﻿IMPORT dx_common;

//DF-28229: This is the delta rid key for thor_data400::base::proflic_mari::base
f_base  := DATASET([],Prof_License_Mari.layouts.Disciplinary_Action_Base);

EXPORT Data_Key_Disciplinary_Actions_Delta_Rid := PROJECT(f_base, TRANSFORM(dx_common.layout_ridkey, SELF := LEFT));
