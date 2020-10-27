//DF-28226: This is the delta rid key for thor_data400::in::patriot_file
IMPORT dx_common;

f_base  := DATASET([],$.Layout_Patriot_addressid);

EXPORT data_key_patriot_delta_rid := PROJECT(f_base, TRANSFORM(dx_common.layout_ridkey, SELF := LEFT));
