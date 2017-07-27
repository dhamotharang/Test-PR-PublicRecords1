EXPORT Keys(DATASET(layout_InsuranceHeader) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeyInfix+'::DID::Debug::specificities_debug';
 
EXPORT SpecificitiesDebugKeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
END;
 
