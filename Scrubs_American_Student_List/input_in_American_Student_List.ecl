import data_services,american_student_list;

// EXPORT input_In_American_Student_List := american_student_list.File_american_student_in;

EXPORT input_In_American_Student_List := dataset(data_services.foreign_prod + 'thor_data400::in::american_student_list::superfile',American_student_list.layout_american_student_in, 	
																		csv(heading(1), 
																		separator(','),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));