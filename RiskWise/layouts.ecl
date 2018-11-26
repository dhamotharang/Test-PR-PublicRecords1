/*2016-05-21T00:50:26Z (Kevin Huls)
RQ-12730: Emerging Identities
*/
/*2016-05-18T19:05:55Z (Kevin Huls)
RQ-12730: Emerging Identities
*/
IMPORT Risk_Indicators, doxie;

export layouts := module 

export header_temp := record
	string shell_converted_source;
	string address_type;  // flag to tell whether the address is input, current, or previous
	recordof(doxie.Key_Header);
end;

export layout_cdci := record
	unsigned4 seq := 0;
	string30 account := '';
	string1  ordertype := '';
	
	string30 cmpy := '';
	string1  cmpytype := '';
	string15 first := '';
	string20 last := '';
	string50 in_addr := '';
	string in_locality := '';
	string in_province := '';
	string in_postalcode := '';
	
	string prim_range := '';
	string dir := '';
	string prim_name := '';
	string addr_suffix := '';
	string unit_desig := '';
	string sec_range := '';
	string locality := '';
	string province := '';
	string postalcode := '';
	string addr_type := '';
	string language := '';
	string addr_status := '';
	string addrvalflag := '';
	
	string10 hphone := '';
	string10 wphone := '';
	string50 email := '';
	string45 ipaddr := '';

	string30 cmpy2 := '';
	string15 first2 := '';  
	string20 last2 := '';
	string50 in_addr2 := '';
	string in_locality2 := '';
	string in_province2 := '';
	string in_postalcode2 := '';
	string prim_range2 := '';
	string dir2 := '';
	string prim_name2 := '';
	string addr_suffix2 := '';
	string unit_desig2 := '';
	string sec_range2 := '';
	string locality2 := '';
	string province2 := '';
	string postalcode2 := '';
	string addr_type2 := '';
	string language2 := '';
	string addr_status2 := '';
	string addrvalflag2 := '';
	
	string10 hphone2 := '';
	
	string1  avscode := '';
	string2  channel := '';
	string2  channel2 := '';
	string6  orderamt := '';
	string3  numitems := '';
	string8  orderdate := '';
	string4  cidcode := '';
	string2  shipmode := '';
	string2  pymtmethod := '';
	string2  prodcode := '';
end;

export layout_cdco := record
	STRING30 account := '';
	STRING32 riskwiseid := '';
	STRING3  score := '';
	STRING3  score2 := '';
	STRING3  score3 := '';
	STRING2  reason := '';
	STRING2  reason2 := '';
	STRING2  reason3 := '';
	STRING2  reason4 := '';
	STRING2  reason5 := '';
	STRING2  reason6 := '';
	STRING2  phoneverlevel := '';
	STRING2  cmpyphoneverlevel := '';
	STRING20 correctlast := '';
	STRING30 correctcmpyname := '';
	STRING10 correcthphone := '';
	STRING50 correctaddr := '';
	STRING15 verfirst := '';
	STRING20 verlast := '';
	STRING50 veraddr := '';
	STRING30 verlocality := '';
	STRING2  verprovince := '';
	STRING9  verpostcode := '';
	STRING10 nameaddrphone := '';
	STRING1  hphonetypeflag := '';
	STRING1  wphonetypeflag := '';
	STRING1  ipcontinent := '';
	STRING2  ipcountry := '';
	STRING2  iproutingtype := '';
	STRING2  ipprovince := '';
	STRING10 topleveldomain := '';
    STRING67 secondleveldomain := '';
	STRING2  reason7 := '';
	STRING2  reason8 := '';
	STRING2  reason9 := '';
	STRING2  reason10 := '';
	STRING2  reason11 := '';
	STRING2  reason12 := '';
	STRING2  phoneverlevel2 := '';
	STRING2 cmpyphoneverlevel2 := '';
	STRING20 correctlast2 := '';
	STRING30 correctcmpyname2 := '';
	STRING10 correchphone2 := '';
	STRING50 correctaddr2 := '';
	STRING15 verfirst2 := '';
	STRING20 verlast2 := '';
	STRING50 veraddr2 := '';
	STRING30 verlocality2 := '';
	STRING2  verprovince2 := '';
	STRING9  verpostcode2 := '';
	STRING10 nameaddrphone2 := '';
	STRING1  hphonetypeflag2 := '';
end;

// todo: add field lengths to all strings
export canada_nap_calc := record
	string nxx_type;
	string phonetype;
	string phonevalflag;
	
	integer phone_firstscore;
	integer phone_lastscore;
	integer phone_addrscore;
	integer phone_phonescore;
	integer phone_firstcount;
	integer phone_lastcount;
	integer phone_addrcount;
	integer phone_phonecount;
	string phone_LASTNAME;
	string phone_FIRSTNAME;
	string phone_PHONENUMBER;
	string phone_STREETADDR;
	string phone_POSTALCITY;
	string phone_PROVINCE;
	string phone_POSTALCODE;
	integer phone_NAP_level;
	
	integer addr_firstscore;
	integer addr_lastscore;
	integer addr_addrscore;
	integer addr_phonescore;
	integer addr_firstcount;
	integer addr_lastcount;
	integer addr_addrcount;
	integer addr_phonecount;
	string addr_LASTNAME;
	string addr_FIRSTNAME;
	string addr_PHONENUMBER;
	string addr_STREETADDR;
	string addr_POSTALCITY;
	string addr_PROVINCE;
	string addr_POSTALCODE;
	integer addr_NAP_level;
	
	integer combo_firstscore;
	integer combo_lastscore;
	integer combo_addrscore;
	integer combo_phonescore;
	integer combo_firstcount;
	integer combo_lastcount;
	integer combo_addrcount;
	integer combo_hphonecount;
	string combo_LASTNAME;
	string combo_FIRSTNAME;
	string combo_PHONENUMBER;
	string combo_STREETADDR;
	string combo_POSTALCITY;
	string combo_PROVINCE;
	string combo_POSTALCODE;
	integer combo_NAP_level;
	
	string corrected_hphone;
	string corrected_address;
	string corrected_last;
end;

export cdn706_variables := record
	layout_cdci indata;
	risk_indicators.layout_eddo eddo;
	riskwise.Layout_IP2O ip_results;
	canada_nap_calc btnap_calc;
	canada_nap_calc stnap_calc;
	integer score;
	dataset(risk_indicators.Layout_Desc) bt_reasons;
	dataset(risk_indicators.Layout_Desc) st_reasons;
end;

export reasoncode_settings := RECORD
	boolean IsInstantID := false;
	unsigned1 IIDVersion := 0;
	boolean EnableEmergingID := false;
	boolean IsIdentifier2 := false;
	boolean ischase := False;// reason codes for chase custom model
	boolean verfirst_chase := False;// reason codes for chase custom model
	boolean verlast_chase := False;// reason codes for chase custom model
	boolean veraddr_chase := False;// reason codes for chase custom model

end;

export actioncode_settings := RECORD
	boolean IsPOBoxCompliant := false;
	boolean IsInstantID := false;
end;


export Layout_Watercraft := RECORD
                unsigned1 watercraft_count := 0;
                unsigned1 watercraft_count30 := 0;
                unsigned1 watercraft_count90 := 0;
                unsigned1 watercraft_count180 := 0;
                unsigned1 watercraft_count12 := 0;
                unsigned1 watercraft_count24 := 0;
                unsigned1 watercraft_count36 := 0;
                unsigned1 watercraft_count60 := 0;
END;

export Layout_Watercraft_Plus := RECORD
                Layout_Watercraft;
                string watercraft_key;
                string sequence_key;
                string2  state_origin;
                unsigned6 did;
                unsigned4 seq;
                boolean isrelat;
								string8 watercraft_build_date
END;

export Layout_Aircraft := RECORD
                unsigned1 aircraft_count := 0;
                unsigned1 aircraft_count30 := 0;
                unsigned1 aircraft_count90 := 0;
                unsigned1 aircraft_count180 := 0;
                unsigned1 aircraft_count12 := 0;
                unsigned1 aircraft_count24 := 0;
                unsigned1 aircraft_count36 := 0;
                unsigned1 aircraft_count60 := 0;
                string8 n_number;          // extra field
                string8 date_first_seen;               // extra field
END;

export Layout_Aircraft_Ids := record
                unsigned6 aircraft_id;
                string8 n_number;          
                unsigned6 did;
                unsigned4 seq;
                unsigned3 historydate;
                boolean isrelat;
end;

export Layout_Aircraft_Plus := RECORD
                Layout_Aircraft;
                unsigned6 did;
                unsigned4 seq;
                boolean isrelat;
								string8 aircraft_build_date := '';
END;


export Layout_American_Student := RECORD
	string8 DATE_FIRST_SEEN;
	string8 DATE_LAST_SEEN;
	string4 CRRT_CODE;
	string1 ADDRESS_TYPE_CODE;
	string2 AGE;
	string8 DOB_FORMATTED;
	string3 CLASS;
	string25 COLLEGE_NAME;	
	string1 COLLEGE_CODE;
	string1 COLLEGE_TYPE;
	string1 INCOME_LEVEL_CODE;
	string1 FILE_TYPE;
	string1 FILE_TYPE2;
	string2 rec_type;
	string1 COLLEGE_TIER;
	string3 college_major;

	string1 competitive_code;
	string1 school_size_code;
	string1 tuition_code;
END;

export Layout_Professional_License := RECORD
	boolean professional_license_flag := false;
	string60 license_type := '';
	string100 jobCategory := '';
	string1 plCategory := '';
	unsigned1 proflic_count := 0;
	unsigned date_most_recent := 0;
	unsigned expiration_date := 0;
	unsigned1 proflic_count30 := 0;
	unsigned1 proflic_count90 := 0;
	unsigned1 proflic_count180 := 0;
	unsigned1 proflic_count12 := 0;
	unsigned1 proflic_count24 := 0;
	unsigned1 proflic_count36 := 0;
	unsigned1 proflic_count60 := 0;
	unsigned1 expire_count30 := 0;
	unsigned1 expire_count90 := 0;
	unsigned1 expire_count180 := 0;
	unsigned1 expire_count12 := 0;
	unsigned1 expire_count24 := 0;
	unsigned1 expire_count36 := 0;
	unsigned1 expire_count60 := 0;
	string2 proflic_Source;  // new for shell 5.0
	unsigned2 sanctions_count := 0;// new for shell 5.0
	unsigned4 sanctions_date_first_seen := 0;// new for shell 5.0
	unsigned4 sanctions_date_last_seen := 0;// new for shell 5.0
	string50 most_recent_sanction_type := '';// new for shell 5.0
END;

export Layout_Professional_License_Plus := RECORD
	Layout_Professional_License;
	string50 prolic_key;
	STRING8  date_first_seen;
	unsigned6 did;
	unsigned4 seq;
	string8 proflic_build_date := '';
END;

export Layout_AVM := RECORD
	risk_indicators.Layout_Address_AVM Input_Address_Information;
	risk_indicators.Layout_Address_AVM Address_History_1;
	risk_indicators.Layout_Address_AVM Address_History_2;
END;

export layout_ssn_in := record
	unsigned4 seq;
	unsigned3 historydate;
	string9   ssn;
	string8   dob;
	boolean deceased; // from ssn_table to avoid doing this search again in ssnCodes 
end;

export layout_ssn_out := record
	unsigned4 seq;
	string9   inssn;
	string8   indob;
	integer4  ssncode;
	integer4  dobcode;
	// Removing info fields from the layout until we decide they are needed
	// string100 ssninfo;
	// string100 dobinfo;
	string8   lowissue;
	string8   highissue;
	string2   state;
end;

export max_alerts := 4;

export red_flags_online_layout := record
	dataset(risk_indicators.layouts.layout_desc_plus_seq) ADDRESS_DISCREPANCY_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) SUSPICIOUS_DOCUMENTS_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) SUSPICIOUS_ADDRESS_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) SUSPICIOUS_SSN_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) SUSPICIOUS_DOB_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) HIGH_RISK_ADDRESS_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) SUSPICIOUS_PHONE_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) SSN_MULTIPLE_LAST_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) MISSING_INPUT_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) FRAUD_ALERT_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) CREDIT_FREEZE_CODES  { maxcount(max_alerts) };
	dataset(risk_indicators.layouts.layout_desc_plus_seq) IDENTITY_THEFT_CODES  { maxcount(max_alerts) };
end;

export red_flags_batch_layout := record
	STRING1 ADDRESS_DISCREPANCY;
	STRING2 ADDRESS_DISCREPANCY_RC1;
	STRING2 ADDRESS_DISCREPANCY_RC2;
	STRING2 ADDRESS_DISCREPANCY_RC3;
	STRING2 ADDRESS_DISCREPANCY_RC4;

	STRING1 SUSPICIOUS_DOCUMENTS;
	STRING2 SUSPICIOUS_DOCUMENTS_RC1;
	STRING2 SUSPICIOUS_DOCUMENTS_RC2;
	STRING2 SUSPICIOUS_DOCUMENTS_RC3;
	STRING2 SUSPICIOUS_DOCUMENTS_RC4;

	STRING1 SUSPICIOUS_ADDRESS;
	STRING2 SUSPICIOUS_ADDRESS_RC1;
	STRING2 SUSPICIOUS_ADDRESS_RC2;
	STRING2 SUSPICIOUS_ADDRESS_RC3;
	STRING2 SUSPICIOUS_ADDRESS_RC4;

	STRING1 SUSPICIOUS_SSN;
	STRING2 SUSPICIOUS_SSN_RC1;
	STRING2 SUSPICIOUS_SSN_RC2;
	STRING2 SUSPICIOUS_SSN_RC3;
	STRING2 SUSPICIOUS_SSN_RC4;

	STRING1 SUSPICIOUS_DOB;
	STRING2 SUSPICIOUS_DOB_RC1;
	STRING2 SUSPICIOUS_DOB_RC2;
	STRING2 SUSPICIOUS_DOB_RC3;
	STRING2 SUSPICIOUS_DOB_RC4;

	STRING1 HIGH_RISK_ADDRESS;
	STRING2 HIGH_RISK_ADDRESS_RC1;
	STRING2 HIGH_RISK_ADDRESS_RC2;
	STRING2 HIGH_RISK_ADDRESS_RC3;
	STRING2 HIGH_RISK_ADDRESS_RC4;

	STRING1 SUSPICIOUS_PHONE;
	STRING2 SUSPICIOUS_PHONE_RC1;
	STRING2 SUSPICIOUS_PHONE_RC2;
	STRING2 SUSPICIOUS_PHONE_RC3;
	STRING2 SUSPICIOUS_PHONE_RC4;

	STRING1 SSN_MULTIPLE_LAST;
	STRING2 SSN_MULTIPLE_LAST_RC1;
	STRING2 SSN_MULTIPLE_LAST_RC2;
	STRING2 SSN_MULTIPLE_LAST_RC3;
	STRING2 SSN_MULTIPLE_LAST_RC4;

	STRING1 MISSING_INPUT;
	STRING2 MISSING_INPUT_RC1;
	STRING2 MISSING_INPUT_RC2;
	STRING2 MISSING_INPUT_RC3;
	STRING2 MISSING_INPUT_RC4;
	
	STRING1 FRAUD_ALERT;
	STRING2 FRAUD_ALERT_RC1;
	STRING2 FRAUD_ALERT_RC2;
	STRING2 FRAUD_ALERT_RC3;
	STRING2 FRAUD_ALERT_RC4;

	STRING1 CREDIT_FREEZE;
	STRING2 CREDIT_FREEZE_RC1;
	STRING2 CREDIT_FREEZE_RC2;
	STRING2 CREDIT_FREEZE_RC3;
	STRING2 CREDIT_FREEZE_RC4;
	
	STRING1 IDENTITY_THEFT;
	STRING2 IDENTITY_THEFT_RC1;
	STRING2 IDENTITY_THEFT_RC2;
	STRING2 IDENTITY_THEFT_RC3;
	STRING2 IDENTITY_THEFT_RC4;
	
	STRING1 PLACEHOLDER1;
	STRING2 PLACEHOLDER1_RC1;
	STRING2 PLACEHOLDER1_RC2;
	STRING2 PLACEHOLDER1_RC3;
	STRING2 PLACEHOLDER1_RC4;
	
	STRING1 PLACEHOLDER2;
	STRING2 PLACEHOLDER2_RC1;
	STRING2 PLACEHOLDER2_RC2;
	STRING2 PLACEHOLDER2_RC3;
	STRING2 PLACEHOLDER2_RC4;

	STRING1 PLACEHOLDER3;
	STRING2 PLACEHOLDER3_RC1;
	STRING2 PLACEHOLDER3_RC2;
	STRING2 PLACEHOLDER3_RC3;
	STRING2 PLACEHOLDER3_RC4;

	STRING1 PLACEHOLDER4;
	STRING2 PLACEHOLDER4_RC1;
	STRING2 PLACEHOLDER4_RC2;
	STRING2 PLACEHOLDER4_RC3;
	STRING2 PLACEHOLDER4_RC4;

	STRING1 PLACEHOLDER5;
	STRING2 PLACEHOLDER5_RC1;
	STRING2 PLACEHOLDER5_RC2;
	STRING2 PLACEHOLDER5_RC3;
	STRING2 PLACEHOLDER5_RC4;

	
end;

red_flags_combined_layouts := record
	unsigned seq;
	red_flags_online_layout;
	red_flags_batch_layout;
end;

EXPORT Paro_IT1O_layout := record
  string1   paro_bansmatchflag := '';
  string12  paro_banscasenum := '';
  string2   paro_bansprcode := '';
  string2   paro_bansdispcode := '';
  string8   paro_bansdatefiled := '';
  string15  paro_bansfirst := '';
  string15  paro_bansmiddle := '';
  string20  paro_banslast := '';
  string30  paro_banscnty := '';
  string1   paro_bansecoaflag := '';
  string1   paro_decsflag := '';
  string8   paro_decsdob := '';
  string5   paro_decszip := '';
  string5   paro_decszip2 := '';
  string20  paro_decslast := '';
  string15  paro_decsfirst := '';
  string8   paro_decsdod := '';
  string1   paro_inputaddrcharflag := '';
  string1   paro_inputsocscharflag := '';
  string9   paro_correctsocs := '';
  string1   paro_phonestatusflag := '';
  string10  paro_phone := '';
  string3   paro_altareacode := '';
  string8   paro_splitdate := '';
  string1   paro_addrstatusflag := '';
  string1   paro_addrcharflag := '';
  string15  paro_first := '';
  string20  paro_last := '';
  string50  paro_addr := '';
  string30  paro_city := '';
  string2   paro_state := '';
  string11  paro_zip := '';
  string1   paro_hownstatusflag := '';
  string3   paro_estincome := '';
  string3   paro_median_hh_size := ''; // takes the place of score2
end;



END;