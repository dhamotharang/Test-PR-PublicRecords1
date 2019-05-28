// This is/will be the code to merge various watchdog keys into a single key that has a binary flag
// field that will determine who can see the various records.
IMPORT $,doxie, Roxiekeybuild, dx_BestRecords;

EXPORT Proc_Build_Merged_Key(STRING pversion) := FUNCTION

	wd := $.fn_build_merged;

  lfn := '~thor_data400::key::watchdog::' + pversion + '::univesal';
	sf := '~thor_data400::key::watchdog';
	Roxiekeybuild.Mac_SK_BuildProcess_v3_local(dx_BestRecords.key_watchdog(),
																					wd,
																					sf,
	                                        lfn,
																					build_key
																				);
  Roxiekeybuild.Mac_SK_Move_to_Built_v2(sf,
	                                   lfn,
																		 move_to_built
																		 );
  Roxiekeybuild.Mac_SK_Move_V2(sf, 'Q', move_to_qa);

  merge_key := SEQUENTIAL(
													build_key,
													move_to_built,
													move_to_qa);

  RETURN merge_key;

END;