IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																										pfiledate,
	STRING																										pversion,
	Boolean                                                   pUseOtherEnvironment,
	DATASET(Corp2_Raw_IN.Layouts.CorpAgentsLayoutIn)					pInCorpAgents   		      = Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.CorpAgents.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpAgentsLayoutBase)				pBaseCorpAgents 		      = IF(Corp2_Raw_IN._Flags.Base.CorpAgents, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.CorpAgents.qa, DATASET([], Corp2_Raw_IN.Layouts.CorpAgentsLayoutBase)),
	DATASET(Corp2_Raw_IN.Layouts.CorpCorporationsLayoutIn)		pInCorpCorporations   		= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment ).Input.CorpCorporations.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase)	pBaseCorpCorporations 		= IF(Corp2_Raw_IN._Flags.Base.CorpCorporations, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.CorpCorporations.qa, DATASET([], Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase)),
	DATASET(Corp2_Raw_IN.Layouts.CorpFilingsLayoutIn)					pInCorpFilings   	   		  = Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.CorpFilings.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpFilingsLayoutBase)				pBaseCorpFilings 	   			= IF(Corp2_Raw_IN._Flags.Base.CorpFilings, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.CorpFilings.qa, DATASET([], Corp2_Raw_IN.Layouts.CorpFilingsLayoutBase)),
	DATASET(Corp2_Raw_IN.Layouts.CorpOfficersLayoutIn)				pInOfficer   	   					= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.CorpOfficers.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpOfficersLayoutBase)			pBaseOfficer 	 	 					= IF(Corp2_Raw_IN._Flags.Base.CorpOfficers, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.CorpOfficers.qa, DATASET([], Corp2_Raw_IN.Layouts.CorpOfficersLayoutBase)),
	DATASET(Corp2_Raw_IN.Layouts.CorpMergersLayoutIn)					pInCorpMergers  			 		= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.CorpMergers.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpMergersLayoutBase)				pBaseCorpMergers			 		= IF(Corp2_Raw_IN._Flags.Base.CorpMergers, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.CorpMergers.qa, DATASET([], Corp2_Raw_IN.Layouts.CorpMergersLayoutBase)),
	DATASET(Corp2_Raw_IN.Layouts.CorpNamesLayoutIn)						pInCorpNames   			 			= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.CorpNames.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpNamesLayoutBase)					pBaseCorpNames			 			= IF(Corp2_Raw_IN._Flags.Base.CorpReports, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.CorpNames.qa, DATASET([], Corp2_Raw_IN.Layouts.CorpNamesLayoutBase)),
	DATASET(Corp2_Raw_IN.Layouts.CorpReportsLayoutIn)					pInCorpReports   			 		= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.CorpReports.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpReportsLayoutBase)				pBaseCorpReports			 		= IF(Corp2_Raw_IN._Flags.Base.CorpReports, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.CorpReports.qa, DATASET([], Corp2_Raw_IN.Layouts.CorpReportsLayoutBase))
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_IN.Build_Bases_Agents(pfiledate,pversion,pUseOtherEnvironment,pInCorpAgents,pBaseCorpAgents).ALL,
																		Corp2_Raw_IN.Build_Bases_Corporations(pfiledate,pversion,pUseOtherEnvironment,pInCorpCorporations,pBaseCorpCorporations).ALL,
																		Corp2_Raw_IN.Build_Bases_Filings(pfiledate,pversion,pUseOtherEnvironment,pInCorpFilings,pBaseCorpFilings).ALL,
																		Corp2_Raw_IN.Build_Bases_Officers(pfiledate,pversion,pUseOtherEnvironment,pInOfficer,pBaseOfficer).ALL,
																		Corp2_Raw_IN.Build_Bases_Reports(pfiledate,pversion,pUseOtherEnvironment,pInCorpReports,pBaseCorpReports).ALL,
																		Corp2_Raw_IN.Build_Bases_Mergers(pfiledate,pversion,pUseOtherEnvironment,pInCorpMergers,pBaseCorpMergers).ALL,
																		Corp2_Raw_IN.Build_Bases_names(pfiledate,pversion,pUseOtherEnvironment,pInCorpNames,pBaseCorpNames).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																	 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version  parameter passed, skipping Corp2_Raw_IN.Build_Bases attribute')
									 );

END;
