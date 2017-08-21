
import crim_common;

Layout_CriminalSentences := RECORD
  integer8 crse_id;
  string10 sentence_amt_c;
  string2000 sentence_comment_c;
  integer8 ecl_charge_id;
  string2 sety_sentence_type_cd_c;
  string15 created_by;
  string8 creation_dt;
  string15 last_updated_by;
  string8 last_update_dt;
  string4 record_supplier_cd;
  string10 batch_number;
  string4 old_record_supplier_cd;
end;
       

File_CrimSent := dataset('~thor_data400::out::crim_cp_ln::criminal_sentences_shadow_load'+ crim_common.version_development, Layout_CriminalSentences,
            						                                      CSV(heading(1),SEPARATOR(['|','|\'']), TERMINATOR(['\n','\r\n','\n\r'])));																															
 
 
// export bCriminalSentencesMaxKey :=  MAX(File_CrimSent,crse_id)
                                                            // : persist ('~thor_data400::persist::out::crim::cross::criminal_sentence_max_key');	
																												
export bCriminalSentencesMaxKey :=  8514602137; //8500000000;
																						

