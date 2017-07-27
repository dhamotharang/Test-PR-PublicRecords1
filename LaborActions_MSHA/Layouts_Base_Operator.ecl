export Layouts_Base_Operator := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;
			string Mine_Id;
			string Sub_Unit;
			LaborActions_MSHA.Layouts_Operator_CY_Employment.Input -[Dart_Id,Mine_Id,Sub_Unit];
			LaborActions_MSHA.Layouts_Operator_QT_Employment.Input -[Dart_Id,Mine_Id,Sub_Unit];
	end;

	export Temp := record
			string5 Dart_Id;
			string7 Mine_Id;
			string7 Mine_Id_Cleaned;
			string2 Sub_Unit;
			string2 Sub_Unit_Cleaned;			
			LaborActions_MSHA.Layouts_Operator_CY_Employment.Base -[Dart_Id,Mine_Id,Mine_Id_Cleaned,Sub_Unit,Sub_Unit_Cleaned];
			LaborActions_MSHA.Layouts_Operator_QT_Employment.Base -[Dart_Id,Mine_Id,Mine_Id_Cleaned,Sub_Unit,Sub_Unit_Cleaned];
	end;

	export Base := record
			unsigned6 Date_FirstSeen;
			unsigned6 Date_LastSeen;
			Temp;
	end;

	export Roll_Up := record
			Base;					
			string50 			Rollup_Sub_Unit_Description;									
	end;
	
end;