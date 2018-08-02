import _Control, faa, FCRA, riskwise, ut;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Aircraft_FCRA(GROUPED DATASET(Layout_Boca_Shell_ids) ids_only) := FUNCTION

// for riskview attributes v5 requirements, modify version 3,4,5 attributes to calculate the age of aircraft attributes based upon build dates instead of today's date.
aircraft_build_date := Risk_Indicators.get_Build_date('faa_build_version');
myGetDate := aircraft_build_date;

checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;


// temporary layout; for linking only.
layout_reg_ids := RECORD (Riskwise.Layouts.Layout_Aircraft_Plus)
  // set of flag file IDs to get override records
  Layout_Boca_Shell_ids.air_correct_ffid;
  // set of persistent record IDs: identifies registration records in a raw file which need suppression/correction
  Layout_Boca_Shell_ids.air_correct_record_id;
                unsigned6 aircraft_id; // unique (but not persistent) registration record identifier
END;

// new did-key-fcra doesn't have a payload; grap registrations records IDs first
key_did := faa.key_aircraft_did (true); 

layout_reg_ids GetIDs(ids_only le, key_did ri) := transform
                self.aircraft_id := ri.aircraft_id;
                self.n_number := '';
                self.date_first_seen := '';
                self := le;
                self := [];
end;       

reg_ids_roxie := join (ids_only, key_did,
                 left.did != 0 and keyed(left.did = right.did),
                 GetIDs (Left, Right),
                 left outer, atmost(keyed(left.did=right.did),
                 riskwise.max_atmost));

reg_ids_thor_did := join (distribute(ids_only(did!=0), hash64(did)), 
								 distribute(pull(key_did), hash64(did)),
                 (left.did = right.did),
                 GetIDs (Left, Right),
                 left outer, atmost(left.did=right.did,
                 riskwise.max_atmost), LOCAL);
reg_ids_thor := group(sort(reg_ids_thor_did + project(ids_only(did=0), transform(layout_reg_ids, self := LEFT, self := [])),seq),seq);

#IF(onThor)
	reg_ids := reg_ids_thor;
#ELSE
	reg_ids := reg_ids_roxie;
#END

// now fetch main registration records; suppressing overrides, if any
key_ids := faa.key_aircraft_id (true);

// Get main (registration) records
Riskwise.Layouts.Layout_Aircraft_Plus GetRawRegistration (layout_reg_ids le, key_ids ri) := transform
                self.seq := le.seq;
  self.did := le.did;
                self.n_number := ri.n_number;
                self.date_first_seen := ri.date_first_seen;
                self := []; // counts
end;       

reg_raw_roxie := join (reg_ids, key_ids, 
                 left.aircraft_id != 0 and keyed (left.aircraft_id = right.aircraft_id) and
                 ((string)right.persistent_record_id not in left.air_correct_ffid),
                 GetRawRegistration (Left, Right),
                 left outer, keep (1), limit (0));

reg_raw_thor_pre := join (distribute(reg_ids(aircraft_id!=0), hash64(aircraft_id)), 
								 distribute(pull(key_ids), hash64(aircraft_id)), 
                 left.aircraft_id = right.aircraft_id and
                 ((string)right.persistent_record_id not in left.air_correct_ffid),
                 GetRawRegistration (Left, Right),
                 left outer, keep (1), limit (0), LOCAL);
reg_raw_thor := group(sort(reg_raw_thor_pre + project(reg_ids(aircraft_id=0), transform(Riskwise.Layouts.Layout_Aircraft_Plus, self := LEFT, self := [])), seq),seq);

#IF(onThor)
	reg_raw := reg_raw_thor;
#ELSE
	reg_raw := reg_raw_roxie;
#END

// Get corrections (same transform as above, just different input)
Riskwise.Layouts.Layout_Aircraft_Plus GetCorrections (Layout_Boca_Shell_ids le, fcra.key_override_faa.aircraft ri) := transform
                self.seq := le.seq;
  self.did := le.did;
                self.n_number := ri.n_number;
                self.date_first_seen := ri.date_first_seen;
                self := []; // counts
end;       
reg_corrected_roxie := join (ids_only, fcra.key_override_faa.aircraft,
                       keyed (Right.flag_file_id IN Left.air_correct_ffid),
                       GetCorrections (Left, Right),
                       atmost(right.flag_file_id in left.air_correct_ffid, 100)); // Note: inner join

reg_corrected_thor := join (ids_only(air_correct_ffid<>[]), pull(fcra.key_override_faa.aircraft),
                       Right.flag_file_id IN Left.air_correct_ffid,
                       GetCorrections (Left, Right), LOCAL, ALL); // Note: inner join
											 
#IF(onThor)
	reg_corrected := reg_corrected_thor;
#ELSE
	reg_corrected := reg_corrected_roxie;
#END

// combine and take only "latest" first-seen registration record for each aircraft
combined := ungroup (reg_raw + reg_corrected);
aircrafts := dedup (sort (combined, seq, n_number, -date_first_seen), seq, n_number);
all_reg := group (sort (aircrafts, seq, n_number), seq);

Riskwise.Layouts.Layout_Aircraft_Plus SetCounts (Riskwise.Layouts.Layout_Aircraft_Plus L, dataset (Riskwise.Layouts.Layout_Aircraft_Plus) R) := transform
                self.aircraft_count := count (R (n_number != ''));
                self.aircraft_count30  := count (R (checkDays (myGetDate, R.date_first_seen, 30)));
                self.aircraft_count90  := count (R (checkDays (myGetDate, R.date_first_seen, 90)));
                self.aircraft_count180 := count (R (checkDays (myGetDate, R.date_first_seen, 180)));
                self.aircraft_count12  := count (R (checkDays (myGetDate, R.date_first_seen, ut.DaysInNYears(1))));
                self.aircraft_count24  := count (R (checkDays (myGetDate, R.date_first_seen, ut.DaysInNYears(2))));
                self.aircraft_count36  := count (R (checkDays (myGetDate, R.date_first_seen, ut.DaysInNYears(3))));
                self.aircraft_count60  := count (R (checkDays (myGetDate, R.date_first_seen, ut.DaysInNYears(5))));
								self.aircraft_build_date := myGetDate;
   Self := L;
end;
aircraft_counts := rollup (all_reg, GROUP, SetCounts (Left, ROWS (Left)));

// project to slim output; blank ambigues fields (results actually have aggregated data)
res := project (aircraft_counts, transform (Riskwise.Layouts.Layout_Aircraft_Plus, Self.n_number := '', Self.date_first_seen := '', Self := Left));

return group (sort (res, seq), seq); // grouped rollup changes the grouping

end;
