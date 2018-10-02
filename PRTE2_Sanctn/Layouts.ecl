import prte_csv, sanctn;

EXPORT Layouts := module

//Incoming Layouts
export Incident_in := record
SANCTN.layout_SANCTN_incident_clean;
UNSIGNED8 __internal_fpos__;
string10 cust_name;
string10 bug_num;
string10 req;
end;

export Party_in := record
SANCTN.layout_SANCTN_did;
UNSIGNED8 __internal_fpos__;
string10 cust_name;
string10 bug_num;
string8 link_dob;
string9 link_ssn;
string9 link_fein;
string8 link_inc_date;
string10 req;	
end;

export license_in := record                                    
SANCTN.layout_SANCTN_license_clean;
UNSIGNED8 __internal_fpos__;
string10 cust_name;
string10 bug_num;
end;


export Party_AKA_DBA_in := record
SANCTN.layout_SANCTN_aka_dba_in;
UNSIGNED8 __internal_fpos__;
string10 cust_name;
string10 bug_num;
end;

export Rebuttal_in := record
SANCTN.layout_SANCTN_rebuttal_in;
UNSIGNED8 __internal_fpos__;
string10 cust_name;
string10 bug_num;
end;

export Incident_ext := record
Incident_in and not __internal_fpos__;
end;

export Party_ext := record
Party_in and not __internal_fpos__;
end;

export License_ext := record
license_in and not __internal_fpos__;
end;

export Party_AKA_DBA_ext := record
Party_AKA_DBA_in and not __internal_fpos__;
end;

export Rebuttal_ext := record
Rebuttal_in and not __internal_fpos__;
end;


export INCIDENT_base := record
// SANCTN.layout_SANCTN_incident_clean AND NOT [RECORD_TYPE, CUST_NAME, BUG_NUM];
Incident_ext AND NOT [RECORD_TYPE, CUST_NAME, BUG_NUM, REQ];
end;


export PARTY_base := record
// SANCTN.layout_SANCTN_did AND NOT [RECORD_TYPE, SOURCE_REC_ID, enh_did_src];
Party_ext AND NOT [RECORD_TYPE, 
										SOURCE_REC_ID, 
										enh_did_src, 
										CUST_NAME, 
										BUG_NUM, 
										LINK_DOB,
										LINK_SSN,
										LINK_FEIN,
										LINK_INC_DATE,
										REQ];
end;

EXPORT LICENSE_base := RECORD
// SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CUST_NAME, BUG_NUM];
License_ext AND NOT [RECORD_TYPE, CUST_NAME, BUG_NUM];
end;


EXPORT PARTY_AKA_DBA_base := RECORD
// SANCTN.layout_SANCTN_aka_dba_in AND NOT [RECORD_TYPE,LAST_NAME,FIRST_NAME,MIDDLE_NAME,CUST_NAME, BUG_NUM];
Party_AKA_DBA_ext AND NOT [RECORD_TYPE,LAST_NAME,FIRST_NAME,MIDDLE_NAME,CUST_NAME, BUG_NUM];
end;


EXPORT REBUTTAL_base := RECORD
Rebuttal_ext AND NOT [RECORD_TYPE, CUST_NAME, BUG_NUM];
end;


//KEY LAYOUTS
export bdid_key := RECORD
	UNSIGNED6 bdid;
	STRING8 	batch_number;
	STRING8 	incident_number;
	STRING8 	party_number;
end;	

	
export casenum_key := RECORD
	STRING20 	case_number;
	STRING8 	batch_number;
	STRING8 	incident_number;
	// UNSIGNED8 __internal_fpos__;
	END;
	
export did_key := RECORD

	UNSIGNED6 did;
	STRING8 	batch_number;
	STRING8 	incident_number;
	STRING8 	party_number;
	// UNSIGNED8 __internal_fpos__;	
end;

//Incident Key Layout
export Incident_Key := RECORD
  Incident_base AND NOT [PARTY_NUMBER,MODIFIED_DATE,LOAD_DATE,CLN_MODIFIED_DATE,CLN_LOAD_DATE];

END;

// Incident Midex Key Layout
export Incident_MIDEX_Key := RECORD
  Incident_base;
END;


//License Midex Layout
export  License_Midex_Key := RECORD
	License_base;
	string26 midex_rpt_nbr;
END;


//License Key Layout
export License_Key := RECORD
  License_base;
END;


export NMLS_MIDEX_KEY := RECORD
 // SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CLN_LICENSE_NUMBER];
 license_base and not [CLN_LICENSE_NUMBER];
 STRING26 		midex_rpt_nbr;
 STRING20 		NMLS_ID;
END;


export NMLS_ID_Key := RECORD
  // SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CLN_LICENSE_NUMBER];
	license_base and not [CLN_LICENSE_NUMBER];
	STRING20 		NMLS_ID;
	STRING26 		MIDEX_RPT_NBR;
END;


//MIDEX_RPT_NBR Key
export MIDEX_RPT_NBR_Key := RECORD
	Party_base;
	string26 midex_rpt_nbr;
END;


export Party_Key := RECORD
Party_ext AND NOT [enh_did_src, 
										CUST_NAME, 
										BUG_NUM, 
										LINK_DOB,
										LINK_SSN,
										LINK_FEIN,
										LINK_INC_DATE,
										REQ];
end;

//Rebuttal Key
export Rebuttal_Key := RECORD
  REBUTTAL_base;
END;


//Party AKA/DBA Key
export PARTY_AKA_DBA_Key := RECORD
  PARTY_AKA_DBA_base;
END;


	
// export nmls_id_key := RECORD
	// STRING20	nmls_id;
	// STRING8 	batch_number;
	// STRING8 	incident_number;
	// STRING8 	party_number;
	// STRING4 	order_number;
	// STRING50 	license_number;
	// STRING50 	license_type;
	// STRING20 	license_state;
	// STRING50 	std_type_desc;
	// STRING26 	midex_rpt_nbr;
	// UNSIGNED8 __internal_fpos__;	
// end;	

// export nmls_midex_key := RECORD
	// STRING26 	midex_rpt_nbr;
	// STRING8 	batch_number;
	// STRING8 	incident_number;
	// STRING8 	party_number;
	// STRING4 	order_number;
	// STRING50 	license_number;
	// STRING50 	license_type;
	// STRING20 	license_state;
	// STRING50 	std_type_desc;
	// STRING20	nmls_id;
	// UNSIGNED8 __internal_fpos__;
// END;

export ssn4_key := RECORD
	STRING4 ssn4;
	STRING8 batch_number;
	STRING8 incident_number;
	STRING8 party_number;
	// UNSIGNED8 __internal_fpos__;
end;

export linkids_key := RECORD
	unsigned6 ultid;
	unsigned6 orgid;
	unsigned6 seleid;
	unsigned6 proxid;
	unsigned6 powid;
	unsigned6 empid;
	unsigned6 dotid;
	unsigned2 ultscore;
	unsigned2 orgscore;
	unsigned2 selescore;
	unsigned2 proxscore;
	unsigned2 powscore;
	unsigned2 empscore;
	unsigned2 dotscore;
	unsigned2 ultweight;
	unsigned2 orgweight;
	unsigned2 seleweight;
	unsigned2 proxweight;
	unsigned2 powweight;
	unsigned2 empweight;
	unsigned2 dotweight;
	string8 	batch_number;
	string8 	incident_number;
	string8 	party_number;
	string1 	record_type;
	string4 	order_number;
	string45 party_name;
	string45 party_position;
	string45 party_vocation;
	string70 party_firm;
	string45 inaddress;
	string45 incity;
	string20 instate;
	string10 inzip;
	string11 ssnumber;
	string10 fines_levied;
	string10 restitution;
	string1 	ok_for_fcr;
	string255 party_text;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	string45 cname;
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
	string5 zip5;
	string4 zip4;
	string2 fips_state;
	string3 fips_county;
	string2 addr_rec_type;
	string10 geo_lat;
	string11 geo_long;
	string4 cbsa;
	string7 geo_blk;
	string1 geo_match;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string4 err_stat;
	unsigned8 source_rec_id;
	unsigned6 did;
	unsigned3 did_score;
	unsigned6 bdid;
	unsigned3 bdid_score;
	string9 ssn_appended;
	string60 dba_name;
	string30 contact_name;
	// integer1 fp;
 END;

	export autokeys := sanctn.layout_autokeys;
end;