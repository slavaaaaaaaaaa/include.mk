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

An example [`Makefile`](Makefile) shows how to include this repository dynamically in your own. Variables are to be overridden outside of `include.mk`; targets can also be overridden _or_ added to (e.g. `encrypt::` will add to the currently defined target).

Of course, you'll need to change the `GITROOT` variable in your `Makefile`s: it'll likely be the same as the example, but without the trailing `../`.

## Documentation

Variables listed should be set in a local `./Makefile`

### [Markdown](01-markdown.mk)

There's only one target here, `make toc`, which uses [`markdown-toc`](https://github.com/smaslennikov/markdown-toc) to generate tables of contents in a given (`MARKDOWN_FILE` variable) Markdown file.

- does so with proper indentation to support BitBucket,
- inserts the TOC at the comment location (`!-- toc --`, surrounded by `<>`. Can't paste it here or there are two places to place a toc!)

### [Bastion host](20-bastion.mk)

An opinionated target to SSH into an immutable bastion host: `make bastion` will

1. Call [`make decrypt`](#gnupg) if the private SSH key (`BASTION_SSH_KEY_FILE` variable) is not already decrypted,
2. `ssh` into `$BASTION_HOST` with `$BASTION_USERNAME` and `$BASTION_EXTRA_ARGS` while **ignoring host keys**

### [Terraform](30-terraform.mk)

TODO

#### [GCP](31-gcp.mk)

TODO

### [Kubernetes](40-kubernetes.mk)

TODO

#### [EKS](41-eks.mk)

TODO

#### [Helm](42-helm.mk)

`make` targets are present to facilitate `helm` operations:

|Command|Required Variables|Purpose|
|-|-|-|
|`make install`|`RELEASE_NAME`, `VALUES_FILE`|Installs the specified release|
|`make upgrade`|`RELEASE_NAME`, `VALUES_FILE`|Upgrades an existing release|
|`make delete`|`RELEASE_NAME`|Deletes an existing release|
|`make status`|`RELEASE_NAME`|Displays status of an existing release|

The following variables are used here:

`RELEASE_NAME`: name of the release
`VALUES_FILE`: which YAML of values to use

### Crypto Includes

#### [Ansible Vault](91-ansible-vault.mk)

TODO

#### [SSH](92-ssh.mk)

TODO

#### [GnuPG](93-gpg.mk)

TODO

## Licensing

 * [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0): [`./LICENSE-APACHE`](LICENSE-APACHE)
 * [MIT License](https://opensource.org/licenses/MIT): [`./LICENSE-MIT`](LICENSE-MIT)

Licensed at your option of either of the above licenses.
