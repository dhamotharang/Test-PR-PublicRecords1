// This is/will be the code to merge various watchdog keys into a single key that has a binary flag
// field that will determine who can see the various records.
IMPORT doxie, Roxiekeybuild, Watchdog, dx_BestRecords,mdr;

Permissions := dx_BestRecords.Constants.PERM_TYPE;

EXPORT fn_build_merged := FUNCTION

	key_glb                      := Watchdog.Key_watchdog_glb_old;
	key_glb_nonblank             := Watchdog.key_watchdog_glb_nonblank_old;
	key_glb_nonutil              := Watchdog.Key_watchdog_glb_nonutil_old;
	key_glb_nonutil_nonblank     := Watchdog.Key_watchdog_GLB_nonutil_nonblank_old;
	key_glb_nonen                := Watchdog.Key_Watchdog_GLB_nonExperian_old;
	key_glb_nonen_nonblank       := Watchdog.Key_Watchdog_GLB_nonExperian_nonblank_old;
	key_glb_noneq                := Watchdog.Key_Watchdog_GLB_nonEquifax_old;
	key_glb_noneq_nonblank       := Watchdog.Key_Watchdog_GLB_nonEquifax_nonblank_old;
	key_glb_nonen_noneq          := Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_old;
	key_glb_nonen_noneq_nonblank := Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank_old;
	key_nonglb                   := Watchdog.Key_Watchdog_nonglb_old;
	key_nonglb_nonblank          := Watchdog.key_watchdog_nonglb_nonblank_old;
	key_nonglb_noneq             := Watchdog.Key_Watchdog_nonglb_V2_old;
	key_nonglb_noneq_nonblank    := Watchdog.key_watchdog_nonglb_nonblank_V2_old;
	key_marketing								 := Watchdog.Key_Watchdog_marketing_old;
	key_marketing_preglb				 := Watchdog.Key_Watchdog_marketing_V2_old;
	key_nonglb_teaser            := Watchdog.key_watchdog_teaser_old;
	key_nonglb_noneq_teaser      := Watchdog.Key_watchdog_teaser_v2_old;
	

	ds_glb_proj                      := PROJECT(key_glb, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonblank_proj             := PROJECT(key_glb_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonutil_proj              := PROJECT(key_glb_nonutil, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonutil_nonblank_proj     := PROJECT(key_glb_nonutil_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonen_proj                := PROJECT(key_glb_nonen, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonen_nonblank_proj       := PROJECT(key_glb_nonen_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_noneq_proj                := PROJECT(key_glb_noneq, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_noneq_nonblank_proj       := PROJECT(key_glb_noneq_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonen_noneq_proj          := PROJECT(key_glb_nonen_noneq, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonen_noneq_nonblank_proj := PROJECT(key_glb_nonen_noneq_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
	ds_nonglb_proj                   := PROJECT(key_nonglb, dx_BestRecords.Layout_Watchdog_Merged);
	ds_nonglb_nonblank_proj          := PROJECT(key_nonglb_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
	ds_nonglb_noneq_proj             := PROJECT(key_nonglb_noneq, dx_BestRecords.Layout_Watchdog_Merged);
	ds_nonglb_noneq_nonblank_proj    := PROJECT(key_nonglb_noneq_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
	ds_marketing_proj   						 := PROJECT(key_marketing, dx_BestRecords.Layout_Watchdog_Merged);
	ds_marketing_preglb_proj    		 := PROJECT(key_marketing_preglb, dx_BestRecords.Layout_Watchdog_Merged);
	ds_nonglb_teaser_proj            := PROJECT(key_nonglb_teaser, dx_BestRecords.Layout_Watchdog_Merged);
	ds_nonglb_noneq_teaser_proj      := PROJECT(key_nonglb_noneq_teaser, dx_BestRecords.Layout_Watchdog_Merged);
	

	// Add the bitmap permissions to each dataset
	dx_BestRecords.Layout_Watchdog_Merged add_bitmap_permission(dx_BestRecords.Layout_Watchdog_Merged L, UNSIGNED8 permission) := TRANSFORM
		SELF.permissions := permission;
		
		self.counts := ROW({SELF.permissions, L.total_records}, recordof(self.counts));
		
		SELF := L;
		SELF := [];
	END;
	
/*	dx_BestRecords.Layout_Watchdog_Merged add_bitmap_permission2(dx_BestRecords.Layout_Watchdog_Merged L, UNSIGNED8 permission) := TRANSFORM
		SELF.permissions := permission;
		self.counts := ROW({SELF.permissions, L.total_records}, recordof(self.counts));
		
		SELF := L;
		SELF := [];
	END;	
*/

	d2c := pull(Doxie.key_D2C_lookup());
    ds_glb_d2c_proj := join(distribute(ds_glb_proj, hash(did)), distribute(d2c, hash(did)), left.did = right.did, transform(left), local);

	ds_glb_w_bit                      := PROJECT(ds_glb_proj, add_bitmap_permission(LEFT, Permissions.glb));
	ds_glb_w_d2c_bit                  := PROJECT(ds_glb_d2c_proj, add_bitmap_permission(LEFT, Permissions.glb_d2c_filtered));
	ds_glb_nonblank_w_bit             := PROJECT(ds_glb_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonblank));
	ds_glb_nonutil_w_bit              := PROJECT(ds_glb_nonutil_proj, add_bitmap_permission(LEFT, Permissions.glb_nonutil));
	ds_glb_nonutil_nonblank_w_bit     := PROJECT(ds_glb_nonutil_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonutil_nonblank));
	ds_glb_nonen_w_bit                := PROJECT(ds_glb_nonen_proj, add_bitmap_permission(LEFT, Permissions.glb_nonen));
	ds_glb_nonen_nonblank_w_bit       := PROJECT(ds_glb_nonen_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonen_nonblank));
	ds_glb_noneq_w_bit                := PROJECT(ds_glb_noneq_proj, add_bitmap_permission(LEFT, Permissions.glb_noneq));
	ds_glb_noneq_nonblank_w_bit       := PROJECT(ds_glb_noneq_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_noneq_nonblank));
	ds_glb_nonen_noneq_w_bit          := PROJECT(ds_glb_nonen_noneq_proj, add_bitmap_permission(LEFT, Permissions.glb_nonen_noneq));
	ds_glb_nonen_noneq_nonblank_w_bit := PROJECT(ds_glb_nonen_noneq_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonen_noneq_nonblank));
	ds_nonglb_w_bit                   := PROJECT(ds_nonglb_proj, add_bitmap_permission(LEFT, Permissions.nonglb));
	ds_nonglb_nonblank_w_bit          := PROJECT(ds_nonglb_nonblank_proj, add_bitmap_permission(LEFT, Permissions.nonglb_nonblank));
	ds_nonglb_noneq_w_bit             := PROJECT(ds_nonglb_noneq_proj, add_bitmap_permission(LEFT, Permissions.nonglb_noneq));
	ds_nonglb_noneq_nonblank_w_bit    := PROJECT(ds_nonglb_noneq_nonblank_proj, add_bitmap_permission(LEFT, Permissions.nonglb_noneq_nonblank));
	ds_marketing_w_bit    			  := PROJECT(ds_marketing_proj, add_bitmap_permission(LEFT, Permissions.marketing));
	ds_marketing_preglb_w_bit    	  := PROJECT(ds_marketing_preglb_proj, add_bitmap_permission(LEFT, Permissions.marketing_preglb));
	ds_nonglb_teaser_w_bit            := PROJECT(ds_nonglb_teaser_proj , add_bitmap_permission(LEFT, Permissions.nonglb_teaser));
  ds_nonglb_noneq_teaser_w_bit        := PROJECT(ds_nonglb_noneq_teaser_proj , add_bitmap_permission(LEFT, Permissions.nonglb_noneq_teaser));

	// Combine all the datasets together and update the permission level as appropriate.
	dx_BestRecords.Layout_Watchdog_Merged combine_permission_bits(dx_BestRecords.Layout_Watchdog_Merged L, dx_BestRecords.Layout_Watchdog_Merged R) := TRANSFORM
		SELF.permissions := L.permissions | R.permissions;
		
		self.counts := L.counts + R.counts;

		SELF := L;
	END;

	ds_merged := ds_glb_w_bit + ds_glb_w_d2c_bit + ds_glb_nonblank_w_bit + ds_glb_nonutil_w_bit + ds_glb_nonutil_nonblank_w_bit +
	                ds_glb_nonen_w_bit + ds_glb_nonen_nonblank_w_bit + ds_glb_noneq_w_bit +
									ds_glb_noneq_nonblank_w_bit + ds_glb_nonen_noneq_w_bit + ds_glb_nonen_noneq_nonblank_w_bit +
									ds_nonglb_w_bit + ds_nonglb_nonblank_w_bit + ds_nonglb_noneq_w_bit +
									ds_nonglb_noneq_nonblank_w_bit +
									ds_marketing_w_bit + ds_marketing_preglb_w_bit + ds_nonglb_teaser_w_bit + ds_nonglb_noneq_teaser_w_bit;
	ds_merged_dist := DISTRIBUTE(ds_merged, did);
	ds_merged_sort := SORT(ds_merged_dist, RECORD, EXCEPT permissions,run_date,total_records,counts,LOCAL); 
	ds_merged_rollup := ROLLUP(ds_merged_sort,
														 combine_permission_bits(LEFT, RIGHT),
														 RECORD,
															  EXCEPT permissions,run_date,total_records,counts,
														 LOCAL);

	RETURN mdr.macGetGlobalSID(ds_merged_rollup, 'WatchdogBest_Virtual', '', 'global_sid');
END;