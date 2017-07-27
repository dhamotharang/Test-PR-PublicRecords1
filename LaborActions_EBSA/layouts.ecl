export Layouts := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;						
			string Date_Added;					
			string Date_Updated;				
			string Website;						
			string State;							
			string Casetype;						
			string Plan_Ein;						
			string Plan_No;						
			string Plan_Year;					
			string Plan_Name;					
			string Plan_Administrator;	
			string Admin_State;
			string Admin_Zip_Code;
			string Admin_Zip_Code4;
			string Closing_Reason;			
			string Closing_Date;				
			string Penalty_Amount;			
	end;

	export Base := record
			unsigned6 Date_FirstSeen;
			unsigned6 Date_LastSeen;
			string5	  Dart_Id;						
			string8 	Date_Added;					
			string8 	Date_Updated;				
			string50	Website;						
			string2	  State;							
			string20 	Casetype;						
			string10	Plan_Ein;						
			string3	  Plan_No;						
			string10	Plan_Year;					
			string150 Plan_Name;					
			string100 Plan_Administrator;	
			string30	Admin_State;
			string5	  Admin_Zip_Code;
			string4	  Admin_Zip_Code4;
			string30	Closing_Reason;			
			string8	  Closing_Date;				
			string20	Penalty_Amount;
			string150 Clean_Plan_Name;					
			string100 Clean_Plan_Administrator;	
	end;

	export Roll_Up := record
			Base;
			string150 Rollup_Clean_Plan_Name;					
			string100 Rollup_Clean_Plan_Administrator;	
	end;
	
end;