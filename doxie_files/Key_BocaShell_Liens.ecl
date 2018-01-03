import doxie, doxie_files, bankrupt, ut, data_services;

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
	STRING10 rmsid;
END;

myGetDate := ut.getDate;

slimrec get_liens(bankrupt.File_Liens R) := transform
	self.rmsid := R.rmsid;
	isRecent := if (r.filing_date = '', false, ut.DaysApart(r.filing_date,myGetDate)<365*2+1);
	SELF.liens_recent_unreleased_count := (INTEGER)(r.rmsid<>'' AND 
									  (INTEGER)r.release_date=0 AND
									  isRecent);
	SELF.liens_historical_unreleased_count := (INTEGER)(r.rmsid<>'' AND
										 (INTEGER)r.release_date=0 AND
										 ~isRecent);
	SELF.liens_recent_released_count := (INTEGER)(r.rmsid<>'' AND
									(INTEGER)r.release_date<>0 AND
									isRecent);
	SELF.liens_historical_released_count := (INTEGER)(r.rmsid<>'' AND
									    (INTEGER)r.release_date<>0 AND
									    ~isRecent);
	self.did := (integer)R.did;
end;

w_liens:= project(bankrupt.file_liens((integer)did != 0), get_liens(LEFT));

slimrec roll_liens(w_liens le, w_liens ri) :=
TRANSFORM
	SELF.liens_recent_unreleased_count := le.liens_recent_unreleased_count + IF(le.rmsid=ri.rmsid,0,ri.liens_recent_unreleased_count);
	SELF.liens_recent_released_count := le.liens_recent_released_count + IF(le.rmsid=ri.rmsid,0,ri.liens_recent_released_count);
	
	SELF.liens_historical_unreleased_count := le.liens_historical_unreleased_count + IF(le.rmsid=ri.rmsid,0,ri.liens_historical_unreleased_count);
	SELF.liens_historical_released_count := le.liens_historical_released_count + IF(le.rmsid=ri.rmsid,0,ri.liens_historical_released_count);

	SELF := le;
END;

liens_rolled := rollup(sort(DISTRIBUTE(w_liens,HASH(did)), did, rmsid, local),LEFT.did=RIGHT.did,roll_liens(LEFT,RIGHT), local);	 

liens_slimmed := PROJECT(liens_rolled,slimmerrec);

export Key_BocaShell_Liens := index(liens_slimmed, 
                                    {did}, 
                                    {liens_slimmed}, 
                                    data_services.data_location.prefix() + 'thor_data400::key::liens::bocashell_did_' + doxie.Version_SuperKey);