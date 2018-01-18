import doxie, doxie_files, ut, liensv2, data_services;

liens_party := distribute(LiensV2.file_liens_party,hash(tmsid,rmsid));
liens_main := distribute(LiensV2.file_liens_main,hash(tmsid,rmsid));

layout_date := RECORD
	unsigned4 date;
	string50  tmsid; // need this to track corrections
	string50  rmsid; // need this to track corrections
	boolean   eviction;
END;

slimrec := record
	unsigned6	did;
	DATASET(layout_date) liens_recent_unreleased_count {MAXCOUNT(25)};
	DATASET(layout_date) liens_historical_unreleased_count {MAXCOUNT(25)};
	DATASET(layout_date) liens_recent_released_count {MAXCOUNT(25)};
	DATASET(layout_date) liens_historical_released_count {MAXCOUNT(25)};
END;

slimrec_rmsid := RECORD
	slimrec;
	string50  tmsid; // need this to track the same liens in the final Rollup
	string50  rmsid; // need this to track the same liens in the final Rollup
END;

myGetDate := ut.getDate;

slimrec_rmsid get_liens(LiensV2.file_liens_party le, LiensV2.file_liens_main ri) := transform
	SELF.did := (integer)le.did;
	SELF.rmsid := le.rmsid;
	self.tmsid := le.tmsid;
	boolean isRecent := if (le.date_first_seen = '', false, ut.DaysApart(le.date_first_seen,myGetDate)<365*2+1);
	isDebtor := le.rmsid<>'' and le.name_type='D';
  boolean IsReleased := (INTEGER)le.date_last_seen <> 0;	
	fcra_date := (unsigned4)le.date_first_seen;
	
	save_lien := DATASET([{fcra_date, le.tmsid, le.rmsid, ri.eviction}],layout_date);
	SELF.liens_recent_unreleased_count     := IF(isDebtor and ~IsReleased AND isRecent, save_lien);
	SELF.liens_historical_unreleased_count := IF(isDebtor and ~IsReleased AND ~isRecent, save_lien);
	SELF.liens_recent_released_count       := IF(isDebtor and IsReleased     AND isRecent, save_lien);
	SELF.liens_historical_released_count   := IF(isDebtor and IsReleased     AND ~isRecent, save_lien);
end;
w_liens := join(liens_party((integer)did!=0,rmsid<>''  and tmsid<>'' and name_type='D'), 
								liens_main(rmsid<>'' and tmsid<>'' and eviction='Y'), 
											left.tmsid=right.tmsid and left.rmsid=right.rmsid, 
											get_liens(LEFT,RIGHT), left outer, local);





// combine all liens for every given did
slimrec_rmsid roll_liens(slimrec_rmsid le, slimrec_rmsid ri) :=
TRANSFORM
	SELF.liens_recent_unreleased_count := CHOOSEN(le.liens_recent_unreleased_count + IF(~(le.tmsid=ri.tmsid and le.rmsid=ri.rmsid),ri.liens_recent_unreleased_count),25);
	SELF.liens_recent_released_count := CHOOSEN(le.liens_recent_released_count + IF(~(le.tmsid=ri.tmsid and le.rmsid=ri.rmsid),ri.liens_recent_released_count),25);
	
	SELF.liens_historical_unreleased_count := CHOOSEN(le.liens_historical_unreleased_count + IF(~(le.tmsid=ri.tmsid and le.rmsid=ri.rmsid),ri.liens_historical_unreleased_count),25);
	SELF.liens_historical_released_count := CHOOSEN(le.liens_historical_released_count + IF(~(le.tmsid=ri.tmsid and le.rmsid=ri.rmsid),ri.liens_historical_released_count),25);

	SELF := ri;
END;

liens_dist := DISTRIBUTE(w_liens,HASH(did)); 
liens_rolled := rollup(sort(liens_dist, did, tmsid, rmsid, local),LEFT.did=RIGHT.did,roll_liens(LEFT,RIGHT), local);	 

liens_slimmed := PROJECT (liens_rolled, transform(slimrec, 
						self.did := left.did,
						self.liens_recent_unreleased_count := left.liens_recent_unreleased_count,
						self.liens_historical_unreleased_count := left.liens_historical_unreleased_count,
						self.liens_recent_released_count := left.liens_recent_released_count,
						self.liens_historical_released_count := left.liens_historical_released_count));
						
export Key_BocaShell_LiensV2_FCRA := index(liens_slimmed, 
                                           {did}, 
                                           {liens_slimmed}, 
                                           data_services.data_location.prefix() + 'thor_data400::key::liensv2::fcra::bocashell_did_' + doxie.Version_SuperKey);