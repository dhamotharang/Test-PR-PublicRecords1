import American_student_list, Doxie, data_services;

file_in := American_student_list.File_american_student_DID_PH_Suppressed_v2;

American_student_DID_base	:=	PROJECT(file_in((unsigned8)did<>0), American_student_list.layout_american_student_base_v2);

export key_DID := index(American_student_DID_base, 
                            {unsigned6 l_did := (unsigned)did},{American_student_DID_base},
				            data_services.data_location.prefix() + 'thor_data400::key::American_Student::' + Doxie.Version_SuperKey+'::DID2');