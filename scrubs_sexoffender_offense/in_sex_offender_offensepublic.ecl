
import ut, scrubs_sexoffender_main;

layout_sex_offender_offense := RECORD,maxlength(200000)
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
 
offender_soff := scrubs_sexoffender_main.in_sex_offender_mainpublic;

offense_soff := dataset(
                       // ut.foreign_dataland +
                         //ut.foreign_prod +
                          '~thor_data400::base::sex_offender_offensespublic',layout_sex_offender_offense,flat);

// Need to get seisint_primary_key,orig_state,orig_state_code,vendor_code from in_sex_offender_mainpublic
slim_offender_soff := TABLE(offender_soff,{seisint_primary_key,
                                             orig_state,
																							orig_state_code,
																							 vendor_code,
																							   source_file, count_1 := count(group)	}
																								     ,seisint_primary_key,
                                                        orig_state,
																							           orig_state_code,
																							            vendor_code,
																							             source_file,few) ;

layout_sex_offender_offensepublic tr_join_offender_and_offense(slim_offender_soff L, offense_soff R) := TRANSFORM
SELF:= L;
SELF := R;
END;

join_offender_and_offense := JOIN(slim_offender_soff,offense_soff,
																			LEFT.seisint_primary_key=RIGHT.seisint_primary_key,
																			 tr_join_offender_and_offense(LEFT,RIGHT));
																			 
EXPORT in_sex_offender_offensepublic := join_offender_and_offense;		 

	 