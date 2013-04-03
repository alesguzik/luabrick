board_x = 0

function draw_board()
   love.graphics.rectangle('fill',board_x,400, 200,20)
   current_time = love.timer.getTime()
   move_board = 0
   if love.keyboard.isDown('left') then
      move_board = move_board - 1
   end
   if love.keyboard.isDown('right') then
      move_board = move_board + 1
   end
   board_x = board_x + love.timer.getDelta() * 500 * move_board
end

function love.draw()
   love.graphics.rectangle('fill',10,10,100,30)
   draw_board()
end

-- function love.keypressed(k)
--     if k == 'right' then
--         board_x = board_x + 10
--     elseif k == 'left' then
--        board_x = board_x - 10
--     elseif k == 'escape' then
--        love.event.push('quit')
--     end
-- end
