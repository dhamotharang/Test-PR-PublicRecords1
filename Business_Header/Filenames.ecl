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
		shared lOldroot		:= lthor + 'base::';
		shared lNewroot		:= lthor + 'base::business_header::@version@::';

		export lNewBHStatroot			:= lNewroot + 'stat';
		export lNewBHroot					:= lNewroot + 'search';
		export lNewBHBroot				:= lNewroot + 'best';
		export lNewBRroot					:= lNewroot + 'relatives';
		export lNewBRGroot				:= lNewroot + 'relatives_group';
		export lNewBHCroot				:= lNewroot + 'companyname';
		export lNewBHCAroot				:= lNewroot + 'companyname_address';
		export lNewBHCABroot			:= lNewroot + 'companyname_address_broad';
		export lNewBHCProot				:= lNewroot + 'companyname_phone';
		export lNewBHCFroot				:= lNewroot + 'companyname_fein';
		export lNewBHSroot				:= lNewroot + 'supergroup';
		export lNewBHCNWroot			:= lNewroot + 'co_name_words';
		export lNewBHBCZFProot		:= lNewroot + 'bdid.city.zip.fein.phone';
		export lNewBHASCroot			:= lNewroot + 'address_sic_code';
		export lNewBHASCFCRAroot	:= lNewroot + 'address_sic_code_fcra';
		export lNewBHASC2root			:= lNewroot + 'address_sic_code2';
		export lNewPawroot				:= lNewroot + 'people_at_work_stats';
		export lNewBCroot					:= lNewroot + 'contacts';
		export lNewBCPlusroot			:= lNewroot + 'contacts_Plus';
		export lNewBHStatOroot		:= lNewroot + 'stat_overflow';
		export lNewBHBDLroot		  := lNewroot + 'BDL2';
		export lNewEqEmployerroot	:= lNewroot + 'Eq_Employer';

		shared lOldBHStatroot			:= lOldroot + 'business_header_stat';
		shared lOldBHroot					:= lOldroot + 'business_header';
		shared lOldBHBroot				:= lOldroot + 'business_header.best';
		shared lOldBRroot					:= lOldroot + 'business_relatives';
		shared lOldBRGroot				:= lOldroot + 'business_relatives_group';
		shared lOldBHCroot				:= lOldroot + 'business_header.companyname';
		shared lOldBHCAroot				:= lOldroot + 'business_header.companyname_address';
		shared lOldBHCABroot			:= lOldroot + 'business_header.companyname_address_broad';
		shared lOldBHCProot				:= lOldroot + 'business_header.companyname_phone';
		shared lOldBHCFroot				:= lOldroot + 'business_header.companyname_fein';
		shared lOldBHSroot				:= lOldroot + 'bh_super_group';
		shared lOldBHCNWroot			:= lOldroot + 'bh_co_name_words';
		shared lOldBHBCZFProot		:= lOldroot + 'bh_bdid.city.zip.fein.phone';
		shared lOldBHASCroot			:= lOldroot + 'address_sic_code';
		shared lOldBHASCFCRAroot	:= lOldroot + 'address_sic_code_fcra';
		shared lOldBHASC2root			:= lOldroot + 'address_sic_code2';
		shared lOldPawroot				:= lOldroot + 'people_at_work_stats';
		shared lOldBCroot					:= lOldroot + 'business_contacts';
		shared lOldBCPlusroot			:= lOldroot + 'business_contacts_Plus';
		shared lOldBHStatOroot		:= lOldroot + 'business_header_stat_overflow';
		shared lOldBHBDLroot			:= lOldroot + 'business_header.BDL2';

		//////////////////////////////////////////////////////////////////
		// -- Filename Versions
		//////////////////////////////////////////////////////////////////
		export Stat											:= versioncontrol.mBuildFilenameVersions(lOldBHStatroot		,lversiondate	,lNewBHStatroot			);
		export Search										:= versioncontrol.mBuildFilenameVersions(lOldBHroot				,lversiondate	,lNewBHroot					);
		export HeaderBest								:= versioncontrol.mBuildFilenameVersions(lOldBHBroot			,lversiondate	,lNewBHBroot				);
		export Relatives								:= versioncontrol.mBuildFilenameVersions(lOldBRroot				,lversiondate	,lNewBRroot					);
		export RelativesGroup						:= versioncontrol.mBuildFilenameVersions(lOldBRGroot			,lversiondate	,lNewBRGroot				);
		export Companyname							:= versioncontrol.mBuildFilenameVersions(lOldBHCroot			,lversiondate	,lNewBHCroot				);
		export CompanynameAddress				:= versioncontrol.mBuildFilenameVersions(lOldBHCAroot			,lversiondate	,lNewBHCAroot				);
		export CompanynameAddressBroad	:= versioncontrol.mBuildFilenameVersions(lOldBHCABroot		,lversiondate	,lNewBHCABroot			);
		export CompanynamePhone					:= versioncontrol.mBuildFilenameVersions(lOldBHCProot			,lversiondate	,lNewBHCProot				);
		export CompanynameFein					:= versioncontrol.mBuildFilenameVersions(lOldBHCFroot			,lversiondate	,lNewBHCFroot				);
		export SuperGroup								:= versioncontrol.mBuildFilenameVersions(lOldBHSroot			,lversiondate	,lNewBHSroot				);
		export CompanyWords							:= versioncontrol.mBuildFilenameVersions(lOldBHCNWroot		,lversiondate	,lNewBHCNWroot			);
		export Bdid											:= versioncontrol.mBuildFilenameVersions(lOldBHBCZFProot	,lversiondate	,lNewBHBCZFProot		);
		export AddressSicCode						:= versioncontrol.mBuildFilenameVersions(lOldBHASCroot		,lversiondate	,lNewBHASCroot			);
		export AddressSicCodeFCRA				:= versioncontrol.mBuildFilenameVersions(lOldBHASCFCRAroot,lversiondate	,lNewBHASCFCRAroot	);
		export AddressSicCode2					:= versioncontrol.mBuildFilenameVersions(lOldBHASC2root		,lversiondate	,lNewBHASC2root			);
		export PeopleAtWorkStats				:= versioncontrol.mBuildFilenameVersions(lOldPawroot			,lversiondate	,lNewPawroot				);
		export Contacts									:= versioncontrol.mBuildFilenameVersions(lOldBCroot				,lversiondate	,lNewBCroot					);
		export ContactsPlus							:= versioncontrol.mBuildFilenameVersions(lOldBCPlusroot		,lversiondate	,lNewBCPlusroot			);
		export StatOverflow							:= versioncontrol.mBuildFilenameVersions(lOldBHStatOroot	,lversiondate	,lNewBHStatOroot		);
		export BDL2       							:= versioncontrol.mBuildFilenameVersions(lOldBHBDLroot		,lversiondate	,lNewBHBDLroot		);
		export Eq_Employer			  			:= versioncontrol.mBuildFilenameVersions(lNewEqEmployerroot,lversiondate			);
		
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
			+ AddressSicCode.dAll_filenames
			+ AddressSicCodeFCRA.dAll_filenames
			+ AddressSicCode2.dAll_filenames
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
		shared lOldroot		:= lthor + 'out::';
		shared lNewroot		:= lthor + 'out::business_header::@version@::';

		export lNewBHroot		:= lNewroot + 'search';
		export lNewBHBroot	:= lNewroot + 'best';
		export lNewBHSroot	:= lNewroot + 'stat';
		export lNewBRroot		:= lNewroot + 'relatives';
		export lNewBRGroot	:= lNewroot + 'relatives_group';
		export lNewPawroot	:= lNewroot + 'employment';
		export lNewBCroot		:= lNewroot + 'contacts';
					
		shared lOldBHroot		:= lOldroot + 'business_header';
		shared lOldBHBroot	:= lOldroot + 'business_header_best';
		shared lOldBHSroot	:= lOldroot + 'business_header_stat';
		shared lOldBRroot		:= lOldroot + 'business_relatives';
		shared lOldBRGroot	:= lOldroot + 'business_relatives_group';
		shared lOldPawroot	:= lOldroot + 'employment';
		shared lOldBCroot		:= lOldroot + 'business_contacts';
					
		//////////////////////////////////////////////////////////////////
		// -- Filename Versions
		//////////////////////////////////////////////////////////////////
		export Search								:= versioncontrol.mBuildFilenameVersions(lOldBHroot		,lversiondate	,lNewBHroot		);
		export HeaderBest						:= versioncontrol.mBuildFilenameVersions(lOldBHBroot	,lversiondate	,lNewBHBroot	);
		export Stat									:= versioncontrol.mBuildFilenameVersions(lOldBHSroot	,lversiondate	,lNewBHSroot	);
		export Relatives						:= versioncontrol.mBuildFilenameVersions(lOldBRroot		,lversiondate	,lNewBRroot		);
		export RelativesGroup				:= versioncontrol.mBuildFilenameVersions(lOldBRGroot	,lversiondate	,lNewBRGroot	);
		export PeopleAtWork					:= versioncontrol.mBuildFilenameVersions(lOldPawroot	,lversiondate	,lNewPawroot	);
		export Contacts							:= versioncontrol.mBuildFilenameVersions(lOldBCroot		,lversiondate	,lNewBCroot		);
																																																
		//////////////////////////////////////////////////////////////////
		// -- Dataset of all Filename Versions
		//////////////////////////////////////////////////////////////////
		export dAll_filenames :=
				Search.dAll_filenames
			+ HeaderBest.dAll_filenames
			+ Stat.dAll_filenames
			+ Relatives.dAll_filenames
			+ RelativesGroup.dAll_filenames
			+ PeopleAtWork.dAll_filenames
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
		+ Out.dAll_filenames
		+ Stat.dAll_filenames
		;

	
end;