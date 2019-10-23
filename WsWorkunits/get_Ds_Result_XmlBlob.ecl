/*
  idea is to be able to pass in a wuid to a function, and it will return the dataset of 
    result name, field name , index and field value
  for scalar results the result name and field value would be populated.
  for dataset results, all fields would be populated.  the default could be only 10 records per dataset result.
  then, you could filter for whatever result the user wants and they wouldn't have to give you the layout of the dataset results, making it easier
  to setup.

*/

import std,WsWorkunits;
export get_Ds_Result_XmlBlob(
   string   pWuid
  ,string   pNamedOutput
  ,string   pesp           = WsWorkunits._Config.localEsp
  ,unsigned pCount         = 1000
) := 
function
  
   
  seq       := WsWorkunits.Get_Result_Sequence_Number (pWuid,pNamedOutput,pesp);
  ds_result := WsWorkunits.soapcall_WUResult          (pWuid,pNamedOutput,(string)seq,pesp,pCount);
  
  //parse into field name, field value dataset
  //<Dataset
  ds_dataset := project(ds_result ,transform({recordof(left)},self.payload := regexreplace('^.*?<Dataset[^>]*>(.*?)</Dataset[^>]*>$',left.payload,'$1',nocase)));
  ds_norm    := normalize(ds_dataset  ,STD.Str.FindCount( ds_dataset[1].payload, '<Row>') ,transform(
    {unsigned record_number,string payload}
    ,row_index_start  := STD.Str.Find( left.payload, '<Row>' , counter );
     row_index_end    := STD.Str.Find( left.payload, '</Row>', counter );
     payload_sliver   := left.payload[row_index_start + 5..row_index_end - 1];
    
     self.record_number := counter;
     self.payload       := payload_sliver;
  ));
  
// <subfilename>~SALT_Reg_BIP_ProxID1::base::Reg_370_3::data</subfilename><doessubfileexist>false</doessubfileexist><dsubfilecontainers></dsubfilecontainers>

  ds_norm2 := normalize(ds_norm ,STD.Str.FindCount( left.payload, '<') / 2  ,transform(
    {string result_name ,string field_name ,string field_value  ,unsigned record_number}
    
    ,tag_index_start  := if(counter = 1 ,STD.Str.Find( left.payload, '<' , counter     )  ,STD.Str.Find( left.payload, '<' , counter + counter - 1) );
     tag_index_end    := STD.Str.Find( left.payload, '>' , counter * 2 );
     payload_sliver   := left.payload[tag_index_start..tag_index_end];
    
     self.result_name   := pNamedOutput;
     self.field_name    := regexfind('<([^>]*)>'          ,payload_sliver  ,1,nocase);
     self.field_value   := regexfind('<([^>]*)>([^<]*)<.*',payload_sliver  ,2,nocase);
     self.record_number := left.record_number;
  ));
  
// <subfilename>~SALT_Reg_BIP_ProxID1::base::Reg_370_3::data</subfilename>
// <doessubfileexist>false</doessubfileexist>
// <dsubfilecontainers></dsubfilecontainers>
// <dsubfilecontainers></dsubfilecontainers>
// end >
 // 1 = 2
 // 2 = 4
 // 3 = 6
 
  // 1 = 1
  // 2 = 3
  // 3 = 5
  // 4 = 7
  // 5 = 9

  return ds_norm2;
  
end;

