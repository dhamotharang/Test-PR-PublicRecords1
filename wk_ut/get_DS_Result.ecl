/*
  if you want to get a dataset result from a remote environment(not local), the layout passed in needs to have xpaths for each field(because I need to use httpcall and parse the resulting xml)
  if you are just grabbing a local dataset result(within the environment this runs), then you don't need xpaths.
*/
/*
import wk_ut;
export get_DS_Result(pWuid,pNamedOutput,pRecordLayout,pesp = '_constants.LocalEsp') := 
functionmacro
  attr := DATASET( WORKUNIT(pWuid , pNamedOutput ), pRecordLayout );
  return if(wk_ut.Is_Valid_Wuid(pWuid) ,attr ,dataset([],pRecordLayout));
endmacro;
*/

export get_DS_Result(
   pWuid
  ,pNamedOutput
  ,pRecordLayout
  ,pesp           = 'WorkMan._Config.LocalEsp'
  ,pCount         = '\'1000\''
  ,pForceHTTPCall = 'false'
) := 
functionmacro

  import Workman;
  return Workman.get_DS_Result(
     pWuid  
    ,pNamedOutput  
    ,pRecordLayout  
    ,pesp            
    ,pCount          
    ,pForceHTTPCall  
  );

endmacro;