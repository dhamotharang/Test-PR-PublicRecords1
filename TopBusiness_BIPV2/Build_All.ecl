import BIPV2;

EXPORT Build_All(

	 string															            pversion   
	,dataset(Layouts.rec_industry_combined_layout	) pIndustryIn	= BIPV2.Industry_sources
	,dataset(Layouts.rec_license_combined_layout	)	pLicenseIn	= BIPV2.License_sources
  ,boolean                                        pPromote2QA = true

) :=

sequential(

   Build_Industry_All (pversion ,pIndustryIn  ,pPromote2QA)
  ,Build_License_All  (pversion ,pLicenseIn   ,pPromote2QA)

);