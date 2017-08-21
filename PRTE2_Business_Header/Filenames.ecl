import Business_header, tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion;
	shared lthor				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;
	
	export Input := 
	module
		//////////////////////////////////////////////////////////////////
		// -- Root names
		//////////////////////////////////////////////////////////////////
		shared linputroot		:= lthor + 'in::business_header::@version@::';
		
		export lInputBusHdr			:= linputroot + 'Bus_header'					;
		export lInputBusCont		:= linputroot + 'Bus_Contact'					;
		
		//////////////////////////////////////////////////////////////////
		// -- Filename Versions
		//////////////////////////////////////////////////////////////////
		export InBusHdr		:= tools.mod_FilenamesInput(lInputBusHdr,lversiondate);
		export InBusCont	:= tools.mod_FilenamesInput(lInputBusCont,lversiondate);
		
		//////////////////////////////////////////////////////////////////
		// -- Dataset of all Base Filename Versions
		//////////////////////////////////////////////////////////////////		
		export dAll_filenames := 
					InBusHdr.dAll_filenames
				+	InBusCont.dAll_filenames			
			; 

	end;
	
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
		export Stat											:= tools.mod_FilenamesBuild(lNewBHStatroot		,lversiondate	,'',1);
		export Search										:= tools.mod_FilenamesBuild(lNewBHroot				,lversiondate	,'',1	);
		export HeaderBest								:= tools.mod_FilenamesBuild(lNewBHBroot				,lversiondate	,'',1	);
		export Relatives								:= tools.mod_FilenamesBuild(lNewBRroot				,lversiondate	,'',1	);
		export RelativesGroup						:= tools.mod_FilenamesBuild(lNewBRGroot				,lversiondate	,'',1	);
		export Companyname							:= tools.mod_FilenamesBuild(lNewBHCroot				,lversiondate	,'',1	);
		export CompanynameAddress				:= tools.mod_FilenamesBuild(lNewBHCAroot			,lversiondate	,'',1	);
		export CompanynameAddressBroad	:= tools.mod_FilenamesBuild(lNewBHCABroot			,lversiondate	,'',1	);
		export CompanynamePhone					:= tools.mod_FilenamesBuild(lNewBHCProot			,lversiondate	,'',1	);
		export CompanynameFein					:= tools.mod_FilenamesBuild(lNewBHCFroot			,lversiondate	,'',1	);
		export SuperGroup								:= tools.mod_FilenamesBuild(lNewBHSroot				,lversiondate	,'',1	);
		export CompanyWords							:= tools.mod_FilenamesBuild(lNewBHCNWroot			,lversiondate	,'',1	);
		export Bdid											:= tools.mod_FilenamesBuild(lNewBHBCZFProot		,lversiondate	,'',1	);
		export PeopleAtWorkStats				:= tools.mod_FilenamesBuild(lNewPawroot				,lversiondate	,'',1	);
		export Contacts									:= tools.mod_FilenamesBuild(lNewBCroot				,lversiondate	,'',1	);
		export ContactsPlus							:= tools.mod_FilenamesBuild(lNewBCPlusroot		,lversiondate	,'',1	);
		//export StatOverflow							:= tools.mod_FilenamesBuild(lNewBHStatOroot		,lversiondate	,'',1	);
		export BDL2       							:= tools.mod_FilenamesBuild(lNewBHBDLroot			,lversiondate	,'',1	);
		//export Eq_Employer			  			:= tools.mod_FilenamesBuild(lNewEqEmployerroot,lversiondate	,'',1	);
		export AddressSicCode						:= tools.mod_FilenamesBuild(lNewBHASCroot			,lversiondate	,'',1	);
		export AddressSicCodeFCRA				:= tools.mod_FilenamesBuild(lNewBHASCFCRAroot	,lversiondate	,'',1	);
		export AddressSicCode2					:= tools.mod_FilenamesBuild(lNewBHASC2root		,lversiondate	,'',1	);
		
		//////////////////////////////////////////////////////////////////
		// -- Dataset of all Base Filename Versions
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
			//+ StatOverflow.dAll_filenames
			+ BDL2.dAll_filenames
			//+ Eq_Employer.dAll_filenames
			;
	end;

end;