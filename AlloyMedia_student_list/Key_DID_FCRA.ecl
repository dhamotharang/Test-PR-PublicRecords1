import ut, doxie, data_services, vault, _control;

alloy_base := alloymedia_student_list.files.File_base(did<>0);

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_DID_FCRA := vault.AlloyMedia_student_list.Key_DID_FCRA;
#ELSE
export Key_DID_FCRA := index(alloy_base,{did},{alloy_base},data_services.data_location.prefix() + 'thor_data400::key::fcra::AlloyMedia_student_list::' + doxie.Version_SuperKey + '::did');
#END;


