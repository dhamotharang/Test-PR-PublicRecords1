import ut,Data_Services;
export File := module
	export raw_608 := dataset(Data_Services.foreign_prod+'thor_data400::in::quickhdr_raw_history_608',Layout.old_raw,THOR);
	export raw_567 := dataset(Data_Services.foreign_prod+'thor_data400::in::quickhdr_raw_history',Layout.current_raw,THOR);
	export raw_rf  := dataset(Data_Services.foreign_prod+'thor_data400::in::quickhdr_raw_history_rf',Layout.raw_rf,THOR);
	export base    := dataset(data_services.foreign_prod+'thor_data400::base::equifax_history',Layout.base,THOR);
	export create_superfiles:=parallel(
		if(~FileServices.SuperFileExists('~thor_data400::base::equifax_history'),fileservices.createsuperfile('~thor_data400::base::equifax_history'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::equifax_history_building'),fileservices.createsuperfile('~thor_data400::base::equifax_history_building'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::equifax_history_built'),fileservices.createsuperfile('~thor_data400::base::equifax_history_built'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::equifax_history_delete'),fileservices.createsuperfile('~thor_data400::base::equifax_history_delete'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::equifax_history_father'),fileservices.createsuperfile('~thor_data400::base::equifax_history_father'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::equifax_history_prod'),fileservices.createsuperfile('~thor_data400::base::equifax_history_prod'))
		,if(~FileServices.SuperFileExists('~thor_data400::base::eq_histHeader_building'),fileservices.createsuperfile('~thor_data400::base::eq_histHeader_building'))
	);
end;
