export Layouts_Contractor_QT_Employment := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;	
			string Contractor_Id;				
			string Sub_Unit_Description;			
			string Sub_Unit;
			string Production_Year;						
			string Production_Quarter;						
			string Fiscal_Year;
			string Fiscal_Quarter;
			string Commodity_Type;
			string Avg_Employee_Ct;					
			string Employee_Hours_Worked;
			string Coal_Production;
	end;

	export Base := record
			string5  Dart_Id;	
			string7  Contractor_Id;
			string7  Contractor_Id_Cleaned;							
			string50 Sub_Unit_Description;		
			string2  Sub_Unit;
			string2  Sub_Unit_Cleaned;
			string4  Production_Year;						
			string1  Production_Quarter;						
			string4  Fiscal_Year;
			string1  Fiscal_Quarter;
			string1  Commodity_Type;
			string5  Avg_Employee_Ct;					
			string7  Employee_Hours_Worked;
			string8  Coal_Production;
	end;

end;