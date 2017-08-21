import VersionControl, OIG;
export Promote(string pversion = '') := module

	shared dfilenames					:=  OIG.Filenames(pversion).Base.dAll_filenames
																+	OIG.Keynames(pversion).dAll_filenames;
	shared basepromote 				:= VersionControl.mPromote.BuildFiles2(dfilenames(),,false);
	export New2Built					:= basepromote.New2Built(pversion);
	export Built2QA						:= basepromote.Built2QA	;
	
end;