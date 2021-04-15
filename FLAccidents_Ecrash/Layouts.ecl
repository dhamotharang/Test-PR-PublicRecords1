export Layouts := module

export slim_layout := record
  string Sent_to_HPCC_DateTime;
  string creation_date ; 
  string incident_id;
  string report_id ; 
  string case_identifier; 
  string agency_name;			
  string loss_state_abbr; 
  string crash_date;
  string work_type_id;   
  string report_type_id;
  string loss_street;
  string loss_cross_street;
  string hash_key;
  string last_name;
  string first_name;
  string middle_name;
  string address;
  string city;
  string state;
  string zip_code;
  string Drivers_License_Number;
  string License_Plate;
  string vin;
  string Make;
  string Model_Yr;
  string Model;
  string1 changed_hashkey :='';
  string1 changed_data_lev1:='';
  string1 U_D_flag :='D'; 
  string2 source_id ; 
  string agency_id; 
  string ORI_Number; 
  string cru_order_id ; 
  string state_report_number;
  string CRU_Sequence_Nbr;
  string2 report_code;
	string8 accident_date; 
	string40 accident_nbr; 
	string40  orig_accnbr;
  string40  addl_report_number;
	string100 Vendor_Code;
  string20  vendor_report_id ;
	string40  orig_case_identifier;
  string40  orig_state_report_number;
	string1 is_available_for_public;
	string20 report_status;
	string3 Page_Count;
	string12 Supplemental_Report;
end;

export l_hash := record
  string19 Creation_Date;
	string11 Incident_ID;
	string11 Report_ID; 
	string64 Hash_Key;
	string1  U_D_flag;
	string19 Sent_to_HPCC_DateTime;
	string2  report_code; 
	string3 page_count;
	string12 supplemental_report;
	string3 report_type_id
end;
	
export ReportVersionNested := record
  string Sent_to_HPCC_DateTime;
  string creation_date ; 
  string incident_id;
  string report_id ; 
  string case_identifier; 
  string agency_name;			
  string loss_state_abbr; 
  string crash_date;
  string work_type_id;   
  string report_type_id;
  string loss_street;
  string loss_cross_street;
  string hash_key;
  string last_name;
  string first_name;
  string middle_name;
  string address;
  string city;
  string state;
  string zip_code;
  string Drivers_License_Number;
  string License_Plate;
  string vin;
  string Make;
  string Model_Yr;
  string Model;
  string1 changed_hashkey :='';
  string1 changed_data_lev1:='';
  string1 U_D_flag :='D'; 
  string2 source_id ; 
  string agency_id; 
  string ORI_Number; 
  string cru_order_id ; 
  string state_report_number;
  string CRU_Sequence_Nbr;
  string11 super_report_id;
	string2 report_code;
	string8 accident_date; 
	string40 accident_nbr; 
	string40 orig_accnbr;
  string40 addl_report_number;
	string100 Vendor_Code;
  string20 vendor_report_id ;
	string40 orig_case_identifier;
  string40 orig_state_report_number;
	string1 is_available_for_public;
	string20 report_status;
	string3 Page_Count;
 dataset(l_hash) hash_;
end;

export ReportVersion := record 
  string11 super_report_id; 
	string11 report_id; 
	string64 hash_key;
	string1 U_D_flag;
	string19 Creation_Date;
	string19 Sent_to_HPCC_DateTime;
	string11 Incident_ID;
	string40 accident_nbr;
	string8 accident_date;
	string2 report_code;
	string100 jurisdiction;
	string2 jurisdiction_state;
	string40 orig_accnbr;
  string40 addl_report_number;
	string12 cru_order_id;
	string2 CRU_Sequence_Nbr;
	string4 work_type_id;
	string3 report_type_id; 
	string9 agency_ori;
	string11 agency_id;
	//PR Recon COPPR-49
	boolean is_terminated_agency;
	string100 Vendor_Code;
  string20 vendor_report_id ;
	string2 source_id; 
	string40 orig_case_identifier;
  string40 orig_state_report_number;
	string1 is_available_for_public;
	string20 report_status;
	string super_report_id_orig ; 
  string3 Page_Count;
end; 

export Delta_Date := record
  string9	Delta_Text;
	string19 Date_Added;
end;

export deletes := record
  string Incident_ID;
  string Creation_Date; 
  string State_Report_Number; 
  string Case_Identifier; 
  string Source_ID; 
  string Loss_State_Abbr; 
  string Crash_Date; 
  string Agency_ID; 
  string Work_Type_ID;
end; 

export SuppressIncidents := record
	string Incident_ID;
	string ORI_Number;
	string State_Report_Number;
	string Agency_ID;
end;

export TFafterTF := record 
	string Sent_to_HPCC_DateTime;
	string creation_date; 
	string incident_id;
	string report_id; 
	string case_identifier; 
	string agency_name;			
	string loss_state_abbr; 
	string crash_date;
	string work_type_id;   
	string report_type_id;
	string loss_street;
	string loss_cross_street;
	string hash_key;
	string last_name;
	string first_name;
	string middle_name;
	string address;
	string city;
	string state;
	string zip_code;
	string Drivers_License_Number;
	string License_Plate;
	string vin;
	string Make;
	string Model_Yr;
	string Model;
	string agency_id; 
	string ORI_Number; 
	string cru_order_id; 
	string state_report_number;
	string CRU_Sequence_Nbr;
	string report_code;
	string accident_date; 
	string accident_nbr; 
	string	orig_accnbr;
	string addl_report_number;
	string	Vendor_Code;
	string vendor_report_id;
	string	orig_case_identifier;
	string orig_state_report_number;
	string	is_available_for_public;
	string report_status;
end; 

export TMout := record
	string Incident_ID;   
	string report_id; 
	string Creation_Date;
	string Sent_to_HPCC_DateTime;
	string crash_date; 
	string agency_name;
	string loss_state_abbr;
	string state_report_number ;
	string case_identifier;
	string work_type_id;
	string report_type_id; 
	string agency_ori;
	string agency_id; 
	string Vendor_Code;
	string vendor_report_id;
	string source_id;
end;

export key_search_layout := record  
	string40  accident_nbr;	
	string40  orig_accnbr;
	string40  addl_report_number;	
	string8   accident_date; 
	string2   report_code;
	string100 jurisdiction;
	string2   jurisdiction_state;
	string11  jurisdiction_nbr;
	string4   work_type_id;
 	string3   report_type_id;
	string11  report_id;
	string9   agency_ori;
	string100 vendor_code;
	string20  vendor_report_id;
	string20  reportLinkID;
  string30  vin;
  string25  driver_license_nbr;
  string2   dlnbr_st;
  string10  tag_nbr;
  string2   tagnbr_st;
  string12  officer_id;
	string8   date_vendor_last_reported;
	string100 accident_location;
	unsigned6 Idfield;
  string12  did;
  string60  fname;
  string60  mname;
  string100 lname;
	string60  orig_fname;
	string60  orig_mname;
	string100	orig_lname;
	string3 contrib_source;
end;

export key_slim_layout := record  
	string40  accident_nbr;	
	string40  orig_accnbr;
	string40  addl_report_number;	
	string8   accident_date; 
	string2   report_code;
	string100 jurisdiction;
	string2   jurisdiction_state;
	string11  jurisdiction_nbr;
	string4   work_type_id;
  string3   report_type_id;
	string11  report_id;
	string9   agency_ori;
	string100 vendor_code;
	string20  vendor_report_id;
	string20  reportLinkID;
  string30  vin;
  string25  driver_license_nbr;
  string2   dlnbr_st;
  string10  tag_nbr;
  string2   tagnbr_st;
  string12  officer_id;
	string8   date_vendor_last_reported;
	string100 accident_location;
	unsigned6 idfield;
  string12  did;
  string60  fname;
  string60  mname;
  string100 lname;
	string3 contrib_source;
end;

export PhotoLayout := record
	string11 document_id;
	string11 incident_id;
	string64 document_hash_key;
	string19 date_created;
	string1 is_deleted;
	string3 report_type;
	string3 page_count;
	string3 extension;
	//PR Recon COPPR-49
	string3 report_source;
	boolean is_terminated_agency;
end;

	
export agency_cmbnd := record
	string11   agency_ori;
	string3    agency_state_abbr;
	string100  agency_name;
	string11   mbsi_agency_id;
	string5    cru_agency_id;
	unsigned3  cru_state_number;
	string3    source_id;
	string2    append_overwrite_flag;
	string10   source_start_date; 
	string10   source_end_date; 
	string20   source_termination_date; 
	string1    source_resale_allowed; 
	string1    source_auto_renew; 
	string1    source_allow_sale_of_component_data; 
	string1    source_allow_extract_of_vehicle_data; 
end;

export Scrubs := FLAccidents_Ecrash.Layout_Basefile - ScrubsBits1;

//Extract layouts
export DupesExtract := record
  string filedate;
  string flag;
  string del_incident_id;
  string add_incident_id;
end;

export ReportUpdate := record
  string entity_type;
  string entity_id;
  string entity_id2;
  string entity_id3; 
  string create_date;
  string extra_data; 
  string super_report_id; 
end;

end;
