export fn_get_best_records(did_ds, did_field = 'did', glb_flag = 'false', 
	nonblank_flag = 'false', utility_flag = 'false', pre_glb_flag = 'false', 
	filter_exp_flag = 'false', filter_eq_flag = 'false', marketing_flag = 'false', 
	cnsmr_flag = 'false') := functionmacro

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

	local br_output := 
		IF(marketing_flag, IF(pre_glb_flag, out_marketing_v2, out_marketing),
		IF(cnsmr_flag, out_cnsmr,
		IF(
			nonblank_flag,
			IF(
				glb_flag,
				MAP(utility_flag => out_glb_nonutil_nonblank,
						filter_exp_flag and filter_eq_flag => out_glb_nonexp_noneq_nonblank, 
						filter_exp_flag => out_glb_nonexp_nonblank,
						filter_eq_flag => out_glb_noneq_nonblank,		
						out_glb_nonblank
						),
				IF (pre_glb_flag,
					out_nonglb_nonblank_v2,
					out_nonglb_nonblank
					)
			),
			IF(
				glb_flag,
				MAP(utility_flag => out_glb_nonutil,
						filter_exp_flag and filter_eq_flag => out_glb_nonexp_noneq,
						filter_exp_flag => out_glb_nonexp,
						filter_eq_flag => out_glb_noneq,
						out_glb),
				IF(pre_glb_flag,
					out_nonglb_v2,
					out_nonglb
				)
			)
		)));

	return br_output;

endmacro;