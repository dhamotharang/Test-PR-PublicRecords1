export fileCell900 := 
	dataset('~thor_data400::in::cell900kleads_20060505',CellPhone.layoutCell900,csv(terminator('\n'), separator('|'), quote('')));