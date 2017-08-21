//This is the code to execute in a builder window
#workunit('name','PRTE_Health_Facility_Services.BWR_GoExternal - External Linking Keybuild - SALT V2.9 Gold SR1');
IMPORT PRTE_Health_Facility_Services,SALT29;
PRTE_Health_Facility_Services.Proc_GoExternal;
//If you want/need to shrink your external keys a little then removing some extra credit fields can help
  Shrinkage := PRTE_Health_Facility_Services.Key_HealthFacility_ZBNAME.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_BNAME.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_SBNAME.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_ADDRESS.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_ZIP_LP.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_CITY_LP.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_PHONE_LP.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_FAX_LP.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_LIC.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_VEN.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_TAX.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_FEN.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_DEA.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_NPI.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_ADDR_NPI.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_CLIA.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_MEDICARE.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_MEDICAID.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_NCPDP.Shrinkage + PRTE_Health_Facility_Services.Key_HealthFacility_BID.Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
