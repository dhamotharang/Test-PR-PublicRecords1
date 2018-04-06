import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Sprayed Filename Versions
	//////////////////////////////////////////////////////////////////
	export Sprayed := module
		export FileSprayed 	:= 	_Dataset().thor_cluster_Files +'in::'+_Dataset().Name;
		
		export _IdentityDataPassed := FileSprayed+'::Passed::IdentityData';
		export _IdentityDataRejected := FileSprayed+'::Rejected::IdentityData';
		export IdentityData	:= _IdentityDataPassed;
		
		export _KnownFraudPassed := FileSprayed+'::Passed::KnownFraud';  
		export _KnownFraudRejected := FileSprayed+'::Rejected::KnownFraud';
		export KnownFraud	:= _KnownFraudPassed;

		export _DeltabasePassed := FileSprayed+'::Passed::Deltabase';  
		export _DeltabaseRejected := FileSprayed+'::Rejected::Deltabase';
		export Deltabase := _DeltabasePassed;	
		
		export _NACPassed := FileSprayed+'::Passed::NAC';  
		export _NACRejected := FileSprayed+'::Rejected::NAC';
		export NAC := _NACPassed;	
		
		export _InquiryLogsPassed := FileSprayed+'::Passed::InquiryLogs';  
		export _InquiryLogsRejected := FileSprayed+'::Rejected::InquiryLogs';
		export InquiryLogs := _InquiryLogsPassed;		
		
	end;
	
	
	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		export IdentityData                  			:= tools.mod_FilenamesInput(Template('IdentityData'),pversion);
		export KnownFraud                  			:= tools.mod_FilenamesInput(Template('KnownFraud'),pversion);
		
		export ByPassed_IdentityData						:= tools.mod_FilenamesInput(Template('ByPassed_IdentityData'),pversion);
		export ByPassed_KnownFraud							:= tools.mod_FilenamesInput(Template('ByPassed_KnownFraud'),pversion);
		
		export AddressCache_IDDT								:= tools.mod_FilenamesInput(Template('AddressCache_IDDT'),pversion);
		export AddressCache_KNFD								:= tools.mod_FilenamesInput(Template('AddressCache_KNFD'),pversion);
		
		export dAll_filenames :=
			IdentityData.dAll_filenames +
			KnownFraud.dAll_filenames +
			ByPassed_IdentityData.dAll_filenames +
			ByPassed_KnownFraud.dAll_filenames + 
			AddressCache_IDDT.dAll_filenames + 
			AddressCache_KNFD.dAll_filenames;
			
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;

		export IdentityData := tools.mod_FilenamesBuild(Template('IdentityData'),pversion);
		export KnownFraud 	:= tools.mod_FilenamesBuild(Template('KnownFraud'),pversion);
		export AddressCache	:= tools.mod_FilenamesBuild(Template('AddressCache'),pversion);

		export dAll_filenames :=
			IdentityData.dAll_filenames +
			KnownFraud.dAll_filenames +
			AddressCache.dAll_filenames; 
	
	end;
	
	export dAll_filenames :=
		Base.dAll_filenames;
 
end;