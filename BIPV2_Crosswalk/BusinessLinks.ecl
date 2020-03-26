import AutoStandardI;
import BIPV2;
import BIPV2_Best;
import BIPV2_Crosswalk;
import DidVille;
import doxie;
import InsuranceHeader_HHID;
import std.str;

modAccessDefault := MODULE(doxie.IDataAccess) END;

/*
 * The main exports from this are contacts(), businesses(), Summary(), and VerifyInputs().
 * All other exports are just here for debugging purposes and are not expected to be 
 * referenced by queries.
 *
 * @param inputDs: each input record must have a unique identifier in the request_id field.
 * @param useInputLexid: set to true if lexid is given on input and you don't want to 
 *                       attempt to reappend lexids
 * @param useInputBIPid: set to true if bip id is given on input and you don't want to 
 *                       attempt to reappend bip ids
 * @param bipWeight, consumerScore, bipScore: minimum weight/score to use when appending
 *                                            ids. There is no consumer weight parameter.
 * @param fetchLevel: affects both contacts associated with input business as well as 
 *                    businesses associated with input consumer. Best info is only 
 *                    available at the proxid and seleid levels. Valid input values are
 *                    defined in BIPV2.IdConstants.Fetch_Level_*Id
 * @param consumerSegmentation: as defined in the best info that comes back for the consumer
 *                              from doxie.mac_best_records() adl_ind field.
 * @param businessSegmentation: uses segmentation from BIP best. Valid input values defined in
 *                              BIPV2.Crosswalk.Constants
 */
EXPORT BusinessLinks(
	dataset(IdLinkLayouts.crosswalkInput) inputDs
	,boolean useInputLexid = false
	,boolean useInputBipId = false
	,unsigned bipWeight = BIPV2.IdConstants.APPEND_WEIGHT_THRESHOLD_ROXIE
	,unsigned consumerScore = 75
	,unsigned bipScore = 75
	,boolean onlyTopContact = false
	,boolean onlyTopBusiness = false
	,boolean allowNoLexid = false
	,string fetchLevel = BIPV2.IDconstants.Fetch_Level_SeleID
	,set of string consumerSegmentation = ALL
	,set of string businessSegmentation = ALL
	,set of string sourcesToInclude = ALL
	,Doxie.IDataAccess mod_access = modAccessDefault
) := module

// Append lexid based on consumer inputs.
export ConsumerAppend() := function
	didAppendInput := 
		project(inputDs(not useInputLexid or consumer.did = 0),
		transform({DidVille.Layout_Did_InBatch, typeof(left.consumer.did) did},
			self.seq := left.request_id,
			self := left.consumer));
	// deduped := true => return only the highest score
	DidVille.MAC_DidAppend(didAppendInput, didAppendOutput, deduped := true, do_fuzzy := false);
	noAppend := project(inputDs(useInputLexid and consumer.did != 0),
		transform(recordof(didAppendOutput),
			self.seq := left.request_id,
			self.did := left.consumer.did,
			self := []));
	// apply score filtering
	withDid := didAppendOutput(score >= consumerScore) + noAppend;
	noMatch := project(didAppendOutput(score < consumerScore),
		transform(recordof(left),
			self.seq := left.seq,
			self := []));

	return withDid + noMatch;
end;

// Append BIP ids based on business inputs.
export BipAppend() := function
	// normalize out contacts names and dba name
	contactNorm := normalize(inputDs, 10,
		transform({typeof(left.request_id) orig_request_id, BIPV2.IdAppendLayouts.AppendInput},
			useDBA := counter > 5;
			useContact1 := (counter % 5) = 1;
			useContact2 := (counter % 5) = 2;
			useContact3 := (counter % 5) = 3;
			useContact4 := (counter % 5) = 4;
			useContact5 := (counter % 5) = 5;
			self.request_id := counter;
			self.orig_request_id := left.request_id;
			self.company_name := if(useDBA,
			                        if(left.business.dba_name != '', left.business.dba_name, SKIP),
			                        left.business.company_name);
			self := map(useContact1 => left.business.contact1,
			            useContact2 => left.business.contact2,
			            useContact3 => left.business.contact3,
			            useContact4 => left.business.contact4,
			            left.business.contact5);
			self := left.business));
	dropBlankContacts := contactNorm(request_id % 5 = 1 or contact_fname != '' or contact_lname != ''
	                                 or contact_ssn != '' or contact_did != 0);
	fakeRequestId := project(dropBlankContacts, transform(recordof(left),
		self.request_id := counter;
		self := left));

	// Drop off the orig_request_id to get into the append layout
	bipInput := project(fakeRequestId, BIPV2.IdAppendLayouts.AppendInput);

	bipAppendRoxie := BIPV2.IdAppendRoxie(bipInput, scoreThreshold := bipScore,
	                                      weightThreshold := bipWeight,
	                                      reAppend := not useInputBipId);
	bipAppend := bipAppendRoxie.withBest(fetchLevel := BIPV2.IdConstants.fetch_level_proxid,
	                                     allBest := false,
	                                     isMarketing := mod_access.isDirectMarketing());
	// Add the orig_request_id back in so we can dedup
	bipAppendOrigId := 
		join(bipAppend, fakeRequestId,
			left.request_id = right.request_id,
			transform({right.orig_request_id, recordof(left)},
				self.orig_request_id := right.orig_request_id,
				self := left),
			limit(1));
	
	// Choose the top answer based on weight.
	// There could be multiple results because of DBA and multiple contact names.
	bipAppendDedup := dedup(sort(bipAppendOrigId, orig_request_id, -proxweight, request_id), orig_request_id);

	return project(bipAppendDedup, transform(recordof(bipAppend), 
		self.request_id := left.orig_request_id;
		self := left));
end;

// This attribute is exported only so that it is available for testing. It should not be
// accessed directly by a query.
// Fetch the businesses associated with the input consumer
export businessFetch := function
	lookupInput := project(ConsumerAppend()(did != 0),
		transform(Key_ConsumerToBip.l_lexid_links,
			self.uniqueid := left.seq,
			self.contact_did := left.did));

	// Treat ultid and orgid the same
	businessFetchLevel := if(fetchLevel = BIPV2.IDconstants.Fetch_Level_UltID, BIPV2.IdConstants.Fetch_Level_Orgid, fetchLevel);
	businesses0 := Key_ConsumerToBip.getDataFiltered(
		lookupInput
		,level := businessFetchLevel
		,sourcesToInclude := sourcesToInclude
		,applyMarketingRestrictions := mod_access.isDirectMarketing()
		,mod_access := mod_access
	);

	// Keep the consumer score
	businesses := 
		join(businesses0, ConsumerAppend()(did != 0),
			left.uniqueid = right.seq,
			transform({IdLinklayouts.businessOutput.did_score, recordof(left)},
				self.did_score := right.score,
				self := left));

	return businesses;
end;


// This attribute is exported only so that it is available for testing. It should not be
// accessed directly by a query.
// onlyTopBusiness - last 2 years at business => top executive title => if no title or tie, most recent;
//                 - older than 2 years => top executive title => if no title or tie, most recent
export businessLookup() := function

	topBusiness := dedup(sort(businessFetch, uniqueid,
	                                      if(dt_last_seen_at_business != 0 and ut.Age(dt_last_seen_at_business) < 2, 0, 1),
	                                      if(executive_ind_order != 0, 0, 1), // 0 is blank which should be last in sort order
	                                      executive_ind_order,
	                                      -dt_last_seen_at_business),
	                     uniqueid);

	return if(onlyTopBusiness, topBusiness, businessFetch);

end;

// This attribute is exported only so that it is available for testing. It should not be
// accessed directly by a query.
export businessBest := function
	isProxLevel := fetchLevel = BIPV2.IdConstants.fetch_level_proxid;
	isSeleLevel := fetchLevel = BIPV2.IdConstants.fetch_level_seleid;

	orgids := ungroup(dedup(businessLookup()(orgid != 0), orgid, seleid, proxid, all));
	bipBestInput :=
		project(orgids, transform(BIPV2.IdAppendLayouts.AppendInput,
			self.request_id := counter,
			self.proxid := if(isProxLevel, left.proxid, 0),
			self.seleid := if(isProxLevel or isSeleLevel, left.seleid, 0),
			self := left,
			self := []));

	bipAppendMod := BIPV2.IdAppendRoxie(bipBestInput, reappend := false);

	// Gets best for all proxids and seleids which will be filtered later based on what level
	// of ids we're interested in.
	bipBestAll := 
		bipAppendMod.withBest(
			fetchLevel :=  BIPV2.IdConstants.fetch_level_seleid,
			allBest := true,
			isMarketing := mod_access.isDirectMarketing());

	return bipBestAll;
end;

// All business associated with the resolved consumer input.
export businesses() := function

	isProxLevel := fetchLevel = BIPV2.IdConstants.fetch_level_proxid;
	isSeleLevel := fetchLevel = BIPV2.IdConstants.fetch_level_seleid;

	// Only keep the segmentation we're interested in.
	inSegBest := businessBest((isActive and Constants.SEG_ACTIVE in businessSegmentation)
	                          or (not isDefunct and not isActive and Constants.SEG_INACTIVE in businessSegmentation)
	                          or (isDefunct and Constants.SEG_DEFUNCT in businessSegmentation));

	// Add in best info for the businesses.
	// We don't calculate best at the org or ult levels, so join condition should be false if neither proxid or seleid.	
	withBest :=
		join(businessLookup()(orgid != 0), inSegBest,
			left.seleid = right.seleid
			  and left.seleid != 0
			  and ((isProxLevel and left.proxid = right.proxid)
			  OR (isSeleLevel and right.proxid = 0)),
			transform(IdLinkLayouts.businessOutput,
				self.request_id := left.uniqueid,
				self.did := left.contact_did,
				self.title := left.job_title1,
				self.proxid := if(isProxLevel, left.proxid, 0),
				self.seleid := if(isProxLevel or isSeleLevel, left.seleid, 0),
				self.orgid := left.orgid,
				self.ultid := left.ultid,
				self.isActive := right.isActive,
				self.isDefunct := right.isDefunct,
				self.company_name := right.company_name,
				self.company_phone := right.company_phone,
				self.prim_range := right.prim_range,
				self.prim_name := right.prim_name,
				self.sec_range := right.sec_range,
				self.city := right.p_city_name,
				self.state := right.st,
				self.zip := right.zip,
				self.fein := right.company_fein,
				self.business_first_seen := left.dt_first_seen,
				self.business_last_seen := left.dt_last_seen,
				self.first_seen_at_business := left.dt_first_seen_at_business,
				self.last_seen_at_business := left.dt_last_seen_at_business,
				self.parent.proxid := right.parent_proxid,
				self := left,
				self := []),
			keep(1), left outer);

	// Get parent info if available.
	parents := 
		project(dedup(withBest(parent.proxid != 0), parent.proxid, all), transform(BIPV2.IdAppendLayouts.AppendInput,
			self.request_id := counter,
			self.proxid := left.parent.proxid,
			self := left,
			self := []));
	bipAppendMod := BIPV2.IdAppendRoxie(parents, reappend := false);
	bipParentBest := 
		bipAppendMod.withBest(
			fetchLevel := BIPV2.IdConstants.fetch_level_proxid,
			isMarketing := mod_access.isDirectMarketing());

	withParentBest :=
		join(withBest, bipParentBest,
			left.parent.proxid = right.proxid,
			transform(recordof(left),
				self.parent.ultid := right.ultid,
				self.parent.orgid := right.orgid,
				self.parent.seleid := right.seleid,
				self.parent.company_name := right.company_name,
				self.parent.prim_name := right.prim_name,
				self.parent.prim_range := right.prim_range,
				self.parent.sec_range := right.sec_range,
				self.parent.city := right.p_city_name,
				self.parent.state := right.st,
				self.parent.zip := right.zip,
				self.parent.company_phone := right.company_phone,
				self := left),
			left outer, limit(1));

	return withParentBest;
end;

// This attribute is exported only so that it is available for testing. It should not be
// accessed directly by a query.
// Get associated contacts from BIP id
export contactFetch := function
	lookupInput := project(BipAppend(),
		transform(BIPV2.IDlayouts.l_xlink_ids2,
			self.uniqueid := left.request_id,
			self := left,
			self := []));
	getContacts := Key_BipToConsumer.getDataFiltered(
		lookupInput
		,Level := fetchLevel
		,sourcesToInclude := sourcesToInclude
        ,applyMarketingRestrictions := mod_access.isDirectMarketing()
		,mod_access := mod_access
	);

	checkLexid0 := getContacts(allowNoLexid OR contact_did != 0);

	keepProxLevel := fetchLevel = BIPV2.IdConstants.fetch_level_proxid;
	keepSeleLevel := keepProxLevel or fetchLevel = BIPV2.IdConstants.fetch_level_seleid;

	// Keep scores and weights of BIP ids.
	checkLexid := 
		join(checkLexid0, lookupInput,
			left.uniqueid = right.uniqueid,
			transform({BIPV2.IDlayouts.l_xlink_ids2 OR recordof(left)},
				// only keep proxid if want that level
				self.proxid := if(keepProxLevel, right.proxid, 0);
				self.proxscore := if(keepProxLevel, right.proxscore, 0);
				self.proxweight := if(keepProxLevel, right.proxweight, 0);
				// only keep seleid if want that level
				self.seleid := if(keepSeleLevel, right.seleid, 0);
				self.selescore := if(keepSeleLevel, right.selescore, 0);
				self.seleweight := if(keepSeleLevel, right.seleweight, 0);

				self := right,
				self := left));
	return checkLexid;
end;

// This attribute is exported only so that it is available for testing. It should not be
// accessed directly by a query.
// onlyTopContact - last 2 years at business => top executive title => if no title or tie, most recent;
//                - older than 2 years => top executive title => if no title or tie, most recent
export contactLookup := function

	topContact := dedup(sort(contactFetch, uniqueid,
	                                     if(dt_last_seen_at_business != 0 and ut.Age(dt_last_seen_at_business) < 2, 0, 1),
	                                     if(executive_ind_order != 0, 0, 1), // 0 is blank which should be last in sort order
	                                     executive_ind_order,
	                                     -dt_last_seen_at_business),
	                    uniqueid);

	return if(onlyTopContact, topContact, contactFetch);
end;

// This attribute is exported only so that it is available for testing. It should not be
// accessed directly by a query.
// Look up best for contacts that have lexids.
export contactBest := function
	gm := AutoStandardI.GlobalModule();												 
	doxie.mac_best_records(dedup(contactLookup, contact_did, all), contact_did, getBest, ut.dppa_ok(gm.DPPAPurpose), ut.glb_ok(gm.GLBPurpose), , doxie.DataRestriction.fixed_DRM, mod_access.isDirectMarketing());
	return getBest;
end;

// This attribute is exported only so that it is available for testing. It should not be
// accessed directly by a query.
// Get the HHID for contacts that have lexids.
export contactHHID := function
	hhidInput := contactLookup(contact_did != 0);
	withHHID := InsuranceHeader_HHID.FnMac_HHID_Append(hhidInput, contact_did, returnlimit := 1, forcePull := FALSE);
	return withHHID;
end;

// The contacts associated with resolved business input.
export contacts() := function

	// Add in best info.
	getBest := contactBest;
	withBest :=
		join(contactLookup, getBest,
			left.contact_did = right.did,
			transform(IdLinkLayouts.contactOutput,
				hasBest := right.did != 0;
				self.request_id := left.uniqueid;
				// Only keep ones that are in the specified segments.
				self.did := if(right.adl_ind in consumerSegmentation, left.contact_did, SKIP);
				self.hhid := 0;
				self.title := if(hasBest, right.title, left.title);
				self.fname := if(hasBest, right.fname, left.fname);
				self.mname := if(hasBest, right.mname, left.mname);
				self.lname := if(hasBest, right.lname, left.lname);
				self.name_suffix := if(hasBest, right.name_suffix, left.name_suffix);
				self.prim_range := if(hasBest, right.prim_range, left.prim_range);
				self.prim_name := if(hasBest, right.prim_name, left.prim_name);
				self.sec_range := if(hasBest, right.sec_range, left.sec_range);
				self.city := if(hasBest, right.city_name, left.v_city_name);
				self.state := if(hasBest, right.st, left.st);
				self.zip := if(hasBest, right.zip, left.zip);
				self.phone := if(hasBest, right.phone, left.contact_phone);
				self.ssn := if(hasBest, right.ssn, left.contact_ssn);
				self.email := left.contact_email;
				self.dt_address_first_seen := 0;
				self.dt_address_last_seen := if(hasBest, right.addr_dt_last_seen, 0);
				self.dt_ln_first_seen := 0;
				self.dt_ln_last_seen := 0;
				self.dt_first_seen_at_business := left.dt_first_seen_at_business;
				self.dt_last_seen_at_business := left.dt_last_seen_at_business;
				self := left;
				self := []), left outer, keep(1));

	withHHID :=
		join(withBest(did != 0), contactHHID,
			left.did = right.contact_did,
			transform(recordof(left),
				self.hhid := right.hhid_relat,
				self := left),
			keep(1), left outer) + withBest(did = 0);

	return withHHID;

end;


export summary := function

	summaryLayout := {
		inputDs.request_id,
		boolean input_is_linked, // input consumer is associated with input business
		unsigned cnt_linked_business, // count of businesses associated with input consumer
		unsigned cnt_contacts, // count of contacts associated with input business
		unsigned cnt_contact_lexid, // count of contacts with a lexid associated with input business
		unsigned cnt_contact_no_lexid, // count of contacts w/o a lexid associated with input business
	};

	verifyLink :=
		join(dedup(businesses(), request_id, did, all), contacts(),
			left.request_id = right.request_id and left.did = right.did,
			transform(left),
			keep(1));

	proxCnts := table(dedup(businesses()(seleid != 0), request_id, seleid, proxid, all), {request_id, cnt := count(group)}, request_id);
	seleCnts := table(dedup(businesses()(seleid != 0), request_id, seleid, all), {request_id, cnt := count(group)}, request_id);
	orgCnts := table(dedup(businesses()(orgid != 0), request_id, orgid, all), {request_id, cnt := count(group)}, request_id);
	contactsLexid := dedup(contacts()(did != 0), request_id, did, all);
	lexidCnts := table(contactsLexid, {request_id, cnt := count(group)}, request_id);
	contactsNoId := contacts()(did = 0);
	noIdCnts := table(contactsNoId, {request_id, cnt := count(group)}, request_id);

	withBusiness :=
		join(inputDS, map(fetchLevel = BIPV2.IDconstants.Fetch_Level_ProxID => proxCnts, 
		                  fetchLevel = BIPV2.IDconstants.Fetch_Level_SeleID => seleCnts,
						  orgCnts),
			left.request_id = right.request_id,
			transform(summaryLayout,
				self.cnt_linked_business := right.cnt,
				self := left;
				self := []), left outer, keep(1));

	withLexid :=
		join(withBusiness, lexidCnts,
			left.request_id = right.request_id,
			transform(summaryLayout,
				self.cnt_contact_lexid := right.cnt,
				self := left;
				self := []), left outer, keep(1));

	withNoId :=
		join(withLexid, noIdCnts,
			left.request_id = right.request_id,
			transform(summaryLayout,
				self.cnt_contact_no_lexid := right.cnt,
				self.cnt_contacts := left.cnt_contact_lexid + right.cnt,
				self := left;
				self := []), left outer, keep(1));
	withVerifyLink :=
		join(withNoId, verifyLink,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.input_is_linked := right.did != 0;
				self := left),
			left outer);

	return withVerifyLink;

end;

// This attribute is exported only so that it is available for testing. It should not be
// accessed directly by a query.
// Get best info for resolved input businesses to be used in the VerifyInputs function.
export inputBusinessBest() := function

	preBest :=
		project(BipAppend()(seleid != 0),
			transform(BIPV2.IdLayouts.l_xlink_ids2,
				self.uniqueid := left.request_id,
				self := left));

	withBest0 := BIPV2_Best.Key_LinkIds.kfetch2(preBest, BIPV2.IDconstants.Fetch_Level_SeleID);
	withBest := dedup(withBest0, seleid, proxid, uniqueid, all);

	return withBest;
end;

// Returns flags indicating if input consumer field(s) match parts of either a contact or business
// Consumer input must be supplied and business input must resolve.
// The input consumer is compared to the contacts associated with the resolved business and to 
// the 
export VerifyInputs() := function

	verifyRec := {
		inputDs.request_id,
		boolean first_last_name, // input consumer first name and last name match a contact associated with input business
		boolean first_name, // input consumer first name matches a contact associated with input business
		boolean last_name, // input consumer last name matches a contact associated with input business
		// input consumer first name matches part of business name and input consumer address line 1 
		// matches address line 1 of resolved business
		boolean first_bus_name_addr1,
		// input consumer last name matches part of business name and input consumer address line 1 
		// matches address line 1 of resolved business
		boolean last_bus_name_addr1,
		boolean first_bus_name, // input consumer first name matches part of resolved business name
		boolean last_bus_name, // input consumer last name matches part of resolved business name
		boolean addr1, // input consumer address line 1 matches address of contact associated with resolved business
		boolean bus_addr1, // input consumer address line 1 matches address of resolved business
		boolean ssn, // input consumer ssn matches the ssn of a contact associated with resolved business
		boolean ssn_fein, // input consumer ssn matches the fein of resolved business
		boolean phone, // input consumer phone matches the phone of a contact associated with resolved business
		boolean bus_phone, // input consumer phone matches phone of resolved business
	};

	// first and last name match a contact
	firstLastName := 
		join(inputDs(consumer.fname != '', consumer.lname != ''), contacts(),
			left.request_id = right.request_id
				and str.toUpperCase(left.consumer.fname) = right.fname
				and str.toUpperCase(left.consumer.lname) = right.lname,
			transform(left), keep(1));

	// first name match
	firstName :=
		join(inputDs(consumer.fname != ''), contacts(),
			left.request_id = right.request_id
				and str.toUpperCase(left.consumer.fname) = right.fname,
			transform(left), keep(1));

	// last name match
	lastName := 
		join(inputDs(consumer.lname != ''), contacts(),
			left.request_id = right.request_id
				and str.toUpperCase(left.consumer.lname) = right.lname,
			transform(left), keep(1));

	// first name matches part of company name and address line 1 matches business
	fBusNameAddrMatch :=
		join(inputDs(consumer.fname != '', consumer.prim_name != ''), inputBusinessBest(),
			left.request_id = right.uniqueid
				and exists(right.company_name(str.Find(company_name, str.toUpperCase(trim(left.consumer.fname)), 1) != 0))
				and exists(right.company_address(str.toUpperCase(left.consumer.prim_range) = company_prim_range
				                                 and str.toUpperCase(left.consumer.prim_name) = company_prim_name)),
			transform(left), keep(1));

	// last name matches part of company name and address line 1 matches busines
	lBusNameAddrMatch :=
		join(inputDs(consumer.lname != '', consumer.prim_name != ''), inputBusinessBest(),
			left.request_id = right.uniqueid
				and exists(right.company_name(str.Find(company_name, str.toUpperCase(trim(left.consumer.lname)), 1) != 0))
				and exists(right.company_address(str.toUpperCase(left.consumer.prim_range) = company_prim_range
				                                 and str.toUpperCase(left.consumer.prim_name) = company_prim_name)),
			transform(left), keep(1));

	// first name matches part of company name
	fBusNameMatch :=
		join(inputDs(consumer.fname != ''), inputBusinessBest(),
			left.request_id = right.uniqueid
				and exists(right.company_name(str.Find(company_name, str.toUpperCase(trim(left.consumer.fname)), 1) != 0)),
			transform(left), keep(1));

	// last name matches part of company name
	lBusNameMatch :=
		join(inputDs(consumer.lname != ''), inputBusinessBest(),
			left.request_id = right.uniqueid
				and exists(right.company_name(str.Find(company_name, str.toUpperCase(trim(left.consumer.lname)), 1) != 0)),
			transform(left), keep(1));

	// input consumer address line 1 matches a contact address line 1
	addrMatch :=
		join(inputDs(consumer.prim_name != ''), contacts(),
			left.request_id = right.request_id
				and str.toUpperCase(left.consumer.prim_range) = right.prim_range
				and str.toUpperCase(left.consumer.prim_name) = right.prim_name,
			transform(left), keep(1));

	// input consumer address line 1 matches business address line 1
	busAddrMatch :=
		join(inputDs(consumer.prim_name != ''), inputBusinessBest(),
			left.request_id = right.uniqueid
				and exists(right.company_address(str.toUpperCase(left.consumer.prim_range) = company_prim_range
				                                 and str.toUpperCase(left.consumer.prim_name) = company_prim_name)),
			transform(left), keep(1));

	// input consumer ssn matches a contact ssn
	ssnMatch := 
		join(inputDs(consumer.ssn != ''), contacts(),
			left.request_id = right.request_id
				and left.consumer.ssn = right.ssn,
			transform(left), keep(1));

	// input consumer ssn matches a business fein
	ssnFeinMatch :=
		join(inputDs(consumer.ssn != ''), inputBusinessBest(),
			left.request_id = right.uniqueid
				and exists(right.company_fein(company_fein = left.consumer.ssn)),
			transform(left), keep(1));

	// input consumer phone matches a contact phone
	phoneMatch := 
		join(inputDs(consumer.phone10 != ''), contacts(),
			left.request_id = right.request_id
				and left.consumer.phone10 = right.phone,
			transform(left), keep(1));

	// input consumer phone matches business phone
	busPhoneMatch :=
		join(inputDs(consumer.phone10 != ''), inputBusinessBest(),
			left.request_id = right.uniqueid
				and exists(right.company_phone(company_phone = left.consumer.phone10)),
			transform(left), keep(1));

	// Set all flags
	fLName := 
		join(inputDs, firstLastName,
			left.request_id = right.request_id,
			transform(verifyRec,
				self.request_id := left.request_id,
				self.first_last_name := right.consumer.fname != '',
				self := []), left outer);

	fName :=
		join(fLName, firstName,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.first_name := right.consumer.fname != '',
				self := left), left outer);

	lName :=
		join(fName, lastName,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.last_name := right.consumer.lname != '',
				self := left), left outer);

	fBusNameAddr :=
		join(lName, fBusNameAddrMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.first_bus_name_addr1 := right.consumer.prim_name != '',
				self := left), left outer);

	lBusNameAddr :=
		join(fBusNameAddr, lBusNameAddrMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.last_bus_name_addr1 := right.consumer.prim_name != '',
				self := left), left outer);

	fBusName :=
		join(lBusNameAddr, fBusNameMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.first_bus_name := right.consumer.fname != '',
				self := left), left outer);

	lBusName :=
		join(fBusName, lBusNameMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.last_bus_name := right.consumer.lname != '',
				self := left), left outer);

	addr :=
		join(lBusName, addrMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.addr1 := right.consumer.prim_name != '',
				self := left), left outer);

	busAddr :=
		join(addr, busAddrMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.bus_addr1 := right.consumer.prim_name != '',
				self := left), left outer);

	ssn :=
		join(busAddr, ssnMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.ssn := right.consumer.ssn != '',
				self := left), left outer);

	ssnFein :=
		join(ssn, ssnFeinMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.ssn_fein := right.consumer.ssn != '',
				self := left), left outer);

	phone :=
		join(ssnFein, phoneMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.phone := right.consumer.phone10 != '',
				self := left), left outer);

	busPhone :=
		join(phone, busPhoneMatch,
			left.request_id = right.request_id,
			transform(recordof(left),
				self.bus_phone := right.consumer.phone10 != '',
				self := left), left outer);

	return busPhone;
end;

end;