# Make includes: include.mk

This is a collection of `make` includes I've put together.

<!-- toc -->

- [Usage](#usage)
- [Documentation](#documentation)
    * [Markdown](#markdown)
    * [Bastion host](#bastion-host)
    * [Kubernetes](#kubernetes)
        + [EKS](#eks)
        + [Helm](#helm)
    * [Crypt](#crypt)
        + [Ansible Vault](#ansible-vault)
        + [SSH](#ssh)
        + [GPG](#gpg)
- [Licensing](#licensing)

<!-- tocstop -->

## Usage

An example [`Makefile`](Makefile) shows how to include this repository dynamically in your own. Variables are to be overridden outside of `include.mk`; targets can also be overridden _or_ added to (e.g. `encrypt::` will add to the currently defined target).

Of course, you'll need to change the `GITROOT` variable in your `Makefile`s: it'll likely be the same as the example, but without the trailing `../`.

## Documentation

Variables listed should be set in a local `./Makefile`

### Markdown

There's only one target here, `make toc`, which uses [`markdown-toc`](https://github.com/smaslennikov/markdown-toc) to generate tables of contents in a given (`MARKDOWN_FILE` variable) Markdown file.

- does so with proper indentation to support BitBucket,
- inserts the TOC at the comment location: `<!-- toc -->`

### Bastion host

TODO

### Kubernetes

TODO

#### EKS

TODO

#### Helm

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

### Crypt

#### Ansible Vault

TODO

#### SSH

TODO

#### GPG

TODO

## Licensing

 * [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0): [`./LICENSE-APACHE`](LICENSE-APACHE)
 * [MIT License](https://opensource.org/licenses/MIT): [`./LICENSE-MIT`](LICENSE-MIT)

Licensed at your option of either of the above licenses.
