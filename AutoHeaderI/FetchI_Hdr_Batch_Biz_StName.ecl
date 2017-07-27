import doxie,ut,Business_Header;

export FetchI_Hdr_Batch_Biz_StName(
	dataset(Layouts.Fetch_Hdr_Biz_Working_Layout) indata) := function

	return denormalize(indata,Business_Header.RoxieKeys().NewFetch.Key_StName_QA,
		JoinConditions.NEGATIVE_FEIN() and
		JoinConditions.NEGATIVE_PHONE() and
		JoinConditions.NEGATIVE_STREET() and
		JoinConditions.NEGATIVE_ADDRESS() and
		JoinConditions.NEGATIVE_ZIP() and
		JoinConditions.NEGATIVE_NAME() and
		left.city_value = '' and
		left.company_name_value != '' and
		JoinConditions.STATE_KEYED() and
		JoinConditions.CNAME_DIAL_KEYED() and
		JoinConditions.FEIN_OPT_KEYED() and
		JoinConditions.ZIP_OPT_KEYED(),
		group,
		transform(Layouts.Fetch_Hdr_Biz_Working_Layout,
			tempbdids := dedup(sort(project(rows(right),Layouts.Fetch_Hdr_Biz_BDID_Layout),bdid),bdid);
			self.results.errcode := if(left.results.errcode != Types.ErrCode.NONE,
				left.results.errcode,
				if(count(tempbdids) > ut.limits.FETCH_UNKEYED,
					if(left.nofail,left.results.errcode,Types.ErrCode.TOOMANY),
					Types.ErrCode.NONE)),
			self.results.bdids := choosen(left.results.bdids + 
				if(count(tempbdids) <= ut.limits.FETCH_UNKEYED,tempbdids),ut.limits.FETCH_UNKEYED),
			self := left),
		limit(ut.limits.FETCH_UNKEYED * 10), // x10 in order to account for name-word permutations
		onfail(
			transform(Layouts.Fetch_Hdr_Biz_Working_Layout,
				self.results.errcode := if(left.nofail,left.results.errcode,Types.ErrCode.TOOMANY),
				self.results.bdids := left.results.bdids,
				self := left)));
	
end;
