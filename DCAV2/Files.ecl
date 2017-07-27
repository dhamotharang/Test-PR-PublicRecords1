import tools;
export Files(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lfns := Filenames(pversion,pUseOtherEnvironment);
	
	export Input := 
	module
		export int					:= tools.macf_FilesInput(lfns.Input.int						,layouts.input.sprayed			,'CSV'							,pSeparator := '\t'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\n'		);
		export prv					:= tools.macf_FilesInput(lfns.Input.prv						,layouts.input.sprayed			,'CSV'							,pSeparator := '\t'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\n'		);
		export pub					:= tools.macf_FilesInput(lfns.Input.pub						,layouts.input.sprayed			,'CSV'							,pSeparator := '\t'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\n'		);
		export privco				:= tools.macf_FilesInput(lfns.Input.privco				,layouts.input.sprayed			,'CSV',pHeading := 1,pSeparator := '\t'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\n'	  );
		export affpeople		:= tools.macf_FilesInput(lfns.Input.affpeople			,layouts.input.affpeople		,'CSV',pHeading := 1,pSeparator := '|'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\r\n'	);
		export affboards		:= tools.macf_FilesInput(lfns.Input.affboards			,layouts.input.affboards		,'CSV',pHeading := 1,pSeparator := '|'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\r\n'	);
		export affPositions	:= tools.macf_FilesInput(lfns.Input.affPositions	,layouts.input.affPositions	,'CSV',pHeading := 1,pSeparator := '|'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\r\n'	);
		export killReport		:= tools.macf_FilesInput(lfns.Input.killReport		,layouts.input.killReport		,'CSV',pHeading := 1,pSeparator := '\t'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\r\n'	);
		export MergerAcquis := tools.macf_FilesInput(lfns.Input.MergerAcquis	,layouts.input.MergerAcquis	,'CSV',pHeading := 1,pSeparator := '\t'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\r\n'	);
	end;
	
	export Base :=
	module
		export Companies	  := tools.macf_FilesBase	(lfns.Base.Companies	,layouts.Base.companies	,pOpt := true);
		export Contacts		  := tools.macf_FilesBase	(lfns.Base.Contacts		,layouts.Base.contacts	,pOpt := true);
	end;
	
end;
