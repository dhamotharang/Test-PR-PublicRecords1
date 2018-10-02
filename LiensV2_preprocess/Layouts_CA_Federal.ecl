// Used in LiensV2.file_liens_main
EXPORT Layouts_CA_Federal := MODULE

	EXPORT Input := RECORD, MAXLENGTH(652)
		string		row_data;
	END;
	
	EXPORT Filing	:= RECORD, MAXLENGTH(78) 
		string1		Record_Code; //Code = '1'
		string14	Initial_Filing_Number;
		string12	static_value;
		string5		Initial_Filing_type;
		string8		Filing_date;
		string4		Filing_time;
		string1		Filing_Status;
		string8		lapse_date;
		string4		page_count;
		string20	Internal_doc_number;
	END;

	EXPORT BusDebtor := RECORD, MAXLENGTH(558)
		string1		Record_Code; //Code = '2'
		string14	Initial_Filing_Number;
		string12	static_value;
		string300	Business_Debtor_Name;
		string110	Business_Debtor_Street_Address;
		string64	Business_Debtor_City;
		string32	Business_Debtor_State;
		string15	Business_Debtor_Zip_Code;
		string6		Business_Debtor_ZipCode_Extension;
		string3		Business_Debtor_Country_Code; 
	END;
	
	EXPORT PersDebtor := RECORD, MAXLENGTH(414)
		string1 	Record_Code; //Code = '3'
		string14 	Initial_Filing_Number;
		string12 	static; 
		string50 	Personal_Debtor_Last_Name;
		string50 	Personal_Debtor_First_Name;
		string50 	Personal_Debtor_Middle_Name;
		string6 	Personal_Debtor_Suffix;
		string110	Personal_Debtor_Street_Address;
		string64 	Personal_Debtor_City;
		string32 	Personal_Debtor_State;
		string15 	Personal_Debtor_Zip_Code;
		string6		Personal_Debtor_Zip_Code_Extension;
		string3 	Personal_Debtor_Country_Code;
	END;
	
	EXPORT BusSecureParty := RECORD, MAXLENGTH(558)
		string1		Record_Code; //Code = '4'
		string14	Initial_Filing_Number; 
		string12	static_value;
		string300	Business_Secured_Party_Name;
		string110	Business_Secured_Party_Street_Address;
		string64	Business_Secured_Party_City;
		string32	Business_Secured_Party_State;
		string15	Business_Secured_Party_Zip_Code;
		string6		Business_Secured_Party_Zip_Code_Extension;
		string3		Business_Secured_Party_Country_Code;
	END;

	EXPORT PersSecureParty := RECORD, MAXLENGTH(414)
		string1		Record_Code; //Code = '5'
		string14	Initial_Filing_Number;
		string12	static_value;
		string50	Personal_Secured_Party_Last_Name;
		string50	Personal_Secured_Party_First_Name;
		string50	Personal_Secured_Party_Middle_Name;
		string6		Personal_Secured_Party_Suffix;
		string110	Personal_Secured_Party_Street_Address;
		string64	Personal_Secured_Party_City;
		string32	Personal_Secured_Party_State;
		string15	Personal_Secured_Party_Zip_Code;
		string6		Personal_Secured_Party_Zip_Code_Extension;
		string3		Personal_Secured_Party_Country_Code;
	END;

	EXPORT ChangeFiling	:= RECORD, MAXLENGTH(70)
		string1		Record_Code; //Code = '6'
		string14	Initial_Filing_Number;
		string12	Change_Filing_Number; // UCC_3_Filing_Number
		string5		Change_Filing_Type; // Initial_Filing_Type
		string8		Change_Filing_Date; // Filing_Date;
		string4		Change_Filing_Time;
		string4		change_page_count; // pagecount of UCC-3
		string20	Internal_Document_Number;
	END;
	
	EXPORT Collateral	:= RECORD, MAXLENGTH(125)
		string1		Record_Code; //Code = '7'
		string14	Initial_Filing_Number;
		string12	static_value;
		string10	Filing_Number_of_UCC_3_Filing;
		string6		Numeric_Collateral_Line_Sequence_Number;
		string80	Collateral_Description;
	END;
	
	EXPORT lookup_files	:= RECORD
		string line_data;
	END;
	
	EXPORT filing_type_lkp := RECORD
		string5	filing_type_cd;
		string	filing_type_desc;
	END;
	
	EXPORT change_filing_lkp := RECORD
		string5	change_filing_cd;
		string	change_filing_desc;
	END;
	
	EXPORT filing_status_lkp := RECORD
		string1	filing_status_cd;
		string	filing_status_desc;
	END;
	
	EXPORT ISO_state_lkp := RECORD
		string3		code;
		string39	ISO_desc;
		string		ISO_code;
	END;
	
	EXPORT province_lkp := RECORD
		string2		code;
		string21	province_desc;
		string		province_code;
	END;
	
	EXPORT state_lkp := RECORD
		string2		state_cd;
		string		state_desc;
	END;

END;

