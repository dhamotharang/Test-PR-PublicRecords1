EXPORT Keys(DATASET(layout_Classify_PS) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::Debug::specificities_debug';
 
EXPORT SpecificitiesDebugKeyName_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
EXPORT RelationshipKeys := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
END;
 
