return function(page, offset, screen_width, screen_height)
   local percent = math.abs(offset/page.width)
   local side = -1
   if(offset > 0) then side = 1 end

   local rollup = percent * 5
   local sizefact = 0
   if(rollup > 1) then rollup = 1; sizefact = 1 end

   local runaway = (percent-0.20)/0.6
   local op = 1
   if(runaway < 0) then runaway = 0 end
   if(runaway > 1) then op = 1 - (runaway-1)/(1/3) end
   if(side < 0) then runaway = 1 - runaway end

   local middleX = page.width / 2
   local middleY = page.height / 2+7

   local radiusparts = (middleY/2)/#page.subviews
   local theta = (3.5*math.pi)/#page.subviews

   for i, icon in subviews(page) do
      local angle = (i - 1 + runaway * #page.subviews) * theta
      local initradius =(i - 1 + runaway * #page.subviews) * radiusparts
      local radius = initradius + middleY/2
      if(side < 0) then
         radius = initradius
         angle = angle + math.pi/2
      end
      local iconX = icon.x + icon.width/2
      local iconY = icon.y + icon.height/2
      local pathX = (middleX + (radius*math.cos(angle)))
      local pathY = (middleY + (radius*math.sin(angle)))
      icon:translate(rollup * (pathX-iconX), rollup * (pathY-iconY), 0)
      icon:rotate(rollup * angle)
      local size = 1 - (1 - radius/middleY) * rollup
      icon:scale(size)
      icon.alpha = op
   end
   
   page:translate(offset, 0, 0)
end
