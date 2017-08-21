import _control, VersionControl;

export _Flags(string pInput_Name='', string pBase_Name='')  := module
	export IsTesting								:= VersionControl._Flags.IsDataland;
	export UseStandardizePersists		:= not IsTesting;
	export IsUpdateFullFile					:= false;
end;

