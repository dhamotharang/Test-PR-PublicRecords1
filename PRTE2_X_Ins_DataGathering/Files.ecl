EXPORT Files := MODULE

		EXPORT 	BASE_PREFIX_NAME			:= '~prct::alpharetta::gathering::base::';
		EXPORT	VIN_SUFFIX						:= 'VIN_Data';
		EXPORT	VIN_SUFFIX5yr					:= 'VIN_Data_5yr';

		EXPORT VIN_Data_Name					:= BASE_PREFIX_NAME+VIN_SUFFIX;
		EXPORT VIN_Data_Name5yr				:= BASE_PREFIX_NAME+VIN_SUFFIX5yr;
		EXPORT VIN_Data_DS						:= DATASET(VIN_Data_Name,PRTE2_X_Ins_DataGathering.Layouts.UsableVINLayout,THOR);
		EXPORT VIN_Data_5yr_DS				:= DATASET(VIN_Data_Name5yr,PRTE2_X_Ins_DataGathering.Layouts.UsableVINLayout,THOR);
END;