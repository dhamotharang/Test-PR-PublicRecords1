EXPORT Layout_Keys_eCrash := MODULE

  EXPORT Agency := RECORD
		STRING3    Agency_State_Abbr;
		STRING100  Agency_Name;
		STRING11   Agency_Ori;
		STRING11   MBSI_Agency_ID;
		STRING5    Cru_Agency_ID;
		UNSIGNED3  Cru_State_Number;
		STRING2    Source_ID;
		STRING2    Append_Overwrite_Flag;															
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
	END;
	
END;