import VersionControl;

export Promote(string pversion = '',string pFilterState = '') :=
module
	
	export Input := 
	module
		shared dfilenames		:= Filenames().Input.dAll_filenames;
		shared filter				:= if( pFilterState = ''	,true
										  ,regexfind('::' + pFilterState + '$',dfilenames.templatename)
										  );
		
		shared inputpromote 	:= VersionControl.mPromote.InputFiles2(dFilenames(filter));
		
		export Root2Sprayed		:= inputpromote.Root2Sprayed	();
		export Sprayed2Using	:= inputpromote.Sprayed2Using		;
		export Using2Used			:= inputpromote.Using2Used		();

	end;

	shared dfilenames		:= Filenames(pversion).base.dAll_filenames;
	shared filter				:= if( pFilterState = ''	,true
										,regexfind('::' + pFilterState + '$',dfilenames.templatename)
										);

	shared basepromote 			:= VersionControl.mPromote.BuildFiles2(dFilenames(filter));
	
	export New2Building			:= basepromote.New2Building		(pversion)	;
	export New2Built				:= basepromote.New2Built			(pversion)	;
	export Building2Built		:= basepromote.Building2Built							;
	export Built2Qa2Delete	:= basepromote.Built2Qa2Delete						;
	export Built2QA2Father	:= basepromote.Built2QA2Father						;
	export QA2Prod					:= basepromote.QA2Prod										;

end;
