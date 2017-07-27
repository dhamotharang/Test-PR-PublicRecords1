import ut;
export Files(string st='') := module;

	export load_in   := DATASET(Superfile_List(st).in,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);
	export load_in_old  := DATASET(Superfile_List(st).in_old,{string75 fn { virtual(logicalfilename)},Layouts.load_old}, THOR);
	export Base      := DATASET(Superfile_List(st).Base,Layouts.base, THOR, opt);
	export Base_prev := DATASET(Superfile_List(st).Base_prev,Layouts.base, THOR);
	export All_Coll  := DATASET(Superfile_List(st).All_Coll,Layouts.Collisions, THOR);
	export State_Coll:= DATASET(Superfile_List(st).State_Coll,Layouts.Collisions, THOR);
	export State_Coll_History := DATASET(Superfile_List(st).State_Coll_History,Layouts.Collisions, THOR);
	export temp      := DATASET(Superfile_List(st).temp,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);
	export rejected  := DATASET(Superfile_List(st).rejected,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);

end;