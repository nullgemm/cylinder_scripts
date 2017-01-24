return function(view, offset, screen_width, screen_height)
   local percent = math.abs(offset/view.width)
   
   local side = -1
   if(offset > 0) then side = 1 end

   local rollup = percent*5
   local runaway = 0
   if(rollup > 1)  then rollup  = 1; runaway = (percent-0.2) * 5/3 end
   if(runaway > 1) then runaway = 1; rollup  = 1 - (percent-0.8) * 5 end

   local angle = rollup * math.pi/3
   local offsetz = math.sin(angle) * (view.height/2)
   local offsety = math.cos(angle) * (view.height/2)

   for i, icon in subviews(view) do       
      icon:translate(0, side * (view.height+20) * runaway, 0)
   end
   
   view.layer.y =  view.height/2 + (view.height/2) - offsety
   view.layer.z = -offsetz
   view.layer.x =  view.width/2 + view.x + offset
   view:rotate(angle, 1, 0, 0)
end
