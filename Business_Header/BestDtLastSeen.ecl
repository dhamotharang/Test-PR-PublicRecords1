// Most frequent dt_last_seen per BDID.
IMPORT ut;

export BestDtLastSeen(

	dataset(business_header.Layout_Business_Header_Base) bh = Files().Base.Business_Headers.Built

) := FUNCTION

//bh_dtLastSeen := bh(dt_last_seen != 0);

// Keep the most frequent dt_last_seen for each bdid.
bh_d_dep_bdid := dedup(Sort(DISTRIBUTE(bh, HASH(bdid)),bdid, -dt_last_seen,local),bdid,local);

layout_dtLastSeen := RECORD
	bh.bdid;
	bh.dt_last_seen;	
END;

bh_bestDtLastSeen   := project(bh_d_dep_bdid, transform(layout_dtLastSeen, self := left));

return bh_bestDtLastSeen;

end;