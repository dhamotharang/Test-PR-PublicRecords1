export Layout_metadata := module 

export incident := record 
string iyetek_metadata_id; 
string 	date_created; 
string 	report_date; 
string 	date_of_loss; 
string 	last_update_date;
string	sent_to_hpcc_datetime;	
string  work_type_id; 
string  agency_ori;	
string  agency_name;
string	report_agency_ori;
string	state_abbr;
string	report_number;
string	report_type;
string	case_identifier;
string	report_status;
string	hit_and_run;
string	county_name;
string	city_name;
string	primary_street;
string	cross_street;
string	officer_name;
string	district;
string	has_addendum;
string	is_available_for_public;
string  mbs_agency_id; 
string  Cru_Agency_Id;
string  Cru_Agency_Name;

end; 

export vehicle_record := record 
string iyetek_metadata_vehicle_id;
string  date_created; 
string	iyetek_metadata_id;
string	unit_number;
string	vin;
string	make; 
string	model;
string	model_year;
string	tag;
string	tag_state_abbr;
string	vehicle_towed;
string	airbag_deployed;
string	initial_point_of_contact;
string	insurance_company_name;
string	insurance_policy_number;
string	insurance_policy_date;
string	insurance_company_standardized;
string  vin_status; 
string  damaged_areas1; 
end;

export person_record := record 

string iyetek_metadata_person_id ; 	
string date_created; 
string iyetek_metadata_id;
string vehicle_unit_number;
string person_type;
string first_name;
string middle_name;
string last_name;
string address; 
string city; 
string state; 
string zip; 
string date_of_birth;
string driver_license;
string injury;
string driver_license_jurisdiction;
end; 

export citation := record 

string iyetek_metadata_citation_id; 
string date_created;
string	iyetek_metadata_id; 
string 	citation_number; 

end; 

export incident_fixed := record 

string11 iyetek_metadata_id; 
string19 	date_created; 
string19 	report_date; 
string19 	date_of_loss; 
string19 	last_update_date;
string19	sent_to_hpcc_datetime;	
string4  work_type_id; 
string9  agency_ori;	
string100  agency_name;
string9	report_agency_ori;
string2	state_abbr;
string25	report_number;
string1	report_type;
string25	case_identifier;
string20	report_status;
string1	hit_and_run;
string50	county_name;
string50	city_name;
string100	primary_street;
string100	cross_street;
string100	officer_name;
string25	district;
string1	has_addendum;
string1	is_available_for_public;
string16  mbs_agency_id;
string20 cru_agency_id;
string100 cru_agency_name;
end; 

export person_fixed := record 
string11 iyetek_metadata_person_id ; 	
string19 	date_created; 
string11 iyetek_metadata_id;
string11 vehicle_unit_number;
string100 person_type;
string25 first_name;
string25 middle_name;
string100 last_name;
string150 address; 
string50 city; 
string2 state; 
string9 zip; 
string10 date_of_birth;
string25 driver_license;
string50 injury;
string2 driver_license_jurisdiction;

end;
export vehicle_fixed := record 

string11 iyetek_metadata_vehicle_id;
string19 	date_created; 
string11	iyetek_metadata_id;
string11	unit_number;
string30	vin;
string100	make;
string100	model;
string4	model_year;
string10	tag;
string2	tag_state_abbr;
string1	vehicle_towed;
string1	airbag_deployed;
string50	initial_point_of_contact;
string100	insurance_company_name;
string100	insurance_company_standardized;
string50	insurance_policy_number;
string20	insurance_policy_date;
string5  vin_status; 
string50 damaged_areas1; 

end;
export citation_fixed := record 

string11 iyetek_metadata_citation_id; 
string19 	date_created; 
string11	iyetek_metadata_id; 
string20 	citation_number; 

end; 

export temp_vehicle := record 
string11 iyetek_metadata_id; 
string19 	date_created; 
string19 	report_date; 
string19 	date_of_loss; 
string19 	last_update_date;
string19	sent_to_hpcc_datetime;	
string4  work_type_id; 
string9  agency_ori;	
string100  agency_name;
string9	report_agency_ori;
string2	state_abbr;
string25	report_number;
string1	report_type;
string25	case_identifier;
string20	report_status;
string1	hit_and_run;
string50	county_name;
string50	city_name;
string100	primary_street;
string100	cross_street;
string100	officer_name;
string25	district;
string1	has_addendum;
string1	is_available_for_public;
string16  mbs_agency_id;
string20 cru_agency_id;
string100 cru_agency_name;

// vehicle
string11 iyetek_metadata_vehicle_id;
string11	unit_number;
string30	vin;
string100	make;
string100	model;
string4	model_year;
string10	tag;
string2	tag_state_abbr;
string1	vehicle_towed;
string1	airbag_deployed;
string50	initial_point_of_contact;
string100	insurance_company_name;
string100	insurance_company_standardized;
string50	insurance_policy_number;
string20	insurance_policy_date;
string5  vin_status; 
string50 damaged_areas1; 
end;
export temp_person := record 
temp_vehicle; 
// person 
string11 iyetek_metadata_person_id ; 	
string11 vehicle_unit_number;
string100 person_type;
string25 first_name;
string25 middle_name;
string100 last_name;
string150 address; 
string50 city; 
string2 state; 
string9 zip; 
string10 date_of_birth;
string25 driver_license;
string50 injury;
string2 driver_license_jurisdiction;
end; 
export temp_citation := record 
temp_person; 
string11 iyetek_metadata_citation_id; 
string20 	citation_number; 
end; 

export comnd := record 
string19 creation_date;
string10 Officer_Report_Date ;
string9 Officer_Report_Time ;
string19 Crash_Date  ;
string19 sent_to_hpcc_datetime ;
string4  work_type_id; 
string9 ORI_Number ;
string100 Agency_Name ;
string2 Loss_State_Abbr ;
string40 State_Report_Number ;
string3 Report_Type_ID ;
string40 Case_Identifier ;
string7 Incident_Hit_and_Run;
string50 Crash_County ; //30
string50 Crash_City ;//35
string100 Loss_Street ; //60
string100 Loss_Cross_Street; //60
string100 Investigating_Officer_Name;//80
string30 Judicial_District ;
string11 vehicle_id  ;
string11 unit_number ;//3 
string30 vin ;
string100 make ;
string100 model  ;
string4 Model_Yr  ;
string10 license_plate  ;
string2 Registration_State  ;
string1 Vehicle_Towed ;
string1 Airbags_Deployed_Derived ;
string30 Impact_Area1  ;//cut 25 chars 
string20 Impact_Area2 ; //cut 25 chars 
string100 Insurance_Company ;//30
string100 Insurance_Company_Standardized ; //30
string25 Insurance_Policy_Number ;
string20 Insurance_Expiration_Date ;
string11 person_id ; 
string11 Vehicle_Unit_Number ;
string100 Person_Type ;
string25 First_Name  ;
string25 Middle_Name ;
string100 Last_Name ;
string150 address; 
string50 city; 
string2 state; 
string9 zip; 
string10 Date_of_Birth ;
string25 Drivers_License_Number ;//15
string200 Injury_Description ;
string11 citation_id ;
string20 Citation_Number1 ; 
string11 incident_id ;
string1 is_available_for_public  ;
string1 has_addendum  ;
string20 last_update_date ;
string20 report_status ;
string9 report_agency_ori ;
string2 driver_license_jurisdiction;
string16  mbs_agency_id;
string5  vin_status; 
string50 damaged_areas1; 
string20 cru_agency_id;
string100 cru_agency_name;
end; 


export base := record 
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string8 dt_first_seen;
  string8 dt_last_seen;
	string2 report_code;
  string25 report_category;
  string65 report_code_desc;
string19 creation_date;
string10 Officer_Report_Date ;
string9 Officer_Report_Time ;
string19 Crash_Date  ;
string19 sent_to_hpcc_datetime ;
string4  work_type_id; 
string9 ORI_Number ;
string100 Agency_Name ;
string2 Loss_State_Abbr ;
string40 State_Report_Number ;
string3 Report_Type_ID ;
string40 Case_Identifier ;
string7 Incident_Hit_and_Run;
string50 Crash_County ; //30
string50 Crash_City ;//35
string100 Loss_Street ; //60
string100 Loss_Cross_Street; //60
string100 Investigating_Officer_Name;//80
string30 Judicial_District ;
string11 vehicle_id  ;
string11 unit_number ;//3 
string30 vin ;
string100 make ;
string100 model  ;
string4 Model_Yr  ;
string10 license_plate  ;
string2 Registration_State  ;
string1 Vehicle_Towed ;
string1 Airbags_Deployed_Derived ;
string30 Impact_Area1  ;//cut 25 chars 
string20 Impact_Area2 ; //cut 25 chars 
string100 Insurance_Company ;//30
string100 Insurance_Company_Standardized ; //30
string50 Insurance_Policy_Number ;
string20 Insurance_Expiration_Date ;
string11 person_id ; 
string11 Vehicle_Unit_Number ;
string100 Person_Type ;
string25 First_Name  ;
string25 Middle_Name ;
string100 Last_Name ;
string150 address; 
string50 city; 
string2 state; 
string9 zip; 
string10 Date_of_Birth ;
string25 Drivers_License_Number ;//15
string200 Injury_Description ;
string11 citation_id ;
string20 Citation_Number1 ; 
string11 incident_id ;
string1 is_available_for_public  ;
string1 has_addendum  ;
string20 last_update_date ;
string20 report_status ;
string9 report_agency_ori ;
string2 driver_license_jurisdiction;
string16  mbs_agency_id;
string5  vin_status; 
string50 damaged_areas1; 
//vina 
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
  string100 make_description;
  string100 model_description;
  string20 series_description;
  string2 car_cylinders;
	//clean 
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
  string1 nametype;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
	string100 cname; 
  string3 name_score;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 rawaid;
	
	string60 orig_fname ;
  string100 orig_lname ;
  string60 orig_mname ;
  string20 cru_agency_id;
  string100 cru_agency_name;
end; 

end;
