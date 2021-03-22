import BatchServices, BatchShare, DidVille, progressive_phone, DeathV2_Services, Royalty, PhoneFinder_Services;

export Layouts := module


	export BatchIn := record
		BatchShare.Layouts.ShareDid;
	  // Client ID 
		BatchShare.Layouts.ShareAcct;
		// First Name
		// Middle Name
		// Last Name
		BatchShare.Layouts.ShareName.name_first;
		BatchShare.Layouts.ShareName.name_middle;
		BatchShare.Layouts.ShareName.name_last;
		BatchShare.Layouts.ShareName.name_suffix;
		// Primary Street Address
		// Primary City
		// Primary State
		// Primary Zip
		//typeof(BatchShare.Layouts.ShareAddress - [addr, county_name];
		BatchShare.Layouts.ShareAddress.prim_range;
		BatchShare.Layouts.ShareAddress.predir;
		BatchShare.Layouts.ShareAddress.prim_name;
		BatchShare.Layouts.ShareAddress.addr_suffix;
		BatchShare.Layouts.ShareAddress.postdir;
		BatchShare.Layouts.ShareAddress.unit_desig;
		BatchShare.Layouts.ShareAddress.sec_range;
		BatchShare.Layouts.ShareAddress.p_city_name;
		BatchShare.Layouts.ShareAddress.st;
		BatchShare.Layouts.ShareAddress.z5;
		BatchShare.Layouts.ShareAddress.zip4;
		// SSN
		// DOB
		BatchShare.Layouts.SharePII.ssn;
		STRING4 SSNLast4;
		BatchShare.Layouts.SharePII.dob;
		
		// Record Type
		string1	record_type; // minor or non minor
		// Primary Address Date
		string8 primary_address_date;
		// Enrollment Date
		string8 enrollment_date;
		// P_Phone number
		typeof(progressive_phone.layout_progressive_batch_out.subj_phone10) primary_phone_number;
		// Email
		string email;
		// Guardian First Name
		typeof(BatchShare.Layouts.ShareName.name_first) guardian_name_first;
		// Guardian Last Name
		typeof(BatchShare.Layouts.ShareName.name_last) guardian_name_last;
		// Guardian DOB
		typeof(BatchShare.Layouts.SharePII.DOB) guardian_DOB;
		// Guardian SSN
		typeof(BatchShare.Layouts.SharePII.SSN) guardian_SSN;
		STRING4 GuardianSSNLast4;
	end;
	
	EXPORT batch_in_extended:=RECORD
	BATCHIN;
	unsigned4	seq;
	END;
	
	
	export BatchOut := record
		BatchShare.Layouts.ShareAcct;
		string100 LN_search_name;		
	  string1 	LN_search_name_type;		
		//string8 	matchcodes;
// Best		
		typeof(BatchShare.Layouts.ShareDid.Did) did;
		//string3 did_score;
		typeof(DidVille.Layout_Did_OutBatch.score) did_score;
		//string1 gender;
		typeof(DidVille.layout_livingSits.gender) gender;
		//string name;
		string100 name;
		//string9 ssn;
		typeof(DidVille.Layout_Did_InBatch.ssn) ssn;
		//string8 dob;
		typeof(DidVille.Layout_Did_InBatch.dob) dob;
// Computed Address		
		string255 address;
		string8 address_match_codes; 
		string25 city;
		string2 st;
		string5 z5;
		string4 zip4;
		string18 county_name;
		string6 addr_dt_last_seen;
		string6 addr_dt_first_seen;
		string1 addr_confidence;
		string10 latitude;
		string11 longitude;
		string1  addr_older_than_90_days;
		//string5	 fips_county

// Computed Address New
		string255 address_new;
		string8 address_new_match_codes;
		string25 city_new;
		string2 st_new;
		string5 z5_new;
		string4 zip4_new;
		string18 county_name_new;
		string6 addr_dt_last_seen_new;
		string6 addr_dt_first_seen_new;
		string1 addr_confidence_new;
		string10 latitude_new;
		string11 longitude_new;
		//string5	 fips_county_new;
		string4  addressdescriptioncode1;	
		string100 addressDescription1;	
		string4 addressdescriptioncode2;	
		string100 addressDescription2;	
		string4 addressdescriptioncode3;	
		string100 addressDescription3;	
		string4 addressdescriptioncode4;	
		string100 addressDescription4;	
		string4 addressdescriptioncode5;	
		string100 addressDescription5;	
		string4 addressdescriptioncode6;	
		string100 addressDescription6;	
		string4 addressdescriptioncode7;	
		string100 addressDescription7;	
		string4 addressdescriptioncode8;	
		string100 addressDescription8;	
		string4 addressdescriptioncode9;	
		string100 addressDescription9;	
		string4 addressdescriptioncode10;	
		string100 addressDescription10;	


//Scores ,  and 
    string3 name_score;
		string3 ssn_score;
		string3 dob_score;
		 
// Phones		
		string8 Phone1_Match_Codes;
		//string10 subj_phone1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_phone10) Phone1_Number;
		//string120 subj_phone_listing_name1;
		string120 Phone1_Number_Listing_Name; /*			string20 subj_first;
																								string20 subj_middle;
																								string20 subj_last;
																								string5 subj_suffix;  */
		//string20 subj_phone_possible_relationship1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_phone_relationship) Phone1_Possible_Relation;
		//string6 subj_date_first_seen1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_date_first) Phone1_First_Seen_Date;
		//string6 subj_date_last_seen1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_date_last) Phone1_Last_Seen_Date;
		//string1 subj_phone_type1;
		// typeof(progressive_phone.layout_progressive_batch_out.phpl_phones_plus_type) Phone1_Type;
		STRING Phone1_Type;
		//string1 subj_phone_line_type1;
		// typeof(progressive_phone.layout_progressive_batch_out.switch_type) Phone1_Line_Type; // Cell . Landline
		STRING Phone1_Line_Type; // Cell . Landline
		//string1 subj_phone_confidence1		
		typeof(progressive_phone.layout_progressive_batch_out.phone_score) Phone1_Score; // derived from progressive_phone.layout_progressive_batch_out.phone_score
		string1 Phone1_Score_confidence; // derived from progressive_phone.layout_progressive_batch_out.phone_score [H, M, L]
		string6 Phone1_Score_confidence_star; // [5 Star, 4 Star, 3 Star]
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.Carrier) Phone1_Carrier;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.CarrierCity) Phone1_Carrier_City;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.CarrierState) Phone1_Carrier_State;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.PhoneStatus) Phone1_Phone_Status;

		string8 Phone2_Match_Codes;
		//string10 subj_phone1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_phone10) Phone2_Number;
		//string120 subj_phone_listing_name1;
		string120 Phone2_Number_Listing_Name; /*			string20 subj_first;
																								string20 subj_middle;
																								string20 subj_last;
																								string5 subj_suffix;  */
		//string20 subj_phone_possible_relationship1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_phone_relationship) Phone2_Possible_Relation;
		//string6 subj_date_first_seen1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_date_first) Phone2_First_Seen_Date;
		//string6 subj_date_last_seen1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_date_last) Phone2_Last_Seen_Date;
		//string1 subj_phone_type1;
		// typeof(progressive_phone.layout_progressive_batch_out.phpl_phones_plus_type) Phone2_Type;
		STRING Phone2_Type;
		//string1 subj_phone_line_type1;
		STRING Phone2_Line_Type; // Cell . Landline
		//string1 subj_phone_confidence1		
		typeof(progressive_phone.layout_progressive_batch_out.phone_score) Phone2_Score; // derived from progressive_phone.layout_progressive_batch_out.phone_score
		string1 Phone2_Score_confidence; // derived from progressive_phone.layout_progressive_batch_out.phone_score [H, M, L]
		string6 Phone2_Score_confidence_star; // [5 Star, 4 Star, 3 Star]
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.Carrier) Phone2_Carrier;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.CarrierCity) Phone2_Carrier_City;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.CarrierState) Phone2_Carrier_State;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.PhoneStatus) Phone2_Phone_Status;
		
		string8 Phone3_Match_Codes;
		//string10 subj_phone1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_phone10) Phone3_Number;
		//string120 subj_phone_listing_name1;
		string120 Phone3_Number_Listing_Name; /*			string20 subj_first;
																								string20 subj_middle;
																								string20 subj_last;
																								string5 subj_suffix;  */
		//string20 subj_phone_possible_relationship1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_phone_relationship) Phone3_Possible_Relation;
		//string6 subj_date_first_seen1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_date_first) Phone3_First_Seen_Date;
		//string6 subj_date_last_seen1;
		typeof(progressive_phone.layout_progressive_batch_out.subj_date_last) Phone3_Last_Seen_Date;
		//string1 subj_phone_type1;
		// typeof(progressive_phone.layout_progressive_batch_out.phpl_phones_plus_type) Phone3_Type;
		STRING Phone3_Type;
		//string1 subj_phone_line_type1;
		STRING Phone3_Line_Type; // Cell . Landline
		//string1 subj_phone_confidence1		
		typeof(progressive_phone.layout_progressive_batch_out.phone_score) Phone3_Score; // derived from progressive_phone.layout_progressive_batch_out.phone_score
		string1 Phone3_Score_confidence; // derived from progressive_phone.layout_progressive_batch_out.phone_score [H, M, L]
		string6 Phone3_Score_confidence_star; // [5 Star, 4 Star, 3 Star]
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.Carrier) Phone3_Carrier;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.CarrierCity) Phone3_Carrier_City;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.CarrierState) Phone3_Carrier_State;
		typeof(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut.PhoneStatus) Phone3_Phone_Status;

// Death
		//string8 date_of_death;
		typeof(BatchServices.layout_Death_Batch_out.dod8) Date_of_death;
		string31 dcd_match_code; // this will be death match code + 1 string for 'D' or DOB matches
		typeof(BatchServices.layout_Death_Batch_out.VorP_code) verified_or_proof_code;
		typeof(BatchServices.layout_Death_Batch_out.death_rec_src) death_rec_src := '';
		string3	deceased_source;
		typeof(BatchServices.layout_Death_Batch_out.isdeepdive)	dcd_isdeepdive := FALSE;
		typeof(BatchServices.layout_Death_Batch_out.filedate) dcd_filedate;
		typeof(BatchServices.layout_Death_Batch_out.state_death_flag) state_death_flag := '';
		typeof(BatchServices.layout_Death_Batch_out.state_death_id) state_death_id;
		typeof(BatchServices.layout_Death_Batch_out.rec_type) dcd_rec_type;
		typeof(BatchServices.layout_Death_Batch_out.rec_type_orig) dcd_rec_type_orig;

		//  Email
		STRING    orig_email;
		string    Email1;
		STRING2 email1_email_src;
		STRING100 email1_email_username;
		STRING120 email1_email_domain;
		UNSIGNED6 email1_did;
		UNSIGNED8 email1_did_score:=0;
		STRING8 email1_date_first_seen;
		STRING8 email1_date_last_seen;
		UNSIGNED4 email1_ln_date_first:=0;
		UNSIGNED4 email1_ln_date_last:=0;
		STRING8 email1_date_vendor_first_reported;
		STRING8 email1_date_vendor_last_reported;
		STRING8 email1_process_date;
		STRING1 email1_activecode;
		BOOLEAN email1_is_current;
		UNSIGNED email1_rules;
		BOOLEAN email1_isdeepdive:=FALSE;
		UNSIGNED email1_subject_lexid:=0;
		STRING email1_orig_CompanyName;
		STRING email1_cln_CompanyName;
		STRING email1_CompanyTitle;
		UNSIGNED6 email1_DotID;
		UNSIGNED6 email1_EmpID;
		UNSIGNED6 email1_POWID;
		UNSIGNED6 email1_ProxID;
		UNSIGNED6 email1_SELEID;
		UNSIGNED6 email1_OrgID;
		UNSIGNED6 email1_UltID;
		STRING15 email1_email_status:='';
		STRING50 email1_email_status_reason:='';
		STRING70 email1_additional_status_info:='';
		STRING8 email1_date_last_verified:='';
		STRING50 email1_relationship:='';
		STRING50 email1_record_err_msg:='';
		UNSIGNED2 email1_record_err_code:=0;
		BOOLEAN email1_is_rejected_rec:=FALSE;
		BOOLEAN email1_isRoyaltySource:=FALSE;
		UNSIGNED email1_num_sources:=0;
		STRING8 email1_latest_orig_login_date:='';
		UNSIGNED email1_num_email_per_did:=0;
		UNSIGNED email1_num_did_per_email:=0;
		string Email2;
		STRING2 email2_email_src;
		STRING100 email2_email_username;
		STRING120 email2_email_domain;
		UNSIGNED6 email2_did;
		UNSIGNED8 email2_did_score:=0;
		STRING8 email2_date_first_seen;
		STRING8 email2_date_last_seen;
		UNSIGNED4 email2_ln_date_first:=0;
		UNSIGNED4 email2_ln_date_last:=0;
		STRING8 email2_date_vendor_first_reported;
		STRING8 email2_date_vendor_last_reported;
		STRING8 email2_process_date;
		STRING1 email2_activecode;
		BOOLEAN email2_is_current;
		UNSIGNED email2_rules;
		BOOLEAN email2_isdeepdive:=FALSE;
		UNSIGNED email2_subject_lexid:=0;
		STRING email2_orig_CompanyName;
		STRING email2_cln_CompanyName;
		STRING email2_CompanyTitle;
		UNSIGNED6 email2_DotID;
		UNSIGNED6 email2_EmpID;
		UNSIGNED6 email2_POWID;
		UNSIGNED6 email2_ProxID;
		UNSIGNED6 email2_SELEID;
		UNSIGNED6 email2_OrgID;
		UNSIGNED6 email2_UltID;
		STRING15 email2_email_status:='';
		STRING50 email2_email_status_reason:='';
		STRING70 email2_additional_status_info:='';
		STRING8 email2_date_last_verified:='';
		STRING50 email2_relationship:='';
		STRING50 email2_record_err_msg:='';
		UNSIGNED2 email2_record_err_code:=0;
		BOOLEAN email2_is_rejected_rec:=FALSE;
		BOOLEAN email2_isRoyaltySource:=FALSE;
		UNSIGNED email2_num_sources:=0;
		STRING8 email2_latest_orig_login_date:='';
		UNSIGNED email2_num_email_per_did:=0;
		UNSIGNED email2_num_did_per_email:=0;
		string Email3;
		STRING2 email3_email_src;
		STRING100 email3_email_username;
		STRING120 email3_email_domain;
		UNSIGNED6 email3_did;
		UNSIGNED8 email3_did_score:=0;
		STRING8 email3_date_first_seen;
		STRING8 email3_date_last_seen;
		UNSIGNED4 email3_ln_date_first:=0;
		UNSIGNED4 email3_ln_date_last:=0;
		STRING8 email3_date_vendor_first_reported;
		STRING8 email3_date_vendor_last_reported;
		STRING8 email3_process_date;
		STRING1 email3_activecode;
		BOOLEAN email3_is_current;
		UNSIGNED email3_rules;
		BOOLEAN email3_isdeepdive:=FALSE;
		UNSIGNED email3_subject_lexid:=0;
		STRING email3_orig_CompanyName;
		STRING email3_cln_CompanyName;
		STRING email3_CompanyTitle;
		UNSIGNED6 email3_DotID;
		UNSIGNED6 email3_EmpID;
		UNSIGNED6 email3_POWID;
		UNSIGNED6 email3_ProxID;
		UNSIGNED6 email3_SELEID;
		UNSIGNED6 email3_OrgID;
		UNSIGNED6 email3_UltID;
		STRING15 email3_email_status:='';
		STRING50 email3_email_status_reason:='';
		STRING70 email3_additional_status_info:='';
		STRING8 email3_date_last_verified:='';
		STRING50 email3_relationship:='';
		STRING50 email3_record_err_msg:='';
		UNSIGNED2 email3_record_err_code:=0;
		BOOLEAN email3_is_rejected_rec:=FALSE;
		BOOLEAN email3_isRoyaltySource:=FALSE;
		UNSIGNED email3_num_sources:=0;
		STRING8 email3_latest_orig_login_date:='';
		UNSIGNED email3_num_email_per_did:=0;
		UNSIGNED email3_num_did_per_email:=0;
		string Email4;
		STRING2 email4_email_src;
		STRING100 email4_email_username;
		STRING120 email4_email_domain;
		UNSIGNED6 email4_did;
		UNSIGNED8 email4_did_score:=0;
		STRING8 email4_date_first_seen;
		STRING8 email4_date_last_seen;
		UNSIGNED4 email4_ln_date_first:=0;
		UNSIGNED4 email4_ln_date_last:=0;
		STRING8 email4_date_vendor_first_reported;
		STRING8 email4_date_vendor_last_reported;
		STRING8 email4_process_date;
		STRING1 email4_activecode;
		BOOLEAN email4_is_current;
		UNSIGNED email4_rules;
		BOOLEAN email4_isdeepdive:=FALSE;
		UNSIGNED email4_subject_lexid:=0;
		STRING email4_orig_CompanyName;
		STRING email4_cln_CompanyName;
		STRING email4_CompanyTitle;
		UNSIGNED6 email4_DotID;
		UNSIGNED6 email4_EmpID;
		UNSIGNED6 email4_POWID;
		UNSIGNED6 email4_ProxID;
		UNSIGNED6 email4_SELEID;
		UNSIGNED6 email4_OrgID;
		UNSIGNED6 email4_UltID;
		STRING15 email4_email_status:='';
		STRING50 email4_email_status_reason:='';
		STRING70 email4_additional_status_info:='';
		STRING8 email4_date_last_verified:='';
		STRING50 email4_relationship:='';
		STRING50 email4_record_err_msg:='';
		UNSIGNED2 email4_record_err_code:=0;
		BOOLEAN email4_is_rejected_rec:=FALSE;
		BOOLEAN email4_isRoyaltySource:=FALSE;
		UNSIGNED email4_num_sources:=0;
		STRING8 email4_latest_orig_login_date:='';
		UNSIGNED email4_num_email_per_did:=0;
		UNSIGNED email4_num_did_per_email:=0;
		string Email5;
		STRING2 email5_email_src;
		STRING100 email5_email_username;
		STRING120 email5_email_domain;
		UNSIGNED6 email5_did;
		UNSIGNED8 email5_did_score:=0;
		STRING8 email5_date_first_seen;
		STRING8 email5_date_last_seen;
		UNSIGNED4 email5_ln_date_first:=0;
		UNSIGNED4 email5_ln_date_last:=0;
		STRING8 email5_date_vendor_first_reported;
		STRING8 email5_date_vendor_last_reported;
		STRING8 email5_process_date;
		STRING1 email5_activecode;
		BOOLEAN email5_is_current;
		UNSIGNED email5_rules;
		BOOLEAN email5_isdeepdive:=FALSE;
		UNSIGNED email5_subject_lexid:=0;
		STRING email5_orig_CompanyName;
		STRING email5_cln_CompanyName;
		STRING email5_CompanyTitle;
		UNSIGNED6 email5_DotID;
		UNSIGNED6 email5_EmpID;
		UNSIGNED6 email5_POWID;
		UNSIGNED6 email5_ProxID;
		UNSIGNED6 email5_SELEID;
		UNSIGNED6 email5_OrgID;
		UNSIGNED6 email5_UltID;
		STRING15 email5_email_status:='';
		STRING50 email5_email_status_reason:='';
		STRING70 email5_additional_status_info:='';
		STRING8 email5_date_last_verified:='';
		STRING50 email5_relationship:='';
		STRING50 email5_record_err_msg:='';
		UNSIGNED2 email5_record_err_code:=0;
		BOOLEAN email5_is_rejected_rec:=FALSE;
		BOOLEAN email5_isRoyaltySource:=FALSE;
		UNSIGNED email5_num_sources:=0;
		STRING8 email5_latest_orig_login_date:='';
		UNSIGNED email5_num_email_per_did:=0;
		UNSIGNED email5_num_did_per_email:=0;
		string Email6;
		STRING2 email6_email_src;
		STRING100 email6_email_username;
		STRING120 email6_email_domain;
		UNSIGNED6 email6_did;
		UNSIGNED8 email6_did_score:=0;
		STRING8 email6_date_first_seen;
		STRING8 email6_date_last_seen;
		UNSIGNED4 email6_ln_date_first:=0;
		UNSIGNED4 email6_ln_date_last:=0;
		STRING8 email6_date_vendor_first_reported;
		STRING8 email6_date_vendor_last_reported;
		STRING8 email6_process_date;
		STRING1 email6_activecode;
		BOOLEAN email6_is_current;
		UNSIGNED email6_rules;
		BOOLEAN email6_isdeepdive:=FALSE;
		UNSIGNED email6_subject_lexid:=0;
		STRING email6_orig_CompanyName;
		STRING email6_cln_CompanyName;
		STRING email6_CompanyTitle;
		UNSIGNED6 email6_DotID;
		UNSIGNED6 email6_EmpID;
		UNSIGNED6 email6_POWID;
		UNSIGNED6 email6_ProxID;
		UNSIGNED6 email6_SELEID;
		UNSIGNED6 email6_OrgID;
		UNSIGNED6 email6_UltID;
		STRING15 email6_email_status:='';
		STRING50 email6_email_status_reason:='';
		STRING70 email6_additional_status_info:='';
		STRING8 email6_date_last_verified:='';
		STRING50 email6_relationship:='';
		STRING50 email6_record_err_msg:='';
		UNSIGNED2 email6_record_err_code:=0;
		BOOLEAN email6_is_rejected_rec:=FALSE;
		BOOLEAN email6_isRoyaltySource:=FALSE;
		UNSIGNED email6_num_sources:=0;
		STRING8 email6_latest_orig_login_date:='';
		UNSIGNED email6_num_email_per_did:=0;
		UNSIGNED email6_num_did_per_email:=0;
		string Email7;
		STRING2 email7_email_src;
		STRING100 email7_email_username;
		STRING120 email7_email_domain;
		UNSIGNED6 email7_did;
		UNSIGNED8 email7_did_score:=0;
		STRING8 email7_date_first_seen;
		STRING8 email7_date_last_seen;
		UNSIGNED4 email7_ln_date_first:=0;
		UNSIGNED4 email7_ln_date_last:=0;
		STRING8 email7_date_vendor_first_reported;
		STRING8 email7_date_vendor_last_reported;
		STRING8 email7_process_date;
		STRING1 email7_activecode;
		BOOLEAN email7_is_current;
		UNSIGNED email7_rules;
		BOOLEAN email7_isdeepdive:=FALSE;
		UNSIGNED email7_subject_lexid:=0;
		STRING email7_orig_CompanyName;
		STRING email7_cln_CompanyName;
		STRING email7_CompanyTitle;
		UNSIGNED6 email7_DotID;
		UNSIGNED6 email7_EmpID;
		UNSIGNED6 email7_POWID;
		UNSIGNED6 email7_ProxID;
		UNSIGNED6 email7_SELEID;
		UNSIGNED6 email7_OrgID;
		UNSIGNED6 email7_UltID;
		STRING15 email7_email_status:='';
		STRING50 email7_email_status_reason:='';
		STRING70 email7_additional_status_info:='';
		STRING8 email7_date_last_verified:='';
		STRING50 email7_relationship:='';
		STRING50 email7_record_err_msg:='';
		UNSIGNED2 email7_record_err_code:=0;
		BOOLEAN email7_is_rejected_rec:=FALSE;
		BOOLEAN email7_isRoyaltySource:=FALSE;
		UNSIGNED email7_num_sources:=0;
		STRING8 email7_latest_orig_login_date:='';
		UNSIGNED email7_num_email_per_did:=0;
		UNSIGNED email7_num_did_per_email:=0;
		string Email8;
		STRING2 email8_email_src;
		STRING100 email8_email_username;
		STRING120 email8_email_domain;
		UNSIGNED6 email8_did;
		UNSIGNED8 email8_did_score:=0;
		STRING8 email8_date_first_seen;
		STRING8 email8_date_last_seen;
		UNSIGNED4 email8_ln_date_first:=0;
		UNSIGNED4 email8_ln_date_last:=0;
		STRING8 email8_date_vendor_first_reported;
		STRING8 email8_date_vendor_last_reported;
		STRING8 email8_process_date;
		STRING1 email8_activecode;
		BOOLEAN email8_is_current;
		UNSIGNED email8_rules;
		BOOLEAN email8_isdeepdive:=FALSE;
		UNSIGNED email8_subject_lexid:=0;
		STRING email8_orig_CompanyName;
		STRING email8_cln_CompanyName;
		STRING email8_CompanyTitle;
		UNSIGNED6 email8_DotID;
		UNSIGNED6 email8_EmpID;
		UNSIGNED6 email8_POWID;
		UNSIGNED6 email8_ProxID;
		UNSIGNED6 email8_SELEID;
		UNSIGNED6 email8_OrgID;
		UNSIGNED6 email8_UltID;
		STRING15 email8_email_status:='';
		STRING50 email8_email_status_reason:='';
		STRING70 email8_additional_status_info:='';
		STRING8 email8_date_last_verified:='';
		STRING50 email8_relationship:='';
		STRING50 email8_record_err_msg:='';
		UNSIGNED2 email8_record_err_code:=0;
		BOOLEAN email8_is_rejected_rec:=FALSE;
		BOOLEAN email8_isRoyaltySource:=FALSE;
		UNSIGNED email8_num_sources:=0;
		STRING8 email8_latest_orig_login_date:='';
		UNSIGNED email8_num_email_per_did:=0;
		UNSIGNED email8_num_did_per_email:=0;
		string Email9;
		STRING2 email9_email_src;
		STRING100 email9_email_username;
		STRING120 email9_email_domain;
		UNSIGNED6 email9_did;
		UNSIGNED8 email9_did_score:=0;
		STRING8 email9_date_first_seen;
		STRING8 email9_date_last_seen;
		UNSIGNED4 email9_ln_date_first:=0;
		UNSIGNED4 email9_ln_date_last:=0;
		STRING8 email9_date_vendor_first_reported;
		STRING8 email9_date_vendor_last_reported;
		STRING8 email9_process_date;
		STRING1 email9_activecode;
		BOOLEAN email9_is_current;
		UNSIGNED email9_rules;
		BOOLEAN email9_isdeepdive:=FALSE;
		UNSIGNED email9_subject_lexid:=0;
		STRING email9_orig_CompanyName;
		STRING email9_cln_CompanyName;
		STRING email9_CompanyTitle;
		UNSIGNED6 email9_DotID;
		UNSIGNED6 email9_EmpID;
		UNSIGNED6 email9_POWID;
		UNSIGNED6 email9_ProxID;
		UNSIGNED6 email9_SELEID;
		UNSIGNED6 email9_OrgID;
		UNSIGNED6 email9_UltID;
		STRING15 email9_email_status:='';
		STRING50 email9_email_status_reason:='';
		STRING70 email9_additional_status_info:='';
		STRING8 email9_date_last_verified:='';
		STRING50 email9_relationship:='';
		STRING50 email9_record_err_msg:='';
		UNSIGNED2 email9_record_err_code:=0;
		BOOLEAN email9_is_rejected_rec:=FALSE;
		BOOLEAN email9_isRoyaltySource:=FALSE;
		UNSIGNED email9_num_sources:=0;
		STRING8 email9_latest_orig_login_date:='';
		UNSIGNED email9_num_email_per_did:=0;
		UNSIGNED email9_num_did_per_email:=0;
		string Email10;
		STRING2 email10_email_src;
		STRING100 email10_email_username;
		STRING120 email10_email_domain;
		UNSIGNED6 email10_did;
		UNSIGNED8 email10_did_score:=0;
		STRING8 email10_date_first_seen;
		STRING8 email10_date_last_seen;
		UNSIGNED4 email10_ln_date_first:=0;
		UNSIGNED4 email10_ln_date_last:=0;
		STRING8 email10_date_vendor_first_reported;
		STRING8 email10_date_vendor_last_reported;
		STRING8 email10_process_date;
		STRING1 email10_activecode;
		BOOLEAN email10_is_current;
		UNSIGNED email10_rules;
		BOOLEAN email10_isdeepdive:=FALSE;
		UNSIGNED email10_subject_lexid:=0;
		STRING email10_orig_CompanyName;
		STRING email10_cln_CompanyName;
		STRING email10_CompanyTitle;
		UNSIGNED6 email10_DotID;
		UNSIGNED6 email10_EmpID;
		UNSIGNED6 email10_POWID;
		UNSIGNED6 email10_ProxID;
		UNSIGNED6 email10_SELEID;
		UNSIGNED6 email10_OrgID;
		UNSIGNED6 email10_UltID;
		STRING15 email10_email_status:='';
		STRING50 email10_email_status_reason:='';
		STRING70 email10_additional_status_info:='';
		STRING8 email10_date_last_verified:='';
		STRING50 email10_relationship:='';
		STRING50 email10_record_err_msg:='';
		UNSIGNED2 email10_record_err_code:=0;
		BOOLEAN email10_is_rejected_rec:=FALSE;
		BOOLEAN email10_isRoyaltySource:=FALSE;
		UNSIGNED email10_num_sources:=0;
		STRING8 email10_latest_orig_login_date:='';
		UNSIGNED email10_num_email_per_did:=0;
		UNSIGNED email10_num_did_per_email:=0;
		STRING15   input_email_invalid;
    	STRING50   input_email_invalid_reason;
		
end;
	
	

	export BatchInter := record(BatchIn)
			BatchOut.LN_search_name;		
			BatchOut.LN_search_name_type;
			typeof(BatchShare.Layouts.ShareDid.did) computed_did;
			typeof(DidVille.Layout_Did_OutBatch.score) computed_did_score;
	end;


	export BestExtended := record(didville.Layout_Did_OutBatch)
			typeof(BatchOut.Email1) input_email;
			typeof(BatchShare.Layouts.ShareAddress.prim_range)	c_best_prim_range;
			typeof(BatchShare.Layouts.ShareAddress.predir)	c_best_predir;
			typeof(BatchShare.Layouts.ShareAddress.prim_name)	c_best_prim_name;
			typeof(BatchShare.Layouts.ShareAddress.addr_suffix)	c_best_addr_suffix;
			typeof(BatchShare.Layouts.ShareAddress.postdir)	c_best_postdir;
			typeof(BatchShare.Layouts.ShareAddress.unit_desig)	c_best_unit_desig;
			typeof(BatchShare.Layouts.ShareAddress.sec_range)	c_best_sec_range;
			typeof(BatchOut.latitude) c_best_latitude; 
			typeof(BatchOut.longitude) c_best_longitude;
			typeof(BatchOut.county_name) c_best_county;
			typeof(BatchShare.Layouts.ShareAddress.p_city_name)	c_best_p_city_name;
			typeof(BatchShare.Layouts.ShareAddress.st)	c_best_st;
			typeof(BatchShare.Layouts.ShareAddress.z5)	c_best_z5;
			typeof(BatchShare.Layouts.ShareAddress.zip4)	c_best_zip4;
			typeof(progressive_phone.layout_progressive_batch_out.subj_phone10) primary_phone_number;
	end;


	export AddressesRec := record
		BatchOut.acctno;
		BatchOut.address_match_codes;
		BatchOut.address;
		BatchOut.city;
		BatchOut.st;
		BatchOut.z5;
		BatchOut.zip4;
		BatchOut.county_name;
		BatchOut.addr_dt_last_seen;
		BatchOut.addr_dt_first_seen;
		BatchOut.addr_confidence;
		BatchOut.latitude;
		BatchOut.longitude;
		//BatchOut.fips_county
		
		BatchOut.address_new;
		BatchOut.address_new_match_codes;
		BatchOut.city_new;
		BatchOut.st_new;
		BatchOut.z5_new;
		BatchOut.zip4_new;
		BatchOut.county_name_new;
		BatchOut.addr_dt_last_seen_new;
		BatchOut.addr_dt_first_seen_new;
		BatchOut.addr_confidence_new;
		BatchOut.latitude_new;
		BatchOut.longitude_new;
		//BatchOut.fips_county_new;
end;


export AddressesRec_extended := record
		BatchOut.acctno;
		BatchOut.address_match_codes;
		BatchOut.address;
		BatchOut.city;
		BatchOut.st;
		BatchOut.z5;
		BatchOut.zip4;
		BatchOut.county_name;
		BatchOut.addr_dt_last_seen;
		BatchOut.addr_dt_first_seen;
		BatchOut.addr_confidence;
		BatchOut.latitude;
		BatchOut.longitude;
		//BatchOut.fips_county
		
		BatchOut.address_new;
		BatchOut.address_new_match_codes;
		BatchOut.city_new;
		BatchOut.st_new;
		BatchOut.z5_new;
		BatchOut.zip4_new;
		BatchOut.county_name_new;
		BatchOut.addr_dt_last_seen_new;
		BatchOut.addr_dt_first_seen_new;
		BatchOut.addr_confidence_new;
		BatchOut.latitude_new;
		BatchOut.longitude_new;
		string4 addressCode1;
    string4  addressdescriptioncode1;	
		string100 addressDescription1;	
		string4 addressdescriptioncode2;	
		string100 addressDescription2;	
		string4 addressdescriptioncode3;	
		string100 addressDescription3;	
		string4 addressdescriptioncode4;	
		string100 addressDescription4;	
		string4 addressdescriptioncode5;	
		string100 addressDescription5;	
		string4 addressdescriptioncode6;	
		string100 addressDescription6;	
		string4 addressdescriptioncode7;	
		string100 addressDescription7;	
		string4 addressdescriptioncode8;	
		string100 addressDescription8;	
		string4 addressdescriptioncode9;	
		string100 addressDescription9;	
		string4 addressdescriptioncode10;	
		string100 addressDescription10;	
		UNSIGNED4 SEQ;

		//BatchOut.fips_county_new;
end;

		export sortRec := record
						string Matchcode;
						unsigned MatchcodeScore;
		 end;
						 
		export DeceasedOut := record(DeathV2_Services.layouts.BatchOut)
		sortRec
		end;
	
	EXPORT emailv2recs := RECORD
	 	STRING20  acctno := '';
    UNSIGNED  seq := 0; //need for internal use for multiple recs for same acctno
    UNSIGNED  email_id := 0;  // email rec key
    STRING2   email_src;
    STRING100 email_username;
    STRING120 email_domain;
    UNSIGNED6 did;
    UNSIGNED8 did_score := 0;
    STRING8   date_first_seen;
    STRING8   date_last_seen;
    UNSIGNED4 ln_date_first := 0;    // LN calculated date based on vendor's date_first_seen
    UNSIGNED4 ln_date_last := 0;    // LN calculated date based on vendor's date_last_seen
    STRING8   date_vendor_first_reported;
    STRING8   date_vendor_last_reported;
    STRING8   process_date;
    STRING1   activecode;
    BOOLEAN   is_current;
    UNSIGNED  rules;
    BOOLEAN   isdeepdive := FALSE;
    UNSIGNED  subject_lexid := 0;  // keeping Lexid resolved from input PII or DID provided from input
    STRING    orig_CompanyName;
		STRING    orig_email;
    STRING    cln_CompanyName;
    STRING    CompanyTitle;
    UNSIGNED6 DotID;
    UNSIGNED6 EmpID;
    UNSIGNED6 POWID;
    UNSIGNED6 ProxID;
    UNSIGNED6 SELEID;
    UNSIGNED6 OrgID;
    UNSIGNED6 UltID;
    //tmx_insights_rec TMX_insights;
    STRING15   email_status := '';
    STRING50   email_status_reason := '';
    STRING70   additional_status_info := '';
    STRING8    date_last_verified := '';
    STRING50   relationship  := '';
    STRING50   record_err_msg  := '';
    UNSIGNED2 record_err_code := 0;
		STRING    src;
    BOOLEAN  is_rejected_rec := FALSE;
		UNSIGNED email_quality_mask := 0;
    UNSIGNED penalt := 0;
    UNSIGNED penalt_addr := 0;
    UNSIGNED penalt_name := 0;
    UNSIGNED penalt_didssndob := 0;
    BOOLEAN  isRoyaltySource := FALSE;
    UNSIGNED num_sources := 0;
    STRING8  latest_orig_login_date := '';
    UNSIGNED num_email_per_did := 0;
    UNSIGNED num_did_per_email := 0;
END;
	
  	export	EmailRecInvalidforV2:=record
		STRING20 acctno := '';
		STRING15 input_email_invalid;
		STRING50 input_email_invalid_reason;
	end;
	
	export EmailRecforv2 := record
      	BatchServices.Layouts.email.rec_results_raw	;
		emailv2recs;
	end;

	
   export EmailRec := record
		dataset(EmailRecforv2) Records;
		dataset(EmailRecInvalidforV2) emailstatus;
		dataset(Royalty.Layouts.RoyaltyForBatch) Royalties;
		
	end;

	EXPORT ProgressivePhoneRec := RECORD
		dataset(progressive_phone.layout_progressive_phone_common) Records;
		dataset(Royalty.Layouts.RoyaltyForBatch) Royalties;	
	END;

	EXPORT PhoneFinderOutPhone:= RECORD
		STRING20 acctno;
		UNSIGNED6 did;
		STRING PhoneNumber;
		STRING PhoneType;
		STRING ListingName;
		STRING8 DateFirstSeen;
		STRING8 DateLastSeen;
		STRING Carrier;
		STRING CarrierCity;
		STRING CarrierState;
		STRING PhoneStatus;
		STRING ListingType;
	END;
	export Layout_Desc :=
RECORD
	STRING5 hri;
	STRING150 desc;
END;

export reportservice_data_In:=record
    STRING15 SSN_in;
		STRING120 fullName := '';
		STRING30 Name_First;
		STRING30 Name_Middle;
		STRING30 Name_Last;
		STRING5 Name_Suffix;
		STRING8 DOB_in;
		STRING140 street_addr := '';
		STRING25 p_City_name;
		STRING5 State_in;
		STRING10 ZIP_in;
		
	END;
	EXPORT reportservice_data_Cln := RECORD 
		reportservice_data_In;
		STRING9 SSN_Cln;
		STRING8 DOB_Cln;
		STRING2 ST_Cln;
		STRING5 Z5_Cln;
		END;

 
end;
