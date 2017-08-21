import doxie,ut;

export FetchI_Hdr_Batch_Indv_RID(
	dataset(Layouts.Fetch_Hdr_Batch_Indv_RID_Layout) indata) := function

	step1 := join(indata,doxie.Key_Header_Rid(),
		keyed((unsigned)left.rid_value = right.rid),
		transform(Layouts.Fetch_Batch_PreOutput_Layout,
			self.acctno := left.acctno,
			self.errcode := Types.ErrCode.NONE,
			self.id := right.did),
		limit(ut.limits.RID_PER_PERSON,skip));
	
	return step1;

end;
