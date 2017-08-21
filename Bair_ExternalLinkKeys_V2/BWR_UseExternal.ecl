//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Bair_ExternalLinkKeys_V2.BWR_UseExternal - Using External Linking - SALT V3.7.0');
IMPORT Bair_ExternalLinkKeys_V2,SALT37;
// For any fields you have replace the /* */ 
 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  UpdateIDs := FALSE;
  Bair_ExternalLinkKeys_V2.Config.MAC_Meow_PS_Batch_Wrapper(myinfile,myrefence_number,/* MY_EID_HASH */,/* MY_NAME_SUFFIX*/,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/
          ,/* MY_PRIM_RANGE*/,/* MY_PRIM_NAME*/,/* MY_SEC_RANGE*/,/* MY_P_CITY_NAME*/,/* MY_ST*/
          ,/* MY_ZIP*/,/* MY_DOB*/,/* MY_PHONE*/,/* MY_DL_ST*/,/* MY_DL*/
          ,/* MY_LEXID*/,/* MY_POSSIBLE_SSN*/,/* MY_CRIME*/,/* MY_NAME_TYPE*/,/* MY_CLEAN_GENDER*/
          ,/* MY_CLASS_CODE*/,/* MY_DT_FIRST_SEEN*/,/* MY_DT_LAST_SEEN*/,/* MY_DATA_PROVIDER_ORI*/,/* MY_VIN*/
          ,/* MY_PLATE*/,/* MY_LATITUDE*/,/* MY_LONGITUDE*/,/* MY_SEARCH_ADDR1*/,/* MY_SEARCH_ADDR2*/
          ,/* MY_CLEAN_COMPANY_NAME*/,/* MY_MAINNAME*/,/* MY_FULLNAME*/,MyOutFile,SmallJob,Stats, FALSE);
//The online version can be used if a Roxie version of the xEID_HASH is available
//  Bair_ExternalLinkKeys_V2.MAC_Meow_PS_Online(myinfile,myrefence_number,/* MY_NAME_SUFFIX*/,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/
//        ,/* MY_PRIM_RANGE*/,/* MY_PRIM_NAME*/,/* MY_SEC_RANGE*/,/* MY_P_CITY_NAME*/,/* MY_ST*/
//        ,/* MY_ZIP*/,/* MY_DOB*/,/* MY_PHONE*/,/* MY_DL_ST*/,/* MY_DL*/
//        ,/* MY_LEXID*/,/* MY_POSSIBLE_SSN*/,/* MY_CRIME*/,/* MY_NAME_TYPE*/,/* MY_CLEAN_GENDER*/
//        ,/* MY_CLASS_CODE*/,/* MY_DT_FIRST_SEEN*/,/* MY_DT_LAST_SEEN*/,/* MY_DATA_PROVIDER_ORI*/,/* MY_VIN*/
//        ,/* MY_PLATE*/,/* MY_LATITUDE*/,/* MY_LONGITUDE*/,/* MY_SEARCH_ADDR1*/,/* MY_SEARCH_ADDR2*/
//        ,/* MY_CLEAN_COMPANY_NAME*/,/* MY_MAINNAME*/,/* MY_FULLNAME*/,/*Soapcall_RoxieIP*/,/*Soapcall_Timeout*/,/*Soapcall_Time_Limit*/,/*Soapcall_Retry*/,/*Soapcall_Parallel*/,MyOutFile,Stats,50,0, FALSE);
  MyOutFile;
  Stats;
