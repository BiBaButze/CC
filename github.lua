
if not http then
    printError( "github requires http API" )
    printError( "Set enableAPI_http to true in ComputerCraft.cfg" )
    return
end

get = function( author, repo, branch, sFile )
  local sPath = shell.resolve( sFile )
  
  -- GET the content
  write( "Connecting to GitHub... " )
  local url = 'https://raw.github.com/'..author..'/'..repo..'/'..branch..'/'..sFile..'.lua'
  local response = http.get( textutils.urlEncode( url ) )
      
  if response then
      print( "Success." )
      
      local sResponse = response.readAll()
      response.close()

      if fs.exists( sPath ) then
          fs.delete( sPath )
      end

      local file = fs.open( sPath, "w" )
      file.write( res )
      file.close()
      
      print( "Downloaded as "..sFile )
  else
      printError( "Failed." )
  end
end 

