#!/bin/bash

sudo apt update

sudo apt install gcc g++ make -y

sudo apt-get install libapr1-dev

sudo apt-get install libssl-dev

sudo apt install zlib1g

sudo apt-get install zlib1g-dev

sudo apt install pkg-config

sudo apt install ninja-build

sudo apt install clang

which python3 &> /dev/null

if [ $? -eq 0 ]; then
    echo "Python3 is already installed. Updating..."
    sudo apt update && sudo apt upgrade python3 -y
else
    echo "Python3 is not installed. Installing..."
    sudo apt update && sudo apt install python3 -y
fi

which cmake &> /dev/null

if [ $? -eq 0 ]; then
    CMAKE_VERSION=$(cmake --version | head -n1 | awk '{print$3}')

    if [["$CMAKE_VERSION" < "3.20.0" ]]; then
        NEED_INSTALL=true
    else
	NEED_INSTALL=false
    fi

else
    NEED_INSTALL=true
fi


if [ "$NEED_INSTALL" = true ]; then

     sudo apt remove cmake -y
     
     cd ~/

     wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz

     tar -zxvf cmake-3.24.2.tar.gz

     cd cmake-3.24.2

     sudo ./bootstrap

     sudo make

     sudo make install

else
    echo "cmake is already installed with version $CMAKE_VERSION or newer."
fi


#Installing llvm


cd ~/

if [ -d "llvm-project" ]; then
    echo "Folder 'llvm-project' exist in the current directory"
    cd llvm-project
else
    git clone https://github.com/llvm/llvm-project.git
    cd llvm-project
fi

if [ -d "build" ]; then
    read -p "Do you want to remove the contents of the 'build' folder (yes/no): " response
    if [ "$response" = "yes" ]; then
        rm -rf build/*
	echo "Contents of the 'build' folder have been removed"
    fi
    cd build
    sudo cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_PARALLEL_LINK_JOBS=1 ../llvm/
    sudo ninja
else
    mkdir build
    cd build
    sudo cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_PARALLEL_LINK_JOBS=1 ../llvm/
    sudo ninja
fi

echo "//============================================="
echo "//Done					     "
echo "//============================================="

python3 --version
cmake --version
llvm-config --version
