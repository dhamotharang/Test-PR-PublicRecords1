import FCRA, FFD, LN_PropertyV2_Services, D2C;

k_assessor(boolean isFCRA = false)	:= LN_PropertyV2_Services.keys.assessor(isFCRA);
k_fares			:= keys.addl_fares_t;
k_legal(boolean isFCRA = false)			:= LN_PropertyV2_Services.keys.addl_legal(isFCRA);

l_sid				:= LN_PropertyV2_Services.layouts.search_fid;

l_raw				:= LN_PropertyV2_Services.layouts.assess.raw_source;
								

max_raw			:= LN_PropertyV2_Services.consts.max_raw;

export dataset(l_raw) fn_get_assessments_raw(
  dataset(l_sid) in_sids,
	boolean isFCRA = false,
	dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
  dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
  integer8 inFFDOptionsMask = 0,
	 boolean isCNSMR = false
) := function
// canned data for testing
  // _canned :=  _data_canned.Corrections (in_sids);
  // flags := _canned.flagfile;
  flags := flagfile (file_id=FCRA.FILE_ID.ASSESSMENT); // prefilter in advance

  boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

	// join inputs to index to get raw data
	ds_raw0 := join(
		in_sids, k_assessor(isFCRA),
	  keyed(left.ln_fares_id = right.ln_fares_id)
		and ~((string)right.ln_fares_id in set(flags((unsigned6)did=left.search_did ),record_id) and isFCRA)
		and (~isCNSMR or right.vendor_source_flag not in D2C.Constants.LNPropertyV2RestrictedSources ),
		transform(l_raw,self:=left,self:=right,self:=[]),
		limit(max_raw)
	);
	
// canned override key for marriages
  // assess_over := _canned.assess_over;
  assess_over := join(flags, FCRA.key_override_property.assessment,
											keyed(left.flag_file_id = right.flag_file_id) and isFCRA,
											transform(l_raw,self.search_did := (unsigned6)left.did,self:=right,self:=[]),
											limit(FCRA.compliance.MAX_OVERRIDE_LIMIT));
											
	ds_raw1 := ds_raw0 + join(in_sids,assess_over,left.ln_fares_id= right.ln_fares_id,transform(l_raw,self:=right,self:=left));	
	
//---------------------------------------FCRA FFD----------------------------------------------------------------	
// Remove or mark Disputed md & add StatementIDs
	l_raw xformAssess ( l_raw L , FFD.Layouts.PersonContextBatchSlim R ) := transform,
		skip(~ShowDisputedRecords and r.isDisputed) 
			self.StatementIDs := if(ShowConsumerStatements,r.StatementIDs,FFD.Constants.BlankStatements);
			self.isDisputed :=	r.isDisputed;
			self := L;
	end;
		
															
	ds_raw1_ds  := join(ds_raw1, slim_pc_recs, 
											 left.ln_fares_id = right.RecID1 and
											 left.search_did  = (unsigned) right.lexid and 
											 right.DataGroup = FFD.Constants.DataGroups.ASSESSMENT,
											 xformAssess(left, right), 
											 left outer,
											 keep(1),
											 limit(0));													
	
	//-------------------------------------------------------------------------------------------------------													
	
	ds_raw2 := if (isFCRA, ds_raw1_ds, join(
		ds_raw0, k_fares,
	  keyed(left.ln_fares_id = right.ln_fares_id),
		transform(l_raw,self.ln_fares_id := left.ln_fares_id, self:=right,self:=left,self:=[]),
		limit(max_raw),
		left outer
	));
	ds_raw3 := join(
		ds_raw2, k_legal(isFCRA),
	  keyed(left.ln_fares_id = right.ln_fares_id),
		transform(l_raw,self.ln_fares_id := left.ln_fares_id, self:=right,self:=left,self:=[]),
		limit(max_raw),
		left outer
	);
	
	results := project(ds_raw3, transform(l_raw,self.sortby_date:=Raw.assess_recency(left);self:=left));

	return results;
end;