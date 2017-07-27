import doxie, doxie_files, watchdog, bankrupt, ut, risk_indicators;

layout_date := RECORD
	unsigned4 date;
  string16  rmsid; // need this to track corrections
END;

slimrec := record
	unsigned6	did;
	DATASET(layout_date) liens_recent_unreleased_count {MAXCOUNT(100)};
	DATASET(layout_date) liens_historical_unreleased_count {MAXCOUNT(100)};
	DATASET(layout_date) liens_recent_released_count {MAXCOUNT(100)};
	DATASET(layout_date) liens_historical_released_count {MAXCOUNT(100)};
END;

slimrec_rmsid := RECORD
	slimrec;
	string16 rmsid; // need this to track the same liens in the final Rollup
END;

myGetDate := ut.getDate;

slimrec_rmsid get_liens(bankrupt.File_Liens R) := transform
	SELF.did := (integer)R.did;
	SELF.rmsid := R.rmsid;
	boolean isRecent := if (r.filing_date = '', false, ut.DaysApart(r.filing_date,myGetDate)<365*2+1);
  boolean IsReleased := (INTEGER)r.release_date <> 0;	
	fcra_date := ut.max2((unsigned4)r.filing_date,(unsigned4)r.release_date);
	
  save_lien := DATASET([{fcra_date, R.rmsid}],layout_date);
	SELF.liens_recent_unreleased_count     := IF(NOT IsReleased AND isRecent, save_lien);
	SELF.liens_historical_unreleased_count := IF(NOT IsReleased AND ~isRecent, save_lien);
	SELF.liens_recent_released_count       := IF(IsReleased     AND isRecent, save_lien);
	SELF.liens_historical_released_count   := IF(IsReleased     AND ~isRecent, save_lien);
end;
// filter by rmsid here
w_liens:= project(bankrupt.file_liens((integer)did != 0, rmsid<>''), get_liens(LEFT));

// combine all liens for every given did
slimrec_rmsid roll_liens(slimrec_rmsid le, slimrec_rmsid ri) :=
TRANSFORM
	SELF.liens_recent_unreleased_count := CHOOSEN(le.liens_recent_unreleased_count + IF(~(le.rmsid=ri.rmsid),ri.liens_recent_unreleased_count),100);
	SELF.liens_recent_released_count := CHOOSEN(le.liens_recent_released_count + IF(~(le.rmsid=ri.rmsid),ri.liens_recent_released_count),100);
	
	SELF.liens_historical_unreleased_count := CHOOSEN(le.liens_historical_unreleased_count + IF(~(le.rmsid=ri.rmsid),ri.liens_historical_unreleased_count),100);
	SELF.liens_historical_released_count := CHOOSEN(le.liens_historical_released_count + IF(~(le.rmsid=ri.rmsid),ri.liens_historical_released_count),100);

	SELF := le;
END;

liens_rolled := rollup(sort(DISTRIBUTE(w_liens,HASH(did)), did, rmsid, local),LEFT.did=RIGHT.did,roll_liens(LEFT,RIGHT), local);	 

liens_slimmed := PROJECT (liens_rolled, slimrec);
export Key_BocaShell_Liens_FCRA := index(liens_slimmed, {did}, {liens_slimmed}, '~thor_data400::key::liens::fcra::bocashell_did_' + doxie.Version_SuperKey);