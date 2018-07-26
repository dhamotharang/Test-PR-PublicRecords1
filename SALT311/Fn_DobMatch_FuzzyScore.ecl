eo0(unsigned a,unsigned b) := a = b OR a = 0 or b = 0;
export Fn_DobMatch_FuzzyScore(unsigned file_dob,unsigned targ_dob) := 
	MAP ( targ_dob = 0 => 0, file_dob = 0 => -1, targ_dob = file_dob => 2,
				eo0(targ_dob div 10000,file_dob div 10000) and eo0(targ_dob div 100 % 100,file_dob div 100 % 100)
				and eo0(targ_dob % 100,file_dob % 100) => 1, -2 );
