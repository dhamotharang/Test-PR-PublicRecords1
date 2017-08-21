export File_Companies_AID_Prep(
	 string														pversion							= 'qa'		//default to qa version of file(superfile)
	,boolean													pUseOtherEnvironment	= false		//don't use other environment
	,dataset(layouts.base.companies)	pCompaniesBase 				= files(pversion,pUseOtherEnvironment).base.companies.new
) := 
	Append_AID.fPreProcess(pCompaniesBase);