//This is the code to execute in a builder window
#workunit('name','Health_Provider_Services.BWR_UseExternal - Using External Linking - SALT V2.8 Gold SR1');
IMPORT Health_Provider_Services,SALT28;
// For any fields you have replace the /* */ 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  Health_Provider_Services.MAC_Meow_xLNPID_Batch(myinfile,myrefence_number,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/,/* MY_SNAME*/
          ,/* MY_GENDER*/,/* MY_PRIM_RANGE*/,/* MY_PRIM_NAME*/,/* MY_SEC_RANGE*/,/* MY_V_CITY_NAME*/
          ,/* MY_ST*/,/* MY_ZIP*/,/* MY_SSN*/,/* MY_DOB*/,/* MY_PHONE*/
          ,/* MY_LIC_STATE*/,/* MY_C_LIC_NBR*/,/* MY_TAX_ID*/,/* MY_DEA_NUMBER*/,/* MY_VENDOR_ID*/
          ,/* MY_NPI_NUMBER*/,/* MY_UPIN*/,/* MY_DID*/,/* MY_BDID*/,/* MY_SRC*/
          ,/* MY_SOURCE_RID*/,/* MY_MAINNAME*/,/* MY_FULLNAME*/,/* MY_ADDR1*/,/* MY_LOCALE*/
          ,/* MY_ADDRESS*/,MyOutFile,SmallJob,Stats);
//The version online version can be used if a Roxie version of the xLNPID is available
//  Health_Provider_Services.MAC_Meow_xLNPID_Online(myinfile,myrefence_number,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/,/* MY_SNAME*/
//        ,/* MY_GENDER*/,/* MY_PRIM_RANGE*/,/* MY_PRIM_NAME*/,/* MY_SEC_RANGE*/,/* MY_V_CITY_NAME*/
//        ,/* MY_ST*/,/* MY_ZIP*/,/* MY_SSN*/,/* MY_DOB*/,/* MY_PHONE*/
//        ,/* MY_LIC_STATE*/,/* MY_C_LIC_NBR*/,/* MY_TAX_ID*/,/* MY_DEA_NUMBER*/,/* MY_VENDOR_ID*/
//        ,/* MY_NPI_NUMBER*/,/* MY_UPIN*/,/* MY_DID*/,/* MY_BDID*/,/* MY_SRC*/
//        ,/* MY_SOURCE_RID*/,/* MY_MAINNAME*/,/* MY_FULLNAME*/,/* MY_ADDR1*/,/* MY_LOCALE*/
//        ,/* MY_ADDRESS*/,MyOutFile,Stats);
  MyOutFile;
  Stats;
