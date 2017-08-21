// Code originally created by Sandy Butler.
import DriversV2, VersionControl;

export Promote(string pversion = '', string suffix) := module
   
	export Input := module
		shared dfilenames			:= DriversV2.Filenames(,suffix).Input.dAll_templates;
      
		shared inputpromote		:= VersionControl.mPromote.InputFiles(dFilenames);
      
		export Root2Sprayed		:= inputpromote.Root2Sprayed();
		export Sprayed2Using	:= inputpromote.Sprayed2Using;
		export Using2Used			:= inputpromote.Using2Used();
	end;

	shared dfilenames				:= DriversV2.Filenames(pversion,suffix).base.dAll_filenames;
	shared basepromote			:= VersionControl.mPromote.BuildFiles2(dfilenames);
   
	export New2Built				:= basepromote.New2Built(pversion);
	export New2QA						:= basepromote.New2QA(pversion);
	export Built2Qa					:= basepromote.Built2Qa;
      
end;