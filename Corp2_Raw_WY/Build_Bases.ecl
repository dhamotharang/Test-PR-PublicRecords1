IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,
	DATASET(Corp2_Raw_WY.Layouts.FilingLayoutIn)			pInFiling   		= Corp2_Raw_WY.Files(pfiledate,pUseProd).Input.Filing.Sprayed,
	DATASET(Corp2_Raw_WY.Layouts.FilingLayoutBase)		pBaseFiling 	 	= IF(Corp2_Raw_WY._Flags.Base.Filing, Corp2_Raw_WY.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, DATASET([], Corp2_Raw_WY.Layouts.FilingLayoutBase)),
	DATASET(Corp2_Raw_WY.Layouts.FilingARLayoutIn)		pInFilingAR   	= Corp2_Raw_WY.Files(pfiledate,pUseProd).Input.FilingAR.Sprayed,
	DATASET(Corp2_Raw_WY.Layouts.FilingARLayoutBase)	pBaseFilingAR 	= IF(Corp2_Raw_WY._Flags.Base.FilingAR, Corp2_Raw_WY.Files(,pUseOtherEnvironment := FALSE).Base.FilingAR.qa, DATASET([], Corp2_Raw_WY.Layouts.FilingARLayoutBase)),
	DATASET(Corp2_Raw_WY.Layouts.PartyLayoutIn)				pInParty   	 		= Corp2_Raw_WY.Files(pfiledate,pUseProd).Input.Party.Sprayed,
	DATASET(Corp2_Raw_WY.Layouts.PartyLayoutBase)			pBaseParty 	 		= IF(Corp2_Raw_WY._Flags.Base.Party, Corp2_Raw_WY.Files(,pUseOtherEnvironment := FALSE).Base.Party.qa, DATASET([], Corp2_Raw_WY.Layouts.PartyLayoutBase))
) := MODULE

	EXPORT full_build := SEQUENTIAL(	Corp2_Raw_WY.Build_Bases_Filing(pfiledate,pversion,puseprod,pInFiling,pBaseFiling).ALL,
																		Corp2_Raw_WY.Build_Bases_Filing_Annual_Report(pfiledate,pversion,puseprod,pInFilingAR,pBaseFilingAR).ALL,
																		Corp2_Raw_WY.Build_Bases_Party(pfiledate,pversion,puseprod,pInParty,pBaseParty).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WY.Build_Bases attribute')
									 );

END;
