

Layout_CriminalSentences_Offender_key := Layout_criminal_sentences_cp;

Layout_CriminalSentences_Offender_key tr_generate_crse_id_key(MapCourtOffensesToCriminalSentences L, INTEGER C) := TRANSFORM
SELF.CRSE_ID := C;
SELF := L;
END;

ds_crim_sentences_with_crse_key := PROJECT(MapCourtOffensesToCriminalSentences,tr_generate_crse_id_key(LEFT,COUNTER));

export MapCreateCrimSentencesKeys :=  SORT(ds_crim_sentences_with_crse_key,ecl_charge_id);