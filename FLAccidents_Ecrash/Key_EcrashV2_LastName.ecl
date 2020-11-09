IMPORT STD;
	 
dseCrashSearch := File_KeybuildV2.eCrashSearchRecs(lname <> '');
feCrashSearch := dseCrashSearch(TRIM(lname, LEFT, RIGHT) <> TRIM(orig_lname, LEFT, RIGHT) AND  
                                (STD.Str.CountWords(lname, ' ') > 1 OR STD.Str.CountWords(orig_lname, ' ') > 1) AND 
													      orig_lname <> '');
Layouts.key_search_layout tCopyNames(Layouts.key_search_layout L) := TRANSFORM
	SELF.fname := L.orig_fname;
	SELF.lname := L.orig_lname;
	SELF.mname := L.orig_mname;
	SELF := L;
END;
peCrashSearch := PROJECT(feCrashSearch, tCopyNames(LEFT)); 

Layouts.key_slim_layout	tModifyLayout(Layouts.key_search_layout L) := TRANSFORM
  SELF.lname := L.lname;
	SELF.fname := L.fname;
	SELF.mname := L.mname;
	SELF := L;
END;
pSlimeCrashSearch := PROJECT(peCrashSearch + dseCrashSearch, tModifyLayout(LEFT));

dSlimeCrashSearch	:= DISTRIBUTED(pSlimeCrashSearch, HASH32(accident_nbr)); 
sSlimeCrashSearch	:= SORT(dSlimeCrashSearch, accident_nbr, lname, report_code, jurisdiction_state, jurisdiction, accident_date, report_type_id, LOCAL); 
uSlimeCrashSearch	:= DEDUP(sSlimeCrashSearch, accident_nbr, lname, report_code, jurisdiction_state, jurisdiction, accident_date, report_type_id, LOCAL); 

EXPORT Key_EcrashV2_LastName := INDEX(uSlimeCrashSearch,
																		 {lname, jurisdiction_state, jurisdiction},
																		 {uSlimeCrashSearch},
																		 Files_eCrash.FILE_KEY_LAST_NAME_STATE_SF);