
| Provider | Type | Result |
| --- | --- | --- |
| CircleCI | test | [![CircleCI](https://circleci.com/gh/xriss/gamecake.svg?style=svg)](https://circleci.com/gh/xriss/gamecake) |


Autogenerated code documentation can be found at 
https://xriss.github.io/gamecake/ so go there if that is what you are 
interested in, the rest of this readme concerns the process of building 
gamecake from source.


Be sure to clone this repo with submodules as the engine binaries live 
in a permanently orphaned branch. The following is the optimal way to 
git clone so that the submodule references master rather than 
(slowly) downloading the repo twice.

	git clone https://github.com/xriss/gamecake.git
	cd gamecake
	./git-pull

It is best to always use this script to git pull the latest everything 
so that git is less likely to get its knickers in a twist.

	./git-pull



Releases are compiled inside the vbox_* directories 
(linux32/linux64/osx64/raspi/etc) which contain vagrant or qemu boxes 
setup to build the code in a controlled environment via a ./make 
script. The latest code built this way can be found in the exe branch 
and a zip of them all can be downloaded from 
https://github.com/xriss/gamecake/archive/exe.zip



For a linuxy build, the big required build/lib dependencies are 
premake4, luajit and SDL2. You have two choices either install via a 
package manager, the following script should do that using apt.

	./apt-gets

Or build them and install them from source which the following script 
will try to do.

	build/install


Then you may use these scripts to make and install.

	./make
	sudo ./install

For some more options when building (eg use clang) see the output of

	./make --help


Alternatively any vbox_* directory can build a specific executable. For 
instance vbox_1604_64 can be used to build a 64bit executable inside an 
ubuntu 16.04 vagrant box. See readme files inside these directories for 
more information.


Once built the engine lives in one single fat binary that includes many 
lua libraries. For convenience gamecake is a command line compatible 
replacement for lua. The only diference is we have C libraries and Lua 
libraries from this repository embedded and ready to be required by 
your lua code.


We are also setup to auto build snaps via 
https://code.launchpad.net/~xriss/+snap/gamecake the following should 
get you a snap install of gamecake.

	sudo snap install gamecake
	sudo snap connect gamecake:joystick


Gamecake is now slowly becoming fully available as a luarock, all our 
custom libraries can be installed at once with.

	sudo luarocks install gamecake
	
This is still under development but is already the replacement for the 
older webserver pagecake builds. I now use a generic openresty combined 
with a luarocks gamecake install.

This is a bit of a hassle to setup, as all server things are, but 
basically it means install openresty and then do something like 
https://openresty.org/en/using-luarocks.html to install luarocks that 
openresty can see and then use that luarocks to install gamecake which 
will get us all the gamecake libs inside an nginx lua environment.

