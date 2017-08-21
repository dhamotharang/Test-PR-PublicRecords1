

ds_concat_crim_sentences :=  MapCourtOffensesToCriminalSentences + MapCrimPunishmentsToCriminalSentences;


Layout_CriminalSentences_Offender_key := Layout_criminal_sentences_cp;

Layout_CriminalSentences_Offender_key tr_generate_crse_id_key(ds_concat_crim_sentences L, INTEGER C) := TRANSFORM
SELF.CRSE_ID := C;
SELF := L;
END;

ds_crim_sentences_with_crse_key := PROJECT(ds_concat_crim_sentences,tr_generate_crse_id_key(LEFT,COUNTER));

export MapCreateCrimSentencesKeys :=  SORT(ds_crim_sentences_with_crse_key,ecl_charge_id);