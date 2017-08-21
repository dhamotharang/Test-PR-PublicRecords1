import doxie, versioncontrol;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion;
	shared lthor				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;
	
	export Base :=
	module
		//////////////////////////////////////////////////////////////////
		// -- Root names
		//////////////////////////////////////////////////////////////////
		shared lNewroot		:= lthor + 'base::business_header::@version@::';

		export lNewBHStatroot			:= lNewroot + 'stat'											;
		export lNewBHroot					:= lNewroot + 'search'										;
		export lNewBHBroot				:= lNewroot + 'best'											;
		export lNewBRroot					:= lNewroot + 'relatives'									;
		export lNewBRGroot				:= lNewroot + 'relatives_group'						;
		export lNewBHCroot				:= lNewroot + 'companyname'								;
		export lNewBHCAroot				:= lNewroot + 'companyname_address'				;
		export lNewBHCABroot			:= lNewroot + 'companyname_address_broad'	;
		export lNewBHCProot				:= lNewroot + 'companyname_phone'					;
		export lNewBHCFroot				:= lNewroot + 'companyname_fein'					;
		export lNewBHSroot				:= lNewroot + 'supergroup'								;
		export lNewBHCNWroot			:= lNewroot + 'co_name_words'							;
		export lNewBHBCZFProot		:= lNewroot + 'bdid.city.zip.fein.phone'	;
		export lNewPawroot				:= lNewroot + 'people_at_work_stats'			;
		export lNewBCroot					:= lNewroot + 'contacts'									;
		export lNewBCPlusroot			:= lNewroot + 'contacts_Plus'							;
		export lNewBHStatOroot		:= lNewroot + 'stat_overflow'							;
		export lNewBHBDLroot		  := lNewroot + 'BDL2'											;
		export lNewEqEmployerroot	:= lNewroot + 'Eq_Employer'								;
		export lNewBHASCroot			:= lNewroot + 'address_sic_code'					;
		export lNewBHASCFCRAroot	:= lNewroot + 'address_sic_code_fcra'			;
		export lNewBHASC2root			:= lNewroot + 'address_sic_code2'					;

		//////////////////////////////////////////////////////////////////
		// -- Filename Versions
		//////////////////////////////////////////////////////////////////
		export Stat											:= versioncontrol.mBuildFilenameVersions(lNewBHStatroot			,lversiondate	);
		export Search										:= versioncontrol.mBuildFilenameVersions(lNewBHroot					,lversiondate	);
		export HeaderBest								:= versioncontrol.mBuildFilenameVersions(lNewBHBroot				,lversiondate	);
		export Relatives								:= versioncontrol.mBuildFilenameVersions(lNewBRroot					,lversiondate	);
		export RelativesGroup						:= versioncontrol.mBuildFilenameVersions(lNewBRGroot				,lversiondate	);
		export Companyname							:= versioncontrol.mBuildFilenameVersions(lNewBHCroot				,lversiondate	);
		export CompanynameAddress				:= versioncontrol.mBuildFilenameVersions(lNewBHCAroot				,lversiondate	);
		export CompanynameAddressBroad	:= versioncontrol.mBuildFilenameVersions(lNewBHCABroot			,lversiondate	);
		export CompanynamePhone					:= versioncontrol.mBuildFilenameVersions(lNewBHCProot				,lversiondate	);
		export CompanynameFein					:= versioncontrol.mBuildFilenameVersions(lNewBHCFroot				,lversiondate	);
		export SuperGroup								:= versioncontrol.mBuildFilenameVersions(lNewBHSroot				,lversiondate	);
		export CompanyWords							:= versioncontrol.mBuildFilenameVersions(lNewBHCNWroot			,lversiondate	);
		export Bdid											:= versioncontrol.mBuildFilenameVersions(lNewBHBCZFProot		,lversiondate	);
		export PeopleAtWorkStats				:= versioncontrol.mBuildFilenameVersions(lNewPawroot				,lversiondate	);
		export Contacts									:= versioncontrol.mBuildFilenameVersions(lNewBCroot					,lversiondate	);
		export ContactsPlus							:= versioncontrol.mBuildFilenameVersions(lNewBCPlusroot			,lversiondate	);
		export StatOverflow							:= versioncontrol.mBuildFilenameVersions(lNewBHStatOroot		,lversiondate	);
		export BDL2       							:= versioncontrol.mBuildFilenameVersions(lNewBHBDLroot			,lversiondate	);
		export Eq_Employer			  			:= versioncontrol.mBuildFilenameVersions(lNewEqEmployerroot	,lversiondate	);
		export AddressSicCode						:= versioncontrol.mBuildFilenameVersions(lNewBHASCroot			,lversiondate	);
		export AddressSicCodeFCRA				:= versioncontrol.mBuildFilenameVersions(lNewBHASCFCRAroot	,lversiondate	);
		export AddressSicCode2					:= versioncontrol.mBuildFilenameVersions(lNewBHASC2root			,lversiondate	);
		
		//////////////////////////////////////////////////////////////////
		// -- Dataset of all Filename Versions
		//////////////////////////////////////////////////////////////////
		export dAll_filenames :=
				Stat.dAll_filenames				
			+ Search.dAll_filenames
			+ HeaderBest.dAll_filenames
			+ Relatives.dAll_filenames
			+ RelativesGroup.dAll_filenames
			+ Companyname.dAll_filenames
			+ CompanynameAddress.dAll_filenames
			+ CompanynameAddressBroad.dAll_filenames
			+ CompanynamePhone.dAll_filenames
			+ CompanynameFein.dAll_filenames
			+ SuperGroup.dAll_filenames
			+ CompanyWords.dAll_filenames
			+ Bdid.dAll_filenames
			+ PeopleAtWorkStats.dAll_filenames
			+ Contacts.dAll_filenames
			+ ContactsPlus.dAll_filenames
			+ StatOverflow.dAll_filenames
			+ BDL2.dAll_filenames
			+ Eq_Employer.dAll_filenames
			;

	end;
		
	//////////////////////////////////////////////////////////////////
	// -- Output Filenames
	//////////////////////////////////////////////////////////////////
	export Out :=
	module
		shared lNewroot		:= lthor + 'out::business_header::@version@::';

		export lNewBHroot		:= lNewroot + 'search'					;
		export lNewBHBroot	:= lNewroot + 'best'						;
		export lNewBHSroot	:= lNewroot + 'stat'						;
		export lNewBRroot		:= lNewroot + 'relatives'				;
		export lNewBRGroot	:= lNewroot + 'relatives_group'	;
		export lNewPawroot	:= lNewroot + 'employment'			;
		export lNewBCroot		:= lNewroot + 'contacts'				;
					
		//////////////////////////////////////////////////////////////////
		// -- Filename Versions
		//////////////////////////////////////////////////////////////////
		export Search								:= versioncontrol.mBuildFilenameVersions(lNewBHroot		,lversiondate	);
		export HeaderBest						:= versioncontrol.mBuildFilenameVersions(lNewBHBroot	,lversiondate	);
		export Stat									:= versioncontrol.mBuildFilenameVersions(lNewBHSroot	,lversiondate	);
		export Relatives						:= versioncontrol.mBuildFilenameVersions(lNewBRroot		,lversiondate	);
		export RelativesGroup				:= versioncontrol.mBuildFilenameVersions(lNewBRGroot	,lversiondate	);
		export PeopleAtWork					:= versioncontrol.mBuildFilenameVersions(lNewPawroot	,lversiondate	);
		export Contacts							:= versioncontrol.mBuildFilenameVersions(lNewBCroot		,lversiondate	);
																																																
		//////////////////////////////////////////////////////////////////
		// -- Dataset of all Filename Versions
		//////////////////////////////////////////////////////////////////
		export dAll_filenames :=
				Search.dAll_filenames
			+ HeaderBest.dAll_filenames
			+ Stat.dAll_filenames
			+ Relatives.dAll_filenames
			+ RelativesGroup.dAll_filenames
			+ Contacts.dAll_filenames
			;
		
	end;

	export Stat :=
	module
		
		shared lNewroot		:= lthor + 'stats::business_header::@version@::';

		export lNewallroot	:= lNewroot + 'all'					;
		export lNewBHroot		:= lNewroot + 'search'			;
		export lNewSGroot		:= lNewroot + 'super_group'	;
		export lNewBCroot		:= lNewroot + 'contacts'		;
		export lNewBDLroot	:= lNewroot + 'BDL'					;
					
		//////////////////////////////////////////////////////////////////
		// -- Filename Versions
		//////////////////////////////////////////////////////////////////
		export all_files				:= versioncontrol.mBuildFilenameVersions(lNewallroot	,lversiondate	);
		export Search						:= versioncontrol.mBuildFilenameVersions(lNewBHroot		,lversiondate	);
		export SuperGroup				:= versioncontrol.mBuildFilenameVersions(lNewSGroot		,lversiondate	);
		export Contacts					:= versioncontrol.mBuildFilenameVersions(lNewBCroot		,lversiondate	);
		export BDL							:= versioncontrol.mBuildFilenameVersions(lNewBDLroot	,lversiondate	);
																																																
		//////////////////////////////////////////////////////////////////
		// -- Dataset of all Filename Versions
		//////////////////////////////////////////////////////////////////
		export dAll_filenames :=
				Search.dAll_filenames
			+ SuperGroup.dAll_filenames
			+ Contacts.dAll_filenames
			+ all_files.dAll_filenames
			+ BDL.dAll_filenames
			;
		
	end;

	//////////////////////////////////////////////////////////////////
	// -- Dataset of all Filename Versions(Base and Output)
	//////////////////////////////////////////////////////////////////
	export dAll_filenames :=
			Base.dAll_filenames
//		+ Out.dAll_filenames
		+ Stat.dAll_filenames
		;

	
end;