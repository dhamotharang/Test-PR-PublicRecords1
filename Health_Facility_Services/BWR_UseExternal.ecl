//This is the code to execute in a builder window
#workunit('name','Health_Facility_Services.BWR_UseExternal - Using External Linking - SALT V2.9 Beta 1');
IMPORT Health_Facility_Services,SALT29;
// For any fields you have replace the /* */ 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  Health_Facility_Services.MAC_Meow_xLNPID_Batch(myinfile,myrefence_number,/* MY_CNAME*/,/* MY_CNP_NAME*/,/* MY_CNP_NUMBER*/,/* MY_CNP_STORE_NUMBER*/
          ,/* MY_CNP_BTYPE*/,/* MY_CNP_LOWV*/,/* MY_PRIM_RANGE*/,/* MY_PRIM_NAME*/,/* MY_SEC_RANGE*/
          ,/* MY_V_CITY_NAME*/,/* MY_ST*/,/* MY_ZIP*/,/* MY_TAX_ID*/,/* MY_FEIN*/
          ,/* MY_PHONE*/,/* MY_LIC_STATE*/,/* MY_C_LIC_NBR*/,/* MY_DEA_NUMBER*/,/* MY_VENDOR_ID*/
          ,/* MY_NPI_NUMBER*/,/* MY_CLIA_NUMBER*/,/* MY_MEDICARE_FACILITY_NUMBER*/,/* MY_BDID*/,/* MY_SRC*/
          ,/* MY_SOURCE_RID*/,/* MY_ADDR1*/,/* MY_LOCALE*/,/* MY_ADDRESS*/,MyOutFile,SmallJob,Stats);
//The version online version can be used if a Roxie version of the xLNPID is available
//  Health_Facility_Services.MAC_Meow_xLNPID_Online(myinfile,myrefence_number,/* MY_CNAME*/,/* MY_CNP_NAME*/,/* MY_CNP_NUMBER*/,/* MY_CNP_STORE_NUMBER*/
//        ,/* MY_CNP_BTYPE*/,/* MY_CNP_LOWV*/,/* MY_PRIM_RANGE*/,/* MY_PRIM_NAME*/,/* MY_SEC_RANGE*/
//        ,/* MY_V_CITY_NAME*/,/* MY_ST*/,/* MY_ZIP*/,/* MY_TAX_ID*/,/* MY_FEIN*/
//        ,/* MY_PHONE*/,/* MY_LIC_STATE*/,/* MY_C_LIC_NBR*/,/* MY_DEA_NUMBER*/,/* MY_VENDOR_ID*/
//        ,/* MY_NPI_NUMBER*/,/* MY_CLIA_NUMBER*/,/* MY_MEDICARE_FACILITY_NUMBER*/,/* MY_BDID*/,/* MY_SRC*/
//        ,/* MY_SOURCE_RID*/,/* MY_ADDR1*/,/* MY_LOCALE*/,/* MY_ADDRESS*/,MyOutFile,Stats);
  MyOutFile;
  Stats;
