import tools;

export _Flags :=
tools.Flags(
	 pExistCurrentSprayed			:= Exists(nothor(fileservices.superfilecontents(filenames().input.using		))) or Exists(nothor(fileservices.superfilecontents(filenames().input.sprayed		)))
	,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.qa				)))
	,pIsUpdateFullFile				:= true
	,pShouldFilter						:= true
);
