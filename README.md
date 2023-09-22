1. `chmod +x install_llvm.sh`
2. `./install_llvm.sh`



./install_llvm.sh: line 105: llvm-config: command not found


> :warning: **If your installation was success full but you get the following message `./install_llvm.sh: line 105: llvm-config: command not found
` from the bash script**: Add the bin folder path to your `~/.bashrc` file.
```bash
#For example my bin folder is located
llvm-setup@llvmsetup-virtual-machine:~/llvm-project/build/bin$ pwd
/home/llvm-setup/llvm-project/build/bin

#In my case I added the following at the end of my ~/.bashrc file

export PATH="/home/llvm-setup/llvm-project/build/bin:$PATH"
```
Restart your computer now `llvm-config --version` should work.
