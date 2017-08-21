IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																												pfiledate,
	STRING																												pversion,
	BOOLEAN																												puseprod,	
	DATASET(Corp2_Raw_LA.Layouts.AgentsLayoutIn)									pInAgents   							= Corp2_Raw_LA.Files(pfiledate,puseprod).Input.Agents.Logical,
	DATASET(Corp2_Raw_LA.Layouts.AgentsLayoutBase)								pBaseAgents 	 						= IF(Corp2_Raw_LA._Flags(puseprod).Base.Agents, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.Agents.qa, DATASET([], Corp2_Raw_LA.Layouts.AgentsLayoutBase)),
	DATASET(Corp2_Raw_LA.Layouts.CorpsEntitiesLayoutIn)						pInCorpsEntities  				= Corp2_Raw_LA.Files(pfiledate,puseprod).Input.CorpsEntities.Logical,
	DATASET(Corp2_Raw_LA.Layouts.CorpsEntitiesLayoutBase)					pBaseCorpsEntities				= IF(Corp2_Raw_LA._Flags(puseprod).Base.CorpsEntities, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.CorpsEntities.qa, DATASET([], Corp2_Raw_LA.Layouts.CorpsEntitiesLayoutBase)),
	DATASET(Corp2_Raw_LA.Layouts.FilingsLayoutIn)									pInFilings   	 						= Corp2_Raw_LA.Files(pfiledate,puseprod).Input.Filings.Logical,
	DATASET(Corp2_Raw_LA.Layouts.FilingsLayoutBase)								pBaseFilings 	 						= IF(Corp2_Raw_LA._Flags(puseprod).Base.Filings, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.Filings.qa, DATASET([], Corp2_Raw_LA.Layouts.FilingsLayoutBase)),
	DATASET(Corp2_Raw_LA.Layouts.MergersLayoutIn)									pInMergers   							= Corp2_Raw_LA.Files(pfiledate,puseprod).Input.Mergers.Logical,
	DATASET(Corp2_Raw_LA.Layouts.MergersLayoutBase)								pBaseMergers 	 						= IF(Corp2_Raw_LA._Flags(puseprod).Base.Mergers, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.Mergers.qa, DATASET([], Corp2_Raw_LA.Layouts.MergersLayoutBase)),
	DATASET(Corp2_Raw_LA.Layouts.NameReservsLayoutIn)							pInNameReservs  					= Corp2_Raw_LA.Files(pfiledate,puseprod).Input.NameReservs.Logical,
	DATASET(Corp2_Raw_LA.Layouts.NameReservsLayoutBase)						pBaseNameReservs					= IF(Corp2_Raw_LA._Flags(puseprod).Base.NameReservs, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.NameReservs.qa, DATASET([], Corp2_Raw_LA.Layouts.NameReservsLayoutBase)),
	DATASET(Corp2_Raw_LA.Layouts.PreviousNamesLayoutIn)						pInPreviousNames   	 			= Corp2_Raw_LA.Files(pfiledate,puseprod).Input.PreviousNames.Logical,
	DATASET(Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase)					pBasePreviousNames 	 			= IF(Corp2_Raw_LA._Flags(puseprod).Base.PreviousNames, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.PreviousNames.qa, DATASET([], Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase)),
	DATASET(Corp2_Raw_LA.Layouts.TradeServicesLayoutIn)						pInTradeServices   	 			= Corp2_Raw_LA.Files(pfiledate,puseprod).Input.TradeServices.Logical,
	DATASET(Corp2_Raw_LA.Layouts.TradeServicesLayoutBase)					pBaseTradeServices 	 			= IF(Corp2_Raw_LA._Flags(puseprod).Base.TradeServices, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.TradeServices.qa, DATASET([], Corp2_Raw_LA.Layouts.TradeServicesLayoutBase))
		
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_LA.Build_Bases_Agents(pfiledate,pversion,puseprod,pInAgents,pBaseAgents).ALL,
																		Corp2_Raw_LA.Build_Bases_CorpsEntities(pfiledate,pversion,puseprod,pInCorpsEntities,pBaseCorpsEntities).ALL,
																		Corp2_Raw_LA.Build_Bases_Filings(pfiledate,pversion,puseprod,pInFilings,pBaseFilings).ALL,
																		Corp2_Raw_LA.Build_Bases_Mergers(pfiledate,pversion,puseprod,pInMergers,pBaseMergers).ALL,
																		Corp2_Raw_LA.Build_Bases_NameReservs(pfiledate,pversion,puseprod,pInNameReservs,pBaseNameReservs).ALL,
																		Corp2_Raw_LA.Build_Bases_PreviousNames(pfiledate,pversion,puseprod,pInPreviousNames,pBasePreviousNames).ALL,
																		Corp2_Raw_LA.Build_Bases_TradeServices(pfiledate,pversion,puseprod,pInTradeServices,pBaseTradeServices).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_LA.Build_Bases attribute')
									 );

END;
