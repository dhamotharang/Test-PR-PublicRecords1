export Files := module
	export load_in     		:= DATASET(SuperFile_List.load, Layouts.load, THOR);
	export load_in_father	:= DATASET(SuperFile_List.load_father, Layouts.load, THOR);
	export Update_in    	:= DATASET(SuperFile_List.updates, Layouts.update, THOR);
	export Deletes_In     := DATASET(SuperFile_List.Deletes, Layouts.Deletes, THOR);
	export Deceased_In    := DATASET(SuperFile_List.Deceased, Layouts.Deceased, THOR);
	export Base           := DATASET(SuperFile_List.Base, Layouts.base, THOR,opt);
	export Base_prev      := DATASET(SuperFile_List.Base_prev, Layouts.base, THOR);
	export create_superfiles:=parallel(
		if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_load'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_load'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_load_father'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_load_father'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_load_delete'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_load_delete'))

		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_updates'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_updates'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_updates_father'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_updates_father'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_updates_history'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_updates_history'))
        
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_deletes'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_deletes'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_deletes_father'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_deletes_father'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_deletes_history'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_deletes_history'))

		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_deceased'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_deceased'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_deceased_father'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_deceased_father'))
		,if(~FileServices.SuperFileExists('~thor_data400::in::FCRA::ExperianCred_deceased_history'),fileservices.createsuperfile('~thor_data400::in::FCRA::ExperianCred_deceased_history'))

		,if(~FileServices.SuperFileExists('~thor_data400::base::FCRA::ExperianCred'),fileservices.createsuperfile('~thor_data400::base::FCRA::ExperianCred'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::FCRA::ExperianCred_delete'),fileservices.createsuperfile('~thor_data400::base::FCRA::ExperianCred_delete'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::FCRA::ExperianCred_father'),fileservices.createsuperfile('~thor_data400::base::FCRA::ExperianCred_father'))

		,if(~FileServices.SuperFileExists('~thor_data400::base::FCRA::ExperianCredHeader_Building'),fileservices.createsuperfile('~thor_data400::base::FCRA::ExperianCredHeader_Building'))
	);

end;