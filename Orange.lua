return function(page, offset, screen_width, screen_height)
   local rings = 3
   local percent = math.abs(offset/page.width)
   local ringparts = math.floor(#page.subviews/rings)
   local overflow = #page.subviews-ringparts*rings

   side = -1
   if(offset > 0) then side = 1 end

   local rollup = percent * 5
   local runaway = 0
   if(rollup > 1) then rollup = 1; runaway = (percent-0.20) / 0.6 end
   if(runaway > 1) then runaway = 1 end

   local middleX = page.width/2
   local middleY = page.height/2 + 7
   local hint = 1

   for i, icon in subviews(page) do
      local pathZ = math.ceil(i/ringparts)
      local capacitor = 0
      
      if(overflow > 0) then
         if(#page.subviews-i < overflow) then
            pathZ = math.ceil(i/ringparts)-hint
            hint = hint + 1
            capacitor = 1
         else
            if(rings-pathZ < overflow) then
               capacitor = 1
            end
         end
      end
      
      local magicheight = icon.height
      local radius = magicheight * pathZ + magicheight * rings * runaway * side
      local angle = (math.pi*2*i) / (ringparts+capacitor) + math.pi * runaway
      local iconX = icon.x + icon.width/2
      local iconY = icon.y + icon.height/2

      local pathX = middleX + radius * math.cos(angle) * side
      local pathY = middleY + radius * math.sin(angle) * side

      icon:translate(rollup * (pathX-iconX), rollup * (pathY-iconY),0)
      icon:rotate(rollup * (angle-math.pi/2))
      icon:scale(1 - (1-(radius/(middleY+50))) * rollup)
      icon.alpha = radius
   end
   
   page:translate(offset,0,0)
end
