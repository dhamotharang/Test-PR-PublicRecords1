EXPORT Checkin_Sandboxed_Attributes(
   string		pModuleName			= ''
  ,string		pDescription	  = ''
  ,string		pAttRegex	      = ''
  ,string		pEsp						= _Config().Esp
  ,string		pUrl						= _Config(pEsp).Url
) :=
function

  //check in pure salt code at this point so we can compare it to the hacked code(only sandboxed atts)
  ds_getatts := Repository.find_Attributes(
     pModuleName          := pModuleName
    ,pAttributeName     	:= ''//pAttRegex   
    ,pIsSandbox				    := false 
    ,pGetHistory          := true
  );
  
  ds_getatts_filtered := ds_getatts(pAttRegex = '' or regexfind(pAttRegex,attributename,nocase,IsSandbox = true));
  
  checkout_pure_salt    := apply(ds_getatts  ,Repository.Checkout_Attribute(modulename,attributename              ));
  checkin_pure_salt     := apply(ds_getatts  ,Repository.Checkin_Attribute (modulename,attributename,pDescription ));
  
  return sequential(
     checkout_pure_salt
    ,checkin_pure_salt
  );

end;