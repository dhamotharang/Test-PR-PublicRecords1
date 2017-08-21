flc2v_v2_in := dataset('~thor_data400::in::flcrash2v'
							,FLAccidents.Layout_FLCrash2v_v2, flat);
									  
flc2v_v2_rec := FLAccidents.Layout_temp.flcrash2v;//FLAccidents.Layout_FLCrash2v;

flc2v_v2_rec flc2v_convert_to_old(flc2v_v2_in l) := transform
	self                       := l;
end;

export InFile_FLCrash2v_v2 := project(flc2v_v2_in,flc2v_convert_to_old(left));