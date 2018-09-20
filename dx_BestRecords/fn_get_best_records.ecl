export fn_get_best_records(did_ds, did_field, perm_type_val) := functionmacro

	import ut, watchdog, Infutor, doxie, dx_BestRecords;

	// ennumerate all of the possible join options
	// -------------------------------------------------------------
	local out_glb := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_watchdog_glb);
	local out_glb_nonutil := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_watchdog_glb_nonutil);
	local out_glb_nonutil_nonblank := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_watchdog_glb_nonutil_nonblank);
	local out_glb_nonexp := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian);
	local out_glb_noneq := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonEquifax);
	local out_glb_nonexp_noneq := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax);
	local out_glb_nonblank := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.key_watchdog_glb_nonblank);
	local out_glb_nonexp_nonblank := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian_nonblank);
	local out_glb_noneq_nonblank := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonEquifax_nonblank);
	local out_glb_nonexp_noneq_nonblank := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank);
	local out_nonglb := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_Watchdog_nonglb);
	local out_nonglb_v2 := dx_BestRecords.fn_join_watchdog(did_ds, did_field, Watchdog.Key_Watchdog_nonglb_V2);
	local out_nonglb_nonblank := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.key_watchdog_nonglb_nonblank);
	local out_nonglb_nonblank_v2 := dx_BestRecords.fn_join_watchdog(did_ds, did_field, Watchdog.key_watchdog_nonglb_nonblank_V2);
	local out_marketing := dx_BestRecords.fn_join_watchdog(did_ds, did_field, watchdog.Key_watchdog_marketing);
	local out_marketing_v2 := dx_BestRecords.fn_join_watchdog(did_ds, did_field, Watchdog.Key_Watchdog_marketing_V2);
	local out_cnsmr := dx_BestRecords.fn_join_watchdog(did_ds, did_field, Infutor.key_infutor_best_did);

	// select correct join based on the input flag
	// NOTE: we expect a valid value of type dx_BestRecords.Constants.perm_type
	local br_output := map(
		perm_type_val = dx_BestRecords.Constants.perm_type.glb => out_glb, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonexperian => out_glb_nonexp, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonequifax => out_glb_noneq, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonexperian_nonequifax => out_glb_nonexp_noneq, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonblank => out_glb_nonblank, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonexperian_nonblank => out_glb_nonexp_nonblank, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonequifax_nonblank => out_glb_noneq_nonblank, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonexperian_nonequifax_nonblank => out_glb_nonexp_noneq_nonblank, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonutil => out_glb_nonutil, 
		perm_type_val = dx_BestRecords.Constants.perm_type.glb_nonutil_nonblank => out_glb_nonutil_nonblank, 
		perm_type_val = dx_BestRecords.Constants.perm_type.nonglb => out_nonglb, 
		perm_type_val = dx_BestRecords.Constants.perm_type.nonglb_v2 => out_nonglb_v2, 
		perm_type_val = dx_BestRecords.Constants.perm_type.nonglb_nonblank => out_nonglb_nonblank, 
		perm_type_val = dx_BestRecords.Constants.perm_type.nonglb_nonblank_v2 => out_nonglb_nonblank_v2, 
		perm_type_val = dx_BestRecords.Constants.perm_type.marketing => out_marketing, 
		perm_type_val = dx_BestRecords.Constants.perm_type.marketing_v2 => out_marketing_v2, 
		perm_type_val = dx_BestRecords.Constants.perm_type.infutor => out_cnsmr);

	return br_output;

endmacro;