IMPORT tools;

EXPORT Keynames(STRING pversion = '',
                BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	SHARED lTemplate(STRING tag) :=	_Dataset(pUseOtherEnvironment).KeyTemplate + tag;
	EXPORT lAutoKeyTemplate			 :=	_Dataset(pUseOtherEnvironment).AutoKeyTemplate;

	EXPORT SSNCustID := tools.mod_FilenamesBuild(lTemplate('SSN_Customer_ID'), pversion);
	EXPORT DIDCustID := tools.mod_FilenamesBuild(lTemplate('DID_Customer_ID'), pversion);
		
	EXPORT autokeyroot := tools.mod_FilenamesBuild(lautokeytemplate, pversion);

	EXPORT dAll_filenames := SSNCustID.dAll_filenames +
	                         DIDCustID.dAll_filenames;

END;