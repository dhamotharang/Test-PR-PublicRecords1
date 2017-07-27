export Layouts_Operator_QT_Employment := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;		
			string Mine_Id;						
			string Sub_Unit;
			string Sub_Unit_Description;							
			string Production_Year;						
			string Production_Quarter;						
			string QT_Fiscal_Year;
			string QT_Fiscal_Quarter;
			string Avg_Employee_Ct;					
			string Employee_Hours_Worked;
			string Coal_Production;
	end;

	export Base := record
			string5 	Dart_Id;	
			string7 	Mine_Id;	
			string7 	Mine_Id_Cleaned;
			string2 	Sub_Unit; 
			string2 	Sub_Unit_Cleaned; 			
			string50 	Sub_Unit_Description;							
			string4 	Production_Year;						
			string1 	Production_Quarter;						
			string4 	QT_Fiscal_Year;
			string1 	QT_Fiscal_Quarter;
			string5 	Avg_Employee_Ct;					
			string7 	Employee_Hours_Worked;
			string8 	Coal_Production;
	end;
	
end;