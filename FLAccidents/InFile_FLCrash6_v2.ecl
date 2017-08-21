flc6_v2_in := dataset('~thor_data400::in::flcrash6'
						,FLAccidents.Layout_FLCrash6_v2, flat);

flc6_v2_rec := FLAccidents.Layout_temp.flcrash6 ;//FLAccidents.Layout_FLCrash6;

flc6_v2_rec flc6_convert_to_old(flc6_v2_in l) := transform
	self := l;
end;

export InFile_FLCrash6_v2 := project(flc6_v2_in,flc6_convert_to_old(left));
