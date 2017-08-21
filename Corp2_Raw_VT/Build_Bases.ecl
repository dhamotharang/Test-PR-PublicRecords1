IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						pUseOtherEnvironment,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInDomLLCBus   						= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.DomLLCBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)			  pBaseDomLLCBus 	 					= IF(Corp2_Raw_VT._Flags.Base.DomLLCBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.DomLLCBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInDomMBEBus   	 					= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.DomMBEBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)				pBaseDomMBEBus 	 					= IF(Corp2_Raw_VT._Flags.Base.DomMBEBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.DomMBEBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInDomNPCBus  						= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.DomNPCBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)				pBaseDomNPCBus						= IF(Corp2_Raw_VT._Flags.Base.DomNPCBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.DomNPCBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInDomProfBus   	 				= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.DomProfBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)				pBaseDomProfBus 	 				= IF(Corp2_Raw_VT._Flags.Base.DomProfBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.DomProfBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInForLLCBus   						= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.ForLLCBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)				pBaseForLLCBus 	 					= IF(Corp2_Raw_VT._Flags.Base.ForLLCBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.ForLLCBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInForNPCBus  						= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.ForNPCBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)				pBaseForNPCBus						= IF(Corp2_Raw_VT._Flags.Base.ForNPCBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.ForNPCBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInForProfBus   	 				= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.ForProfBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)			  pBaseForProfBus 	 				= IF(Corp2_Raw_VT._Flags.Base.ForProfBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.ForProfBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInPshipsBus   	 			    = Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.PshipsBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)				pBasePshipsBus 	 			    = IF(Corp2_Raw_VT._Flags.Base.PshipsBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.PshipsBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutIn)					pInTrdNamesBus   	 				= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.TrdNamesBus.logical,
	DATASET(Corp2_Raw_VT.Layouts.BusLayoutBase)				pBaseTrdNamesBus 	 				= IF(Corp2_Raw_VT._Flags.Base.TrdNamesBus, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.TrdNamesBus.qa, DATASET([], Corp2_Raw_VT.Layouts.BusLayoutBase)),
	
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)				  pInDomLLCPrn  						= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.DomLLCPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBaseDomLLCPrn						= IF(Corp2_Raw_VT._Flags.Base.DomLLCPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.DomLLCPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)					pInDomMBEPrn   						= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.DomMBEPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBaseDomMBEPrn 	 					= IF(Corp2_Raw_VT._Flags.Base.DomMBEPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.DomMBEPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)					pInDomNPCPrn   	 					= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.DomNPCPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBaseDomNPCPrn 	 					= IF(Corp2_Raw_VT._Flags.Base.DomNPCPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.DomNPCPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)					pInDomProfPrn   	 				= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.DomProfPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBaseDomProfPrn 	 				= IF(Corp2_Raw_VT._Flags.Base.DomProfPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.DomProfPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)					pInForLLCPrn  						= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.ForLLCPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBaseForLLCPrn						= IF(Corp2_Raw_VT._Flags.Base.ForLLCPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.ForLLCPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)					pInForNPCPrn   	 					= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.ForNPCPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBaseForNPCPrn 	 					= IF(Corp2_Raw_VT._Flags.Base.ForNPCPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.ForNPCPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)					pInForProfPrn   	 				= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.ForProfPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBaseForProfPrn 	 				= IF(Corp2_Raw_VT._Flags.Base.ForProfPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.ForProfPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)					pInPshipsPrn   	 			    = Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.PshipsPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBasePshipsPrn 	 			    = IF(Corp2_Raw_VT._Flags.Base.PshipsPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.PshipsPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutIn)					pInTrdNamesPrn   	 				= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.TrdNamesPrn.logical,
	DATASET(Corp2_Raw_VT.Layouts.PrnLayoutBase)				pBaseTrdNamesPrn 	 				= IF(Corp2_Raw_VT._Flags.Base.TrdNamesPrn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.TrdNamesPrn.qa, DATASET([], Corp2_Raw_VT.Layouts.PrnLayoutBase)),
	
	DATASET(Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutIn)				pInTrdNamesOwn   	 				= Corp2_Raw_VT.Files(pfiledate,pUseOtherEnvironment).Input.TrdNamesOwn.logical,
	DATASET(Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase)			pBaseTrdNamesOwn 	 				= IF(Corp2_Raw_VT._Flags.Base.TrdNamesOwn, Corp2_Raw_VT.Files(,pUseOtherEnvironment := FALSE).Base.TrdNamesOwn.qa, DATASET([], Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutBase))

) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_VT.Build_Bases_DomLLCBus(pfiledate,pversion,pUseOtherEnvironment,pInDomLLCBus,pBaseDomLLCBus).ALL,
																		Corp2_Raw_VT.Build_Bases_DomMBEBus(pfiledate,pversion,pUseOtherEnvironment,pInDomMBEBus,pBaseDomMBEBus).ALL,
																		Corp2_Raw_VT.Build_Bases_DomNPCBus(pfiledate,pversion,pUseOtherEnvironment,pInDomNPCBus,pBaseDomNPCBus).ALL,
																		Corp2_Raw_VT.Build_Bases_DomProfBus(pfiledate,pversion,pUseOtherEnvironment,pInDomProfBus,pBaseDomProfBus).ALL,
																		Corp2_Raw_VT.Build_Bases_ForLLCBus(pfiledate,pversion,pUseOtherEnvironment,pInForLLCBus,pBaseForLLCBus).ALL,
																		Corp2_Raw_VT.Build_Bases_ForNPCBus(pfiledate,pversion,pUseOtherEnvironment,pInForNPCBus,pBaseForNPCBus).ALL,
																		Corp2_Raw_VT.Build_Bases_ForProfBus(pfiledate,pversion,pUseOtherEnvironment,pInForProfBus,pBaseForProfBus).ALL,
																		Corp2_Raw_VT.Build_Bases_TrdNamesBus(pfiledate,pversion,pUseOtherEnvironment,pInTrdNamesBus,pBaseTrdNamesBus).ALL,
																		Corp2_Raw_VT.Build_Bases_PshipsBus(pfiledate,pversion,pUseOtherEnvironment,pInPshipsBus,pBasePshipsBus).ALL, //As of 07/2016 ,Domestic & Foreign  partnership Businesses in single file
																		
																		Corp2_Raw_VT.Build_Bases_DomLLCPrn(pfiledate,pversion,pUseOtherEnvironment,pInDomLLCPrn,pBaseDomLLCPrn).ALL,
																		Corp2_Raw_VT.Build_Bases_DomMBEPrn(pfiledate,pversion,pUseOtherEnvironment,pInDomMBEPrn,pBaseDomMBEPrn).ALL,
																		Corp2_Raw_VT.Build_Bases_DomNPCPrn(pfiledate,pversion,pUseOtherEnvironment,pInDomNPCPrn,pBaseDomNPCPrn).ALL,
																		Corp2_Raw_VT.Build_Bases_DomProfPrn(pfiledate,pversion,pUseOtherEnvironment,pInDomProfPrn,pBaseDomProfPrn).ALL,
																		Corp2_Raw_VT.Build_Bases_ForLLCPrn(pfiledate,pversion,pUseOtherEnvironment,pInForLLCPrn,pBaseForLLCPrn).ALL,
																		Corp2_Raw_VT.Build_Bases_ForNPCPrn(pfiledate,pversion,pUseOtherEnvironment,pInForNPCPrn,pBaseForNPCPrn).ALL,
																		Corp2_Raw_VT.Build_Bases_ForProfPrn(pfiledate,pversion,pUseOtherEnvironment,pInForProfPrn,pBaseForProfPrn).ALL,
																		Corp2_Raw_VT.Build_Bases_PshipsPrn(pfiledate,pversion,pUseOtherEnvironment,pInPshipsPrn,pBasePshipsPrn).ALL, //As of 07/2016 ,Domestic & Foreign  partnership Principals in single file
																		Corp2_Raw_VT.Build_Bases_TrdNamesPrn(pfiledate,pversion,pUseOtherEnvironment,pInTrdNamesPrn,pBaseTrdNamesPrn).ALL,
																		
																		Corp2_Raw_VT.Build_Bases_TrdNamesOwn(pfiledate,pversion,pUseOtherEnvironment,pInTrdNamesOwn,pBaseTrdNamesOwn).ALL,
																		
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VT.Build_Bases attribute')
									 );

END;
