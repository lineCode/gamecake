echo "linking .lua fles from the main lua dir so we dont accidently edit multiple copies"

#you will need to delete the local copies first...
#rm code/speak.lua

ln ../../bin/lua/wetgenes/speak.lua code
