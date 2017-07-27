//============================================================================
// Attribute: AirCraft_raw.  Used by view source service and comp-report.
// Function to get faa aircraft records by did or bdid.
// Return layout: doxie_crs.layout_Faa_Aircraft_records.
//============================================================================

import faa, fcra, codes, ut, doxie_crs, Doxie, suppress, FaaV2_Services, BIPV2, FFD;

MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

// FCRA: there are no FCRA-specific restrictions (date/state/etc. based) for this data

export AirCraft_Raw(
    dataset(Doxie.layout_references) dids,
    dataset(Doxie.Layout_ref_bdid) bdids, // = dataset([], Doxie.Layout_ref_bdid)?,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    string6 ssn_mask_value = 'NONE',
		string32 applicationType='',
    boolean IsFCRA = false,
    dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
		dataset(BIPV2.IDlayouts.l_xlink_ids2) linkids = dataset([], BIPV2.IDlayouts.l_xlink_ids2),
		string1 BIPFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID,
		dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
		integer8 inFFDOptionsMask = 0 
) := FUNCTION

	// get aircrafts IDs; FCRA: overrides are not required
	key_did := faa.key_aircraft_did (IsFCRA);

	bydid := join(dids,key_did, keyed(left.did = right.did),
              transform (FaaV2_Services.Layouts.search_id, Self.aircraft_id := Right.aircraft_id),
              ATMOST (ut.limits.AIRCRAFTS_PER_DID));

	// FCRA: BDIDs are not used
	bybdid := if (~IsFCRA, 
               join(bdids,faa.Key_Aircraft_Reg_BDID, keyed (left.bdid = right.bd),
               transform (FaaV2_Services.Layouts.search_id, Self.aircraft_id := Right.aircraft_id),
               ATMOST (ut.limits. AIRCRAFTS_PER_BDID)));

	// Search via BIP Linkids
	ds_from_linkids := IF(~IsFCRA,PROJECT(faa.key_aircraft_linkids.kFetch2(linkids,BIPFetchLevel,,FaaV2_Services.Constants.max_recs_on_linkid_join),
															 transform (FaaV2_Services.Layouts.aircraftNumberPlus,
																					SELF := LEFT,
																					SELF := [])));
	
	// Get aircraft_ids via the aircraft_numbers.  
	air_keys := FaaV2_Services.Raw.byAircraftNumber(ds_from_linkids);
	bylinkids := PROJECT(FaaV2_Services.Raw.byAircraftNumber(ds_from_linkids),
								transform(FaaV2_Services.Layouts.search_id,
								SELF := LEFT));
																							
	// combine, keep autokey hits separate from linkid fetch since autokey fetch's rollup on did and bdid while
	// linkid fetch's rollup on the linkids.      
	all_ak_ids := dedup(sort(bydid + bybdid ,aircraft_id),aircraft_id);
	all_link_ids := dedup(sort(bylinkids ,aircraft_id),aircraft_id);

	// true == "best" registration record
	ds_air_raw_ak := FaaV2_Services.Raw.getFullAircraft(all_ak_ids,applicationType,isFCRA,flagfile,true, slim_pc_recs, inFFDOptionsMask);
	ds_air_raw_link := FaaV2_Services.Raw.getFullAircraft(all_link_ids,applicationType,isFCRA,flagfile,true, slim_pc_recs, inFFDOptionsMask);

	// Final output
	// Note that detailed info and engine shouldn't have being defined as datasets: the may contain 
	//   at most one record (currently these "datasets" are unwrapped on ESP side).
	doxie_crs.layout_Faa_Aircraft_records aircraft_trans(FaaV2_Services.Layouts.aircraft_full l, string2 inSource) := transform
		self.current_flag_mapped:=map(L.aircraft.current_flag = 'H' => 'Historical',
																		L.aircraft.current_flag = 'A' => 'Active',
																		'');
		self:=l.aircraft;
		self.county_name := l.county_name;
		self.engine_info := dataset(row(l.engine, doxie_crs.layout_FAR_engine));
		self.craft_info := dataset(row(l.detail, transform(doxie_crs.layout_FAR_aircraft,
				self.engine_type_mapped := codes.FAA_AIRCRAFT_REF.TYPE_ENGINE(left.type_engine), 
				self.aircraft_type_mapped := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(left.type_aircraft),
				self.category_mapped := codes.FAA_AIRCRAFT_REF.AIRCRAFT_CATEGORY_CODE(left.aircraft_category_code),
				self.amateur_certification_mapped := codes.FAA_AIRCRAFT_REF.AMATEUR_CERTIFICATION_CODE(left.amateur_certification_code),
				self.aircraft_weight_mapped := Codes.KeyCodes('FAA_AIRCRAFT_REF','AIRCRAFT_WEIGHT',,left.aircraft_weight),
				self := left)));
		self.source := inSource;
		SELF.StatementIDs := l.StatementIDs;
		SELF.isDisputed :=	l.isDisputed;	
		SELF := l;
	end;
	ds_aircraft_ak := project(ds_air_raw_ak,aircraft_trans(left,FaaV2_Services.Constants.autokey_src));
	ds_aircraft_lk := project(ds_air_raw_link,aircraft_trans(left,FaaV2_Services.Constants.linkid_src));

	srtd := sort(ds_aircraft_ak+ds_aircraft_lk, -last_action_date, -date_last_seen);

	doxie.MAC_PruneOldSSNs(srtd, srtd_pruned, best_ssn, did_out, IsFCRA);
	suppress.MAC_Mask(srtd_pruned, out_mskd, best_ssn, blank, true, false);

	return out_mskd;

END;
