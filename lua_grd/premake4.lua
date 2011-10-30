
--include("zlib")
include("libpng")
--include("libjpeg")


project "lua_grd"
language "C++"
files { "code/**.cpp" , "code/**.c" , "code/**.h" , "all.h" }

links { "lua51" , "lua_grd_libpng" , "lib_z" }

if os.get() == "windows" then

else -- nix

end


includedirs { "." , "../lib_z" }


SET_KIND("lua","grd","grd")
SET_TARGET("","grd")

