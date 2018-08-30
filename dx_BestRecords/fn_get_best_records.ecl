export fn_get_best_records(did_ds, glb_flag = 'false', nonblank_flag = 'false', utility_flag = 'false', 
	pre_glb_flag = 'false', filter_exp_flag = 'false', filter_eq_flag = 'false', marketing_flag = 'false', 
	cnsmr_flag = 'false') := functionmacro

	import ut, watchdog, Infutor;

	local fn_join_watchdog(dids, key) := functionmacro
		outfile := join(dids, key,
			keyed(left.did = right.did),							
			transform(
				dx_BestRecords.layout_best,
				self.age := if ( right.dob = 0, 0, ut.age(right.dob) ),
				self := right
			), keep(1), limit(0));
		return outfile;
	endmacro;

	// ennumerate all of the possible join options
	// -------------------------------------------------------------
	local out_glb := fn_join_watchdog(did_ds, watchdog.Key_watchdog_glb);
	local out_glb_nonutil := fn_join_watchdog(did_ds, watchdog.Key_watchdog_glb_nonutil);
	local out_glb_nonutil_nonblank := fn_join_watchdog(did_ds, watchdog.Key_watchdog_glb_nonutil_nonblank);
	local out_glb_nonexp := fn_join_watchdog(did_ds, watchdog.Key_Watchdog_GLB_nonExperian);
	local out_glb_noneq := fn_join_watchdog(did_ds, watchdog.Key_Watchdog_GLB_nonEquifax);
	local out_glb_nonexp_noneq := fn_join_watchdog(did_ds, watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax);
	local out_glb_nonblank := fn_join_watchdog(did_ds, watchdog.key_watchdog_glb_nonblank);
	local out_glb_nonexp_nonblank := fn_join_watchdog(did_ds, watchdog.Key_Watchdog_GLB_nonExperian_nonblank);
	local out_glb_noneq_nonblank := fn_join_watchdog(did_ds, watchdog.Key_Watchdog_GLB_nonEquifax_nonblank);
	local out_glb_nonexp_noneq_nonblank := fn_join_watchdog(did_ds, watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank);
	local out_nonglb := fn_join_watchdog(did_ds, watchdog.Key_Watchdog_nonglb);
	local out_nonglb_v2 := fn_join_watchdog(did_ds, Watchdog.Key_Watchdog_nonglb_V2);
	local out_nonglb_nonblank := fn_join_watchdog(did_ds, watchdog.key_watchdog_nonglb_nonblank);
	local out_nonglb_nonblank_v2 := fn_join_watchdog(did_ds, Watchdog.key_watchdog_nonglb_nonblank_V2);
	local out_marketing := fn_join_watchdog(did_ds, watchdog.Key_watchdog_marketing);
	local out_marketing_v2 := fn_join_watchdog(did_ds, Watchdog.Key_Watchdog_marketing_V2);
	local out_cnsmr := fn_join_watchdog(did_ds, Infutor.key_infutor_best_did);

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