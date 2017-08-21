flc5_v2_in := dataset('~thor_data400::in::flcrash5'
						,FLAccidents.Layout_FLCrash5_v2, flat);

flc5_v2_rec :=  FLAccidents.Layout_temp.flcrash5 ;//FLAccidents.Layout_FLCrash5;

flc5_v2_rec flc5_convert_to_old(flc5_v2_in l) := transform
	self := l;
end;

export InFile_FLCrash5_v2 := project(flc5_v2_in,flc5_convert_to_old(left));
