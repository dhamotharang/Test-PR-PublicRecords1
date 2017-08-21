import VersionControl;

export _Flags(string pInput_Name='', string pBase_Name='')  := module

	export IsTesting								:= VersionControl._Flags.IsDataland;

end;
