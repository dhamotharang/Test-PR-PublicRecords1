import VersionControl;
export Promote(string pversion = '', string pFilter = '') := module
   
	export Input := module
		shared dfilenames			:= Filenames().Input.dAll_templates;
      
		shared inputpromote		:= VersionControl.mPromote.InputFiles(dFilenames);
      
		export Root2Sprayed		:= inputpromote.Root2Sprayed();
		export Sprayed2Using	:= inputpromote.Sprayed2Using;
		export Using2Used			:= inputpromote.Using2Used();
	end;

	shared dfilenames				:= Filenames(pversion).base.dAll_filenames;
	shared basepromote			:= VersionControl.mPromote.BuildFiles2(dfilenames);
   
	export New2Built				:= basepromote.New2Built(pversion);
	export Built2Qa					:= basepromote.Built2Qa;

	export KeyBuild2BH			:= sequential
														 (
															FileServices.RemoveOwnedSubFiles(filenames().Keybuild.BusinessHeader,true)
														 ,FileServices.AddSuperFile(filenames().Keybuild.BusinessHeader,filenames(pversion).keybuild.logical)
														 );
	//export QA2Prod					:= basepromote.QA2Prod;

end;