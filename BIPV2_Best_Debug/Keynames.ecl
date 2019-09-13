IMPORT  tools;
EXPORT Keynames(
  STRING    pversion              = ''
  ,BOOLEAN  pUseOtherEnvironment  = FALSE
) :=
MODULE
  SHARED  lkeyTemplate  := _Constants(pUseOtherEnvironment).keyTemplate;
	EXPORT  LinkIds       :=  tools.mod_FilenamesBuild(lkeyTemplate		+ 'linkIds'			,pversion);
	
	export dAll_filenames := 
	LinkIds.dAll_filenames 
  ;
END;