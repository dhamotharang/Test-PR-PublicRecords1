import ut,std;

EXPORT AgencyDeletes := module;

		cfs_deletes				:= Bair.files().agency_deletes_input(field1 = 'CFS');
		event_deletes			:= Bair.files().agency_deletes_input(field1 = 'EVENT');
		offenders_deletes	:= Bair.files().agency_deletes_input(field1 = 'OFFENDERS');
		crash_deletes			:= Bair.files().agency_deletes_input(field1 = 'CRA');
		lpr_deletes				:= Bair.files().agency_deletes_input(field1 = 'LPR');
		
		ts := Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u');

		deletes := 	project(cfs_deletes, transform(Bair.Layouts.AgencyDeletes_Base, SELF.ts := (unsigned6)regexreplace('-', ts, ''); SELF.eid 	:= trim('CFS' + (string)(unsigned8)hash64(trim(left.field3, left, right) + ':' + left.field2), left, right);))
											+
								project(event_deletes, transform(Bair.Layouts.AgencyDeletes_Base, SELF.ts := (unsigned6)regexreplace('-', ts, ''); self.eid := trim('EVE' + (string)(unsigned8)hash64(trim(left.field3, left, right) + ':' + left.field2), left, right);))
											+
								project(offenders_deletes, transform(Bair.Layouts.AgencyDeletes_Base, SELF.ts := (unsigned6)regexreplace('-', ts, ''); self.eid := trim('OFF' + (string)(unsigned8)hash64(trim(left.field3, left, right) + ':' + left.field2), left, right);))
											+
								project(crash_deletes, transform(Bair.Layouts.AgencyDeletes_Base, SELF.ts := (unsigned6)regexreplace('-', ts, ''); self.eid := trim('CRA' + (string)(unsigned8)hash64(trim(left.field3, left, right) + ':' + left.field2), left, right);))
											+
								project(lpr_deletes, transform(Bair.Layouts.AgencyDeletes_Base, SELF.ts := (unsigned6)regexreplace('-', ts, ''); self.eid := trim('LPR' + (string)(unsigned8)hash64(trim(left.field3, left, right) + ':' + left.field2), left, right);));
		
		EXPORT eids_to_delete := 	dedup(deletes, eid, all);
END;
			