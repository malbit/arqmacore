# Arqma core repositories

This repository includes code that is oftenly used among Arqma and moneroexamples projects.
It includes:

 - classess for decoding outputs/inputs, payment ids
 - general utility tools (e.g., get default Arqma blockchain path)
 - more to come ...

# C++14

C++14 is required to run this code.


#### Compilation of the arqmacore

```bash

# go to home folder if still in ~/arqma
cd ~

git clone --recurse-submodules  https://github.com/malbit/arqmacore.git

cd arqmacore

mkdir build && cd build

cmake ..

# altearnatively can use cmake -DARQMA_DIR=/path/to/arqma ..
# if Arqma is not in ~/arqma

make

# run tests
make test
```

# Other examples

Other examples can be found on  [github](https://github.com/moneroexamples?tab=repositories).
Please know that some of the examples/repositories are not
finished and may not work as intended.

# How can you help?

Constructive criticism, code and website edits are always good. They can be made through github.
