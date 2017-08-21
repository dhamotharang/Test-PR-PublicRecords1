import tools;

export Files(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lfns := Filenames(pversion,pUseOtherEnvironment);
	
	export Input := 
	module

		export Companies	  := tools.macf_FilesInput	(lfns.input.Companies ,layouts.Input.Sprayed,'CSV','','/>','',0,_Constants().max_record_size);
		export Contacts		  := tools.macf_FilesInput	(lfns.input.Contacts	,layouts.Input.Sprayed,'CSV','','/>','',0,_Constants().max_record_size);
//		export MergerAcquis := tools.macf_FilesInput(lfns.Input.MergerAcquis	,layouts.input.MergerAcquis	,'CSV',pHeading := 1,pSeparator := '\t'	,pMaxLength := _Constants().max_record_size,pTerminator	:= '\r\n'	);

	end;
	
	export Base :=
	module

		export Companies	  := tools.macf_FilesBase	(lfns.Base.Companies	,layouts.Base.companies	,,,_Constants().max_record_size,true);
		export Contacts		  := tools.macf_FilesBase	(lfns.Base.Contacts		,layouts.Base.contacts	,,,_Constants().max_record_size,true);

	end;
	
end;
