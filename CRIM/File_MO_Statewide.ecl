import ut;
export File_MO_Statewide :=  
	dataset('~thor_data400::in::crim::mo::statewide',
	CRIM.Layout_MO_Statewide,csv(terminator('\r\n'), separator('|'), quote('')));
