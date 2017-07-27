import ut;
export Files := module;

	export load_in     		:= DATASET(SuperFile_List.load, Layouts.load, THOR);
	export Update_in    	:= DATASET(SuperFile_List.updates, Layouts.update, THOR);
	export Base           := DATASET(SuperFile_List.Base, Layouts.base, THOR);
	export Base_prev      := DATASET(SuperFile_List.Base_prev, Layouts.base, THOR);
	export Delete_In      := DATASET(SuperFile_List.Deletes, Layouts.Delete, THOR);
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

		,if(~FileServices.SuperFileExists('~thor_data400::base::TransunionCredHeader_Building'),fileservices.createsuperfile('~thor_data400::in::TransunionCred_deletes_history'))
	);

end;