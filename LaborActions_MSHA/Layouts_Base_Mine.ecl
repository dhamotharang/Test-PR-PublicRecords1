export Layouts_Base_Mine := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;
			string Mine_Id;
			string Controller_Id;
			string Operator_Id;
			string Mine_Name;
			string Controller_Name;
			string Operator_Name;
			LaborActions_MSHA.Layouts_Mine.Input -[Dart_Id,Mine_Id,Controller_Id,Operator_Id,Mine_Name,Controller_Name,Operator_Name];
			LaborActions_MSHA.Layouts_Controller_Hist.Input -[Dart_Id,Controller_Id,Operator_Id,Controller_Name,Operator_Name];	
			LaborActions_MSHA.Layouts_Operator_Hist.Input -[Dart_Id,Mine_Id,Operator_Id,Operator_Name,Mine_name];
	end;

	export Temp := record
			string5 	Dart_Id;
			string7 	Mine_Id;
			string7 	Mine_Id_Cleaned;
			string80 	Mine_Name;			
			string7 	Controller_Id;
			string7 	Controller_Id_Cleaned;			
			string80 	Controller_Name;
			string80  Controller_Name_Cleaned;			
			string80 	Controller_Name_Business;
			string1   Controller_Name_Name_Flag;
			string20  Controller_Name_CLN_FName;
			string20  Controller_Name_CLN_MName;
			string20  Controller_Name_CLN_LName;
			string5   Controller_Name_CLN_Suffix;
			string7 	Operator_Id;
			string7 	Operator_Id_Cleaned;					
			string80	Operator_Name;
			string80	Operator_Name_Cleaned;
			string80	Operator_Name_Business;			
			string1   Operator_Name_Name_Flag;
			string20  Operator_Name_CLN_FName;
			string20  Operator_Name_CLN_MName;
			string20  Operator_Name_CLN_LName;
			string5   Operator_Name_CLN_Suffix;
			LaborActions_MSHA.Layouts_Mine.Base -[Dart_Id
																						,Mine_Id
																						,Mine_Id_Cleaned
																						,Mine_Name
																						,Controller_Id
																						,Controller_Id_Cleaned			
																						,Controller_Name
																						,Controller_Name_Cleaned
																						,Controller_Name_Business
																						,Controller_Name_Name_Flag
																						,Controller_Name_CLN_FName
																						,Controller_Name_CLN_MName
																						,Controller_Name_CLN_LName
																						,Controller_Name_CLN_Suffix
																						,Operator_Id
																						,Operator_Id_Cleaned
																						,Operator_Name
																						,Operator_Name_Cleaned
																						,Operator_Name_Business
																						,Operator_Name_Name_Flag
																						,Operator_Name_CLN_FName
																						,Operator_Name_CLN_MName
																						,Operator_Name_CLN_LName
																						,Operator_Name_CLN_Suffix];
			LaborActions_MSHA.Layouts_Controller_Hist.Base -[Dart_Id,Controller_Id,Controller_Id_Cleaned,Operator_Id,Operator_Id_Cleaned,Controller_Name,Operator_Name];	
			LaborActions_MSHA.Layouts_Operator_Hist.Base -[Dart_Id,Mine_Id,Mine_Id_Cleaned,Operator_Id,Operator_Id_Cleaned,Operator_Name,Mine_name];
	end;

	export Base := record
			unsigned6 Date_FirstSeen;
			unsigned6 Date_LastSeen;
			Temp;
	end;

	export Roll_Up := record
			Base;					
			string80 			Rollup_Mine_Name;									
			string80 			Rollup_Controller_Name;						
			string80 			Rollup_Operator_Name;						
	end;
	
end;