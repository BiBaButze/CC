
local tArgs = { ... }

local function dive()
  local i = 0
  while turtle.placeDown() do
    turtle.refuel()
    if turtle.down() then
      i = i + 1
    end
  end

  for j=1,i do
    turtle.up()
  end
end

for i=1,16 do
  turtle.forward()
  dive()
end

turtle.turnRight()
turtle.turnRight()

for i=1,16 do
  turtle.forward()
end
