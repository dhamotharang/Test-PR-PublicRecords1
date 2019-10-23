IMPORT Gong_Neustar, header;
EXPORT fn_GetGongPhone(dataset(header.Layout_Header_V2) h) := FUNCTION
	gong := PULL(Gong_Neustar.Key_History_did)(current_flag=true);
	dup := dedup(sort(DISTRIBUTE(gong,did),did,phone10,-dt_first_seen,local),did,phone10,local);
	j := JOIN(DISTRIBUTE(h,did), dup, left.did=right.did, TRANSFORM(header.Layout_Header_v2,
								self.phone := right.phone10;
								self := LEFT;), KEEP(1), LEFT OUTER, local);
	return j;
END;
