




import crim_common;


Layout_criminal_supplimental := RECORD
  integer8 crsu_id;
  string50 assigned_judge;
  string50 referred_judge;
  string8 term_dt;
  string10 original_court_id;
  string8 arrest_dt_c;
  string8 arraign_dt_f;
  string8 first_court_dt_f;
  string8 jail_release_dt_c;
  string240 ticket_number;
  string15 arresting_agency_cd;
  string75 arresting_agency_place_c;
  string8 seized_property_number;
  string10 costs_ordered;
  string1 costs_imposed;
  string1 imprisoned_switch_flg;
  string50 commenced_by_cd;
  integer8 ecl_cade_id;
  string15 created_by;
  string8 creation_dt;
  string15 last_updated_by;
  string8 last_update_dt;
  string4 record_supplier_cd;
  string10 batch_number;
  string12 agency_case_number_f;
  string15 custodial_agency_id;
  string50 custodial_agency;
  string25 county_of_commitment_f;
  string350 custody_status;
  string40 charging_document;
  string30 judge_doc_entered_by;
  string8 judge_doc_entered_dt;
  string35 offender_legal_representer;
  string50 witness_name;
  string8 trial_dt_c;
  string8 case_served_dt;
  string4 old_record_supplier_cd;
  string15 trial_type;
  string75 warrant_info_f;
  string75 mtr_info;
  string1000 custody_info_case;
  string1000 probation_info;
  string50 custody_location;
end;


														
																												
File_CrimSupp := dataset('~thor_data400::out::crim::cross_aoc_and_county::criminal_supplimental200'+ crim_common.version_development, Layout_criminal_supplimental,
            						                                    CSV(SEPARATOR(['|#~|']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('[]')      ));		
																															
																								
output(File_CrimSupp(old_record_supplier_cd ='AZGI'),NAMED('AZGI'));
output(File_CrimSupp(old_record_supplier_cd ='AZMC'),NAMED('AZMC'));
output(File_CrimSupp(old_record_supplier_cd ='AZPI'),NAMED('AZPI'));
output(File_CrimSupp(old_record_supplier_cd ='CACO'),NAMED('CACO'));
output(File_CrimSupp(old_record_supplier_cd ='CAFR'),NAMED('CAFR'));
output(File_CrimSupp(old_record_supplier_cd ='CALA'),NAMED('CALA'));
output(File_CrimSupp(old_record_supplier_cd ='CAMA'),NAMED('CAMA'));
output(File_CrimSupp(old_record_supplier_cd ='CAOR'),NAMED('CAOR'));
output(File_CrimSupp(old_record_supplier_cd ='CARI'),NAMED('CARI'));
output(File_CrimSupp(old_record_supplier_cd ='CAIN'),NAMED('CAIN'));
output(File_CrimSupp(old_record_supplier_cd ='CABA'),NAMED('CABA'));
output(File_CrimSupp(old_record_supplier_cd ='CACL'),NAMED('CACL'));
output(File_CrimSupp(old_record_supplier_cd ='CASC'),NAMED('CASC'));
output(File_CrimSupp(old_record_supplier_cd ='CASB'),NAMED('CASB'));
output(File_CrimSupp(old_record_supplier_cd ='CASD'),NAMED('CASD'));
output(File_CrimSupp(old_record_supplier_cd ='CAVE'),NAMED('CAVE'));
output(File_CrimSupp(old_record_supplier_cd ='FLAN'),NAMED('FLAN'));
output(File_CrimSupp(old_record_supplier_cd ='FLBA'),NAMED('FLBA'));
output(File_CrimSupp(old_record_supplier_cd ='FLBR'),NAMED('FLBR'));
output(File_CrimSupp(old_record_supplier_cd ='FLBO'),NAMED('FLBO'));
output(File_CrimSupp(old_record_supplier_cd ='FLCH'),NAMED('FLCH'));
output(File_CrimSupp(old_record_supplier_cd ='FLDA'),NAMED('FLDA'));
output(File_CrimSupp(old_record_supplier_cd ='FLDU'),NAMED('FLDU'));
output(File_CrimSupp(old_record_supplier_cd ='FLHE'),NAMED('FLHE'));
output(File_CrimSupp(old_record_supplier_cd ='FLHI'),NAMED('FLHI'));
output(File_CrimSupp(old_record_supplier_cd ='FLHL'),NAMED('FLHL'));
output(File_CrimSupp(old_record_supplier_cd ='FLLE'),NAMED('FLLE'));
output(File_CrimSupp(old_record_supplier_cd ='FLLN'),NAMED('FLLN'));
output(File_CrimSupp(old_record_supplier_cd ='FLMR'),NAMED('FLMR'));
output(File_CrimSupp(old_record_supplier_cd ='FLME'),NAMED('FLME'));
output(File_CrimSupp(old_record_supplier_cd ='FLOR'),NAMED('FLOR'));
output(File_CrimSupp(old_record_supplier_cd ='FLOS'),NAMED('FLOS'));
output(File_CrimSupp(old_record_supplier_cd ='FLPB'),NAMED('FLPB'));
output(File_CrimSupp(old_record_supplier_cd ='FLPI'),NAMED('FLPI'));
output(File_CrimSupp(old_record_supplier_cd ='FLSA'),NAMED('FLSA'));
output(File_CrimSupp(old_record_supplier_cd ='GACB'),NAMED('GACB'));
output(File_CrimSupp(old_record_supplier_cd ='GAGW'),NAMED('GAGW'));
output(File_CrimSupp(old_record_supplier_cd ='ILCK'),NAMED('ILCK'));
output(File_CrimSupp(old_record_supplier_cd ='LAST'),NAMED('LAST'));
output(File_CrimSupp(old_record_supplier_cd ='MIWA'),NAMED('MIWA'));
output(File_CrimSupp(old_record_supplier_cd ='MSHN'),NAMED('MSHN'));
output(File_CrimSupp(old_record_supplier_cd ='OHLE'),NAMED('OHLE'));
output(File_CrimSupp(old_record_supplier_cd ='OHVA'),NAMED('OHVA'));
output(File_CrimSupp(old_record_supplier_cd ='OHDA'),NAMED('OHDA'));
output(File_CrimSupp(old_record_supplier_cd ='OHFL'),NAMED('OHFL'));
output(File_CrimSupp(old_record_supplier_cd ='OHNE'),NAMED('OHNE'));
output(File_CrimSupp(old_record_supplier_cd ='OHAX'),NAMED('OHAX'));
output(File_CrimSupp(old_record_supplier_cd ='OHAL'),NAMED('OHAL'));
output(File_CrimSupp(old_record_supplier_cd ='OHAT'),NAMED('OHAT'));
output(File_CrimSupp(old_record_supplier_cd ='OHBR'),NAMED('OHBR'));
output(File_CrimSupp(old_record_supplier_cd ='OHBU'),NAMED('OHBU'));
output(File_CrimSupp(old_record_supplier_cd ='OHCL'),NAMED('OHCL'));
output(File_CrimSupp(old_record_supplier_cd ='OHCT'),NAMED('OHCT'));
output(File_CrimSupp(old_record_supplier_cd ='OHCM'),NAMED('OHCM'));
output(File_CrimSupp(old_record_supplier_cd ='OHBE'),NAMED('OHBE'));
output(File_CrimSupp(old_record_supplier_cd ='OHEU'),NAMED('OHEU'));
output(File_CrimSupp(old_record_supplier_cd ='OHDE'),NAMED('OHDE'));
output(File_CrimSupp(old_record_supplier_cd ='OHFR'),NAMED('OHFR'));
output(File_CrimSupp(old_record_supplier_cd ='OHFK'),NAMED('OHFK'));
output(File_CrimSupp(old_record_supplier_cd ='OHFU'),NAMED('OHFU'));
output(File_CrimSupp(old_record_supplier_cd ='OHGR'),NAMED('OHGR'));
output(File_CrimSupp(old_record_supplier_cd ='OHXE'),NAMED('OHXE'));
output(File_CrimSupp(old_record_supplier_cd ='OHLA'),NAMED('OHLA'));
output(File_CrimSupp(old_record_supplier_cd ='OHLI'),NAMED('OHLI'));
output(File_CrimSupp(old_record_supplier_cd ='OHHU'),NAMED('OHHU'));
output(File_CrimSupp(old_record_supplier_cd ='OHKE'),NAMED('OHKE'));
output(File_CrimSupp(old_record_supplier_cd ='OHMO'),NAMED('OHMO'));
output(File_CrimSupp(old_record_supplier_cd ='OHPO'),NAMED('OHPO'));
output(File_CrimSupp(old_record_supplier_cd ='OHRO'),NAMED('OHRO'));
output(File_CrimSupp(old_record_supplier_cd ='OHRC'),NAMED('OHRC'));
output(File_CrimSupp(old_record_supplier_cd ='OHSR'),NAMED('OHSR'));
output(File_CrimSupp(old_record_supplier_cd ='OHST'),NAMED('OHST'));
output(File_CrimSupp(old_record_supplier_cd ='OHAK'),NAMED('OHAK'));
output(File_CrimSupp(old_record_supplier_cd ='OHSM'),NAMED('OHSM'));
output(File_CrimSupp(old_record_supplier_cd ='OHBA'),NAMED('OHBA'));
output(File_CrimSupp(old_record_supplier_cd ='OHTR'),NAMED('OHTR'));
output(File_CrimSupp(old_record_supplier_cd ='OHTU'),NAMED('OHTU'));
output(File_CrimSupp(old_record_supplier_cd ='OHWA'),NAMED('OHWA'));
output(File_CrimSupp(old_record_supplier_cd ='OHWR'),NAMED('OHWR'));
output(File_CrimSupp(old_record_supplier_cd ='OHMA'),NAMED('OHMA'));
output(File_CrimSupp(old_record_supplier_cd ='SCRI'),NAMED('SCRI'));
output(File_CrimSupp(old_record_supplier_cd ='TXBE'),NAMED('TXBE'));
output(File_CrimSupp(old_record_supplier_cd ='TXBR'),NAMED('TXBR'));
output(File_CrimSupp(old_record_supplier_cd ='TXCL'),NAMED('TXCL'));
output(File_CrimSupp(old_record_supplier_cd ='TXDL'),NAMED('TXDL'));
output(File_CrimSupp(old_record_supplier_cd ='TXDT'),NAMED('TXDT'));
output(File_CrimSupp(old_record_supplier_cd ='TXEP'),NAMED('TXEP'));
output(File_CrimSupp(old_record_supplier_cd ='TXFB'),NAMED('TXFB'));
output(File_CrimSupp(old_record_supplier_cd ='TXGR'),NAMED('TXGR'));
output(File_CrimSupp(old_record_supplier_cd ='TXHR'),NAMED('TXHR'));
output(File_CrimSupp(old_record_supplier_cd ='TXJE'),NAMED('TXJE'));
output(File_CrimSupp(old_record_supplier_cd ='TXJO'),NAMED('TXJO'));
output(File_CrimSupp(old_record_supplier_cd ='TXMD'),NAMED('TXMD'));
output(File_CrimSupp(old_record_supplier_cd ='TXMG'),NAMED('TXMG'));
output(File_CrimSupp(old_record_supplier_cd ='TXPO'),NAMED('TXPO'));
output(File_CrimSupp(old_record_supplier_cd ='TXVC'),NAMED('TXVC'));
output(File_CrimSupp(old_record_supplier_cd ='VAFA'),NAMED('VAFA'));
    




  output(MIN(File_CrimSupp,crsu_id));
	output(MIN(File_CrimSupp,ecl_cade_id));

  output(MAX(File_CrimSupp,crsu_id));
	output(MAX(File_CrimSupp,ecl_cade_id));
	
	output(File_CrimSupp(crsu_id = 0));
	output(File_CrimSupp(ecl_cade_id = 0));


