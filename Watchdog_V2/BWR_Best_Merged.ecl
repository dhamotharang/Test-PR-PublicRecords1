// This will merge various watchdog keys into a single basefile that has a binary flag field that will
// determine who can see the various records.
IMPORT PromoteSupers, Watchdog, Python;

 string sortstr(string s) := EMBED(Python)		
    return ''.join(sorted(s))
 ENDEMBED;

EXPORT BWR_Best_Merged := FUNCTION

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
	
	string1 sPermission(unsigned4 permission) := CASE(permission,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb                      => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_nonblank  => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_nonblank,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_nonutil           => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_nonutil,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_nonutil_nonblank  => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_nonutil_nonblank,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_nonen                      => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_nonen,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_nonen_nonblank                      => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_nonen_nonblank,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_noneq                      => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_noneq,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_noneq_nonblank                      => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_noneq_nonblank,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_nonen_noneq                      => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_nonen_noneq,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.glb_nonen_noneq_nonblank     => Watchdog_v2._Flags.Bitmap_Permissions.sKey.glb_nonen_noneq_nonblank,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.nonglb     => Watchdog_v2._Flags.Bitmap_Permissions.sKey.nonglb,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.nonglb_nonblank     => Watchdog_v2._Flags.Bitmap_Permissions.sKey.nonglb_nonblank,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.nonglb_noneq     => Watchdog_v2._Flags.Bitmap_Permissions.sKey.nonglb_noneq,
				Watchdog_v2._Flags.Bitmap_Permissions.Key.nonglb_noneq_nonblank     => Watchdog_v2._Flags.Bitmap_Permissions.sKey.nonglb_noneq_nonblank,
				'X');
				


	// Add the bitmap permissions to each dataset
	Watchdog_V2.Layout_Best_Merged add_bitmap_permission(Watchdog.Layout_Best L, UNSIGNED4 permission) := TRANSFORM
		SELF.bitmap_permissions := permission;
		SELF.str_permissions := spermission(permission);
		
		self.counts := ROW({SELF.bitmap_permissions, SELF.str_permissions, L.total_records}, recordof(self.counts));
		
		SELF := L;
		SELF := [];
	END;
	
	Watchdog_V2.Layout_Best_Merged add_bitmap_permission2(Watchdog.Layout_best_flags L, UNSIGNED4 permission) := TRANSFORM
		SELF.bitmap_permissions := permission;
		SELF.str_permissions := spermission(permission);
		self.counts := ROW({SELF.bitmap_permissions, SELF.str_permissions, L.total_records}, recordof(self.counts));
		
		SELF := L;
		SELF := [];
	END;	


	ds_glb_w_bit                      := PROJECT(ds_glb_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb));
	ds_glb_nonblank_w_bit             := PROJECT(ds_glb_nonblank_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_nonblank));
	ds_glb_nonutil_w_bit              := PROJECT(ds_glb_nonutil_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_nonutil));
	ds_glb_nonutil_nonblank_w_bit     := PROJECT(ds_glb_nonutil_nonblank_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_nonutil_nonblank));
	ds_glb_nonen_w_bit                := PROJECT(ds_glb_nonen_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_nonen));
	ds_glb_nonen_nonblank_w_bit       := PROJECT(ds_glb_nonen_nonblank_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_nonen_nonblank));
	ds_glb_noneq_w_bit                := PROJECT(ds_glb_noneq_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_noneq));
	ds_glb_noneq_nonblank_w_bit       := PROJECT(ds_glb_noneq_nonblank_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_noneq_nonblank));
	ds_glb_nonen_noneq_w_bit          := PROJECT(ds_glb_nonen_noneq_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_nonen_noneq));
	ds_glb_nonen_noneq_nonblank_w_bit := PROJECT(ds_glb_nonen_noneq_nonblank_proj, add_bitmap_permission(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.glb_nonen_noneq_nonblank));
	ds_nonglb_w_bit                   := PROJECT(ds_nonglb_proj, add_bitmap_permission2(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.nonglb));
	ds_nonglb_nonblank_w_bit          := PROJECT(ds_nonglb_nonblank_proj, add_bitmap_permission2(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.nonglb_nonblank));
	ds_nonglb_noneq_w_bit             := PROJECT(ds_nonglb_noneq_proj, add_bitmap_permission2(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.nonglb_noneq));
	ds_nonglb_noneq_nonblank_w_bit    := PROJECT(ds_nonglb_noneq_nonblank_proj, add_bitmap_permission2(LEFT, Watchdog_V2._Flags.Bitmap_Permissions.Key.nonglb_noneq_nonblank));

	// Combine all the datasets together and update the permission level as appropriate.
	Watchdog_V2.Layout_Best_Merged combine_permission_bits(Watchdog_V2.Layout_Best_Merged L, Watchdog_V2.Layout_Best_Merged R) := TRANSFORM
		SELF.str_permissions := sortstr(TRIM(L.str_permissions,LEFT,RIGHT) + TRIM(R.str_permissions,LEFT,RIGHT));
		SELF.bitmap_permissions := L.bitmap_permissions | R.bitmap_permissions;
		
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
	ds_merged_dist := DISTRIBUTE(ds_merged, HASH64(did));
	ds_merged_sort := SORT(ds_merged_dist, RECORD, EXCEPT bitmap_permissions,str_permissions,run_date,total_records,counts, 
																	glb_name,glb_address,glb_dob,glb_ssn,glb_phone, LOCAL);
	ds_merged_rollup := ROLLUP(ds_merged_sort,
														 combine_permission_bits(LEFT, RIGHT),
														 RECORD,
															  EXCEPT bitmap_permissions,str_permissions,run_date,total_records,counts,
																	glb_name,glb_address,glb_dob,glb_ssn,glb_phone,
														 LOCAL);

// will probably need to change the name for consistency
  //PromoteSupers.MAC_SF_BuildProcess(ds_merged_rollup, '~thor_data400::base::watchdog_best_combined', build_combined_base, 2, , TRUE);

  // merged_base := SEQUENTIAL(OUTPUT(count(ds_best), named('COUNT_ds_best')),
	                          // OUTPUT(count(ds_best_nonglb), named('COUNT_ds_best_nonglb')),
														// OUTPUT(count(ds_best_nonglb_noneq), named('COUNT_ds_best_nonglb_noneq')),
														// OUTPUT(count(ds_best_nonutility), named('COUNT_ds_best_nonutility')),
														// OUTPUT(count(ds_best_nonglb_nonutility), named('COUNT_ds_best_nonglb_nonutility')),
														// OUTPUT(count(ds_best_noneq), named('COUNT_ds_best_noneq')),
														// OUTPUT(count(ds_best_nonen), named('COUNT_ds_best_nonen')),
														// OUTPUT(count(ds_best_nonen_noneq), named('COUNT_ds_best_nonen_noneq')),
														// OUTPUT(choosen(sort(ds_best_w_bit, did, local), 300), named('ds_best_w_bit')),
														// OUTPUT(choosen(sort(ds_best_nonglb_w_bit, did, local), 300), named('ds_best_nonglb_w_bit')),
														// OUTPUT(choosen(sort(ds_best_nonglb_noneq_w_bit, did, local), 300), named('ds_best_nonglb_noneq_w_bit')),
														// OUTPUT(choosen(sort(ds_best_nonutility_w_bit, did, local), 300), named('ds_best_nonutility_w_bit')),
														// OUTPUT(choosen(sort(ds_best_nonglb_nonutility_w_bit, did, local), 300), named('ds_best_nonglb_nonutility_w_bit')),
														// OUTPUT(choosen(sort(ds_best_noneq_w_bit, did, local), 300), named('ds_best_noneq_w_bit')),
														// OUTPUT(choosen(sort(ds_best_nonen_w_bit, did, local), 300), named('ds_best_nonen_w_bit')),
														// OUTPUT(choosen(sort(ds_best_nonen_noneq_w_bit, did, local), 300), named('ds_best_nonen_noneq_w_bit')),
														// OUTPUT(count(ds_just_best), named('COUNT_ds_just_best')),
														// OUTPUT(choosen(ds_just_best, 300), named('ds_just_best')),
														// OUTPUT(count(ds_just_nonglb), named('COUNT_ds_just_nonglb')),
														// OUTPUT(choosen(ds_just_nonglb, 300), named('ds_just_nonglb')),
														// OUTPUT(count(ds_just_nonglb_noneq), named('COUNT_ds_just_nonglb_noneq')),
														// OUTPUT(choosen(ds_just_nonglb_noneq, 300), named('ds_just_nonglb_noneq')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 1)), named('COUNT_best_only')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 2)), named('COUNT_nonglb_only')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 3)), named('COUNT_best_and_nonglb')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 4)), named('COUNT_noneq_only')),
														// OUTPUT(ds_final_join(bitmap_permissions = 4), named('noneq_only')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 5)), named('COUNT_best_and_noneq')),
														// OUTPUT(ds_final_join(bitmap_permissions = 5), named('best_and_noneq')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 6)), named('COUNT_nonglb_and_noneq')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 7)), named('COUNT_true_for_all_three')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 8)), named('COUNT_eight')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 16)), named('COUNT_sixteen')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 32)), named('COUNT_thirtytwo')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 64)), named('COUNT_sixtyfour')),
														// OUTPUT(count(ds_final_join(bitmap_permissions = 128)), named('COUNT_onetwentyeight')),
														// OUTPUT(count(ds_final_join), named('COUNT_total_records_after_joins')),
														// OUTPUT(final_dedup, named('number_of_permission_levels')),
														// build_combined_base);

  // RETURN merged_base;
	/*merged_base := SEQUENTIAL(OUTPUT(count(ds_merged), named('COUNT_ds_merged')),
													  OUTPUT(ds_merged, named('ds_merged')),
													  OUTPUT(count(ds_merged_rollup), named('COUNT_ds_merged_rollup')),
													  OUTPUT(ds_merged_rollup, named('ds_merged_rollup')),
														ds_merged_rollup);*/
	RETURN ds_merged_rollup;		//ds_merged_rollup;

END;