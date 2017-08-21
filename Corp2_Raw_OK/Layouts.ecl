EXPORT Layouts := module

  EXPORT RawLayoutIN   := RECORD 
			string	blob;
  END;
	
	EXPORT Entity_01_Layout := record
			string2   f01_record_header;
			string10  f01_Filing_Number;
			string2	  f01_Status_ID;
			string2	  f01_Corp_Type_ID;
			string13  f01_Address_ID;
			string150	f01_Name;
			string30	f01_Perpetual_Flag;
			string10	f01_Creation_Date;
			string10	f01_Expiration_Date;
			string10	f01_Inactive_Date;
			string10	f01_Formation_Date;
			string10	f01_Report_Due_Date;
			string16	f01_Tax_ID;
			string150	f01_Fictitious_Name;
			string16	f01_Foreign_Fein;
			string4	  f01_Foreign_State;
			string3	  f01_Foreign_Country;
			string10	f01_Foreign_Formation_Date;
			string16	f01_Expiration_Type;
			string10	f01_Last_Report_Filed_Date;
			string25	f01_Telephone_Number;
			string2	  f01_OTC_Suspension_Flag;
			string2	  f01_Consent_Name_Flag;
			string2	  f01_lf;
	end;
	
	EXPORT Entity_01_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			Entity_01_Layout;
	END;
	
	EXPORT Address_02_Layout := record
			string2 	f02_RECORD_HEADER;
			string13 	f02_Address_ID;
			string50 	f02_Address1;
			string50 	f02_Address2;
			string64 	f02_City;
			string4 	f02_State;
			string9 	f02_Zip_Code;
			string6 	f02_Zip_Extension;
			string3 	f02_Country;
			string1 	f02_lf;
		end;
	
	EXPORT Address_02_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			Address_02_Layout;
	END;
	
	EXPORT Agent_03_Layout := record
			string2 	f03_RECORD_HEADER;
			string10 	f03_Filing_Number;
			string13 	f03_Address_ID;
			string150 f03_Business_Name;
			string50 	f03_Agent_Last_Name;
			string50 	f03_Agent_First_Name;
			string50 	f03_Agent_Middle_Name;
			string13 	f03_Agent_Suffix_Id;
			string10 	f03_Creation_Date;
			string10 	f03_Inactive_Date;
			string150 f03_Normalized_Name;
			string2 	f03_SOS_RA_Flag;
			string1 	f03_lf;
		end;
	
	EXPORT Agent_03_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			Agent_03_Layout;
	END;
	
	EXPORT Officer_04_Layout := record
			string2 	f04_RECORD_HEADER;
			string10 	f04_Filing_Number;
			string6  	f04_Officer_ID;
			string32	f04_Officer_Title;
			string150 f04_Business_Name;
			string50 	f04_Officer_Last_Name;
			string50 	f04_Officer_First_Name;
			string50 	f04_Officer_Middle_Name;
			string6 	f04_Officer_Suffix_ID;
			string13 	f04_Address_ID;
			string10 	f04_Creation_Date;
			string10 	f04_Inactive_Date;
			string10  f04_Last_Modified_Date;
			string150	f04_Normalized_Name;
			string1 	f04_lf;
		end;

	EXPORT Officer_04_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			Officer_04_Layout;
	END;
	
	EXPORT Names_05_Layout := record
			string2 	f05_RECORD_HEADER;
			string10 	f05_Filing_Number;
			string6 	f05_Name_ID;
			string150 f05_Name;
			string30 	f05_Name_Status_ID;
			string3 	f05_Name_Type_ID;
			string10 	f05_Creation_Date;
			string10 	f05_Inactive_Date;
			string10 	f05_Expire_Date;
			string10 	f05_All_Counties_Flag;
			string12 	f05_Consent_Filing_Number;
			string2 	f05_Search_ID;
			string10  f05_Transfer_To;
			string10	f05_Received_From;
			string2 	f05_lf;
		end;

	EXPORT Names_05_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			Names_05_Layout;
	END;
	
	EXPORT AssocEnt_06_Layout := record
			string2 	f06_RECORD_HEADER;
			string10 	f06_Filing_Number;
			string13 	f06_Document_Number;
			string6  	f06_Associated_Entity_ID;
			string6   f06_Assoc_Ent_Corp_Type_ID;
			string4  	f06_Primary_Capacity_ID;
			string4  	f06_Capacity_ID;
			string150	f06_Associated_Entity_Name;
			string12  f06_Entity_Filing_Number;
			string10  f06_Entity_Filing_Date;
			string10  f06_Inactive_Date;
			string10  f06_Jurisdiction_State;
			string3  	f06_Jurisdiction_Country;
			string1 	f06_lf;
		end;

	EXPORT AssocEnt_06_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			AssocEnt_06_Layout;
	END;
	
	EXPORT StockData_07_Layout := record
			string2 	f07_RECORD_HEADER;
			string13  f07_Stock_ID;
			string13  f07_Filing_Number;
			string13  f07_Stock_Type_ID;
			string256 f07_Stock_Series;
			string40  f07_Share_Volume;
			string40  f07_Par_Value;
			string1   f07_lf;
		end;

	EXPORT StockData_07_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			StockData_07_Layout;
	END;
	
	EXPORT StockInfo_08_Layout := record
			string2 	f08_RECORD_HEADER;
			string13	f08_Filing_Number;
			string1		f08_Qualify_Flag;
			string1		f08_Unlimited_Flag;
			string40	f08_Actual_Amt_Invested;
			string40	f08_Pd_On_Credit;
			string40	f08_Tot_Auth_Capital;
			string1		f08_lf;
		end;

	EXPORT StockInfo_08_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			StockInfo_08_Layout;
	END;
	
	EXPORT CorpType_12_Layout := record
			string2 	f12_RECORD_HEADER;
			string13	f12_Corp_Type_ID;
			string80	f12_Corp_Type_Desc;
			string1 	f12_lf;
		end;

	EXPORT CorpType_12_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			CorpType_12_Layout;
	END;
	
	EXPORT CorpFiling_17_Layout := record
			string2 	f17_RECORD_HEADER;
			string10	f17_Filing_Number;  
			string12	f17_Document_Number;
			string12	f17_Filing_Type_ID;
			string96	f17_Filing_Type;
			string10	f17_Entry_Date;  
			string10	f17_Filing_Date;
			string10	f17_Effective_Date;
			string2		f17_Effective_Condition_Flag;
			string10	f17_Inactive_Date;
			string1 	f17_lf;
		end;
	
	EXPORT CorpFiling_17_LayoutBase := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			CorpFiling_17_Layout;
	END;
	
	// Temporary Layouts
	
	EXPORT EntityLookups := record
	    Entity_01_Layout;
			Names_05_Layout;
			AssocEnt_06_Layout;
			string80	Corp_Type_Desc;
			string50 	Corp_Address1;
			string50 	Corp_Address2;
			string64 	Corp_City;
			string4 	Corp_State;
			string9 	Corp_Zip_Code;
			string6 	Corp_Zip_Extension;
			string3 	Corp_Country;
			string10 	Agent_Filing_Number;
			string13 	Agent_Address_ID;
			string50  Agent_Address1;
			string50  Agent_Address2;
			string64  Agent_City;
			string4 	Agent_State;
			string9 	Agent_Zip_Code;
			string6 	Agent_Zip_Extension;
			string3 	Agent_Country;
			string150 Agent_Business_Name;
			string50 	Agent_Last_Name;
			string50 	Agent_First_Name;
			string50 	Agent_Middle_Name;
			string13 	Agent_Suffix_Id;
			string10 	Agent_Creation_Date;
			string10 	Agent_Inactive_Date;
			string2 	Agent_SOS_RA_Flag;
		end;
		
	EXPORT ARLookups := record
			Entity_01_Layout;
			CorpFiling_17_Layout;
	  end;
		
	EXPORT StockLookups := record
			StockData_07_Layout;
			StockInfo_08_Layout;
		end;	

	EXPORT OfficerLookups := record
			string150	f01_Name;
			Address_02_Layout;
			Officer_04_Layout;
		end;
	
	EXPORT normContLayout := record
		  OfficerLookups;
			string  norm_ContEff_Date;
  		string1 norm_type;
		end;	
		
	EXPORT normEventLayout := record
		  CorpFiling_17_Layout;
			string  norm_Event_Filing_Date;
  		string1 norm_type;
		end;		
	
END;
