EXPORT Layout_MBSAgency := MODULE 
 
 EXPORT agency := RECORD
		STRING11  Agency_ID;
	  STRING100 Agency_Name;
	  STRING3   Source_ID;
	  STRING10  Agency_State_Abbr;
	  STRING11  Agency_ori; 
	  STRING1   Allow_Open_Search; 
	  STRING2   Append_Overwrite_Flag;
	  STRING1   Drivers_Exchange_Flag; 
	END; 
	
	EXPORT agency_contrib_source := RECORD
		STRING11  Agency_ID;
	  STRING100 Agency_Name;
		STRING10  Agency_State_Abbr;
	  STRING11  Agency_ori;
	  STRING1   Allow_Open_Search;
	  STRING2   Append_Overwrite_Flag;
	  STRING1   Drivers_Exchange_Flag;   
	  STRING3   Source_ID;
	  STRING10  Source_Start_Date; 
	  STRING10  Source_End_Date; 
	  STRING20  Source_Termination_Date; 
	  STRING1   Source_Resale_Allowed; 
	  STRING1   Source_Auto_Renew; 
	  STRING1   Source_Allow_Sale_Of_Component_Data; 
	  STRING1   Source_Allow_Extract_Of_Vehicle_Data; 
	END; 

END;