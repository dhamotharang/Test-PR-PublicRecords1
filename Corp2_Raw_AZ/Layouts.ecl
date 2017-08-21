EXPORT Layouts := module

  //Vendor Input files and Base Files
	
  export COREXT_LayoutIn := record
	  string4 	Record_Id_1000;
		string60 	Compacted_Corp_Name;
		string9 	File_Number;
		string60 	Corporation_Name;
		string30 	First_Address_Line1;
		string30 	First_Address_Line2;
		string30 	First_Address_Line3;
		string20 	First_Address_City;
		string2 	First_Address_State;
		string9 	First_Address_Zip_Code;
		string10 	County;
		string8 	Amendment_Date;
		string8 	Amendment_Publication_Date;
		string8 	Annual_Report_Received_Date;
		string2 	Status_Code;
		string1 	Amendment_Publication_Exception_Cod;
		string2 	Fiscal_Month;
		string4 	Last_Year_Annual_Report_Filed;
		string2 	Prvious_Fiscal_Month;
		string4 	Last_Year_Annual_Report_Filed_for_P;
		string8 	Extension_Due_Date;
		string8 	Date_of_Incorporation;
		string8 	Disclosure_Date;
		string8 	Date_of_Approval_of_Articles_of_Inc;
		string8 	Renewal_Date;
		string140 Comments;
		string1 	Corporation_Type_Code;
		string1 	Exception_Code;
		string2 	Domicile_State;
		string2 	Corporation_Life;
		string8 	Expiration_Date;
		string1 	Dissolution_Code;
		string8 	Dissolution_Date;
		string32 	Revocation_Comment1;
		string32 	Revocation_Comment2;
		string8 	Stat_Agent_Appointment_Resign_Date;
		string1 	Stat_Agent_Appointment_Resign_Code;
		string8 	Date_of_Pub_of_art_of_inc;
		string8 	Status_Date;
		string30 	Statutory_Agent_Name;
		string30 	Statutory_Agent_Address_Line_1;
		string30 	Statutory_Agent_Address_Line_2;
		string30 	Statutory_Agent_Address_Line_3;
		string20 	Statutory_Agent_Address_City;
		string2 	Statutory_Agent_Address_State;
		string9 	Statutory_Agent_Address_Zip_Code;
		string30 	Second_Address_Line1;
		string30 	Second_Address_Line2;
		string30 	Second_Address_Line3;
		string20 	Second_Address_City;
		string2 	Second_Address_State;
		string9 	Second_Address_Zip_Code;
		string8 	Merger_Date;
		string8 	Merger_Publication_Date;
		string1 	Merger_Publication_Exception_Code;
		string8 	Bankruptcy_Date;
		string8 	Annual_Report_Returned_Date;
		string2 	Annual_Report_Returned_Code;
		string1 	Corext_lf;	
	end;
	
	export COREXT_LayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		COREXT_LayoutIn;
	end;	
	
	export CHGEXT_LayoutIn := record
		string4 	Record_Id_2001_2999;
		string60  Chgext_Compacted_Corp_Name;
		string9 	File_Number;
		string1 	Change_Merge_Code;
		string8 	Change_Merge_Date;
		string60 	Change_Merge_From_Name;
		string1  	Chgext_lf;
	end;
	
	export CHGEXT_LayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		CHGEXT_LayoutIn;
	end;
		 
	export FLMEXT_LayoutIn := record
		string4 	Record_Id_3001_3999;
		string60 	Flmext_Compacted_Corp_Name;
		string9 	File_Number;
		string11 	Microfilm_Location;
		string8 	Date_Document_Received;
		string50 	Document_Description;
		string1 	Flmext_lf;
	end;
			
	export FLMEXT_LayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		FLMEXT_LayoutIn;
	end;

  export OFFEXT_LayoutIn := record
	 string9 	Officer_File_Number;
	 string2 	Title_Code;
	 string30 Officer_Name;
	 string30 Officer_Address_Line1;
	 string30 Officer_Address_Line2;
	 string30 Officer_Address_Line3;
	 string20 Officer_Address_City;
	 string2 	Officer_Address_State;
	 string9 	Officer_Addr_Zip;
	 string1 	Offext_lf;
	end;
	
	export OFFEXT_LayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		OFFEXT_LayoutIn;
	end;
	
	//Intermediate Files
	
	export normLayout := record
		COREXT_LayoutIn;
		string 	Norm_Street1;
		string 	Norm_Street2;
		string  Norm_City;
    string  Norm_State;
		string  Norm_Zip;
		string 	Norm_Type;
	end;
		
	export COREXT_FLMEXT := record
    COREXT_LayoutIn;
		string4 	Record_Id_3001_3999;
		string60 	Flmext_Compacted_Corp_Name;
		string11 	Microfilm_Location;
		string8 	Date_Document_Received;
		string50 	Document_Description;
		string1 	Flmext_lf;
	end;
	
	export COREXT_OFFEXT := record
   COREXT_LayoutIn;
   OFFEXT_LayoutIn;
	end;
	
	export FinalOfficerFile := record
		COREXT_OFFEXT;
		string      Title1;
		string      Title2;
		string      Title3;
		string      Title4;
		string      Title5;
	end;
	
	export normEventLayout := record
		COREXT_LayoutIn;
		string 	Norm_Event_Filing_Date := '';
		string  Norm_Event_Filing_Desc := '';
  end;
	
	export CHGEXT_TempLay := record
		CHGEXT_LayoutIn;
		COREXT_LayoutIn.DOMICILE_STATE;
		COREXT_LayoutIn.DATE_OF_INCORPORATION;
	end;
	
end;	 