# CommandBox Task Local Model Resolver

A simple module that allows Task Runners to inject CFCs from the shell's working dir.  This module listens to the `beforeInstanceAutowire` interception point in WireBox and looks for any propery injections whose DSL matches the name of a CFC in the shell's working directory.  This allows a Task Runner to inject a CFC in the working directory without creating a mapping for it.

```
install commandbox-task-local-model-resolver
```
