export Layouts_Contractor := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;		
			string Mine_Id;					
			string Contractor_Id;				
			string Contractor_Name;						
			string Contractor_Start_Date;
			string Contractor_End_Date;
	end;

	export Base := record
			string5 	Dart_Id;
			string7 	Mine_Id;
			string7 	Mine_Id_Cleaned;
			string7 	Contractor_Id;
			string7 	Contractor_Id_Cleaned;
			string80 	Contractor_Name;						
			string8 	Contractor_Start_Date;
			string8 	Contractor_End_Date;
	end;
	
end;