import tools;
export _Flags :=
	tools.Flags(
		 pExistCurrentSprayed			:= Exists(nothor(fileservices.superfilecontents(filenames().input.using	)))
		,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.qa			)))
		,pIsUpdateFullFile				:= true
		,pShouldFilter						:= true
		,pUseStandardizePersists 	:= not _Constants().IsTesting
	);
