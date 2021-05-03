IMPORT SALT311;
EXPORT Keys(DATASET(layout_InsuranceHeader) ih, BOOLEAN incremental = FALSE) := MODULE
SHARED keys_s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName :=  KeyPrefix +  'key::InsuranceHeader_xLink'+'::'+Config.KeyInfix+'::DID::Debug::specificities_debug'; /*HACK50*/
 
EXPORT SpecificitiesDebugKeyName_sf:= KeyPrefix +  'key::InsuranceHeader_xLink'+'::'+Config.KeySuperfile+'::DID::Debug::specificities_debug'; /*HACK51*/
s0 := IF(~incremental, keys_s);
 
EXPORT Specificities_Key := INDEX(s0,{1},{s0},SpecificitiesDebugKeyName_sf);
 
EXPORT Assign_SpecificitiesDebugKeyNameToSuperFile := FileServices.AddSuperFile(SpecificitiesDebugKeyName_sf,SpecificitiesDebugKeyName);
 
EXPORT Clear_SpecificitiesDebugKeyNameSuperFile := SEQUENTIAL(FileServices.CreateSuperFile(SpecificitiesDebugKeyName_sf,,TRUE),FileServices.ClearSuperFile(SpecificitiesDebugKeyName_sf));
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, SpecificitiesDebugKeyName, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
END;
 
