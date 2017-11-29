import doxie, doxie_ln, ut, NID, suppress, FFD, LN_PropertyV2_Services;

l_fidPlus				:= { LN_PropertyV2_Services.layouts.fid; string1 source_code_1; };
l_assess_wider	:= LN_PropertyV2_Services.layouts.assess.result.wider;
l_deeds_wider		:= LN_PropertyV2_Services.layouts.deeds.result.wider2;
l_party					:= LN_PropertyV2_Services.layouts.parties.pparty;
l_wider					:= LN_PropertyV2_Services.layouts.combined.wider;
l_tmp						:= LN_PropertyV2_Services.layouts.combined.tmp;
l_out						:= LN_PropertyV2_Services.layouts.out_crs;

export dataset(l_out) CRS_records(
	dataset(doxie.Layout_Comp_Addresses) subject_addrs,
	dataset(doxie.layout_NameDID) subject_names,
	string32 appType,
	integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	boolean IsFCRA = false,
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	):=
FUNCTION

// should borrowers be allowed (as equivalent to owners)?
allowedSources := if(LN_PropertyV2_Services.input.lnBranded, ['O','B','S'], ['O','S']);

// generate list of DIDs and BDIDs
dids_direct	:= if(LN_PropertyV2_Services.input.did<>0, dataset([{LN_PropertyV2_Services.input.did}], LN_PropertyV2_Services.layouts.search_did));
dids_deep		:= PROJECT (limit( doxie.Get_Dids(), LN_PropertyV2_Services.consts.max_deepDIDs, skip), doxie.layout_references);
dids				:= if(LN_PropertyV2_Services.input.incProp and ~IsFCRA, dedup(sort(dids_direct+dids_deep,did),did), dids_direct);	// the conditional may improve performance slightly
bdids				:= dataset([], Doxie.Layout_ref_bdid);

// retrieve a list of property records associated with those IDs
prop_ids_raw := doxie_LN.property_ids(
	dids, bdids,
	LN_PropertyV2_Services.input.dateVal, LN_PropertyV2_Services.input.dppa, LN_PropertyV2_Services.input.glb, LN_PropertyV2_Services.input.lnBranded, LN_PropertyV2_Services.input.pOverride,
  /*input.incPrior*/true, LN_PropertyV2_Services.input.useCurr, subject_addrs, subject_names,IsFCRA,,skipAddressRollup := true,appType:=appType); //i want the prior prop IDs so that I can check to at the bottom to see if they were owned
prop_ids := prop_ids_raw(source_code[1] in allowedSources);

// ...and massage that list into structures we can use
ownedSet := set(prop_ids(current=true),fid);
sids := project(prop_ids, transform(LN_PropertyV2_Services.layouts.search_fid, self.ln_fares_id:=left.fid, self.search_did := LN_PropertyV2_Services.input.did, self.isDeepDive:=false));


// assimilate those fids and retrieve results for all those records
tmp				:= LN_PropertyV2_Services.fn_get_report( sids, true, , , nonSS, isFCRA, slim_pc_recs, inFFDOptionsMask);
tmp_did		:= tmp(ln_fares_id in ownedSet);
tmp_addr	:= tmp(ln_fares_id not in ownedSet);


// property address hash -- used below for sort/dedup
pa(dataset(l_party) p) := p(party_type='P')[1];
paHash(dataset(l_party) p) := hash32(
	pa(p).prim_name, pa(p).prim_range, pa(p).zip, pa(p).predir,
	pa(p).postdir, pa(p).suffix, pa(p).sec_range
);

// We're going to prefer source A - FARES - all else being equal becuase there's more data there.

// for owned... keep the most recent deed/assessment seller/owner (that's up to four records)
tmp_did_w := join(tmp_did, prop_ids, left.ln_fares_id=right.fid and right.current=true, many lookup);
tmp_did_s := sort(tmp_did_w, paHash(parties), fid_type, (source_code[1]='S'), -sortby_date, -doxie_ln.get_LNFirst(ln_fares_id), record);
tmp_did_d := project( dedup(tmp_did_s, paHash(parties), fid_type, (source_code[1]='S')), l_tmp );


// for non-owned... keep only the most recent per property address
tmp_addr_s := sort(tmp_addr, paHash(parties), -sortby_date, -doxie_ln.get_LNFirst(ln_fares_id), record);
tmp_addr_d := dedup(tmp_addr_s, paHash(parties));


// project to result fmt, assigning owned in the process
results_did		:= resultFmt.tmpToCRS(tmp_did_d, true);
results_addr	:= resultFmt.tmpToCRS(tmp_addr_d);


// Add address_seq_no field
results_all := join(
	results_did+results_addr, prop_ids,
	left.ln_fares_id=right.fid,
	transform(l_out, self.address_seq_no:=right.address_seq_no, self:=left),
	left outer, keep(1)
);


// Pull subject names and use them to set OWNED unless UseCurr
namerec := {subject_names.fname, subject_names.mname, subject_names.lname, subject_names.name_suffix};
names := dedup(project(subject_names, namerec), all);

propnames := 
	normalize(
		project(
			results_all(not LN_PropertyV2_Services.input.useCurr and not owned),		//this filter prevents any OWNED updates when input.useCurr
			transform(
				{results_all.ln_fares_id,results_all.parties},
				self.ln_fares_id := left.ln_fares_id,
				self := left.parties(party_type = 'O')[1]
			)
		),
		left.entity,
		transform(
			{results_all.ln_fares_id, namerec},
			self.ln_fares_id := left.ln_fares_id,
			self := right
		)
	);

owned_ids := 
	join(
		propnames(fname <> '' and lname <> ''),
		names,
		left.lname = right.lname and
		NID.mod_PFirstTools.PFLeqPFR(left.fname,right.fname) and
		ut.NNEQ_Suffix(left.name_suffix, right.name_suffix) and
		(ut.NNEQ(left.mname, right.mname) or ut.Lead_contains(left.mname, right.mname))
	);

patched := 
	join(
		results_all,
		dedup(owned_ids, ln_fares_id, all),
		left.ln_fares_id = right.ln_fares_id,
		transform(
			l_out,
			self.owned := left.owned or right.ln_fares_id <> '',
			self := left
		),
		left outer
	);

// final sort
results_s := sort(patched(owned or LN_PropertyV2_Services.input.incPrior), if(owned,0,1), -sortby_date, ln_fares_id);


// output(dids, 					named('dids'));					// DEBUG
// output(bdids,  				named('bdids'));				// DEBUG
// output(prop_ids_raw, 	named('prop_ids_raw'));	// DEBUG
// output(prop_ids, 			named('prop_ids'));			// DEBUG
// output(sids, 					named('sids'));					// DEBUG

// output(tmp,						named('tmp'));					// DEBUG
// output(tmp_did,				named('tmp_did'));			// DEBUG
// output(tmp_addr, 			named('tmp_addr'));			// DEBUG
// output(tmp_did_w,			named('tmp_did_w'));		// DEBUG
// output(tmp_did_s,			named('tmp_did_s'));		// DEBUG
// output(tmp_did_d,			named('tmp_did_d'));		// DEBUG
// output(tmp_addr_s, 		named('tmp_addr_s'));		// DEBUG
// output(tmp_addr_d, 		named('tmp_addr_d'));		// DEBUG

// output(results_did,		named('results_did'));	// DEBUG
// output(results_addr, 	named('results_addr'));	// DEBUG
// output(results_all,		named('results_all'));	// DEBUG
// output(results_s,			named('results_s'));		// DEBUG

return if(LN_PropertyV2_Services.input.incProp, results_s);

END;