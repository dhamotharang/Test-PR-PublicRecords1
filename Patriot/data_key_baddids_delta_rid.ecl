//DF-28226: This is the delta rid for thor_data400::key::baddids_qa
IMPORT dx_common;

f_base  := DATASET([],$.KeyType_BadDids);

EXPORT data_key_baddids_delta_rid := PROJECT(f_base, TRANSFORM(dx_common.layout_ridkey, SELF := LEFT));

