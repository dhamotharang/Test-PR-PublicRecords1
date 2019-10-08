//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader_ExternalLinking.BWR_UseExternal - Using External Linking - SALT V3.11.7');
IMPORT HealthcareNoMatchHeader_ExternalLinking,SALT311;
// For any fields you have replace the /* */ 
 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  InUpdateIDs := FALSE;
  DisableForce := FALSE;
  DoClean := TRUE;
  // replace definition below with desired input file, myreference_number should be unique per record
  myinfile := DATASET([], {HealthcareNoMatchHeader_ExternalLinking.Layout_HEADER, UNSIGNED myreference_number});
  HealthcareNoMatchHeader_ExternalLinking.Config.MAC_Meow_XNOMATCH_Batch_Wrapper(myinfile,myreference_number,/* MY_nomatch_id */,/* MY_SRC*/,/* MY_SSN*/,/* MY_DOB*/,/* MY_LEXID*/
          ,/* MY_SUFFIX*/,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/,/* MY_GENDER*/
          ,/* MY_PRIM_NAME*/,/* MY_PRIM_RANGE*/,/* MY_SEC_RANGE*/,/* MY_CITY_NAME*/,/* MY_ST*/
          ,/* MY_ZIP*/,/* MY_DT_FIRST_SEEN*/,/* MY_DT_LAST_SEEN*/,/* MY_MAINNAME*/,/* MY_ADDR1*/
          ,/* MY_LOCALE*/,/* MY_ADDRESS*/,/* MY_FULLNAME*/,MyOutFile,SmallJob,InUpdateIDs,Stats,DisableForce,DoClean);
//The online version can be used if a Roxie version of the xnomatch_id is available
//  HealthcareNoMatchHeader_ExternalLinking.MAC_Meow_XNOMATCH_Online(myinfile,myreference_number,/* MY_SRC*/,/* MY_SSN*/,/* MY_DOB*/,/* MY_LEXID*/
//        ,/* MY_SUFFIX*/,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/,/* MY_GENDER*/
//        ,/* MY_PRIM_NAME*/,/* MY_PRIM_RANGE*/,/* MY_SEC_RANGE*/,/* MY_CITY_NAME*/,/* MY_ST*/
//        ,/* MY_ZIP*/,/* MY_DT_FIRST_SEEN*/,/* MY_DT_LAST_SEEN*/,/* MY_MAINNAME*/,/* MY_ADDR1*/
//        ,/* MY_LOCALE*/,/* MY_ADDRESS*/,/* MY_FULLNAME*/,/*Soapcall_RoxieIP*/,/*Soapcall_Timeout*/,/*Soapcall_Time_Limit*/,/*Soapcall_Retry*/,/*Soapcall_Parallel*/,MyOutFile,Stats,50,0, FALSE);
  MyOutFile;
  Stats;
