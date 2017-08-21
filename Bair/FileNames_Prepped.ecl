EXPORT FileNames_Prepped(boolean pUseProd = false) := module

	shared sufx_in := 'in::bair_prepped::';

	export cfs_2_in 							:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'cfs::dbo::cfs_2';
	export cfs_2_in_hist 					:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'cfs::dbo::cfs_2::history';

	export cfs_2_off_in 					:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'cfs::dbo::cfs_officers_2';
	export cfs_2_off_in_hist			:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'cfs::dbo::cfs_officers_2::history';

	export mo_in 									:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::mo';
	export mo_in_hist 						:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::mo::history';

	export mo_udf_in 							:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::mo_udf';
	export mo_udf_in_hist					:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::mo_udf::history';

	export persons_in 						:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::persons';
	export persons_in_hist 				:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::persons::history';

	export persons_udf_in 				:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::persons_udf';
	export persons_udf_in_hist 		:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::persons_udf::history';

	export vehicle_in 						:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::vehicle';
	export vehicle_in_hist 				:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'event::dbo::vehicle::history';

	export crash_in 							:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'crash::dbo::crash';
	export crash_in_hist 					:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'crash::dbo::crash::history';

	export cra_per_in 						:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'crash::dbo::person';
	export cra_per_in_hist 				:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'crash::dbo::person::history';

	export cra_veh_in 						:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'crash::dbo::vehicle';
	export cra_veh_in_hist 				:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'crash::dbo::vehicle::history';

	export lpr_in 								:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'lpr::dbo::licenseplateevent';
	export lpr_in_hist 						:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'lpr::dbo::licenseplateevent::history';

	export offender_in 						:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'offenders::dbo::offender';
	export offender_in_hist 			:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'offenders::dbo::offender::history';

	export offender_class_in 			:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'offenders::dbo::offender_classification';
	export offender_class_in_hist := _Dataset(pUseProd).thor_cluster_files + sufx_in + 'offenders::dbo::offender_classification::history';

	export offender_pic_in 				:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'offenders::dbo::offender_picture';
	export offender_pic_in_hist 	:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'offenders::dbo::offender_picture::history';

	export agency_del_in			 		:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'agency_removed::dbo::agency_deletes';
	export agency_del_in_hist 		:= _Dataset(pUseProd).thor_cluster_files + sufx_in + 'agency_removed::dbo::agency_deletes::history';

End;