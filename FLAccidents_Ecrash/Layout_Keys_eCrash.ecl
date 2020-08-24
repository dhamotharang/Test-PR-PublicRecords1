EXPORT Layout_Keys_eCrash := MODULE

  EXPORT Agency := RECORD 
		STRING3 Agency_State_Abbr;
		STRING100 Agency_Name;
		STRING11 Agency_Ori;
		STRING11 MBSI_Agency_ID;
		STRING5 Cru_Agency_ID;
		UNSIGNED3 Cru_State_Number;
		STRING3 Source_ID;
		STRING2 Append_Overwrite_Flag;
		STRING10 Source_Start_Date; 
		STRING10 Source_End_Date; 
		STRING20 Source_Termination_Date; 
		STRING1 Source_Resale_Allowed; 
		STRING1 Source_Auto_Renew; 
		STRING1 Source_Allow_Sale_of_Component_Data; 
		STRING1 Source_Allow_Extract_of_Vehicle_Data; 															
	END;

  EXPORT PhotoId := RECORD
	 STRING11 Super_Report_ID;
	 STRING11 Document_ID;
	 STRING3 Report_Type;
	 STRING11 Incident_ID;
	 STRING64 Document_Hash_Key;
	 STRING19 Date_Created;
	 STRING1 Is_Deleted;
	 STRING3 Page_Count;
	 STRING3 Extension;
	 STRING3 Report_Source;
	END;
	
END;