import standard, Risk_Indicators;

export layout := module

export mbslayout := record
	string	Company_ID := '';
	string	Global_Company_ID := '';
end;

export allowlayout := record
	unsigned8	AllowFlags := 0;
	// string	Allow_Inquiry_Observation := '';
	// string	Customer_Inquiry_OptOut := '';
	// string	allow_fraud_detection := '';
	// string	allow_id_verification := '';
	// string	allow_authentication := '';
	// string	allow_credit_risk := '';
	// string	allow_insurance := '';
	// string	allow_collections := '';
	// string	allow_le := '';
	// string	allow_marketing := '';
	// string	allow_emp_screening := '';
	// string	allow_tenant_screening := '';
	// string	allow_all := '';
end;

export businfolayout := record
	string	Primary_Market_Code;
	string	Secondary_Market_Code;
	string	Industry_1_Code;
	string	Industry_2_Code;
	string	Sub_market;
	string	Vertical;
	string	Use := ''; // banko only - additional vertical information
	string	Industry; 
end;

export InputPersonDataLayout := record
	string	Full_Name := '';
	string	First_Name := '';
	string	Middle_Name := '';
	string	Last_Name := '';
	string	Address := '';
	string	City := '';
	string	State := '';
	string	Zip := '';
	string	Personal_Phone := '';
	string	Work_Phone := '';
	string	DOB := '';
	string	DL := ''; // unique id
	string	DL_St := ''; // unique id
	string	Email_Address := '';
	string	SSN := '';
	string	LinkID := '';
	string	IPAddr := '';
end;

export CleanPersonDataLayout := record
	standard.Name - name_score;
	standard.Addr;
	string	Personal_Phone := '';
	string	Work_Phone := '';
	string	DOB := '';
	string	DL := ''; // unique id
	string	DL_St := ''; // unique id
	string	Email_Address := '';
	string	SSN := '';
	string	LinkID := '';
	string	IPAddr := '';
	string	Appended_SSN := '';
	unsigned6	Appended_ADL := 0;
end;

export PersonDataLayout := record
	string	Full_Name := '';
	string	First_Name := '';
	string	Middle_Name := '';
	string	Last_Name := '';
	string	Address := '';
	string	City := '';
	string	State := '';
	string	Zip := '';
	string	Personal_Phone := '';
	string	Work_Phone := '';
	string	DOB := '';
	string	DL := ''; // unique id
	string	DL_St := ''; // unique id
	string	Email_Address := '';
	string	SSN := '';
	string	LinkID := '';
	string	IPAddr := '';
	standard.Name - name_score;
	standard.Addr;
	string	Appended_SSN := '';
	unsigned6	Appended_ADL := 0;
end;

export InputBusDataLayout := record
	string	CName := '';
	string	Address := '';
	string	City := '';
	string	State := '';
	string	Zip := '';
	string	Company_Phone := '';
	string	EIN := ''; // unique id
	string	Charter_Number := ''; // unique id
	string	UCC_Number := '';  // unique id - doc number
	string	Domain_Name := ''; // unique id
end;

export CleanBusDataLayout := record
	string CName := '';
	standard.Addr;
	string	Company_Phone := '';
	string	EIN := ''; // unique id
	string	Charter_Number := ''; // unique id
	string	UCC_Number := '';  // unique id - doc number
	string	Domain_Name := ''; // unique id
	unsigned6	Appended_BDID := 0;
	string	Appended_EIN := '';
end;

export BusDataLayout := record
	string	CName := '';
	string	Address := '';
	string	City := '';
	string	State := '';
	string	Zip := '';
	string	Company_Phone := '';
	string	EIN := ''; // unique id
	string	Charter_Number := ''; // unique id
	string	UCC_Number := '';  // unique id - doc number
	string	Domain_Name := ''; // unique id
	standard.Addr;
	unsigned6	Appended_BDID := 0;
	string	Appended_EIN := '';
end;

export InputBusUserDataLayout := record
	string	First_Name := '';
	string	Middle_Name := '';
	string	Last_Name := '';
	string	Address := '';
	string	City := '';
	string	State := '';
	string	Zip := '';
	string	Personal_Phone := '';
	string	DOB := '';
	string	DL := ''; // unique id
	string	DL_St := '';
	string	SSN := '';
end;

export CleanBusUserDataLayout := record
	standard.Name - name_score;
	standard.Addr;
	string	Personal_Phone := '';
	string	DOB := '';
	string	DL := ''; // unique id
	string	DL_St := '';
	string	SSN := '';
	string	Appended_SSN := '';
	unsigned6	Appended_ADL := 0;
end;

export BusUserDataLayout := record
	string	First_Name := '';
	string	Middle_Name := '';
	string	Last_Name := '';
	string	Address := '';
	string	City := '';
	string	State := '';
	string	Zip := '';
	string	Personal_Phone := '';
	string	DOB := '';
	string	DL := ''; // unique id
	string	DL_St := '';
	string	SSN := '';
	standard.Name - name_score;
	standard.Addr;
	string	Appended_SSN := '';
	unsigned6	Appended_ADL := 0;
	
end;

export PermissableLayout := record
	string	GLB_purpose := '';
	string	DPPA_purpose := '';
	string	FCRA_purpose := '';
end;

export searchlayout := record
	string	DateTime := '';
	string	Start_Monitor := '';
	string	Stop_Monitor := '';
	string	Login_History_ID := '';
	string	Transaction_ID := '';
	string	Sequence_Number := '';
	string	Method := '';
	string	Product_Code := '';
	string	Transaction_Type := '';
	string	Function_Description := '';
	string	IPAddr := '';
end;

//// BIID2.0 - SBFE Implementation
export BusDataLayoutPlus := record
  BusDataLayout;
	string20 	fax_phone;         
	string8 	sic_code;            
	string8 	naic_code;            
	string32 	business_structure;   
	string3 	years_in_business; 
	string8 	bus_start_date;       
	string12 	yearly_revenue; 
end;

export BusUserDataLayoutPlus := record
       BusUserDataLayout;
       string100 cmp_name;                
       string9   cmp_fein;   	
end;


/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

export Common := record
 mbslayout 				 MBS;
 allowlayout 			 Allow_Flags;
 businfolayout 		 Bus_Intel;
 PersonDataLayout  Person_Q;
 BusDataLayout 		 Bus_Q;
 BusUserDataLayout BusUser_Q;
 PermissableLayout Permissions;
 SearchLayout 		 Search_Info;
end;

export Common_ThorAdditions := record
 Common;
 string    source               :='';
 string3   fraudpoint_score     :='';
 string  orig_RECORD_COUNT    :='';
 string	 orig_PRICE					  :='';
 string	 orig_REPORT_OPTIONS  :='';
 string  orig_function_name	  :='';
end;

export Common_ThorAdditions_non_FCRA:=record
 Common;
 string    source               :='';
 string3   fraudpoint_score     :='';
end;

export Common_ThorAdditions_FCRA := record
	Common;
	string    source               :='';
	unsigned8 persistent_record_id := 0;
end;

export ccpaLayout := record
 UNSIGNED4 global_sid   := 0;   
 UNSIGNED8 record_sid   := 0; 	
end;

export Common_ccpa := record
  Common;
  ccpaLayout ccpa;
end;


export Common_indexes := record
 {Common_ThorAdditions_non_FCRA}-source-bus_q-bususer_q;
  ccpaLayout ccpa;
 //Common;
end;

export Common_indexes_DID_SBA := record
 mbslayout 				 			MBS;
 allowlayout 			 			Allow_Flags;
 businfolayout 		 			Bus_Intel;
 PersonDataLayout  			Person_Q;
 BusUserDataLayoutPlus	BusUser_Q2;
 BusUserDataLayoutPlus	BusUser_Q3;
 BusUserDataLayoutPlus	BusUser_Q4;
 BusUserDataLayoutPlus	BusUser_Q5;
 BusUserDataLayoutPlus	BusUser_Q6;
 BusUserDataLayoutPlus	BusUser_Q7;
 BusUserDataLayoutPlus	BusUser_Q8;
 PermissableLayout 			Permissions;
 SearchLayout 		 			Search_Info;
 string3   fraudpoint_score     :='';
 ccpaLayout ccpa;
end;

export Common_indexes_FCRA := record
 {Common};
 ccpaLayout ccpa;
end;

export Common_Indexes_FCRA_DID_SBA := record
	mbslayout 				 MBS;
	allowlayout 			 Allow_Flags;
	businfolayout 		 Bus_Intel;
	PersonDataLayout  Person_Q;
	BusDataLayout 		 Bus_Q;
	BusUserDataLayoutPlus	BusUser_Q;
	BusUserDataLayoutPlus	BusUser_Q2;
	BusUserDataLayoutPlus	BusUser_Q3;
	BusUserDataLayoutPlus	BusUser_Q4;
	BusUserDataLayoutPlus	BusUser_Q5;
	BusUserDataLayoutPlus	BusUser_Q6;
	BusUserDataLayoutPlus	BusUser_Q7;
	BusUserDataLayoutPlus	BusUser_Q8;
  PermissableLayout Permissions;
  SearchLayout 		 Search_Info;
	ccpaLayout        ccpa;
end;

export adl_reappend := RECORD
  unsigned8 person_q_id;
  string person_q_apssn;
  unsigned6 person_q_apdid;
  unsigned6 person_q_apdidold;
  unsigned8 bus_q_id;
  string bus_q_apfein;
  unsigned6 bus_q_apbdid;
  unsigned6 bus_q_apbdidold;
  unsigned8 bususer_q_id;
  string bususer_q_apssn;
  unsigned6 bususer_q_apdid;
  unsigned6 bususer_q_apdidold;
  boolean change;
END;

export layout_address_characteristics := record
		Risk_Indicators.Layouts.Layout_Addr_Flags2 Addr_Flags;
		string10 listed_phone;
		string20 listed_phone_fname;
		string20 listed_phone_lname;
		string2 listed_phone_source;
	end;
	
export layout_phone_characteristics := record
		string1 phone_indicator;
		string2 phone_type;
		string10 listed_prim_range;
    string2  listed_predir;
    string28 listed_prim_name;
    string4  listed_suffix;
    string2  listed_postdir;
    string10 listed_unit_desig;
    string8  listed_sec_range;
    string25 listed_city_name;
    string2  listed_st;
    string5  listed_zip;
		string20 listed_fname;
		string20 listed_lname;
		string2 listed_address_source;
		string2 disconnects_last_12months;
		string1 zipcode_phone_match;
		string50 highriskphone_description;
		string2 highriskphone_source;
	end;
			
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

export Override := record
	Common_ThorAdditions_non_fcra;
	layout_address_characteristics address_characteristics;
	layout_phone_characteristics phone_characteristics;
end;

export	Layout_inquiry_disclosure := record
		Common_ThorAdditions_FCRA;
		layout_address_characteristics address_characteristics;
		layout_phone_characteristics phone_characteristics;
		
		integer LexIDs_per_inquiry_SSN := 0;
		integer LexIDs_per_inquiry_phone := 0;
		integer LexIDs_per_inquiry_address := 0;
		integer SSNs_per_inquiry_address := 0;
		
		string inquiry_phone_High_risk_source := '';
		string inquiry_phone_characteristics_source := '';
end;
	
//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

export Common_SBA := record
 mbslayout 				 			MBS;
 allowlayout 			 			Allow_Flags;
 businfolayout 		 			Bus_Intel;
 PersonDataLayout  			Person_Q;
 BusDataLayoutPlus 			Bus_Q;
 BusUserDataLayoutPlus	BusUser_Q;
 BusUserDataLayoutPlus	BusUser_Q2;
 BusUserDataLayoutPlus	BusUser_Q3;
 BusUserDataLayoutPlus	BusUser_Q4;
 BusUserDataLayoutPlus	BusUser_Q5;
 BusUserDataLayoutPlus	BusUser_Q6;
 BusUserDataLayoutPlus	BusUser_Q7;
 BusUserDataLayoutPlus	BusUser_Q8;
 PermissableLayout			Permissions;
 SearchLayout 		 			Search_Info;
end;

export Common_ThorAdditions_SBA := record
 Common_SBA;
 string    source               :='';
 string3   fraudpoint_score     :='';
end;
end;