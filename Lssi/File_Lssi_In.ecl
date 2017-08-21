import ut;
export File_Lssi_In := Dataset(ut.foreign_prod + '~thor_data400::in::lssi_update', Layout_in, 
	                  csv(HEADING(1), SEPARATOR(','), TERMINATOR('\n'), QUOTE('"')));