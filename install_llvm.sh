#!/bin/bash

sudo apt update

sudo apt install gcc g++ make -y

sudo apt-get install libapr1-dev

sudo apt-get install libssl-dev

sudo apt install zlib1g

sudo apt-get install zlib1g-dev

sudo apt install pkg-config

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
     
     wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz

     tar -zxvf cmake-3.24.2.tar.gz

     cd cmake-3.24.2

     sudo ./bootstrap

     sudo make

     sudo make install

else
    echo "cmake is already installed with version $CMAKE_VERSION or newer."
fi




echo "//============================================="
echo "//Done					     "
echo "//============================================="

python3 --version
cmake --version
