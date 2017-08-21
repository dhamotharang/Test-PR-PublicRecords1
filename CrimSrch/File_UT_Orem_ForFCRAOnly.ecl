import ut;
export File_UT_Orem_ForFCRAOnly := 
	dataset('~thor_200::in::crim_court_fcra::ut_orem_crim_data',
	CrimSrch.Layout_UT_Orem_FCRA_Input,csv(terminator('\n'), separator(['~','|',';']), maxlength(30000)));
	
