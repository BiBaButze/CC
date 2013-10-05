
os.loadAPI("imp")

data = {}
data.slot = {
  disk = 1,
  diskDrive = 2,
  computer = 3,
  modem = 4
}

function init()
end

function writeDiskStartup( v )
  fs.delete( "disk/startup" )
  file = fs.open( "disk/startup", "w" )
  file.writeLine( 'os.setComputerLabel( "GPS-Satellit: '.. v.x ..', '.. v.y ..', '.. v.z ..'" )' )
  file.writeLine( 'fs.copy( "disk/install", "startup" )' )
  file.writeLine( 'fs.delete( "disk/startup" )' )
  file.writeLine( 'sleep( 2 )')
  file.writeLine( 'os.reboot()' )
  file.close()
end

function writeDiskInstall( v )
  fs.delete( "disk/install" )
  file = fs.open( "disk/install", "w" )
  file.writeLine( 'shell.run( "gps", "host", "'.. v.x ..'", "'.. v.y ..'", "'.. v.z ..'")' )
  file.close()
end

function buildComputerUnit()
  turtle.select( data.slot.computer )
  turtle.place()
  imp.turnLeft()
  imp.forward(2)
  imp.turnRight()
  imp.forward()
  imp.turnRight()
  turtle.select( data.slot.modem )
  turtle.place()
  imp.turnRight()
  imp.forward()
  imp.turnLeft()
  imp.forward(2)
  imp.turnLeft()
end

function initComputerUnit()
  imp.down()
  turtle.select( data.slot.diskDrive )
  turtle.place()
  turtle.select( data.slot.disk )
  turtle.drop()
  writeDiskStartup( imp.location() + imp.direction() + vector.new( 0, 1, 0 ) )
  writeDiskInstall( imp.location() + imp.direction() + vector.new( 0, 1, 0 ) )
  imp.up()
  peripheral.call( "front", "turnOn" )
  peripheral.call( "front", "reboot" )
  sleep( 5 )
  imp.down()
  turtle.suck()
  turtle.dig()
  imp.up()
end

function goTop()
end

function buildSatellite()
  imp.init()
  data.start = imp.location()

  while imp.location().y <= 250 do
    imp.up()
  end

  for i=1,4 do
    if i%2 == 0 then
      imp.up()
    else
      imp.down()
    end
    imp.forward()
    buildComputerUnit()
    initComputerUnit()
    imp.back()
    imp.turnLeft()
    if i%2 == 0 then
      imp.down()
    else
      imp.up()
    end
  end

  while imp.location().y > data.start.y do
    imp.down()
  end
end

buildSatellite()
