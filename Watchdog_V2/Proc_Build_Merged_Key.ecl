// This is/will be the code to merge various watchdog keys into a single key that has a binary flag
// field that will determine who can see the various records.
IMPORT doxie, Roxiekeybuild, Watchdog;

EXPORT Proc_Build_Merged_Key(STRING pversion) := FUNCTION

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
	Watchdog.Layout_Key_Merged add_bitmap_permission(Watchdog.Layout_Best L, UNSIGNED8 permission) := TRANSFORM
		SELF.bitmap_permissions := permission;
		
		SELF := L;
		SELF := [];
	END;

	Watchdog.Layout_Key_Merged add_bitmap_permission2(Watchdog.Layout_best_flags L, UNSIGNED8 permission) := TRANSFORM
		SELF.bitmap_permissions := permission;
		
		SELF := L;
		SELF := [];
	END;

	ds_glb_w_bit                      := PROJECT(ds_glb_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb));
	ds_glb_nonblank_w_bit             := PROJECT(ds_glb_nonblank_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_nonblank));
	ds_glb_nonutil_w_bit              := PROJECT(ds_glb_nonutil_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_nonutil));
	ds_glb_nonutil_nonblank_w_bit     := PROJECT(ds_glb_nonutil_nonblank_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_nonutil_nonblank));
	ds_glb_nonen_w_bit                := PROJECT(ds_glb_nonen_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_nonen));
	ds_glb_nonen_nonblank_w_bit       := PROJECT(ds_glb_nonen_nonblank_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_nonen_nonblank));
	ds_glb_noneq_w_bit                := PROJECT(ds_glb_noneq_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_noneq));
	ds_glb_noneq_nonblank_w_bit       := PROJECT(ds_glb_noneq_nonblank_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_noneq_nonblank));
	ds_glb_nonen_noneq_w_bit          := PROJECT(ds_glb_nonen_noneq_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_nonen_noneq));
	ds_glb_nonen_noneq_nonblank_w_bit := PROJECT(ds_glb_nonen_noneq_nonblank_proj, add_bitmap_permission(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.glb_nonen_noneq_nonblank));
	ds_nonglb_w_bit                   := PROJECT(ds_nonglb_proj, add_bitmap_permission2(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.nonglb));
	ds_nonglb_nonblank_w_bit          := PROJECT(ds_nonglb_nonblank_proj, add_bitmap_permission2(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.nonglb_nonblank));
	ds_nonglb_noneq_w_bit             := PROJECT(ds_nonglb_noneq_proj, add_bitmap_permission2(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.nonglb_noneq));
	ds_nonglb_noneq_nonblank_w_bit    := PROJECT(ds_nonglb_noneq_nonblank_proj, add_bitmap_permission2(LEFT, Watchdog._Flags.Bitmap_Permissions.Key.nonglb_noneq_nonblank));

	// Combine all the datasets together and update the permission level as appropriate.
	Watchdog.Layout_Key_Merged combine_permission_bits(Watchdog.Layout_Key_Merged L, Watchdog.Layout_Key_Merged R) := TRANSFORM
		SELF.bitmap_permissions := L.bitmap_permissions | R.bitmap_permissions;

		SELF := L;
	END;

	ds_merged_key := ds_glb_w_bit + ds_glb_nonblank_w_bit + ds_glb_nonutil_w_bit + ds_glb_nonutil_nonblank_w_bit +
	                    ds_glb_nonen_w_bit + ds_glb_nonen_nonblank_w_bit + ds_glb_noneq_w_bit +
										  ds_glb_noneq_nonblank_w_bit + ds_glb_nonen_noneq_w_bit + ds_glb_nonen_noneq_nonblank_w_bit +
										  ds_nonglb_w_bit + ds_nonglb_nonblank_w_bit + ds_nonglb_noneq_w_bit +
										  ds_nonglb_noneq_nonblank_w_bit;
	ds_merged_key_dist := DISTRIBUTE(ds_merged_key, HASH64(did));
	ds_merged_key_sort := SORT(ds_merged_key_dist, RECORD, EXCEPT bitmap_permissions, LOCAL);
	ds_merged_key_rollup := ROLLUP(ds_merged_key_sort,
															   combine_permission_bits(LEFT, RIGHT),
															   RECORD,
																	  EXCEPT bitmap_permissions,
															   LOCAL);

	final_merged_key := INDEX(ds_merged_key_rollup,
	                          {ds_merged_key_rollup},
													  '~thor_data400::key::watchdog_best_merged.did_' + doxie.Version_SuperKey);

	Roxiekeybuild.MAC_SK_BuildProcess_Local(final_merged_key,
	                                        '~thor_data400::key::watchdog::' + pversion + '::best_merged.did',
																					'~thor_data400::key::watchdog_best_merged.did',
																					build_key,
																					2);
	// Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.Key_Watchdog_Merged.merged_key,
	                                        // '~thor_data400::key::watchdog::' + pversion + '::best_merged.did',
																					// '~thor_data400::key::watchdog_best_merged.did',
																					// build_key,
																					// 2);
  Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::' + pversion + '::best_merged.did',
	                                   '~thor_data400::key::watchdog_best_merged.did',
																		 move_to_built,
																		 2);
  Roxiekeybuild.Mac_SK_Move('~thor_data400::key::watchdog_best_merged.did', 'Q', move_to_qa);

  merge_key := SEQUENTIAL(/*OUTPUT(count(ds_merged_key), named('COUNT_ds_merged_key')),
													OUTPUT(ds_merged_key, named('ds_merged_key')),
													OUTPUT(count(ds_merged_key_rollup), named('COUNT_ds_merged_key_rollup')),
													OUTPUT(ds_merged_key_rollup, named('ds_merged_key_rollup')),*/
													build_key,
													move_to_built,
													move_to_qa);

  RETURN merge_key;

END;