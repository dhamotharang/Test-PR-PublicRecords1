
// This is/will be the code to merge various watchdog keys into a single key that has a binary flag
// field that will determine who can see the various records.
IMPORT doxie, Roxiekeybuild, Watchdog, dx_BestRecords, prte2_watchdog;

Permissions := dx_BestRecords.Constants.PERM_TYPE;

EXPORT fn_build_merged := FUNCTION
/*
	key_glb                      := watchdog.Key_Prep_Watchdog_GLB();
	key_glb_nonblank             := watchdog.Key_Prep_Watchdog_GLB();  		//copy from best.did
	key_glb_nonutil              := watchdog.Key_Prep_Watchdog_GLB(true);
	// key_glb_nonutil_nonblank     := Watchdog.key_Prep_Watchdog_glb_nonutil_nonblank(true);
	key_glb_nonen                := watchdog.Key_Prep_Watchdog_GLB(); 			//copy from best.did
	key_glb_nonen_nonblank       := watchdog.Key_Prep_Watchdog_GLB();			//copy from best.did
	key_glb_noneq                := watchdog.Key_Prep_Watchdog_GLB();			//copy from best.did
	key_glb_noneq_nonblank       := watchdog.Key_Prep_Watchdog_GLB();			//copy from best.did
	key_glb_nonen_noneq          := watchdog.Key_Prep_Watchdog_GLB();		  //copy from best.did	
	key_glb_nonen_noneq_nonblank := watchdog.Key_Prep_Watchdog_GLB();			//copy from best.did
	key_nonglb                   := watchdog.Key_Prep_Watchdog_nonglb(false);
	key_nonglb_nonblank          := Watchdog.key_Prep_Watchdog_nonglb_nonblank(false);
	key_nonglb_noneq             := watchdog.Key_Prep_Watchdog_nonglb(true);
	key_nonglb_noneq_nonblank    := Watchdog.key_Prep_Watchdog_nonglb_nonblank(true);
	key_marketing								 := watchdog.Key_Prep_Watchdog_marketing(false);
	key_marketing_preglb				 := watchdog.Key_Prep_Watchdog_marketing(true);
	
*/

	key_glb                      := prte2_watchdog.Keys.key_glb;
	key_glb_nonblank             := prte2_watchdog.Keys.key_glb;  		//copy from best.did
	key_glb_nonutil              := prte2_watchdog.Keys.key_glb_nonutil(true);
	// key_glb_nonutil_nonblank     := Watchdog.key_Prep_Watchdog_glb_nonutil_nonblank(true);
	key_glb_nonen                := prte2_watchdog.Keys.key_glb; 			//copy from best.did
	key_glb_nonen_nonblank       := prte2_watchdog.Keys.key_glb;			//copy from best.did
	key_glb_noneq                := prte2_watchdog.Keys.key_glb;			//copy from best.did
	key_glb_noneq_nonblank       := prte2_watchdog.Keys.key_glb;			//copy from best.did
	key_glb_nonen_noneq          := prte2_watchdog.Keys.key_glb;		  //copy from best.did	
	key_glb_nonen_noneq_nonblank := prte2_watchdog.Keys.key_glb;			//copy from best.did
	key_nonglb                   := prte2_watchdog.Keys.key_nonglb;
	key_nonglb_nonblank          := prte2_watchdog.keys.key_nonglb_nonblank;
	key_nonglb_noneq             := prte2_watchdog.Keys.key_nonglb_noneq;
	key_nonglb_noneq_nonblank    := prte2_watchdog.keys.key_nonglb_noneq_nonblank;
	key_marketing								 := prte2_watchdog.Keys.key_marketing;
	key_marketing_preglb				 := prte2_watchdog.Keys.key_marketing_preglb;
		

	ds_glb_proj                      := PROJECT(key_glb, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonblank_proj             := PROJECT(key_glb_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
	ds_glb_nonutil_proj              := PROJECT(key_glb_nonutil, dx_BestRecords.Layout_Watchdog_Merged);
	// ds_glb_nonutil_nonblank_proj     := PROJECT(key_glb_nonutil_nonblank, dx_BestRecords.Layout_Watchdog_Merged);
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

	ds_glb_w_bit                      := PROJECT(ds_glb_proj, add_bitmap_permission(LEFT, Permissions.glb));
	ds_glb_nonblank_w_bit             := PROJECT(ds_glb_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonblank));
	ds_glb_nonutil_w_bit              := PROJECT(ds_glb_nonutil_proj, add_bitmap_permission(LEFT, Permissions.glb_nonutil));
	// ds_glb_nonutil_nonblank_w_bit     := PROJECT(ds_glb_nonutil_nonblank_proj, add_bitmap_permission(LEFT, Permissions.glb_nonutil_nonblank));
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
	ds_marketing_w_bit    						:= PROJECT(ds_marketing_proj, add_bitmap_permission(LEFT, Permissions.marketing));
	ds_marketing_preglb_w_bit    			:= PROJECT(ds_marketing_preglb_proj, add_bitmap_permission(LEFT, Permissions.marketing_preglb));

	// Combine all the datasets together and update the permission level as appropriate.
	dx_BestRecords.Layout_Watchdog_Merged combine_permission_bits(dx_BestRecords.Layout_Watchdog_Merged L, dx_BestRecords.Layout_Watchdog_Merged R) := TRANSFORM
		SELF.permissions := L.permissions | R.permissions;
		
		self.counts := L.counts + R.counts;

		SELF := L;
	END;

	ds_merged := ds_glb_w_bit + ds_glb_nonblank_w_bit + ds_glb_nonutil_w_bit + /*ds_glb_nonutil_nonblank_w_bit +*/
	                ds_glb_nonen_w_bit + ds_glb_nonen_nonblank_w_bit + ds_glb_noneq_w_bit +
									ds_glb_noneq_nonblank_w_bit + ds_glb_nonen_noneq_w_bit + ds_glb_nonen_noneq_nonblank_w_bit +
									ds_nonglb_w_bit + ds_nonglb_nonblank_w_bit + ds_nonglb_noneq_w_bit +
									ds_nonglb_noneq_nonblank_w_bit +
									ds_marketing_w_bit + ds_marketing_preglb_w_bit;
	ds_merged_dist := DISTRIBUTE(ds_merged, did);
	ds_merged_sort := SORT(ds_merged_dist, RECORD, EXCEPT permissions,run_date,total_records,counts,LOCAL); 
	ds_merged_rollup := ROLLUP(ds_merged_sort,
														 combine_permission_bits(LEFT, RIGHT),
														 RECORD,
															  EXCEPT permissions,run_date,total_records,counts,
														 LOCAL);

	RETURN ds_merged_rollup;
END;