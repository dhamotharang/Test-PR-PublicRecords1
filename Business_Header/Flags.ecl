import VersionControl;

export Flags :=
module

	export IsTesting 						:= VersionControl._Flags.IsDataland;
	export ShouldCollapseBdids	:= true; 
	export ShouldUseNewCodes		:= true; 
	
	export Building :=
	module
		export Initialize	:= false;
		export ResetBdids	:= false;
		export NoUpdates	:= false; 
	end;
	
	export Out :=
	module
	
		export ShouldFilter := true;

	end;

end;