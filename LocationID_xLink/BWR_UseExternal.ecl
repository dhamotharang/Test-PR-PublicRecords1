//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','LocationId_xLink.BWR_UseExternal - Using External Linking - SALT V3.7.0');
IMPORT LocationId_xLink,SALT37;
// For any fields you have replace the /* */ 
 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  UpdateIDs := FALSE;
  LocationId_xLink._CFG.MAC_Meow_LocationID_Batch_Wrapper(myinfile,myrefence_number,/* MY_LocId */,/* MY_prim_range*/,/* MY_predir*/,/* MY_prim_name*/,/* MY_addr_suffix*/
          ,/* MY_postdir*/,/* MY_unit_desig*/,/* MY_sec_range*/,/* MY_v_city_name*/,/* MY_st*/
          ,/* MY_zip5*/,MyOutFile,SmallJob,UpdateIDs,Stats);
//The online version can be used if a Roxie version of the xLocId is available
//  LocationId_xLink.MAC_Meow_LocationID_Online(myinfile,myrefence_number,/* MY_prim_range*/,/* MY_predir*/,/* MY_prim_name*/,/* MY_addr_suffix*/
//        ,/* MY_postdir*/,/* MY_unit_desig*/,/* MY_sec_range*/,/* MY_v_city_name*/,/* MY_st*/
//        ,/* MY_zip5*/,/*Soapcall_RoxieIP*/,/*Soapcall_Timeout*/,/*Soapcall_Time_Limit*/,/*Soapcall_Retry*/,/*Soapcall_Parallel*/,MyOutFile,Stats,50,0);
  MyOutFile;
  Stats;
