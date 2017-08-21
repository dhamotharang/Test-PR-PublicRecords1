export Layouts_Base_Events:= module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;
			string Mine_Id;
			string Event_No;
			string Contractor_Id;
			LaborActions_MSHA.Layouts_Inspection.Input -[Dart_Id,Mine_Id,Event_No]; 
			LaborActions_MSHA.Layouts_Violation.Input -[Dart_Id,Event_No,Contractor_Id];
	end;

	export Temp := record
			string5 	Dart_Id;
			string7 	Mine_Id;
			string7 	Mine_Id_Cleaned;
			string7 	Event_No;	
			string7 	Event_No_Cleaned;
			string7 	Contractor_Id;
			string7 	Contractor_Id_Cleaned;
			LaborActions_MSHA.Layouts_Inspection.Base -[Dart_Id,Mine_Id,Mine_Id_Cleaned,Event_No,Event_No_Cleaned]; 
			LaborActions_MSHA.Layouts_Violation.Base -[Dart_Id,Event_No,Event_No_Cleaned,Contractor_Id,Contractor_Id_Cleaned];
	end;

	export Base := record
			unsigned6 Date_FirstSeen;
			unsigned6 Date_LastSeen;
			Temp;
	end;

	export Temp_Key := record
			string5 	Dart_Id;
			string7 	Mine_Id;
			string7 	Mine_Id_Cleaned;
			string7 	Event_No;	
			string7 	Event_No_Cleaned;
			string7 	Contractor_Id;
			string7 	Contractor_Id_Cleaned;
			LaborActions_MSHA.Layouts_Inspection.Base -[Dart_Id,Mine_Id,Mine_Id_Cleaned,Event_No,Event_No_Cleaned]; 
			LaborActions_MSHA.Layouts_Violation.Base_Old_End_Date_20121009 -[Dart_Id,Event_No,Event_No_Cleaned,Contractor_Id,Contractor_Id_Cleaned];
	end;
	
	export MineId_Events_Key := record
			unsigned6 Date_FirstSeen;
			unsigned6 Date_LastSeen;	
			Temp_Key;
	end;

	export ContractorId_Events_Key := record
			unsigned6 Date_FirstSeen;
			unsigned6 Date_LastSeen;	
			Temp_Key;	
	end;	
end;