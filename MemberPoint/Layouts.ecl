 import Autokey_batch,AddrBest,BatchServices,BatchShare,DidVille,progressive_phone,DeathV2_Services,Royalty, PhoneFinder_Services;

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

//  Email
		string Email1;
		string Email2;
		string Email3;
		string Email4;
		string Email5;
		string Email6;
		string Email7;
		string Email8;
		string Email9;
		string Email10;
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

		export sortRec := record
						string Matchcode;
						unsigned MatchcodeScore;
		 end;
						 
		export DeceasedOut := record(DeathV2_Services.layouts.BatchOut)
		sortRec
		end;
	
  export EmailRec := record
		dataset(BatchServices.Layouts.email.rec_results_raw) Records;
		dataset(Royalty.Layouts.RoyaltyForBatch) Royalties;
	end;

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
	
end;