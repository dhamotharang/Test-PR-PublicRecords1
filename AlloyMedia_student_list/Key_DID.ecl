Import Data_Services, ut, doxie;

alloy_base := alloymedia_student_list.files.File_base(did<>0);

export Key_DID := index(alloy_base,{did},{alloy_base},Data_Services.Data_location.Prefix('alloy_student')+'thor_data400::key::AlloyMedia_student_list::' + doxie.Version_SuperKey + '::did');