Import Data_Services, American_student_list, Doxie;

file_in := American_student_list.File_American_Student_List_Address_List;

export key_Address_List := index(file_in, 
                            {LN_COLLEGE_NAME},{file_in},
				            Data_Services.Data_location.Prefix('american_student')+'thor_data400::key::American_Student::' + Doxie.Version_SuperKey+ '::address_list');
										
										
										
								