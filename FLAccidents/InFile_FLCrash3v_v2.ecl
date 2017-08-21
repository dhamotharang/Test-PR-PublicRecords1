flc3v_v2_in := dataset('~thor_data400::in::flcrash3v'
									,FLAccidents.Layout_FLCrash3v_v2, flat);

flc3v_v2_rec := FLAccidents.Layout_FLCrash3v;

flc3v_v2_rec flc3v_convert_to_old(flc3v_v2_in l) := transform
	self := l;
end;

export InFile_FLCrash3v_v2 := project(flc3v_v2_in,flc3v_convert_to_old(left));
