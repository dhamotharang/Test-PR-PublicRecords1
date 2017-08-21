import ut;

export File_In_OH_Hancock := dataset('~thor_200::in::civil::20120806::oh_hancock.txt',
								civ_court.Layout_In_OH_Hancock,csv(heading(1),terminator('\n'), separator('|')));