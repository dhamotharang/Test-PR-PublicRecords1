import RoxieKeyBuild, business_header, ut, aca, versioncontrol, Address_Attributes;

export proc_build_hri_keys(

	string pversion

) :=
module

	shared KeyName		:= keynames			(pversion);
	shared ACAKeyName	:= aca.keynames	(pversion);

	/////////////////////////////////////////////////////////////////////////////////
	// -- Build ACA Key
	/////////////////////////////////////////////////////////////////////////////////
	VersionControl.macBuildNewLogicalKeyWithName(aca.key_aca_addr						,ACAKeyName.Address.New				,BuildACAkey					);
	
	/////////////////////////////////////////////////////////////////////////////////
	// -- Build Address_Attributes business_risk_bdid Key
	/////////////////////////////////////////////////////////////////////////////////
	VersionControl.macBuildNewLogicalKeyWithName(Address_Attributes.key_business_risk_bdid		,KeyName.AddrAttrRiskBdid.New			,BuildAddrAttrBDIDkey				);
	VersionControl.macBuildNewLogicalKeyWithName(Address_Attributes.key_business_risk_geolink	,KeyName.AddrAttrRiskGeolink.New	,BuildAddrAttrGeolinkkey		);

	/////////////////////////////////////////////////////////////////////////////////
	// -- Build Non-FCRA Keys
	/////////////////////////////////////////////////////////////////////////////////
	VersionControl.macBuildNewLogicalKeyWithName(Key_HRI_Address_To_Sic			,KeyName.HRIAddress.New						,BuildHRIAddrkey				,,true);
	VersionControl.macBuildNewLogicalKeyWithName(Key_HRI_Sic_Zip_To_Address	,KeyName.HRISicZ5.New							,BuildHRISICkey					,,true);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Address_To_Sic					,KeyName.AddressSicCode.New				,BuildAddrSICkey				,,true);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Address_To_Sic_Full_HRI,KeyName.AddressSicCodeFullHRI.New,BuildAddrSICFullHrikey	,,true);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Sic_Description				,KeyName.SicCodeDesc.New					,BuildSICDesckey				,,true);
																																				
	/////////////////////////////////////////////////////////////////////////////////
	// -- Build FCRA Neutral Keys
	/////////////////////////////////////////////////////////////////////////////////
	VersionControl.macBuildNewLogicalKeyWithName(Key_HRI_Address_To_Sic_filtered			,KeyName.HRIAddress_filtered.New			,BuildHRIAddrFiltKey		,,true	);
	VersionControl.macBuildNewLogicalKeyWithName(Key_HRI_Address_To_Sic_filtered_FCRA	,KeyName.HRIAddress_fcra_filtered.New	,BuildHRIAddrFiltFCRAKey,,true	);

	shared keygroupnames := 
				ACAKeyName.Address.dAll_filenames
			+ KeyName.AddrAttrRiskBdid.dAll_filenames
			+ KeyName.AddrAttrRiskGeolink.dAll_filenames
			+ KeyName.HRIAddress.dAll_filenames                                                                           
			+ KeyName.HRISicZ5.dAll_filenames
			+ KeyName.AddressSicCode.dAll_filenames
			+ KeyName.AddressSicCodeFullHRI.dAll_filenames
			+ KeyName.SicCodeDesc.dAll_filenames
			+ KeyName.HRIAddress_filtered.dAll_filenames
			+ KeyName.HRIAddress_fcra_filtered.dAll_filenames
			; 

	shared build_keys := 
		if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
			,parallel(
			
				 BuildACAkey
				,BuildAddrAttrBDIDkey
				,BuildAddrAttrGeolinkkey
				,BuildHRIAddrkey
				,BuildHRISICkey	
				,BuildAddrSICkey
				,BuildAddrSICFullHrikey
				,BuildSICDesckey
				,BuildHRIAddrFiltKey
				,BuildHRIAddrFiltFCRAKey
			));

	shared do_all :=
		sequential(

			 build_keys
			,promote(pversion).new2built
			,ACA.promote(pversion).new2built
		);


	export All := do_all;

end;