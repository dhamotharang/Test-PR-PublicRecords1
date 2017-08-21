EXPORT proc_getDeceased(dataset(Spokeo.Layout_temp) basein) := FUNCTION

	d := DISTRIBUTE(Spokeo.dDeceased, did);
	sp := DISTRIBUTE(basein(LexId<>0), LexId);
	
	result := JOIN(sp, d, left.LexId=right.did, TRANSFORM(Spokeo.Layout_Temp,
							self.deceased := IF(right.dod8='', false, true);
							self := left;), LEFT OUTER, LOCAL);
	
	return result + basein(LexId=0);
	
END;