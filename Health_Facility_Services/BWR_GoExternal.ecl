//This is the code to execute in a builder window
#workunit('name','Health_Facility_Services.BWR_GoExternal - External Linking Keybuild - SALT V2.9 Gold SR1');
IMPORT Health_Facility_Services,SALT29;
Health_Facility_Services.Proc_GoExternal;
//If you want/need to shrink your external keys a little then removing some extra credit fields can help
  Shrinkage := Health_Facility_Services.Key_HealthFacility_ZBNAME.Shrinkage + Health_Facility_Services.Key_HealthFacility_BNAME.Shrinkage + Health_Facility_Services.Key_HealthFacility_SBNAME.Shrinkage + Health_Facility_Services.Key_HealthFacility_ADDRESS.Shrinkage + Health_Facility_Services.Key_HealthFacility_ZIP_LP.Shrinkage + Health_Facility_Services.Key_HealthFacility_CITY_LP.Shrinkage + Health_Facility_Services.Key_HealthFacility_PHONE_LP.Shrinkage + Health_Facility_Services.Key_HealthFacility_FAX_LP.Shrinkage + Health_Facility_Services.Key_HealthFacility_LIC.Shrinkage + Health_Facility_Services.Key_HealthFacility_VEN.Shrinkage + Health_Facility_Services.Key_HealthFacility_TAX.Shrinkage + Health_Facility_Services.Key_HealthFacility_FEN.Shrinkage + Health_Facility_Services.Key_HealthFacility_DEA.Shrinkage + Health_Facility_Services.Key_HealthFacility_NPI.Shrinkage + Health_Facility_Services.Key_HealthFacility_ADDR_NPI.Shrinkage + Health_Facility_Services.Key_HealthFacility_CLIA.Shrinkage + Health_Facility_Services.Key_HealthFacility_MEDICARE.Shrinkage + Health_Facility_Services.Key_HealthFacility_MEDICAID.Shrinkage + Health_Facility_Services.Key_HealthFacility_NCPDP.Shrinkage + Health_Facility_Services.Key_HealthFacility_BID.Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
