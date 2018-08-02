/*2013-05-28T13:07:02Z (Michele Walklin_prod)
code review AML
*/
import _Control, faa, riskwise, ut;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Aircraft_Hist_FCRA(GROUPED DATASET(Layout_Boca_Shell_ids) ids_only) := FUNCTION

checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;


// temporary layout; for linking only.
layout_reg_ids := RECORD (Riskwise.Layouts.Layout_Aircraft_Plus)
                unsigned6 aircraft_id; // unique (but not persistent) registration record identifier
                string8 hist_date;
END;

// new did-key-fcra doesn't have a payload; grap registrations records IDs first
key_did := faa.key_aircraft_did (true); 

layout_reg_ids GetIDs(ids_only le, key_did ri) := transform
                self.aircraft_id := ri.aircraft_id;
                self.n_number := '';
                self.date_first_seen := '';
                self.hist_date := iid_constants.myGetDate(le.historydate); // do it here: just once for each row
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

// now fetch main registration records;
key_ids := faa.key_aircraft_id (true);

// Get main (registration) records
layout_reg_ids GetRawRegistration (layout_reg_ids le, key_ids ri) := transform
                self.seq := le.seq;
  self.did := le.did;
                self.hist_date := le.hist_date;
                self.n_number := ri.n_number;
                self.date_first_seen := ri.date_first_seen;
                self := []; // counts
end;       

reg_raw_roxie := join (reg_ids, key_ids, 
                 left.aircraft_id != 0 and keyed (left.aircraft_id = right.aircraft_id),
                 GetRawRegistration (Left, Right),
                 left outer, keep (1), limit (0));

reg_raw_thor_pre := join (distribute(reg_ids(aircraft_id != 0), hash64(aircraft_id)), 
									distribute(pull(key_ids), hash64(aircraft_id)), 
                 (left.aircraft_id = right.aircraft_id),
                 GetRawRegistration (Left, Right),
                 left outer, keep (1), limit (0), LOCAL);
reg_raw_thor := group(sort(reg_raw_thor_pre + project(reg_ids(aircraft_id=0), transform(layout_reg_ids, self := LEFT, self := [])), seq),seq);

#IF(onThor)
	reg_raw := reg_raw_thor;
#ELSE
	reg_raw := reg_raw_roxie;
#END

// combine and take only "latest" first-seen registration record for each aircraft
aircrafts := dedup (sort (reg_raw, seq, n_number, -date_first_seen), seq, n_number);
all_reg := group (sort (ungroup (aircrafts), seq), seq);

Riskwise.Layouts.Layout_Aircraft_Plus SetCounts (layout_reg_ids L, dataset (layout_reg_ids) R) := transform
  myGetDate := L.hist_date;
                self.aircraft_count := count (R (n_number != ''));
                self.aircraft_count30  := count (R (checkDays (myGetDate, R.date_first_seen, 30)));
                self.aircraft_count90  := count (R (checkDays (myGetDate, R.date_first_seen, 90)));
                self.aircraft_count180 := count (R (checkDays (myGetDate, R.date_first_seen, 180)));
                self.aircraft_count12  := count (R (checkDays (myGetDate, R.date_first_seen, ut.DaysInNYears(1))));
                self.aircraft_count24  := count (R (checkDays (myGetDate, R.date_first_seen, ut.DaysInNYears(2))));
                self.aircraft_count36  := count (R (checkDays (myGetDate, R.date_first_seen, ut.DaysInNYears(3))));
                self.aircraft_count60  := count (R (checkDays (myGetDate, R.date_first_seen, ut.DaysInNYears(5))));
								self.aircraft_build_date := Risk_Indicators.get_Build_date('faa_build_version');				
   Self := L;
end;
aircraft_counts := rollup (all_reg, GROUP, SetCounts (Left, ROWS (Left)));

// project to slim output; blank ambigues fields (results actually have aggregated data)
res := project (aircraft_counts, transform (Riskwise.Layouts.Layout_Aircraft_Plus, Self.n_number := '', Self.date_first_seen := '', Self := Left));
// res := project (all_reg, transform (Riskwise.Layouts.Layout_Aircraft_Plus, Self.n_number := '', Self.date_first_seen := '', Self := Left));
return group (sort (res, seq), seq);

end;
