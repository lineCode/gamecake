
project "lua_speak"
language "C++"
files { "code/**.c" , "code/**.h" , "all.h" }

links { "lib_lua" }


files { "flite/include/**.c" , "flite/include/**.h" }
files { "flite/src/**.c" , "flite/src/**.h" }
files { "flite/voices/cmulex/**.c" , "flite/voices/cmulex/**.h" }
files { "flite/voices/usenglish/**.c" , "flite/voices/usenglish/**.h" }

-- choose the voices that are baked in
files { "flite/voices/cmu_us_slt/**.c" , "flite/voices/cmu_us_slt/**.h" }
--files { "flite/voices/cmu_us_kal/**.c" , "flite/voices/cmu_us_kal/**.h" }

-- do not bake the large chunk of voice data into the exe, load it later
excludes { "flite/voices/cmu_us_slt/cmu_us_slt_cg_single_params.c" }

includedirs { "." , "flite/include" , "flite/voices/usenglish" , "flite/voices/cmulex" }


KIND{lua="wetgenes.speak.core"}

