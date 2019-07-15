/*
  if you want to get a dataset result from a remote environment(not local), the layout passed in needs to have xpaths for each field(because I need to use httpcall and parse the resulting xml)
  if you are just grabbing a local dataset result(within the environment this runs), then you don't need xpaths.

  https://track.hpccsystems.com/browse/HPCC-11151 -- Support xpath(‘<>’) for write (especially for SOAPCALL/HTTPCALL but also OUTPUT)
  Once this is fixed(target is 7.0.0), it will allow you to not know the layout of the returned xml for a result, but we should
  be able to normalize it out to a field name, field value dataset.  this might also require doing this as a soapcall instead of an HTTPCALL because the soapcall
  returns the blob of xml.
  idea is to be able to pass in a wuid to a function, and it will return the dataset of 
    result name, field name , index and field value
  for scalar results the result name and field value would be populated.
  for dataset results, all fields would be populated.  the default could be only 10 records per dataset result.
  then, you could filter for whatever result the user wants and they wouldn't have to give you the layout of the dataset results, making it easier
  to setup.

*/
/*
import WorkMan;
export get_DS_Result(pWuid,pNamedOutput,pRecordLayout,pesp = '_Config.LocalEsp') := 
functionmacro
  attr := DATASET( WORKUNIT(pWuid , pNamedOutput ), pRecordLayout );
  return if(WorkMan.Is_Valid_Wuid(pWuid) ,attr ,dataset([],pRecordLayout));
endmacro;
*/

import WorkMan,tools,WsWorkunits;
export get_DS_Result(
   pWuid
  ,pNamedOutput
  ,pRecordLayout
  ,pesp           = 'WorkMan._Config.LocalEsp'
  ,pCount         = '\'1000\''
  ,pForceHTTPCall = 'false'
) := 
functionmacro
  
  import WorkMan,tools,WsWorkunits;
   
  local_DS_result   := DATASET( WORKUNIT(pWuid , pNamedOutput ), pRecordLayout );
  remote_DS_result  := WsWorkunits.get_Ds_Result(pWuid,pNamedOutput,pRecordLayout,pCount,pesp);

  IsEspLocal        := if(pesp in WorkMan._Config.LocalEsps ,true ,false);

  return if(WorkMan.Is_Valid_Wuid(pWuid) 
    ,if(IsEspLocal and pForceHTTPCall = false   ,local_DS_result 
                                                ,remote_DS_result
    )
    ,dataset([],pRecordLayout)
  );

  // return raw;
  
endmacro;

