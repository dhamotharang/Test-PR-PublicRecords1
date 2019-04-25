#workunit('name','Instant ID Generic batch');

import risk_indicators, ashirey, scoring_project_Macros, scoring_project_pip, scoring_qa;

eyeball := 30;

// input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout;


layout_reason_codes_plus_seq := RECORD
     unsigned1 seq;
     string3 reason_code;
     string reason_description;
    END;

layout_risk_indices := RECORD
     string30 name;
     string1 value;
    END;

layout_score_iid_wfp := RECORD
    string3 i;
    string50 description;
    string3 index;
    DATASET(layout_reason_codes_plus_seq) reason_codes;
    DATASET(layout_risk_indices) risk_indices{maxcount(6)};
   END;

layout_model_iid := RECORD
   string30 accountnumber;
   string50 description;
   DATASET(layout_score_iid_wfp) scores;
  END;

layout_desc_plus_seq := RECORD
   unsigned1 seq;
   string5 hri;
   string150 desc;
  END;

r := RECORD
   string5 hri;
   string150 desc;
  END;

input_layout := RECORD
  unsigned8 time_ms;
  string30 acctno;
  unsigned6 did;
  unsigned4 seq;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string120 in_streetaddress;
  string25 in_city;
  string2 in_state;
  string5 in_zipcode;
  string25 in_country;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string4 zip4;
  string10 lat;
  string11 long;
  string3 county;
  string7 geo_blk;
  string1 addr_type;
  string4 addr_status;
  string25 country;
  string9 ssn;
  string8 dob;
  string3 age;
  string20 dl_number;
  string2 dl_state;
  string50 email_address;
  string45 ip_address;
  string10 phone10;
  string10 wphone10;
  string100 employer_name;
  string20 lname_prev;
  unsigned6 transaction_id;
  string20 verfirst;
  string20 verlast;
  string65 veraddr;
  string10 verprimrange;
  string2 verpredir;
  string28 verprimname;
  string4 veraddrsuffix;
  string2 verpostdir;
  string10 verunitdesignation;
  string8 versecrange;
  string25 vercity;
  string2 verstate;
  string5 verzip;
  string20 vercounty;
  string4 verzip4;
  string12 verdpbc;
  string9 verssn;
  string8 verdob;
  string10 verhphone;
  string1 verify_addr;
  string1 verify_dob;
  string1 valid_ssn;
  integer1 nas_summary;
  integer1 nap_summary;
  string1 nap_type;
  string1 nap_status;
  string3 cvi;
  integer1 additional_score1;
  integer1 additional_score2;
  string20 corrected_lname;
  string8 corrected_dob;
  string10 corrected_phone;
  string9 corrected_ssn;
  string65 corrected_address;
  string10 correctedprimrange;
  string2 correctedpredir;
  string28 correctedprimname;
  string4 correctedaddrsuffix;
  string2 correctedpostdir;
  string10 correctedunitdesignation;
  string8 correctedsecrange;
  string3 area_code_split;
  string8 area_code_split_date;
  string20 phone_fname;
  string20 phone_lname;
  string65 phone_address;
  string10 phoneprimrange;
  string2 phonepredir;
  string28 phoneprimname;
  string4 phoneaddrsuffix;
  string2 phonepostdir;
  string10 phoneunitdesignation;
  string8 phonesecrange;
  string25 phone_city;
  string2 phone_st;
  string5 phone_zip;
  string10 name_addr_phone;
  string8 ssa_date_first;
  string8 ssa_date_last;
  string2 ssa_state;
  string20 ssa_state_name;
  string20 current_fname;
  string20 current_lname;
  string60 watchlist_table;
  string120 watchlist_program;
  string10 watchlist_record_number;
  string20 watchlist_fname;
  string20 watchlist_lname;
  string65 watchlist_address;
  string10 watchlistprimrange;
  string2 watchlistpredir;
  string28 watchlistprimname;
  string4 watchlistaddrsuffix;
  string2 watchlistpostdir;
  string10 watchlistunitdesignation;
  string8 watchlistsecrange;
  string25 watchlist_city;
  string2 watchlist_state;
  string5 watchlist_zip;
  string30 watchlist_contry;
  string200 watchlist_entity_name;
  DATASET(layout_model_iid) models{maxcount(3)};
  unsigned1 recordcount;
  string3 subjectssncount;
  string20 verdl;
  string8 deceaseddate;
  string8 deceaseddob;
  string15 deceasedfirst;
  string20 deceasedlast;
  string1 passportvalidated;
  string44 passportupperline;
  string44 passportlowerline;
  string6 gender;
  string1 dobmatchlevel;
  unsigned8 iid_flags;
  boolean addresspobox;
  boolean addresscmra;
  boolean ssnfoundforlexid;
  string3 cvicustomscore;
  string1 instantidversion;
  string128 cvicustomscore_name;
  DATASET(layout_desc_plus_seq) cvicustomscore_ri{maxcount(75)};
  DATASET(r) cvicustomscore_fua{maxcount(4)};
  boolean emergingid;
  string1 addresssecondaryrangemismatch;
  boolean standardizedaddress;
  string65 streetaddress1;
  string65 streetaddress2;
  string20 countyname;
  unsigned2 royalty_type_code_targus;
  string20 royalty_type_targus;
  unsigned2 royalty_count_targus;
  unsigned2 non_royalty_count_targus;
  string20 count_entity_targus;
  unsigned2 royalty_type_code_insurance;
  string20 royalty_type_insurance;
  unsigned2 royalty_count_insurance;
  unsigned2 non_royalty_count_insurance;
  string20 count_entity_insurance;
  string4 hri_1;
  string100 hri_desc_1;
  string4 hri_2;
  string100 hri_desc_2;
  string4 hri_3;
  string100 hri_desc_3;
  string4 hri_4;
  string100 hri_desc_4;
  string4 hri_5;
  string100 hri_desc_5;
  string4 hri_6;
  string100 hri_desc_6;
  string4 fua_1;
  string150 fua_desc_1;
  string4 fua_2;
  string150 fua_desc_2;
  string4 fua_3;
  string150 fua_desc_3;
  string4 fua_4;
  string150 fua_desc_4;
  string20 additional_fname_1;
  string20 additional_lname_1;
  string8 additional_lname_date_last_1;
  string20 additional_fname_2;
  string20 additional_lname_2;
  string8 additional_lname_date_last_2;
  string20 additional_fname_3;
  string20 additional_lname_3;
  string8 additional_lname_date_last_3;
  string200 watchlist_country;
  string65 chron_address_1;
  string25 chron_city_1;
  string2 chron_st_1;
  string5 chron_zip_1;
  string4 chron_zip4_1;
  string50 chron_phone_1;
  string6 chron_dt_first_seen_1;
  string6 chron_dt_last_seen_1;
  string65 chron_address_2;
  string25 chron_city_2;
  string2 chron_st_2;
  string5 chron_zip_2;
  string4 chron_zip4_2;
  string50 chron_phone_2;
  string6 chron_dt_first_seen_2;
  string6 chron_dt_last_seen_2;
  string65 chron_address_3;
  string25 chron_city_3;
  string2 chron_st_3;
  string5 chron_zip_3;
  string4 chron_zip4_3;
  string50 chron_phone_3;
  string6 chron_dt_first_seen_3;
  string6 chron_dt_last_seen_3;
  string1 chron_addr_1_isbest;
  string1 chron_addr_2_isbest;
  string1 chron_addr_3_isbest;
  string60 watchlist_table_2;
  string120 watchlist_program_2;
  string10 watchlist_record_number_2;
  string20 watchlist_fname_2;
  string20 watchlist_lname_2;
  string65 watchlist_address_2;
  string25 watchlist_city_2;
  string2 watchlist_state_2;
  string5 watchlist_zip_2;
  string30 watchlist_country_2;
  string200 watchlist_entity_name_2;
  string60 watchlist_table_3;
  string120 watchlist_program_3;
  string10 watchlist_record_number_3;
  string20 watchlist_fname_3;
  string20 watchlist_lname_3;
  string65 watchlist_address_3;
  string25 watchlist_city_3;
  string2 watchlist_state_3;
  string5 watchlist_zip_3;
  string30 watchlist_country_3;
  string200 watchlist_entity_name_3;
  string60 watchlist_table_4;
  string120 watchlist_program_4;
  string10 watchlist_record_number_4;
  string20 watchlist_fname_4;
  string20 watchlist_lname_4;
  string65 watchlist_address_4;
  string25 watchlist_city_4;
  string2 watchlist_state_4;
  string5 watchlist_zip_4;
  string30 watchlist_country_4;
  string200 watchlist_entity_name_4;
  string60 watchlist_table_5;
  string120 watchlist_program_5;
  string10 watchlist_record_number_5;
  string20 watchlist_fname_5;
  string20 watchlist_lname_5;
  string65 watchlist_address_5;
  string25 watchlist_city_5;
  string2 watchlist_state_5;
  string5 watchlist_zip_5;
  string30 watchlist_country_5;
  string200 watchlist_entity_name_5;
  string60 watchlist_table_6;
  string120 watchlist_program_6;
  string10 watchlist_record_number_6;
  string20 watchlist_fname_6;
  string20 watchlist_lname_6;
  string65 watchlist_address_6;
  string25 watchlist_city_6;
  string2 watchlist_state_6;
  string5 watchlist_zip_6;
  string30 watchlist_country_6;
  string200 watchlist_entity_name_6;
  string60 watchlist_table_7;
  string120 watchlist_program_7;
  string10 watchlist_record_number_7;
  string20 watchlist_fname_7;
  string20 watchlist_lname_7;
  string65 watchlist_address_7;
  string25 watchlist_city_7;
  string2 watchlist_state_7;
  string5 watchlist_zip_7;
  string30 watchlist_country_7;
  string200 watchlist_entity_name_7;
  string4 hri_7;
  string100 hri_desc_7;
  string4 hri_8;
  string100 hri_desc_8;
  string4 hri_9;
  string100 hri_desc_9;
  string4 hri_10;
  string100 hri_desc_10;
  string4 hri_11;
  string100 hri_desc_11;
  string4 hri_12;
  string100 hri_desc_12;
  string4 hri_13;
  string100 hri_desc_13;
  string4 hri_14;
  string100 hri_desc_14;
  string4 hri_15;
  string100 hri_desc_15;
  string4 hri_16;
  string100 hri_desc_16;
  string4 hri_17;
  string100 hri_desc_17;
  string4 hri_18;
  string100 hri_desc_18;
  string4 hri_19;
  string100 hri_desc_19;
  string4 hri_20;
  string100 hri_desc_20;
  string10 chronprimrange1;
  string2 chronpredir1;
  string28 chronprimname1;
  string4 chronaddrsuffix1;
  string2 chronpostdir1;
  string10 chronunitdesignation1;
  string8 chronsecrange1;
  string10 chronprimrange2;
  string2 chronpredir2;
  string28 chronprimname2;
  string4 chronaddrsuffix2;
  string2 chronpostdir2;
  string10 chronunitdesignation2;
  string8 chronsecrange2;
  string10 chronprimrange3;
  string2 chronpredir3;
  string28 chronprimname3;
  string4 chronaddrsuffix3;
  string2 chronpostdir3;
  string10 chronunitdesignation3;
  string8 chronsecrange3;
  string10 watchlistprimrange2;
  string2 watchlistpredir2;
  string28 watchlistprimname2;
  string4 watchlistaddrsuffix2;
  string2 watchlistpostdir2;
  string10 watchlistunitdesignation2;
  string8 watchlistsecrange2;
  string10 watchlistprimrange3;
  string2 watchlistpredir3;
  string28 watchlistprimname3;
  string4 watchlistaddrsuffix3;
  string2 watchlistpostdir3;
  string10 watchlistunitdesignation3;
  string8 watchlistsecrange3;
  string10 watchlistprimrange4;
  string2 watchlistpredir4;
  string28 watchlistprimname4;
  string4 watchlistaddrsuffix4;
  string2 watchlistpostdir4;
  string10 watchlistunitdesignation4;
  string8 watchlistsecrange4;
  string10 watchlistprimrange5;
  string2 watchlistpredir5;
  string28 watchlistprimname5;
  string4 watchlistaddrsuffix5;
  string2 watchlistpostdir5;
  string10 watchlistunitdesignation5;
  string8 watchlistsecrange5;
  string10 watchlistprimrange6;
  string2 watchlistpredir6;
  string28 watchlistprimname6;
  string4 watchlistaddrsuffix6;
  string2 watchlistpostdir6;
  string10 watchlistunitdesignation6;
  string8 watchlistsecrange6;
  string10 watchlistprimrange7;
  string2 watchlistpredir7;
  string28 watchlistprimname7;
  string4 watchlistaddrsuffix7;
  string2 watchlistpostdir7;
  string10 watchlistunitdesignation7;
  string8 watchlistsecrange7;
  string errorcode;
  string6 historydate;
  boolean fnamepop;
  boolean lnamepop;
  boolean addrpop;
  string1 ssnlength;
  boolean dobpop;
  boolean emailpop;
  boolean ipaddrpop;
  boolean hphnpop;
 END;



// prii_layout := RECORD
  // Scoring_Project_Macros.Regression.global_layout;
	// Scoring_Project_Macros.Regression.pii_layout;
	// Scoring_Project_Macros.Regression.runtime_layout;
 // END;

prii_layout := RECORD
  unsigned8 date_added;
  string customer;
  string source_info;
  integer1 perm_flag;
  integer3 accountnumber;
  string firstname;
  string middlename;
  string lastname;
  string streetaddress;
  string city;
  string state;
  string zip;
  string homephone;
  string ssn;
  string dateofbirth;
  string workphone;
  string income;
  string dlnumber;
  string dlstate;
  string balance;
  string chargeoffd;
  string formername;
  string email;
  string company;
  integer8 historydateyyyymm;
  string placeholder_1;
  string placeholder_2;
  string placeholder_3;
  string placeholder_4;
  string placeholder_5;
  string dppa;
  string glb;
  string drm;
  integer8 history_date;
  string dpm;
  string other2;
  string other3;
  string other4;
 END;


// basefilename := '~scoringqa::out::nonfcra::instantid_xml_generic_20190201_core_phoneplusv2keys_20181217b_gongneustar_base';        //XML or Batch
// testfilename := '~scoringqa::out::nonfcra::instantid_xml_generic_20190201_core_phoneplusv2keys_20181219b_gongneustar_second';     
// basefilename := '~scoringqa::out::nonfcra::instantid_batch_generic_20190201_core_phoneplusv2keys_20181217b_gongneustar_base';        //XML or Batch
// testfilename := '~scoringqa::out::nonfcra::instantid_batch_generic_20190201_core_phoneplusv2keys_20181219b_gongneustar_second';  

// basefilename := '~scoringqa::out::nonfcra::instantid_xml_generic_20190326_core_phoneplusv2keys_20181217b_gongneustar_neustarexclusive_5k_base';        //XML
// testfilename := '~scoringqa::out::nonfcra::instantid_xml_generic_20190326_core_phoneplusv2keys_20181219b_gongneustar_neustarexclusive_5k_second';     
basefilename := '~scoringqa::out::nonfcra::instantid_batch_generic_20190326_core_phoneplusv2keys_20181217b_gongneustar_neustarexclusive_5k_base';        //Batch
testfilename := '~scoringqa::out::nonfcra::instantid_batch_generic_20190326_core_phoneplusv2keys_20181219b_gongneustar_neustarexclusive_5k_second';        
pii_name := scoring_project_pip.Input_Sample_Names.IID_Scores_V0_batch_Generic_infile;             //XML or Batch


ds_baseline := dataset(basefilename,input_layout, thor); 
ds_new := dataset(testfilename,input_layout, thor); 
ds_pii := dataset(pii_name, prii_layout, thor);

ds_baseline_NoError := ds_baseline(errorcode = '');
ds_new_NoError := ds_new(errorcode = '');

//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;


ds_join_baseline := JOIN( ds_baseline_NoError, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new_NoError, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

OUTPUT(count(ds_join_baseline), named('baseline_count'));
// OUTPUT(choosen(ds_join_baseline, 25), named('baseline'));
OUTPUT(count(ds_join_second), named('second_count'));
// OUTPUT(choosen(ds_join_second, 25), named('second'));


//*********table across fields*************
// r1 := record
 // ds_join_baseline.results.cvi;
 // count_ := count(group);
// end;

// r2 := record
 // ds_join_second.results.cvi;
 // count_ := count(group);
// end;

// ta1 := table(ds_join_baseline,r1,results.cvi,few);
// output(sort(ta1,cvi),all, named('baseline_cvi_summary'));
// ta2 := table(ds_join_second,r2,results.cvi,few);
// output(sort(ta2,cvi),all, named('second_cvi_summary'));



cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

// blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));


 j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.verhphone = '',
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

 j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.verhphone <> '',
					// AND (INTEGER)LEFT.results.verhphone > (INTEGER)RIGHT.results.verhphone,
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
	
	j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND RIGHT.results.verhphone = '',
					// AND (INTEGER)LEFT.results.verhphone < (INTEGER)RIGHT.results.verhphone,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

	j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND (INTEGER)LEFT.results.nap_summary < (INTEGER)RIGHT.results.nap_summary
					// AND LEFT.results.verhphone = ''
					AND RIGHT.results.verhphone <> '',
					// AND Right.results.phone10 <> right.results.verhphone,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
					

	j5 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND (INTEGER)LEFT.results.nap_summary < (INTEGER)RIGHT.results.nap_summary
					// AND LEFT.results.verhphone = ''
					AND (RIGHT.results.verhphone = ''
					OR RIGHT.results.verhphone <> ''),
					// AND Right.results.phone10 <> right.results.verhphone,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

// OUTPUT(count(j1), NAMED('Base_verhphone_blank_count'));
// OUTPUT(count(j2), NAMED('Base_verhphone_Notblank_count'));
// OUTPUT(count(j3), NAMED('test_verhphone_blank_count'));
// OUTPUT(count(j4), NAMED('test_verhphone_Notblank_count'));
OUTPUT(count(j5), NAMED('test_verhphone_NotblankANDblank_count'));

// OUTPUT(CHOOSEN(j1, 25), named('Base_verhphone_blank'));
// OUTPUT(CHOOSEN(j2, 25), named('Base_verhphone_Notblank'));
// OUTPUT(CHOOSEN(j3, 25), named('test_verhphone_blank'));
// OUTPUT(CHOOSEN(j4, 25), named('test_verhphone_Notblank'));


// t1 := table(ds_baseline_NoError, {verhphone; namedcount := count(group)}, verhphone);
// t2 := table(ds_new_NoError, {verhphone; namedcount := count(group)}, verhphone);

// output(t1, Named('base_verhphone'));
// output(t2, Named('test_verhphone'));

// ashirey.flatten(ds_baseline, flatten_baseline);
// ashirey.flatten(ds_new, flatten_second);

	 // scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['acctno'], 0);  //nested layout
// scoring_qa.CROSSTAB_MACRO(ds_baseline_NoError, ds_new_NoError, ['acctno'], 'nap_summary');    //nested layout


new_layout := record
	   string30 acctno;
		 integer base_nap;
		 integer test_nap;
		 integer base_cvi;
		 integer test_cvi;
		 end;
		 
new_layout quick_trans(input_layout le, input_layout ri) :=	transform
			self.acctno := le.acctno;
			self.base_nap := le.nap_summary;
			self.test_nap := ri.nap_summary;
			self.base_cvi := (integer)trim(le.cvi, left, right);
			self.test_cvi := (integer)trim(ri.cvi, left, right);
end;	 

		 j20 := join(ds_baseline_NoError, ds_new_NoError, left.acctno = right.acctno,
										quick_trans(left, right));

f1(dataset (new_layout) le, integer val) := function
	filterset := le(test_nap = val);
	t20 := table(filterset, {base_nap, integer _count := count(group)}, base_nap);
	sorttable := sort(t20, base_nap);

	return sorttable;

end;

f2(dataset (new_layout) le, integer val) := function
	filterset := le(test_cvi = val);
	t21 := table(filterset, {base_cvi, integer _count := count(group)}, base_cvi);
	sorttable2 := sort(t21, base_cvi);

	return sorttable2;

end;

	// Output(f1(j20, 0), NAMED('nap_Second_0'));
	// Output(f1(j20, 1), NAMED('nap_Second_1'));
	// Output(f1(j20, 2), NAMED('nap_Second_2'));
	// Output(f1(j20, 3), NAMED('nap_Second_3'));
	// Output(f1(j20, 4), NAMED('nap_Second_4'));
	// Output(f1(j20, 5), NAMED('nap_Second_5'));
	// Output(f1(j20, 6), NAMED('nap_Second_6'));
	// Output(f1(j20, 7), NAMED('nap_Second_7'));
	// Output(f1(j20, 8), NAMED('nap_Second_8'));
	// Output(f1(j20, 9), NAMED('nap_Second_9'));
	// Output(f1(j20, 10), NAMED('nap_Second_10'));
	// Output(f1(j20, 11), NAMED('nap_Second_11'));
	// Output(f1(j20, 12), NAMED('nap_Second_12'));



	// Output(f2(j20, 00), NAMED('cvi_Second_00'));
	// Output(f2(j20, 10), NAMED('cvi_Second_10'));
	// Output(f2(j20, 20), NAMED('cvi_Second_20'));
	// Output(f2(j20, 30), NAMED('cvi_Second_30'));
	// Output(f2(j20, 40), NAMED('cvi_Second_40'));
	// Output(f2(j20, 50), NAMED('cvi_Second_50'));