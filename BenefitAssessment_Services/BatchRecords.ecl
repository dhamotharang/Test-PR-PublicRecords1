IMPORT ut, BatchShare, suppress, FCRA, Doxie;

EXPORT BatchRecords(IParam.batch_params configData, dataset(Layouts.Batch_In_Shared) ds_batch_with_did,
				            boolean isFCRA = true, integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing) := FUNCTION
		
		//Filter off any records that we couldn't find a did or doesn't have SSN, First Name, or Last Name 
		//NOTE: even if the dec can find a hit for the SSN only, we won't as if we can't find a did for that input record, 
		// we shouldn't search via SSN only as might not be who the person they actually sent in
		// But we'll return the did if we find one on the input
		ds_batch_in_good := ds_batch_with_did(ssn != '' AND name_first != '' AND name_last != '' AND did != 0);
		ds_batch_in_bad := ds_batch_with_did(ssn = '' OR name_first = '' OR name_last = '' OR did = 0);			
		ds_batch_in_master := project(ds_batch_in_good, TRANSFORMS.MakeIntoPlus(LEFT));
		input_dids :=  project(ds_batch_in_master,doxie.layout_references);
		ds_best := project(ds_batch_in_master, Transforms.PutInDoxieInput(LEFT)); 
		ds_flagfile := if(isFCRA, FCRA.GetFlagFile (ds_best));
		
		//get dec hits and append on input
		ds_dec_hits := Raw.GetDecHits(ds_batch_in_master, isFCRA, ds_flagfile);

		ds_crim_hits := Raw.GetCrimHits(ds_dec_hits,  isFCRA, configData);															
		ds_sofr_hits := Raw.GetSofrHits(ds_crim_hits, isFCRA, configData);																											 
		ds_dec_crim_so_recs := if(configData.include_sex_offenders, ds_sofr_hits, ds_crim_hits);
		
//For Phase 2 - include_assets_and_wealth
		ds_phase_1   := PROJECT(ds_dec_crim_so_recs, TRANSFORM(Layouts.temp_cumulative_rec, SELF := LEFT, SELF := []));
		ds_just_dids := PROJECT(ds_phase_1(did >0 AND DeceasedMatchCode = '' AND Incarcerated_Flag != '1'),
											       TRANSFORM(Layouts.rec_inputWithSearchID, SELF.search_did := LEFT.did,SELF := LEFT));
		ds_searched_props     := Raw.GetFids(ds_just_dids, isFCRA, configData, nonSS);
		ds_current_properties := Raw.GetCurrentPropHits(ds_just_dids, ds_searched_props, ds_phase_1, isFCRA, configData);																								
		ds_prior_properties   := Raw.GetPriorPropHits(ds_just_dids, ds_searched_props, ds_current_properties, isFCRA, configData);

		ds_with_prof_lics := Raw.GetProfLics(input_dids, ds_prior_properties, ds_flagfile);
		ds_with_paw       := Raw.GetPaw(input_dids, ds_with_prof_lics, ds_flagfile);
		ds_with_wc        := Raw.GetWc(input_dids, ds_with_paw, ds_flagfile);
		ds_with_ac        := Raw.GetAc(input_dids, ds_with_wc, ds_flagfile);

		ds_phase_2 := if(configData.include_assets_and_wealth, ds_with_ac, ds_phase_1);
		
//For Phase 3 - include_criminal_derogatory
		ds_crimderog_hits := Raw.GetCrimDerogHits(ds_phase_2, isFCRA, configData);	
		ds_with_bk        := Raw.GetBankrupties(input_dids, ds_crimderog_hits, ds_flagfile);
		
		// The liens & judgments section is being removed from the response for project JULI.
		// Just commenting it out in case we need to add it back later.
		// ds_with_liens     := Raw.GetLiens(input_dids, ds_with_bk, ds_flagfile);
																		
		// ds_phase_3 := PROJECT(if(configData.include_criminal_derogatory, ds_with_liens,	ds_phase_2),
		ds_phase_3 := PROJECT(if(configData.include_criminal_derogatory, ds_with_bk,	ds_phase_2),
															TRANSFORM(Layouts.layout_batch_out_plus, SELF := LEFT, SELF := []));
															
//For Phase 4 - include_family_comp
		ds_family_comp_hits := Raw.GetFamilyComp(ds_phase_3, isFCRA, configData, ds_flagfile);
		ds_with_md          := Raw.GetMarDiv(ds_family_comp_hits, configData, ds_flagfile);
		
		ds_almost_batch_out := PROJECT(if(configData.include_family_comp, ds_with_md,	ds_phase_3),
																			TRANSFORM(Layouts.layout_batch_out, SELF := LEFT));

		ds_input_wo_did := PROJECT(ds_batch_in_bad, TRANSFORMS.MakeNonHits_out(LEFT));

		ds_batch_out :=	ds_almost_batch_out +	ds_input_wo_did;
				
	RETURN ds_batch_out;
END;