# Make includes: include.mk

This is a collection of `make` includes I've put together.

<!-- toc -->

- [Usage](#usage)
- [Documentation](#documentation)
    * [Markdown](#markdown)
    * [Bastion host](#bastion-host)
    * [Terraform](#terraform)
        + [GCP](#gcp)
    * [Kubernetes](#kubernetes)
        + [EKS](#eks)
        + [Helm](#helm)
    * [Crypto Includes](#crypto-includes)
        + [Ansible Vault](#ansible-vault)
        + [SSH](#ssh)
        + [GnuPG](#gnupg)
- [Licensing](#licensing)

<!-- tocstop -->

## Usage

Add the following to your Makefile:

```
GITROOT=$(shell git rev-parse --show-toplevel)/
include $(shell test -d $(GITROOT)/include.mk/ || (git clone git@github.com:slavaaaaaaaaaa/include.mk.git) && echo $(GITROOT))/include.mk/*.mk
```

Feel free to either remove `.git` directory in the acquired `include.mk` or add it as a submodule and follow along for additions and fixes.

## Documentation

Variables listed should be set in a local `./Makefile`

### [Markdown](01-markdown.mk)

There's only one target here, `make toc`, which uses [`markdown-toc`](https://github.com/slavaaaaaaaaaa/markdown-toc) to generate tables of contents in a given (`TOC_TARGET` variable) Markdown file.

- does so with proper indentation to support BitBucket,
- inserts the TOC at the comment location (`!-- toc --`, surrounded by `<>`. Can't paste it here or there are two places to place a toc!)

### [Bastion host](20-bastion.mk)

An opinionated target to SSH into an immutable bastion host: `make bastion` will

1. Call [`make decrypt`](#gnupg) if the private SSH key (`BASTION_SSH_KEY_FILE` variable) is not already decrypted,
2. `ssh` into `$BASTION_HOST` with `$BASTION_USERNAME` and `$BASTION_EXTRA_ARGS` while **ignoring host keys**

### [Terraform](30-terraform.mk)

Has a single target: `make output` calls `terraform output`. This is useful to work around [this bug](https://github.com/hashicorp/terraform/issues/20097).

#### [GCP](31-gcp.mk)

Has a single target: `make gproject` simply checks whether `GOOGLE_PROJECT` variable is set. This target is largely used as a dependency of others that require this variable.

### [Kubernetes](40-kubernetes.mk)

Has a single target: `make apply-k8s` will `kubectl apply -f ...` all `*.yaml` files in the directory. **It ignores** `*.yml` and doesn't simply apply `./`: it was a workaround for some subpar procedures at the time.

#### [EKS](41-eks.mk)

These are targets to facilitate some EKS operations:

|Command|Required Variables|End User target?|Purpose|
|-|-|-|-|
|`make dashboard`|none|Yes|Opens the proxied dashboard URL in your browser. Calls `make token`|
|`make token`|none|No|Spits out the token to be used to authenticate against the dashboard|
|`make kubeconfig`|`TERRAFORM_DIR`|Yes|Backs up your current `kubeconfig`, merges it with that generated by `make kubeconfig-eks`|
|`make kubeconfig-eks`|none|No|Simply spits out the generated EKS kubeconfig with `terraform output` in `TERRAFORM_DIR`|

The following variables are used here:

|Variable name|Default|Description|
|-|-|-|
|`TERRAFORM_DIR`|none|Relative path of your EKS terraform directory|

#### [Helm](42-helm.mk)

`make` targets are present to facilitate `helm` operations:

|Command|Required Variables|End User target?|Purpose|
|-|-|-|-|
|`make helm-install`|`RELEASE_NAME`, `VALUES_FILE`|Yes|Installs the specified release|
|`make helm-upgrade`|`RELEASE_NAME`, `VALUES_FILE`|Yes|Upgrades an existing release|
|`make helm-delete`|`RELEASE_NAME`|Yes|Deletes an existing release|
|`make helm-status`|`RELEASE_NAME`|Yes|Displays status of an existing release|

The following variables are used here:

|Variable name|Default|Description|
|-|-|-|
|`RELEASE_NAME`|none|Name of the release|
|`VALUES_FILE`|none|Which YAML of values to use|

### Crypto Includes

#### [Ansible Vault](91-ansible-vault.mk)

Facilitates Ansible Vault operations, takes care of the passphrase management.

|Command|Required Variables|End User target?|Purpose|
|-|-|-|-|
|`make vault_encrypt`|`VAULT_VARS_FILE`, `VAULT_PASSWORD_FILE`|Yes|Encrypts `VAULT_VARS_FILE` with passphrase in the file `VAULT_PASSWORD_FILE` (which should be encrypted with the [GnuPG](#gnupg) targets)|
|`make vault_decrypt`|`VAULT_VARS_FILE`, `VAULT_PASSWORD_FILE`|Yes|Decrypts as above|

**Each of the above operations cleans up after itself:** after `make vault_encrypt` you'll only have the encrypted file (`${VAULT_VARS_FILE}.enc`), whereas after a `make vault_decrypted` - only the plaintext version. This is to ensure that changes are committed properly.

The following variables are used here:

|Variable name|Default|Description|
|-|-|-|
|`VAULT_VARS_FILE`|`inventory/group_vars/all`|The file you want encrypted|
|`VAULT_PASSWORD_FILE`|`secret/vault_password`|The file containing the vault password|

**Ideally**, you'd set `ENCRYPTABLE=$(VAULT_PASSWORD_FILE)` in your local makefile and keep it encrypted with the [GnuPG](#gnupg) targets.

#### [SSH](92-ssh.mk)

Just one target in this include: `make generate-ssh-key` will generate an RSA SSH key using `SSH_KEY_FILE` and `SSH_KEY_COMMENT` variables.

**Ideally**, you'd set `ENCRYPTABLE=$(SSH_KEY_FILE)` in your local makefile and keep it encrypted with the [GnuPG](#gnupg) targets.

#### [GnuPG](93-gpg.mk)

Wraps GnuPG operations, allows for safely storing secrets in `git`.

|Command|Required Variables|End User target?|Purpose|
|-|-|-|-|
|`make generate-secret`|`CRYPTO_CHARS`, `CRYPTO_LENGTH`|Yes|Generates a secret using allowed `CRYPTO_CHARS` of length `CRYPTO_LENGTH`|
|`make generate-service-gpg-key`|`GPG_KEY_FILE`, `GPG_KEY_UID`|Yes|Generates a service GPG key (can be used for CI systems) with description of `GPG_KEY_UID` and exports to `GPG_KEY_FILE`|
|`make encrypt`|`ENCRYPTABLE`, `RECIPIENTS`|Yes|Iterates over list of files `ENCRYPTABLE`, encrypting all of them to public keys of `RECIPIENTS`|
|`make decrypt`|`ENCRYPTABLE`|Yes|Iterates over list of files `ENCRYPTABLE`, decrypting all of them|
|`make reencrypt`|None|Yes|Find all files `*.asc` (all encrypted files in the directory), encrypt them anew. Useful for key leaks|
|`make encryptable`|None|No|Checks that `ENCRYPTABLE` variable is set|

The following variables are used here:

|Variable name|Default|Description|
|-|-|-|
|`CRYPTO_CHARS`|`A-Za-z0-9-_`|A list of allowed characters to be used in `make generate-secret`|
|`CRYPTO_LENGTH`|`32`|Length of secret generated with `make generate-secret`|
|`GPG_KEY_FILE`|`secret/gpg_key`|Where to export your generated gpg key (`make generate-service-gpg-key`)|
|`GPG_KEY_UID`|none|Description of generated gpg key in `make generate-service-gpg-key`|
|`ENCRYPTABLE`|none|List of files (space separated) to be targeted with GPG make targets|
|`RECIPIENTS`|none|List of emails/UIDs of public keys to encrypt secrets to|

## Licensing

 * [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0): [`./LICENSE-APACHE`](LICENSE-APACHE)
 * [MIT License](https://opensource.org/licenses/MIT): [`./LICENSE-MIT`](LICENSE-MIT)

Licensed at your option of either of the above licenses.
