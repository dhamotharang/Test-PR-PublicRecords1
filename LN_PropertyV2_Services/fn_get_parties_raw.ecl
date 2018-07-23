import _Control, FCRA,suppress, FFD, LN_PropertyV2_Services, D2C;
onThor := _Control.Environment.OnThor;

k_search(boolean isFCRA = false)		:= keys.search(isFCRA);

l_fid				:= LN_PropertyV2_Services.layouts.fid;
l_raw				:= LN_PropertyV2_Services.layouts.parties.raw_source;

max_raw			:= LN_PropertyV2_Services.consts.max_raw;
max_parties	:= LN_PropertyV2_Services.consts.max_parties;

export dataset(l_raw) fn_get_parties_raw(
  dataset(l_fid) in_fids,
	integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	boolean isFCRA = false,
	dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
  dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
  integer8 inFFDOptionsMask = 0,
	 boolean isCNSMR = false
) := function
// canned data for testing
  // _canned :=  _data_canned.Corrections (project(in_fids,LN_PropertyV2_Services.layouts.search_fid));
  // flags := _canned.flagfile;
  flags := flagfile (file_id=FCRA.FILE_ID.SEARCH); // prefilter in advance
	
  boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

	// join inputs to index to get raw data
	ds_raw_roxie := join(
		in_fids, k_search(isFCRA),
	  keyed(left.ln_fares_id = right.ln_fares_id)
		and ~((string)right.persistent_record_id in set(flags((unsigned6)did=left.search_did ),record_id) and isFCRA)
		and (~isCNSMR or right.vendor_source_flag not in D2C.Constants.LNPropertyV2RestrictedSources ),
		transform(l_raw, self.search_did := left.search_did,self:=right, self := []),
		keep(2*max_parties), 
		atmost(max_raw)
	);
	
	ds_raw_thor := join(
		distribute(in_fids, hash64(ln_fares_id)), 
		distribute(pull(k_search(isFCRA)), hash64(ln_fares_id)),
	  left.ln_fares_id = right.ln_fares_id
		and ~((string)right.persistent_record_id in set(flags((unsigned6)did=left.search_did ),record_id) and isFCRA),
		transform(l_raw, self.search_did := left.search_did,self:=right, self := []),
		keep(2*max_parties),
		atmost(left.ln_fares_id=right.ln_fares_id, max_raw),
		local
	);
	
	#IF(onThor)
    ds_raw := ds_raw_thor;
  #ELSE
    ds_raw := ds_raw_roxie;
  #END
  
// canned override key for property
	// search_over := _canned.search_over;
	d_flags := dedup(sort(flags,flag_file_id),flag_file_id); // removes dups from the first version of overrides
	search_over_roxie := join(d_flags, FCRA.key_override_property.search,
											keyed(left.flag_file_id = right.flag_file_id),
											transform(l_raw,self.search_did := (unsigned6)left.did,
												self.source_code_1:=right.source_code[1],
												self.source_code_2:=right.source_code[2],
												self:=right, 
												self := []),
												LIMIT(FCRA.compliance.MAX_OVERRIDE_LIMIT));

	search_over_thor := join(distribute(d_flags, hash64(flag_file_id)), 
                      distribute(FCRA.key_override_property.search, hash64(flag_file_id)),
											(left.flag_file_id = right.flag_file_id),
											transform(l_raw,self.search_did := (unsigned6)left.did,
												self.source_code_1:=right.source_code[1],
												self.source_code_2:=right.source_code[2],
												self:=right, 
												self := []),
												LIMIT(FCRA.compliance.MAX_OVERRIDE_LIMIT), LOCAL);
                        
  #IF(onThor)
    search_over := search_over_thor;
  #ELSE
    search_over := search_over_roxie;
  #END
  
	ds_raw1 := ds_raw + join(in_fids,search_over,left.ln_fares_id = right.ln_fares_id and left.search_did = right.did,
														transform(l_raw,self:=right));
														
 //---------------------------------------FCRA FFD----------------------------------------------------------------	
// Remove or mark Disputed md & add StatementIDs
	l_raw xformParty ( l_raw L , FFD.Layouts.PersonContextBatchSlim R ) := transform,
		skip(~ShowDisputedRecords and r.isDisputed) 
			self.StatementIDs := if(ShowConsumerStatements,r.StatementIDs,FFD.Constants.BlankStatements);
			self.isDisputed :=	r.isDisputed;
			self := L;
	end;
		
															
	ds_raw1_ds  := join(ds_raw1, slim_pc_recs, 
											 (string)left.persistent_record_id = right.RecID1 and
											 left.did  = (unsigned) right.lexid and 
											 right.DataGroup = FFD.Constants.DataGroups.PROPERTY_SEARCH,
											 xformParty(left, right), 
											 left outer,
											 keep(1),
											 limit(0));													
	
	
	//-------------------------------------------------------------------------------------------------------													
	
  ds_rawfinal := if(isFCRA, ds_raw1_ds, ds_raw); 

  nss_raw := if(nonSS = suppress.constants.NonSubjectSuppression.doNothing,
									ds_rawfinal,
								  project(ds_rawfinal(search_did<>did and bdid = 0 and cname = ''),
												transform(recordof(l_raw),
												     self.ln_fares_id := left.ln_fares_id, 
												     self.search_did := left.search_did,
														 self.source_code_1 := left.source_code_1,
														 self.source_code_2 := left.source_code_2,
														 self.source_code := left.source_code,
														 self.persistent_record_id := left.persistent_record_id,
														 self.which_orig := left.which_orig,
  											     self.lname := if(nonSS = suppress.constants.NonSubjectSuppression.returnRestrictedDescription,fcra.constants.FCRA_Restricted,''),
														 self:=[])) +
								     ds_rawfinal(~(search_did<>did and bdid = 0 and cname = ''))
								 );	
 // output(in_fids,named('in_fids'));
// output(ds_raw,named('parties_raw_no_over'));
// output(s_over,named('searchover'));
// output(search_over,named('actual_overrides'));
//output(ds_raw1,named('parties_rawwithoverrides'));
//output(ds_rawfinal,named('parties_ds_rawfinal'));
// output(nss_raw,named('parties_nss'));
	return nss_raw;

end;