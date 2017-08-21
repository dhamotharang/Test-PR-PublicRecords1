import data_services;
export File_american_student_in := dataset(American_student_list.thor_cluster + 'in::american_student_list::superfile',American_student_list.layout_american_student_in, 	
																		csv(heading(1), 
																		separator(','),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));