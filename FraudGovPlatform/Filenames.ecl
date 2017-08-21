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
		
		export _IdentityDataPassed		:=  FileSprayed+'::Passed::IdentityData';
		export _IdentityDataRejected 	:=  FileSprayed+'::Rejected::IdentityData';
		export IdentityData	:=  _IdentityDataPassed;
		
		export _KnownFraudPassed			:=  FileSprayed+'::Passed::KnownFraud';  
		export _KnownFraudRejected 		:=  FileSprayed+'::Rejected::KnownFraud';
		export KnownFraud	:=  _KnownFraudPassed;
		
	end;
	
	
	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		export IdentityData                  				:= tools.mod_FilenamesInput(Template('IdentityData'),pversion);
		export KnownFraud                  				 	:= tools.mod_FilenamesInput(Template('KnownFraud'),pversion);
		export ByPassed_IdentityData								:= tools.mod_FilenamesInput(Template('ByPassed_IdentityData'),pversion);
		export ByPassed_KnownFraud									:= tools.mod_FilenamesInput(Template('ByPassed_KnownFraud'),pversion);

		export dAll_filenames :=
			IdentityData.dAll_filenames +
			KnownFraud.dAll_filenames +
			ByPassed_IdentityData.dAll_filenames +
			ByPassed_KnownFraud.dAll_filenames;
			
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		export IdentityData                 := tools.mod_FilenamesBuild(Template('IdentityData' ),pversion);
		export KnownFraud                  	:= tools.mod_FilenamesBuild(Template('KnownFraud' ),pversion);

		export dAll_filenames :=
			IdentityData.dAll_filenames +
			KnownFraud.dAll_filenames;
	
	end;
	
	export dAll_filenames :=
		Base.dAll_filenames;
 
end;