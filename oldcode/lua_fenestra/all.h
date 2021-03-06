/*+-----------------------------------------------------------------------------------------------------------------+*/
//
// (C) Kriss@XIXs.com 2013
//
/*+-----------------------------------------------------------------------------------------------------------------+*/


#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <signal.h>
#include <string.h>



#if defined(_MSC_VER)

#include <crtdbg.h>

#else

#endif


#if !defined(__TIMESTAMP__)
#define __TIMESTAMP__ 0
#endif


#if defined(WIN32)

#include <io.h>
#include <direct.h>

#include <windows.h>
#include <windowsx.h>

#include "../lib_wet/util/win_types.h"

#elif defined(X11)

#include <X11/Xlib.h> 

#include <strings.h>
#include <sys/time.h>

#include "../lib_wet/util/nix_types.h"

#endif

#include "../lib_wet/util/f32_math.h"


#include "code/GLee.h"
#include <GL/gl.h>
#include <GL/glu.h>


#ifdef __cplusplus
extern "C" {
#endif

#include "../lib_lua/src/lua.h"
#include "../lib_lua/src/lauxlib.h"
#include "../lib_lua/src/lualib.h"

//#include "../_src/liblwo/code/lwo2.h"

#ifdef __cplusplus
};
#endif


#include <ft2build.h>
#include FT_FREETYPE_H


//#include "../../drylib/drylib_all.h"


//#include "../wetlib/wetlib_all.h"



// data file header descriptions

#include "../lib_wet/file/file_xox.h"
#include "../lib_wet/file/file_xsx.h"
#include "../lib_wet/file/file_xtx.h"


#include "../lua_grd/code/grd.h"
#include "../lua_grd/code/lua_grd.h"

#include "code/fenestra_data.h"
#include "code/fenestra_ogl.h"
#include "code/fenestra.h"


