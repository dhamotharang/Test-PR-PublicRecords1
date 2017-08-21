import ut;
export Files := module;

	export load_in     		:= DATASET(TransunionCred.SuperFile_List.load,       TransunionCred.Layouts.load      , THOR);
	export Update_in    	:= DATASET(TransunionCred.SuperFile_List.updates,    TransunionCred.Layouts.update-cr , THOR);
	export Base           := DATASET(TransunionCred.SuperFile_List.Base,       TransunionCred.Layouts.base      , THOR);
	export Base_prev      := DATASET(TransunionCred.SuperFile_List.Base_prev,  TransunionCred.Layouts.base      , THOR);
	export Delete_In      := DATASET(TransunionCred.SuperFile_List.Deletes,    TransunionCred.Layouts.Delete    , THOR);
	export create_superfiles:=parallel(
		if(~FileServices.SuperFileExists('~thor_data400::base::TransunionCred'),fileservices.createsuperfile('~thor_data400::base::TransunionCred'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::TransunionCred_delete'),fileservices.createsuperfile('~thor_data400::base::TransunionCred_delete'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::TransunionCred_father'),fileservices.createsuperfile('~thor_data400::base::TransunionCred_father'))

		,if(~FileServices.SuperFileExists('~thor_data400::in::TransunionCred_load'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_load'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::TransunionCred_load_father'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_load_father'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::TransunionCred_load_delete'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_load_delete'))

		,if(~FileServices.SuperFileExists('~thor_data400::in::TransunionCred_updates'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_updates'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::TransunionCred_updates_father'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_updates_father'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::TransunionCred_updates_history'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_updates_history'))
        
		,if(~FileServices.SuperFileExists('~thor_data400::in::TransunionCred_deletes'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_deletes'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::TransunionCred_deletes_father'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_deletes_father'))

		,if(~FileServices.SuperFileExists('~thor_data400::base::TransunionCredHeader_Building'),fileservices.createsuperfile('~thor_data400::base::TransunionCredHeader_Building'))
	);

end;