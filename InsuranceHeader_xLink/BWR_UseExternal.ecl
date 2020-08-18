//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_xLink.BWR_UseExternal - Using External Linking - SALT V3.11.10-PV1');
IMPORT InsuranceHeader_xLink,SALT311;
// For any fields you have replace the /* */ 
 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  InUpdateIDs := FALSE;
  DisableForce := FALSE;
  DoClean := TRUE;
  // replace definition below with desired input file, myreference_number should be unique per record
  myinfile := DATASET([], {InsuranceHeader_xLink.Layout_InsuranceHeader, UNSIGNED myreference_number});
  InsuranceHeader_xLink.Config.MAC_Meow_xIDL_Batch_Wrapper(myinfile,myreference_number,/* MY_DID */,/* MY_SNAME*/,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/
          ,/* MY_DERIVED_GENDER*/,/* MY_PRIM_RANGE*/,/* MY_PRIM_NAME*/,/* MY_SEC_RANGE*/,/* MY_CITY*/
          ,/* MY_ST*/,/* DATASET MY_ZIP*/,/* MY_SSN5*/,/* MY_SSN4*/,/* MY_DOB*/
          ,/* MY_PHONE*/,/* MY_DL_STATE*/,/* MY_DL_NBR*/,/* MY_SRC*/,/* MY_SOURCE_RID*/
          ,/* MY_DT_FIRST_SEEN*/,/* MY_DT_LAST_SEEN*/,/* MY_DT_EFFECTIVE_FIRST*/,/* MY_DT_EFFECTIVE_LAST*/,/* MY_MAINNAME*/
          ,/* MY_FULLNAME*/,/* MY_ADDR1*/,/* MY_LOCALE*/,/* MY_ADDRESS*/,/* MY_fname2*/
          ,/* MY_lname2*/,/* MY_VIN*/,MyOutFile,SmallJob,InUpdateIDs,Stats,DisableForce,DoClean);
//The online version can be used if a Roxie version of the xDID is available
//  InsuranceHeader_xLink.MAC_Meow_xIDL_Online(myinfile,myreference_number,/* MY_SNAME*/,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/
//        ,/* MY_DERIVED_GENDER*/,/* MY_PRIM_RANGE*/,/* MY_PRIM_NAME*/,/* MY_SEC_RANGE*/,/* MY_CITY*/
//        ,/* MY_ST*/,/* DATASET MY_ZIP*/,/* MY_SSN5*/,/* MY_SSN4*/,/* MY_DOB*/
//        ,/* MY_PHONE*/,/* MY_DL_STATE*/,/* MY_DL_NBR*/,/* MY_SRC*/,/* MY_SOURCE_RID*/
//        ,/* MY_DT_FIRST_SEEN*/,/* MY_DT_LAST_SEEN*/,/* MY_DT_EFFECTIVE_FIRST*/,/* MY_DT_EFFECTIVE_LAST*/,/* MY_MAINNAME*/
//        ,/* MY_FULLNAME*/,/* MY_ADDR1*/,/* MY_LOCALE*/,/* MY_ADDRESS*/,/* MY_fname2*/
//        ,/* MY_lname2*/,/* MY_VIN*/,/*Soapcall_RoxieIP*/,/*Soapcall_Timeout*/,/*Soapcall_Time_Limit*/,/*Soapcall_Retry*/,/*Soapcall_Parallel*/,MyOutFile,Stats,50,0, FALSE);
  MyOutFile;
  Stats;
