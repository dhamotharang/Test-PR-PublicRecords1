flc7_v2_in := dataset('~thor_data400::in::flcrash7'
						,FLAccidents.Layout_FLCrash7_v2, flat);

flc7_v2_rec := FLAccidents.Layout_temp.flcrash7;//FLAccidents.Layout_FLCrash7;

flc7_v2_rec flc7_convert_to_old(flc7_v2_in l) := transform
	self := l;
end;

export InFile_FLCrash7_v2 := project(flc7_v2_in,flc7_convert_to_old(left));
