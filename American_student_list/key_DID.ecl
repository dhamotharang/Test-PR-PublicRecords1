Import Data_Services, American_student_list, Doxie, OKC_Student_List;

file_in := American_student_list.File_american_student_list_combine;
dsPrepped := Prep_Build.prepBase(file_in);
export key_DID := index(dsPrepped, 
                            {unsigned6 l_did := (unsigned)did},{dsPrepped},
				            Data_Services.Data_location.Prefix('american_student')+'thor_data400::key::American_Student::' + Doxie.Version_SuperKey+'::DID2');
