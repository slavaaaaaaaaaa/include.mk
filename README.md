# Make includes: include.mk

This is a collection of `make` includes I've put together.

<!-- toc -->

- [Usage](#usage)
- [Licensing](#licensing)

<!-- tocstop -->

## Usage

An example [`Makefile`](Makefile) shows how to include this repository dynamically in your own. Variables are to be overridden outside of `include.mk`; targets can also be overridden _or_ added to (e.g. `encrypt::` will add to the currently defined target).

## Licensing

 * [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0): [`./LICENSE-APACHE`](LICENSE-APACHE)
 * [MIT License](https://opensource.org/licenses/MIT): [`./LICENSE-MIT`](LICENSE-MIT)

Licensed at your option of either of the above licenses.
