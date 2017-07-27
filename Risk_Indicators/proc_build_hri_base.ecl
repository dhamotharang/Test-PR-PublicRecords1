import risk_indicators, VersionControl, business_header,paw;
export proc_build_hri_base(

	 string		pversion
	,boolean	pUseDatasets		= false
	,string		pPersistUnique	= 'hri::'

) :=
module

	shared basename 	:= filenames(pversion);
	
	shared sicunique := if(pPersistUnique = '', '', '::' + pPersistUnique[1..(length(trim(pPersistUnique)) - 2)]);

	shared dpawinactives := paw.fCorpInactives(pPersistname := paw.persistnames.f_CorpInactives + sicunique);

	VersionControl.macBuildNewLogicalFile( basename.HRIAddressSicCode.new			,BWR_Create_HRI_Addr_Sic			(pUseDatasets,pPersistUnique,pInactiveCorps := dpawinactives)	,build_hri_addr_sic_base			,false);
	VersionControl.macBuildNewLogicalFile( basename.HRIAddressSicCodeFCRA.new	,BWR_Create_HRI_Addr_Sic_FCRA	(pUseDatasets,pPersistUnique,pInactiveCorps := dpawinactives)	,build_hri_addr_sic_base_fcra	);
	VersionControl.macBuildNewLogicalFile( basename.HRIAddressSicCode2.new		,BWR_Create_HRI_Addr_Sic2			(pUseDatasets,pPersistUnique,pInactiveCorps := dpawinactives)	,build_hri_addr_sic_base2			);
	VersionControl.macBuildNewLogicalFile( basename.AddressSicCode.new				,fAll_Businesses							(pPersistUnique,pUseDatasets,pInactiveCorps := dpawinactives)	,build_addr_sic_base					);

	export all :=
	sequential(
		parallel(
			 build_hri_addr_sic_base
			,build_hri_addr_sic_base_fcra
			,build_hri_addr_sic_base2
			,build_addr_sic_base
		)
		,promote(pversion,'address_sic_code').new2built
	);

end;