BaseK := Process_xLNPID_Layouts.BuildAll;
BKB := BUILDINDEX(Key_HealthFacility_.Key,OVERWRITE);
BKBV := BUILDINDEX(Key_HealthFacility_.ValueKey,OVERWRITE);
BK0 := BUILDINDEX(Key_HealthFacility_ZBNAME.Key,OVERWRITE);
BK1 := BUILDINDEX(Key_HealthFacility_BNAME.Key,OVERWRITE);
BK2 := BUILDINDEX(Key_HealthFacility_SBNAME.Key,OVERWRITE);
BK3 := BUILDINDEX(Key_HealthFacility_ADDRESS.Key,OVERWRITE);
BK4 := BUILDINDEX(Key_HealthFacility_ZIP_LP.Key,OVERWRITE);
BK5 := BUILDINDEX(Key_HealthFacility_CITY_LP.Key,OVERWRITE);
BK6 := BUILDINDEX(Key_HealthFacility_PHONE_LP.Key,OVERWRITE);
BK7 := BUILDINDEX(Key_HealthFacility_FAX_LP.Key,OVERWRITE);
BK8 := BUILDINDEX(Key_HealthFacility_LIC.Key,OVERWRITE);
BK9 := BUILDINDEX(Key_HealthFacility_VEN.Key,OVERWRITE);
BK10 := BUILDINDEX(Key_HealthFacility_TAX.Key,OVERWRITE);
BK11 := BUILDINDEX(Key_HealthFacility_FEN.Key,OVERWRITE);
BK12 := BUILDINDEX(Key_HealthFacility_DEA.Key,OVERWRITE);
BK13 := BUILDINDEX(Key_HealthFacility_NPI.Key,OVERWRITE);
BK14 := BUILDINDEX(Key_HealthFacility_ADDR_NPI.Key,OVERWRITE);
BK15 := BUILDINDEX(Key_HealthFacility_CLIA.Key,OVERWRITE);
BK16 := BUILDINDEX(Key_HealthFacility_MEDICARE.Key,OVERWRITE);
BK17 := BUILDINDEX(Key_HealthFacility_MEDICAID.Key,OVERWRITE);
BK18 := BUILDINDEX(Key_HealthFacility_NCPDP.Key,OVERWRITE);
BK19 := BUILDINDEX(Key_HealthFacility_BID.Key,OVERWRITE);
WBK1 := BUILDINDEX(specificities(File_HealthFacility).CNP_NAME_values_key,OVERWRITE);
EXPORT Proc_GoExternal := PARALLEL(Keys(File_HealthFacility).BuildAll,BaseK,BKB,BKBV,BK0,BK1,BK2,BK3,BK4,BK5,BK6,BK7,BK8,BK9,BK10,BK11,BK12,BK13,BK14,BK15,BK16,BK17,BK18,BK19,WBK1);
