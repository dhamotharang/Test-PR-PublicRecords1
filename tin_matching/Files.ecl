import tools,dnb;
export Files(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lfns := Filenames(pversion,pUseOtherEnvironment);
	
	export Input := 
	module
		tools.mac_FilesInput(lfns.Input.logs_thor	,layouts.Input.Sprayed	,logs_thor	,'CSV',pHeading := 1,pSeparator := '|');
		tools.mac_FilesInput(lfns.Input.prod_thor	,layouts.Input.Sprayed	,prod_thor	);
	end;


	export Base :=
	module
		tools.mac_FilesBase	(lfns.Base.logs_thor	,layouts.Input.Sprayed	,logs_thor		);
		tools.mac_FilesBase	(lfns.Base.prod_thor	,layouts.Base						,prod_thor		);
	end;

end;
