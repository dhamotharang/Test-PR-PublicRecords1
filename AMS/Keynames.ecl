import tools;

export Keynames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	shared lTemplate(string tag)	:=	_Dataset(pUseOtherEnvironment).KeyTemplate + tag;
	export lAutoKeyTemplate				:=	_Dataset(pUseOtherEnvironment).AutoKeyTemplate;
	
	export Main := module
		shared fTemplate(string tag) := lTemplate('Main') + '::' + tag;
		export AMSID := tools.mod_FilenamesBuild(fTemplate('AMSID'),pversion);
		export DID := tools.mod_FilenamesBuild(fTemplate('DID'),pversion);
		export BDID := tools.mod_FilenamesBuild(fTemplate('BDID'),pversion);
		export LinkIds := tools.mod_FilenamesBuild(fTemplate('LINKIDS'),pversion);
		export TaxID := tools.mod_FilenamesBuild(fTemplate('TAXID'),pversion);
		export NPI := tools.mod_FilenamesBuild(fTemplate('NPI'),pversion);
		export LicenseNumberState := tools.mod_FilenamesBuild(fTemplate('License_Number_State'),pversion);
		export LicenseNumber := tools.mod_FilenamesBuild(fTemplate('License_Number'),pversion);
		export LicenseState := tools.mod_FilenamesBuild(fTemplate('License_State'),pversion);
		export LNPID := tools.mod_FilenamesBuild(fTemplate('LNPID'),pversion);
		export dAll_filenames :=
			  AMSID.dAll_filenames +
				DID.dAll_filenames +
				BDID.dAll_filenames +
				LinkIds.dAll_filenames +
				TaxID.dAll_filenames +
				NPI.dAll_filenames +
				LicenseNumberState.dAll_filenames +
				LicenseNumber.dAll_filenames +
				LicenseState.dAll_filenames +
				LNPID.dAll_filenames;
	end;
	
	export StateLicense := module
		shared fTemplate(string tag) := lTemplate('StateLicense') + '::' + tag;
		export AMSID := tools.mod_FilenamesBuild(fTemplate('AMSID'),pversion);
		export dAll_filenames :=
			  AMSID.dAll_filenames;
	end;
	
	export Specialty := module
		shared fTemplate(string tag) := lTemplate('Specialty') + '::' + tag;
		export AMSID := tools.mod_FilenamesBuild(fTemplate('AMSID'),pversion);
		export dAll_filenames :=
			  AMSID.dAll_filenames;
	end;
	
	export IDNumber := module
		shared fTemplate(string tag) := lTemplate('IDNumber') + '::' + tag;
		export AMSID := tools.mod_FilenamesBuild(fTemplate('AMSID'),pversion);
		export dAll_filenames :=
			  AMSID.dAll_filenames;
	end;
	
	export Degree := module
		shared fTemplate(string tag) := lTemplate('Degree') + '::' + tag;
		export AMSID := tools.mod_FilenamesBuild(fTemplate('AMSID'),pversion);
		export dAll_filenames :=
			  AMSID.dAll_filenames;
	end;
	
	export Credential := module
		shared fTemplate(string tag) := lTemplate('Credential') + '::' + tag;
		export AMSID := tools.mod_FilenamesBuild(fTemplate('AMSID'),pversion);
		export dAll_filenames :=
			  AMSID.dAll_filenames;
	end;
	
	export Affiliation := module
		shared fTemplate(string tag) := lTemplate('Affiliation') + '::' + tag;
		export AMSID := tools.mod_FilenamesBuild(fTemplate('AMSID'),pversion);
		export dAll_filenames :=
			  AMSID.dAll_filenames;
	end;
	
	export autokeyroot			:= tools.mod_FilenamesBuild(lautokeytemplate												,pversion);

	export dAll_filenames :=
		  Main.dAll_filenames
		+ StateLicense.dAll_filenames
		+ Specialty.dAll_filenames
		+ IDNumber.dAll_filenames
		+ Degree.dAll_filenames
		+ Credential.dAll_filenames
		+ Affiliation.dAll_filenames
		;

end;