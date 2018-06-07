/*2012-08-31T19:10:22Z (Julie Franzer)
checking in with latest fields added

*/
/*2012-08-22T20:16:39Z (Julie Franzer)
Added Phone_type to the layout
*/
/*removed source_group, vendor_id, group1_id, and pflag*/
import address;

//PRESERVING EXISTING DEFAULTS
export Layout_Business_Linking := module

shared rTmpCompanyFields := record
 string tmp_join_id_company:='';//field is optional for DataTeam only and used to join Company and Contacts files together
 unsigned8	company_aceaid:=0; 
end;

shared rTmpContactFields := record
 string tmp_join_id_contact:='';//field is optional for DataTeam only and used to join Company and Contacts files together
 unsigned8 contact_rawaid:=0;
 unsigned8 contact_aceaid:=0; 
 address.Layout_Clean182_fips contact_address;
 string2	 contact_address_type:='';//C-CONTACT (default for unknown type), CM-CONTACT MAILING, CB-CONTACT BUSINESS, CP-CONTACT PRIMARY
 string3	 contact_address_country_code:='';
end;

export Company_ := record
 rTmpCompanyFields;
 string2		source;
 unsigned4	dt_first_seen:=0;						//Not using for Corps, but should be analyzed in other sources on a case by case basis for mapping.
 unsigned4	dt_last_seen:=0;						//Not using for Corps, but should be analyzed in other sources on a case by case basis for mapping.
 unsigned4	dt_vendor_first_reported:=0;//Not using for Corps, but should be analyzed in other sources on a case by case basis for mapping.
 unsigned4	dt_vendor_last_reported:=0;	//Not using for Corps, but should be analyzed in other sources on a case by case basis for mapping.
 unsigned6	rcid:=0;
 //COMPANY INFORMATION
 unsigned6	company_bdid:=0;
 string120	company_name;
 string50  	company_name_type_raw; //Raw vendor data or vendorÃ‚â€™s field name - Example: LEGAL, DBA, TRADENAME, etc.
 unsigned8	company_rawaid:=0;
 address.Layout_Clean182_fips company_address;
 string50	  company_address_type_raw; //Raw vendor data or vendorÃ‚â€™s field name - Examples: MAILING, PRIMARY, BUSINESS, etc.
 string1    company_address_category:='';//Pulled from ADVO
 string3	  company_address_country_code:=''; // 3 char country codes.
 string9  	company_fein:='';
 string1    best_fein_Indicator; // this is for DNB_FEIN only - 1 = best fein	
 string10 	company_phone; //7 to 10 digits
 string1		phone_type; // 'F' - fax; 'T' - Telephone
 string60	  company_org_structure_raw; //Raw vendor data or vendorÃ‚â€™s field name - Examples: PROPRIETORSHIP, PARTNERSHIP, CORPORATION, etc.
 unsigned4	company_incorporation_date;
 string8		company_sic_code1:=''; 
 string8		company_sic_code2:='';
 string8		company_sic_code3:='';
 string8		company_sic_code4:='';
 string8		company_sic_code5:=''; 
 string6    company_naics_code1:='';
 string6    company_naics_code2:='';
 string6    company_naics_code3:='';
 string6    company_naics_code4:='';
 string6    company_naics_code5:='';
 string6    company_ticker;
 string6		company_ticker_exchange; // stock exchange
 string1		company_foreign_domestic;//(D)omestic or (F)oreign
 string80		company_url;
 string2    company_inc_state; //State where the company was formed
 string32   company_charter_number; //Mostly corps only
 unsigned4  company_filing_date;  
 unsigned4  company_status_date;  
 unsigned4  company_foreign_date;  
 unsigned4  event_filing_date;  
 string50   company_name_status_raw; //Raw vendor data or vendorÃ‚â€™s field name - Examples: PRIOR, ACTIVE, etc.
 string50   company_status_raw; //Raw vendor data or vendorÃ‚â€™s field name - Examples: ACTIVE, DISSOLVED, etc.  
 unsigned4  dt_first_seen_company_name:=0;
 unsigned4  dt_last_seen_company_name:=0;
 unsigned4  dt_first_seen_company_address:=0;//Consider address_effective_date found in some sources
 unsigned4  dt_last_seen_company_address:=0;
 //INTERNAL & MISC. MANY OF THESE FIELDS EXIST IN THE CURRENT BH & BC INTERFACES
 string34		vl_id;
 boolean		current;//true if Current; false if Historical
 unsigned8	source_record_id:=0;//to tie back to the original record
 boolean		glb:=false;
 boolean		dppa:=false;
 unsigned2	phone_score:=0;
 string81		match_company_name:='';
 string20		match_branch_city:='';
 string25		match_geo_city:='';
 string9   	duns_number 	:=	'';
 string100 	source_docid	:=	'';
end;

export Contact := record
 rTmpContactFields; 
 //CONTACT INFORMATION
 boolean    is_contact:=false;//field is set during linking
 unsigned4	dt_first_seen_contact:=0;
 unsigned4	dt_last_seen_contact:=0;
 unsigned6	contact_did:=0;
 address.layout_clean_name contact_name; //People names only
 string50  	contact_type_raw:=''; //Raw vendor data or vendorÃ‚â€™s field name - Examples: APPLICANT, CONTACT, OFFICER, PRESIDENT, MEMBER, etc.
 string50		contact_job_title_raw:=''; //Raw vendor data or vendorÃ‚â€™s field name - Examples: CHIEF EXECUTIVE OFFICER, PRESIDENT, SECRETARY, etc.
 string9  	contact_ssn:='';
 unsigned4	contact_dob:=0;
 string30   contact_status_raw:=''; //Raw vendor data or vendorÃ‚â€™s field name - Examples: RESIGNED, ACTIVE, etc.  
 string60		contact_email:='';
 string30   contact_email_username:='';//Should be able to utilize email_data.fn_clean_email_username
 string30   contact_email_domain:='';//Should be able to utilize email_data.fn_clean_email_domain
 string10 	contact_phone:=''; //7 to 10 digits
 unsigned8	cid:=0;//contact_id
 unsigned1	contact_score:=0;
 string1		from_hdr:='N';
 string35		company_department:='';
end;

export Combined := record
 Company_;
 Contact;
end;

export Linking_Interface := record
 Combined -rTmpCompanyFields -rTmpContactFields;
end;

EXPORT Ingest_Layout_BIPV2_flat := RECORD
   STRING100 source_expanded;   
   STRING2	source;
   UNSIGNED4	dt_first_seen;
   UNSIGNED4	dt_last_seen;
   UNSIGNED4	dt_vendor_first_reported;
   UNSIGNED4	dt_vendor_last_reported;
   UNSIGNED6	rcid;
   UNSIGNED6	company_bdid;
   STRING120	company_name;
   STRING50	company_name_type_raw;
   UNSIGNED8	company_rawaid;
   STRING10	company_address_prim_range;
   STRING2	company_address_predir;
   STRING28	company_address_prim_name;
   STRING4	company_address_addr_suffix;
   STRING2	company_address_postdir;
   STRING10	company_address_unit_desig;
   STRING8	company_address_sec_range;
   STRING25	company_address_p_city_name;
   STRING25	company_address_v_city_name;
   STRING2	company_address_st;
   STRING5	company_address_zip;
   STRING4	company_address_zip4;
   STRING4	company_address_cart;
   STRING1	company_address_cr_sort_sz;
   STRING4	company_address_lot;
   STRING1	company_address_lot_order;
   STRING2	company_address_dbpc;
   STRING1	company_address_chk_digit;
   STRING2	company_address_rec_type;
   STRING2	company_address_fips_state;
   STRING3	company_address_fips_county;
   STRING10	company_address_geo_lat;
   STRING11	company_address_geo_long;
   STRING4	company_address_msa;
   STRING7	company_address_geo_blk;
   STRING1	company_address_geo_match;
   STRING4	company_address_err_stat;
   STRING50	company_address_type_raw;
   STRING1	company_address_category;
   STRING3	company_address_country_code;
   STRING9	company_fein;
   STRING1	best_fein_indicator;
   STRING10	company_phone;
   STRING1	phone_type;
   STRING60	company_org_structure_raw;
   UNSIGNED4	company_incorporation_date;
   STRING8	company_sic_code1;
   STRING8	company_sic_code2;
   STRING8	company_sic_code3;
   STRING8	company_sic_code4;
   STRING8	company_sic_code5;
   STRING6	company_naics_code1;
   STRING6	company_naics_code2;
   STRING6	company_naics_code3;
   STRING6	company_naics_code4;
   STRING6	company_naics_code5;
   STRING6	company_ticker;
   STRING6	company_ticker_exchange;
   STRING1	company_foreign_domestic;
   STRING80	company_url;
   STRING2	company_inc_state;
   STRING32	company_charter_number;
   UNSIGNED4	company_filing_date;
   UNSIGNED4	company_status_date;
   UNSIGNED4	company_foreign_date;
   UNSIGNED4	event_filing_date;
   STRING50	company_name_status_raw;
   STRING50	company_status_raw;
   UNSIGNED4	dt_first_seen_company_name;
   UNSIGNED4	dt_last_seen_company_name;
   UNSIGNED4	dt_first_seen_company_address;
   UNSIGNED4	dt_last_seen_company_address;
   STRING34	vl_id;
   BOOLEAN	current;
   UNSIGNED8	source_record_id;
   BOOLEAN	glb;
   BOOLEAN	dppa;
   UNSIGNED2	phone_score;
   STRING81	match_company_name;
   STRING20	match_branch_city;
   STRING25	match_geo_city;
   STRING9	duns_number;
   STRING100	source_docid;
   BOOLEAN	is_contact;
   UNSIGNED4	dt_first_seen_contact;
   UNSIGNED4	dt_last_seen_contact;
   UNSIGNED6	contact_did;
   STRING5	contact_name_title;
   STRING20	contact_name_fname;
   STRING20	contact_name_mname;
   STRING20	contact_name_lname;
   STRING5	contact_name_name_suffix;
   STRING3	contact_name_name_score;
   STRING50	contact_type_raw;
   STRING50	contact_job_title_raw;
   STRING9	contact_ssn;
   UNSIGNED4	contact_dob;
   STRING30	contact_status_raw;
   STRING60	contact_email;
   STRING30	contact_email_username;
   STRING30	contact_email_domain;
   STRING10	contact_phone;
   UNSIGNED8	cid;
   UNSIGNED1	contact_score;
   STRING1	from_hdr;
   STRING35	company_department;
   UNSIGNED8	company_aceaid;
   STRING50	company_name_type_derived;
   STRING50	company_address_type_derived;
   STRING60	company_org_structure_derived;
   STRING50	company_name_status_derived;
   STRING50	company_status_derived;
   STRING1	proxid_status_private;
   STRING1	powid_status_private;
   STRING1	seleid_status_private;
   STRING1	orgid_status_private;
   STRING1	ultid_status_private;
   STRING1	proxid_status_public;
   STRING1	powid_status_public;
   STRING1	seleid_status_public;
   STRING1	orgid_status_public;
   STRING1	ultid_status_public;
   STRING50	contact_type_derived;
   STRING50	contact_job_title_derived;
   STRING30	contact_status_derived;
   STRING1	address_type_derived;
   BOOLEAN	is_vanity_name_derived;
END;

end;