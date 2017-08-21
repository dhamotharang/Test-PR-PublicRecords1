Import PropertyScrubs,LN_PropertyV2; 

EXPORT ProcPropertyScrubs(dataset(recordof(LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs)	) latest_Assesor,
                          dataset(recordof(LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs)	)           latest_Deeds,  string versionDate) := function 

	AssessorStats        := PropertyScrubs.fValidateAssesment.GetRawCode(latest_Assesor); 
 	DeedsStats           := PropertyScrubs.fValidateDeeds.GetRawCode(latest_Deeds); 

										 
	return sequential(output(AssessorStats, named('Scrub_Result_Tax'),all),output(DeedsStats, named('Scrub_Result_Deed'),all)); 
	
	end; 
	