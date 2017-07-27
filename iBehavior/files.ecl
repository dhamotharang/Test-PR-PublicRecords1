EXPORT files :=
	MODULE
		EXPORT File_in 				:= DATASET(thor_cluster + 'in::iBehavior_using', layouts.layout_in, flat);
		EXPORT File_consumer	:= DATASET(thor_cluster + 'base::iBehavior_consumer', layouts.layout_consumer, THOR);
		EXPORT File_behavior	:= DATASET(thor_cluster + 'base::iBehavior_behavior', layouts.layout_behavior, THOR);
		EXPORT File_base			:= DATASET(thor_cluster + 'base::iBehavior', layouts.layout_base, THOR);
	END;