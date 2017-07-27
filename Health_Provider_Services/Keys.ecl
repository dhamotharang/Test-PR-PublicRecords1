EXPORT Keys(DATASET(layout_HealthProvider) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
EXPORT SpecificitiesDebugKeyName := Health_Provider_Services.Files.FILE_Spec_SF; //'~'+'key::Health_Provider_Services::LNPID::Debug::specificities_debug';
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, Health_Provider_Services.Files.File_Spec, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
END;
