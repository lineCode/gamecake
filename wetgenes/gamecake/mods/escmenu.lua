-- copy all globals into locals, some locals are prefixed with a G to reduce name clashes
local coroutine,package,string,table,math,io,os,debug,assert,dofile,error,_G,getfenv,getmetatable,ipairs,Gload,loadfile,loadstring,next,pairs,pcall,print,rawequal,rawget,rawset,select,setfenv,setmetatable,tonumber,tostring,type,unpack,_VERSION,xpcall,module,require=coroutine,package,string,table,math,io,os,debug,assert,dofile,error,_G,getfenv,getmetatable,ipairs,load,loadfile,loadstring,next,pairs,pcall,print,rawequal,rawget,rawset,select,setfenv,setmetatable,tonumber,tostring,type,unpack,_VERSION,xpcall,module,require
local gcinfo=gcinfo

local hex=function(str) return tonumber(str,16) end

local pack=require("wetgenes.pack")
local wzips=require("wetgenes.zips")

local wstr=require("wetgenes.string")
local tardis=require("wetgenes.tardis")	-- matrix/vector math


module("wetgenes.gamecake.mods.escmenu")

function bake(state)

	local escmenu={}
	escmenu.name="escmenu" -- by this name shall ye know me
	
	local opts={
		width=480,
		height=480,
	}

	local canvas=state.canvas.child()
	canvas.layout=false

	function escmenu.setup(state)
	
		state.cake.fonts.loads({1}) -- always load builtin font number 1 a basic 8x8 font		
		opts.font=1
		
		if wzips.exists("data/fonts/Vera.ttf") then -- we got us better font to use :)
			state.cake.fonts.loads({"Vera"})
			opts.font="Vera"
		end


		escmenu.show=false

		escmenu.master=state:rebake("wetgenes.gamecake.widgets").setup({})
		
		if wzips.exists("data/wskins/soapbar/button.png") then -- we got us better skin to use :)
			state:rebake("wetgenes.gamecake.widgets.skin").load("soapbar")
		end

		local hooks={}
		function hooks.click(widget)
			local id=widget.id
--	print(widget.id)
			if id=="layout" then
				if state.mods.layout then
					state.mods.layout.cycle_mode()
					escmenu.layout_widget.text="Layout: "..state.mods.layout.mode
				end
			elseif id=="continue" then
			
				escmenu.show=false
				
			elseif id=="restart" then
			
				state.next=state.now
				escmenu.show=false
				
			elseif id=="quit" then
			
				state.next=true
				escmenu.show=false
				
			end
		end
		local top=escmenu.master:add({hx=480,hy=480,mx=1,class="hx",ax=0,ay=0,font=opts.font})
		top:add({sy=1,sx=1})
		
		if state.mods.layout then
		
			escmenu.layout_widget=top:add({text="Layout: "..state.mods.layout.mode,color=0xffcccccc,id="layout",hooks=hooks,text_size=32})
						
		end
		
		top:add({text="Continue",color=0xff44ff44,id="continue",hooks=hooks,text_size=32})
		top:add({text="Restart",color=0xffffff44,id="restart",hooks=hooks,text_size=32})
		top:add({text="Quit",color=0xffff4444,id="quit",hooks=hooks,text_size=32})
		top:add({sy=1,sx=1})
		
		escmenu.master:layout()

	end

	function escmenu.clean(state)
	
	end
	
	

	function escmenu.update(state)
	
		if escmenu.show then

			escmenu.master:update()
		
		end
		
	end
	
	function escmenu.draw(state)
	
		local win=state.win
		local cake=state.cake
		local gl=cake.gl
--		local canvas=state.canvas
		local font=canvas.font

		if escmenu.show then

		canvas.viewport() -- did our window change?
		canvas.project23d(opts.width,opts.height,1/4,opts.height*4)
		canvas.gl_default() -- reset gl state


		gl.MatrixMode(gl.PROJECTION)
		gl.LoadMatrix( canvas.pmtx )

		gl.MatrixMode(gl.MODELVIEW)
		gl.LoadIdentity()
		gl.Translate(-opts.width/2,-opts.height/2,-opts.height*2) -- top left corner is origin
		gl.PushMatrix()

		escmenu.master:draw()
			
		gl.PopMatrix()

		end

		
	end
		
	function escmenu.msg(state,m)
		if escmenu.show then
			if m.xraw and m.yraw then	-- we need to fix raw x,y numbers
				m.x,m.y=canvas.xyscale(m.xraw,m.yraw)	-- local coords, 0,0 is center of screen
				m.x=m.x+(opts.width/2)
				m.y=m.y+(opts.height/2)
			end
			escmenu.master:msg(m)
		end
		if m.class=="key" then
			if m.action==1 and m.keyname=="escape" then
				escmenu.show=not escmenu.show
			end
		end
	end

	return escmenu
end
