IMPORT SALT311;
EXPORT Keys(DATASET(layout_HealthProvider) ih) := MODULE
SHARED keys_s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := Health_Provider_Services.Files.FILE_Spec_SF;   //'~'+'key::Health_Provider_Services::LNPID::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(keys_s,{1},{keys_s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, Health_Provider_Services.Files.File_Spec, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
END;
 
