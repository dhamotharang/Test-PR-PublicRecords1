
EXPORT  layout_sexoffender_offense := RECORD,maxlength(200000)
  //from offender
	string30 orig_state;
  string2 orig_state_code;
  string2 vendor_code;
  string20 source_file;
	//from offense
  string60 seisint_primary_key;
  string80 conviction_jurisdiction;
  string8 conviction_date;
  string30 court;
  string25 court_case_number;
  string8 offense_date;
  string20 offense_code_or_statute;
  string320 offense_description;
  string180 offense_description_2;
  string30 offense_category;
  string1 victim_minor;
  string3 victim_age;
  string10 victim_gender;
  string30 victim_relationship;
  string180 sentence_description;
  string180 sentence_description_2;
  string8 arrest_date;
  string250 arrest_warrant;
  string1 fcra_conviction_flag;
  string1 fcra_traffic_flag;
  string8 fcra_date;
  string1 fcra_date_type;
  string8 conviction_override_date;
  string1 conviction_override_date_type;
  string2 offense_score;
  unsigned8 offense_persistent_id;
 END;