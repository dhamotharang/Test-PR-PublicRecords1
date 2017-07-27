import doxie, versioncontrol;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate		:= pversion;
	shared lthor					:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;
	
	shared lroot					:= lthor + 'base::business_header::@version@::';
	export HRIroot				:= lroot + 'hri::'							;

	export lBHASCroot						:= lroot	+ 'address_sic_code'							;
	export lBHASCFCRAroot				:= lroot	+ 'address_sic_code_fcra'					;
	export lBHASC2root					:= lroot	+ 'address_sic_code2'							;
	export lAddressSicCoderoot	:= lroot	+ 'address_sic_code_full'					;
	export lsiclookuproot				:= lthor	+ 'lookup::@version@::sic_codes'	;
	
	//////////////////////////////////////////////////////////////////
	// -- Filename Versions
	//////////////////////////////////////////////////////////////////
	export HRIAddressSicCode			:= versioncontrol.mBuildFilenameVersions(lBHASCroot						,lversiondate	);
	export HRIAddressSicCodeFCRA	:= versioncontrol.mBuildFilenameVersions(lBHASCFCRAroot				,lversiondate	);
	export HRIAddressSicCode2			:= versioncontrol.mBuildFilenameVersions(lBHASC2root					,lversiondate	);
	export AddressSicCode					:= versioncontrol.mBuildFilenameVersions(lAddressSicCoderoot	,lversiondate	);
	export SicLookup							:= versioncontrol.mBuildFilenameVersions(lsiclookuproot				,lversiondate	);							
	
	//////////////////////////////////////////////////////////////////
	// -- Dataset of all Filename Versions
	//////////////////////////////////////////////////////////////////
	export dAll_filenames :=
			HRIAddressSicCode.dAll_filenames
		+ HRIAddressSicCodeFCRA.dAll_filenames
		+ HRIAddressSicCode2.dAll_filenames
		+ AddressSicCode.dAll_filenames
		+ SicLookup.dAll_filenames
		;

end;