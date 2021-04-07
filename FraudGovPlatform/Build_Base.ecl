IMPORT tools;
EXPORT Build_Base(
	 string	pversion
) :=
module

	export Run_Main := FraudGovPlatform.Build_Base_Main(pversion).All:independent;
	export Run_DataCoverage := FraudGovPlatform.Build_CoverageDates_Base(pversion).All:independent;
	export Run_AgencyActivity := FraudGovPlatform.Build_AgencyActivityDate_Base(pversion).All:independent;
	export Run_AddressCache := FraudGovPlatform.Build_Base_AddressCache(pversion).All:independent;
	export Run_DisposableEmailDomains := FraudGovPlatform.Build_Base_DisposableEmailDomains(pversion).All:independent;
	export Run_Anonymize := FraudGovPlatform.Build_Base_Anonymized(pversion).All:independent;
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			Run_Main,
			Run_DataCoverage,
			Run_AgencyActivity,
			Run_AddressCache,
			Run_DisposableEmailDomains,
			Run_Anonymize
				)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 
