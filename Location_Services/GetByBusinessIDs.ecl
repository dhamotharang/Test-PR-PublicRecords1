IMPORT BIPV2, Doxie_Raw, iesp, LN_propertyv2, TopBusiness_Services;

EXPORT GetByBusinessIds(DATASET(Doxie_Raw.Layout_address_input) addr_in) := MODULE;
	
	ds_inData := PROJECT(addr_in, 
									TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
											SELF.prim_range := LEFT.prim_range,
											SELF.prim_name := LEFT.prim_name,
											SELF.zip5 := LEFT.zip,
											SELF.city := LEFT.city_name,
											SELF.state := LEFT.st,
											SELF.hsort := TRUE,
											SELF := []));
																					
	EXPORT linkIdsBestOut	:= 	BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_inData).SELEBest(company_name <> '');
	
	busWithScoreRecs := RECORD
		Layout_report.BusAssoc;
		INTEGER record_score;
	END;
	
	ds_linkIdsOut := PROJECT(linkIdsBestOut, 
											TRANSFORM(busWithScoreRecs, 	
													SELF.businessIDs.dotid := LEFT.dotid,
													SELF.businessIDs.empid := LEFT.empid,
													SELF.businessIDs.powid := LEFT.powid,
													SELF.businessIDs.ultid := LEFT.ultid,
													SELF.businessIDs.seleid := LEFT.seleid,
													SELF.businessIDs.proxid := LEFT.proxid,
													SELF.businessIDs.orgid := LEFT.orgid,
													SELF.company_name := DATASET([{(LEFT.company_name)}], Location_Services.Layout_report.CompanyName);
													SELF.record_score := LEFT.record_score;
													SELF := []));
	
	top_score := MAX(ds_linkIdsOut, ds_linkIdsOut.record_score );

	linkIdsInfoOut_top_score := ds_linkIdsOut(record_score = top_score);
	
	EXPORT linkIdsInfoOut := PROJECT(linkIdsInfoOut_top_score, 
																TRANSFORM(Layout_report.BusAssoc, SELF := LEFT));
  
	EXPORT GetLinkIds() := FUNCTION
	
		BIPV2.IDlayouts.l_xlink_ids xForm_LinkIds(linkIdsInfoOut le) := TRANSFORM
			SELF := le.BusinessIds;
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