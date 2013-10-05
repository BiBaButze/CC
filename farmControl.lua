local side = "left"
local time = 120

local function pulseRS()
  rs.setOutput( "top", true )
  rs.setOutput( side, true )
  sleep( 0.4 )
  rs.setOutput( "top", false)
  rs.setOutput( side, false)
end

local function reset()
  local p = peripheral.wrap("top")
  local item = p.getStackInSlot(5).rawName
  if item == "bucket" then
    pulseRS()
  end
end

rednet.open( "bottom" )

reset()

while true do
  local senderId, message, distance = rednet.receive()

  if message == "startHarvest" then
    pulseRS()
    sleep( time )
    pulseRS()

    rednet.send(senderId, "harvestComplete")
  end
end