-- copy all globals into locals, some locals are prefixed with a G to reduce name clashes
local coroutine,package,string,table,math,io,os,debug,assert,dofile,error,_G,getfenv,getmetatable,ipairs,Gload,loadfile,loadstring,next,pairs,pcall,print,rawequal,rawget,rawset,select,setfenv,setmetatable,tonumber,tostring,type,unpack,_VERSION,xpcall,module,require=coroutine,package,string,table,math,io,os,debug,assert,dofile,error,_G,getfenv,getmetatable,ipairs,load,loadfile,loadstring,next,pairs,pcall,print,rawequal,rawget,rawset,select,setfenv,setmetatable,tonumber,tostring,type,unpack,_VERSION,xpcall,module,require


local function print(...) _G.print(...) end

local wstr=require("wetgenes.string")
local wwin=require("wetgenes.win")
local pack=require("wetgenes.pack")

local snames=require("wetgenes.gamecake.spew.names")

--module
local M={ modname=(...) } ; package.loaded[M.modname]=M


M.bake=function(oven,gui)

	gui=gui or {} 
	gui.modname=M.modname

	gui.strings={} -- put user type strings here

	gui.clicks={} -- put onclick function in here
	gui.pages={} -- put functions to fill in pages in here

	local cake=oven.cake
	local sounds=cake.sounds
	local canvas=cake.canvas
	local layout=cake.layouts.create{}
	local flat=canvas.flat
	
	local gl=oven.gl

	local wetiso=oven.rebake("wetgenes.gamecake.spew.geom_wetiso")
	local geom=oven.rebake("wetgenes.gamecake.spew.geom")

--	function gui.returnpage()
--		gui.active=false -- stop displaying our stuff
--	end
	function gui.mpage(pname) --request that we go to this page please?
		gui.active=false -- stop displaying our stuff
		if gui.page_hook then
			gui.page_hook(pname)
		end
	end

	function gui.setup(parent)
		if parent then
			gui.parent=parent
			gui.master=parent.master
		end
		wetiso.setup()
		gui.time=0

	end
	
	local wdata=oven.rebake("wetgenes.gamecake.widgets.data")
	local mkeys=oven.rebake("wetgenes.gamecake.mods.keys")
	local sprofiles=oven.rebake("wetgenes.gamecake.spew.profiles")
	local sscores=oven.rebake("wetgenes.gamecake.spew.scores")

	local ssettings=oven.rebake("wetgenes.gamecake.spew.settings")
	


--	local bpages=oven.rebake("bulb.pages")
	
	gui.ids={}
	gui.data={}
	function gui.initdata() -- call this later

		gui.offset=1
		
		gui.data.mode=1
--		gui.data.score=0
		gui.data.name=wdata.new_data({class="string",hooks=gui.hooks})
		gui.data.vol_music=wdata.new_data({id="vol_music",class="number",hooks=gui.hooks,num=ssettings.get("vol_music")*11,min=0,max=11,step=1})
		gui.data.vol_sfx=wdata.new_data({id="vol_sfx",class="number",hooks=gui.hooks,num=ssettings.get("vol_sfx")*11,min=0,max=11,step=1})

	end
	
	function gui.set_all_values()
		local ids=gui.master.ids
		local d=gui.data
--		if ids.menu_gamemode then ids.menu_gamemode.text=d.modes[d.mode].title end
	end
	
	
local beep_play=function() end
	
	
	function gui.hooks(act,widget)

		if gui.beep_hook then
			beep_play=gui.beep_hook.play
		else
			beep_play=function() end
		end

		local d=gui.data
		local id=widget and widget.id

		if act=="value" then
			if     id=="vol_music" then
				ssettings.set("vol_music",widget.num/11)
			elseif id=="vol_sfx" then
				ssettings.set("vol_sfx",widget.num/11)
			end
		end
		

		if act=="click" then
		
print("click",id)

			if gui.clicks[id] then
				return gui.clicks[id](act,widget)
			end


			if id=="profiles_select" then
			
				beep_play("button")
			
				sprofiles.select(widget.user)
				gui.page("profile")
				
			elseif id=="profile_name_clear" then

				beep_play("button")

				gui.data.name:value( "" )
				
			elseif id=="profile_name_rand" then

				beep_play("button")

				gui.data.name:value( snames.random() )

			elseif id=="profile_name_edit" then
			
				beep_play("button")

				gui.page("profile_name_edit")
				
			elseif id=="profile_name_set" then
			
				beep_play("button")

				sprofiles.set("name",gui.data.name:value())
				gui.page("profile")

			elseif id=="profile_return" then
			
				beep_play("button")

				gui.mpage("menu")
				
			elseif id=="profile_goto" then

				beep_play("button")

				gui.page(widget.user)
			
			elseif id=="profile_cancel" then
			
				beep_play("button")

					if widget.user then
						gui.page(widget.user)
					else
						gui.mpage("menu")	
					end

			elseif id=="score_list" then

				beep_play("button")

--				gui.offset=1
				gui.page("score_list")

			elseif id=="score_brag" then

				beep_play("button")

				local score=sscores.up[1].score
				if wwin.hardcore.send_intent then -- we have a way to brag
					if gui.strings.brag then
						wwin.hardcore.send_intent(wstr.replace(
							gui.strings.brag,
							{
								score=wstr.str_insert_number_commas(score)
							}))
					end
				end
				gui.mpage("menu") -- callback to return to original menu			
			end
		end
	
	end

	
	function gui.add_part(top,name)
--[[
		if name=="profile_bar" then
			local bback
			if gui.page_name=="profile" then bback="profiles" end
			top:add({sx=110,sy=40,color=0xffcccccc,text="OK",id="profile_ok",hooks=gui.hooks,user=bback})
			top:add({sx=100,sy=40})
			top:add({sx=110,sy=40,color=0xffcccccc,text="Cancel",id="profile_cancel",hooks=gui.hooks,user=bback})
		end
]]
	end


	function gui.pages.profiles(master)

		local top=master:add({hx=320,hy=480,class="fill",font="Vera",text_size=24})

		top:add({hx=320,hy=110,text="Choose profile.",text_color=0xffffffff})

		for i,v in sprofiles.ipairs() do
			top:add({hx=320,hy=20})
			top:add({hx=20,hy=50})
			top:add({hx=280,hy=50,color=0xffcccccc,text=v.name,id="profiles_select",hooks=gui.hooks,user=i})
			top:add({hx=20,hy=50})
		end
		top:add({hx=320,hy=20})

		master.go_back_id="profiles_select"
		master.go_forward_id="profiles_select"
		
	end
		
	function gui.pages.profile(master)
		local top=master:add({hx=320,hy=480,class="fill",font="Vera",text_size=24})
		
		gui.data.name:value( sprofiles.get("name") )

		top:add({hx=320,hy=20})
		top:add({hx=320,hy=40,text_color=0xffffffff,text="My name is"})
		top:add({hx=320,hy=20})

		top:add({hx=20,hy=40})
		top:add({hx=280,hy=40,color=0xffcccccc,text=gui.data.name:value(),id="profile_name_edit",hooks=gui.hooks})
		top:add({hx=20,hy=40})

		top:add({hx=200,hy=40})
		top:add({hx=100,hy=40,color=0xffcccccc,text="Edit",id="profile_name_edit",hooks=gui.hooks})
		top:add({hx=20,hy=40})

		top:add({hx=320,hy=40*7})

		top:add({hx=110,hy=40,color=0xffcccccc,text="OK",id="profile_return",hooks=gui.hooks})
		top:add({hx=100,hy=40})
		top:add({hx=110,hy=40,color=0xffcccccc,text="Cancel",id="profile_goto",hooks=gui.hooks,user="profiles"})

		master.go_back_id="profile_return"
		master.go_forward_id="profile_return"

	end

	function gui.pages.profile_name_edit(master)
		local top=master:add({hx=320,hy=480,class="fill",font="Vera",text_size=24})
		
		gui.data.name:value( sprofiles.get("name") )

		top:add({hx=320,hy=80,text_color=0xffffffff,text="Type your name"})

		top:add({hx=20,hy=40})
		top:add({hx=280,hy=40,color=0xffcccccc,data=gui.data.name,id="profile_name",hooks=gui.hooks,class="textedit"})
		top:add({hx=20,hy=40})

		top:add({hx=20,hy=40})
		top:add({hx=120,hy=40,color=0xffcccccc,text="Clear",id="profile_name_clear",hooks=gui.hooks})
		top:add({hx=40,hy=40})
		top:add({hx=120,hy=40,color=0xffcccccc,text="Random",id="profile_name_rand",hooks=gui.hooks})
		top:add({hx=20,hy=40})
		
		top:add({hx=320,hy=40})
		top:add({hx=320,hy=40})

		top:add({hx=110,hy=40,color=0xffcccccc,text="OK",id="profile_name_set",hooks=gui.hooks})
		top:add({hx=100,hy=40})
		top:add({hx=110,hy=40,color=0xffcccccc,text="Cancel",id="profile_goto",hooks=gui.hooks,user="profile"})

		top:add({hx=320,hy=40})

		local m=top:add({hx=320,hy=160})		
		mkeys.setup_keyboard_widgets(m)
		
		master.go_back_id="profile_name_set"
		master.go_forward_id="profile_name_set"

	end

	function gui.pages.score(master)

		local score=sscores.up[1].score
		local best=sscores.list({})[1]			best=(best and best.score) or 0
		local mine=sscores.get_best_score({})	mine=(mine and mine.score) or 0
		if best<score then best=score end
		if mine<score then mine=score end

		local best_pct=0
		local mine_pct=0
		if best<1 then best_pct=0 else best_pct=math.floor(100*score/best) end
		if mine<1 then mine_pct=0 else mine_pct=math.floor(100*score/mine) end


		gui.clicks.score_back=function()
			beep_play("button")
			gui.mpage("menu") -- callback to return to original menu			
		end
		


		local top=master:add({hx=320,hy=480,class="fill",font="Vera",text_size=24})
		top:add({hx=320,hy=40})

		top:add({hx=320,hy=80,text_color=0xffffffff,text="You scored "..wstr.str_append_english_number_postfix(gui.offset).."!"})
		
		top:add({hx=20,hy=40})
		top:add({hx=280,hy=40,color=0xffcccccc,text=wstr.str_insert_number_commas(score)})
		top:add({hx=20,hy=40})
		
		top:add({hx=320,hy=40})

		top:add({hx=20,hy=40})
		if oven.opts.smell=="gamestick" then -- hide brag button
			top:add({hx=130,hy=40})
		else
			top:add({hx=130,hy=40,color=0xffcccccc,text="Brag",id="score_brag",hooks=gui.hooks})
		end
		top:add({hx=20,hy=40})
		top:add({hx=130,hy=40,color=0xffcccccc,text="List",id="score_list",hooks=gui.hooks})
--		top:add({hx= 5,hy=40})
--		top:add({hx=90,hy=40,color=0xffcccccc,text="Send",id="profile_score_send",hooks=gui.hooks})
		top:add({hx=20,hy=40})

		top:add({hx=320,hy=40})
		top:add({hx=320,hy=60,text_color=0xffffffff,text=""..best_pct.."% success"})
		top:add({hx=320,hy=60,text_color=0xffffffff,text=""..mine_pct.."% effort"})
		top:add({hx=320,hy=40})

		top:add({hx=120,hy=40,color=0xffcccccc,text="Back",id="score_back",hooks=gui.hooks})
		top:add({hx=200,hy=40})
		
		master.go_back_id="score_back"
		master.go_forward_id="score_list"
		
	end

	function gui.pages.score_list(master)

		gui.clicks.score_list_less=function()
			beep_play("button")
			gui.offset=gui.offset-5
			gui.page("score_list")
		end
		gui.clicks.score_list_more=function()
			beep_play("button")
			gui.offset=gui.offset+5
			gui.page("score_list")
		end
		gui.clicks.score_list_exit=function()
			beep_play("button")
			gui.offset=1
			gui.mpage("menu") -- callback to return to original menu			
		end
	
		if gui.offset<1 then
			gui.offset=1
		end

		local top=master:add({hx=320,hy=480,class="fill",font="Vera",text_size=24})
		
		local tab={}

		
		local fill=function()
		
			top:clean_all()
		
			local b=top:add({hx=320,hy=90,class="fill",font="Vera",text_size=24,id="score_title"})			

			b:add({hx=320,hy=5})

			b:add({hx=20,hy=30})
			b:add({hx=280,hy=30,text_color=0xffffffff,text="High Scores",id="score_title_text"})
			b:add({hx=20,hy=30})

			b:add({hx=320,hy=5})

			b:add({hx=320,hy=50})

			for i=1,5 do
				local v=tab[i]

				if v then

					local b=top:add({hx=320,hy=70,class="fill",font="Vera",text_size=24,id="score_block"})			

					b:add({hx=320,hy=5})

					b:add({hx=5,hy=60})

					local s=b:add({hx=310,hy=60,class="fill"})			
					s:add(
						{hx=100,hy=30,color=0xffcccccc,text=wstr.str_append_english_number_postfix(v.idx),hooks=gui.hooks,id="score_part"},
						{hx=210,hy=30,color=0xffcccccc,text=wstr.str_insert_number_commas(v.score),hooks=gui.hooks,id="score_part"},
						{hx=310,hy=30,color=0xffcccccc,text=v.name,hooks=gui.hooks,id="score_part"})

					b:add({hx=5,hy=60})

					b:add({hx=320,hy=5})
				else

					top:add({hx=320,hy=70})
				
				end
			end
			
			
			if gui.offset>1 then
				top:add({hx=100,hy=40,color=0xffcccccc,text="Back",id="score_list_less",hooks=gui.hooks})
				top:add({hx=10,hy=40})
			else
				top:add({hx=110,hy=40})
			end

			top:add({hx=100,hy=40,color=0xffcccccc,text="Exit",id="score_list_exit",hooks=gui.hooks})

			if nomore then
				top:add({hx=110,hy=40})
			else
				top:add({hx=10,hy=40})
				top:add({hx=100,hy=40,color=0xffcccccc,text="More",id="score_list_more",hooks=gui.hooks})
			end
		end
		

		if wwin.smell=="gamestick" then
		
			gui.msg_smell_hook=function(m)

--print(gui.msg_smell_hook,wstr.dump(m))

--				if m.class=="LeaderBoard" then
					if m.data then
						for i=1,5 do
							for _,v in ipairs(m.data) do
								if v.position==gui.offset+i-1 then
									tab[i]={
										idx=tonumber(v.position or 0) or 0,
										name=v.name,
										score=tonumber(v.score or 0) or 0,
									}
								end
							end
						end

						fill()

						gui.master:layout()
						
					end
--				end
			end
		
			if wwin.hardcore.smell_score_range then wwin.hardcore.smell_score_range(gui.offset,gui.offset+4) end
			
		else
		
			local sc=sscores.list({offset=gui.offset,order="full"})
			local nomore=not sc[6]
			for i=1,5 do
				local v=sc[i]
				if v then
					tab[i]={
						idx=v.idx,
						name=v.name,
						score=v.score,
					}
				end
			end

		end
		
				
		fill()

		master.go_back_id="score_list_less"
		master.go_forward_id="score_list_exit"

	end

	function gui.pages.settings(master)
	
		gui.clicks.settings_return=function()
			beep_play("button")
			gui.mpage("menu")
		end
		gui.clicks.settings_quit=function()
			beep_play("button")
			gui.page("quit")
		end
		gui.clicks.settings_game=function()
			beep_play("button")
			if not gui.mpage("settings_game") then gui.mpage("menu") end
		end
		gui.clicks.settings_scores=function()
			beep_play("button")
			gui.page("score_list")
		end
		gui.clicks.settings_about=function()
			beep_play("button")
			oven.next=oven.rebake("wetgenes.gamecake.spew.about.sinescroll")
		end

		local top=master:add({hx=320,hy=480,class="fill",font="Vera",text_size=24})

		top:add({hx=100,hy=40,color=0xffcccccc,text="Main",id="settings_main",hooks=gui.hooks})
		top:add({hx=10,hy=40})
		top:add({hx=100,hy=40,color=0xffcccccc,text="Game",id="settings_game",hooks=gui.hooks})
		top:add({hx=10,hy=40})
		top:add({hx=100,hy=40,color=0xffcccccc,text="Scores",id="settings_scores",hooks=gui.hooks})

		top:add({hx=320,hy=40,text_color=0xffffffff,text="Music volume"})
		top:add({class="slide",color=0xffcccccc,hx=320,hy=40,datx=gui.data.vol_music,data=gui.data.vol_music,hooks=gui.hooks})
		top:add({hx=320,hy=40,text_color=0xffffffff,text="Sound effects volume"})
		top:add({class="slide",color=0xffcccccc,hx=320,hy=40,datx=gui.data.vol_sfx,data=gui.data.vol_sfx,hooks=gui.hooks})


		local t=top:add({hx=320,hy=40,class="fill",font="Vera",text_size=12,text_color=0xffffffff})
		t:add{hx=320,hy=20,text=oven.opts.title}
		t:add{hx=320,hy=20,text=""}

		top:add({hx=320,hy=40,color=0xffcccccc,text="About",id="settings_about",hooks=gui.hooks}):
			add{hx=80,hy=80,px=20,py=-20}.draw=function(w)
			w:draw_base(function(w)
				gl.Color(0,0.25,0.75,1)
				gl.PushMatrix()
				gl.Translate(w.hy*0.5,w.hy*0.5,0)
				gl.Scale(w.hy,w.hy,w.hy)
				gl.Rotate(gui.time,0,-1,0)
				gl.Rotate(gui.time/8,1,0,0)
				gl.Enable(gl.CULL_FACE)
				wetiso.draw()
				gl.Disable(gl.CULL_FACE)
				gl.PopMatrix()
			end)
		end
		
		local v= ( oven.opts.bake and oven.opts.bake.version ) or 0

		local t=top:add({hx=320,hy=40,class="fill",font="Vera",text_size=12,text_color=0xffffffff})
		t:add{hx=320,hy=20,text=""}
		t:add{hx=320,hy=20,text=(wwin.smell or "vanilla") .. " build v".. v}

						
						
		top:add({hx=320,hy=40*3})

		top:add({hx=120,hy=40,color=0xffcccccc,text="Back",id="settings_return",hooks=gui.hooks})
		top:add({hx=80,hy=40})
		top:add({hx=120,hy=40,color=0xffcc4444,text="Quit",id="settings_quit",hooks=gui.hooks})

		master.go_back_id="settings_return"
		master.go_forward_id="settings_return"

	end
	
	function gui.pages.quit(master)

		gui.clicks.quit_back=function()
			beep_play("button")
			gui.page("settings")
		end
		gui.clicks.quit_exit=function()
			beep_play("button")
			oven.next=true -- really quit
		end
				
		local top=master:add({hx=320,hy=480,class="fill",font="Vera",text_size=24})

		top:add({hx=320,hy=40*3})

		top:add({hx=320,hy=40*2,text_color=0xffffffff,text="Make your time!"})

		top:add({hx=20,hy=40*2})
		top:add({hx=120,hy=40*2,color=0xffcccccc,text="Back",id="quit_back",hooks=gui.hooks})
		top:add({hx=40,hy=40*2})
		top:add({hx=120,hy=40*2,color=0xffcc4444,text="Quit",id="quit_exit",hooks=gui.hooks})
		top:add({hx=20,hy=40*2})

		top:add({hx=320,hy=40*5})
		
		master.go_back_id="quit_back"
		master.go_forward_id="quit_back"
		
	end
	
	function gui.page(pname)
		
		gui.active=true -- display out stuff

		if not gui.master then
			gui.master=oven.rebake("wetgenes.gamecake.widgets").setup({hx=320,hy=480,px=0,py=0})
		end
	
		gui.master:clean_all()
		
		if pname then
			local f=gui.pages[pname]
			if f then
				f(gui.master) -- pass in the master so we could fill up other widgets
			end
		end

		gui.page_name=pname

		gui.set_all_values()

		gui.master:layout()
		
		if gui.widget_hook then
			gui.master:call_descendents(function(w) gui.widget_hook(w) end)
		end
		
		if gui.master.go_forward_id then
			gui.master.activate_by_id(gui.master.go_forward_id)
		end
	end

	function gui.clean()

		gui.master=nil
	
	end
	
	function gui.update()
		gui.time=gui.time+1
	
		gui.master:update()

	end
	
	function gui.msg(m)

		if m.xraw and m.yraw then	-- we need to fix raw x,y numbers
			m.x,m.y=layout.xyscale(m.xraw,m.yraw)	-- local coords, 0,0 is now center of screen
			m.x=m.x+(320/2)
			m.y=m.y+(480/2)
		end
		

		if gui.msg_smell_hook then
			if m.cmd and m.cmd:sub(1,11)=="LeaderBoard" then
				return gui.msg_smell_hook(m)
			end
		end

		gui.master:msg(m)

	end

	function gui.draw()

		layout.viewport() -- set clip area
		layout.project23d(320,480,1/4,480*4) -- build projection

		gl.MatrixMode(gl.PROJECTION)
		gl.LoadMatrix( layout.pmtx )

		gl.MatrixMode(gl.MODELVIEW)
		gl.LoadIdentity()
		gl.Translate(-320/2,-480/2,-480*2) -- top left corner is origin

		gl.PushMatrix()
		
			gui.master:draw()

		gl.PopMatrix()

	end
	
	gui.initdata()
	return gui
end
