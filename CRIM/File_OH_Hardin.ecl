import ut;

export File_OH_Hardin := module

export File_OH_Hardin_200910 := dataset('~thor_data400::in::crim_court::20091012::oh_hardin.txt.fixed',	Crim.Layout_OH_Hardin.Layout_OH_Hardin_200910,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
export File_OH_Hardin_Current := dataset('~thor_data400::in::crim_court::oh_hardin_updt',	Crim.Layout_OH_Hardin.Layout_OH_Hardin_Current,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
end;
