Import Data_Services, ut, doxie;

alloy_base := alloymedia_student_list.files.File_base(did<>0);

// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::alloy::qa::ffid
ut.MAC_CLEAR_FIELDS(alloy_base, alloy_base_cleared, AlloyMedia_student_list.Constants.fields_to_clear_alloy);

export Key_DID_FCRA := index(alloy_base_cleared,{did},{alloy_base_cleared},Data_Services.Data_location.Prefix('alloy_student')+'thor_data400::key::fcra::AlloyMedia_student_list::' + doxie.Version_SuperKey + '::did');