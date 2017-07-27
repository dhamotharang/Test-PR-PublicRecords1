import VersionControl;

export Promote(string pversion = '') := module

	shared dfilenames				:= Filenames(pversion).base.dAll_filenames;
	shared basepromote			:= VersionControl.mPromote.BuildFiles2(dfilenames);
  export New2Built				:= basepromote.New2Built(pversion);
	export Built2Qa					:= basepromote.Built2Qa;
      
end;