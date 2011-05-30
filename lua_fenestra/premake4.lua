
project "lua_fenestra"
language "C++"
files { "code/**.cpp" , "code/**.c" , "code/**.h" , "all.h" }

links { "lua51" }

defines { "LUA_LIB" }

if os.get() == "windows" then
	links { "opengl32" , "glu32" }
else -- nix
	links { "GL" , "GLU" }

	local fp=assert(io.popen("pkg-config --cflags gtkmm-2.4"))
	local s=assert(fp:read("*l"))
	buildoptions { s }
	fp:close()

	local fp=assert(io.popen("pkg-config --libs gtkmm-2.4"))
	local s=assert(fp:read("*l"))
	linkoptions { s }
	fp:close()

end


includedirs { "." }

SET_KIND("lua","fenestra.core","fenestra_core")
SET_TARGET("/fenestra","core")

