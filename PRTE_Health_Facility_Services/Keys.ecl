EXPORT Keys(DATASET(layout_HealthFacility) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
EXPORT SpecificitiesDebugKeyName := PRTE_Health_Facility_Services.Files.FILE_Spec; // '~'+'key::PRTE_Health_Facility_Services::LNPID::Debug::specificities_debug';
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, PRTE_Health_Facility_Services.Files.FILE_Spec,OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
END;
