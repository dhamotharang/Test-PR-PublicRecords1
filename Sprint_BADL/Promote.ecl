import VersionControl;

export Promote(

	string pversion = ''

) :=
module
	
	export Input := 
	module
		shared dfilenames			:= Filenames().Input.dAll_filenames;
		
		shared inputpromote 	:= VersionControl.mPromote.InputFiles2(dFilenames);
		
		export Root2Sprayed		:= inputpromote.Root2Sprayed	();
		export Sprayed2Using	:= inputpromote.Sprayed2Using		;
		export Using2Used			:= inputpromote.Using2Used		();

	end;

	export Base := 
	module

		shared dfilenames		:= Filenames(pversion).base.dAll_filenames;
		shared basepromote 	:= VersionControl.mPromote.BuildFiles2(dfilenames			);
		
		export New2Built				:= basepromote.New2Built			(pversion)	;
		export Built2QA					:= basepromote.Built2QA										;
		export QA2Prod					:= basepromote.QA2Prod										;
		
	end;

end;
