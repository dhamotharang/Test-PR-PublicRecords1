import VersionControl;

export Promote(string pversion = '') :=
module
	
	export Base := 
	module

		shared dfilenames		:= Filenames(pversion).base.dAll_filenames;
		shared basepromote 	:= VersionControl.mPromote.BuildFiles2(dfilenames			);
		
		export New2Building			:= basepromote.New2Building		(pversion)	;
		export New2Built				:= basepromote.New2Built			(pversion)	;
		export Building2Built		:= basepromote.Building2Built							;
		export Built2Qa2Delete	:= basepromote.Built2Qa2Delete						;
		export Built2QA2Father	:= basepromote.Built2QA2Father						;
		export Built2QA					:= basepromote.Built2QA										;
		export QA2Prod					:= basepromote.QA2Prod										;
		
	end;
	
	export Built2Qa2Delete :=
	sequential(
		 Base.Built2Qa2Delete
	);

	export Built2QA2Father :=
	sequential(
		 Base.Built2QA2Father
	);

	export Built2QA :=
	sequential(
		 Base.Built2QA
	);

	export QA2Prod :=
	sequential(
		 Base.QA2Prod
	);

end;
