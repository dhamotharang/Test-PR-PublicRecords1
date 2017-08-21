export files := 
MODULE

	export base_name 		:= '~thor_data400::base::xADL_log::Overview';
//	export newfile_name := base_name + thorlib.wuid();

	export log_QA_name := 			base_name + '_QA';
	export log_QA      := 	dataset(log_QA_name, 					xADL_log_service.layouts.base_log, thor);
	export log_father_name := 	base_name + '_father';
	export log_father      := 	dataset(log_father_name, 			xADL_log_service.layouts.base_log, thor);
	export log_grandfather_name := base_name + '_grandfather';
	export log_grandfather := 	dataset(log_grandfather_name,      xADL_log_service.layouts.base_log, thor);
	export log_delete_name :=	base_name + '_delete';
	export log_delete      := 	dataset(log_delete_name, 			xADL_log_service.layouts.base_log, thor);
	
END;