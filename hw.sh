#!/bin/bash

kernel_release=$(uname -r)

echo "Current kernel version =" $kernel_release "\n"

gcc_str=$(gcc --version | grep gcc)

if [ $? -eq 127 ]
then 
    printf "GCC not found!"
else 
    echo "GCC version is -" $gcc_str "\n"
fi

# Midnight Commander
while true; do
    read -p "Install Midnight Commander? [Y/N] " yn
    case $yn in
        [Yy]* ) apt-get install mc; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n"

# GIT
while true; do
    read -p "Install GIT? [Y/N] " yn
    case $yn in
        [Yy]* ) apt-get install git; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n"

# Conky
while true; do
    read -p "Install Conky system monitor? [Y/N] " yn
    case $yn in
        [Yy]* ) apt-get install conky; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n"

# g++
while true; do
    read -p "Install latest g++ compiler? [Y/N] " yn
    case $yn in
        [Yy]* ) apt-get install g++; break;; 
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n"

# clang
while true; do
    read -p "Install latest clang compiler? [Y/N] " yn
    case $yn in
        [Yy]* ) apt-get install clang; break;; 
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "\n"

# xed
while true; do
    read -p "Install xed text editor? It cause add new repo - ppa:embrosyn/xapps. [Y/N] " yn
    case $yn in
        [Yy]* ) add-apt-repository ppa:embrosyn/xapps; 
                apt-get install xed; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Ещё один способ запроса ДА\НЕТ

# read -p "Are you sure? " -n 1 -r
# echo    # (optional) move to a new line
# if [[ ! $REPLY =~ ^[Yy]$ ]]
# then
    # exit 1
# fi
