﻿IMPORT FraudShared, tools;
EXPORT Build_Base(

	 string	pversion
	,boolean	PSkipIdentityDataBase	= false 
	,boolean	PSkipKnownFraudBase	= false
	,boolean	PSkipDeltabaseBase = false	
	,boolean	PSkipAddressCacheBase	= false
	,boolean	PSkipMainBase = false
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile	=	FraudShared.Files().Base.Main.QA
	
  ,dataset(Layouts.Base.IdentityData)	pBaseIdentityDataFile	=	Files().Base.IdentityData.QA
	,dataset(Layouts.Input.IdentityData)	pUpdateIdentityDataFile	=	Files().Input.IdentityData.Sprayed
	,boolean	pUpdateIdentityDataFlag	= _Flags.Update.IdentityData

	,dataset(Layouts.Base.KnownFraud)	pBaseKnownFraudFile	=	Files().Base.KnownFraud.QA
	,dataset(Layouts.Input.KnownFraud)	pUpdateKnownFraudFile	=	Files().Input.KnownFraud.Sprayed
	,boolean	pUpdateKnownFraudFlag	= _Flags.Update.KnownFraud
	
	,dataset(Layouts.Base.Deltabase)	pBaseDeltabaseFile	=	Files().Base.Deltabase.QA 
	,dataset(Layouts.Input.Deltabase)	pUpdateDeltabaseFile	=	Files().Input.Deltabase.Sprayed
	,boolean	pUpdateDeltabaseFlag	= _Flags.Update.Deltabase 
) :=
module

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			 parallel(
				 if(PSkipIdentityDataBase , output('IdentityData base skipped')
					,Build_Base_IdentityData(
					 pversion
					,pBaseIdentityDataFile
					,pUpdateIdentityDataFile
					,pUpdateIdentityDataflag
					).All)
				,if(PSkipKnownFraudBase , output('KnownFraud base skipped')
					,Build_Base_KnownFraud(
					 pversion
					,pBaseKnownFraudFile
					,pUpdateKnownFraudFile
					,pUpdateKnownFraudflag
					).All)		 
				,if(PSkipDeltabaseBase , output('Deltabase base skipped')
					,Build_Base_Deltabase(
					 pversion
					,pBaseDeltabaseFile
					,pUpdateDeltabaseFile
					,pUpdateDeltabaseflag
					).All)
			 )
			 , if(PSkipAddressCacheBase , output('AddressCache base skipped'),Build_Base_AddressCache(pversion).All)
			 , Promote(pversion).buildfiles.New2Built
			 , if(PSkipMainBase, output('Main base skipped'), MapToCommon(pversion).Build_Base_Main.All)
			 , Build_Base_Anonymized(pversion).All
			 , Append_DemoData(pversion)
		) 
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 
