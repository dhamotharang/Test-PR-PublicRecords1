flc0_v2_in := dataset('~thor_data400::in::flcrash0'
									,FLAccidents.Layout_FLCrash0_v2, flat);

flc0_v2_rec := FLAccidents.Layout_FLCrash0;

flc0_v2_rec flc0_convert_to_old(flc0_v2_in l) := transform
	self                 := l;
end;

export InFile_FLCrash0_v2 := project(flc0_v2_in,flc0_convert_to_old(left));
