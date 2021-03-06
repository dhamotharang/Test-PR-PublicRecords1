// NOTE: The use_distributed option will use a hash(did_field) on input records (not a hash32 or hash64).
// If the input is already distributed with a hash() on the did_field value, 
//  the operation should be suitably efficient
//
EXPORT append(did_ds, did_field, permission_type, left_outer = 'true', use_distributed = 'false') := FUNCTIONMACRO

	IMPORT ut, watchdog, Infutor, doxie, dx_BestRecords;

	// ennumerate all of the possible join options
	// -------------------------------------------------------------
	LOCAL out_glb := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_watchdog_glb, use_distributed, left_outer);
	LOCAL out_glb_nonutil := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_watchdog_glb_nonutil, use_distributed, left_outer);
	LOCAL out_glb_nonutil_nonblank := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_watchdog_glb_nonutil_nonblank, use_distributed, left_outer);
	LOCAL out_glb_nonexp := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian, use_distributed, left_outer);
	LOCAL out_glb_noneq := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonEquifax, use_distributed, left_outer);
	LOCAL out_glb_nonexp_noneq := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax, use_distributed, left_outer);
	LOCAL out_glb_nonblank := dx_BestRecords.mac_join(did_ds, did_field, watchdog.key_watchdog_glb_nonblank, use_distributed, left_outer);
	LOCAL out_glb_nonexp_nonblank := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian_nonblank, use_distributed, left_outer);
	LOCAL out_glb_noneq_nonblank := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonEquifax_nonblank, use_distributed, left_outer);
	LOCAL out_glb_nonexp_noneq_nonblank := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank, use_distributed, left_outer);
	LOCAL out_nonglb := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_Watchdog_nonglb, use_distributed, left_outer);
	LOCAL out_nonglb_preglb := dx_BestRecords.mac_join(did_ds, did_field, Watchdog.Key_Watchdog_nonglb_V2, use_distributed, left_outer);
	LOCAL out_nonglb_nonblank := dx_BestRecords.mac_join(did_ds, did_field, watchdog.key_watchdog_nonglb_nonblank, use_distributed, left_outer);
	LOCAL out_nonglb_nonblank_preglb := dx_BestRecords.mac_join(did_ds, did_field, Watchdog.key_watchdog_nonglb_nonblank_V2, use_distributed, left_outer);
	LOCAL out_marketing := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_watchdog_marketing, use_distributed, left_outer);
	LOCAL out_marketing_preglb := dx_BestRecords.mac_join(did_ds, did_field, Watchdog.Key_Watchdog_marketing_V2, use_distributed, left_outer);
	LOCAL out_cnsmr := dx_BestRecords.mac_join(did_ds, did_field, Infutor.key_infutor_best_did, use_distributed, left_outer);

	// select correct join based on the input flag
	// NOTE: we expect a valid value of type dx_BestRecords.Constants.perm_type
	LOCAL br_output := MAP(
		permission_type = dx_BestRecords.Constants.perm_type.glb => out_glb, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonexperian => out_glb_nonexp, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonequifax => out_glb_noneq, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonexperian_nonequifax => out_glb_nonexp_noneq, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonblank => out_glb_nonblank, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonexperian_nonblank => out_glb_nonexp_nonblank, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonequifax_nonblank => out_glb_noneq_nonblank, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonexperian_nonequifax_nonblank => out_glb_nonexp_noneq_nonblank, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonutil => out_glb_nonutil, 
		permission_type = dx_BestRecords.Constants.perm_type.glb_nonutil_nonblank => out_glb_nonutil_nonblank, 
		permission_type = dx_BestRecords.Constants.perm_type.nonglb => out_nonglb, 
		permission_type = dx_BestRecords.Constants.perm_type.nonglb_preglb => out_nonglb_preglb, 
		permission_type = dx_BestRecords.Constants.perm_type.nonglb_nonblank => out_nonglb_nonblank, 
		permission_type = dx_BestRecords.Constants.perm_type.nonglb_nonblank_preglb => out_nonglb_nonblank_preglb, 
		permission_type = dx_BestRecords.Constants.perm_type.marketing => out_marketing, 
		permission_type = dx_BestRecords.Constants.perm_type.marketing_preglb => out_marketing_preglb, 
		permission_type = dx_BestRecords.Constants.perm_type.infutor => out_cnsmr);

	RETURN br_output;

ENDMACRO;
