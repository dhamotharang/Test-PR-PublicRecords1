import crim_common;

string rundate:='20091209';
f1_vendor :=  			crim_common.File_Moxie_Crim_Offender2_Prod(vendor in 	['96','55','1E','1G','1P','1F','1H','2H','1D','2I','1N','1L','1Y','2G','2T','2S']);
f2_vendor := distribute(crim_common.File_Moxie_Court_Offenses_Prod(vendor in 	['96','55','1E','1G','1P','1F','1H','2H','1D','2I','1N','1L','1Y','2G','2T','2S']),hash(offender_key));
f3_vendor := distribute(crim_common.File_In_Court_Activity(vendor in 			['96','55','1E','1G','1P','1F','1H','2H','1D','2I','1N','1L','1Y','2G','2T','2S']),hash(offender_key));


f1_enth := distribute(ENTH(group(sort(distribute(f1_vendor,hash(vendor)),vendor,local),vendor),33,100,1),hash(offender_key));

layout_crim_offender_new
  := record
    string8        process_date;
	string8		   file_date:= '';	//new field
    string60       offender_key;
    string2        vendor;
    string2        state_origin;
    string1        data_type;
    string20       source_file;
    string35       case_number;
    string40       case_court;
    string50       case_name;
    string5        case_type;
    string25       case_type_desc;
    string8        case_filing_dt;
    string56       pty_nm;
    string1        pty_nm_fmt;
    string20       orig_lname;
    string20       orig_fname;
    string20       orig_mname;
    string10       orig_name_suffix;
    string1        pty_typ;
    string1        nitro_flag;
    string9        orig_ssn;			// *MASK*
    string10       dle_num;
    string9        fbi_num;
    string10       doc_num;
    string10       ins_num;
    string15       id_num;
    string25       dl_num;				// *MASK*
    string2        dl_state;			// *MASK*
    string2        citizenship;
    string8        dob;
    string8        dob_alias;
	string13	   county_of_birth:= ''; 	// new field
    string2        place_of_birth;
    string25       street_address_1;
    string25       street_address_2;
    string25       street_address_3;
    string10       street_address_4;
    string10       street_address_5;
	string13	   current_residence_county:= ''; 	//new field
	string13	   legal_residence_county:= ''; 	//new field
    string5        race;
    string30       race_desc;
    string1        sex;
    string5        hair_color;
    string25       hair_color_desc;
    string5        eye_color;
    string25       eye_color_desc;
    string5        skin_color;
    string25       skin_color_desc;
	string10	   scars_marks_tattoos_1:= ''; //new field
	string10	   scars_marks_tattoos_2:= ''; //new field
	string10	   scars_marks_tattoos_3:= ''; //new field
	string10	   scars_marks_tattoos_4:= ''; //new field
	string10	   scars_marks_tattoos_5:= ''; //new field
    string3        height;
    string3        weight;
    string10       party_status;
    string60       party_status_desc;
	string10	   _3g_offender:= ''; 		//new field
	string10	   violent_offender:= ''; 	//new field
	string10	   sex_offender:= ''; 		//new field
	string10	   vop_offender:= ''; 		//new field
	string26	   record_setup_date:= ''; 	//new field
    // string10       prim_range;
    // string2        predir;
    // string28       prim_name;
    // string4        addr_suffix;
    // string2        postdir;
    // string10       unit_desig;
    // string8        sec_range;
    // string25       p_city_name;
    // string25       v_city_name;
    // string2        state;
    // string5        zip5;
    // string4        zip4;
    // string4        cart;
    // string1        cr_sort_sz;
    // string4        lot;
    // string1        lot_order;
    // string2        dpbc;
    // string1        chk_digit;
    // string2        rec_type;
    // string2        ace_fips_st;
    // string3        ace_fips_county;
    // string10       geo_lat;
    // string11       geo_long;
    // string4        msa;
    // string7        geo_blk;
    // string1        geo_match;
    // string4        err_stat;
    // string5        title;
    // string20       fname;
    // string20       mname;
    // string20       lname;
    // string5        name_suffix;
    // string3        cleaning_score;
end;
layout_crim_offender_new to_prep1(f1_enth l) := transform
self.dl_num := if(l.dl_num<>'','99999999999','');
self.dl_state := if(l.dl_state<>'','XX','');
self.orig_ssn := if(l.orig_ssn<>'','734001234','');
self := l;
end;

Layout_In_Court_Offenses
 := record
    string8     process_date;
    string60    offender_key;
    string2     vendor;
    string2     state_origin;
    string20    source_file;
    string4     off_comp;
    string1     off_delete_flag;
    string8     off_date;
    string8     arr_date;
    string3     num_of_counts;
    string10    le_agency_cd;
    string50    le_agency_desc;
    string35    le_agency_case_number;
    string35    traffic_ticket_number;
    string25    traffic_dl_no;
    string2     traffic_dl_st;
    string20    arr_off_code;
    string75    arr_off_desc_1;
    string50    arr_off_desc_2;
    string5     arr_off_type_cd;
    string30    arr_off_type_desc;
    string5     arr_off_lev;
    string20    arr_statute;
    string70    arr_statute_desc;
    string8     arr_disp_date;
    string5     arr_disp_code;
    string30    arr_disp_desc_1;
    string30    arr_disp_desc_2;
    string10    pros_refer_cd;
    string50    pros_refer;
    string10    pros_assgn_cd;
    string50    pros_assgn;
    string1     pros_chg_rej;
    string20    pros_off_code;
    string75    pros_off_desc_1;
    string50    pros_off_desc_2;
    string5     pros_off_type_cd;
    string30    pros_off_type_desc;
    string5     pros_off_lev;
    string30    pros_act_filed;
    string35    court_case_number;
    string10    court_cd;
    string40    court_desc;
    string1     court_appeal_flag;
    string30    court_final_plea;
    string20    court_off_code;
    string75    court_off_desc_1;
    string50    court_off_desc_2;
    string5     court_off_type_cd;
    string30    court_off_type_desc;
    string5     court_off_lev;
    string20    court_statute;
    string50    court_additional_statutes;
    string70    court_statute_desc;
    string8     court_disp_date;
    string5     court_disp_code;
    string40    court_disp_desc_1;
    string40    court_disp_desc_2;
    string8     sent_date;
    string50    sent_jail;
    string50    sent_susp_time;
    string8     sent_court_cost;
    string9     sent_court_fine;
    string9     sent_susp_court_fine;
    string50    sent_probation;
    string5     sent_addl_prov_code;
    string40    sent_addl_prov_desc_1;
    string40    sent_addl_prov_desc_2;
    string2     sent_consec;
    string10    sent_agency_rec_cust_ori;
    string50    sent_agency_rec_cust;
    string8     appeal_date;
    string40    appeal_off_disp;
    string40    appeal_final_decision;
end;
layout_in_court_offenses to_prep2(f2_vendor l,f1_enth r) := transform
self := l;
end;

Layout_In_Court_Activity
 := record
     string8     process_date;
     string60    offender_key;
     string2     vendor;
     string2     state_origin;
     string20    source_file;
     string4     off_comp;
     string35    case_number;
     string2     event_type;
     string9     event_sort_key;
     string8     event_date;
     string10    event_location_code;
     string50    event_location_desc;
     string8     event_desc_code;
     string50    event_desc_1;
     string50    event_desc_2;
end;
layout_in_court_activity to_prep3(f3_vendor l,f1_enth r) := transform
self := l;
end;

f1_prep_for_hd := project(f1_enth,to_prep1(left));
f2_prep_for_hd := join(f2_vendor,f1_enth,left.offender_key=right.offender_key,to_prep2(left,right),local);
f3_prep_for_hd := join(f3_vendor,f1_enth,left.offender_key=right.offender_key,to_prep3(left,right),local);


output(f1_prep_for_hd,,'~thor::temp::hygienics_offender2_'+rundate,csv(separator('|'),heading(single)),overwrite);
output(f2_prep_for_hd,,'~thor::temp::hygienics_court_offenses_'+rundate,csv(separator('|'),heading(single)),overwrite);
output(f3_prep_for_hd,,'~thor::temp::hygienics_court_activity_'+rundate,csv(separator('|'),heading(single)),overwrite);
