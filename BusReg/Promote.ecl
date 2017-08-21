import VersionControl;

export Promote(

	 string		pversion	= ''
	,string		pFilter		= ''
	,boolean	pDelete		= false

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


	shared dfilenames		:=  Filenames				(pversion).dAll_filenames
												+ Keynames				(pversion).dAll_filenames
												;
												
	shared filter				:= if(pFilter = ''	,true
																					,regexfind(pFilter,dfilenames.templatename,nocase)
												);
												
	shared basepromote 	:= VersionControl.mPromote.BuildFiles2(dfilenames(filter),,pDelete);

	export New2Built							:= basepromote.New2Built			(pversion)	;
	export New2Root								:= basepromote.New2Root				(pversion)	;
	export Built2QA								:= basepromote.Built2QA										;
	export QA2Prod								:= basepromote.QA2Prod										;
	export VersionIntegrityCheck	:= basepromote.VersionIntegrityCheck			;

end;
