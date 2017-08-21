/*
Intermediary filenames required for running concurrent delta and full build.
*/
EXPORT Filenames_Intermediary(boolean pUseProd) := module

	shared dsName := _Dataset().name;
	shared thor_cluster := _Dataset(pUseProd).thor_cluster_files;
	
	export cfs_base 		:= thor_cluster + 'base::' + dsName + '::dbo::cfs::intermediate_delta';
	export mo_base 			:= thor_cluster + 'base::' + dsName + '::dbo::mo::intermediate_delta';
	export mo_udf_base 	:= thor_cluster + 'base::' + dsName + '::event::dbo::mo_udf::intermediate_delta';
	export per_base 		:= thor_cluster + 'base::' + dsName + '::dbo::persons::intermediate_delta';
	export per_udf_base := thor_cluster + 'base::' + dsName + '::event::dbo::persons_udf::intermediate_delta';
	export veh_base 		:= thor_cluster + 'base::' + dsName + '::dbo::vehicle::intermediate_delta';
	export cra_base 		:= thor_cluster + 'base::' + dsName + '::dbo::crash::intermediate_delta';
	export off_base 		:= thor_cluster + 'base::' + dsName + '::dbo::offenders::intermediate_delta';	
	export off_pic_base := thor_cluster + 'base::' + dsName + '::dbo::offenders_picture::intermediate_delta';
	export int_base 		:= thor_cluster + 'base::' + dsName + '::dbo::intel::intermediate_delta';
	export lpr_base 		:= thor_cluster + 'base::' + dsName + '::dbo::licenseplateevent::intermediate_delta';
	export shot_base 		:= thor_cluster + 'base::' + dsName + '::dbo::shotspotter::intermediate_delta';	
	export notes_base 	:= thor_cluster + 'base::' + dsName + '::notes::intermediate_delta';	
	export images_base 	:= thor_cluster + 'base::' + dsName + '::images::intermediate_delta';	
	export deletes_base := thor_cluster + 'base::' + dsName + '::agency_removed::dbo::agency_deletes::intermediate';
	export geohash_base := thor_cluster + 'base::' + dsName + '::geohash::intermediate';
	export geohash_key  := thor_cluster + 'key::'  + dsName + '::geohash::intermediate';
	export geohash_lpr_base := thor_cluster + 'base::' + dsName + '::geohash::lpr::intermediate';
	export geohash_lpr_key  := thor_cluster + 'key::'  + dsName + '::geohash::lpr::intermediate';
	
End;