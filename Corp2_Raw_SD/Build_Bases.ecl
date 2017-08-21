IMPORT tools, corp2;

EXPORT Build_Bases( STRING																									pfiledate,
										STRING																									pversion,
										BOOLEAN 																								puseprod,
										DATASET(Corp2_Raw_SD.Layouts.vendor_mainLayout)					pIn_vendor_main       = Corp2_raw_SD.Files(pfiledate,puseprod).Input.ds_vendor_rawMain,
										DATASET(Corp2_Raw_SD.Layouts.vendor_mainLayoutBase)			pBase_vendor_main 	  = IF(_Flags.Base.vendor_main, Corp2_Raw_SD.Files(,pUseOtherEnvironment := FALSE).Base.vendor_main.qa, DATASET([], Corp2_Raw_SD.Layouts.vendor_mainLayoutBase)),
										DATASET(Corp2_Raw_SD.Layouts.vendor_amendLayout)				pIn_vendor_amend      = Corp2_raw_SD.Files(pfiledate,puseprod).Input.vendor_amend.logical,
										DATASET(Corp2_Raw_SD.Layouts.vendor_amendLayoutBase)	  pBase_vendor_amend    = IF(_Flags.Base.vendor_amendments, Corp2_Raw_SD.Files(,pUseOtherEnvironment := FALSE).Base.vendor_amend.qa, DATASET([], Corp2_Raw_SD.Layouts.vendor_amendLayoutBase)),
										DATASET(Corp2_Raw_SD.Layouts.vendor_arLayout)				    pIn_vendor_ar         = Corp2_raw_SD.Files(pfiledate,puseprod).Input.vendor_ar.logical,
										DATASET(Corp2_Raw_SD.Layouts.vendor_arLayoutBase)	      pBase_vendor_ar       = IF(_Flags.Base.vendor_ar, Corp2_Raw_SD.Files(,pUseOtherEnvironment := FALSE).Base.vendor_ar.qa, DATASET([], Corp2_Raw_SD.Layouts.vendor_arLayoutBase))
									 ) := MODULE
									 
		
	EXPORT full_build := SEQUENTIAL(Corp2_Raw_SD.Build_Bases_Main(pfiledate,pversion,puseprod,pIn_vendor_main,pBase_vendor_main).ALL,
                                  Corp2_Raw_SD.Build_Bases_Amendments(pfiledate,pversion,puseprod,pIn_vendor_amend,pBase_vendor_amend).ALL,
                                  Corp2_Raw_SD.Build_Bases_AR(pfiledate,pversion,puseprod,pIn_vendor_ar,pBase_vendor_ar).ALL,
																	Promote(pversion).buildfiles.New2Built,
																	Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_SD.Build_Bases attribute')
									 );

END;