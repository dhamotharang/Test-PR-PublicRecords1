EXPORT Keys(DATASET(layout_HealthFacility) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
EXPORT SpecificitiesDebugKeyName := Health_Facility_Services.Files.FILE_Spec_SF; // '~'+'key::Health_Facility_Services::LNPID::Debug::specificities_debug';
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, Health_Facility_Services.Files.FILE_Spec, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
END;
