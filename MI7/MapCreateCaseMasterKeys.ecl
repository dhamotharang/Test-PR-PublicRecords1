

ds_concat_case_master :=  MapPrimOffenderToCaseMaster + MapAliasOffenderToCaseMaster;



Layout_CaseMaster_Offender_key := Layout_case_master_cp;

Layout_CaseMaster_Offender_key tr_generate_cama_id_key(ds_concat_case_master L, INTEGER C) := TRANSFORM
SELF.CAMA_ID := C;
SELF := L;
END;

ds_case_master_with_cama_id_key := PROJECT(ds_concat_case_master,tr_generate_cama_id_key(LEFT,COUNTER));

export MapCreateCaseMasterKeys :=  SORT(ds_case_master_with_cama_id_key,ecl_cade_id,subject_type_flg_c);

