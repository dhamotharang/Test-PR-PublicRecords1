EXPORT Superfile_List(string st='') := module

	export in_old    := '~nac::in::consortium_old_layout';
	export in        := '~nac::in::consortium';
	export in_history := '~nac::in::consortium_history';
	export Base      := '~nac::base::consortium';
	export Base_prev := '~nac::base::consortium_father';
	export Collisions  := '~nac::out::collisions';
	export temp      := '~nac::in::'+st+'::temp';
	export rejected  := '~nac::in::'+st+'::rejected';
	export Flag      := '~thor_data400::out::NAC_NewHeader_flag';

end;