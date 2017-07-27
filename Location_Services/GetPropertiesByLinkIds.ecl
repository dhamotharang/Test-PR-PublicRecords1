IMPORT BIPV2, Doxie_Raw, iesp, LN_propertyv2, TopBusiness_Services;

EXPORT GetPropertiesByLinkIds(DATASET(Doxie_Raw.Layout_address_input) addr_in) := MODULE;
	
	ds_inData := PROJECT(addr_in, 
									TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
											SELF.prim_range := LEFT.prim_range,
											SELF.prim_name := LEFT.prim_name,
											SELF.zip5 := LEFT.zip,
											SELF.sec_range := LEFT.city_name,
											SELF.state := LEFT.st,
											SELF.hsort := TRUE,
											SELF := []));
																					
	ds_linkIdsOutTemp	:= 	BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_inData).SELEBest;
	
	busWithScoreRecs := RECORD
		Layout_report.BusAssocWithLinkIds busWithLinkIds;
		INTEGER record_score;
	END;
	
	ds_linkIdsOut := PROJECT(ds_linkIdsOutTemp, 
											TRANSFORM(busWithScoreRecs, 	
													SELF.busWithLinkIds.link_ids.dotid := LEFT.dotid,
													SELF.busWithLinkIds.link_ids.empid := LEFT.empid,
													SELF.busWithLinkIds.link_ids.powid := LEFT.powid,
													SELF.busWithLinkIds.link_ids.ultid := LEFT.ultid,
													SELF.busWithLinkIds.link_ids.seleid := LEFT.seleid,
													SELF.busWithLinkIds.link_ids.proxid := LEFT.proxid,
													SELF.busWithLinkIds.link_ids.orgid := LEFT.orgid,
													SELF.busWithLinkIds.company_name := LEFT.company_name,
													SELF := LEFT));
	
  // Only one company name per ultid/orgid/seleid when using SELEBest.	
	linkIdsInfoOut_sorted := SORT(ds_linkIdsOut, -record_score )(busWithLInkIds.company_name <> '');
	
	// Use only the top scoring records to narrow on address.  
	top_score := linkIdsInfoOut_sorted[1].record_score;

	linkIdsInfoOut_top_score := linkIdsInfoOut_sorted(record_score = top_score);
	
	EXPORT linkIdsInfoOut := PROJECT(linkIdsInfoOut_top_score, 
																TRANSFORM(Layout_report.BusAssocWithLinkIds, 
																		SELF.link_ids.dotid := LEFT.busWithLinkIds.link_ids.dotid,
																		SELF.link_ids.empid := LEFT.busWithLinkIds.link_ids.empid,
																		SELF.link_ids.powid := LEFT.busWithLinkIds.link_ids.powid,
																		SELF.link_ids.ultid := LEFT.busWithLinkIds.link_ids.ultid,
																		SELF.link_ids.orgid := LEFT.busWithLinkIds.link_ids.orgid,
																		SELF.link_ids.seleid := LEFT.busWithLinkIds.link_ids.seleid,
																		SELF.link_ids.proxid := LEFT.busWithLinkIds.link_ids.proxid,
																		SELF.company_name := LEFT.busWithLinkIds.company_name,
																		SELF := LEFT));
  
	EXPORT GetLinkIds() := FUNCTION
	
		BIPV2.IDlayouts.l_xlink_ids xForm_LinkIds(linkIdsInfoOut le) := TRANSFORM
			SELF.dotid 	:= le.link_ids.dotid;
			SELF.empid 	:= le.link_ids.empid;
			SELF.powid 	:= le.link_ids.powid;
			SELF.ultid 	:= le.link_ids.ultid;
			SELF.orgid 	:= le.link_ids.orgid;
			SELF.seleid := le.link_ids.seleid;
			SELF.proxid := le.link_ids.proxid;
		END;
		
		// Extract just the linking ids.	
		linkIdsOnly := PROJECT(linkIdsInfoOut, xForm_LinkIds(LEFT));
	
		RETURN linkIdsOnly;
		
	END;
	
	EXPORT GetPropFids() := FUNCTION
		
		// Fetch property recs using linking ids so we can get the FID.
		property_recs_raw := LN_propertyv2.key_Linkids.kfetch(getLinkIds(),
																				TopBusiness_Services.Constants.sourceLinkIdLevel)(source_code[2]='P');
																				
		// Don't need to sort by proxid because we don't have one.																	
		property_recs_dedup := DEDUP(SORT(property_recs_raw, -selescore, -dt_vendor_last_reported), ultid, orgid, seleid);
						
		fid_rec := RECORD
			STRING12 fid := '';
			STRING2 source_code := '';
		END;
			
		fid_rec intof(property_recs_raw le) := TRANSFORM
			SELF.fid := le.ln_fares_id;
			SELF.source_code := le.source_code;
		END;  

		busFids := PROJECT(property_recs_dedup, intof(LEFT));	
		
		RETURN busFids;
		
	END;
	
	EXPORT GetSourceRecs() := FUNCTION
	
		source_recs := CHOOSEN(BIPV2.Key_BH_Linking_Ids.kFetch(GetLinkIds(), 
																TopBusiness_Services.Constants.sourceLinkIdLevel), 
																		iesp.Constants.TOPBUSINESS.MAX_COUNT_BK_RECORD); // limit the same as TopBusiness_Services
				
		RETURN source_recs;
		
	END;

END; 