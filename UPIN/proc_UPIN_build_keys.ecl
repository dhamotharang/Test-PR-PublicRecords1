import UPIN;

build_DID_key  := buildindex(UPIN.key_UPIN_DID, overwrite);

build_name_key := buildindex(UPIN.key_UPIN_ST_NAME, overwrite);

build_upin_key := buildindex(UPIN.key_UPIN, overwrite);



export proc_UPIN_build_keys := sequential(build_DID_key,build_name_key,build_upin_key);