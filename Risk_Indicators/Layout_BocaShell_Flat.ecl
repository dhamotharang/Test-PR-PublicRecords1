/* created for outputting the bocashell in a flat layout.  

Whenever the layout_boca_shell_edina changes, or any of the sub_layouts change, this will need to change for them to stay in sync.

	layout_boca_shell_edina
	layout_address_information
	layout_census
	layout_derogs
	layout_relatives
	layout_relatives_property_values
	layout_vehicles
	
*/

Layout_Address_Validation := RECORD
	string1 USPS_Deliverable;
	STRING10 Dwelling_Type;
	STRING10 Zip_Type;
	string1 HR_Address;
	STRING100 HR_Company;
	STRING4 Error_Codes;
	string1 Corrections;
END;

Layout_Phone_Validation := RECORD
	STRING10 telcordia_type;
	string1 phone_zip_mismatch;
	string4 distance;
	string1 disconnected;
	string2 recent_disconnects;
	string1 HR_Phone;
	STRING100 HR_Company;
	string1 Corrections;
END;

Layout_SSN_Validation := RECORD
	string1 deceased;
	string1 valid;
	string1 issued;
	string8 high_issue_date;
	string8 low_issue_date;
	STRING2 issue_state;
	string2 dob_mismatch;
END;

Layout_DL_Validation := RECORD
	string1 valid;
	string8 Issue_date;
	string8 Expire_date;
END;

Layout_Name_Verification := RECORD
	STRING12 adl;
	string3 adl_score;
	string3 fname_score;
	string3 lname_score;
	string6 lname_change_date;
	string6 lname_prev_change_date;
	string2 source_count;
	string1 fname_credit_sourced;
	string1 lname_credit_sourced;
	string1 fname_tu_sourced;
	string1 lname_tu_sourced;
	string1 fname_eda_sourced;
	string1 lname_eda_sourced;
	string1 fname_dl_sourced;
	string1 lname_dl_sourced;
	string1 fname_voter_sourced;
	string1 lname_voter_sourced;
	string1 fname_utility_sourced;
	string1 lname_utility_sourced;
	string3 age;
	string3 dob_score;
END;

Layout_Addr_Info :=RECORD
	string6 address_score;
	string1 House_Number_match;
	string1 isBestMatch;
	string2 source_count;
	string1 credit_sourced;
	string1 eda_sourced;
	string1 dl_sourced;
	string1 voter_sourced;
	string1 utility_sourced;
	string1 applicant_owned;
	string1 occupant_owned;
	string1 family_owned;
	string1 family_sold;
	string1 applicant_sold;
	string1 family_sale_found;
	string1 family_buy_found;
	string1 applicant_sale_found;
	string1 applicant_buy_found;
	string2 NAProp;
	string8 purchase_date;
	string8 built_date;
	string8 purchase_amount;
	string8 mortgage_amount;
	string8 mortgage_date;
	string8 assessed_amount;
	string8 date_first_seen;
	string8 date_last_seen;
	string1 HR_Address;
	STRING100 HR_Company;
	string10 prim_range ;
	string2  predir ;
	string28 prim_name ;
	string4  addr_suffix ;
	string2  postdir ;
	string10 unit_desig ;
	string8  sec_range ;
	string25 city_name ;
	string2  st ;
	string5  zip5 ;
	string3 county;
	string7 geo_blk;
	// layout census
	string5  census_age;
	string9  census_income;
	string9  census_home_value;
	string5  census_education;
	string1 full_match;
	// end layout census
END;

Layout_Property_Value := RECORD
	string2 property_total;
	string10 property_owned_purchase_total;
	string4 property_owned_purchase_count;
	string10 property_owned_assessed_total;
	string4 property_owned_assessed_count;
END;

Layout_Applicants_Property_Values := RECORD
	Layout_Property_Value owned;
	Layout_Property_Value sold;
	Layout_Property_Value ambiguous;
end;

Layout_Address_Verification := RECORD
	Layout_Addr_Info Input_Address_Information;
	Layout_Applicants_Property_Values;
	string4 distance_in_2_h1;
	string4 distance_in_2_h2;
	string4 distance_h1_2_h2;
	Layout_Addr_Info Address_History_1;
	Layout_Addr_Info Address_History_2;
END;

Layout_Phone_Verification := RECORD
	string3 phone_score;
	string2 EDA_NAP;
	Layout_Phone_Validation;
END;	

Layout_DL_Verification := RECORD
	string2 NADL;
END;

Layout_SSN_Information := RECORD
	string3 ssn_score;
	string2 NAS1;
	string4 namePerSSN_count;
	string4 adlPerSSN_count;
	string1 credit_sourced;
	string6 credit_first_seen;
	string6 credit_last_seen;
	string2 header_count;
	string6 header_first_seen;
	string6 header_last_seen;
	string1 tu_sourced;
	string1 voter_sourced;
	string1 utility_sourced;
	string1 bk_sourced;
	string1 other_sourced;
	Layout_SSN_Validation Validation;
END;

Layout_Input_Validation := RECORD
	string1 FirstName;
	string1 MiddleName;
	string1 LastName;
	string1 Address;
	string1 Country;
	string1 SSN;
	string1 DateOfBirth;
	string1 Age;
	string1 DlNumber;
	string1 DlState;
	string1 Email;
	string1 IPAddress;
	string1 HomePhone;
	string1 WorkPhone;
	string1 EmployerName;
	string1 FormerName;
END;

Layout_Available_Sources := RECORD
	string1 DL;
	string1 Voter;
END;

Layout_InstantID_Results := RECORD
	STRING2 NAS_Summary;
	STRING2 NAP_Summary;
	STRING1 NAP_Type;
	STRING1 NAP_Status;
	STRING2 CVI;
	string2 reason1 := '';
     string2 reason2 := '';
     string2 reason3 := '';
     string2 reason4 := '';
	string2 reason5 := '';
     string2 reason6 := '';
END;

layout_in := record
	string8 seq;
	STRING5  title := '';
	STRING20 fname;
	STRING20 mname;
	STRING5  suffix;
	STRING120 in_streetAddress;
	STRING25 in_city;
	STRING2 in_state;
	STRING5 in_zipCode;
	STRING25 in_country;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
	STRING10 lat := '';
	STRING11 long := '';
	string3 county := '';
	string7 geo_blk := '';
	STRING1  addr_type;
	STRING4  addr_status;
	STRING25 country;
	STRING8  dob;
	STRING3  age;
	STRING2 dl_state := '';
	STRING50 email_address := '';
	STRING20 ip_address := '';
	STRING10 phone10;
	STRING10 wphone10;
	STRING100 employer_name := '';
end;

Layout_Derog := RECORD
	string1 bankrupt;
	string8 date_last_seen;
	STRING1 filing_type;
	STRING35 disposition;
	string2 filing_count;
	string2 bk_recent_count;
	string2 bk_disposed_recent_count;
	string2 bk_disposed_historical_count;
	string2 liens_recent_unreleased_count;
	string2 liens_historical_unreleased_count;
	string2 liens_recent_released_count;
	string2 liens_historical_released_count;
	string2 criminal_count;
END;

Layout_Property_Value_R := RECORD
	string2 relatives_property_count;
	string2 relatives_property_total;
	string10 relatives_property_owned_purchase_total;
	string4 relatives_property_owned_purchase_count;
	string10 relatives_property_owned_assessed_total;
	string4 relatives_property_owned_assessed_count;
END;

Layout_Relative_Property_Values := RECORD
	Layout_Property_Value_R owned;
	Layout_Property_Value_R sold;
	Layout_Property_Value_R ambiguous;
END;

Layout_Relative :=RECORD
	string2 relative_count;
	string2 relative_bankrupt_count;
	string2 relative_criminal_count;
	string2 relative_criminal_total;
	Layout_Relative_Property_Values;

	/* *********** Census related aggregates *************** */
	string2 relative_within25miles_count;
	string2 relative_within100miles_count;
	string2 relative_within500miles_count;
	string2 relative_withinOther_count;
	
	string2 relative_incomeUnder25_count;
	string2 relative_incomeUnder50_count;
	string2 relative_incomeUnder75_count;
	string2 relative_incomeUnder100_count;
	string2 relative_incomeOver100_count;

	string2 relative_homeUnder50_count;
	string2 relative_homeUnder100_count;
	string2 relative_homeUnder150_count;
	string2 relative_homeUnder200_count;
	string2 relative_homeUnder300_count;
	string2 relative_homeUnder500_count;
	string2 relative_homeOver500_count;
		
	string2 relative_educationUnder8_count;
	string2 relative_educationUnder12_count;
	string2 relative_educationOver12_count;
	
	string2 relative_ageUnder20_count;
	string2 relative_ageUnder30_count;
	string2 relative_ageUnder40_count;
	string2 relative_ageUnder50_count;
	string2 relative_ageUnder60_count;
	string2 relative_ageUnder70_count;
	string2 relative_ageOver70_count;
END;

Layout_Vehicle_Information := RECORD
	string4 year_make;
	STRING10 make;
	STRING10 model;	
	string1 title;
	STRING25 vin;
END;

Layout_Vehicle := RECORD
	string2 current_count;
	string2 historical_count;
	Layout_Vehicle_Information Vehicle1;
	Layout_Vehicle_Information Vehicle2;
	Layout_Vehicle_Information Vehicle3;
END;

export Layout_Bocashell_Flat := record
	string8 	seq;
	string12 	did;
	string1 	trueDID;
	Layout_In									Shell_Input;
	Layout_InstantID_Results 					iid;
	Layout_Available_Sources 					Available_Sources;
	Layout_Input_Validation 						Input_Validation;
	Layout_Address_Validation 					Address_Validation;
	Layout_DL_Validation 						DL_Validation;
	Layout_Name_Verification 					Name_Verification;
	Layout_Address_Verification 					Address_Verification;
	Layout_Phone_Verification 					Phone_Verification;
	Layout_DL_Verification 						DL_Verification;
	Layout_SSN_Information 						SSN_Verification;
	Layout_Derog 								BJL;
	Layout_Relative 							Relatives;
	Layout_Vehicle 							Vehicles;
	string6 	historyDate;
END;

