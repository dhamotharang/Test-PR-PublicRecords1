import ut,Workers_Compensation;

EXPORT Rollup_Base(DATASET(Layouts.Keybuild_FULL) pDataset) := FUNCTION

	pDataset_sort	:=	sort(pDataset,
												 except Date_FirstSeen, Date_lastSeen, source_rec_id );
   
	Layouts.Keybuild_FULL RollupUpdate(Layouts.Keybuild_FULL l, Layouts.Keybuild_FULL r) := transform
	
		self.Date_FirstSeen	:= ut.EarliestDate( ut.EarliestDate(l.Date_FirstSeen, r.Date_FirstSeen),
																						ut.EarliestDate(l.Date_lastSeen, r.Date_lastSeen)
																					 );
		self.Date_lastSeen	:= max(l.Date_lastSeen,r.Date_lastSeen);
		self.source_rec_id	:= if(l.source_rec_id <> 0,l.source_rec_id,r.source_rec_id);				
		self                := l;
		
 	end;
	
	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,record
														,except Date_FirstSeen, Date_lastSeen, source_rec_id );
  
	ut.MAC_Append_Rcid(pDataset_rollup, source_rec_id, pDataset_rollup_id);                            
	
	return pDataset_rollup_id;
	
end;