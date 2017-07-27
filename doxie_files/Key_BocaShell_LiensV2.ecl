import doxie, doxie_files, watchdog, liensv2, ut, risk_indicators;

slimmerrec := record
	unsigned6	did;
	UNSIGNED1 liens_recent_unreleased_count;
	UNSIGNED1 liens_historical_unreleased_count;
	UNSIGNED1 liens_recent_released_count;
	UNSIGNED1 liens_historical_released_count;
END;

slimrec :=
RECORD
	slimmerrec;
	// liens extras
	string50 tmsid;
	STRING50 rmsid;
END;

myGetDate := ut.getDate;

slimrec get_liens(LiensV2.file_liens_party R) := transform
	self.tmsid := R.tmsid;
	self.rmsid := R.rmsid;
	isRecent := if (r.date_first_seen = '', false, ut.DaysApart(r.date_first_seen,myGetDate)<365*2+1);
	isDebtor := r.rmsid<>'' and r.name_type='D';
	SELF.liens_recent_unreleased_count := (INTEGER)(isDebtor AND 
									  (INTEGER)r.date_last_seen=0 AND
									  isRecent);
	SELF.liens_historical_unreleased_count := (INTEGER)(isDebtor AND
										 (INTEGER)r.date_last_seen=0 AND
										 ~isRecent);
	SELF.liens_recent_released_count := (INTEGER)(isDebtor AND
									(INTEGER)r.date_last_seen<>0 AND
									isRecent);
	SELF.liens_historical_released_count := (INTEGER)(isDebtor AND
									    (INTEGER)r.date_last_seen<>0 AND
									    ~isRecent);
	self.did := (integer)R.did;
end;

w_liens:= project(LiensV2.file_liens_party((integer)did != 0), get_liens(LEFT));

slimrec roll_liens(w_liens le, w_liens ri) :=
TRANSFORM
	SELF.liens_recent_unreleased_count := le.liens_recent_unreleased_count + IF(le.tmsid=ri.tmsid and le.rmsid=ri.rmsid,0,ri.liens_recent_unreleased_count);
	SELF.liens_recent_released_count := le.liens_recent_released_count + IF(le.tmsid=ri.tmsid and le.rmsid=ri.rmsid,0,ri.liens_recent_released_count);
	
	SELF.liens_historical_unreleased_count := le.liens_historical_unreleased_count + IF(le.tmsid=ri.tmsid and le.rmsid=ri.rmsid,0,ri.liens_historical_unreleased_count);
	SELF.liens_historical_released_count := le.liens_historical_released_count + IF(le.tmsid=ri.tmsid and le.rmsid=ri.rmsid,0,ri.liens_historical_released_count);

	SELF := le;
END;

liens_rolled := rollup(sort(DISTRIBUTE(w_liens,HASH(did)), did, tmsid, rmsid, local),LEFT.did=RIGHT.did,roll_liens(LEFT,RIGHT), local);	 

liens_slimmed := PROJECT(liens_rolled,slimmerrec);

export Key_BocaShell_LiensV2 := index(liens_slimmed, {did}, {liens_slimmed}, '~thor_data400::key::liensv2::bocashell_did_' + doxie.Version_SuperKey);