import DID_Add,header_slimsort,ut,didville,fair_isaac,gong_v2;

//master file already has did and prep attribute filtered for current records.  Doing these things once in one place to save on processing time.
gng := Gong_v2.proc_roxie_keybuild_prep_current;







export DID_Gongv2 := gng: persist('~thor_data400::persist::gongv2_did');