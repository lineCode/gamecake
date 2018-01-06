
local bitdown=require("wetgenes.gamecake.fun.bitdown")

--module
local M={ modname=(...) } ; package.loaded[M.modname]=M

-----------------------------------------------------------------------------
--[[#lua.wetgenes.gamecake.fun.yarn.pages

	pages = require("wetgenes.gamecake.fun.yarn.pages").create(items)

This module contains only one function which can be used to create an 
pages instance and the rest of this documentation concerns the return 
from this create function, not the module itself.


]]
-----------------------------------------------------------------------------
M.create=function(items,level)

	local pages={} -- a place to store all pages
	
	pages.metatable={} -- unique meta table everytime we create
	pages.metatable.__index=pages.metatable -- metatable is full of functions
	setmetatable(pages.metatable,items.metatable) -- inherit

	pages.level=level

	pages.page_xh=32 -- size of each page in cells
	pages.page_yh=32

	pages.page_cx=0x8000*pages.page_xh -- centre page location in cells
	pages.page_cy=0x8000*pages.page_yh
	
	pages.default_name="page_zero" -- use this name if pages.names[index] is empty
	
	pages.names={} -- index to names, the world map

	pages.map={} -- index to created pages
	
	pages.index_to_xy=function(index)
		return index%0x10000 , math.floor(index/0x10000)
	end
	
	pages.index_from_xy=function(x,y)
		return y*0x10000 + x
	end
	
	pages.get=function(index)
		return pages.map[index]
	end
	
	pages.set=function(page)
		pages[ page.index ]=page
		return page
	end

	pages.manifest=function(index)
	
		local page=pages.get(index)

		if not page then -- create
		
			page=pages.create(index, pages.names[index] or pages.default_name )
			
		end

		return page
	end

	pages.create=function(index,name)

		local page=items.create()
		setmetatable(page,pages.metatable)
		page.class="page"

		pages.map[index]=page
		
		page.index=index
		page.name=name
		
		page.px , page.py = pages.index_to_xy(index)

		page.cx=page.px*pages.page_xh
		page.cy=page.py*pages.page_yh
		
		page.cells={}
		
		local p=items.prefabs.get(name)
		if p and p.legend and p.map then
			local tiles=bitdown.pix_tiles(p.map,p.legend)
			for y=0,#tiles do local vx=tiles[y]
				for x=0,#vx do local v=vx[x]
					local cell=items.level.cells.create()
					page.cells[1 + x + y*pages.page_xh ]=cell
					cell.cx=page.cx+v.x
					cell.cy=page.cy+v.y
					cell.page=page
					for ii,iv in ipairs( v.items or {v.item} ) do
						items.create( items.prefabs.get(iv) ):insert(cell)
					end
				end
			end
		end
		
		return page
	end
	
	pages.metatable.get_cell=function(page,cx,cy)
		return page.cells[ 1 + cx + cy*pages.page_xh ]
	end

	pages.get_cell=function(cx,cy)
		local index=pages.index_from_xy(math.floor(cx/pages.page_xh),math.floor(cy/pages.page_yh))
		local page=pages.manifest(index)
		return page:get_cell( cx%pages.page_xh , cy%pages.page_yh )
	end

	return pages

end
