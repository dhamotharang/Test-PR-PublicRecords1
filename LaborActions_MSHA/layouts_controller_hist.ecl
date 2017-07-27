export Layouts_Controller_Hist := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;			
			string Controller_Id;				
			string Operator_Id;
			string Controller_Start_Date;
			string Controller_Name;
			string Controller_End_Date;
			string Operator_Name;
	end;
	
	export Base  := record
			string5 	Dart_Id;
			string7 	Controller_Id;
			string7 	Controller_Id_Cleaned;						
			string7 	Operator_Id;
			string7 	Operator_Id_Cleaned;			
			string8 	Controller_Start_Date;
			string80 	Controller_Name;
			string8 	Controller_End_Date;
			string80 	Operator_Name;
	end;
		
end;