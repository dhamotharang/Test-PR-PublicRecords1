EXPORT Keys(DATASET(layout_BizHead) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+'key::BizLinkFull::proxid::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;
END;
 
