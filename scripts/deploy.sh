#!/bin/bash
BOTNAME=rich-uncle-pennybags-bot &&
LOCATION=/opt/$BOTNAME/ &&
echo  -e "\033[33;36m Building release binaries... \033[0m" &&
cargo build --release &&

echo  -e "\033[33;36m Copying binaries to server... \033[0m" &&
ssh jnf rm -rf ~/$BOTNAME/target/release/$BOTNAME &&
scp ./target/release/$BOTNAME jnf:~/$BOTNAME/target/release/$BOTNAME &&

echo  -e "\033[33;36m Copying Coinfile to server... \033[0m" &&
ssh jnf rm -rf ~/$BOTNAME/Coins.toml &&
scp ./Coins.toml jnf:~/$BOTNAME/Coins.toml &&

echo  -e "\033[33;36m Stopping services... \033[0m" &&
ssh jnf service $BOTNAME stop &&

echo  -e "\033[33;36m Copying files to $LOCATION... \033[0m" &&
ssh jnf cp $BOTNAME/target/release/$BOTNAME $LOCATION &&
ssh jnf cp $BOTNAME/Coins.toml $LOCATION &&

echo  -e "\033[33;36m Starting services... \033[0m" &&
ssh jnf service $BOTNAME start &&

echo  -e "\033[33;32m Done deploying! \033[0m";