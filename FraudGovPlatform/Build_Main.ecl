IMPORT FraudShared, tools;
EXPORT Build_Main(
	 string	pversion
) :=
module

	// Modules
	export Run_Main := FraudGovPlatform.MapToCommon(pversion).Build_Main_Base.All;
	export Run_Anonymize := Build_Base_Anonymized(pversion).All;
	export Run_Demo := Append_DemoData(pversion);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			  Run_Main
			, Run_Anonymize
			, Run_Demo)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Main atribute')
	 );
		
end;

 
