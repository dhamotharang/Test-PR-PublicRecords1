﻿EXPORT New_Samples_layouts := module;

import Scoring_Project_Macros;

Export FraudAdvisor_Layout := RECORD
	STRING	TransactionID;
	STRING	AccountID;
	STRING	TransactionDate;
	STRING	CompanyName;
	STRING	FirstName;
	STRING	LastName;
	STRING	SSN;
	STRING	DOB;
	STRING	Address;
	STRING	City;
	STRING	State;
	STRING	Zip;
	STRING	DL;
	STRING	HomePhone;
	STRING	WorkPhone;
	string	FP_Model;
	string	FP_Model2;
	string	FP_Attributes;
	string	FP_Attributes2;
	end;
	
export LeadIntegrity_Layout := RECORD
	STRING	TransactionID; 
	STRING	AccountID;
	STRING	TransactionDate;
	STRING	CompanyName;
	STRING	FirstName;
	STRING	LastName;
	STRING	SSN;
	STRING	DOB;
	STRING	Address;
	STRING	City;
	STRING	State;
	STRING	Zip;
	STRING	DL;
	STRING	DLState;
	STRING	HomePhone;
	STRING	WorkPhone;
	string 	LI_Model;
	string  LI_AttributeVersion;
end;

export RiskView_Layout := RECORD
	STRING	TransactionID; 
	STRING	AccountID;
	STRING	TransactionDate;
	STRING	CompanyName;
	STRING	FirstName;
	STRING	LastName;
	STRING	SSN;
	STRING	DOB;
	STRING	Address;
	STRING	City;
	STRING	State;
	STRING	Zip;
	STRING	DL;
	STRING	HomePhone;
	STRING	WorkPhone;
	string	AttributeVersion;
	string	Auto;
	string	Bank;
	string	Money;
	string	Prescreen;
	string	Telecom;
	string	Retail;
	string	Custom;
end;
	
export BNK4_CBBL_Layout := RECORD
	STRING	TransactionID; 
	STRING	AccountID;
	STRING	TransactionDate;
	STRING	_LoginId;
	STRING	TribCode;
	STRING	DataRestrictionMask;
	STRING	Account;
	STRING	FirstName ;
	STRING	LastName;
	STRING	Address;
	STRING	City;
	STRING	State ;
	STRING	Zip ;
	STRING	SSN ;
	STRING	DateOfBirth;
	STRING	HomePhone;
	STRING	WorkPhone;
	STRING	Income;
	STRING CompanyName;
	STRING CompanyAddress;
	STRING	CompanyCity;
	STRING	CompanyState;
	STRING	CompanyZIP;
	STRING  FEIN;	
end;	

export Output_structureBNK4 := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.bus_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;	
	
	
export Output_structure := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;
	
EXPORT PI02_layout := RECORD
	STRING	TransactionID; // Forced into the record so I can join it all together
	STRING	AccountID;
	STRING	TransactionDate;
	STRING	_LoginId;
	STRING	TribCode;
	STRING	DataRestrictionMask;
	STRING	Account;
	STRING	FirstName;
	STRING	MiddleName;
	STRING	LastName;
	STRING	Address;
	STRING	City;
	STRING	State;
	STRING	Zip;
	STRING	SSN;
	STRING	DateOfBirth;
	STRING	HomePhone;
	STRING	WorkPhone;
	STRING	Income;
	STRING CompanyName;	
end;
	
EXPORT InstantID_Layout := RECORD
	STRING	TransactionID; // Forced into the record so I can join it all together
	STRING	AccountID;
	STRING	TransactionDate;
	STRING	CompanyName;
	STRING  ReferenceCode;
	STRING  LoadAmount;
	STRING  RetailZip;
	STRING  FirstName;
	STRING  LastName;
	STRING	FullName;
	STRING  SSN;
	STRING	DOB;
	STRING	Address;
	STRING	City;
	STRING	State;
	STRING	Zip;
	STRING	DL;
	STRING	DLState;
	STRING	HomePhone;
	STRING	WorkPhone;
	string  FP_model;
	string	CVI;
	string	NAP;
	string  NAS;
END;	
	
EXPORT BusinessIID_Layout := RECORD
	STRING	TransactionID; // Forced into the record so I can join it all together
	STRING	AccountID;
	STRING	TransactionDate;
	STRING	EndUserCompanyName;
	STRING  CompanyName;
	STRING  CompanyAddress;
	STRING	CompanyCity;
	STRING	CompanyState;
	STRING	CompanyZIP;
	STRING	CompanyPhone10;
	STRING	FEIN;
	STRING	RepFirstName;
	STRING	RepLastName;
	STRING	RepSSN;
	STRING	RepDOB;
	STRING	RepAddress;
	STRING	RepCity;
	STRING	RepState;
	STRING	RepZip;
	STRING	RepDL;
	STRING	RepDLState;
	STRING	RepPhone10;
END;
	
export SBALayout := Record
	string 	TransactionID;
	STRING	AccountID;
	// string 	CompanyName;
	// string  CompanyAddress1;
	// string  CompanyAddress2;
	// string  CompanyCity;
	// string  CompanyState;
	// string  CompanyZIP;
	// string  FEIN;
	// string  CompanyPhone10;
	// string  Rep_1_FirstName;
	// string  Rep_1_LastName;
	// string  Rep_1_SSN;
	// string  Rep_1_DOB;
	// string  Rep_1_Address1;
	// string  Rep_1_Address2;
	// string  Rep_1_City;
	// string  Rep_1_State;
	// string  Rep_1_Zip;
	// string  Rep_1_DL;
	// string  Rep_1_DLState;
	// string  Rep_1_Phone10;
	// string  Rep_2_FirstName;
	// string  Rep_2_LastName;
	// string  Rep_2_SSN;
	// string  Rep_2_DOB;
	// string  Rep_2_Address1;
	// string  Rep_2_Address2;
	// string  Rep_2_City;
	// string  Rep_2_State;
	// string  Rep_2_Zip;
	// string  Rep_2_DL;
	// string  Rep_2_DLState;
	// string  Rep_2_Phone10;
	// string  Rep_3_FirstName;
	// string  Rep_3_LastName;
	// string  Rep_3_SSN;
	// string  Rep_3_DOB;
	// string  Rep_3_Address1;
	// string  Rep_3_Address2;
	// string  Rep_3_City;
	// string  Rep_3_State;
	// string  Rep_3_Zip;
	// string  Rep_3_DL;
	// string  Rep_3_DLState;
	// string  Rep_3_Phone10;
	 String companyname;
 String altcompanyname;
 String streetaddress1;
 String streetaddress2;
 String city;
 String state;
 String zip9;
 String prim_range;
 String predir;
 String prim_name;
 String addr_suffix;
 String postdir;
 String unit_desig;
 String sec_range;
 String zip5;
 String zip4;
 String lat;
 String long;
 String addr_type;
 String addr_status;
 String county;
 String geo_block;
 String fein;
 String phone10;
 String ipaddr;
 String companyurl;
 String sic_code;
 String naic_code;
 String bus_lexid;
 String bus_structure;
 String years_in_business;
 String bus_start_date;
 String yearly_revenue;
 String fax_number;
 String rep_fullname;
 String rep_nametitle;
 String rep_firstname;
 String rep_middlename;
 String rep_lastname;
 String rep_namesuffix;
 String rep_formerlastname;
 String rep_streetaddress1;
 String rep_streetaddress2;
 String rep_city;
 String rep_state;
 String rep_zip;
 String rep_prim_range;
 String rep_predir;
 String rep_prim_name;
 String rep_addr_suffix;
 String rep_postdir;
 String rep_unit_desig;
 String rep_sec_range;
 String rep_zip5;
 String rep_zip4;
 String rep_lat;
 String rep_long;
 String rep_addr_type;
 String rep_addr_status;
 String rep_county;
 String rep_geo_block;
 String rep_ssn;
 String rep_dateofbirth;
 String rep_phone10;
 String rep_age;
 String rep_dlnumber;
 String rep_dlstate;
 String rep_email;
 String rep_lexid;
 String rep2_fullname;
 String rep2_nametitle;
 String rep2_firstname;
 String rep2_middlename;
 String rep2_lastname;
 String rep2_namesuffix;
 String rep2_formerlastname;
 String rep2_streetaddress1;
 String rep2_streetaddress2;
 String rep2_city;
 String rep2_state;
 String rep2_zip;
 String rep2_prim_range;
 String rep2_predir;
 String rep2_prim_name;
 String rep2_addr_suffix;
 String rep2_postdir;
 String rep2_unit_desig;
 String rep2_sec_range;
 String rep2_zip5;
 String rep2_zip4;
 String rep2_lat;
 String rep2_long;
 String rep2_addr_type;
 String rep2_addr_status;
 String rep2_county;
 String rep2_geo_block;
 String rep2_ssn;
 String rep2_dateofbirth;
 String rep2_phone10;
 String rep2_age;
 String rep2_dlnumber;
 String rep2_dlstate;
 String rep2_email;
 String rep2_lexid;
 String rep3_fullname;
 String rep3_nametitle;
 String rep3_firstname;
 String rep3_middlename;
 String rep3_lastname;
 String rep3_namesuffix;
 String rep3_formerlastname;
 String rep3_streetaddress1;
 String rep3_streetaddress2;
 String rep3_city;
 String rep3_state;
 String rep3_zip;
 String rep3_prim_range;
 String rep3_predir;
 String rep3_prim_name;
 String rep3_addr_suffix;
 String rep3_postdir;
 String rep3_unit_desig;
 String rep3_sec_range;
 String rep3_zip5;
 String rep3_zip4;
 String rep3_lat;
 String rep3_long;
 String rep3_addr_type;
 String rep3_addr_status;
 String rep3_county;
 String rep3_geo_block;
 String rep3_ssn;
 String rep3_dateofbirth;
 String rep3_phone10;
 String rep3_age;
 String rep3_dlnumber;
 String rep3_dlstate;
 String rep3_email;
 String rep3_lexid;
 String dppa_purpose;
 String glba_purpose;
 String data_restriction_mask;
 String data_permission_mask;
 String industryclass;
 String historydate;
 String linksearchlevel;
 String marketingmode;
 String busshellversion;
 String powid;
 String proxid;
 String seleid;
 String orgid;
 String ultid;

	string  Models;
	string  Attributes;
END;
	end;