IMPORT CMS_AddOn;

EXPORT Build_Compare(STRING pversion) := MODULE

  // Customer doesn't want the 2 date fields and the record type in the final data
  oldAddOnFile := PROJECT(DATASET('~foreign::10.194.94.1::thor::base::qa::addson_codes_reference_data',
	                                   CMS_AddOn.Layouts.Reference_Add_On_For_Customer_base, thor),
													TRANSFORM(CMS_AddOn.Layouts.Reference_Add_On_For_Customer_base,
													          SELF := LEFT,
																		SELF := []));
	newAddOnFile := PROJECT(CMS_AddOn.Files().Base.QA,
	                        TRANSFORM(CMS_AddOn.Layouts.Reference_Add_On_For_Customer_base,
													          SELF := LEFT,
																		SELF := []));
	oldAddOnFile_dist := DISTRIBUTE(oldAddOnFile, HASH64(PROC_CD_1, PROC_CD_2));
	newAddOnFile_dist := DISTRIBUTE(newAddOnFile, HASH64(PROC_CD_1, PROC_CD_2));

	inDate := 'D' + pversion;

  // This is really only needed for the first run, but we'll do this every time.  Any duplicates
	//   will be exactly the same, so no speical logic needed.
  oldAddOnFile_dedup := DEDUP(SORT(oldAddOnFile_dist, PROC_CD_1, PROC_CD_2, LOCAL),
	                            PROC_CD_1, PROC_CD_2,
															LOCAL);

	// Grab invalid records from the persist file.
	hasInvalidDate := DATASET('~thor_data400::persist::cms_addon::invalid_termination_dates',
	                             CMS_AddOn.Layouts.Input, thor);
	hasInvalidDate_sort := SORT(hasInvalidDate, AddOnCode, PrimaryCode);

	// Grab new input records from the persist file.
	newInput := DATASET('~thor_data400::persist::cms_addon::final_input', CMS_AddOn.Layouts.Input, thor);
	newInput_dist := DISTRIBUTE(newInput, HASH64(AddOnCode, PrimaryCode));

	onNewNotOnOld := JOIN(newAddOnFile_dist, oldAddOnFile_dedup,
												LEFT.PROC_CD_1 = RIGHT.PROC_CD_1 AND
												   LEFT.PROC_CD_2 = RIGHT.PROC_CD_2,
												TRANSFORM(CMS_AddOn.Layouts.Reference_Add_On_new_only,
																	SELF.NEW_PROC_CD_1        := LEFT.PROC_CD_1,
																	SELF.NEW_PROC_CD_2        := LEFT.PROC_CD_2,
																	SELF.NEW_Effective_Date   := LEFT.Effective_Date,
																	SELF.NEW_Termination_Date := LEFT.Termination_Date),
												LEFT ONLY,
												LOCAL);
	onNewNotOnOld_sort := SORT(onNewNotOnOld, NEW_PROC_CD_1, NEW_PROC_CD_2, RECORD);

	onOldNotOnNew := JOIN(newInput_dist, oldAddOnFile_dedup,
												LEFT.AddOnCode = RIGHT.PROC_CD_1 AND
												   LEFT.PrimaryCode = RIGHT.PROC_CD_2,
												TRANSFORM(CMS_AddOn.Layouts.Reference_Add_On_old_only,
																	SELF.OLD_PROC_CD_1        := RIGHT.PROC_CD_1,
																	SELF.OLD_PROC_CD_2        := RIGHT.PROC_CD_2,
																	SELF.OLD_Effective_Date   := RIGHT.Effective_Date,
																	SELF.OLD_Termination_Date := RIGHT.Termination_Date),
												RIGHT ONLY,
												LOCAL);
	onOldNotOnNew_sort := SORT(onOldNotOnNew, OLD_PROC_CD_1, OLD_PROC_CD_2, RECORD);

	CMS_AddOn.Layouts.Reference_Add_On_diff get_differences(
	   CMS_AddOn.Layouts.Reference_Add_On_For_Customer_base L,
		 CMS_AddOn.Layouts.Reference_Add_On_For_Customer_base R) := TRANSFORM
		SELF.NEW_PROC_CD_1        := L.PROC_CD_1;
		SELF.NEW_PROC_CD_2        := L.PROC_CD_2;
		SELF.NEW_Effective_Date   := L.Effective_Date;
		SELF.NEW_Termination_Date := L.Termination_Date;

		SELF.OLD_PROC_CD_1        := R.PROC_CD_1;
		SELF.OLD_PROC_CD_2        := R.PROC_CD_2;
		SELF.OLD_Effective_Date   := R.Effective_Date;
		SELF.OLD_Termination_Date := R.Termination_Date;
	END;

	compareOnBoth := JOIN(newAddOnFile_dist, oldAddOnFile_dedup,
											  LEFT.PROC_CD_1 = RIGHT.PROC_CD_1 AND
													 LEFT.PROC_CD_2 = RIGHT.PROC_CD_2 AND
													 (LEFT.Effective_Date != RIGHT.Effective_Date OR
														  LEFT.Termination_Date != RIGHT.Termination_Date
													 ),
											  get_differences(LEFT, RIGHT),
											  LOCAL);
	compareOnBoth_sort := SORT(compareOnBoth, NEW_PROC_CD_1, NEW_PROC_CD_2, RECORD);

  countgroup_rec := RECORD
    CountGroup := COUNT(GROUP);
		newAddOnFile.PROC_CD_1;
		newAddOnFile.PROC_CD_2;
	END;

  newAddOnStats := TABLE(newAddOnFile, countgroup_rec, PROC_CD_1, PROC_CD_2);
	newAddOnDuplicates := newAddOnStats(CountGroup > 1);
	newAddOnDupRecords := JOIN(newAddOnFile, newAddOnDuplicates,
	                           LEFT.PROC_CD_1 = RIGHT.PROC_CD_1 AND
														    LEFT.PROC_CD_2 = RIGHT.PROC_CD_2,
														 TRANSFORM(CMS_AddOn.Layouts.Reference_Add_On_For_Customer_base,
														           SELF := LEFT));
	newAddOnDupRecords_sort := SORT(newAddOnDupRecords, PROC_CD_1, PROC_CD_2, RECORD);

  EXPORT All :=
	  SEQUENTIAL(OUTPUT(COUNT(oldAddOnFile_dedup), NAMED('ADDON_cnt_old')),
							 OUTPUT(COUNT(newInput), NAMED('ADDON_cnt_new')),

							 OUTPUT(COUNT(newAddOnDupRecords), NAMED('ADDON_cnt_duplicate_codes')),
							 OUTPUT(COUNT(hasInvalidDate), NAMED('ADDON_cnt_codes_excluded_invalid_term_date')),
							 OUTPUT(COUNT(onNewNotOnOld), NAMED('ADDON_cnt_codes_added_on_New_Not_On_Old')),
							 OUTPUT(COUNT(onOldNotOnNew), NAMED('ADDON_cnt_codes_kept_on_Old_Not_On_New')),
							 OUTPUT(COUNT(compareOnBoth), NAMED('ADDON_cnt_changed')),

							 OUTPUT(newAddOnDupRecords_sort, , '~thor::ReferenceCompare::ADDON_cnt_duplicate_codes_' + inDate, COMPRESSED, OVERWRITE),
							 OUTPUT(hasInvalidDate_sort, , '~thor::ReferenceCompare::ADDON_cnt_codes_excluded_invalid_term_date_' + inDate, COMPRESSED, OVERWRITE),
							 OUTPUT(onNewNotOnOld_sort, , '~thor::ReferenceCompare::ADDON_cnt_codes_added_on_New_Not_On_Old_' + inDate, COMPRESSED, OVERWRITE),
							 OUTPUT(onOldNotOnNew_sort, , '~thor::ReferenceCompare::ADDON_cnt_codes_kept_on_Old_Not_On_New_' + inDate, COMPRESSED, OVERWRITE),
							 OUTPUT(compareOnBoth_sort, , '~thor::ReferenceCompare::ADDON_cnt_changed_' + inDate, COMPRESSED, OVERWRITE));

END;