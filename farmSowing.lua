
os.loadAPI( "sowingImp" )

sowingImp.init()

data = {}
func = {}

func.sowField = function ( v )
  while sowingImp.y < 80 do
    sowingImp.up()
  end

  sowingImp.goTo( v )

  for i=1,42 do
    if i%7 == 0 then
      sowingImp.down()
    end
    
    if i%2 == 0 then
      sowingImp.go( vector.new( 0,0,-3 ) )
    else
      sowingImp.go( vector.new( 0,0,3 ) )
    end

    if i%42 == 0 then
      turtle.digDown()
      turtle.placeDown()
      sowingImp.go( vector.new( 0,2,0 ) )
    else
      sowingImp.go( vector.new( 1,0,0 ) )
    end
  end
end
