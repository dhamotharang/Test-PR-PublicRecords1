import corp2_mapping, corp2;

EXPORT Layouts := module

   EXPORT RawLayoutIN   := RECORD 
			string	 blob;
  END;

	EXPORT Master_02_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string2   status_id := '';
			string2   corp_type_id := '';
			string150 name := '';
			string2   perpetual_flag := '';
			string8   creation_date := '';
			string8   expiration_date := '';
			string8   inactive_date := '';
			string8   formation_date := '';
			string8   report_due_date := '';
			string11  tax_id := '';
			string150 dba_name := '';
			string16  foreign_fein := '';
			string4   foreign_state := '';
			string64  foreign_country := '';
			string8   foreign_formation_date := '';
			string16  expiration_type := '';
			string3   nonprofit_subtype_id := '';
			string2   boc_flag := '';
			string8   boc_date := '';
			string70  filler_02 := '';
	END;

	EXPORT MastAddr_03_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string50  address1 := '';
			string50  address2 := '';
			string64  city := '';
			string4   state := '';
			string9   zip := '';
			string6   zip_extension := '';
			string64  country := '';
			string301 filler := ''; 
	END;																	

	EXPORT RegBusAgent_05_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string50  BusiAgent_address1 := '';
			string50  BusiAgent_address2 := '';
			string64  BusiAgent_city := ''; 
			string4   BusiAgent_state := '';
			string9   BusiAgent_zip := '';
			string6   BusiAgent_zip_extension := '';
			string64  BusiAgent_country := '';
			string8   BusiAgent_inactive_date := '';
			string150 BusiAgent_business_name := '';
			string143 BusiAgent_filler := '';
	END;

	EXPORT RA_PersName_06_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string50  RegAgent_address1 := '';
			string50  RegAgent_address2 := '';
			string64  RegAgent_city := '';
			string4   RegAgent_state := '';
			string9   RegAgent_zip := '';
			string6   RegAgent_zip_extension := '';
			string64  RegAgent_country := '';
			string8   RegAgent_inactive_date := '';
			string50  Agent_last_name := '';
			string50  Agent_first_name := '';
			string50  Agent_middle_name := '';
			string6   Agent_suffix := '';
			string137 RegAgent_filler := '';
	END;
		
	EXPORT Chart_BusOff_07_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string50  BusinessOffi_address1;
			string50  BusinessOffi_address2;
			string64  BusinessOffi_city;
			string4   BusinessOffi_state;
			string9   BusinessOffi_zip;
			string6   BusinessOffi_zip_extension;
			string64  BusinessOffi_country;
			string6   BusinessOffi_officer_id;
			string32  BusinessOffi_officer_title;
			string150 BusinessOffi_business_name;
			string113 BusinessOffi_filler;
	END;

	EXPORT ChartOff_Pers_08_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string50  address1;
			string50  address2;
			string64  city;
			string4   state;
			string9   zip;
			string6   zip_extension;
			string64  country;
			string6   officer_id;
			string32  officer_title;
			string50  last_name;
			string50  first_name;
			string50  middle_name;
			string6   suffix;
			string107 filler;
	END;
	
	EXPORT CharterNames_09_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string6   name_id;
			string150 name;
			string3   name_status_id;
			string3   name_type_id;
			string8   creation_date;
			string8   inactive_date;
			string8   expire_date;
			string8   county_type;
			string11  consent_filing_number;
			string254 selected_county_array;
			string5   reserved;
			string84  filler;
	END;

	EXPORT AssocEnt_10_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string6   associated_entity_id;
			string150 associated_entity_name;
			string12  entity_filing_number;
			string8   entity_filing_date;
			string64  jurisdiction_country;
			string4   jurisdiction_state;
			string8   inactive_date;
			string4   capacity_id;
			string292 filler;
	END;
		
	EXPORT FilingHist_11_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string14  document_no;
			string12  filing_type_id;
			string96  filing_type;
			string8   entry_date;
			string8   filing_date;
			string8   effective_date;
			string2   effective_cond_flag;
			string8   inactive_date;
			string392 filler;
	END;
			
	EXPORT AuditLog_12_layout := RECORD
			string2   rec_code;
			string10  filing_number;
			string8   audit_date;
			string4   table_id;
			string4   field_id;
			string10  action;
			string300 current_value;
			string222 audit_comment; 
	END;
 

	// Temporary Layouts
	EXPORT 	Master_tempLay := RECORD
					Master_02_layout;
					MastAddr_03_layout    -[rec_code, filing_number];
					RegBusAgent_05_layout ;
					RA_PersName_06_layout ;
					string Bus_or_Pers := '';
	END;

	EXPORT  ContOfficers_07_tempLay := record
					Master_02_layout;
					Chart_BusOff_07_layout;
	END;
	
	EXPORT  ContOfficers_08_tempLay := RECORD
					Master_02_layout;
					ChartOff_Pers_08_layout;
	END;
	
	EXPORT normMaster_Layout        := RECORD
		Master_tempLay;
		string norm_name;
		string norm_type;
	END;
	
	EXPORT normEvent_Layout         := RECORD
		FilingHist_11_layout;			
		string norm_date;
		string norm_type;
	END;	
	
	EXPORT normEvent2_Layout         := RECORD
		CharterNames_09_layout;			
		string norm_date;
		string norm_type;
	END;	
	
	EXPORT normMerger_Layout         := RECORD
		AssocEnt_10_layout;
		string norm_filing_nbr := '';
		string norm_type := '';
	END;
	
	EXPORT CharterNames_09_TempLay		:= RECORD
		CharterNames_09_layout;
		normMaster_Layout.corp_type_id;
		string mast_creation_date;
		normMaster_Layout.foreign_formation_date;
	END;
	
	EXPORT AssocEnt_10_TempLay		:= RECORD
		AssocEnt_10_layout;
		Master_02_layout.corp_type_id;
		Master_02_layout.creation_date;
		Master_02_layout.foreign_formation_date;
	END;
	
	
END;			
