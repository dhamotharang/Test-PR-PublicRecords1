EXPORT Layout_MBSAgency := MODULE 
 
 	EXPORT agency_spray := RECORD
		STRING Agency_ID;
	  STRING Agency_Name;
		STRING Agency_State_Abbr;
	  STRING Agency_ori;
	  STRING Allow_Open_Search;
	  STRING Append_Overwrite_Flag;
	  STRING Drivers_Exchange_Flag;   
	  STRING Source_ID;
	  STRING Source_Start_Date; 
	  STRING Source_End_Date; 
	  STRING Source_Termination_Date; 
	  STRING Source_Resale_Allowed; 
	  STRING Source_Auto_Renew; 
	  STRING Source_Allow_Sale_Of_Component_Data; 
	  STRING Source_Allow_Extract_Of_Vehicle_Data; 
	END; 
	
	EXPORT agency := RECORD
		STRING11  Agency_ID;
	  STRING100 Agency_Name;
		STRING10  Agency_State_Abbr;
	  STRING11  Agency_ori;
	  STRING1   Allow_Open_Search;
	  STRING2   Append_Overwrite_Flag;
	  STRING1   Drivers_Exchange_Flag;   
	  STRING3   Source_ID;
	  STRING10  Orig_Source_Start_Date; 
	  UNSIGNED4  Source_Start_Date; 
	  STRING10  Orig_Source_End_Date; 
	  UNSIGNED4  Source_End_Date; 
	  STRING20  Orig_Source_Termination_Date; 	    
	  UNSIGNED4  Source_Termination_Date; 	    
	  STRING1   Source_Resale_Allowed; 
	  STRING1   Source_Auto_Renew; 
	  STRING1   Source_Allow_Sale_Of_Component_Data; 
	  STRING1   Source_Allow_Extract_Of_Vehicle_Data; 
	END; 

END;