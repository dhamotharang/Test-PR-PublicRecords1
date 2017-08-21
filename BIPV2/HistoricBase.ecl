import BIPV2_Files;

export HistoricBase := module

	// Add back in appropriate removed records and use history file to reproduce
	// the specified version.
	export Get(string ver, dataset(BipV2.CommonBase.Layout) currentBase = BipV2.CommonBase.DS_BASE) := function
		historySubName := BipV2_Files.Files_CommonBase.HistorySubName(ver);
		history := pull(BipV2_Files.Files_CommonBase.HistoryKey(historySubName));

		removedRecs := BIPV2_Files.files_CommonBase.DS_REMOVED;
		removedToAdd0 := dedup(sort(distribute(removedRecs(dt_removed > (typeof(dt_removed))ver[1..8]),
		                                       hash32(rcid)),
		                            rcid, dt_removed, local),
		                       rcid, local);
		
		removedToAdd := project(removedToAdd0, recordof(currentBase));

		// if for some reason an rcid was reused, pick the right one
		currentNoDupRcid := 
			join(currentBase, removedToAdd,
				left.rcid = right.rcid,
				transform(left),
				hash, left only);

		oldBase :=
			join(history, currentNoDupRcid + removedToAdd,
				left.rcid = right.rcid,
				transform(recordof(right),
					self.cnt_rcid_per_dotid := 0,
					self.cnt_dot_per_proxid := 0,
					self.cnt_prox_per_lgid3 := 0,
					self.cnt_prox_per_powid := 0,
					self.cnt_dot_per_empid := 0,
					self := left,
					self := right),
				limit(1), hash);

		return oldBase;
	end;


end;