//DF-28226: This is the delta rid key for thor_data400::key::annotated_names_qa
IMPORT dx_common;

f_base  := DATASET([],$.KeyType_BadNames);

EXPORT data_key_badnames_delta_rid := PROJECT(f_base, TRANSFORM(dx_common.layout_ridkey, SELF := LEFT));