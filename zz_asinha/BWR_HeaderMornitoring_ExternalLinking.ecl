source_size := 10;

Criminal_filesize 				:= source_size;  // Do we need to take the latest samples ?
Properties_filesize 			:= source_size;
Liens_Judgments_filesize 	:= source_size;
Utility_filesize 					:= source_size;
Bankruptcy_filesize 			:= source_size;
Current_Carrier_filesize 	:= source_size;
DL_filesize 							:= source_size;
Clue_Auto_filesize 				:= source_size;

foreignTag_Boca := data_services.foreign_prod;
foreignTag_Alpha := '~foreign::' + _control.IPAddress.aprod_thor_dali + '::';

Criminal_filename 				:= foreignTag_Boca + 'thor_data400::base::corrections_offenders_public';
Properties_filename 			:= foreignTag_Boca + 'thor_data400::base::ln_propertyv2::search';
Liens_Judgments_filename 	:= foreignTag_Boca + 'thor_data400::base::liens::party';     //Not using thor_data400::base::liens::main since it does not have PII
Utility_filename 					:= foreignTag_Boca + 'thor_data400::base::utility_file';
Bankruptcy_filename 			:= foreignTag_Boca + 'thor_data400::base::bankruptcy::main_v3';
Current_Carrier_filename 	:= foreignTag_Alpha + 'thor::base::currentcarrier::qa::holder';
DL_filename 							:= '~';
Clue_Auto_filename 				:= foreignTag_Alpha + 'thor::base::clueauto::qa::subject';

Criminal_layout 					:= corrections.layout_offender;
Properties_layout 				:= RECORD
															unsigned3 dt_first_seen;
															unsigned3 dt_last_seen;
															unsigned3 dt_vendor_first_reported;
															unsigned3 dt_vendor_last_reported;
															string1 vendor_source_flag;
															string12 ln_fares_id;
															string8 process_date;
															string2 source_code;
															string2 which_orig;
															string1 conjunctive_name_seq;
															string5 title;
															string20 fname;
															string20 mname;
															string20 lname;
															string5 name_suffix;
															string80 cname;
															string80 nameasis;
															string100 append_prepaddr1;
															string50 append_prepaddr2;
															unsigned8 append_rawaid;
															string10 prim_range;
															string2 predir;
															string28 prim_name;
															string4 suffix;
															string2 postdir;
															string10 unit_desig;
															string8 sec_range;
															string25 p_city_name;
															string25 v_city_name;
															string2 st;
															string5 zip;
															string4 zip4;
															string4 cart;
															string1 cr_sort_sz;
															string4 lot;
															string1 lot_order;
															string2 dbpc;
															string1 chk_digit;
															string2 rec_type;
															string5 county;
															string10 geo_lat;
															string11 geo_long;
															string4 msa;
															string7 geo_blk;
															string1 geo_match;
															string4 err_stat;
															string10 phone_number;
															string1 name_type;
															string1 prop_addr_propagated_ind;
															unsigned6 did;
															unsigned6 bdid;
															string9 app_ssn;
															string9 app_tax_id;
															unsigned6 dotid;
															unsigned2 dotscore;
															unsigned2 dotweight;
															unsigned6 empid;
															unsigned2 empscore;
															unsigned2 empweight;
															unsigned6 powid;
															unsigned2 powscore;
															unsigned2 powweight;
															unsigned6 proxid;
															unsigned2 proxscore;
															unsigned2 proxweight;
															unsigned6 seleid;
															unsigned2 selescore;
															unsigned2 seleweight;
															unsigned6 orgid;
															unsigned2 orgscore;
															unsigned2 orgweight;
															unsigned6 ultid;
															unsigned2 ultscore;
															unsigned2 ultweight;
															unsigned8 source_rec_id;
															string2 ln_party_status;
															string6 ln_percentage_ownership;
															string2 ln_entity_type;
															string8 ln_estate_trust_date;
															string1 ln_goverment_type;
															unsigned8 nid;
															integer2 xadl2_weight;
															string2 addr_ind;
															string1 best_addr_ind;
															unsigned6 addr_tx_id;
															string1 best_addr_tx_id;
															unsigned8 location_id;
															string1 best_locid;
														 END;
Liens_Judgments_layout 		:= RECORD
  string50 tmsid;
  string50 rmsid;
  string orig_full_debtorname;
  string orig_name;
  string orig_lname;
  string orig_fname;
  string orig_mname;
  string orig_suffix;
  string9 tax_id;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string cname;
  string orig_address1;
  string orig_address2;
  string orig_city;
  string orig_state;
  string orig_zip5;
  string orig_zip4;
  string orig_county;
  string orig_country;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string phone;
  string name_type;
  string12 did;
  string12 bdid;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  unsigned8 persistent_record_id;
  string9 app_ssn;
  string9 app_tax_id;
 END;

Utility_layout 						:= UtilFile.layout_util.base;
Bankruptcy_layout 				:= bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp;
//Current Carrier layout Start
layout_insurance_address := RECORD
   string9 house_num;
   string20 street_name;
   string5 apt_num;
   string20 rcity;
   string2 rst;
   string5 rzip;
   string4 rzip4;
  END;

legacy_holder_lapse_info := RECORD
   unsigned4 last_cancel_dt;
   string1 input_flg;
   string1 count_lapse_ind;
   string2 relation;
   string9 batch_id;
   unsigned4 load_date;
  END;
Current_Carrier_layout 		:= RECORD
  string6 ambest;
  string20 policy_number;
  string2 insurance_type;
  unsigned6 policy_endorsement_date;
  unsigned4 policy_endorsement_nbr;
  unsigned8 idl;
  unsigned4 orig_date;
  unsigned4 start_date;
  unsigned4 end_date;
  unsigned4 chg_effect_date;
  string2 relation;
  string3 special_project_id;
  string3 carrier_order_seq_nbr;
  string8 client_identifier;
  string20 pfname;
  string20 fname;
  string20 mname;
  string28 lname;
  string5 sname;
  string1 gender;
  unsigned4 dob;
  string25 dl_nbr;
  string2 dl_state;
  string9 ssn;
  string9 house_num;
  string5 apt_num;
  string28 street_name;
  string28 rcity;
  string2 rst;
  string5 rzip;
  string4 rzip4;
  string3 area_code;
  string7 phone_num;
  string4 extension;
  string1 default_state_ind;
  string1 fraud_alert_ind;
  string1 suppress_ind;
  string1 count_lapse_ind;
  string1 early_terminate_ind;
  unsigned4 lapse_count_start;
  unsigned4 holder_cancel_date;
  string4 error_code;
  unsigned8 address_id;
  string28 clean_lname;
  string20 clean_fname;
  string15 clean_mname;
  string3 clean_sname;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 city;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_state;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string60 email_address;
  string1 individual_or_business_type;
  string60 full_individual_or_business_or_trust_name;
  string9 fein_number_or_tax_id;
  string2 trust_or_business_name_address_type;
  layout_insurance_address trust_or_business_name_mail_address;
  string3 trust_or_business_name_area_code;
  string7 trust_or_business_name_phone_num;
  string4 trust_or_business_name_extension;
  string1 marital_status;
  string1 delete_flg;
  string1 pull_forward_ind;
  string9 batch_id;
  DATASET(legacy_holder_lapse_info) legacy_holder_lapses{maxcount(99)};
 END;
 
//Current Carrier layout End
DL_layout 								:= '';
Clue_Auto_layout 					:= RECORD
																string6 ambest_no;
																string20 claim_no;
																string9 batch_no;
																string1 name_address_ind;
																string4 prefix_name;
																string20 last_name;
																string20 first_name;
																string15 middle_name;
																string3 suffix_name;
																string25 drivers_license_no;
																string2 drivers_license_state;
																string1 sex;
																unsigned4 dob;
																string9 ssn;
																string9 house_no;
																string20 street_name;
																string5 apt;
																string20 city;
																string2 state;
																string5 zip;
																string4 zip_ext;
																string25 vin;
																string20 policy_no;
																unsigned4 claim_date;
																unsigned4 as_of_date;
																unsigned6 load_date_time;
																string1 delete_flag;
																unsigned8 source_rid;
																unsigned8 header_rid;
																unsigned1 rec_seq_no;
																unsigned8 record_no;
																string1 operator_relation;
																string4 c_prefix_name;
																string20 c_last_name;
																string20 c_first_name;
																string15 c_middle_name;
																string3 c_suffix_name;
																string4 addr_error_code;
																string10 prim_range;
																string2 predir;
																string28 prim_name;
																string4 addr_suffix;
																string2 postdir;
																string10 unit_desig;
																string8 sec_range;
																string20 c_city;
																string2 c_st;
																string5 c_zip5;
																string4 c_zip4;
																unsigned8 did;
															 END;






inputLayout := Record
	string20 source;
	string6 date_first_seen;
	string6 date_last_seen;
	string50 unique_id;
	unsigned4 seq;
	qSTRING9  ssn;
	qSTRING8  dob;
	qstring10 phone10;
	qSTRING5  title;
	qSTRING20 fname;
	qSTRING20 mname;
	qSTRING20 lname;
	qSTRING5  suffix;
	qSTRING10 prim_range;
	qSTRING2  predir;
	qSTRING28 prim_name;
	qSTRING4  addr_suffix;
	qSTRING2  postdir;
	qSTRING10 unit_desig;
	qSTRING8  sec_range;
	qSTRING25 p_city_name;
	qSTRING2  st;
	qSTRING5  z5;
	qSTRING4  zip4;
	QSTRING120 email:='';  
End;


/* ************************************
 *          Properties Sample         *
************************************* */


dsCrim := choosen(dataset(Properties_filename,Properties_layout,thor),Properties_filesize);
output(dsCrim,named('Properties_Sample'));

inProp := project(dsCrim,transform(inputLayout,
																				self.source := 'Property';
																				// self.date_first_seen := left.dt_first_seen;
																				// self.date_last_seen := left.dt_last_seen;
																				self.unique_id := left.ln_fares_id;
																				// self.seq := left.;
																				self.ssn := left.app_ssn;
																				// self.dob := left.person_name.dob;
																				// self.phone10 := left.person_name.;
																				self.title := left.title;
																				self.fname := left.fname;
																				self.mname := left.mname;
																				self.lname := left.lname;
																				self.suffix := left.name_suffix;
																				self.prim_range := left.prim_range;
																				self.predir := left.predir;
																				self.prim_name := left.prim_name;
																				self.addr_suffix := left.suffix;
																				self.postdir := left.postdir;
																				self.unit_desig := left.unit_desig;
																				self.sec_range := left.sec_range;
																				self.p_city_name := left.v_city_name;
																				self.st := left.st;
																				self.z5 := left.zip;
																				self.zip4 := left.zip4;
																				// self.email := left.;
																				self := [];
																				));

output(inProp, named('in_prop'));


/* ************************************
 *              L&J Sample            *
************************************* */
dsLnJ := choosen(dataset(Liens_Judgments_filename,Liens_Judgments_layout,thor),Liens_Judgments_filesize);
output(dsLnJ,named('LnJ_Sample'));

inLnJ := project(dsLnJ,transform(inputLayout,
																				self.source := 'LnJ';
																				self.date_first_seen := left.date_first_seen;
																				self.date_last_seen := left.date_last_seen;
																				self.unique_id := left.tmsid;
																				// self.seq := left.;
																				self.ssn := left.app_ssn;
																				// self.dob := left.person_name.dob;
																				self.phone10 := left.phone;
																				self.title := left.title;
																				self.fname := left.fname;
																				self.mname := left.mname;
																				self.lname := left.lname;
																				self.suffix := left.name_suffix;
																				self.prim_range := left.prim_range;
																				self.predir := left.predir;
																				self.prim_name := left.prim_name;
																				self.addr_suffix := left.addr_suffix;
																				self.postdir := left.postdir;
																				self.unit_desig := left.unit_desig;
																				self.sec_range := left.sec_range;
																				self.p_city_name := left.v_city_name;
																				self.st := left.st;
																				self.z5 := left.zip;
																				self.zip4 := left.zip4;
																				// self.email := left.;
																				self := [];
																				));

output(inLnJ, named('in_LnJ'));


/* ************************************
 *           Utility Sample           *
************************************* */
dsUtility := choosen(dataset(Utility_filename,Utility_layout,thor),Utility_filesize);
output(dsUtility,named('Utility_Sample'));

inUtility := project(dsUtility,transform(inputLayout,
																				self.source := 'Utility';
																				self.date_first_seen := left.date_first_seen;
																				// self.date_last_seen := left.date_last_seen;
																				self.unique_id := left.exchange_serial_number;
																				// self.seq := left.;
																				self.ssn := left.ssn;
																				// self.dob := left.dob;
																				self.phone10 := left.phone;
																				self.title := left.title;
																				self.fname := left.fname;
																				self.mname := left.mname;
																				self.lname := left.lname;
																				self.suffix := left.name_suffix;
																				self.prim_range := left.prim_range;
																				self.predir := left.predir;
																				self.prim_name := left.prim_name;
																				self.addr_suffix := left.addr_suffix;
																				self.postdir := left.postdir;
																				self.unit_desig := left.unit_desig;
																				self.sec_range := left.sec_range;
																				self.p_city_name := left.v_city_name;
																				self.st := left.st;
																				self.z5 := left.zip;
																				self.zip4 := left.zip4;
																				// self.email := left.;
																				self := [];
																				));

output(inUtility, named('in_Utility'));



/* ************************************
 *         Bankruptcy Sample          *
************************************* */
dsBankruptcy := choosen(dataset(Bankruptcy_filename,Bankruptcy_layout,thor),Bankruptcy_filesize);
output(dsBankruptcy,named('Bankruptcy_Sample'));

inBankruptcy := project(dsBankruptcy,transform(inputLayout,
																				self.source := 'Bankruptcy';
																				self.date_first_seen := left.date_first_seen;
																				self.date_last_seen := left.date_last_seen;
																				self.unique_id := left.id;
																				// self.seq := left.;
																				self.ssn := left.app_ssn;
																				// self.dob := left.dob;
																				// self.phone10 := left.phone;
																				self.title := left.title;
																				self.fname := left.fname;
																				self.mname := left.mname;
																				self.lname := left.lname;
																				self.suffix := left.name_suffix;
																				self.prim_range := left.prim_range;
																				self.predir := left.predir;
																				self.prim_name := left.prim_name;
																				self.addr_suffix := left.addr_suffix;
																				self.postdir := left.postdir;
																				self.unit_desig := left.unit_desig;
																				self.sec_range := left.sec_range;
																				self.p_city_name := left.v_city_name;
																				self.st := left.st;
																				self.z5 := left.zip;
																				self.zip4 := left.zip4;
																				// self.email := left.;
																				self := [];
																				));

output(inBankruptcy, named('in_Bankruptcy'));


/* ************************************
 *         Current Carrier Sample     *
************************************* */
dsCurrentCarrier := choosen(dataset(Current_Carrier_filename,Current_Carrier_layout,thor),Current_Carrier_filesize);
output(dsCurrentCarrier,named('Current_Carrier_Sample'));

inCurrentCarrier := project(dsCurrentCarrier,transform(inputLayout,
																				self.source := 'CurrentCarrier';
																				// self.date_first_seen := left.date_first_seen;
																				// self.date_last_seen := left.date_last_seen;
																				// self.unique_id := left.id;
																				// self.seq := left.;
																				self.ssn := left.ssn;
																				self.dob := (string)left.dob;
																				self.phone10 := left.area_code + left.phone_num;
																				// self.title := left.title;
																				self.fname := left.clean_fname;
																				self.mname := left.clean_mname;
																				self.lname := left.clean_lname;
																				// self.suffix := left.name_suffix;
																				self.prim_range := left.prim_range;
																				self.predir := left.predir;
																				self.prim_name := left.prim_name;
																				self.addr_suffix := left.addr_suffix;
																				self.postdir := left.postdir;
																				self.unit_desig := left.unit_desig;
																				self.sec_range := left.sec_range;
																				self.p_city_name := left.city;
																				self.st := left.st;
																				self.z5 := left.zip;
																				self.zip4 := left.zip4;
																				// self.email := left.;
																				self := [];
																				));

output(inCurrentCarrier, named('in_CurrentCarrier'));


/* ************************************
 *          Criminal Sample           *
************************************* */
dsCriminal := choosen(dataset(Criminal_filename,Criminal_layout,thor),Criminal_filesize);
output(dsCriminal,named('Criminal_Sample'));

inCriminal := project(dsCriminal,transform(inputLayout,
																				self.source := 'Criminal';
																				// self.date_first_seen := left.date_first_seen;
																				// self.date_last_seen := left.date_last_seen;
																				self.unique_id := left.offender_key;
																				// self.seq := left.;
																				self.ssn := left.ssn_appended;
																				self.dob := left.dob;
																				// self.phone10 := left.phone;
																				// self.title := left.title;
																				self.fname := left.fname;
																				self.mname := left.mname;
																				self.lname := left.lname;
																				self.suffix := left.name_suffix;
																				self.prim_range := left.prim_range;
																				self.predir := left.predir;
																				self.prim_name := left.prim_name;
																				self.addr_suffix := left.addr_suffix;
																				self.postdir := left.postdir;
																				self.unit_desig := left.unit_desig;
																				self.sec_range := left.sec_range;
																				self.p_city_name := left.v_city_name;
																				self.st := left.st;
																				self.z5 := left.zip5;
																				self.zip4 := left.zip4;
																				// self.email := left.;
																				self := [];
																				));

output(inCriminal, named('in_Criminal'));


/* ************************************
 *          Clue Auto Sample          *
************************************* */
dsClue_Auto := choosen(dataset(Clue_Auto_filename,Clue_Auto_layout,thor),Clue_Auto_filesize);
output(dsClue_Auto,named('Clue_Auto_Sample'));

inClue_Auto := project(dsClue_Auto,transform(inputLayout,
																				self.source := 'Clue_Auto';
																				// self.date_first_seen := left.date_first_seen;
																				// self.date_last_seen := left.date_last_seen;
																				self.unique_id := left.claim_no;
																				// self.seq := left.;
																				self.ssn := left.ssn;
																				// self.dob := left.dob;
																				// self.phone10 := left.phone;
																				// self.title := left.title;
																				self.fname := left.first_name;
																				self.mname := left.middle_name;
																				self.lname := left.last_name;
																				self.suffix := left.suffix_name;
																				self.prim_range := left.prim_range;
																				self.predir := left.predir;
																				self.prim_name := left.prim_name;
																				self.addr_suffix := left.addr_suffix;
																				self.postdir := left.postdir;
																				self.unit_desig := left.unit_desig;
																				self.sec_range := left.sec_range;
																				self.p_city_name := left.city;
																				self.st := left.state;
																				self.z5 := left.zip;
																				self.zip4 := left.zip_ext;
																				// self.email := left.;
																				self := [];
																				));

output(inClue_Auto, named('in_Clue_Auto'));


/* ************************************
 *   Prepare final input for linking  *
************************************* */
Layout_Did_OutBatch := record
		unsigned6 did := 0;
		unsigned2 score := 0;
		unsigned6 hhid := 0;
		didville.layout_did_inbatch;
		didville.layout_best_append;
		patriot.Layout_PatriotAppend;
		didville.layout_lookups;
		didville.layout_livingsits;
end;

Layout_Did_OutBatch did_prep(inputLayout le, integer c) := transform
				self.seq := c;
				self := le;
				self := [];
end;

indata := inCriminal + inProp + inLnJ + inBankruptcy + inCurrentCarrier + inUtility + inClue_Auto;

didprep := PROJECT(indata, did_prep(left, counter));
output(didprep, named('didprep'));


/* ************************************
 *                Linking             *
************************************* */
glb_ok := risk_indicators.iid_constants.glb_ok(1, false);  //parameters (glb, isFCRA)
dppa_ok := risk_indicators.iid_constants.dppa_ok(1, false);  //parameters (glb, isFCRA)
fz := '4GZ';
dedup_these := false;	// allow multiple DID's for bsVersion > 2
allscores := false;

didville.Mac_DIDAppend(didprep, resu, dedup_these, fz, allscores);
output(choosen(resu,all), named('did_results'));

