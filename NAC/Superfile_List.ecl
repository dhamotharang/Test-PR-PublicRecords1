EXPORT Superfile_List(string st='') := module

	export in_old    := '~nac::in::consortium_old_layout';
	export in        := '~nac::in::consortium';
	export Base      := '~nac::base::consortium';
	export Base_prev := '~nac::base::consortium_father';
	export All_Coll  := '~nac::out::collisions';
	export State_Coll:= '~nac::out::'+st;
	export State_Coll_History := '~nac::out::'+st+'_history';
	export temp      := '~nac::in::'+st+'::temp';
	export rejected  := '~nac::in::'+st+'::rejected';

end;