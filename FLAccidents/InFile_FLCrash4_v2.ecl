flc4_v2_in := dataset('~thor_data400::in::flcrash4'
							,FLAccidents.Layout_FLCrash4_v2, flat);

flc4_v2_rec := FLAccidents.Layout_temp.flcrash4;//FLAccidents.Layout_FLCrash4;

flc4_v2_rec flc4_convert_to_old(flc4_v2_in l) := transform
	self := l;
end;

export InFile_FLCrash4_v2 := project(flc4_v2_in,flc4_convert_to_old(left));
