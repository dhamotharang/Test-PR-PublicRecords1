EXPORT files :=
	MODULE
		EXPORT File_in 		:= DATASET('~thor_data400::in::alloy', layouts.layout_in, flat);
		EXPORT File_base	:= DATASET(thor_cluster + 'base::AlloyMedia_student_list', layouts.layout_base, THOR);
	END;