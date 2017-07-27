export Layout_DL := record
	unsigned6                dl_seq := 0;         //New field added for re-write
	unsigned6                did:= 0 ;
	unsigned6                Preglb_did:= 0 ;
	unsigned3                dt_first_seen;
	unsigned3                dt_last_seen;
	unsigned3                dt_vendor_first_reported;
	unsigned3                dt_vendor_last_reported;
	string14                 DLCP_Key  := '';     //New field added for re-write
	string2                  orig_state;
	string2					 source_code	:=	'AD';
	string1                  history :='';
	qstring52                name;
	string1                  addr_type := '';     //New field added for re-write                  
	qstring40                addr1;  // chgd, 30 to 40, 20030325,New Mexico, TK
	qstring20                city;
	qstring2                 state;
	qstring5                 zip;
	string2                  province := '';      //New field added for re-write
	string3                  country := '';       //New field added for re-write
	string10                 postal_code := '';   //New field added for re-write
	unsigned4                dob;
	string1                  race := '';
	string1                  sex_flag := '';
	string6                  license_class := ''; //New field added for re-write
	qstring4                 license_type;	  // chgd, 2 to 4, 20030514, Wisconsin, TK
	qstring4                 moxie_license_type := ''; //added for backwards compatibility (new field for re-write)
	qstring14                attention_flag := '';
	qstring8                 dod := '';
	qstring42                restrictions := '';
	qstring42				 restrictions_delimited := '';
	unsigned4                orig_expiration_date := 0;
	unsigned4                orig_issue_date := 0;
	unsigned4                lic_issue_date := 0;
	unsigned4                expiration_date := 0;
	unsigned3                active_date := 0;
	unsigned3                inactive_date := 0;
	qstring10                lic_endorsement := '';
	qstring4                 motorcycle_code := '';
	qstring24                dl_number; //changed 14 to 24,For certegy bug#50422  
	qstring9                 ssn := '';
	qstring9                 ssn_safe := '';
	qstring3                 age := '';
	string1					 privacy_flag := '';
	string1					 driver_edu_code := '';
	string1                  dup_lic_count:= '';
	string1                  rcd_stat_flag:= '';
	qstring3                 height := '';
	qstring3				 hair_color:= '';
	qstring3				 eye_color:= '';
	qstring3				 weight := '';
	qstring25                oos_previous_dl_number := '';
	string2                  oos_previous_st := '';
	qstring5                 title;
	qstring20                fname;
	qstring20                mname;
	qstring20                lname;
	qstring5                 name_suffix;
	qstring3                 cleaning_score;
	string1                  addr_fix_flag := '';
	qstring10                prim_range;
	qstring2                 predir;
	qstring28                prim_name;
	qstring4                 suffix;
	qstring2                 postdir;
	qstring10                unit_desig;
	qstring8                 sec_range;
	qstring25                p_city_name;
	qstring25                v_city_name;
	qstring2                 st;
	qstring5                 zip5;
	qstring4                 zip4;
	qstring4                 cart;
	string1                  cr_sort_sz;
	qstring4                 lot;
	string1                  lot_order;
	string2                  dpbc := '';
	string1                  chk_digit;
	string2                  rec_type;
	string2                  ace_fips_st := '';
	qstring3                 county;
	qstring10                geo_lat;
	qstring11                geo_long;
	qstring4                 msa := '';
	qstring7                 geo_blk;
	string1                  geo_match;
	qstring4                 err_stat;
	string3                  status := '';
	qstring2                 issuance;
	qstring8                 address_change := '';
	string1                  name_change := '';
	string1                  dob_change := '';
	string1                  sex_change := '';
	qstring24                old_dl_number := ''; //changed 14 to 24,For certegy bug#50422
	qstring9				 dl_key_number:= '';
	string3                  CDL_status := '';     //New field added for re-write	
end;