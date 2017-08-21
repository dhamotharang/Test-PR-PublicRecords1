import versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pkeystring						= 'key'
	,string		pPrefix								= 'thor_data400'

) :=
module

	export lOldRoot			:= _Dataset(pUseOtherEnvironment,pPrefix).thor_cluster_Files + 'key::';									
	shared lNewRoot			:= lOldRoot + 'business_header::';
	shared lversiondate	:= pversion														;
	shared lversion			:= '@version@::'											;

	export lHRIOldAddress						:= lOldRoot + 'hri_address_to_sic'					;
	export lHRIOldAddress_filtered	:= lOldRoot + 'hri_address_to_sic_filtered'	;
	export lHRIOldSicz5							:= lOldRoot + 'hri_sic_zip_to_address'			;
	export lroot										:= lNewRoot 								+ lversion												;
	export HRIroot									:= lNewRoot 								+ lversion	+ 'hri::'							;
	export HRIroot_filtered					:= lNewRoot + 'filtered::'	+ lversion	+ 'hri::'							;
	export HRIroot_filtered_fcra		:= lNewRoot + 'filtered::fcra::'	+ lversion	+ 'hri::'							;

	export lHRINewaddress								:= HRIroot								+ 'address'									;
	export lHRINewaddress_filtered			:= HRIroot_filtered				+ 'address'									;
	export lHRINewaddress_fcra_filtered	:= HRIroot_filtered_fcra	+ 'address'									;
	export lHRINewsicz5									:= HRIroot								+ 'sic.z5'									;
	export laddressSicCode							:= lroot									+ 'address_SicCode'					;
	export laddressSicCodeHRI						:= HRIroot								+ 'address_SicCode'					;
	export lSicCodeDescription					:= lroot									+ 'SicCode_Description'			;
	export lAddrAttrRiskBdid						:= lroot									+ 'business_risk_bdid'			;
	export lAddrAttrRiskGeolink					:= lroot									+ 'business_risk_geolink'		;
	

	export HRIAddress									:= versioncontrol.mBuildFilenameVersions(lHRIOldAddress								,lversiondate	,lHRINewaddress						);
	export HRIAddress_filtered				:= versioncontrol.mBuildFilenameVersions(lHRIOldAddress_filtered			,lversiondate	,lHRINewaddress_filtered	);
	export HRIAddress_fcra_filtered		:= versioncontrol.mBuildFilenameVersions(lHRINewaddress_fcra_filtered	,lversiondate	);
	export HRISicZ5										:= versioncontrol.mBuildFilenameVersions(lHRIOldSicz5									,lversiondate	,lHRINewsicz5							);
	export AddressSicCode							:= versioncontrol.mBuildFilenameVersions(laddressSicCode							,lversiondate	);
	export AddressSicCodeFullHRI			:= versioncontrol.mBuildFilenameVersions(laddressSicCodeHRI						,lversiondate	);
	export SicCodeDesc								:= versioncontrol.mBuildFilenameVersions(lSicCodeDescription					,lversiondate	);
	export AddrAttrRiskBdid						:= versioncontrol.mBuildFilenameVersions(lAddrAttrRiskBdid						,lversiondate	);
	export AddrAttrRiskGeolink				:= versioncontrol.mBuildFilenameVersions(lAddrAttrRiskGeolink					,lversiondate	);

	export NonFCRA_dAll_filenames := 
			HRIAddress.dAll_filenames
		+ HRISicZ5.dAll_filenames
		+ HRIAddress_filtered.dAll_filenames
		+ AddressSicCode.dAll_filenames
		+ AddressSicCodeFullHRI.dAll_filenames
		+ SicCodeDesc.dAll_filenames
		+ AddrAttrRiskBdid.dAll_filenames
		+ AddrAttrRiskGeolink.dAll_filenames
		;

	export FCRA_dAll_filenames := 
		  HRIAddress_fcra_filtered.dall_filenames
		;

	export dAll_filenames := 
			HRIAddress.dAll_filenames
		+ HRISicZ5.dAll_filenames
		+ HRIAddress_filtered.dAll_filenames
		+ HRIAddress_fcra_filtered.dall_filenames
		+ AddressSicCode.dAll_filenames
		+ AddressSicCodeFullHRI.dAll_filenames
		+ SicCodeDesc.dAll_filenames
		+ AddrAttrRiskBdid.dAll_filenames
		+ AddrAttrRiskGeolink.dAll_filenames
		;

end;