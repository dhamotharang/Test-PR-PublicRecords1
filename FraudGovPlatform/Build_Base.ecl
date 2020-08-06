IMPORT FraudShared, tools;
EXPORT Build_Base(
	 string	pversion
) :=
module

	export Run_Main := $.Build_Base_Main(pversion).All:independent;
	export Run_DataCoverage := $.Build_CoverageDates_Base(pversion).All:independent;
	export Run_AgencyActivity := $.Build_AgencyActivityDate_Base(pversion).All:independent;
	export Run_AddressCache := $.Build_Base_AddressCache(pversion).All:independent;
	export Run_Anonymize := $.Build_Base_Anonymized(pversion).All:independent;
	export Run_Demo := $.Append_DemoData(pversion):independent;
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			  Run_Main			
			, Run_DataCoverage
			, Run_AgencyActivity
			, Run_AddressCache
			, Run_Anonymize			
			, Run_Demo
			)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 
