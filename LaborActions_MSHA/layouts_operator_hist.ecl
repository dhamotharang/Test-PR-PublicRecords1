export Layouts_Operator_Hist := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;
			string Mine_Id;				
			string Operator_Id;
			string Operator_Start_Date;
			string Operator_End_Date;
			string Operator_Name;
			string Mine_Name;
	end;

	export Base := record
			string5	  Dart_Id;			
			string7 	Mine_Id;
			string7 	Mine_Id_Cleaned;
			string7 	Operator_Id;
			string7 	Operator_Id_Cleaned;
			string8 	Operator_Start_Date;
			string8 	Operator_End_Date;
			string80 	Operator_Name;
			string80 	Mine_Name;
	end;
	
end;