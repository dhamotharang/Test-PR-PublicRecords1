/*
The last LSSi history file must be in File_Final_LSSI_History

This will merge the LSSi records with the neustar master
Matching LSSi records will be replaced with neustar records
non-matching records will have the current record flag cleared

the asof date will be the deletion date for the LSSi records

*/
EXPORT MigrateLssiToNeustar(string asof) := FUNCTION
	h := Gong_Neustar.File_Final_LSSI_History;

	mstr1 := PROJECT(gong_neustar.File_Master, TRANSFORM(layout_gongmaster,
										self.persistent_record_id := 0;
										self := left;));
	
	seed := MAX(h, persistent_record_id) + 1;
	mstr2 := Gong_Neustar.Mac_Assign_UniqueId(mstr1, persistent_record_id, seed);
	
	mstr := Gong_Neustar.proc_LinkUp(mstr2);

	h0 := Gong_Neustar.ProcessFinalLssiHistory(h(current_record_flag='Y'), mstr, asof);
	h1 := DISTRIBUTE(h(current_record_flag<>'Y') & h0);

	return SEQUENTIAL (
		OUTPUT(mstr,,'~thor::base::gong_master::' + asof + '::migrated',COMPRESSED,OVERWRITE),
		OUTPUT(h1,,'~thor::base::gong_history::' + asof + '::migrated',COMPRESSED,OVERWRITE),
		OUTPUT(mstr,,'~thor::base::gong_master::' + asof + '::migrated::backup',COMPRESSED,OVERWRITE),
		OUTPUT(h1,,'~thor::base::gong_history::' + asof + '::migrated::backup',COMPRESSED,OVERWRITE),
		Promotions.Master('~thor::base::gong_master::' + asof + '::migrated'),
		Promotions.History('~thor::base::gong_history::' + asof + '::migrated')
	);
END;

