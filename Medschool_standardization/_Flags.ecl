import  VersionControl;


export _Flags(string pInput_Name='', string pBase_Name='')  := module
	export IsTesting								:= VersionControl._Flags.IsDataland;
	export UseStandardizePersists		:= not IsTesting; // for bug 26170 -- Missing dependency from persist to stored
end;

