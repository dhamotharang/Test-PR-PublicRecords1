EXPORT Files := MODULE

		EXPORT 	BASE_PREFIX_NAME  := '~prct::alpharetta::gathering::base::';
		EXPORT	VIN_SUFFIX        := 'VIN_Data';
		EXPORT	VIN_SUFFIX5yr     := 'VIN_Data_5yr';
   	EXPORT	VIN_SUFFIX_Tmp    := 'VIN_Data_Tmp';   // Misc research
   	EXPORT	VIN_SUFFIX_Enh    := 'VIN_Data_Enhance';   // Misc research to enhance our main VIN data
		EXPORT   VIN_Tmp_Name      := BASE_PREFIX_NAME+VIN_SUFFIX_Tmp;
		EXPORT   VIN_Enh_Name      := BASE_PREFIX_NAME+VIN_SUFFIX_Enh;

		EXPORT VIN_Data_Name       := BASE_PREFIX_NAME+VIN_SUFFIX;
		EXPORT VIN_Data_Name5yr    := BASE_PREFIX_NAME+VIN_SUFFIX5yr;
		EXPORT VIN_Data_DS         := DATASET(VIN_Data_Name,PRTE2_X_Ins_DataGathering.Layouts.UsableVINLayout,THOR);
		EXPORT VIN_Data_5yr_DS     := DATASET(VIN_Data_Name5yr,PRTE2_X_Ins_DataGathering.Layouts.UsableVINLayout,THOR);
END;