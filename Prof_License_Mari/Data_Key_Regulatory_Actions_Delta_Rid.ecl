IMPORT dx_common;

//DF-28229: This is the delta rid key for thor_data400::base::proflic_mari::regulatory_actions
f_base  := DATASET([],Prof_License_Mari.layouts.Regulatory_Action_Base);

EXPORT Data_Key_Regulatory_Actions_Delta_Rid := PROJECT(f_base, TRANSFORM(dx_common.layout_ridkey, SELF := LEFT));
