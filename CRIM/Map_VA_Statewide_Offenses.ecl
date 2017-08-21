import crim, crim_common;

//Fix for Bugzilla #59753 - Court Descriprion not populated for VA Criminal Court
ds_offender 		:= dataset('~thor_data400::in::court_offender_va_crim_clean_20090605b', crim_common.Layout_In_Court_Offender,flat);

	ds_slim_layout := record
		string offender_key;
		string case_court;
	end;

	ds_slim_layout courtDesc(ds_offender l):= transform
		self := l;
	end;

case_court 			:= project(ds_offender, courtDesc(left));

case_court_slim		:= sort(distribute(case_court, hash(offender_key)), offender_key, local);
ds_offense 			:= sort(distribute(dataset('~thor_data400::in::court_offenses_va_crim_20090605', crim_common.Layout_In_Court_Offenses,flat), hash(offender_key)), offender_key, local);

	crim_common.Layout_In_Court_Offenses joinKeys(ds_offense l, case_court_slim r) := transform
		self.court_desc := r.case_court;
		self := l;
	end;

	populateCourt	:= join(ds_offense, case_court_slim, 
							left.offender_key = right.offender_key, 
							joinKeys(left, right), left outer, local);

	dedup_join		:= dedup(sort(populateCourt, offender_key), all) : PERSIST('~thor_dell400::persist::Crim_VA_Statewide_Offenses_Clean');


export Map_VA_Statewide_Offenses := dedup_join;