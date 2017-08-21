import tools;

export _Flags :=
module
	export Companies := tools.Flags(
		 pExistCurrentSprayed			:= Exists(nothor(fileservices.superfilecontents(filenames().input.raw.using				)))
		,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.companies.qa	)))
		,pIsUpdateFullFile				:= true
		,pShouldFilter						:= true
		,pUseStandardizePersists 	:= not _Constants().IsTesting
	);
	export Contacts := tools.Flags(
		 pExistCurrentSprayed			:= Exists(nothor(fileservices.superfilecontents(filenames().input.raw.using				)))
		,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.contacts.qa	)))
		,pIsUpdateFullFile				:= true
		,pShouldFilter						:= true
		,pUseStandardizePersists 	:= not _Constants().IsTesting
	);
end;