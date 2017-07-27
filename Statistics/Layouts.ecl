export Layouts :=
module

	export Field_count_layout := 
	record, maxlength(100000)
		string		Field_Value									;
		unsigned8 cnt					:= count(group)	;
	end;

	export Calculated_Stat_layout := 
	record, maxlength(100000)
		string Stat_Description;
		string Stat_Value;
	end;

	export Description_Stat_layout := 
	record, maxlength(100000)
		string Stat_Description;
		string Field_Label;
		dataset(Field_count_layout) Samples;
	end;

	export Description_Stat_layout2 := 
	record, maxlength(100000)
		dataset(Description_Stat_layout) Samples;
	end;

	export standard_stat_out :=
	record, maxlength(100000)
		string														Build_Name										;	// name of build/dataset
		string														Version												;	// Build version
		string														Build_Subset									;	// Subset of build, to differentiate multiple files in build
		string														Build_View										;	// additional fields to differentiate stats
		string														Build_Type										;	// additional fields to differentiate stats
		dataset(Calculated_Stat_layout	)	Discrete_Values								;
		dataset(Description_Stat_layout )	Samples					 							;
	end;

end;