import Batchshare, BIPV2;
EXPORT LAYOUTS := MODULE
	EXPORT Input := RECORD
			STRING20  acctno;
			STRING120 comp_name;
			STRING10  prim_range;
			STRING2   predir;
			STRING28  prim_name;
			
			STRING8   sec_range;
			STRING25  city_name;
			STRING2   st;
			STRING5   z5;
		
			STRING3   mileradius;
			STRING16  workphone;
			STRING9   fein;
			STRING16   seleid;
			STRING100   url;
			STRING20 		name_first;
			STRING20 		name_middle;
			STRING20 		name_last;
			STRING9     siccode;
			STRING9     Contact_SSN;
			UNSIGNED6   Contact_DID;
			STRING50    email;
		END;
	
  EXPORT Input_Processed :=
	RECORD(Input)
    STRING20 orig_acctno := '';
    Batchshare.Layouts.ShareErrors;
  END;
	
  EXPORT		
		// proxidSearchLayout := RECORDOF(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(DATASET([], 
											                 // BIPV2.IDfunctions.rec_SearchInput)).data2_);
    // this is a copy of the data2_ export		
		// it is referenced and hardcoded here
		// 
	  // This is a list of the fields that this query
		// will output.
		//
    proxidBipSearchFinal := RECORD	 
		 string20 acctno;
		 unsigned6 proxid;
		 unsigned2 proxweight;
		 unsigned6 seleid;
		 unsigned6 orgid;
		 unsigned6 ultid;
		 string120 company_name;
		 string5   title;
		 string20  fname;
		 string20  mname;
		 string20  lname;
		 string5   name_suffix;
		 string1   IsContact;
		 string9   contact_ssn;
		 string50  contact_email;
		
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  p_city_name;
		STRING25  v_city_name;
		STRING2   st;
		STRING5   zip;
		STRING4   zip4;
		string5   fips_county;
		STRING2   source;
		UNSIGNED4  dt_first_seen;
		UNSIGNED4  dt_last_seen;
		UNSIGNED4  dt_vendor_last_reported;
		string9   company_fein;
		string20  active_duns_number;
		string10  company_phone;
		string100 company_url;
		string9   company_sic_code1;
		unsigned6  contact_did;
		INTEGER2 match_cnp_name;
		INTEGER2 match_company_phone;
		INTEGER2 match_company_fein;
		INTEGER2 match_company_sic_code1;
		INTEGER2 match_prim_range;
		INTEGER2 match_prim_name;
	  INTEGER2 match_sec_range;
		INTEGER2 match_city;
		INTEGER2 match_st;
		INTEGER2 match_zip;
		INTEGER2 match_company_url;
		INTEGER2 match_contact_did;
		INTEGER2 match_fname;
		INTEGER2 match_mname;
		INTEGER2 match_lname;
		INTEGER2 match_contact_ssn;
		INTEGER2 match_contact_email;
		Batchshare.Layouts.ShareErrors;
		END;
    // this below also pertains to the layout of the data2_ export it is a bip search with results returned at the proxid level
		//
    // this data2_ SALT EXPORT layout has all the fields below..
		// those commented with //// are what is showing up in query output
		// those just commented out with // are other fields which are in the layout
		// note:  the salt export data2_ hardly ever changes 
		
		//// proxid, seleid, orgid, ultid
		//// company_name, title, fname, mname, lname, name_suffix, isContact, contact_ssn, contact_email,
		//// prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name,
		//// st, zip, zip4, fips_county, source, dt_first_seen, dt_last_seen, dt_vendor_last_reported,
		//// company_fein, active_duns_number, company_phone, company_url, company_sic_code1, contact_did
 
 
		                    //// proxweight, match_cnp_name,		                    
												//// match_cnp_name, match_company_phone, match_company_fein, match_company_sic_code1, ,
												//// match_prim_range, match_prim_name, match_sec_range, match_city, 
												//// match_st, match_zip, match_company_url, match_contact_did, match_fname,
												//// match_mname, match_lname, match_contact_ssn, match_contact_email, contact_did
												//// 
												// match_company_name_prefix,
		                    // match_cnp_number, match_cnp_btype, match_cnp_lowv, cnp_name, cnp_btype,company_name_prefix,
												// rcid,
												// record_score,proxscore,match_sele_flag, match_org_flag, match_ult_flag, match_city_clean,
												// match_contactname,match_streetaddress,weight,uniqueID,
												// match_fname_preferred, match_company_phone_3, match_company_phone_3_ex, match_company_phone_7,												
												// keysused,keysfailed,did_fetch,parent_proxid, sele_proxid, org_proxid, ultimate_proxid,
												// has_lgid,company_bdid,vl_id, source_record_id, source_docid, contact_email_domain,
												// contact_job_title_derived, address_type_derived, err_stat, is_sele_level,
												// is_org_level, is_ult_level, cnp_number, cnp_store_number, cnp_component_code, cnp_lowv,
												// cnp_translated, cnp_classid, city_clean,
												// company_phone_7, company_phone_3, company_phone_3_ex, fname_preferred, sele_flag,
												// org_flag, ult_flag, fallback_value, fullmatch_required, has_fullmatch,
												// recordsonly, is_fullmatch,
												// match_parent_proxid, match_sele_proxid, match_org_proxid, match_ultimate_proxid,
												// match_has_lgid, match_empid, match_source, match_source_record_id,
												// match_source_docid, match_company_name, match_active_duns_number,
												// match_iscontact, match_title, match_name_suffix, match_fallback_value,
												// is_truncated, dotscore, dotweight, empscore,empweight,powscore,powweight,
												// selescore,seleweight,orgscore,orgweight,ultscore,ultweight, city, phone_type,company_status_derived
				 																			 
END;