import VersionControl;

export Promote(string pversion = '',string pFilterState = '') :=
module
	
	export Input := 
	module
		shared dfilenames		:= Filenames().Input.dAll_filenames;
		shared filter				:= if(pFilterState = ''	,true
																								,regexfind('::' + pFilterState + '$',dfilenames.templatename, nocase)
													);
		
		shared inputpromote 	:= VersionControl.mPromote.InputFiles2(dFilenames(filter));
		
		export Root2Sprayed		:= inputpromote.Root2Sprayed	();
		export Sprayed2Using	:= inputpromote.Sprayed2Using		;
		export Using2Used			:= inputpromote.Using2Used		();
		export new2sprayed		:= inputpromote.new2sprayed		(pversion);

	end;

	shared dfilenames		:= Filenames(pversion).base.dAll_filenames;
	shared filter				:= if(pFilterState = ''	,true
																							,regexfind('::' + pFilterState + '$',dfilenames.templatename, nocase)
												);

	shared basepromote 			:= VersionControl.mPromote.BuildFiles2(dFilenames(filter));
	
	export New2Built				:= basepromote.New2Built			(pversion)	;
	export Built2Qa					:= basepromote.Built2Qa2Delete						;
	export QA2Prod					:= basepromote.QA2Prod										;

end;
