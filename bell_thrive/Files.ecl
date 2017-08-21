import tools,dnb;
export Files(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lfns := Filenames(pversion,pUseOtherEnvironment);
	
	tools.mac_FilesInput(lfns.Input	,layouts.Input.Sprayed	,Input	,'CSV',pHeading := 1);
	tools.mac_FilesBase	(lfns.Base	,layouts.Base						,Base		);

end;
