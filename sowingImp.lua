
dofile( "imp" )

function forward( n )
  for i=1,n or 1 do
    turtle.digDown()
    turtle.placeDown()
    if turtle.forward() then
      data.location = data.location + data.direction
    else
      return false
    end
  end
  return location()
end

