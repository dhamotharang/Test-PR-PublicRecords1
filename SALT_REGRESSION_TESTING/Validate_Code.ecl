import wk_ut,Repository;

EXPORT Validate_Code(

   string  pModule
  ,string  pBWR_Attribute
  ,string  pcluster           = wk_ut._constants.LocalHthor
  ,string  pESP               = wk_ut._constants.LocalEsp
  ,string  pESPPort           = '8010'

) :=
function

  ds_getatt := Repository.find_Attributes(
     pModuleName          := pModule
    ,pAttributeName     	:= pBWR_Attribute   
    ,pIsSandbox				    := false 
    ,pGetHistory          := false
  );

  ECL := ds_getatt[1].text;

  return if(pBWR_Attribute != '' and ECL != ''  ,wk_ut.CompileWuid(ECL,pcluster,pESP,pESPPort));

end;