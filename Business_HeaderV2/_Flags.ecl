import _control, VersionControl;

export _Flags :=
module

	export IsTesting					:= VersionControl._Flags.IsDataland	;
	export IsCollapsingBdids	:= true															;
	
	export Building :=
	module
		export Initialize	:= false;
		export ResetBdids	:= false;
		export NoUpdates	:= true; 
	end;
	
	export Out :=
	module
	
		export ShouldFilter := true;

	end;

end;