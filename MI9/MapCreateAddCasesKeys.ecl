

Layout_additional_cases_Offender_key := Layout_additional_cases_cp;

Layout_additional_cases_Offender_key tr_generate_adca_id_key(MapOffenderToAdditionalCases L, INTEGER C) := TRANSFORM
SELF.ADCA_ID := C;
SELF := L;
END;

ds_crim_sentences_with_adca_key := PROJECT(MapOffenderToAdditionalCases,tr_generate_adca_id_key(LEFT,COUNTER));

export MapCreateAddCasesKeys :=  SORT(ds_crim_sentences_with_adca_key,ecl_cade_id);