IMPORT FraudShared, tools;
EXPORT Build_Base(
	 string	pversion
) :=
module

	export Run_Main := FraudGovPlatform.MapToCommon(pversion).Build_Main_Base.All:independent;
	export Run_Anonymize := Build_Base_Anonymized(pversion).All:independent;
	export Run_Demo := Append_DemoData(pversion):independent;
	export Run_AddressCache := Build_Base_AddressCache(pversion).All:independent;
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			  Run_Main			
			, Run_Anonymize
			, Run_Demo
			, Run_AddressCache)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 
