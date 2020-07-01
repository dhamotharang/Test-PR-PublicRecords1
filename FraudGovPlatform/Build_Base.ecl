IMPORT FraudShared, tools;
EXPORT Build_Base(
	 string	pversion
) :=
module

	export Run_Main := FraudGovPlatform.MapToCommon(pversion).Build_Main_Base.All:independent;
	export Run_Anonymize := FraudGovPlatform.Build_Base_Anonymized(pversion).All:independent;
	export Run_DataCoverage := FraudGovPlatform.Build_CoverageDates_Base(pversion).All:independent;
	export Run_AgencyActivity := FraudGovPlatform.Build_AgencyActivityDate_Base(pversion).All:independent;
	export Run_AddressCache := FraudGovPlatform.Build_Base_AddressCache(pversion).All:independent;
	export Run_Demo := FraudGovPlatform.Append_DemoData(pversion):independent;
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			  Run_Main			
			, Run_Anonymize
			, Run_DataCoverage
			, Run_AgencyActivity
			, Run_AddressCache
			, Run_Demo
			)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 
