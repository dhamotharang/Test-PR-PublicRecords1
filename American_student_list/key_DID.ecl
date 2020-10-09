Import Data_Services, American_student_list, Doxie, OKC_Student_List;

// file_in := American_student_list.File_american_student_DID_PH_Suppressed_v2;
file_in := American_student_list.File_american_student_list_combine;

// American_student_DID_base	:=	PROJECT(file_in((unsigned8)did<>0), American_student_list.layout_american_student_base_v2)
                              // + OKC_Student_List.Map_To_ASL_Base(did<>0);

export key_DID := index(file_in, 
                            {unsigned6 l_did := (unsigned)did},{file_in},
				            Data_Services.Data_location.Prefix('american_student')+'thor_data400::key::American_Student::' + Doxie.Version_SuperKey+'::DID2');
