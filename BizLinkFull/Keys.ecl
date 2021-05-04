IMPORT SALT44;
EXPORT Keys(DATASET(layout_BizHead) ih) := MODULE
SHARED keys_s := Specificities(ih).Specificities;

EXPORT SpecificitiesDebugKeyName := '~'+'key::BizLinkFull::proxid::Debug::specificities_debug';

EXPORT Specificities_Key := INDEX(keys_s,{1},{keys_s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
EXPORT BuildAll := Build_Specificities_Key;

END;
