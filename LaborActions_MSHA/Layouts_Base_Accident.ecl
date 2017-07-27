export Layouts_Base_Accident := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			LaborActions_MSHA.Layouts_Accident.Input;
	end;

	export Temp := record
			LaborActions_MSHA.Layouts_Accident.Base;
	end;

	export Base := record
			unsigned6 Date_FirstSeen;
			unsigned6 Date_LastSeen;
			Temp;
	end;

	export Roll_Up := record
			Base;					
			string50 			Rollup_Sub_Unit_Description;									
			string40 			Rollup_Degree_of_Injury;						
			string50 			Rollup_Accident_Classification_Description;						
			string50 			Rollup_Occupation_Code_Description;					
			string40    	Rollup_Miner_Activity;					
			string1000  	Rollup_Accident_Narrative;
	end;

end;