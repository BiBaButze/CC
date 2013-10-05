os.loadAPI("vector")

data = {}

data.location = vector.new( 0, 0, 0 )
data.direction = vector.new( 1, 0, 0 )

function x()
  return data.location.x
end

function y()
  return data.location.y
end

function z()
  return data.location.z
end

function dx()
  return data.direction.x
end

function dy()
  return data.direction.y
end

function dz()
  return data.direction.z
end

function location()
  return data.location
end

function direction()
  return data.direction
end

function init()
  data.location = vector.new( gps.locate(5) )

  for i=1,4 do
    if turtle.forward() then
      tLoc = vector.new( gps.locate(5) )
      turtle.back()
      break
    else
      turtle.turnLeft()
    end
  end
  
  data.direction = tLoc - data.location
end

function forward( n )
  for i=1,n or 1 do
    if turtle.forward() then
      data.location = data.location + data.direction
    else
      return false
    end
  end
  return location()
end

function back( n )
  for i=1,n or 1 do
    if turtle.back() then
      data.location = data.location - data.direction
    else
      return false
    end
  end
  return location()
end

function up(n)
  for i=1,n or 1 do
    if turtle.up() then
      data.location = data.location + vector.new( 0,1,0 )
    else
      return false
    end
  end
  return location()
end

function down( n )
  for i=1,n or 1 do
    if turtle.down() then
      data.location = data.location - vector.new( 0,1,0 )
    else
      return false
    end
  end
  return location()
end

function turnLeft( n )
  for i=1,n or 1 do
    if turtle.turnLeft() then
      data.direction = data.direction:rotateY( 90 )
    else
      return false
    end
  end
  return direction()
end

function turnRight( n )
  for i=1,n or 1 do
    if turtle.turnRight() then
      data.direction = data.direction:rotateY( -90 )
    else
      return false
    end
  end
  return direction()
end

function go( v, forceMovement )
  forceMovement = forceMovement or false
  while v:length() > 0 do
    theta = data.direction:theta(v)
  
    if theta >= math.pi/2 then
      cross = data.direction:cross(vDest)
      if cross.y == 0 then
        if v.y > 0 then
          while up() == false do
            turtle.digUp()
          end
          v = v - vector.new( 0, 1, 0 )
        else
          while down() == false do
            turtle.digDown()
          end
          v = v - vector.new( 0, -1, 0 )
        end
      else
        if cross.y > 0 then
          turnLeft()
        else
          turnRight()
        end
      end
    else
      while forward() == false do
        turtle.dig()
      end
      v = v - data.direction
    end
  end
end

function goTo( v, forceMovement )
  forceMovement = forceMovement or false
  v = v - data.location
  go( v, forceMovement )
end