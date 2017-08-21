import address;
export Layouts := module
		
	export	Input	:=	module

		export PubRec	:=	record
			string	Record_ID;
			string	Name;
			string	Business_Name;
			string	Address;
			string	Secondary_Address;
			string	City;
			string	State;
			string	Zip_Code;
			string	Phone_Number;
			string	SSN;
			string	Tax_ID_Number;
			string	Case_Number;
			string	Case_State;
			string	Charter_Number;
			string	Charter_State;
		end;

		export ConsumerRec	:=	
		record
			string	Record_ID;
			string	Name;
			string	Address;
			string	Secondary_Address;
			string	City;
			string	State;
			string	Zip_Code;
			string	Phone_Number;
			string	SSN;
		end;
		
		export CleanPubRec	:=	RECORD
/*
			string record_id;
			string name;
			string business_name;
			string address;
			string secondary_address;
			string city;
			string state;
			string zip_code;
			string phone_number;
			string ssn;
			string tax_id_number;
			string case_number;
			string case_state;
			string charter_number;
			string charter_state;
*/
			PubRec;
			string5   title;
			string20  fname;
			string20  mname;
			string20  lname;
			string5   name_suffix;
			string3   name_score;
			string10  prim_range;
			string2   predir;
			string28  prim_name;
			string4   addr_suffix;
			string2   postdir;
			string10  unit_desig;
			string8   sec_range;
			string25  p_city_name;
			string25  v_city_name;
			string2   st;
			string5   zip;
			string4   zip4;
			string4   cart;
			string1   cr_sort_sz;
			string4   lot;
			string1   lot_order;
			string2   dbpc;
			string1   chk_digit;
			string2   rec_type;
			string5   county;
			string10  geo_lat;
			string11  geo_long;
			string4   msa;
			string7   geo_blk;
			string1   geo_match;
			string4   err_stat;
			unsigned8 did;
			unsigned8 did_score;
			unsigned8 bdid;
			unsigned8 bdid_score;
			string9   app_ssn;
			string9   app_tax_id;
		end;
		
		export AssetLicRec	:=	record
			string	Record_ID;
			string	Name;
			string	Business_Name;
			string	Address;
			string	Secondary_Address;
			string	City;
			string	State;
			string	Zip_Code;
			string	Phone_Number;
			string	SSN;
			string	Tax_ID_Number;
			string	VIN;
			string	Craft_ID;
			string	License_Plate_Number;
			string	License_Plate_State;
		end;
		
		export CleanAssetLicRec	:=	record
			AssetLicRec;
			address.Layout_Clean_Name;
			address.Layout_Clean182;
			unsigned6 did := 0;
			unsigned did_score := 0;
			unsigned6 bdid := 0;
			unsigned bdid_score := 0;
			string9 app_ssn := '';
			string9 app_tax_id := '';
		end;
		
	end;
	
	export Response := 
	module

		export AreaCode_Extract :=
		record
			string SourceZip;
			// string	Record_ID					;
			string	area_code					;
		end;

		export ZipCode_Extract :=
		record
			// string	Record_ID			;
			string	ZipCode				;
			string	city					;
			string	state					;
		end;

		export Employment_Extract :=
		record

			string	Record_ID					;
			string	Name							;
			string	Company_Name			;
			string	tax_ID 						;
			string	title 						;
			string	Street_Address		;
			string	Secondary_Address	;
			string	City							;
			string	State							;
			string	Zip_Code					;
			string	phone							;
			string	email							;
			string	ssn								;
			string	date_last_reported;
			string	date_added				;
			string	confidence_level	;

		end;
		
		export TaxId_Extract :=
		record

			string	Record_ID					;
			string	Business_Name			;
			string	Street_Address		;
			string	Secondary_Address	;
			string	City							;
			string	State							;
			string	Zip_Code					;
			string	phone							;
			string	tax_ID 						;
			string	last_report_date	;

		end;
	
		export TaxId_extract_temp :=
		record
			unsigned6 										bdid					;
			TaxId_Extract									Extract				;
			Address.Layout_Clean182_fips	Clean_Address	;
		end;

		export TaxId_Pubrec_temp :=
		record
			unsigned6 										bdid					;
			unsigned3											bdid_score		;
			input.PubRec								;
			Address.Layout_Clean182_fips;
		end;

		export TaxId_Append :=
		record

			input.PubRec							SearchCriteria;
			TaxId_Extract - Record_ID Appended_data	;

		end;

		export TaxId_Append_temp :=
		record
			unsigned6 										bdid					;
			unsigned3											bdid_score		;
			input.PubRec							SearchCriteria;
			TaxId_Extract - Record_ID Appended_data	;

		end;

		export SSN_Extract :=
		record

			string	Record_ID					;
			string	first_Name			;
			string	middle_Name			;
			string	last_Name			;
			string	Street_Address		;
			string	Secondary_Address	;
			string	City							;
			string	State							;
			string	Zip_Code					;
			string	phone							;
			string	SSN 						;
			string	SSN_issuing_state 						;
			string	SSN_issuing_date 						;
			string	date_of_birth 						;
			string	added_date 						;
			string	last_report_date	;
		end;
	
		export SSN_Append :=
		record

			input.PubRec SearchCriteria;
			SSN_Extract - Record_ID Appended_data;

		end;
		
		export Voter_Extract :=
		record
			string	Source_Zip						;
			string	Rec_ID								;
			string	first_Name						;
			string	middle_Name						;
			string	last_Name							;
			string	Street_Addr						;
			string	Secondary_Addr				;
			string	Res_City							;
			string	St										;
			string	Zip										;
			string	SSN_out								;
			string	DOB										;
			string	Gender						 		;
			string	Race						 			;
			string	Occupation						;
			string	Mail_Street_Addr			;
			string	Mail_Secondary_Addr		;
			string	Mail_City						 	;
			string	Mail_St								;
			string	Mail_Zip							;
			string	Last_Vote_Date				;
			string	Registration_Date			;
			string	State_of_Registration	;
			string	Political_Party				;
			string	Active_Status					;
			//string	Phone									;
		end;
		
		export Voter_Append_temp := record
			Input.AssetLicRec;
			Voter_Extract and not [Source_Zip];
		end;
	
		export Voter_Append :=	record
			Voter_Append_temp and not [rec_id];						
		end;
		
		export Fishing_Hunting_Extract := record
			string	Source_Zip						;
			string 	rec_ID								;
			string	first_Name						;
			string	middle_Name						;
			string	last_Name							;
			string	Street_Addr						;
			string	Secondary_Addr				;
			string	res_City							;
			string	St										;
			string	Zip										;
			string	license_type					;
			string  Home_State						;
			string	license_state					;
			string	license_date					;
			string	license_number				;
			string	SSN_Out								;
			string	Gender								;
			string	DOB										;
			
			string	mail_Street_Addr			;
			string	mail_Secondary_Addr		;
			string	mail_City							;
			string	mail_St								;
			string	mail_Zip							;
			
		end;
		
		export Fishing_Hunting_Append_temp := record
			Input.AssetLicRec;
			Fishing_Hunting_Extract and not [source_zip];
		end;
		
		export Fishing_Hunting_Append := record
			Fishing_Hunting_Append_temp and not [rec_id];
		end;
		
	end;

	export UCC := module
		
		export FDS_Extract_Layout := record
			string  sourceZip;
			string  rec_id;
			string  d_fName;
			string  d_mName;
			string  d_lName;
			string  d_companyName;
			string  d_street1;
			string  d_street2;
			string  d_city;
			string  d_state;
			string  d_zip;
			string  c_fName;
			string  c_mName;
			string  c_lName;
			string  c_companyName;
			string  c_street1;
			string  c_street2;
			string  c_city;
			string  c_state;
			string  c_zip;
			string  filing_date;
			string  filing_type;
			string  filing_state;
			string  filing_count;
			string  filing_number;
			string  original_filing_number;
			string  original_filing_date;
			string  document_count;
			string  debtor_count;
			string  secured_count;
			string  collateral_desc;
		end;
		
		export FDS_Append_temp_layout := record
			input.PubRec;
			FDS_Extract_Layout and not [sourceZip];
			//string	Status;
			string	Expiration_Date;
			string	Orig_filing_type;
		end;
		
		export FDS_Append_Layout := record
			FDS_Append_temp_layout and not [rec_id];
		end;
		
	end;
	
	export Prolic_Extract 	:= 	record
		string  sourceZip;
		string	Record_ID;
		string	first_Name;
		string	middle_Name;
		string	last_Name;
		string	company_name;
		string	Street_Address;
		string	Secondary_Address;
		string	City;
		string	State;
		string	Zip_Code;
		string	phone;
		string	License_Number;
		string	License_State;
		string	License_Type;
		string	License_Profession;
		string	License_Status;
		string	License_Issue_Date;
		string	License_Expiration_Date;
		string	Last_Renewal_Date;
	end;
	
	export Prolic_Extract_temp 	:=	record
		unsigned6	key;
		string		prolic_key;
		string		date_last_seen;
		Prolic_Extract;
	end;
	
	export Prolic_Append	:=	record
		input.AssetLicRec SearchCriteria;
		Prolic_Extract - Record_ID Appended_data;
	end;
	
	export EDA_Extract := record
			string sourcezip;
			string record_ID;
			string	first_Name;
			string	middle_Name;
			string	last_Name;
			string	Address1;
			string	Address2;
			string	City_;
			string	State_;
			string	Zip_Code_;
			string address_type;
			string MSA;
			string county;
			string phone;
			string line_type;
			string original_carrier;
			string last_update;
			string first_reported;
	end;
	
	export EDA_Append := record
		fds_test.consumer_layouts.input.ConsumerRec;
		EDA_Extract and not [record_id, sourcezip];
	end;
end;