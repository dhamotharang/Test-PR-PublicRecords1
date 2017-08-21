import VersionControl;
export Promote(string pversion = '', string bldType = '') := module

	shared dfilenames			:= if (bldType='E',
																	Filenames(pversion).Experian.base.dAll_filenames,
																	Filenames(pversion).Florida.base.dAll_filenames
															);
	shared basepromote		:= VersionControl.mPromote.BuildFiles2(dfilenames);
   
	export New2Built			:= basepromote.New2Built(pversion);
	export Built2Qa				:= basepromote.Built2Qa;
     
end;