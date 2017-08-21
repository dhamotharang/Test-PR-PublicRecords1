import VersionControl;

export Promote(string pversion = '', string psuffix = '') := module
 
	export Input := module
		shared dfilenames			:= Filenames(psuffix,).Input.dAll_templates;
		shared inputpromote		:= VersionControl.mPromote.InputFiles(dFilenames);     
		export Root2Sprayed		:= inputpromote.Root2Sprayed();
		export Sprayed2Using	:= inputpromote.Sprayed2Using;
		export Using2Used			:= inputpromote.Using2Used();
	end;

	shared bfilenames				:= Filenames(psuffix,pversion).base.dAll_filenames;
	shared basepromote			:= VersionControl.mPromote.BuildFiles2(bfilenames);
   
	export New2Built				:= basepromote.New2Built(pversion);
	export Built2Qa					:= basepromote.Built2Qa;
//export QA2Prod					:= basepromote.QA2Prod;
      
end;