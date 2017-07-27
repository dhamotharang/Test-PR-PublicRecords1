IMPORT tools;

EXPORT Keynames(STRING pversion = '',
                BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	SHARED lTemplate(STRING tag) :=	_Dataset(pUseOtherEnvironment).KeyTemplate + tag;
	EXPORT lAutoKeyTemplate			 :=	_Dataset(pUseOtherEnvironment).AutoKeyTemplate;

	EXPORT BDID := tools.mod_FilenamesBuild(lTemplate('BDID'), pversion);
	EXPORT CLIA_Number := tools.mod_FilenamesBuild(lTemplate('CLIA_Number'), pversion);
		
	EXPORT autokeyroot := tools.mod_FilenamesBuild(lautokeytemplate, pversion);

	EXPORT dAll_filenames := BDID.dAll_filenames +
		                       CLIA_Number.dAll_filenames;

END;