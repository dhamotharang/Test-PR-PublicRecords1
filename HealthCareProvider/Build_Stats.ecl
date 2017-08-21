IMPORT HealthCareProviderHeader_Reports;
EXPORT Build_Stats (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Header_DS = HealthCareProvider.Files.Person_Salt_Input_DS) := FUNCTION
	
		#WORKUNIT ('NAME','Health Care Provider - Reports');

		Population_Stats					  := HealthCareProviderHeader_Reports.HeaderPopulationStats (Header_DS);
		
		Population_Stats_By_State 	:= HealthCareProviderHeader_Reports.HeaderPopulationStatsByState (Header_DS);
		
		Distribution_Stats					:=	HealthCareProviderHeader_Reports.HeaderFieldDistributionStats (Header_DS);
		
		RETURN SEQUENTIAL (Population_Stats, Population_Stats_By_State, Distribution_Stats);
END;