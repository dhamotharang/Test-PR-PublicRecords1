/*
	Property Ownership

	This module implements the core runtime interface for property ownership,
	in other words "who owns what".  As the system evolves, please add new
	retrieval methods here rather than in individual queries.  This should be
	the only runtime attribute referring to ownership keys (going forward).
	
	Our understanding of ownership is determined by what we see in _all_ sources
	during the data build.  However, generally our queries still need to consult
	the DataRestrictionMask to determine what to display in the results.  Thus,
	the "drm" input in the get routines below controls only the fraction of the
	result records we're allowed to display and does not affect the ownership
	values themselves.  For example, if Fidelity shows John owns property X, and
	Fares has more recent records showing Mary has purchased property X from
	John, then a customer not allowed to see Fares will see _no_ ownership info
	for Property X (rather than seeing a false assertion that John still owns it).
*/

import LN_PropertyV2, doxie, doxie_ln, suppress;

export Ownership := module

	// NOTE: Some of the fields in the key are "FYI only", useful when studying
	//       the key and researching problems, but not intended for general use
	//       in production.  As a rule, callers should retrieve "l_own" records.
	export l_wide	:= LN_PropertyV2.layout_ownership_did;
	export l_own	:= {l_wide and not [fname,lname,orig_state,orig_county,legal_brief_description]};
	
	export max_owned_per_did	:= 250; // STUB - check this value
	export max_owned_per_addr	:= 250; // STUB - check this value
	
	export l_in_batch := record(doxie.layout_references)
		string5 drm;
		boolean lnBranded;
		boolean currentOnly;
	end;
	
	// Parameters control everything
	shared dataset(l_wide) get_batch_wide(dataset(l_in_batch) inp, string32 appType) := function
		ds := join(
			inp, LN_PropertyV2.key_ownership_did(),
			keyed(left.did=right.did)
				and keyed(right.current or not left.currentOnly)
				and exists(right.hist(ln_fares_id[1] in input.srcSelect(left.drm,left.lnBranded).allow)),
			transform(l_wide,self:=right),
			limit(max_owned_per_did, skip)
		);
		Suppress.MAC_Suppress(ds,ds_pulled,apptype,Suppress.Constants.LinkTypes.DID,did);
		return ds_pulled;
	end;
	
	// DIDs+currentOnly as parameters, src restrictions come from shared inputs
	shared dataset(l_wide) get_dids_wide(dataset(doxie.layout_references) in_dids, boolean in_currentOnly, string32 appType) := function
		cur_in := project(in_dids, transform(l_in_batch,
			self.drm					:= input.drm,
			self.lnBranded		:= input.lnBranded,
			self.currentOnly	:= in_currentOnly,
			self:=left));
		return get_batch_wide(cur_in, appType);
	end;
	export dataset(l_own) get_dids(dataset(doxie.layout_references) in_dids, boolean in_currentOnly, string32 appType) := function
		return project(get_dids_wide(in_dids, in_currentOnly, appType), l_own);
	end;
	
	// DID+currentOnly as parameters, src restrictions come from shared inputs
	
	// shared inputs control everything
	
	// ------------------------------------------------------------
	// This is a replacement for LN_PropertyV2_Services.CRS_records
	// ------------------------------------------------------------
	shared l_crs := LN_PropertyV2_Services.layouts.out_crs;
	export dataset(l_crs) get_CRS_records(
		dataset(doxie.layout_references)			in_dids,
		dataset(doxie.Layout_Comp_Addresses)	subject_addrs,
		dataset(doxie.layout_NameDID)					subject_names,
		string32 appType = LN_PropertyV2_Services.input.appType,
		boolean isFCRA = false,  // only used at nonFCRA side -> FCRA side is not fully supported
		boolean IncludePriorProperties = LN_PropertyV2_Services.input.incPrior,
		boolean UseCurrentlyOwnedProperty = LN_PropertyV2_Services.input.useCurr,
		boolean IncludePropertySellerData = LN_PropertyV2_Services.input.incSeller
	):= function
	
		// Properties that may be returned have one of three types of ownership classifications:
		//
		//   1. Currently owned by subject
		//   2. Ever owned by subject
		//   3. Never owned by subject
		// 
		// #1 and #2 are mostly retrieved by DID from the ownership keys.  #3 are retrieved by searching
		// for the addresses in "subject_adrs".  Since we have some property data where parties weren't
		// able to link for some reason, we also examine all records retrieved by address to see if we
		// can identify a name match with the subject.  Records with an owner name match are promoted to
		// either #1 or #2.
		//
		// It's important to keep in mind that ESP is filtering the propertyv2_children output of
		// the roxie query into two separate sections of the comp report, and that those sections
		// have different requirements for which records to display.  Specifically:
		//
		//   propertyv2_children(owned=true) goes to "possible properties"
		//   propertyv2_children(address_seq_no>=0) goes to "previous addresses"
		//
		// This dual use has been the source of some complexity in the code, and we really need to
		// do a better job of keeping these competing needs in mind when making changes.
		//
		// Two major inputs tune the behavior of this code: UseCurrentlyOwnedProperty (UCOP), and
		// IncludePriorProperties (IPP).  The following table depicts how they influence the output
		// of records to each comp report section:
		//
		//   UCOP		IPP			"Possible Properties"		"Previous Addresses"
		//   false	false		#1, filt(#2)						#1, #2
		//   false	true		#1, filt(#2)						#1, #2, #3
		//   true		false		#1											#1
		//   true		true		#1											#1, #2, #3
		// 
		// NOTES:
		// - In the "Possible Properties" section, we want to display the latest deed and
		//   the latest assessment record that demonstrate ownership by the subject.  That
		//   restriction by subject ownership is what I'm trying to indicate with "filt(#2)".
		// - In the "Previous Addresses" section, we want to display the latest record for the
		//   property, regardless of ownership or deed/assessment.
		// - The term "prior" in the input parameter is a little confusing.  It's referring to
		//   properties that were never owned by the subject, but which have some prior
		//   association with the subject since they're included in subject_addrs (i.e. #3).
		
		l_norm1 := record
			subject_addrs.address_seq_no;
			LN_PropertyV2.key_ownership.did(isFCRA).aceaid;
			LN_PropertyV2.key_ownership.did(isFCRA).did;
			LN_PropertyV2.key_ownership.did(isFCRA).current;
			LN_PropertyV2.key_ownership.did(isFCRA).fips_code;
			LN_PropertyV2.key_ownership.did(isFCRA).unformatted_apn;
			LN_PropertyV2.mod_ownership.l_fipsAPN.hist;
			boolean owned;
		end;
		l_norm2 := record
			l_norm1 and not hist;
			LN_PropertyV2.mod_ownership.l_fipsAPN.hist.dt_seen;
			LN_PropertyV2.mod_ownership.l_fipsAPN.hist.ln_fares_id;
			LN_PropertyV2.mod_ownership.l_fipsAPN.hist.owners;
		end;
		
		// retrieve by DID
		cur_in_dids := project(in_dids, transform(l_in_batch,
			self.drm					:= LN_PropertyV2_Services.input.drm,
			self.lnBranded		:= LN_PropertyV2_Services.input.lnBranded,
			self.currentOnly	:= false,
			self:=left));
		ds_dids_prepulled := join(
			cur_in_dids, LN_PropertyV2.key_ownership.did(isFCRA),
			keyed(left.did=right.did)
				and keyed(right.current or not left.currentOnly),
			transform(l_norm1, self.address_seq_no:=-1, self.owned:=true, self:=right.hist[1], self:=right),
			limit(max_owned_per_did, skip)
		);
		Suppress.MAC_Suppress(ds_dids_prepulled,ds_dids,apptype,Suppress.Constants.LinkTypes.DID,did, isFCRA := isFCRA);
		
		
		// retrieve by address, allowing for the possibility the sec_range in the inputs could be bogus
		mac_JoinByAddr(in_file, full_address) := macro
			join(
				in_file, LN_PropertyV2.key_ownership.addr(isFCRA),
				keyed(left.prim_name = right.prim_name) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.zip = right.zip5) and									 
					keyed(left.predir = right.predir) and 
					keyed(left.postdir = right.postdir) and 
					keyed(left.suffix = right.addr_suffix) and
					if(full_address, keyed(left.sec_range=right.sec_range), keyed(right.sec_range='')),
				limit(max_owned_per_addr, skip)
			)
		endmacro;
		
		// ...first try to retrieve exact addrs
		doxie.MAC_Address_Rollup(subject_addrs, 50, in_addr_roll);
			// NOTE: We may not need to call MAC_Address_Rollup here.  doxie.Comp_Subject_Addresses seems to take
			//       care of it already when we're running locally, and it should also already be done when we're
			//       running remotely.  It won't hurt to re-do it, but this would be good to remove and retest soon.
		in_addr_cnt		:= project(in_addr_roll, transform(doxie.layout_propertySearch, self.address_seq_no:=counter,self:=left));
		in_addr_nocnt	:= project(subject_addrs, transform(doxie.layout_propertySearch, self:=left));
		in_addr1			:= if(exists(subject_addrs(address_seq_no > 0)), in_addr_nocnt, in_addr_cnt);
		ds_addr1 			:= mac_JoinByAddr(in_addr1, true);
		
		// ...and where we don't get exact hits, try omitting the sec_range
		in_addr2 := join( // narrow inputs to those not successfully handled in previous block
			in_addr1(sec_range<>''), ds_addr1,
			left.address_seq_no = right.address_seq_no,
			transform(doxie.layout_propertySearch, self:=left),
			left only);
		ds_addr2 := mac_JoinByAddr(in_addr2, false);
		
		// ...then combine recs retrieved by both address methods, and exclude those we already handled by DID
		ds_addrs_raw := project(ds_addr1 + ds_addr2, transform(l_norm1, self:=left.hist[1], self:=left, self.current:=false, self.owned:=false));
		ds_addrs := join(
			ds_addrs_raw, ds_dids,
			left.fips_code=right.fips_code and left.unformatted_apn=right.unformatted_apn and left.aceaid = right.aceaid,
			left only
		);
		
		// Now we need to deal with exceptions where records found by address can be "promoted"
		// to being owned or previously owned by the subject.  This comes about when the property
		// records didn't get a DID, but that we can now match by name.
		// (This would have been so much easier if I'd left the full name in the history!)
		l_addrNorm := record
			boolean		isCurrent;
			ds_addrs.fips_code;
			ds_addrs.unformatted_apn;
			ds_addrs.hist.ln_fares_id;
			string20	fname				:='';
			string20	lname				:='';
			string5		name_suffix	:='';
			string    geo_lat := '';
			string    geo_long := '';
		end;
		ds_addrNorm := normalize( // flatten out the apns+fids we may care about
			ds_addrs,
			if(UseCurrentlyOwnedProperty, 1, count(left.hist)),
			transform(l_addrNorm, self.isCurrent:=(counter=1), self:=left.hist[counter], self:=left)
		);
		ds_addrs_ownnames := join( // retrieve owner names associated with fid (often multiple parties per fid)
			ds_addrNorm, LN_PropertyV2.key_search_fid(isFCRA),
			keyed(left.ln_fares_id=right.ln_fares_id) and right.source_code[1..2] in ['OP','BP'],
			transform(l_addrNorm, self:=right, self:=left),
			limit(100,skip)
		);
		ds_addrs_subnames := join( // narrow down to apns where one of the names matches the subject
			ds_addrs_ownnames, subject_names,
			LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND ut.NNEQ(LEFT.name_suffix,RIGHT.name_suffix),
			transform(left),
			keep(1)
		);
		ds_addrs_sub := join( // back to original record type, limited to subject matches
			ds_addrs, ds_addrs_subnames,
			left.fips_code=right.fips_code and left.unformatted_apn=right.unformatted_apn,
			transform(left),
			keep(1)
		);
		ds_addrs_nosub := join( // back to original record type, limited to subject no-matches
			ds_addrs, ds_addrs_subnames,
			left.fips_code=right.fips_code and left.unformatted_apn=right.unformatted_apn,
			transform(left),
			left only
		);
		
		// Convert to the ownership classifications described above
		ds_1		:= ds_dids(current);																										// 1. currently owned
		ds_2		:= if(not UseCurrentlyOwnedProperty, ds_dids(not current));	// 2. ever owned
		ds_12		:= ds_addrs_sub(current or not UseCurrentlyOwnedProperty);	// -.	could be 1 or 2
		ds_3		:= if(IncludePriorProperties, ds_addrs_nosub);						// 3. never owned
		ds_all	:= ds_1 + ds_2 + ds_12 + ds_3;
		
		// normalize history, and reduce to just FaresIds we're allowed to use
		ds_norm			:= normalize(ds_all, left.hist, transform(l_norm2, self:=left, self:=right));
		ds_fids1		:= ds_norm(ln_fares_id[1] not in input.srcRestrict);	// blacklist FARES, Fidelity, or LnBranded as needed
		Suppress.MAC_Suppress(ds_fids1,ds_fids2,apptype,,,Suppress.Constants.DocTypes.FaresID,ln_fares_id, isFCRA := isFCRA);
		 
		
		ds_additional_sellers := JOIN(ds_fids2,
																	ln_propertyv2.key_search_fid(isFCRA),
																	KEYED(left.ln_fares_id = right.ln_fares_id) and
																	wild(right.which_orig) and
																	keyed(right.source_code_2 = 'P') and
																	keyed(right.source_code_1 = 'S') and
																	left.did = right.did and
																	right.ln_fares_id[2] != 'A', // data issue of assessment records containing seller records
																	transform(l_norm2, self.owners := [], self.owned := false, self := left),
																	limit(0), keep(1));
																	
		// Decide which FaresIds we're going to display
		// ...for owned, keep the most recent deed/assessment (that's up to two records) that show subject as owner
		// ...for non-owned, keep only the most recent per property address
		
		ds_fids2_cur := project(ds_fids2, transform(l_norm2, self.did := if(exists(left.owners(did=left.did)), left.did, skip), self:=left));
		tmp_own_s	:= sort(ds_fids2_cur(owned), fips_code, unformatted_apn, ln_fares_id[2], -dt_seen, -doxie_ln.get_LNFirst(ln_fares_id), record);
		tmp_own_d	:= dedup(tmp_own_s, fips_code, unformatted_apn, ln_fares_id[2]);
		tmp_non_s	:= sort(ds_fids2(not owned), fips_code, unformatted_apn, ln_fares_id[2], -dt_seen, -doxie_ln.get_LNFirst(ln_fares_id), record);
		tmp_non_d	:= dedup(tmp_non_s, fips_code, unformatted_apn, aceaid);
		tmp_sellers_s := sort(ds_additional_sellers, aceaid, did, ln_fares_id[2], -dt_seen, -doxie_ln.get_LNFirst(ln_fares_id), record);
		tmp_sellers_d := dedup(tmp_sellers_s, aceaid, did);
		ds_combo	:= tmp_own_d + tmp_non_d + if(IncludePropertySellerData, tmp_sellers_d);
		sids			:= project(ds_combo, transform(layouts.search_fid, self.ln_fares_id:=left.ln_fares_id, self.isDeepDive:=false));
		
		
		// The Ownership keys rely on fips+apn, which are missing for about 2% of properties.  So, now
		// we need to use the traditional address key to look for any addresses we missed above.  This
		// follows a similar pattern of logic, but the layouts are all different so we're not able to
		// tie it into the stream of logic as early as would have been nice.
		in_addr3 := join( // narrow inputs to those not successfully handled in previous blocks
			in_addr1, ds_addr1+ds_addr2,
			left.address_seq_no = right.address_seq_no,
			transform(doxie.layout_propertySearch, self:=left),
			left only);
		l_addr3 := record
			in_addr3.address_seq_no;
			boolean owned := false;						  // true indicates this property was ever owned by the subject (cat #1 or #2)
			boolean is_seller := false;         // true indicates seller
			LN_PropertyV2.key_addr_fid().owner;	// true indicates this record shows the current owner (cat #1 or #3)
			LN_PropertyV2.key_addr_fid().lname;
			LN_PropertyV2.key_addr_fid().fname;
			LN_PropertyV2.key_addr_fid().name_suffix;
			LN_PropertyV2.key_addr_fid().ln_fares_id;
		end;
		ds_addr3_raw := join(
			in_addr3, LN_PropertyV2.key_addr_fid(isFCRA),
			  keyed(left.prim_name=right.prim_name)
				and keyed(left.prim_range=right.prim_range)
				and keyed(left.zip=right.zip)
				and keyed(left.predir=right.predir)
			  and keyed(left.postdir=right.postdir)
				and keyed(left.suffix=right.suffix)
			  and keyed(left.sec_range=right.sec_range)
				and right.source_code_1 in ['B','O', 'S'], // including seller data
			transform(l_addr3, self.is_seller:=right.source_code_1 = 'S', self:=right, self:=left),
			limit(max_owned_per_addr, skip)
		);
		ds_addr3_sub := join( // narrow to recs where the name matches the subject -- categories #1 & #2
			ds_addr3_raw, subject_names,
			LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND ut.NNEQ(LEFT.name_suffix,RIGHT.name_suffix),
			transform(l_addr3, self.owned:=not left.is_seller, self:=left),
			keep(1)
		);
		ds_addr3_nosub := join( // category #3
			ds_addr3_raw, ds_addr3_sub,
			left.address_seq_no = right.address_seq_no,
			transform(l_addr3, self.owned:=false, self:=left),
			left only
		);
		
		ds_addr3_1	:= ds_addr3_sub(owner and not is_seller);
		ds_addr3_2	:= if(not UseCurrentlyOwnedProperty, ds_addr3_sub(not owner and not is_seller));
		ds_addr3_3	:= if(IncludePriorProperties, ds_addr3_nosub(not is_seller));
		ds_addr3_4  := if(IncludePropertySellerData, ds_addr3_sub(is_seller)); // if flag set to true, including seller info
		ds_addr3		:= ds_addr3_1 + ds_addr3_2 + ds_addr3_3 + ds_addr3_4;
		
		ds_addr3_fids1 := ds_addr3(ln_fares_id[1] not in input.srcRestrict);		// blacklist FARES, Fidelity, or LnBranded as needed
		Suppress.MAC_Suppress(ds_addr3_fids1,ds_addr3_fids2,apptype,,,Suppress.Constants.DocTypes.FaresID,ln_fares_id,isFCRA := isFCRA);

		tmp_addr3_own_s	:= sort(ds_addr3_fids2(owned), address_seq_no, ln_fares_id[2], -doxie_ln.get_LNFirst(ln_fares_id), -ln_fares_id[3..], record);
		tmp_addr3_own_d	:= dedup(tmp_addr3_own_s, address_seq_no, ln_fares_id[2]);
		tmp_addr3_non_s	:= sort(ds_addr3_fids2(not owned and not is_seller), address_seq_no, ln_fares_id[2], -doxie_ln.get_LNFirst(ln_fares_id), -ln_fares_id[3..], record);
		tmp_addr3_non_d	:= dedup(tmp_addr3_non_s, address_seq_no);
		tmp_addr3_seller_s := sort(ds_addr3_fids2(is_seller), address_seq_no, fname, lname, ln_fares_id[2], -doxie_ln.get_LNFirst(ln_fares_id), -ln_fares_id[3..], record);
		tmp_addr3_seller_d := dedup(tmp_addr3_seller_s, address_seq_no, fname, lname);
		ds_addr3_combo	:= tmp_addr3_own_d + tmp_addr3_non_d + tmp_addr3_seller_d;
		addr3_sids			:= project(ds_addr3_combo, transform(layouts.search_fid, self.ln_fares_id:=left.ln_fares_id, self.isDeepDive:=false));
		// NOTE: We want to favor recency, but we don't have dates here.  So, to approximate recency, we'll
		//       favor ln_fares_id values with a larger numeric component.
		
		combined_sids := dedup(sort(sids+addr3_sids, ln_fares_id), ln_fares_id);
		
		
		// retrieve report records by FaresId
		tmp := LN_PropertyV2_Services.fn_get_report(combined_sids, skipPenaltyFilter:=true);
		// tmp_bydid := LN_PropertyV2_Services.fn_get_report(sids, skipPenaltyFilter:=true);
		// tmp_byaddr := LN_PropertyV2_Services.fn_get_report(addr3_sids, skipPenaltyFilter:=true);
		
		// project to result fmt, assigning owned in the process
		ownSet			:= set(tmp_own_d,ln_fares_id) + set(tmp_addr3_own_d, ln_fares_id);
		results_own	:= resultFmt.tmpToCRS(tmp(ln_fares_id in ownSet), true, IncludePropertySellerData);
		results_non	:= resultFmt.tmpToCRS(tmp(ln_fares_id not in ownSet), , IncludePropertySellerData);

		// Add address_seq_no field
		results_all := LN_PropertyV2_Services.fn_AddSeqNo(results_own+results_non, subject_addrs);
		
		// final sort
		results_s := sort(results_all, if(owned,0,1), -sortby_date, ln_fares_id);
	

		return results_s;
	end;
	
	export unsigned count_currently_owned(
		dataset(doxie.layout_references)			in_dids,
		dataset(doxie.Layout_Comp_Addresses)	subject_addrs,
		dataset(doxie.layout_NameDID)					subject_names,
		string32 appType = LN_PropertyV2_Services.input.appType,
		boolean isFCRA = false
	):= function 	
		
		owned_fat := get_CRS_records(in_dids, 
																 subject_addrs, 
																 subject_names, 
																 appType, 
																 isFCRA, 
																 false, /* IncludePriorProperties */
																 true	 /* UseCurrentlyOwnedProperty */
																 );

		own_slim := record
			typeof(LN_PropertyV2_Services.layouts.out_crs.deeds.apnt_or_pin_number) unformatted_apn;
			LN_PropertyV2_Services.layouts.parties.pparty.prim_range;
			LN_PropertyV2_Services.layouts.parties.pparty.prim_name;
			LN_PropertyV2_Services.layouts.parties.pparty.suffix;
			LN_PropertyV2_Services.layouts.parties.pparty.sec_range;
			typeof(LN_PropertyV2_Services.layouts.parties.pparty.p_city_name) city_name;
			LN_PropertyV2_Services.layouts.parties.pparty.st;
			LN_PropertyV2_Services.layouts.parties.pparty.zip;			
		end;
		
		owned_slim := project(owned_fat,
													transform(own_slim,
														_pparty 	:= left.parties(party_type='P')[1];
														_apn 			:= if(left.fid_type='D', left.deeds[1].apnt_or_pin_number, left.assessments[1].apna_or_pin_number);
														self.unformatted_apn 	:= LN_PropertyV2.fn_strip_pnum(_apn, true);
														self.city_name				:= if(_pparty.p_city_name<>'', _pparty.p_city_name, _pparty.v_city_name),
														self 									:= _pparty));

		owned_slim_byapn := rollup(sort(owned_slim, unformatted_apn), 
		                       left.unformatted_apn = right.unformatted_apn,
													 transform(own_slim, 			
														 				 // same apns so let's try to preserve sec range when at least one is available.
																		 self.sec_range := if(left.sec_range<>'', left.sec_range, right.sec_range),
																		 self := left));   																			
																					
		owned_slim_byaddr	:= dedup(sort(owned_slim_byapn, prim_range, prim_name, city_name, st, sec_range), prim_range, prim_name, city_name, st, sec_range);														 
		
		return count(owned_slim_byaddr);	
		
	end;
	

end;