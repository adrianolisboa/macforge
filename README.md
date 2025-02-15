## Zsh and OSX configurations

### Load configurations

To use add to your __.zshrc__:

```
LOAD_ROOT=/osx-setup
. ${LOAD_ROOT}/load
```

Than `load` takes care of loading all functions, aliases and etc. Every directory defined in  `load` will be sourced recursively.

## OSX Setup

Then just run `./setup.sh`
