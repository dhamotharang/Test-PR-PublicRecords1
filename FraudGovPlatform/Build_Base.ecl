﻿import tools,FraudShared;

export Build_Base(

	 string	pversion
	,boolean	PSkipIdentityDataBase	= false 
	,boolean	PSkipKnownFraudBase	= false
	,boolean	PSkipAddressCacheBase	= false
	,boolean	PSkipMainBase = false
	,boolean	PSkipKelBase	 = false
	,dataset(FraudShared.Layouts.Base.Main)	pBaseMainFile	=	FraudShared.Files().Base.Main.QA
	
  ,dataset(Layouts.Base.IdentityData)	pBaseIdentityDataFile	=	Files().Base.IdentityData.QA
	,dataset(Layouts.Input.IdentityData)	pUpdateIdentityDataFile	=	Files().Input.IdentityData.Sprayed
	,boolean	pUpdateIdentityDataFlag	= _Flags.Update.IdentityData

	,dataset(Layouts.Base.KnownFraud)	pBaseKnownFraudFile	=	Files().Base.KnownFraud.QA
	,dataset(Layouts.Input.KnownFraud)	pUpdateKnownFraudFile	=	Files().Input.KnownFraud.Sprayed
	,boolean	pUpdateKnownFraudFlag	= _Flags.Update.KnownFraud
	

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
			 )			 
			 , if(PSkipKelBase , output('KnownFraud base skipped'),Build_Base_Kel(pversion).All)		 					 
			 , if(PSkipAddressCacheBase , output('AddressCache base skipped'),Build_Base_AddressCache(pversion).All)
			 , if(PSkipMainBase, output('Main base skipped'), MapToCommon(pversion).Build_Base_Main.All)
			 , FraudGovPlatform.Promote().buildfiles.Built2QA			 
		 )
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_Base atribute')
	 );
		
end;

 