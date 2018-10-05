import tools;

export Files(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= TRUE
) :=
module

	shared lfns := Filenames(pversion,pUseOtherEnvironment);
	
	tools.mac_FilesInput(lfns.Input	,layouts.input		,Input	,'CSV',pHeading := 1,pSeparator := '|',pMaxLength := 650,pTerminator	:= '\n');
	tools.mac_FilesBase	(lfns.Base	,layouts.Base_new			,Base		,pOpt := true);

end;
