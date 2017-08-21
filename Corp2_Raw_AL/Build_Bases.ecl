IMPORT tools, ut, corp2_raw_al;

EXPORT Build_Bases(
	STRING	                                              pfiledate,
	STRING	                                              pversion,
  BOOLEAN                                             	pUseProd,
	DATASET(Corp2_Raw_AL.Layouts.IncorporatorLayoutIn)		pIncrIncPf 	 = Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crIncPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.IncorporatorLayoutBase)	pBasecrIncPf = IF(Corp2_Raw_AL._Flags.Base.crIncPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crIncPf.qa, DATASET([], Corp2_Raw_AL.Layouts.IncorporatorLayoutBase)),
	DATASET(Corp2_Raw_AL.Layouts.OffAddrLayoutIn)					pIncrOffPf   = Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crOffPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.OffAddrLayoutBase)				pBasecrOffPf = IF(Corp2_Raw_AL._Flags.Base.crOffPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crOffPf.qa, DATASET([], Corp2_Raw_AL.Layouts.OffAddrLayoutBase)),
	DATASET(Corp2_Raw_AL.Layouts.NameChangeLayoutIn)			pIncrNamPf   = Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crNamPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.NameChangeLayoutBase)		pBasecrNamPf = IF(Corp2_Raw_AL._Flags.Base.crNamPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crNamPf.qa, DATASET([], Corp2_Raw_AL.Layouts.NameChangeLayoutBase)),
	DATASET(Corp2_Raw_AL.Layouts.ServiceLayoutIn)					pIncrSerPf   = Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crSerPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.ServiceLayoutBase)				pBasecrSerPf = IF(Corp2_Raw_AL._Flags.Base.crSerPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crSerPf.qa, DATASET([], Corp2_Raw_AL.Layouts.ServiceLayoutBase)),
  DATASET(Corp2_Raw_AL.Layouts.BusinessNameLayoutIn)		pIncrBusPf   = Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crBusPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.BusinessNameLayoutBase)	pBasecrBusPf = IF(Corp2_Raw_AL._Flags.Base.crBusPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crBusPf.qa, DATASET([], Corp2_Raw_AL.Layouts.BusinessNameLayoutBase)),
	DATASET(Corp2_Raw_AL.Layouts.HistoryLayoutIn)					pIncrHstPf   = Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crHstPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.HistoryLayoutBase)				pBasecrHstPf = IF(Corp2_Raw_AL._Flags.Base.crHstPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crHstPf.qa, DATASET([], Corp2_Raw_AL.Layouts.HistoryLayoutBase)),
	DATASET(Corp2_Raw_AL.Layouts.AnnualReportLayoutIn)		pIncrAnlPf   = Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crAnlPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.AnnualReportLayoutBase)	pBasecrAnlPf = IF(Corp2_Raw_AL._Flags.Base.crAnlPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crAnlPf.qa, DATASET([], Corp2_Raw_AL.Layouts.AnnualReportLayoutBase)),
	DATASET(Corp2_Raw_AL.Layouts.CorpMasterLayoutIn)			pIncrMstPf   = Corp2_Raw_AL.Files(pfiledate,pUseProd).Input.crMstPf.logical,
	DATASET(Corp2_Raw_AL.Layouts.CorpMasterLayoutBase)		pBasecrMstPf = IF(Corp2_Raw_AL._Flags.Base.crMstPf, Corp2_Raw_AL.Files(,pUseOtherEnvironment := FALSE).Base.crMstPf.qa, DATASET([], Corp2_Raw_AL.Layouts.CorpMasterLayoutBase))
	
) := MODULE

	EXPORT full_build := SEQUENTIAL(	Corp2_Raw_AL.Build_Bases_crIncPf(pfiledate,pversion,pUseProd,pIncrIncPf,pBasecrIncPf).ALL,
																		Corp2_Raw_AL.Build_Bases_crOffPf(pfiledate,pversion,pUseProd,pIncrOffPf,pBasecrOffPf).ALL,
																		Corp2_Raw_AL.Build_Bases_crNamPf(pfiledate,pversion,pUseProd,pIncrNamPf,pBasecrNamPf).ALL,
																		Corp2_Raw_AL.Build_Bases_crSerPf(pfiledate,pversion,pUseProd,pIncrSerPf,pBasecrSerPf).ALL,
																		Corp2_Raw_AL.Build_Bases_crBusPf(pfiledate,pversion,pUseProd,pIncrBusPf,pBasecrBusPf).ALL,
																		Corp2_Raw_AL.Build_Bases_crHstPf(pfiledate,pversion,pUseProd,pIncrHstPf,pBasecrHstPf).ALL,
																		Corp2_Raw_AL.Build_Bases_crAnlPf(pfiledate,pversion,pUseProd,pIncrAnlPf,pBasecrAnlPf).ALL,	
																		Corp2_Raw_AL.Build_Bases_crMstPf(pfiledate,pversion,pUseProd,pIncrMstPf,pBasecrMstPf).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AL.Build_Bases attribute')
									 );

END;
