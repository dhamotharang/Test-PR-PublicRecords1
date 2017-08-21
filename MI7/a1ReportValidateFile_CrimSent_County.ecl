



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
												

																													
 File_CrimSent := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_sentences200'+ crim_common.version_development, Layout_CriminalSentences,
            						                              CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		


output(File_CrimSent(old_record_supplier_cd ='AZGI'),NAMED('AZGI'));
output(File_CrimSent(old_record_supplier_cd ='AZMC'),NAMED('AZMC'));
output(File_CrimSent(old_record_supplier_cd ='AZPI'),NAMED('AZPI'));
output(File_CrimSent(old_record_supplier_cd ='CACO'),NAMED('CACO'));
output(File_CrimSent(old_record_supplier_cd ='CAFR'),NAMED('CAFR'));
output(File_CrimSent(old_record_supplier_cd ='CALA'),NAMED('CALA'));
output(File_CrimSent(old_record_supplier_cd ='CAMA'),NAMED('CAMA'));
output(File_CrimSent(old_record_supplier_cd ='CAOR'),NAMED('CAOR'));
output(File_CrimSent(old_record_supplier_cd ='CARI'),NAMED('CARI'));
output(File_CrimSent(old_record_supplier_cd ='CAIN'),NAMED('CAIN'));
output(File_CrimSent(old_record_supplier_cd ='CABA'),NAMED('CABA'));
output(File_CrimSent(old_record_supplier_cd ='CACL'),NAMED('CACL'));
output(File_CrimSent(old_record_supplier_cd ='CASC'),NAMED('CASC'));
output(File_CrimSent(old_record_supplier_cd ='CASB'),NAMED('CASB'));
output(File_CrimSent(old_record_supplier_cd ='CASD'),NAMED('CASD'));
output(File_CrimSent(old_record_supplier_cd ='CAVE'),NAMED('CAVE'));
output(File_CrimSent(old_record_supplier_cd ='FLAN'),NAMED('FLAN'));
output(File_CrimSent(old_record_supplier_cd ='FLBA'),NAMED('FLBA'));
output(File_CrimSent(old_record_supplier_cd ='FLBR'),NAMED('FLBR'));
output(File_CrimSent(old_record_supplier_cd ='FLBO'),NAMED('FLBO'));
output(File_CrimSent(old_record_supplier_cd ='FLCH'),NAMED('FLCH'));
output(File_CrimSent(old_record_supplier_cd ='FLDA'),NAMED('FLDA'));
output(File_CrimSent(old_record_supplier_cd ='FLDU'),NAMED('FLDU'));
output(File_CrimSent(old_record_supplier_cd ='FLHE'),NAMED('FLHE'));
output(File_CrimSent(old_record_supplier_cd ='FLHI'),NAMED('FLHI'));
output(File_CrimSent(old_record_supplier_cd ='FLHL'),NAMED('FLHL'));
output(File_CrimSent(old_record_supplier_cd ='FLLE'),NAMED('FLLE'));
output(File_CrimSent(old_record_supplier_cd ='FLLN'),NAMED('FLLN'));
output(File_CrimSent(old_record_supplier_cd ='FLMR'),NAMED('FLMR'));
output(File_CrimSent(old_record_supplier_cd ='FLME'),NAMED('FLME'));
output(File_CrimSent(old_record_supplier_cd ='FLOR'),NAMED('FLOR'));
output(File_CrimSent(old_record_supplier_cd ='FLOS'),NAMED('FLOS'));
output(File_CrimSent(old_record_supplier_cd ='FLPB'),NAMED('FLPB'));
output(File_CrimSent(old_record_supplier_cd ='FLPI'),NAMED('FLPI'));
output(File_CrimSent(old_record_supplier_cd ='FLSA'),NAMED('FLSA'));
output(File_CrimSent(old_record_supplier_cd ='GACB'),NAMED('GACB'));
output(File_CrimSent(old_record_supplier_cd ='GAGW'),NAMED('GAGW'));
output(File_CrimSent(old_record_supplier_cd ='ILCK'),NAMED('ILCK'));
output(File_CrimSent(old_record_supplier_cd ='LAST'),NAMED('LAST'));
output(File_CrimSent(old_record_supplier_cd ='MIWA'),NAMED('MIWA'));
output(File_CrimSent(old_record_supplier_cd ='MSHN'),NAMED('MSHN'));
output(File_CrimSent(old_record_supplier_cd ='OHLE'),NAMED('OHLE'));
output(File_CrimSent(old_record_supplier_cd ='OHVA'),NAMED('OHVA'));
output(File_CrimSent(old_record_supplier_cd ='OHDA'),NAMED('OHDA'));
output(File_CrimSent(old_record_supplier_cd ='OHFL'),NAMED('OHFL'));
output(File_CrimSent(old_record_supplier_cd ='OHNE'),NAMED('OHNE'));
output(File_CrimSent(old_record_supplier_cd ='OHAX'),NAMED('OHAX'));
output(File_CrimSent(old_record_supplier_cd ='OHAL'),NAMED('OHAL'));
output(File_CrimSent(old_record_supplier_cd ='OHAT'),NAMED('OHAT'));
output(File_CrimSent(old_record_supplier_cd ='OHBR'),NAMED('OHBR'));
output(File_CrimSent(old_record_supplier_cd ='OHBU'),NAMED('OHBU'));
output(File_CrimSent(old_record_supplier_cd ='OHCL'),NAMED('OHCL'));
output(File_CrimSent(old_record_supplier_cd ='OHCT'),NAMED('OHCT'));
output(File_CrimSent(old_record_supplier_cd ='OHCM'),NAMED('OHCM'));
output(File_CrimSent(old_record_supplier_cd ='OHBE'),NAMED('OHBE'));
output(File_CrimSent(old_record_supplier_cd ='OHEU'),NAMED('OHEU'));
output(File_CrimSent(old_record_supplier_cd ='OHDE'),NAMED('OHDE'));
output(File_CrimSent(old_record_supplier_cd ='OHFR'),NAMED('OHFR'));
output(File_CrimSent(old_record_supplier_cd ='OHFK'),NAMED('OHFK'));
output(File_CrimSent(old_record_supplier_cd ='OHFU'),NAMED('OHFU'));
output(File_CrimSent(old_record_supplier_cd ='OHGR'),NAMED('OHGR'));
output(File_CrimSent(old_record_supplier_cd ='OHXE'),NAMED('OHXE'));
output(File_CrimSent(old_record_supplier_cd ='OHLA'),NAMED('OHLA'));
output(File_CrimSent(old_record_supplier_cd ='OHLI'),NAMED('OHLI'));
output(File_CrimSent(old_record_supplier_cd ='OHHU'),NAMED('OHHU'));
output(File_CrimSent(old_record_supplier_cd ='OHKE'),NAMED('OHKE'));
output(File_CrimSent(old_record_supplier_cd ='OHMO'),NAMED('OHMO'));
output(File_CrimSent(old_record_supplier_cd ='OHPO'),NAMED('OHPO'));
output(File_CrimSent(old_record_supplier_cd ='OHRO'),NAMED('OHRO'));
output(File_CrimSent(old_record_supplier_cd ='OHRC'),NAMED('OHRC'));
output(File_CrimSent(old_record_supplier_cd ='OHSR'),NAMED('OHSR'));
output(File_CrimSent(old_record_supplier_cd ='OHST'),NAMED('OHST'));
output(File_CrimSent(old_record_supplier_cd ='OHAK'),NAMED('OHAK'));
output(File_CrimSent(old_record_supplier_cd ='OHSM'),NAMED('OHSM'));
output(File_CrimSent(old_record_supplier_cd ='OHBA'),NAMED('OHBA'));
output(File_CrimSent(old_record_supplier_cd ='OHTR'),NAMED('OHTR'));
output(File_CrimSent(old_record_supplier_cd ='OHTU'),NAMED('OHTU'));
output(File_CrimSent(old_record_supplier_cd ='OHWA'),NAMED('OHWA'));
output(File_CrimSent(old_record_supplier_cd ='OHWR'),NAMED('OHWR'));
output(File_CrimSent(old_record_supplier_cd ='OHMA'),NAMED('OHMA'));
output(File_CrimSent(old_record_supplier_cd ='SCRI'),NAMED('SCRI'));
output(File_CrimSent(old_record_supplier_cd ='TXBE'),NAMED('TXBE'));
output(File_CrimSent(old_record_supplier_cd ='TXBR'),NAMED('TXBR'));
output(File_CrimSent(old_record_supplier_cd ='TXCL'),NAMED('TXCL'));
output(File_CrimSent(old_record_supplier_cd ='TXDL'),NAMED('TXDL'));
output(File_CrimSent(old_record_supplier_cd ='TXDT'),NAMED('TXDT'));
output(File_CrimSent(old_record_supplier_cd ='TXEP'),NAMED('TXEP'));
output(File_CrimSent(old_record_supplier_cd ='TXFB'),NAMED('TXFB'));
output(File_CrimSent(old_record_supplier_cd ='TXGR'),NAMED('TXGR'));
output(File_CrimSent(old_record_supplier_cd ='TXHR'),NAMED('TXHR'));
output(File_CrimSent(old_record_supplier_cd ='TXJE'),NAMED('TXJE'));
output(File_CrimSent(old_record_supplier_cd ='TXJO'),NAMED('TXJO'));
output(File_CrimSent(old_record_supplier_cd ='TXMD'),NAMED('TXMD'));
output(File_CrimSent(old_record_supplier_cd ='TXMG'),NAMED('TXMG'));
output(File_CrimSent(old_record_supplier_cd ='TXPO'),NAMED('TXPO'));
output(File_CrimSent(old_record_supplier_cd ='TXVC'),NAMED('TXVC'));
output(File_CrimSent(old_record_supplier_cd ='VAFA'),NAMED('VAFA'));
	
  output(MIN(File_CrimSent,crse_id));
  output(MIN(File_CrimSent,ecl_charge_id));
	
  output(MAX(File_CrimSent,crse_id));
	output(MAX(File_CrimSent,ecl_charge_id));
	
	output(File_CrimSent(crse_id= 0));
	output(File_CrimSent(ecl_charge_id= 0));