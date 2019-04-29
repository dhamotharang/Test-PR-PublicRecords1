// This is/will be the code to merge various watchdog keys into a single key that has a binary flag
// field that will determine who can see the various records.
IMPORT doxie, Roxiekeybuild, Watchdog, dx_BestRecords;

Permissions := dx_BestRecords.Constants.PERM_TYPE;

EXPORT fn_build_merged := FUNCTION

	key_glb                      := Watchdog.Key_watchdog_glb;
	key_glb_nonblank             := Watchdog.key_watchdog_glb_nonblank;
	key_glb_nonutil              := Watchdog.Key_watchdog_glb_nonutil;
	key_glb_nonutil_nonblank     := Watchdog.Key_watchdog_GLB_nonutil_nonblank;
	key_glb_nonen                := Watchdog.Key_Watchdog_GLB_nonExperian;
	key_glb_nonen_nonblank       := Watchdog.Key_Watchdog_GLB_nonExperian_nonblank;
	key_glb_noneq                := Watchdog.Key_Watchdog_GLB_nonEquifax;
	key_glb_noneq_nonblank       := Watchdog.Key_Watchdog_GLB_nonEquifax_nonblank;
	key_glb_nonen_noneq          := Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax;
	key_glb_nonen_noneq_nonblank := Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank;
	key_nonglb                   := Watchdog.Key_Watchdog_nonglb;
	key_nonglb_nonblank          := Watchdog.key_watchdog_nonglb_nonblank;
	key_nonglb_noneq             := Watchdog.Key_Watchdog_nonglb_V2;
	key_nonglb_noneq_nonblank    := Watchdog.key_watchdog_nonglb_nonblank_V2;

	ds_glb_proj                      := PROJECT(key_glb, watchdog.Layout_Best);
	ds_glb_nonblank_proj             := PROJECT(key_glb_nonblank, watchdog.Layout_Best);
	ds_glb_nonutil_proj              := PROJECT(key_glb_nonutil, watchdog.Layout_Best);
	ds_glb_nonutil_nonblank_proj     := PROJECT(key_glb_nonutil_nonblank, watchdog.Layout_Best);
	ds_glb_nonen_proj                := PROJECT(key_glb_nonen, watchdog.Layout_Best);
	ds_glb_nonen_nonblank_proj       := PROJECT(key_glb_nonen_nonblank, watchdog.Layout_Best);
	ds_glb_noneq_proj                := PROJECT(key_glb_noneq, watchdog.Layout_Best);
	ds_glb_noneq_nonblank_proj       := PROJECT(key_glb_noneq_nonblank, watchdog.Layout_Best);
	ds_glb_nonen_noneq_proj          := PROJECT(key_glb_nonen_noneq, watchdog.Layout_Best);
	ds_glb_nonen_noneq_nonblank_proj := PROJECT(key_glb_nonen_noneq_nonblank, watchdog.Layout_Best);
	ds_nonglb_proj                   := PROJECT(key_nonglb, watchdog.Layout_best_flags);
	ds_nonglb_nonblank_proj          := PROJECT(key_nonglb_nonblank, watchdog.Layout_best_flags);
	ds_nonglb_noneq_proj             := PROJECT(key_nonglb_noneq, watchdog.Layout_best_flags);
	ds_nonglb_noneq_nonblank_proj    := PROJECT(key_nonglb_noneq_nonblank, watchdog.Layout_best_flags);
	

	// Add the bitmap permissions to each dataset
	dx_BestRecords.layout_best add_bitmap_permission(Watchdog.Layout_Best L, UNSIGNED8 permission) := TRANSFORM
		SELF.permissions := permission;
		
		self.counts := ROW({SELF.permissions, L.total_records}, recordof(self.counts));
		
		SELF := L;
		SELF := [];
	END;
	
	dx_BestRecords.layout_best add_bitmap_permission2(Watchdog.Layout_best_flags L, UNSIGNED8 permission) := TRANSFORM
		SELF.permissions := permission;
		self.counts := ROW({SELF.permissions, L.total_records}, recordof(self.counts));
		
		SELF := L;
		SELF := [];
	END;	


	ds_glb_w_bit                      := PROJECT(ds_glb_proj, add_bitmap_permission(LEFT, Permissions.glb));
	ds_glb_nonblank_w_bit             := PROJECT(ds_glb_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonblank));
	ds_glb_nonutil_w_bit              := PROJECT(ds_glb_nonutil_proj, add_bitmap_permission(LEFT, Permissions.glb_nonutil));
	ds_glb_nonutil_nonblank_w_bit     := PROJECT(ds_glb_nonutil_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonutil_nonblank));
	ds_glb_nonen_w_bit                := PROJECT(ds_glb_nonen_proj, add_bitmap_permission(LEFT, Permissions.glb_nonen));
	ds_glb_nonen_nonblank_w_bit       := PROJECT(ds_glb_nonen_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonen_nonblank));
	ds_glb_noneq_w_bit                := PROJECT(ds_glb_noneq_proj, add_bitmap_permission(LEFT, Permissions.glb_noneq));
	ds_glb_noneq_nonblank_w_bit       := PROJECT(ds_glb_noneq_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_noneq_nonblank));
	ds_glb_nonen_noneq_w_bit          := PROJECT(ds_glb_nonen_noneq_proj, add_bitmap_permission(LEFT, Permissions.glb_nonen_noneq));
	ds_glb_nonen_noneq_nonblank_w_bit := PROJECT(ds_glb_nonen_noneq_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonen_noneq_nonblank));
	ds_nonglb_w_bit                   := PROJECT(ds_nonglb_proj, add_bitmap_permission2(LEFT, Permissions.nonglb));
	ds_nonglb_nonblank_w_bit          := PROJECT(ds_nonglb_nonblank_proj, add_bitmap_permission2(LEFT, Permissions.nonglb_nonblank));
	ds_nonglb_noneq_w_bit             := PROJECT(ds_nonglb_noneq_proj, add_bitmap_permission2(LEFT, Permissions.nonglb_noneq));
	ds_nonglb_noneq_nonblank_w_bit    := PROJECT(ds_nonglb_noneq_nonblank_proj, add_bitmap_permission2(LEFT, Permissions.nonglb_noneq_nonblank));

	// Combine all the datasets together and update the permission level as appropriate.
	dx_BestRecords.Layout_Best combine_permission_bits(dx_BestRecords.Layout_Best L, dx_BestRecords.Layout_Best R) := TRANSFORM
		SELF.permissions := L.permissions | R.permissions;
		
		self.counts := L.counts + R.counts;
		
		self.glb_name := IF(L.glb_name='Y' OR R.glb_name='Y', 'Y', L.glb_name);
		self.glb_address := IF(L.glb_address='Y' OR R.glb_address='Y', 'Y', L.glb_address);
		self.glb_dob := IF(L.glb_dob='Y' OR R.glb_dob='Y', 'Y', L.glb_dob);
		self.glb_ssn := IF(L.glb_ssn='Y' OR R.glb_ssn='Y', 'Y', L.glb_ssn);
		self.glb_phone := IF(L.glb_phone='Y' OR R.glb_phone='Y', 'Y', L.glb_phone);

		SELF := L;
	END;

	ds_merged := ds_glb_w_bit + ds_glb_nonblank_w_bit + ds_glb_nonutil_w_bit + ds_glb_nonutil_nonblank_w_bit +
	                ds_glb_nonen_w_bit + ds_glb_nonen_nonblank_w_bit + ds_glb_noneq_w_bit +
									ds_glb_noneq_nonblank_w_bit + ds_glb_nonen_noneq_w_bit + ds_glb_nonen_noneq_nonblank_w_bit +
									ds_nonglb_w_bit + ds_nonglb_nonblank_w_bit + ds_nonglb_noneq_w_bit +
									ds_nonglb_noneq_nonblank_w_bit;
	ds_merged_dist := DISTRIBUTE(ds_merged, did);
	ds_merged_sort := SORT(ds_merged_dist, RECORD, EXCEPT permissions,run_date,total_records,counts, 
																	glb_name,glb_address,glb_dob,glb_ssn,glb_phone, LOCAL);
	ds_merged_rollup := ROLLUP(ds_merged_sort,
														 combine_permission_bits(LEFT, RIGHT),
														 RECORD,
															  EXCEPT permissions,run_date,total_records,counts,
																	glb_name,glb_address,glb_dob,glb_ssn,glb_phone,
														 LOCAL);

	RETURN ds_merged_rollup;
END;