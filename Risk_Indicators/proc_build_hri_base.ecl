import risk_indicators, tools, business_header,paw,corp2;

laycorp := corp2.Layout_Corporate_Direct_Corp_Base;

export proc_build_hri_base(

	 string														pversion
	,boolean													pUseDatasets									= false
	,string														pPersistUnique								= 'hri::'
	,string														pBhVersion										= 'qa'
	,string														pSicUnique										= if(pPersistUnique = '', '', '::' + pPersistUnique[1..(length(trim(pPersistUnique)) - 2)])
	,dataset(laycorp								)	pInactiveCorps 								= paw.fCorpInactives(pPersistname := paw.persistnames().f_CorpInactives + pSicUnique)
	,dataset(Layout_HRI_Address_Sic	)	pBWR_Create_HRI_Addr_Sic			= BWR_Create_HRI_Addr_Sic				(pUseDatasets,pPersistUnique + 'addrsic::',pInactiveCorps := pInactiveCorps,pBhVersion := pBhVersion)
	,dataset(Layout_HRI_Address_Sic2)	pBWR_Create_HRI_Addr_Sic2			= BWR_Create_HRI_Addr_Sic2			(pUseDatasets,pPersistUnique,pInactiveCorps := pInactiveCorps,pBhVersion := pBhVersion)
	,dataset(Layout_HRI_Address_Sic	)	pBWR_Create_HRI_Addr_Sic_FCRA = BWR_Create_HRI_Addr_Sic_FCRA	(pUseDatasets,pPersistUnique + 'fcra::',pInactiveCorps := pInactiveCorps,pBhVersion := pBhVersion)
	,dataset(Layouts.AddressSicCode	)	pfAll_Businesses 							= fAll_Businesses								(pUseDatasets,pPersistUnique,pInactiveCorps := pInactiveCorps,pBhVersion := pBhVersion)

) :=
module

	shared basename 	:= filenames(pversion);
	
	tools.mac_WriteFile(basename.HRIAddressSicCode.new			,pBWR_Create_HRI_Addr_Sic				,build_hri_addr_sic_base			,false);
	tools.mac_WriteFile(basename.HRIAddressSicCode2.new			,pBWR_Create_HRI_Addr_Sic2			,build_hri_addr_sic_base2			);
	tools.mac_WriteFile(basename.HRIAddressSicCodeFCRA.new	,pBWR_Create_HRI_Addr_Sic_FCRA 	,build_hri_addr_sic_base_fcra	);
	tools.mac_WriteFile(basename.AddressSicCode.new					,pfAll_Businesses 							,build_addr_sic_base					);

	export all :=
	sequential(
		parallel(
			 build_hri_addr_sic_base			
			,build_hri_addr_sic_base2			
			,build_hri_addr_sic_base_fcra	
			,build_addr_sic_base						
		)
		,promote(pversion,'address_sic_code').new2built
	);

end;