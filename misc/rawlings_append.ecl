import ut;

#option('skipFileFormatCrcCheck', 1);

format_date(string indate) := function
    DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';	
	in_Date := trim(indate, left,right);
	outDate := if(regexfind(DateFinder,in_Date),
				  intformat((integer)regexfind(DateFinder,in_Date,3),4,1) +
				  intformat((integer)regexfind(DateFinder,in_Date,1),2,1) +
				  intformat((integer)regexfind(DateFinder,in_Date,2),2,1),
				  '');						  
	return (outDate);
end;

inp_ds := misc.rawlings_file;

layout_c := RECORD
  string8 dt_first_seen;
  string8 dt_last_seen;
  string2 report_code;
  string25 report_category;
  string65 report_code_desc;
  string order_id;
  string sequence_nbr;
  string creation_date;
  string acct_nbr;
  string acct_suffix;
  string client_id;
  string adjuster_id;
  string state_nbr;
  string agency_id;
  string agency_type;
  string edit_agency_name;
  string service_id;
  string status_id;
  string reason_id;
  string queue;
  string claim_nbr;
  string itag;
  string itag_state;
  string otag;
  string otag_state;
  string loss_date;
  string loss_time;
  string precinct;
  string report_nbr;
  string house_nbr;
  string street;
  string apt_nbr;
  string cross_street;
  string city;
  string state;
  string zip5;
  string zip4;
  string county;
  string tag;
  string tag_state;
  string vin;
  string make;
  string model;
  string first_name_1;
  string middle_name_1;
  string last_name_1;
  string ssn_1;
  string dob_1;
  string first_name_2;
  string middle_name_2;
  string last_name_2;
  string first_name_3;
  string middle_name_3;
  string last_name_3;
  string drivers_license;
  string drivers_license_st;
  string processed_date;
  string print_date;
  string checkin_date;
  string cost_override;
  string additional_info;
  string special_note;
  string special_billing_id;
  string last_changed;
  string userid;
  string expected_turnaround;
  string orderpoint_status;
  string year;
  string actual_turnaround;
  string historical_notice;
  string client_quoteback;
  string agency_cost;
  string handling_fee;
  string second_request_print_date;
  string suffix_1;
  string gender_1;
  string state_service_type_name;
  string billing_restricted;
  string result_id;
  string batch_id;
  string page_count;
  string start_index;
  string end_index;
  string result_status;
  string result_type;
  string has_original_cover;
  string poor_quality;
  string batch_doc_nbr;
  string vin_entry_status;
  string pdf_image_hash;
  string tif_image_hash;
  string vehicle_id;
  string vehicle_incident_id;
  string vehicle_nbr;
  string vehicle_status;
  string vehvin;
  string vehyear;
  string vehmake;
  string vehmodel;
  string color;
  string impact_location;
  string inc_city;
  string state_abbr;
  string policy_nbr;
  string policy_exp_date;
  string commercial_vin;
  string car_fire;
  string airbags_deploy;
  string car_towed;
  string car_rollover;
  string decoded_info;
  string damage;
  string polk_validated_vin;
  string party_id;
  string party_type;
  string first_name;
  string last_name;
  string business_name;
  string pty_drivers_license;
  string pty_drivers_license_st;
  string dob;
  string carrier_id;
  string other_carrier;
  string carrier_name;
  string fulfilled_date;
  string policy_carrier_auto;
  string policy_nbr_auto;
  string policy_carrier_property;
  string policy_nbr_property;
  string previous_policy_type;
  string mortgage_loan_nbr;
  string mortgagee;
  string orig_order_id;
  string initial_order;
  string rules_status_cd;
  string version;
  string search_mode;
  string process_state;
  string processor;
  string42 vehicle_seg;
  string1 vehicle_seg_type;
  string4 model_year;
  string2 body_style_code;
  string4 engine_size;
  string1 fuel_code;
  string1 number_of_driving_wheels;
  string1 steering_type;
  string3 vina_series;
  string3 vina_model;
  string3 vina_make;
  string2 vina_body_style;
  string20 make_description;
  string20 model_description;
  string20 series_description;
  string2 car_cylinders;
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
  string5 z5;
  string4 z4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
 END;

c := dataset('~thor_data400::base::alpharetta::national_accidents_20100421',layout_c,flat);
layout_c_clean := record
	layout_c;
	string8 loss_date_ccyymmdd;
	string8 dob_1_clean;
	string8 dob_clean;
	end;
layout_c_clean to_c1(layout_c l) := transform
	self.loss_date_ccyymmdd := format_date(l.loss_date[1..10]);
	self.dob_1_clean  := format_date(l.dob_1[1..10]);
	self.dob_clean  := format_date(l.dob[1..10]);
	self := l;
	end;
c_clean := project(c,to_c1(left));

layout_join := record
	string 		inp_RAWLINGS_KEY;
	string 		inp_FIRST_NAME;
	string20 	fname;
	string 		inp_LAST_NAME;
	string20	Lname;	

	string 		inp_orig_SSN;
	string8 	inp_DOB;
	string8 	dob_1_clean;
	string8 	dob_clean;
	
	string25  	inp_p_city_name;
	string25	p_city_name;
	string25  	inp_v_city_name;
	string25 	v_city_name;
	string2  	inp_state;
	string2 	st;
	string5   	inp_zip5;
	string5		z5;

	//
	unsigned6 	inp_did := 0;
	unsigned6 	did;
	//
	string 		itag_state;
	string 		otag_state;
	string 		tag_state;
	string 		state;
	string 		drivers_license_st;
	string 		state_abbr;
	string 		pty_drivers_license_st;
	string 		process_state;
	//
	string8 	inp_DOL;
	string8		loss_date_ccyymmdd;
	unsigned4	dol_difference;
	//
	string25 	report_category;
	string65 	report_code_desc;
	string 		order_id;
	string 		acct_nbr;
	string 		acct_suffix;
	//
end;
layout_join to_j1(c_clean l, inp_ds r) := transform
	self.dol_difference := ut.DaysApart(l.loss_date_ccyymmdd,r.inp_dol);
	self := l;
	self := r;
	end;
res1 := join(c_clean,inp_ds,
			left.did<>0 and left.did=right.inp_did,
			to_j1(left,right),lookup);
res2 := join(c_clean,inp_ds,
			((left.dob_clean<>'' and left.dob_clean=right.inp_dob) or (left.dob_1_clean<>'' and left.dob_1_clean=right.inp_dob)) 
					and 
			(left.lname<>'' and left.lname=right.inp_lname and left.fname<>'' and left.fname=right.inp_fname),
			 to_j1(left,right),lookup);

						// and
				// (left.loss_date_ccyymmdd, right.inp_dol) 

res_dedup := dedup(sort(res1+res2,record),all);

res_st := res_dedup(st=inp_state or state_abbr=inp_state);

res_dol := res_st(dol_difference<=30);	

inp_c := count(inp_ds);
o1 := output(inp_c,named('count_input'));
res1_c := count(res1);
o2a := output(res1_c,named('count_res1'));
res2_c := count(res2);
o2b := output(res2_c,named('count_res2'));
res_dedup_c:= count(res_dedup);
o2c := output(res_dedup_c,named('count_res_dedup'));
res_st_c := count(res_st);
o2d := output(res_st_c,named('count_res_st'));
res_dol_c := count(res_dol);
o2e := output(res_dol_c,named('count_res_dol'));

o3a:=output(res_dedup);
o3b:=output(res_st);
o3c:=output(res_dol);

export rawlings_append := sequential(o1,o2a,o2b,o2c,o2d,o2e,o3a,o3b,o3c);
