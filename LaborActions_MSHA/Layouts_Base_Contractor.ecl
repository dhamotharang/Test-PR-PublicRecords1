export Layouts_Base_Contractor := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;
			string Mine_Id;
			string Contractor_Id;
			string Commodity_Type;
			string Sub_Unit;
			string Sub_Unit_Description;
			LaborActions_MSHA.Layouts_Contractor.Input -[Dart_Id,Mine_Id,Contractor_Id];
			LaborActions_MSHA.Layouts_Contractor_CY_Employment.Input -[Dart_Id,Contractor_Id,Sub_Unit,Commodity_Type];
			LaborActions_MSHA.Layouts_Contractor_QT_Employment.Input -[Dart_Id,Contractor_Id,Sub_Unit,Sub_Unit_Description,Commodity_Type];
	end;

	export Temp := record
			string5 	Dart_Id;
			string7 	Mine_Id;
			string7 	Mine_Id_Cleaned;
			string7 	Contractor_Id;
			string7 	Contractor_Id_Cleaned;			
			string1		Commodity_Type;
			string2 	Sub_Unit;
			string2 	Sub_Unit_Cleaned;
			string50 	Sub_Unit_Description;
			LaborActions_MSHA.Layouts_Contractor.Base -[Dart_Id,Mine_Id, Mine_Id_Cleaned,Contractor_Id,Contractor_Id_Cleaned];
			LaborActions_MSHA.Layouts_Contractor_CY_Employment.Base -[Dart_Id,Contractor_Id,Contractor_Id_Cleaned,Sub_Unit,Sub_Unit_Cleaned,Commodity_Type];
			LaborActions_MSHA.Layouts_Contractor_QT_Employment.Base -[Dart_Id,Contractor_Id,Contractor_Id_Cleaned,Sub_Unit,Sub_Unit_Cleaned,Sub_Unit_Description,Commodity_Type];
	end;


	export Base := record
			unsigned6 Date_FirstSeen;
			unsigned6 Date_LastSeen;
			Temp;
	end;

end;