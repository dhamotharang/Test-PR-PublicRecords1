import tools;
export _Flags :=
module

	export logs_thor := 
	tools.Flags(
		 pExistCurrentSprayed			:= Exists(nothor(fileservices.superfilecontents(filenames().input.logs_thor.using	)))
		,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.logs_thor.qa			)))
		,pIsUpdateFullFile				:= true
		,pShouldFilter						:= true
		,pUseStandardizePersists 	:= not _Constants().IsTesting
	);

	export prod_thor := 
	tools.Flags(
		 pExistCurrentSprayed			:= Exists(nothor(fileservices.superfilecontents(filenames().input.prod_thor.using	)))
		,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.prod_thor.qa			)))
		,pIsUpdateFullFile				:= true
		,pShouldFilter						:= true
		,pUseStandardizePersists 	:= not _Constants().IsTesting
	);

end;