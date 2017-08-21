IMPORT corp2, tools;

EXPORT Build_Bases(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,	
	DATASET(Corp2_Raw_VA.Layouts.TablesLayoutIn)					pInTables   	  = Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.Tables.logical,
	DATASET(Corp2_Raw_VA.Layouts.TablesLayoutBase)				pBaseTables 	  = IF(Corp2_Raw_VA._Flags.Base.Tables, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Tables.qa, DATASET([], Corp2_Raw_VA.Layouts.TablesLayoutBase)),
	DATASET(Corp2_Raw_VA.Layouts.CorpsLayoutIn)						pInCorps   		  = Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.Corps.logical,
	DATASET(Corp2_Raw_VA.Layouts.CorpsLayoutBase)					pBaseCorps 		  = IF(Corp2_Raw_VA._Flags.Base.Corps, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Corps.qa, DATASET([], Corp2_Raw_VA.Layouts.CorpsLayoutBase)),
	DATASET(Corp2_Raw_VA.Layouts.LPLayoutIn)							pInLP   			  = Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.LP.logical,
	DATASET(Corp2_Raw_VA.Layouts.LPLayoutBase)						pBaseLP 			  = IF(Corp2_Raw_VA._Flags.Base.LP, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.LP.qa, DATASET([], Corp2_Raw_VA.Layouts.LPLayoutBase)),
	DATASET(Corp2_Raw_VA.Layouts.AmendmentLayoutIn)				pInAmendment 	  = Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.Amendment.logical,
	DATASET(Corp2_Raw_VA.Layouts.AmendmentLayoutBase)			pBaseAmendment  = IF(Corp2_Raw_VA._Flags.Base.Amendment, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Amendment.qa, DATASET([], Corp2_Raw_VA.Layouts.AmendmentLayoutBase)),
	DATASET(Corp2_Raw_VA.Layouts.OfficersLayoutIn)				pInOfficer      = Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.Officer.logical,
	DATASET(Corp2_Raw_VA.Layouts.OfficersLayoutBase)			pBaseOfficer    = IF(Corp2_Raw_VA._Flags.Base.Officer, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, DATASET([], Corp2_Raw_VA.Layouts.OfficersLayoutBase)),
	DATASET(Corp2_Raw_VA.Layouts.NamesHistLayoutIn)				pInNamesHist    = Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.NamesHist.logical,
	DATASET(Corp2_Raw_VA.Layouts.NamesHistLayoutBase)   	pBaseNamesHist  = IF(Corp2_Raw_VA._Flags.Base.NamesHist, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.NamesHist.qa, DATASET([], Corp2_Raw_VA.Layouts.NamesHistLayoutBase)),
	DATASET(Corp2_Raw_VA.Layouts.MergersLayoutIn)					pInMerger    	  = Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.Merger.logical,
	DATASET(Corp2_Raw_VA.Layouts.MergersLayoutBase)				pBaseMerger     = IF(Corp2_Raw_VA._Flags.Base.Merger, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Merger.qa, DATASET([], Corp2_Raw_VA.Layouts.MergersLayoutBase)),
	DATASET(Corp2_Raw_VA.Layouts.ReservedLayoutIn)				pInResrvdName   = Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.ResrvdName.logical,
	DATASET(Corp2_Raw_VA.Layouts.ReservedLayoutBase)			pBaseResrvdName = IF(Corp2_Raw_VA._Flags.Base.ResrvdName, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.ResrvdName.qa, DATASET([], Corp2_Raw_VA.Layouts.ReservedLayoutBase)),
	DATASET(Corp2_Raw_VA.Layouts.LLCLayoutIn)							pInLLC      		= Corp2_Raw_VA.Files(pfiledate,pUseProd).Input.LLC.logical,
	DATASET(Corp2_Raw_VA.Layouts.LLCLayoutBase)						pBaseLLC  		  = IF(Corp2_Raw_VA._Flags.Base.LLC, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.LLC.qa, DATASET([], Corp2_Raw_VA.Layouts.LLCLayoutBase))	
	
) := MODULE

	EXPORT full_build := SEQUENTIAL(	Corp2_Raw_VA.Build_Bases_Amendment(pfiledate,pversion,pUseProd,pInAmendment,pBaseAmendment).ALL,
																		Corp2_Raw_VA.Build_Bases_Corps(pfiledate,pversion,pUseProd,pInCorps,pBaseCorps).ALL,
																		Corp2_Raw_VA.Build_Bases_LLC(pfiledate,pversion,pUseProd,pInLLC,pBaseLLC).ALL,
																		Corp2_Raw_VA.Build_Bases_Officer(pfiledate,pversion,pUseProd,pInOfficer,pBaseOfficer).ALL,
																		Corp2_Raw_VA.Build_Bases_LP(pfiledate,pversion,pUseProd,pInLP,pBaseLP).ALL,
																		Corp2_Raw_VA.Build_Bases_Merger(pfiledate,pversion,pUseProd,pInMerger,pBaseMerger).ALL,
																		Corp2_Raw_VA.Build_Bases_NamesHist(pfiledate,pversion,pUseProd,pInNamesHist,pBaseNamesHist).ALL,
																		Corp2_Raw_VA.Build_Bases_ResrvdName(pfiledate,pversion,pUseProd,pInResrvdName,pBaseResrvdName).ALL,
																		Corp2_Raw_VA.Build_Bases_Tables(pfiledate,pversion,pUseProd,pInTables,pBaseTables).ALL,
																		Promote(pversion).buildfiles.New2Built,
																	  Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version  parameter passed, skipping Corp2_Raw_VA.Build_Bases attribute')
									 );

END;


