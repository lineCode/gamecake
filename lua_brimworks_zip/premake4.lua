
project "lua_brimworks_zip"
language "C"
files { "./**.c" , "./**.h" }

links { "lib_lua" , "lib_zzip" }



includedirs { "." , "../lib_zip/lib" }


KIND{kind="lua",name="brimworks_zip"}

