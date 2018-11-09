IMPORT strata;

EXPORT Strata_Stats(
	 DATASET(QA_Data.layouts.base)	            pBaseFile					= QA_Data.Files().base.built
	,STRING															        pfileversion			= 'using'
	,BOOLEAN														        pUseOtherEnviron	= QA_Data._Constants().isdataland
	,DATASET(QA_Data.Layouts.Input.Sprayed_Addresses)
	                                            pSprayedAddrFile  = QA_Data.Files(pfileversion,pUseOtherEnviron).Input_Addr.logical
	,DATASET(QA_Data.Layouts.Input.Sprayed_Transactions)
	                                            pSprayedTransFile = QA_Data.Files(pfileversion,pUseOtherEnviron).Input_Trans.logical
) := MODULE

	Strata.mac_Pops		(pSprayedAddrFile			,dAddrInputNoGrouping						                    );
	Strata.mac_Uniques(pSprayedAddrFile			,dUniqueAddrInputNoGrouping			                    );
	Strata.mac_Pops		(pSprayedTransFile		,dTransInputNoGrouping					                    );
	Strata.mac_Uniques(pSprayedTransFile		,dUniqueTransInputNoGrouping		                    );
	Strata.mac_Pops		(pBaseFile				    ,dNoGrouping										                    );
	Strata.mac_Pops		(pBaseFile				    ,dCleanAddressState				      ,'Addr_address.st'	);
	Strata.mac_Uniques(pBaseFile				    ,dUniqueNoGrouping							                    );
	Strata.mac_Uniques(pBaseFile				    ,dUniqueCleanAddressState	      ,'Addr_address.st'	);

END;