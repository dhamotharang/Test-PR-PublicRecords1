IMPORT doxie, business_header, AutoStandardI, AutoHeaderI, TopBusiness_Services;

it 							:= AutoStandardI.InterfaceTranslator;
gm 							:= input.gm();

inner_params2 := interface(input.params,it.noDeepDive.params, TopBusiness_Services.iParam.BIDParams)
	export string45 ParcelId;
end;

inner_id_search (inner_params2 in_mod,
									boolean isAssetRpt = false,
									boolean didOnly = false,
									dataset(layouts.search_did)		in_dids		= dataset([], layouts.search_did),
									dataset(layouts.search_bdid)	in_bdids	= dataset([], layouts.search_bdid)):= function

		// =========================================================
		//  Get seqs associated with various inputs...
		// =========================================================

		// NOTE: We check "input.paSearch" below to disable some expensive code below
		// when running a property address search -- we can get away with this because
		// deep diving doesn't make sense in that context.

		// NOTE: This may or may not be temporary.  We used to just set workHard=false
		// here but that was effectively disabling phonetic matching within the autokey
		// code.  We may want to fix that similar to how we fixed nicknames in bug 22532.
		doxie.MAC_Header_Field_Declare();
		workHard := phonetics;

		// autokeys
		
		by_auto	:= LN_PropertyV2_Services.autokey_ids(workHard,,not input.incDeepDive,in_mod);

		// deep dids
		tempmod2 := module(project(in_mod,AutoheaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
				export forceLocal := true;
				export noFail := not isAssetRpt;
			end;
			
		deep_dids	:= limit( AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tempmod2), LN_PropertyV2_Services.consts.max_deepDIDs, skip);



		by_deep 	:= if(input.incDeepDive and not input.paSearch, LN_PropertyV2_Services.Raw.get_fids_from_dids(deep_dids));

		// project bdid supergroup into correct layout
		supergroup_bdids := if(not input.paSearch, in_bdids + project(business_header.bdidDataset,LN_PropertyV2_Services.layouts.search_bdid));

		// lookup by direct key
		by_key := LN_PropertyV2_Services.ReportService_ids(input.did, input.bdid, input.parcelID, input.faresId, in_dids, supergroup_bdids);

		// if this is an APN search, we need to filter by location info
		by_key_loc := if(
			input.parcelID<>'' and input.faresId='' and (zip_value<>[] or city_value<>'' or state_value<>''),
			join(
				by_key, keys.search(),
				keyed(left.ln_fares_id=right.ln_fares_id) and right.source_code_2='P'
					and (zip_value=[] or (integer)right.zip in zip_value) // covers Zip, State+County, or State+City+ZipRadius
					and ((zipradius_value=0 or state_value='') and city_value in ['',right.p_city_name,right.v_city_name]) // covers literal City when no radius
					and (zipradius_value=0 and state_value in ['',right.st]),	// covers literal State when no radius
				transform(layouts.fid, self:=left),
				keep(1), limit(0) //can be a few, but we need just fares ID.
			),
			by_key
		);
		
		// lookup by DID
		dids := dataset([{input.did}], LN_PropertyV2_Services.layouts.search_did);

		by_did := LN_PropertyV2_Services.Raw.get_fids_from_dids(dids);
		
		// lookup by input business ids
		in_bids := TopBusiness_Services.Functions.create_business_ids_dataset(in_mod);
		by_bids := LN_PropertyV2_Services.Raw.get_fids_from_bids(in_bids,in_mod.BusinessIDFetchLevel);

		// output(by_auto, 		named('by_auto'));		// DEBUG
		// output(deep_dids, 	named('deep_dids'));	// DEBUG
		// output(by_deep,		named('by_deep'));		// DEBUG
		// output(by_key,			named('by_key'));			// DEBUG
		// output(by_key_loc,	named('by_key_loc'));	// DEBUG


		// ========================================
		//  assemble them into a single dataset...
		// ========================================

		// ...adding the deep dive flag 
		addFlag(dataset(LN_PropertyV2_Services.layouts.fid) ds, boolean flag) := project(
			ds,
			transform(LN_PropertyV2_Services.layouts.search_fid, self.isDeepDive := flag, self := left)
		);

		fids_all := map(
			input.isDirectKey or exists(in_dids(did != 0)) or exists(supergroup_bdids(bdid != 0)) => addFlag(by_key_loc, false),
			exists (by_bids) => addFlag(by_bids, false),
			addFlag(by_deep, true) + by_auto
		);
		
		fids_didOnly := if(
			input.did<>0,
			addFlag(by_did, false),
			addFlag(by_deep, true)
		);
		fids := if(didOnly, fids_didOnly, fids_all);
		return fids;		
end;

export dataset(LN_PropertyV2_Services.layouts.search_fid) SearchService_ids(
	boolean isAssetRpt = false,
	boolean didOnly = false,
	dataset(LN_PropertyV2_Services.layouts.search_did)		in_dids		= dataset([], LN_PropertyV2_Services.layouts.search_did),
	dataset(LN_PropertyV2_Services.layouts.search_bdid)	in_bdids	= dataset([], LN_PropertyV2_Services.layouts.search_bdid)
	) := function
	
temp_mod_one := module(project(gm,inner_params2,opt))
	export parcelid := input.parcelid;
end;
temp_mod_two := module(project(gm,inner_params2,opt))
export parcelid := input.parcelid;
export firstname := gm.entity2_firstname;
export middlename := gm.entity2_middlename;
export lastname := gm.entity2_lastname;
export unparsedfullname := gm.entity2_unparsedfullname;
export allownicknames := gm.entity2_allownicknames;
export phoneticmatch := gm.entity2_phoneticmatch;
export companyname := gm.entity2_companyname;
export addr := gm.entity2_addr;
export city := gm.entity2_city;
export state := gm.entity2_state;
export zip := gm.entity2_zip;
export zipradius := gm.entity2_zipradius;
export phone := gm.entity2_phone;
export fein := gm.entity2_fein;
export bdid := gm.entity2_bdid;
export did := gm.entity2_did;
export ssn := gm.entity2_ssn;
end;
 party_one_results := inner_id_search(temp_mod_one,isAssetRpt,didOnly,in_dids,in_bdids);
 party_two_results := inner_id_search(temp_mod_two,isAssetRpt,didOnly,in_dids,in_bdids);
//output(party_one_results,named('L1'));
//output(party_two_results,named('L2'));

two_party_search_results := join(
party_one_results,
party_two_results,
left.ln_fares_id= right.ln_fares_id,
transform(left),
		keep(1),
		limit(0));

selected_results := if(gm.TwoPartySearch,
two_party_search_results,
party_one_results);

	// ...and shifting deep-dive-only to the end
	fids_d := dedup(sort(selected_results, ln_fares_id, if(isDeepDive, 1, 0)), ln_fares_id);

	// output(fids, 	named('fids')); 	// DEBUG
	// output(fids_d, named('fids_d')); // DEBUG
	
return fids_d;

end;