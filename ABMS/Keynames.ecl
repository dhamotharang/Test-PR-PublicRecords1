IMPORT tools;

EXPORT Keynames(STRING pversion = '',
                BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	SHARED lTemplate(STRING tag) :=	_Dataset(pUseOtherEnvironment).KeyTemplate + tag;
	EXPORT lAutoKeyTemplate			 :=	_Dataset(pUseOtherEnvironment).AutoKeyTemplate;

  EXPORT Main := MODULE
		SHARED fTemplate(STRING tag) := lTemplate('Main') + '::' + tag;

		EXPORT BIOGNumber := tools.mod_FilenamesBuild(fTemplate('BIOG_Number'), pversion);
		EXPORT DID := tools.mod_FilenamesBuild(fTemplate('DID'), pversion);
		EXPORT BDID := tools.mod_FilenamesBuild(fTemplate('BDID'), pversion);
		EXPORT NPI := tools.mod_FilenamesBuild(fTemplate('NPI'), pversion);
		EXPORT LNameSpecialtyFName := tools.mod_FilenamesBuild(fTemplate('LName_Specialty_FName'), pversion);
		EXPORT LNameCertFName := tools.mod_FilenamesBuild(fTemplate('LName_Cert_FName'), pversion);

		EXPORT dAll_filenames := BIOGNumber.dAll_filenames +
		                         DID.dAll_filenames +
		                         BDID.dAll_filenames +
		                         NPI.dAll_filenames +
														 LNameSpecialtyFName.dAll_filenames +
														 LNameCertFName.dAll_filenames;
	END;

  EXPORT Career := MODULE
		SHARED fTemplate(STRING tag) := lTemplate('Career') + '::' + tag;
		EXPORT BIOGNumber := tools.mod_FilenamesBuild(fTemplate('BIOG_Number'), pversion);
		EXPORT dAll_filenames := BIOGNumber.dAll_filenames;
	END;

  EXPORT Cert := MODULE
		SHARED fTemplate(STRING tag) := lTemplate('Cert') + '::' + tag;
		EXPORT BIOGNumber := tools.mod_FilenamesBuild(fTemplate('BIOG_Number'), pversion);
		EXPORT dAll_filenames := BIOGNumber.dAll_filenames;
	END;

  EXPORT Education := MODULE
		SHARED fTemplate(STRING tag) := lTemplate('Education') + '::' + tag;
		EXPORT BIOGNumber := tools.mod_FilenamesBuild(fTemplate('BIOG_Number'), pversion);
		EXPORT dAll_filenames := BIOGNumber.dAll_filenames;
	END;

  EXPORT Membership := MODULE
		SHARED fTemplate(STRING tag) := lTemplate('Membership') + '::' + tag;
		EXPORT BIOGNumber := tools.mod_FilenamesBuild(fTemplate('BIOG_Number'), pversion);
		EXPORT dAll_filenames := BIOGNumber.dAll_filenames;
	END;

  EXPORT TypeOfPractice := MODULE
		SHARED fTemplate(STRING tag) := lTemplate('TypeOfPractice') + '::' + tag;
		EXPORT BIOGNumber := tools.mod_FilenamesBuild(fTemplate('BIOG_Number'), pversion);
		EXPORT dAll_filenames := BIOGNumber.dAll_filenames;
	END;

  EXPORT Lookups := MODULE
		SHARED fTemplate(STRING tag) := lTemplate('Lookups') + '::' + tag;
		EXPORT Specialty := tools.mod_FilenamesBuild(fTemplate('Specialty'), pversion);
		EXPORT dAll_filenames := Specialty.dAll_filenames;
	END;

	EXPORT autokeyroot := tools.mod_FilenamesBuild(lAutoKeyTemplate, pversion);

	EXPORT dAll_filenames := Main.dAll_filenames +
	                         Career.dAll_filenames +
	                         Cert.dAll_filenames +
	                         Education.dAll_filenames +
	                         Membership.dAll_filenames +
	                         TypeOfPractice.dAll_filenames +
													 Lookups.dAll_filenames;

END;