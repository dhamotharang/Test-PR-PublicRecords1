IMPORT FraudShared, tools;
EXPORT Build_Base(

	 string	pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
) :=
module

	export Test_Build := Mac_TestBuild(pversion):independent;
	export Test_RecordID := Mac_TestRecordID(pversion):independent;
	export Test_RinID := Mac_TestRinID(pversion):independent;
	
	// Modules
	export Run_IdentityData := Build_Base_IdentityData(pversion,MBS_Sprayed).All;
	export Run_KnownFraud := Build_Base_KnownFraud(pversion,MBS_Sprayed).All;
	export Run_Deltabase := Build_Base_Deltabase(pversion,MBS_Sprayed).All;
	export Run_AddressCache := Build_Base_AddressCache(pversion).All;
	export Run_Main := MapToCommon(pversion).Build_Main.All;
	export Run_Anonymize := Build_Base_Anonymized(pversion).All;
	export Run_Demo := Append_DemoData(pversion);
	export Promote_Base := Promote(pversion).promote_base;
	export promote_sprayed_files := promote(pversion).promote_sprayed_files;
	export postNewStatus := FraudgovInfo(pversion,'Base_Completed').postNewStatus;
	export notify_Base_Completed := notify('Base_Completed','*');
	export Run_Rollback := Rollback('',Test_Build,Test_RecordID,Test_RinID).All;
	
	export Publish_Base 
	:= if( 
		Test_Build = 'Passed' and  
		Test_RecordID = 'Passed' and 
		Test_RinID = 'Passed', 
			sequential(
				Promote_Base,
				promote_sprayed_files,
				postNewStatus,
				notify_Base_Completed),
			Run_Rollback);
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			  Run_IdentityData
			, Run_KnownFraud
			, Run_Deltabase
			, Run_AddressCache
			, Run_Main
			, Run_Anonymize
			, Run_Demo
			, Publish_Base)
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 
