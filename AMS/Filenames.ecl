import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		export Xref                 := tools.mod_FilenamesInput(Template('Xref'                ),pversion);
		export StateLicense         := tools.mod_FilenamesInput(Template('StateLicense'        ),pversion);
		export Specialty            := tools.mod_FilenamesInput(Template('Specialty'           ),pversion);
		export Merges               := tools.mod_FilenamesInput(Template('Merges'              ),pversion);
		export Splits               := tools.mod_FilenamesInput(Template('Splits'              ),pversion);
		export ProviderDemographics := tools.mod_FilenamesInput(Template('ProviderDemographics'),pversion);
		export Degree               := tools.mod_FilenamesInput(Template('Degree'              ),pversion);
		export Credential           := tools.mod_FilenamesInput(Template('Credential'          ),pversion);
		export ProviderAddress      := tools.mod_FilenamesInput(Template('ProviderAddress'     ),pversion);
		export Code                 := tools.mod_FilenamesInput(Template('Code'                ),pversion);
		export Affiliation          := tools.mod_FilenamesInput(Template('Affiliation'         ),pversion);
		export AccountDemographics  := tools.mod_FilenamesInput(Template('AccountDemographics' ),pversion);
		export AccountAddress       := tools.mod_FilenamesInput(Template('AccountAddress'      ),pversion);
		export AccountMerges        := tools.mod_FilenamesInput(Template('AccountMerges'       ),pversion);
		export AccountSplits        := tools.mod_FilenamesInput(Template('AccountSplits'       ),pversion);
		
		export dAll_filenames :=
			Xref.dAll_filenames +
			StateLicense.dAll_filenames +
			Specialty.dAll_filenames +
			Merges.dAll_filenames +
			Splits.dAll_filenames +
			ProviderDemographics.dAll_filenames +
			Degree.dAll_filenames +
			Credential.dAll_filenames +
			ProviderAddress.dAll_filenames +
			Code.dAll_filenames +
			Affiliation.dAll_filenames +
			AccountDemographics.dAll_filenames +
			AccountAddress.dAll_filenames +
			AccountMerges.dAll_filenames +
			AccountSplits.dAll_filenames;
	
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		export Main                 := tools.mod_FilenamesBuild(Template('Main'                ),pversion);
		export StateLicense         := tools.mod_FilenamesBuild(Template('StateLicense'        ),pversion);
		export Specialty            := tools.mod_FilenamesBuild(Template('Specialty'           ),pversion);
		export IDNumber							:= tools.mod_FilenamesBuild(Template('IDNumber'						 ),pversion);
		export Degree               := tools.mod_FilenamesBuild(Template('Degree'              ),pversion);
		export Credential           := tools.mod_FilenamesBuild(Template('Credential'          ),pversion);
		export Affiliation          := tools.mod_FilenamesBuild(Template('Affiliation'         ),pversion);
		
		export dAll_filenames :=
			Main.dAll_filenames +
			StateLicense.dAll_filenames +
			Specialty.dAll_filenames +
			IDNumber.dAll_filenames +
			Degree.dAll_filenames +
			Credential.dAll_filenames +
			Affiliation.dAll_filenames;
	
	end;
	
	export dAll_filenames :=
		Base.dAll_filenames;
 
end;