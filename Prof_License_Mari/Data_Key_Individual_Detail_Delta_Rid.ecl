IMPORT dx_common;

//DF-28229: This is the delta rid key for thor_data400::base::proflic_mari::individual_detail
f_base  := DATASET([],Prof_License_Mari.layouts.Individual_Reg_Base);

EXPORT Data_Key_Individual_Detail_Delta_Rid := PROJECT(f_base, TRANSFORM(dx_common.layout_ridkey, SELF := LEFT));
