import tools,LiensV2;

export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).inputliensv2	,Layouts.Input.Layout_Liens_Hogan	,Inputliensv2	);
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input					,Layouts.Input.Layout_Liens_Hogan	,Input				,pOpt := true);
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base					,layouts.Base											,Base					,pOpt := true);

end;