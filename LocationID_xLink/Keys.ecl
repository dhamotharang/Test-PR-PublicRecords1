EXPORT Keys(DATASET(layout_LocationId) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::Debug::specificities_debug';
 
EXPORT SpecificitiesDebugKeyName_sf := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
END;
 
