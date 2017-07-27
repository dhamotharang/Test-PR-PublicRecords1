import ut, RoxieKeyBuild;
BaseK := Process_xLNPID_Layouts.BuildAll;
BKB := BUILDINDEX(Key_HealthFacility_.Key,Health_Facility_Services.Files.FILE_Header_Refs,OVERWRITE);
BKBV := BUILDINDEX(Key_HealthFacility_.ValueKey,Health_Facility_Services.Files.FILE_Header_Words,OVERWRITE);
BK0 := BUILDINDEX(Key_HealthFacility_ZBNAME.Key,Health_Facility_Services.Files.FILE_BName_Zip,OVERWRITE);
BK1 := BUILDINDEX(Key_HealthFacility_SBNAME.Key,Health_Facility_Services.Files.FILE_BName_St,OVERWRITE);
BK2 := BUILDINDEX(Key_HealthFacility_BNAME.Key,Health_Facility_Services.Files.FILE_BName,OVERWRITE);
BK3 := BUILDINDEX(Key_HealthFacility_ADDRESS.Key,Health_Facility_Services.Files.FILE_Address,OVERWRITE);
BK4 := BUILDINDEX(Key_HealthFacility_ZIP_LP.Key,Health_Facility_Services.Files.FILE_ZIP,OVERWRITE);
BK5 := BUILDINDEX(Key_HealthFacility_CITY_LP.Key,Health_Facility_Services.Files.FILE_City,OVERWRITE);
BK6 := BUILDINDEX(Key_HealthFacility_PHONE_LP.Key,Health_Facility_Services.Files.FILE_PHONE,OVERWRITE);
BK7 := BUILDINDEX(Key_HealthFacility_LIC.Key,Health_Facility_Services.Files.FILE_LIC,OVERWRITE);
BK8 := BUILDINDEX(Key_HealthFacility_VEN.Key,Health_Facility_Services.Files.FILE_VendorID,OVERWRITE);
BK9 := BUILDINDEX(Key_HealthFacility_TAX.Key,Health_Facility_Services.Files.FILE_Tax,OVERWRITE);
BK10 := BUILDINDEX(Key_HealthFacility_FEN.Key,Health_Facility_Services.Files.FILE_Fein,OVERWRITE);
BK11 := BUILDINDEX(Key_HealthFacility_DEA.Key,Health_Facility_Services.Files.FILE_DEA,OVERWRITE);
BK12 := BUILDINDEX(Key_HealthFacility_NPI.Key,Health_Facility_Services.Files.FILE_NPI,OVERWRITE);
BK13 := BUILDINDEX(Key_HealthFacility_BID.Key,Health_Facility_Services.Files.FILE_BDID,OVERWRITE);
WBK1 := BUILDINDEX(specificities(File_HealthFacility).CNP_NAME_values_key,Health_Facility_Services.Files.FILE_BName_Values,OVERWRITE);
EXPORT Proc_GoExternal := PARALLEL(Keys(HealthCareFacility.Files.Facility_Header_DS).BuildAll,BaseK,BKB,BKBV,BK0,BK1,BK2,BK3,BK4,BK5,BK6,BK7,BK8,BK9,BK10,BK11,BK12,BK13,WBK1);


