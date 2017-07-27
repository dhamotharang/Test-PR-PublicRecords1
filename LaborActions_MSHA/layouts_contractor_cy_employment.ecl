export Layouts_Contractor_CY_Employment := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;		
			string Contractor_Id;				
			string Sub_Unit;
			string Commodity_Type;
			string Calendar_Year;
			string Hours_Reported_for_Year;
			string Annual_Coal_Production;
			string Avg_Annual_Employee_Ct;
	end;
	
	export Base := record
			string5  Dart_Id;		
			string7  Contractor_Id;	
			string7  Contractor_Id_Cleaned;						
			string2	 Sub_Unit;
			string2	 Sub_Unit_Cleaned;			
			string1  Commodity_Type;
			string4  Calendar_Year;
			string7  Hours_Reported_for_Year;
			string8  Annual_Coal_Production;
			string5  Avg_Annual_Employee_Ct;
	end;
	
end;