import VersionControl, tools;

export _Flags :=
tools.Flags(
   pExistCurrentSprayed	 := Exists(nothor(fileservices.superfilecontents(TXBUS.Constants.Cleaned_name)))
	,pExistBaseFile				 := Exists(nothor(fileservices.superfilecontents(TXBUS.Constants.Base_name)))
	,pIsUpdateFullFile		 := true
	,pShouldFilter				 := true
 );
 