import VersionControl;
export Promote(string pversion = '', string pFilter = '') := module
   
	export Input := module
		shared dfilenames		:= Filenames().Input.dAll_templates;
      
		shared inputpromote		:= VersionControl.mPromote.InputFiles(dFilenames);
      
		export Root2Sprayed		:= inputpromote.Root2Sprayed();
		export Sprayed2Using	:= inputpromote.Sprayed2Using;
		export Using2Used		:= inputpromote.Using2Used();
	end;

	
   shared dfilenames			:= Filenames(pversion).Base.dAll_filenames
												+ Keynames(pversion).dAll_filenames;
	shared basepromote 			:= VersionControl.mPromote.BuildFiles2(dfilenames(),,false);
	export New2Built			:= basepromote.New2Built(pversion);
	export Built2QA				:= basepromote.Built2QA	;
end;