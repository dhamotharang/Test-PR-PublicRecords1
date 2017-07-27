import VersionControl;
export Promote(string pversion = '') := module
   

    
	shared dfilenames			:=  Filenames(pversion).Base.dAll_filenames
															+	Keynames(pversion).dAll_filenames;
											
	shared basepromote 		:= VersionControl.mPromote.BuildFiles2(dfilenames(),,false);
  export New2Built			:= basepromote.New2Built(pversion);
	export Built2QA				:= basepromote.Built2QA	;
end;