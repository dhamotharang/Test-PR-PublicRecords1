/*
Intermediary files required for running concurrent delta and full build.
*/
EXPORT Files_Intermediary(boolean pUseProd = false) := module
	
	shared inter_fn_modname := bair.Filenames_Intermediary(pUseProd);
	
	export cfs_d 		  := dataset(inter_fn_modname.cfs_base, Bair.layouts.dbo_cfs_Base, thor, opt);
	export mo_d 			:= dataset(inter_fn_modname.mo_base, Bair.layouts.dbo_event_mo_final_Base, thor, opt);
	export mo_udf_d 	:= dataset(inter_fn_modname.mo_udf_base, Bair.layouts.mo_udf_Base, thor, opt);
	export per_d 			:= dataset(inter_fn_modname.per_base, Bair.layouts.dbo_event_persons_final_Base, thor, opt);
	export per_udf_d 	:= dataset(inter_fn_modname.per_udf_base, Bair.layouts.persons_udf_Base, thor, opt);
	export veh_d 			:= dataset(inter_fn_modname.veh_base, Bair.layouts.dbo_event_vehicle_final_Base, thor, opt);
	export cra_d 			:= dataset(inter_fn_modname.cra_base, Bair.layouts.dbo_crash_Base, thor, opt);
	export off_d 			:= dataset(inter_fn_modname.off_base, Bair.layouts.dbo_offenders_Base, thor, opt);
	export off_pic_d 	:= dataset(inter_fn_modname.off_pic_base, Bair.layouts.dbo_offenders_picture_Base, thor, opt);
	export int_d 			:= dataset(inter_fn_modname.int_base, Bair.layouts.dbo_intel_Base, thor, opt);
	export lpr_d 			:= dataset(inter_fn_modname.lpr_base, Bair.layouts.lpr_dbo_LicensePlateEvent_Base, thor, opt);
	export shot_d 		:= dataset(inter_fn_modname.shot_base, Bair.layouts.gunop_dbo_shot_incident_Base, thor, opt);
	export notes_d 		:= dataset(inter_fn_modname.notes_base, Bair.layouts.notes_base, thor, opt);
	export images_d		:= dataset(inter_fn_modname.images_base, Bair.layouts.images_base, thor, opt);
	export deletes_d 	:= dataset(inter_fn_modname.deletes_base, Bair.layouts.AgencyDeletes_Base, thor, opt);

End;