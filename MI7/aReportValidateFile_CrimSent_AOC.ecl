
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
												

																													
 File_CrimSent := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_sentences'+ crim_common.version_development, Layout_CriminalSentences,
            						                              CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		

output(File_CrimSent(old_record_supplier_cd ='AKCR'),NAMED('AKCR'));
output(File_CrimSent(old_record_supplier_cd ='ARCR'),NAMED('ARCR'));
output(File_CrimSent(old_record_supplier_cd ='AZCR'),NAMED('AZCR'));
output(File_CrimSent(old_record_supplier_cd ='CTCR'),NAMED('CTCR'));
output(File_CrimSent(old_record_supplier_cd ='FLCR'),NAMED('FLCR'));
output(File_CrimSent(old_record_supplier_cd ='GAGB'),NAMED('GAGB'));    
output(File_CrimSent(old_record_supplier_cd ='IAOC'),NAMED('IAOC'));
output(File_CrimSent(old_record_supplier_cd ='INCR'),NAMED('INCR'));
    
output(File_CrimSent(old_record_supplier_cd ='MOCR'),NAMED('MOCR'));
output(File_CrimSent(old_record_supplier_cd ='NCCR'),NAMED('NCCR'));
output(File_CrimSent(old_record_supplier_cd ='NDCR'),NAMED('NDCR'));
output(File_CrimSent(old_record_supplier_cd ='NJCR'),NAMED('NJCR'));
    
output(File_CrimSent(old_record_supplier_cd ='OKCR'),NAMED('OKCR'));
output(File_CrimSent(old_record_supplier_cd ='ORCR'),NAMED('ORCR'));
output(File_CrimSent(old_record_supplier_cd ='PACR'),NAMED('PACR'));
output(File_CrimSent(old_record_supplier_cd ='PACP'),NAMED('PACP'));
output(File_CrimSent(old_record_supplier_cd ='RICR'),NAMED('RICR'));
output(File_CrimSent(old_record_supplier_cd ='RITR'),NAMED('RITR'));
output(File_CrimSent(old_record_supplier_cd ='TNCR'),NAMED('TNCR'));
output(File_CrimSent(old_record_supplier_cd ='TXDP'),NAMED('TXDP'));
output(File_CrimSent(old_record_supplier_cd ='UTCR'),NAMED('UTCR'));
output(File_CrimSent(old_record_supplier_cd ='VACR'),NAMED('VACR'));
output(File_CrimSent(old_record_supplier_cd ='WICR'),NAMED('WICR'));

output(File_CrimSent(old_record_supplier_cd ='HICR'),NAMED('HICR'));
output(File_CrimSent(old_record_supplier_cd ='MDCR'),NAMED('MDCR'));
output(File_CrimSent(old_record_supplier_cd ='NMCR'),NAMED('NMCR'));
	
	
  output(MIN(File_CrimSent,crse_id));
  output(MIN(File_CrimSent,ecl_charge_id));
	
  output(MAX(File_CrimSent,crse_id));
	output(MAX(File_CrimSent,ecl_charge_id));
	
	
	output(File_CrimSent(ecl_charge_id= 0));