EXPORT file_american_student_list_address_in := dataset(American_student_list.thor_cluster + 'in::american_student_list_address::superfile',American_student_list.layout_american_student_list_address_in, 	
																		csv(heading(1), 
																		separator(','),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));