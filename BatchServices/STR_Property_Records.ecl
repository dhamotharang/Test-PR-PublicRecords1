import Autokey_batch, LN_PropertyV2_Services, Suppress;

///////////////////////////////////////////////////////////////////////////////
// This code was previously in BatchServices.STR_Records. I'm moving it over here so
// we can reuse the same code to search properties by address and/or apn.
///////////////////////////////////////////////////////////////////////////////

EXPORT STR_Property_Records(dataset(BatchServices.STR_Layouts.batch_in_ready) ds_batch_in,
														BatchServices.Interfaces.str_config in_mod) := 
MODULE
	
	p_batch_in 	:= project(ds_batch_in, LN_PropertyV2_Services.layouts.batch_in);	
	p_recs 			:= BatchServices.Property_BatchService_Records(p_batch_in, ['A','D']);	
	
	shared fids_all	:= join(ds_batch_in, p_recs.ds_outpl_slim_filtered, left.acctno = right.acctno);		
	export fids_too_many_matches := dedup(sort(fids_all(search_status = STR_Constants.ErrorCodes.TOO_MANY_MATCHES), acctno), acctno);														

	fids1				:= fids_all(ln_fares_id[1] not in LN_PropertyV2_Services.input.srcRestrict, // blacklist FARES, Fidelity, or LnBranded as needed
													search_status = BatchServices.STR_Constants.ErrorCodes.NO_ERROR);
	Suppress.MAC_Suppress(fids1,fids2,in_mod.ApplicationType,,,Suppress.Constants.DocTypes.FaresID,ln_fares_id);													
	
	export fids := project(fids2, TRANSFORM(BatchServices.STR_Layouts.Working_Property, SELF:=LEFT, SELF:=[]));																					
	
	// go get deeds and assement records
	raw_search_fids := dedup(sort(project(fids, LN_PropertyV2_Services.layouts.search_fid), ln_fares_id));	
	ds_deeds_raw 	:= LN_PropertyV2_Services.fn_get_deeds_raw(raw_search_fids);
	ds_assess_raw := LN_PropertyV2_Services.fn_get_assessments_raw(raw_search_fids);	
	
	ds_deeds_plus_acctnos  	:= join(fids, ds_deeds_raw, left.ln_fares_id = right.ln_fares_id, BatchServices.STR_Transforms.add_deed_to_flat(left, right));																			
	ds_assess_plus_acctnos 	:= join(fids, ds_assess_raw, left.ln_fares_id = right.ln_fares_id, BatchServices.STR_Transforms.add_assess_to_flat(left, right));																			
	ds_deeds_plus_assess 		:= ds_deeds_plus_acctnos + ds_assess_plus_acctnos;
	// dropping possible 'future' records
	ds_deeds_plus_assess_filtered	:= ds_deeds_plus_assess((unsigned6) sortby_date[1..4] <= search_year_until);
	
	// grab the parties for all deeds and assessements
	ds_props_with_parties := join(ds_deeds_plus_assess_filtered, LN_PropertyV2_Services.keys.search(),	
														keyed(left.ln_fares_id = right.ln_fares_id) and		
														right.source_code_2 = 'P' and
														// party type: property and owners + sellers + borrowers
														(right.source_code_1 = 'O' or right.source_code_1 = 'S' or right.source_code_1 = 'B') and 
														(left.apnSearch or right.prim_range='' or left.prim_range = right.prim_range) and		// reducing the number of records
														(left.apnSearch or right.zip='' or left.z5 = right.zip) and
														// in case of search by apn, we want to restrict to a matching county, if an address has been provided.
														(~left.apnSearch or left.county='' or left.county = right.county), 
														BatchServices.STR_Transforms.add_party_to_flat(LEFT, RIGHT),
														LEFT OUTER, keep(STR_Constants.Limits.MAX_RECORDS_KEEP), limit(STR_Constants.Limits.JOIN_LIMIT));

	//////////////////////////////////////////////////////////////////////////
	// Supress records by fids below.
	//////////////////////////////////////////////////////////////////////////
	
	fidsToPull1 := 
		join(ds_props_with_parties, Suppress.Key_New_Suppression(),
					keyed(right.Product in map (in_mod.ApplicationType = Suppress.Constants.ApplicationTypes.PeopleWise => Suppress.Constants.SuppressPeopleWise,
															 in_mod.ApplicationType = Suppress.Constants.ApplicationTypes.LE => Suppress.Constants.SuppressLE,
															 Suppress.Constants.SuppressGeneral)) and 
					keyed(right.Linking_type = Suppress.Constants.LinkTypes.DID) and
				 (unsigned6)left.owners[1].owner_did<>0 and 
					 keyed(intformat((unsigned6)left.owners[1].owner_did,12,1) = right.Linking_ID),
				 transform(LN_PropertyV2_Services.layouts.fid, self := left),keep(1));
	fidsToPull2 := 
		join(ds_props_with_parties, Suppress.Key_New_Suppression(), 
					keyed(right.Product in map (in_mod.ApplicationType = Suppress.Constants.ApplicationTypes.PeopleWise => Suppress.Constants.SuppressPeopleWise,
															 in_mod.ApplicationType = Suppress.Constants.ApplicationTypes.LE => Suppress.Constants.SuppressLE,
															 Suppress.Constants.SuppressGeneral)) and 
					keyed(right.Linking_type = Suppress.Constants.LinkTypes.SSN) and
				 length(trim((string60)left.owners[1].owner_ssn))<>0 and 
				 keyed((string60)left.owners[1].owner_ssn = right.Linking_ID),
				 transform(LN_PropertyV2_Services.layouts.fid, self := left),keep(1));
	fidsToPull := fidsToPull1+fidsToPull2;
	
	// pull all suppressed fids from property records.
	ds_props_with_parties_pulled := 
		join(ds_props_with_parties, fidsToPull, left.ln_fares_id = right.ln_fares_id,
				 transform(BatchServices.STR_Layouts.Working_Property, self := left),
				 left only);
	
	//////////////////////////////////////////////////////////////////////////	

	// here we may still have some records not related to the input address. apply address penalty to filter those out.
	ds_batch_in_penalty := project(ds_batch_in, BatchServices.STR_Transforms.prepare_to_penalize(LEFT));		
	ds_props_pre_penalty := join(ds_batch_in_penalty, ds_props_with_parties_pulled,
															 LEFT._acctno = RIGHT.acctno,
															 TRANSFORM(BatchServices.STR_Layouts.Working_Property, 
																				 self.penalt := STR_Functions.penalize_address(left, right),
																				 self := right));	
	ds_props_penalized := ds_props_pre_penalty(penalt <= in_mod.PenaltThreshold);		

	// roll up records for each acctno, keeping the latest property info (sale date, assessed value, etc) on top. 
	// also building owner dataset along the way.
	ds_props_recs_s := sort(ds_props_penalized, acctno, sortby_date);
	ds_props_recs_r := rollup(ds_props_recs_s, BatchServices.STR_Transforms.rollup_property_records(left, right), acctno);			
	// exclude property records where search could not locate a single address.
	export records := ds_props_recs_r(ln_fares_id<>'', ~multipleApnLocation);
		
END;