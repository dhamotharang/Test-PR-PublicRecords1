EXPORT File_american_student_suppression := MODULE
	//20170810 Layout
	// EXPORT raw 			 := DATASET('~thor_data400::in::american_student_list_suppression::Superfile',
															// Layout_american_student_suppression.raw,
															// CSV(HEADING(1), 
															// SEPARATOR(','),
															// QUOTE('"'),
															// TERMINATOR(['\r\n','\r','\n'])));	
	EXPORT raw 			 := DATASET('~thor_data400::in::american_student_list_suppression::Superfile',
															Layout_american_student_suppression.raw,
															THOR);	

	EXPORT base			 := DATASET('~thor_data400::base::american_student_list_suppression',
															Layout_american_student_suppression.base,THOR,OPT);	

END;