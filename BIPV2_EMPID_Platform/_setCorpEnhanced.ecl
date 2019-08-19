// The isCorp field is assigned on a per-record basis during Ingest.  However, what we know
// from one record can improve the understanding of another, and can be propagated throughout
// an UltID cluster.  This routine does that.

l_EmpID := BIPV2_EMPID_Platform.Layout_EmpID;

EXPORT DATASET(l_EmpID) _setCorpEnhanced(DATASET(l_EmpID) ds_in) := FUNCTION

	// Build table of corporation names
	ds_filt	:= ds_in(isCorp='T',cnp_name<>'',st<>'' OR company_inc_state<>'');
	ds_st1	:= TABLE(ds_filt, {cnp_name, st, company_inc_state}, cnp_name, st, company_inc_state, merge);
	ds_st2	:= PROJECT(ds_st1(company_inc_state<>'' AND company_inc_state<>st), TRANSFORM(RECORDOF(ds_st1), SELF.st:=LEFT.company_inc_state, SELF:=LEFT));
	ds_CorpNames := TABLE(ds_st1(st<>'')+ds_st2, {cnp_name, st}, cnp_name, st, merge);
	
	// Extend isCorp='T' knowledge to other records sharing the same corporation names
	ds_filt_in	:= ds_in(cnp_name<>'' AND st<>'' AND isCorp<>'T');	// recs we might be able to extend
	ds_filt_out	:= ds_in(cnp_name='' OR st='' OR isCorp='T');				// recs we can't (or don't need to) extend
	ds_extend_in := JOIN(
		ds_filt_in, ds_CorpNames,
		LEFT.cnp_name=RIGHT.cnp_name AND LEFT.st=RIGHT.st,
		TRANSFORM(l_EmpID, SELF.isCorpEnhanced:=IF(RIGHT.cnp_name<>'','T',LEFT.isCorp), SELF:=LEFT),
		LEFT OUTER, KEEP(1), HASH
	);
	ds_extend_out := PROJECT(ds_filt_out, TRANSFORM(l_EmpID, SELF.isCorpEnhanced:=LEFT.isCorp, SELF:=LEFT));
	ds_extend := ds_extend_in + ds_extend_out;
	
	// Propagate record-level isCorpEnhanced='T' knowledge throughout UltID clusters
	ult := TABLE(ds_extend(isCorpEnhanced='T'), {ultid}, ultid, merge);
	ds_prop := ds_extend(ultid=0) + JOIN(
		ds_extend(ultid<>0), ult,
		LEFT.ultid=RIGHT.ultid,
		TRANSFORM(l_EmpID, SELF.isCorpEnhanced:=IF(RIGHT.UltID<>0,'T',LEFT.isCorpEnhanced), SELF:=LEFT),
		LEFT OUTER, KEEP(1), HASH
	);
	
	// OUTPUT(COUNT(ds_in(isCorp='T')), NAMED('cnt_corp_recs_in')); // DEBUG
	// OUTPUT(COUNT(ds_extend(isCorpEnhanced='T')), NAMED('cnt_corpenhanced_recs_extend')); // DEBUG
	// OUTPUT(COUNT(ds_prop(isCorpEnhanced='T')), NAMED('cnt_corpenhanced_recs_prop')); // DEBUG
	
	RETURN ds_prop;
END;