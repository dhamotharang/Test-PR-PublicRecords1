IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																			   pfiledate,
	STRING																				 pversion,
	BOOLEAN                                        pUseOtherEnvironment,
	DATASET(Corp2_Raw_RI.Layouts.amendmentsIn)		 pInamendments   					= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.amendments.logical,
	DATASET(Corp2_Raw_RI.Layouts.amendmentsBase)	 pBaseamendments 					= IF(Corp2_Raw_RI._Flags.Base.amendments, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.amendments.qa, DATASET([], Corp2_Raw_RI.Layouts.AmendmentsBase)),
	DATASET(Corp2_Raw_RI.Layouts.AmendmentsIn)		 pInInactive_Amendments   = Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Inactive_Amendments.logical,
	DATASET(Corp2_Raw_RI.Layouts.AmendmentsBase)	 pBaseInactive_Amendments = IF(Corp2_Raw_RI._Flags.Base.Inactive_Amendments, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Inactive_Amendments.qa, DATASET([], Corp2_Raw_RI.Layouts.AmendmentsBase)),
	DATASET(Corp2_Raw_RI.Layouts.EntitiesIn)			 pInEntities   						= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Entities.logical,
	DATASET(Corp2_Raw_RI.Layouts.EntitiesBase)		 pBaseEntities 						= IF(Corp2_Raw_RI._Flags.Base.Entities, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Entities.qa, DATASET([], Corp2_Raw_RI.Layouts.EntitiesBase)),
	DATASET(Corp2_Raw_RI.Layouts.InActEntitiesIN)	 pInInactive_Entities   	= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Inactive_Entities.logical,
  DATASET(Corp2_Raw_RI.Layouts.InActEntitiesBase)pBaseInactive_Entities 	= IF(Corp2_Raw_RI._Flags.Base.Inactive_Entities, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Inactive_Entities.qa, DATASET([], Corp2_Raw_RI.Layouts.InActEntitiesBase)),
	DATASET(Corp2_Raw_RI.Layouts.MergersIn)				 pInMergers  							= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Mergers.logical,
	DATASET(Corp2_Raw_RI.Layouts.MergersBase)			 pBaseMergers							= IF(Corp2_Raw_RI._Flags.Base.Mergers, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Mergers.qa, DATASET([], Corp2_Raw_RI.Layouts.MergersBase)),
	DATASET(Corp2_Raw_RI.Layouts.MergersIn)			   pInInactive_Mergers   	  = Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Inactive_Mergers.logical,
	DATASET(Corp2_Raw_RI.Layouts.MergersBase)		   pBaseInactive_Mergers		= IF(Corp2_Raw_RI._Flags.Base.Inactive_Mergers, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Inactive_Mergers.qa, DATASET([], Corp2_Raw_RI.Layouts.MergersBase)),
	DATASET(Corp2_Raw_RI.Layouts.OfficersIn)			 pInOfficers   	  				= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input. Officers.logical,
  DATASET(Corp2_Raw_RI.Layouts.OfficersBase)		 pBaseOfficers 						= IF(Corp2_Raw_RI._Flags.Base. Officers, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base. Officers.qa, DATASET([], Corp2_Raw_RI.Layouts.OfficersBase)),
	DATASET(Corp2_Raw_RI.Layouts.OfficersIn)			 pInInactive_Officers  		= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Inactive_Officers.logical,
	DATASET(Corp2_Raw_RI.Layouts.OfficersBase)	 	 pBaseInactive_Officers		= IF(Corp2_Raw_RI._Flags.Base.Inactive_Officers, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Inactive_Officers.qa, DATASET([], Corp2_Raw_RI.Layouts.OfficersBase)),
	DATASET(Corp2_Raw_RI.Layouts.StocksIn)	 			 pInStocks   							= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Stocks.logical,
	DATASET(Corp2_Raw_RI.Layouts.StocksBase) 			 pBaseStocks							= IF(Corp2_Raw_RI._Flags.Base.Stocks, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Stocks.qa, DATASET([], Corp2_Raw_RI.Layouts.StocksBase)),
	DATASET(Corp2_Raw_RI.Layouts.StocksIn)	 			 pInInactive_Stocks   		= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Inactive_Stocks.logical,
	DATASET(Corp2_Raw_RI.Layouts.StocksBase) 		   pBaseInactive_Stocks			= IF(Corp2_Raw_RI._Flags.Base.Inactive_Stocks, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Inactive_Stocks.qa, DATASET([], Corp2_Raw_RI.Layouts.StocksBase)),
	DATASET(Corp2_Raw_RI.Layouts.NamesIn)					 pInNames   							= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Names.logical,
	DATASET(Corp2_Raw_RI.Layouts.NamesBase)			   pBaseNames 							= IF(Corp2_Raw_RI._Flags.Base.Names, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Names.qa, DATASET([], Corp2_Raw_RI.Layouts.NamesBase)),
	DATASET(Corp2_Raw_RI.Layouts.NamesIn)				   pInInactive_Names   			= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Inactive_Names.logical,
	DATASET(Corp2_Raw_RI.Layouts.NamesBase)			   pBaseInactive_Names 			= IF(Corp2_Raw_RI._Flags.Base.Inactive_Names, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Inactive_Names.qa, DATASET([], Corp2_Raw_RI.Layouts.NamesBase))
	
) := MODULE

	EXPORT full_build := SEQUENTIAL(	Corp2_Raw_RI.Build_Bases_amendments(pfiledate,pversion,pUseOtherEnvironment,pInamendments,pBaseamendments).ALL,
																		Corp2_Raw_RI.Build_Bases_Inact_Amendments(pfiledate,pversion,pUseOtherEnvironment,pInInactive_Amendments,pBaseInactive_Amendments).ALL,
																		Corp2_Raw_RI.Build_Bases_Entities(pfiledate,pversion,pUseOtherEnvironment,pInEntities,pBaseEntities).ALL,
																		Corp2_Raw_RI.Build_Bases_Inact_Entities(pfiledate,pversion,pUseOtherEnvironment,pInInactive_Entities,pBaseInactive_Entities).ALL,
																		Corp2_Raw_RI.Build_Bases_Mergers(pfiledate,pversion,pUseOtherEnvironment,pInMergers,pBaseMergers).ALL,
																		Corp2_Raw_RI.Build_Bases_Inact_Mergers(pfiledate,pversion,pUseOtherEnvironment,pInInactive_Mergers,pBaseInactive_Mergers).ALL,
																		Corp2_Raw_RI.Build_Bases_Officers(pfiledate,pversion,pUseOtherEnvironment,pInOfficers,pBaseOfficers).ALL,
																		Corp2_Raw_RI.Build_Bases_Inact_Officers(pfiledate,pversion,pUseOtherEnvironment,pInInactive_Officers,pBaseInactive_Officers).ALL,
																		Corp2_Raw_RI.Build_Bases_Stocks(pfiledate,pversion,pUseOtherEnvironment,pInStocks,pBaseStocks).ALL,
																		Corp2_Raw_RI.Build_Bases_Inact_Stocks(pfiledate,pversion,pUseOtherEnvironment,pInInactive_Stocks,pBaseInactive_Stocks).ALL,
																		Corp2_Raw_RI.Build_Bases_Names(pfiledate,pversion,pUseOtherEnvironment,pInNames,pBaseNames).ALL,
																		Corp2_Raw_RI.Build_Bases_Inact_Names(pfiledate,pversion,pUseOtherEnvironment,pInInactive_Names,pBaseInactive_Names).ALL,
																		Promote(pversion).buildfiles.New2Built,
																	  Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_RI.Build_Bases attribute')
									 );

END;
