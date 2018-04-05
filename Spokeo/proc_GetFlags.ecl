import Std, Infutor;


EXPORT proc_GetFlags(dataset(Spokeo.Layout_temp) basein) := FUNCTION

	candidates := DISTRIBUTE(basein(LexId<>0,address_source='S'), LexId);
	flags := Infutor.GetIndicatorFlags(basein, LexId, fname,mname,lname,name_suffix,p_city_name,st);
	
	dflags := DEDUP(flags, RECORD, ALL);
	
	merged := join(candidates, DISTRIBUTE(dflags, LexId), left.LexId=right.LexId, TRANSFORM(Spokeo.Layout_Temp,
										self.judgments := right.judgments;
										self.civilCourtRecords := right.civilCourtRecords;
										self.crimCourtRecords := right.crimCourtRecords;
										self.curr_incar_flag := right.curr_incar_flag;
										self.foreclosures := right.foreclosures;
										self.bankruptcy := right.bankruptcy;
										self := left;), LEFT OUTER, KEEP(1), LOCAL);

	return merged + basein(LexId=0 OR address_source<>'S');

END;