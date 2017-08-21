//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader.BWR_UseExternal - Using External Linking - SALT V2.7 Gold SR1');
IMPORT HealthCareProviderHeader,SALT27;
// For any fields you have replace the /* */ 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  HealthCareProviderHeader.MAC_Meow_LNPID_Batch(myinfile,myrefence_number,/* MY_DID*/,/* MY_DOB*/,/* MY_PHONE*/,/* MY_SNAME*/
          ,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/,/* MY_GENDER*/,/* MY_DERIVED_GENDER*/
          ,/* MY_LIC_NBR*/,/* MY_ADDRESS_ID*/,/* MY_PRIM_NAME*/,/* MY_PRIM_RANGE*/,/* MY_SEC_RANGE*/
          ,/* MY_V_CITY_NAME*/,/* MY_ST*/,/* MY_ZIP*/,/* MY_CNAME*/,/* MY_TAX_ID*/
          ,/* MY_UPIN*/,/* MY_DEA_NUMBER*/,/* MY_VENDOR_ID*/,/* MY_NPI_NUMBER*/,/* MY_DT_FIRST_SEEN*/
          ,/* MY_DT_LAST_SEEN*/,/* MY_DT_LIC_EXPIRATION*/,/* MY_DT_DEA_EXPIRATION*/,/* MY_MAINNAME*/,/* MY_FULLNAME*/
          ,/* MY_FULLNAME_DOB*/,/* MY_ADDR*/,/* MY_LOCALE*/,/* MY_ADDRESS*/,/* MY_LIC_STATE*/
          ,/* MY_SRC*/,MyOutFile,SmallJob,Stats);
//The version online version can be used if a Roxie version of the xLNPID is available
//  HealthCareProviderHeader.MAC_Meow_LNPID_Online(myinfile,myrefence_number,/* MY_DID*/,/* MY_DOB*/,/* MY_PHONE*/,/* MY_SNAME*/
//        ,/* MY_FNAME*/,/* MY_MNAME*/,/* MY_LNAME*/,/* MY_GENDER*/,/* MY_DERIVED_GENDER*/
//        ,/* MY_LIC_NBR*/,/* MY_ADDRESS_ID*/,/* MY_PRIM_NAME*/,/* MY_PRIM_RANGE*/,/* MY_SEC_RANGE*/
//        ,/* MY_V_CITY_NAME*/,/* MY_ST*/,/* MY_ZIP*/,/* MY_CNAME*/,/* MY_TAX_ID*/
//        ,/* MY_UPIN*/,/* MY_DEA_NUMBER*/,/* MY_VENDOR_ID*/,/* MY_NPI_NUMBER*/,/* MY_DT_FIRST_SEEN*/
//        ,/* MY_DT_LAST_SEEN*/,/* MY_DT_LIC_EXPIRATION*/,/* MY_DT_DEA_EXPIRATION*/,/* MY_MAINNAME*/,/* MY_FULLNAME*/
//        ,/* MY_FULLNAME_DOB*/,/* MY_ADDR*/,/* MY_LOCALE*/,/* MY_ADDRESS*/,/* MY_LIC_STATE*/
//        ,/* MY_SRC*/,MyOutFile,Stats);
  MyOutFile;
  Stats;
