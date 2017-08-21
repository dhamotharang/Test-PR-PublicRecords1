IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																										pfiledate,
	STRING																										pversion,
	Boolean 																								  pUseOtherEnvironment,
	DATASET(Corp2_Raw_WV.Layouts.AddressesLayoutIn)						pInAddresses   		  = Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.Addresses.logical,
	DATASET(Corp2_Raw_WV.Layouts.AddressesLayoutBase)					pBaseAddresses 		  = IF(Corp2_Raw_WV._Flags.Base.Addresses, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.Addresses.qa, DATASET([], Corp2_Raw_WV.Layouts.AddressesLayoutBase)),
	DATASET(Corp2_Raw_WV.Layouts.amendmentsLayoutIn)					pInamendments   		= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.amendments.logical,
	DATASET(Corp2_Raw_WV.Layouts.amendmentsLayoutBase)			  pBaseamendments 		= IF(Corp2_Raw_WV._Flags.Base.amendments, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.amendments.qa, DATASET([], Corp2_Raw_WV.Layouts.amendmentsLayoutBase)),
	DATASET(Corp2_Raw_WV.Layouts.annualreportsLayoutIn)				pInannualreports   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.annualreports.logical,
	DATASET(Corp2_Raw_WV.Layouts.annualreportsLayoutBase)			pBaseannualreports 	= IF(Corp2_Raw_WV._Flags.Base.annualreports, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.annualreports.qa, DATASET([], Corp2_Raw_WV.Layouts.annualreportsLayoutBase)),
	DATASET(Corp2_Raw_WV.Layouts.corporationsLayoutIn)				pIncorporations   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.corporations.logical,
  DATASET(Corp2_Raw_WV.Layouts.corporationsLayoutBase)			pBasecorporations 	= IF(Corp2_Raw_WV._Flags.Base.corporations, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.corporations.qa, DATASET([], Corp2_Raw_WV.Layouts.corporationsLayoutBase)),
	DATASET(Corp2_Raw_WV.Layouts.DissolutionsLayoutIn)				pInDissolutions  		= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.Dissolutions.logical,
	DATASET(Corp2_Raw_WV.Layouts.DissolutionsLayoutBase)			pBaseDissolutions		= IF(Corp2_Raw_WV._Flags.Base.Dissolutions, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.Dissolutions.qa, DATASET([], Corp2_Raw_WV.Layouts.DissolutionsLayoutBase)),
	DATASET(Corp2_Raw_WV.Layouts.dbasLayoutIn)								pIndbas   			 		= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.dbas.logical,
	DATASET(Corp2_Raw_WV.Layouts.dbasLayoutBase)							pBasedbas			 			= IF(Corp2_Raw_WV._Flags.Base.dbas, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.dbas.qa, DATASET([], Corp2_Raw_WV.Layouts.dbasLayoutBase)),
	DATASET(Corp2_Raw_WV.Layouts.mergersLayoutIn)							pInmergers   				= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.mergers.logical,
  DATASET(Corp2_Raw_WV.Layouts.mergersLayoutBase)			 			pBasemergers 				= IF(Corp2_Raw_WV._Flags.Base.mergers, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.mergers.qa, DATASET([], Corp2_Raw_WV.Layouts.mergersLayoutBase)),
	DATASET(Corp2_Raw_WV.Layouts.namechangesLayoutIn)				  pInnamechanges  		= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.namechanges.logical,
	DATASET(Corp2_Raw_WV.Layouts.namechangesLayoutBase)	 			pBasenamechanges		= IF(Corp2_Raw_WV._Flags.Base.namechanges, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.namechanges.qa, DATASET([], Corp2_Raw_WV.Layouts.namechangesLayoutBase)),
	DATASET(Corp2_Raw_WV.Layouts.subsidiariesLayoutIn)	 			pInsubsidiaries   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment).Input.subsidiaries.logical,
	DATASET(Corp2_Raw_WV.Layouts.subsidiariesLayoutBase) 			pBasesubsidiaries		= IF(Corp2_Raw_WV._Flags.Base.subsidiaries, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.subsidiaries.qa, DATASET([], Corp2_Raw_WV.Layouts.subsidiariesLayoutBase))
	
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_WV.Build_Bases_Addresses(pfiledate,pversion,pUseOtherEnvironment,pInAddresses,pBaseAddresses).ALL,
																		Corp2_Raw_WV.Build_Bases_amendments(pfiledate,pversion,pUseOtherEnvironment,pInamendments,pBaseamendments).ALL,
																		Corp2_Raw_WV.Build_Bases_annualreports(pfiledate,pversion,pUseOtherEnvironment,pInannualreports,pBaseannualreports).ALL,
																		Corp2_Raw_WV.Build_Bases_corporations(pfiledate,pversion,pUseOtherEnvironment,pIncorporations,pBasecorporations).ALL,
																		Corp2_Raw_WV.Build_Bases_Dissolutions(pfiledate,pversion,pUseOtherEnvironment,pInDissolutions,pBaseDissolutions).ALL,
																		Corp2_Raw_WV.Build_Bases_dbas(pfiledate,pversion,pUseOtherEnvironment,pIndbas,pBasedbas).ALL,
																		Corp2_Raw_WV.Build_Bases_mergers(pfiledate,pversion,pUseOtherEnvironment,pInmergers,pBasemergers).ALL,
																		Corp2_Raw_WV.Build_Bases_namechanges(pfiledate,pversion,pUseOtherEnvironment,pInnamechanges,pBasenamechanges).ALL,
																		Corp2_Raw_WV.Build_Bases_subsidiaries(pfiledate,pversion,pUseOtherEnvironment,pInsubsidiaries,pBasesubsidiaries).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WV.Build_Bases attribute')
									 );

END;
