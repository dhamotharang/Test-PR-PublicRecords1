import _control, VersionControl;

export _Flags(string pInput_Name='', string pBase_Name='')  := module
	
	export IsTesting								:= true;
	export UseStandardizePersists		:= not IsTesting;
	export IsUpdateFullFile					:= false;
	
end;

