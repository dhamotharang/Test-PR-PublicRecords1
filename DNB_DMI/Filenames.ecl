import business_header, tools;
export Filenames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pDatasetName					= 'DNB_DMI'
) :=
module

	shared lversiondate	:= pversion														;

	shared lInputRoot				:= _Constants(pUseOtherEnvironment,pDatasetName).InputTemplate	+ 'data'			;
	shared lInputCompRoot		:= _Constants(pUseOtherEnvironment,pDatasetName).InputTemplate	+ 'companies'	;
	shared lInputContRoot		:= _Constants(pUseOtherEnvironment,pDatasetName).InputTemplate	+ 'contacts'	;
	shared lCompaniesRoot		:= _Constants(pUseOtherEnvironment,pDatasetName).FileTemplate	+ 'Companies'	;
	shared lContactsRoot		:= _Constants(pUseOtherEnvironment,pDatasetName).FileTemplate	+ 'Contacts'	;
	shared lV1CompaniesRoot	:= _Constants(pUseOtherEnvironment,pDatasetName).OldFileTemplate	+ '_Companies'	;
	shared lV1ContactsRoot	:= _Constants(pUseOtherEnvironment,pDatasetName).OldFileTemplate	+ '_Contacts'	;

	export Input := 
	module

		export Raw 						:= tools.mod_FilenamesInput(lInputRoot			,lversiondate);
		export Oldcompanies		:= tools.mod_FilenamesInput(lInputCompRoot	,lversiondate);	//old DNB V1 input files
		export Oldcontacts		:= tools.mod_FilenamesInput(lInputContRoot	,lversiondate);	//old DNB V1 input files

		export dAll_filenames := 
				Raw.dAll_filenames
			+ Oldcompanies.dAll_filenames
			+ Oldcontacts.dAll_filenames
			; 
	end;
	
	export Base :=
	module
	
		export Companies			:= tools.mod_FilenamesBuild(lCompaniesRoot	,lversiondate);
		export Contacts				:= tools.mod_FilenamesBuild(lContactsRoot	 	,lversiondate);

	end;
	
	export V1 :=
	module
	
		export Companies			:= tools.mod_FilenamesBuild(lV1CompaniesRoot	,lversiondate);
		export Contacts				:= tools.mod_FilenamesBuild(lV1ContactsRoot	 	,lversiondate);

	end;

	export dAll_filenames := 
			Base.Companies.dAll_filenames
		+ Base.Contacts.dAll_filenames
		; 
end;
