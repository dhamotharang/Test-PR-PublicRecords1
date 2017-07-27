IMPORT tools;

EXPORT Keynames(STRING pversion = '',
                BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	SHARED lTemplate(STRING tag) :=	_Dataset(pUseOtherEnvironment).KeyTemplate + tag;
	EXPORT lAutoKeyTemplate			 :=	_Dataset(pUseOtherEnvironment).AutoKeyTemplate;

	EXPORT LicenseNumber := tools.mod_FilenamesBuild(lTemplate('License_Number'), pversion);
	EXPORT LicenseState  := tools.mod_FilenamesBuild(lTemplate('License_State'), pversion);
		
	EXPORT autokeyroot := tools.mod_FilenamesBuild(lautokeytemplate, pversion);

	EXPORT dAll_filenames := LicenseNumber.dAll_filenames +
	                         LicenseState.dAll_filenames;

END;