IMPORT  doxie, Autokey_batch, FCRA, FFD, suppress, STD, WatercraftV2_Services;

// Constants
STRING BLNK := '';
STRING CURRENT_IND_STR := 'CURRENT';

toUpper(STRING input) := STD.Str.ToUpperCase(TRIM(input, LEFT, RIGHT));

EXPORT BatchRecords(WatercraftV2_Services.Interfaces.batch_params configData, 
										DATASET(WatercraftV2_Services.Layouts.batch_in) clean_in, 
										BOOLEAN isFCRA = false,
										DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
										DATASET(FCRA.Layout_override_flag) ds_flags = DATASET([], FCRA.Layout_override_flag)
										) := FUNCTION
										
	ds_batch_in_common 	:= project(clean_in, Autokey_batch.Layouts.rec_inBatchMaster);	

	// Search via AutoKey	
	fromAK :=  WatercraftV2_Services.BatchIds.AutoKeyIds(ds_batch_in_common);
									
	// Search via DID and DID Lookup (deepdive)
	fromDID := WatercraftV2_Services.BatchIds.byDIDIds(ds_batch_in_common, configData.RunDeepDive, isFCRA);
	
	// Search via business linkids
	fromLinkid := WatercraftV2_Services.BatchIds.byLinkIDs(clean_in,configData.BIPFetchLevel);
	
		// if isFCRA skip autokey search
	acctNos := if(isFCRA, fromDID, fromAK + fromDID + fromLinkid);
	acctNos_final := dedup(sort(acctNos, acctno, watercraft_key, sequence_key), acctno, watercraft_key, sequence_key);
	
	// Get watercraft based on watercraft ids obtained
	in_watercraftkeys := PROJECT(acctNos_final, TRANSFORM(WatercraftV2_Services.Layouts.search_watercraftkey,
													self.subject_did := left.ldid, self := left));
	ds_recs_wk := UNGROUP(WatercraftV2_Services.get_watercraft(in_watercraftkeys, BLNK, isFCRA, 
																															ds_flags,
																															configData.include_non_regulated_sources,
																															slim_pc_recs, 
																															configData.FFDOptionsMask).report());

	ds_recs := IF(configData.ReturnCurrentOnly, ds_recs_wk(toUpper(rec_type) = CURRENT_IND_STR), ds_recs_wk);
	
	// recover acctno and handle non_subject suppression
	WatercraftV2_Services.Layouts.batch_report xformNonSubject(WatercraftV2_Services.Layouts.WCReportEX L, WatercraftV2_Services.Layouts.acct_rec R) := transform
		self.acctno := R.acctno;
		//suppressing owners that are not the subject searched on and are not a company
		owners_supp := project(L.owners((unsigned6)did = R.ldid or (bdid <> '' or company_name <> '' or ultId <> 0)), transform(WatercraftV2_Services.Layouts.owner_report_rec,
																																																						  self.orig_name := '', self := left));
		//adding FCRA restriction tag to non-subject owners
		owners_restricted :=  project(L.owners(~((unsigned6)did = R.ldid or (bdid <> '' or company_name <> '' or ultId <> 0))), 
																							 transform(WatercraftV2_Services.Layouts.owner_report_rec,
																												 self.lname := FCRA.Constants.FCRA_Restricted, self := []));
		owners_returnNameOnly := project(L.owners(~((unsigned6)did = R.ldid or (bdid <> '' or company_name <> '' or ultId <> 0))), 
																							 transform(WatercraftV2_Services.Layouts.owner_report_rec,
																												 self.fname := left.fname, 
																												 self.mname := left.mname, 
																												 self.lname := left.lname, 
																												 self.name_suffix := left.name_suffix, 
																												 self := []));
		self.owners := map(configData.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => owners_supp + owners_restricted, 
											 configData.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnNameOnly => owners_supp + owners_returnNameOnly,
											 configData.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => owners_supp,
											 L.owners); //default: configData.non_subject_suppresson = Suppress.Constants.NonSubjectSuppression.doNothing
		self := L;
	end;
	ds_recs_final := JOIN(ds_recs, acctNos_final,
								LEFT.subject_did = (unsigned6)RIGHT.ldid AND
								LEFT.watercraft_key = RIGHT.watercraft_key AND 
								LEFT.sequence_key = RIGHT.sequence_key AND 
								LEFT.state_origin = RIGHT.state_origin,
								xformNonSubject(left, right));
	
	// Calculate penalty
	ds_recs_final_with_penalty := JOIN(
		clean_in, ds_recs_final,
		LEFT.acctno = right.acctno,
		TRANSFORM(WatercraftV2_Services.Layouts.batch_report,
			SELF.penalt := if(isFCRA, 0, WatercraftV2_services.Functions.penalize_batch_records(LEFT, RIGHT)),
			SELF := RIGHT,
			SELF := LEFT)); // save errors, if any provided in the input
	
	ds_rsrt := ds_recs_final_with_penalty(penalt <= configData.PenaltThreshold);

	// OUTPUT(acctNos_final, NAMED('acctNos_final'));		
	// OUTPUT(in_watercraftkeys, NAMED('in_watercraftkeys'));
	// OUTPUT(ds_recs, NAMED('ds_recs'));
	// OUTPUT(ds_recs_final, NAMED('ds_recs_final'));
	// OUTPUT(clean_in, NAMED('clean_in'));
	// OUTPUT(ds_rsrt, NAMED('ds_rsrt'));

	RETURN ds_rsrt;
	
END;