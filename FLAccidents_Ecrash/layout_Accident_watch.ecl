export layout_Accident_watch := module

export temp :=  { string orig_accnbr;
  string vehicle_incident_id;
  string vehicle_status;
  string accident_date;
  string did;
  string title;
  string fname;
  string mname;
  string lname;
  string name_suffix;
  string dob;
  string b_did;
  string cname;
  string prim_range;
  string predir;
  string prim_name;
  string addr_suffix;
  string postdir;
  string unit_desig;
  string sec_range;
  string v_city_name;
  string st;
  string zip;
  string zip4;
  string record_type;
  string report_code;
  string report_code_desc;
  string report_category;
  string vin;
  string driver_license_nbr;
  string dlnbr_st;
  string tag_nbr;
  string tagnbr_st;
  string accident_location;
  string accident_street;
  string accident_cross_street;
  string jurisdiction;
  string jurisdiction_state;
	string vehicle_unit_number;
  string vehicle_incident_city;
  string vehicle_incident_st;
  string carrier_name; 
	string Policy_num;
	string Policy_Effective_Date; 
	string process_date_time , 
	string report_type :='',
	string addl_report_number,
	string agency_id , 
  string agency_ori,
  string Insurance_Company_Standardized ,
  string source_id; 
	string work_type_id  ; 
	string hash_key;
	string CRU_order_id; 
	string CRU_Seq_number;
	string carrier_id_carriername;
	string update_flag;
	string Report_Type_ID ;
	string carrier_id_carrierSource ;
 
}; 

 export final := record ,maxlength(20000000)
  string orig_accnbr;
  string vehicle_incident_id;
  string vehicle_status;
  string accident_date;
  string did;
  string title;
  string fname;
  string mname;
  string lname;
  string name_suffix;
  string dob;
  string b_did;
  string cname;
  string prim_range;
  string predir;
  string prim_name;
  string addr_suffix;
  string postdir;
  string unit_desig;
  string sec_range;
  string v_city_name;
  string st;
  string zip;
  string zip4;
  string record_type;
  string report_code;
  string report_code_desc;
  string report_category;
  string vin;
  string driver_license_nbr;
  string dlnbr_st;
  string tag_nbr;
  string tagnbr_st;
  string accident_location;
  string accident_street;
  string accident_cross_street;
  string jurisdiction;
  string jurisdiction_state;
	string vehicle_unit_number;
  string vehicle_incident_city;
  string vehicle_incident_st;
  string carrier_name; 
	string Policy_num;
	string Policy_Effective_Date; 
	string process_date_time , 
	string report_type ,
	string addl_report_number,
	string agency_id , 
  string agency_ori,
  string Insurance_Company_Standardized ,
  string source_id; 
	string hash_key; 
	string work_type_id ; 
	string CRU_order_id; 
	string CRU_Seq_number;
	string carrier_id_carriername;
	string update_flag;
  string Report_Type_ID ;
 	string carrier_id_carrierSource ;

end; 

end; 