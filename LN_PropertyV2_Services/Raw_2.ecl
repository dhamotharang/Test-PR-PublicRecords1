import LN_PropertyV2, BIPV2;

export Raw_2(STRING10 lookupVal = '', STRING10 partyType = '', STRING12 faresID = '') := module

	// ------------------------------------------
	// Key & layout abbreviations
	// ------------------------------------------
	shared k_did(boolean isFCRA)		:= keys_2.search_did(isFCRA);
	shared k_bdid		:= keys_2.search_bdid;
	shared k_pnum_a	:= keys_2.search_pnum_a;
	shared k_pnum_d	:= keys_2.search_pnum_d;
	shared k_addr(boolean isFCRA)		:= keys_2.search_addr(isFCRA);
	shared k_linkId	:= LN_propertyv2.key_Linkids;
	shared l_did		:= layouts.search_did;
	shared l_bdid		:= layouts.search_bdid;
	shared l_pnum		:= layouts.search_pnum;
	shared l_addr		:= layouts.search_addr;
	shared l_fid		:= layouts.fid;
	shared l_sid		:= layouts.search_fid;
	
	
	// ------------------------------------------
	// Key conversions
	// ------------------------------------------
	shared lookupValOK(string fid)			:= lookupVal in ['',LN_PropertyV2.fn_fid_type(fid)];
	shared partyTypeOK(string src_code)	:= partyType in ['',src_code[1]];
	// shared partyTypeOK(string src_code)	:= case(partyType, ''=>true, 'P'=>src_code[2]='P', src_code[1]=partyType);
	
	export dataset(l_fid) cleanFids(dataset(l_fid) in_fids) := function
		fids_d	:= dedup(sort(in_fids,record),record);
		fids		:= fids_d(lookupValOK(ln_fares_id));
		return fids;
	end;
	
	export dataset(l_sid) cleanSids(dataset(l_sid) in_sids) := function
		sids_d	:= dedup(sort(in_sids,record),record);
		sids		:= sids_d(lookupValOK(ln_fares_id));
		return sids;
	end;
	
	export dataset(l_sid) get_sids_from_fids(dataset(l_fid) in_fids, boolean isDD=false) := function
		sids := project(in_fids, transform(l_sid, self.ln_fares_id:=left.ln_fares_id, self.isDeepDive:=isDD, self.search_did := left.search_did));
		return sids;
	end;
	
	export dataset(l_fid) get_fids_from_dids(dataset(l_did) in_dids,boolean isFCRA=false) := function
		res := join(
			dedup(sort(in_dids,did),did), k_did(isFCRA),
			keyed(left.did = right.s_did) and 
      lookupValOK(right.ln_fares_id) and
      partyTypeOK(right.source_code) and
      // filter out "Care-Of" records on FCRA side
      (~IsFCRA or right.source_code[1] <> 'C'),
			transform(l_fid, self := right, self.search_did := right.s_did),
			atmost(consts.max_raw)
		);
		return cleanFids(res);
	end;
	
	export dataset(l_fid) get_fids_from_bdids(dataset(l_bdid) in_bdids) := function
		res := join(
			dedup(sort(in_bdids,bdid),bdid), k_bdid,
			keyed(left.bdid = right.s_bid) and lookupValOK(right.ln_fares_id) and partyTypeOK(right.source_code),
			transform(l_fid, self := right),
			atmost(consts.max_raw)
		);
		return cleanFids(res);
	end;
	
	export dataset(l_fid) get_fids_from_bids(
									DATASET(BIPV2.IDlayouts.l_xlink_ids) link_ds = DATASET([], BIPV2.IDlayouts.l_xlink_ids), 
									STRING1 BusinessIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID) := function
		res := project(k_linkId.kfetch(link_ds, BusinessIdFetchLevel),
										 transform(l_fid, self := left, self := []));
		return cleanFids(res);
	end;
	
	export dataset(l_fid) get_fids_from_pnum(dataset(l_pnum) in_pnum) := function
		in_d := dedup(sort(in_pnum,pnum),pnum);
		res_a := join(
			in_d, k_pnum_a,
			keyed(left.pnum = right.fares_unformatted_apn) and lookupValOK(right.ln_fares_id),
			transform(l_fid, self := right),
			atmost(consts.max_raw)
		);
		res_d := join(
			in_d, k_pnum_d,
			keyed(left.pnum = right.fares_unformatted_apn) and lookupValOK(right.ln_fares_id),
			transform(l_fid, self := right),
			atmost(consts.max_raw)
		);
		return cleanFids(res_a+res_d);
	end;

	export dataset(l_fid) get_fids_from_addr(dataset(l_addr) in_addrs,boolean isFCRA = false) := function
		by_addr := join(
			in_addrs, k_addr(isFCRA),
			keyed(left.prim_name=right.prim_name) and
				keyed(left.prim_range=right.prim_range) and
				keyed(left.zip=right.zip) and
				keyed(left.predir=right.predir) and
				keyed(left.postdir=right.postdir) and
				keyed(left.suffix=right.suffix) and
				keyed(left.sec_range=right.sec_range) and
				right.source_code_2='P' and
				lookupValOK(right.ln_fares_id),
			transform(layouts.fid,self:=right),
			atmost(consts.max_raw)
		);
		return cleanFids(by_addr);
	
	end; // exp_fids_by_addr
	

	// ------------------------------------------
	// FaresID expansions
	// ------------------------------------------
	export dataset(layouts.fid) exp_fids_by_pnum(dataset(layouts.fid) fids,boolean isFCRA = false) := function

		// get ParcelIDs for specified FaresIDs
		pnum_d := join(
			fids, keys_2.deed(isFCRA),
			keyed(left.ln_fares_id = right.ln_fares_id),
			transform(layouts.search_pnum, self.pnum := LN_PropertyV2.fn_strip_pnum(right.apnt_or_pin_number)),
			atmost(consts.max_raw)
		);
		pnum_a := join(
			fids, keys_2.assessor(isFCRA),
			keyed(left.ln_fares_id = right.ln_fares_id),
			transform(layouts.search_pnum, self.pnum := LN_PropertyV2.fn_strip_pnum(right.apna_or_pin_number)),
			atmost(consts.max_raw)
		);
		pnum := pnum_d + pnum_a;
		
		// expand to all recs with matching ParcelID
		by_pnum := if( exists(pnum), get_fids_from_pnum(pnum) );
		
		// output(pnum_d,		named('pnum_d'));		// DEBUG
		// output(pnum_a,		named('pnum_a'));		// DEBUG
		// output(pnum,			named('pnum'));			// DEBUG
		// output(by_pnum,	named('by_pnum'));	// DEBUG
		
		return by_pnum;
		
	end; // exp_fids_by_pnum
	
	export dataset(layouts.fid) exp_fids_by_addr(dataset(layouts.fid) fids,boolean isFCRA=false) := function
	
		// get property addrs for specified records
		addr_raw := join(
			fids, keys_2.search(isFCRA),
			keyed(left.ln_fares_id=right.ln_fares_id) and right.source_code_2='P',
			transform(l_addr,self:=right),
			keep(1), // only 1 prop addr per ln_fares_id
			atmost(consts.max_raw)
		);
		addr := dedup(addr_raw, record, all);
		
		// expand to all recs with matching property addr
		by_addr := get_fids_from_addr(addr);
		
		// output(addr,			named('addr'));			// DEBUG
		// output(by_addr,	named('by_addr'));	// DEBUG
		
		return by_addr;
	
	end; // exp_fids_by_addr
	
	// this is used for sorting the original ln_fares_id to the top of the results
	export unsigned1 fid_match(string12 fid) := if( faresID in ['',fid], 0, 1 );
	
	export deed_recency_raw(LN_PropertyV2_Services.layouts.deeds.raw_source rec) :=
		function
			return map(
				rec.contract_date<>''				=> rec.contract_date,
				rec.fares_mortgage_date<>''	=> rec.fares_mortgage_date,
				rec.recording_date
			);		
		end;
	
	export assess_recency_raw(LN_PropertyV2_Services.layouts.assess.raw_source rec) :=
		function
			return map(
				rec.tax_year<>''							=> rec.tax_year+'0000',
				rec.assessed_value_year<>''		=> rec.assessed_value_year+'0000',
				rec.market_value_year<>''			=> rec.market_value_year+'0000',
				rec.certification_date<>''		=> rec.certification_date+'00',
				rec.tape_cut_date<>''					=> rec.tape_cut_date,
				rec.recording_date<>''				=> rec.recording_date,
				rec.prior_recording_date<>''	=> rec.prior_recording_date,
				rec.sale_date
			);
		end;
	
end; // Raw_2