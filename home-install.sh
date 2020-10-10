#!/bin/sh
# install niv sources

function install_home(){
	mkdir -p ~/
	git clone git@github.com:ImExtends/sources.git ~/ 
}
