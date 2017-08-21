IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																										pfiledate,
	STRING																										pversion,
	Boolean 																								  pUseOtherEnvironment,
	DATASET(Corp2_Raw_NC.Layouts.AddressesLayoutIn)						pInAddresses   		 		= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.Addresses.logical,
	DATASET(Corp2_Raw_NC.Layouts.AddressesLayoutBase)					pBaseAddresses 		 		= IF(Corp2_Raw_NC._Flags.Base.Addresses, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.Addresses.qa, DATASET([], Corp2_Raw_NC.Layouts.AddressesLayoutBase)),
	DATASET(Corp2_Raw_NC.Layouts.FilingsLayoutIn)							pInFilings   					= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.Filings.logical,
	DATASET(Corp2_Raw_NC.Layouts.FilingsLayoutBase)						pBaseFilings 					= IF(Corp2_Raw_NC._Flags.Base.Filings, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.Filings.qa, DATASET([], Corp2_Raw_NC.Layouts.FilingsLayoutBase)),
	DATASET(Corp2_Raw_NC.Layouts.CorporationsLayoutIn)				pInCorporations   		= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input. Corporations.logical,
  DATASET(Corp2_Raw_NC.Layouts.CorporationsLayoutBase)			pBaseCorporations 		= IF(Corp2_Raw_NC._Flags.Base. Corporations, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base. Corporations.qa, DATASET([], Corp2_Raw_NC.Layouts. CorporationsLayoutBase)),
	DATASET(Corp2_Raw_NC.Layouts.NameReservationsLayoutIn)		pInNameReservations 	= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.NameReservations.logical,
	DATASET(Corp2_Raw_NC.Layouts.NameReservationsLayoutBase)	pBaseNameReservations	= IF(Corp2_Raw_NC._Flags.Base.NameReservations, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.NameReservations.qa, DATASET([], Corp2_Raw_NC.Layouts.NameReservationsLayoutBase)),
	DATASET(Corp2_Raw_NC.Layouts.NamesLayoutIn)								pInNames   			 			= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.Names.logical,
	DATASET(Corp2_Raw_NC.Layouts.NamesLayoutBase)							pBaseNames			 			= IF(Corp2_Raw_NC._Flags.Base.Names, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.Names.qa, DATASET([], Corp2_Raw_NC.Layouts.NamesLayoutBase)),
	DATASET(Corp2_Raw_NC.Layouts.StockLayoutIn)	 							pInStock   						= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.Stock.logical,
  DATASET(Corp2_Raw_NC.Layouts.StockLayoutBase) 						pBaseStock						= IF(Corp2_Raw_NC._Flags.Base.Stock, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, DATASET([], Corp2_Raw_NC.Layouts.StockLayoutBase)),
  DATASET(Corp2_Raw_NC.Layouts.PendingFilingsLayoutIn)			pInPendingFilings   	= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.PendingFilings.logical,
	DATASET(Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase)		pBasePendingFilings 	= IF(Corp2_Raw_NC._Flags.Base.PendingFilings, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.PendingFilings.qa, DATASET([], Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase)),
	DATASET(Corp2_Raw_NC.Layouts.CorpOfficersLayoutIn)				pInCorpOfficers   		= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.CorpOfficers.logical,
  DATASET(Corp2_Raw_NC.Layouts.CorpOfficersLayoutBase)			pBaseCorpOfficers 		= IF(Corp2_Raw_NC._Flags.Base.CorpOfficers, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.CorpOfficers.qa, DATASET([], Corp2_Raw_NC.Layouts. CorpOfficersLayoutBase))
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_NC.Build_Bases_Addresses(pfiledate,pversion,pUseOtherEnvironment,pInAddresses,pBaseAddresses).ALL,
																		Corp2_Raw_NC.Build_Bases_Filings(pfiledate,pversion,pUseOtherEnvironment,pInFilings,pBaseFilings).ALL,
																		Corp2_Raw_NC.Build_Bases_Corporations(pfiledate,pversion,pUseOtherEnvironment,pInCorporations,pBaseCorporations).ALL,
																		Corp2_Raw_NC.Build_Bases_NameReservations(pfiledate,pversion,pUseOtherEnvironment,pInNameReservations,pBaseNameReservations).ALL,
																		Corp2_Raw_NC.Build_Bases_Names(pfiledate,pversion,pUseOtherEnvironment,pInNames,pBaseNames).ALL,
																		Corp2_Raw_NC.Build_Bases_Stock(pfiledate,pversion,pUseOtherEnvironment,pInStock,pBaseStock).ALL,
																		Corp2_Raw_NC.Build_Bases_Filings(pfiledate,pversion,pUseOtherEnvironment,pInPendingFilings,pBasePendingFilings).ALL,
																		Corp2_Raw_NC.Build_Bases_CorpOfficers(pfiledate,pversion,pUseOtherEnvironment,pInCorpOfficers,pBaseCorpOfficers).ALL,
																		Corp2_Raw_NC.Build_Bases_PendingFilings(pfiledate,pversion,pUseOtherEnvironment,pInPendingFilings,pBasePendingFilings).ALL,
																		
																	  Promote(pversion).buildfiles.New2Built,
																	  Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NC.Build_Bases attribute')
									 );

END;
