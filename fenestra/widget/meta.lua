


local math=math
local table=table

local ipairs=ipairs
local setmetatable=setmetatable
local type=type

local function print(...) _G.print(...) end



module("fenestra.widget.meta")

--
-- add meta functions
--
function setup(def)

	local master=def.master
	local meta=def.meta
	local win=def.win

	function meta.call_hook(widget,hook)
		if widget.hooks and widget.hooks[hook] then widget.hooks[hook](widget) end
	end

--
-- add a new widget as a child to this one
--
	function meta.add(parent,def)
		
		local widget={}
		setmetatable(widget,meta)
		table.insert(parent,widget)
		widget.parent=parent
		widget:setup(def)
		widget.meta=meta
		
		return widget
	end
	
--
-- initial setup
--def
	function meta.setup(widget,def)
	
		widget.state="none"
	
		widget.class=def.class
		widget.highlight=def.highlight
		
		widget.id=def.id
		widget.user=def.user
		widget.hooks=def.hooks
		
		widget.fx=def.fx		-- optional local size
		widget.fy=def.fy
		widget.ax=def.ax or 0	-- local position
		widget.ay=def.ay or 0
		
		widget.sx=def.sx or 1 -- size for layout
		widget.sy=def.sy or 1
		
		widget.mx=def.mx or 0 -- max size for layout
		widget.my=def.my or 0
		
		widget.hx=def.hx or 0 -- absolute pixel size (may be generated)
		widget.hy=def.hy or 0
		
		widget.px=def.px or 0 -- pixel position (may be generated)
		widget.py=def.py or 0
		widget.pa=0
		
		widget.color=def.color
		widget.text_color=def.text_color or master.text_color or 0xffffffff
		widget.text_size=def.text_size or master.text_size or 16
		
		widget.text=def.text
		
		if widget.color or widget.text then widget.solid=true end
		widget.solid=widget.solid or def.solid
		
		return widget
	end
--
-- and final cleanup
--
	function meta.clean(widget)
		return widget
	end
--
-- live adjustment
--
	function meta.get(widget,val,...)
	
		if val=="slide" then
		
			local x=(widget.px-widget.parent.px) / (widget.parent.hx-widget.hx)
			local y=(widget.py-widget.parent.py) / (widget.parent.hy-widget.hy)
			
			return x,y
		end
		
	end
	
	function meta.set(widget,val,...)
	local t={...}
	
		if val=="slide" then
			for i,v in ipairs(widget) do
			
				if type(t[1])=="table" then
					v.ax=t[1][1] or v.ax
					v.ay=t[1][2] or v.ay
				else
					v.ax=t[1] or v.ax
					v.ay=t[2] or v.ay
				end
				
				v.px=widget.px+(widget.hx-v.hx)*v.ax -- local position relative to parents size
				v.py=widget.py-(widget.hy-v.hy)*v.ay
				
			end
		end
	end
	
--
-- initial layout of widgets, to put them into reasonable positions
--
	function meta.layout(widget)
--print(widget.class)
		if widget.class=="hx" then
			meta.layout_hx(widget)
		elseif widget.class=="slide" or widget.class=="pad" then
			meta.layout_padding(widget)
		elseif widget.class=="master" or widget.class=="abs" then
			meta.layout_absolute(widget)
		else
			meta.layout_relative(widget)
		end
	end
	
	function meta.layout_none(widget)
		for i,v in ipairs(widget) do
			v:layout()
		end
	end
	
	function meta.layout_padding(widget)
		for i,v in ipairs(widget) do
		
			if v.fx then v.hx=widget.hx*v.fx end -- generate size as a fraction of parent
			if v.fy then v.hy=widget.hy*v.fy end
			
			v.px=widget.px+(widget.hx-v.hx)*v.ax -- local position relative to parents size
			v.py=widget.py-(widget.hy-v.hy)*v.ay
			
		end
		for i,v in ipairs(widget) do
			v:layout()
		end
	end
	
	function meta.layout_absolute(widget)
		for i,v in ipairs(widget) do
		
			if v.fx then v.hx=widget.hx*v.fx end -- generate size as a fraction of parent
			if v.fy then v.hy=widget.hy*v.fy end
			
			v.px=widget.px+v.ax -- local absolute position
			v.py=widget.py-v.ay
			
		end
		for i,v in ipairs(widget) do
			v:layout()
		end
	end
	
	function meta.layout_relative(widget)
		for i,v in ipairs(widget) do
		
			if v.fx then v.hx=widget.hx*v.fx end -- generate size as a fraction of parent
			if v.fy then v.hy=widget.hy*v.fy end
			
			v.px=widget.px+(widget.hx)*v.ax -- local position relative to parents size
			v.py=widget.py-(widget.hy)*v.ay
			
		end
		for i,v in ipairs(widget) do
			v:layout()
		end
	end
	
	function meta.layout_hx(widget)
		local sx,sy=0,0
		local my=0
		local line=1
		
		function endoflines()
			local y=0
			for i,v in ipairs(widget) do
				v.hy=v.sy*widget.hy/sy
				v.py=widget.py-y
				if v.endofline then y=y+v.hy end
--print(v.px..","..v.py.." - "..v.hx..","..v.hy)
			end
		end
		
		function endofline(i)
			local x=0
			for i=line,i do -- final line layout
				local v=widget[i]
				v.sy=my
				v.hx=v.sx*widget.hx/sx
				v.px=widget.px+x
				x=x+v.hx
			end
			widget[i].endofline=true
			sx=0
			sy=sy+my
			my=0
			line=i+1
		end
		
		if #widget>0 then
			for i,v in ipairs(widget) do
			
				v.endofline=false
				if sx+v.sx>widget.mx then
					if sx==0 then
						if v.sy>my then my=v.sy end
						sx=sx+v.sx				
						endofline(i)
					else
						endofline(i-1)
						if v.sy>my then my=v.sy end
						sx=sx+v.sx				
					end
				else
					if v.sy>my then my=v.sy end
					sx=sx+v.sx				
				end
			end

			endofline(#widget)
			endoflines()
		end
		
		for i,v in ipairs(widget) do
			v:layout()
		end
	end
	
--
-- initial layout of widgets, to put them into reasonable positions
--
	function meta.mouse(widget,act,x,y,key)
	
--print(x..","..y.." : "..widget.px..","..widget.py)

		if widget.solid and x>=widget.px and x<widget.px+widget.hx and y<=widget.py and y>widget.py-widget.hy then
		
			if act=="down" then
-- only set if null or our parent...
				if not master.active or master.active==widget.parent then
					master.active=widget
					master.active_x=x-widget.px
					master.active_y=y-widget.py
				end
			end
			if act=="up" then
				if master.active and master.active==widget then -- widget clicked
					widget:call_hook("click")
				end
			end

			if not master.active or master.active==widget then -- over widget
				master.over=widget
			end
		else
		
			if master.over==widget then master.over=nil end
		end
	
		for i,v in ipairs(widget) do
			v:mouse(act,x,y,key)
		end
	end
	
--
-- update this widget and its sub widgets
--
	function meta.update(widget)
	
		for i,v in ipairs(widget) do

			v:update()
		end
	end

--
-- remove all children of this widget
--
	function meta.remove_all(widget)
	
		local len=#widget
		for i=1,len do
			widget[i]=nil
		end
	end

end
