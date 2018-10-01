IMPORT doxie, FCRA, FFD, AVM_v2, ConsumerDisclosure, UT, 
risk_indicators; // for macro to work

layout_avm_base_raw := RECORD  // recordof(AVM_V2.Key_AVM_Address_FCRA) - has history section missing in FCRA.Layout_Override_AVM
	avm_v2.layouts.layout_base_with_history;
END;

layout_avm_valuation := RECORD
	UNSIGNED AutomatedValuationCurrent := 0;	
	UNSIGNED AutomatedValuation1 := 0;
	UNSIGNED AutomatedValuation2 := 0;
	UNSIGNED AutomatedValuation3 := 0;
	UNSIGNED AutomatedValuation4 := 0;
	UNSIGNED AutomatedValuation5 := 0;
END;

layout_avm_base_rawrec := RECORD(layout_avm_base_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
    layout_avm_valuation SnapshotData;
END;
	
layout_avm_medians_raw := RECORD
	AVM_V2.layouts.layout_medians_with_history;   // recordof(AVM_V2.Key_AVM_Medians_FCRA)
END;

layout_avm_medians_disclosure := RECORD  
  AVM_V2.layouts.Layout_Override_AVM_Medians - [flag_file_id];  // recordof(FCRA.Key_Override_AVM.avm_medians)
END;

layout_avm_medians_working := RECORD
	UNSIGNED6 subject_did;
	UNSIGNED1 seq_no;
	STRING12 block_geolink;
	STRING12 geolink;
	UNSIGNED whichaddr;
	INTEGER8 median_valuation;
	layout_avm_medians_raw raw_payload;
END;
	
layout_avm_medians_disclosure_internal := RECORD(layout_avm_medians_disclosure)
	ConsumerDisclosure.Layouts.InternalMetadata;
	UNSIGNED seq_no;
	STRING12 block_geolink;
	STRING12 county_geolink;
	STRING12 tract_geolink;
  STRING3 county;
	STRING7 geo_blk;
END;
	
layout_avm_medians_disclosure_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
	layout_avm_medians_disclosure;
END;
	
layout_avm_medians_disclosure_ext := RECORD(layout_avm_medians_disclosure_out)
	UNSIGNED seq_no;
	STRING12 block_geolink;
END;

layout_avm_medians_raw_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
	layout_avm_medians_raw;
END;

STRING8 history_date := '99999901';	// for use with risk_indicators macros - it is not meant to be run in historical mode
	
EXPORT RawAVM := MODULE

	EXPORT layout_avm_address_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		layout_avm_base_raw;
    layout_avm_valuation SnapshotData;
	END;

	EXPORT layout_avm_medians_out := RECORD
		UNSIGNED seq_no;  // keeping it for internal use, won't be part of final output
		STRING12 block_geolink;
		DATASET(layout_avm_medians_disclosure_out) disclosure_medians;
		DATASET(layout_avm_medians_raw_out) raw_medians;
	END;

	EXPORT GetAVMMediansData(DATASET(ConsumerDisclosure.Layouts.address_rec) in_addresses,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,														 
							  ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
		pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.AVM_MEDIANS);
		all_flags := flag_file(file_id = FCRA.FILE_ID.AVM_MEDIANS);
		
		addresses_with_seq := PROJECT(in_addresses(geo_blk<>''), 
																	TRANSFORM(layout_avm_medians_disclosure_internal, 
																						SELF.seq_no := COUNTER, 
																						SELF.block_geolink := TRIM(ut.st2FipsCode(LEFT.st)) + TRIM(LEFT.county) + TRIM(LEFT.geo_blk[1..7]),
																						SELF.county_geolink := TRIM(ut.st2FipsCode(LEFT.st)) + TRIM(LEFT.county),
																						SELF.tract_geolink := TRIM(ut.st2FipsCode(LEFT.st)) + TRIM(LEFT.county) + TRIM(LEFT.geo_blk[1..6]),
																						SELF:=LEFT, 
																						SELF:=[]));

		addresses_ddp := DEDUP(SORT(addresses_with_seq,block_geolink),block_geolink);

		layout_avm_medians_working create_geolinks(layout_avm_medians_disclosure_internal le, UNSIGNED c) := TRANSFORM
			countyfips := le.county;									
			statefips := ut.st2FipsCode(le.st);
			geoblk := 
			CHOOSE(c,'',  							// fips level only, first addr
							le.geo_blk[1..6],  	// block level, first addr
							le.geo_blk[1..7]  	// tract level, first addr
							);
			
			SELF.whichaddr := c;
			SELF.geolink := TRIM(statefips) + TRIM(countyfips) + TRIM(geoblk);
			SELF.subject_did := le.subject_did;
			SELF := le;
			SELF := [];
		END;
		with_geolinks := NORMALIZE(addresses_ddp, 3, create_geolinks(LEFT,COUNTER));

		layout_avm_medians_working getMedians(layout_avm_medians_working le, avm_v2.Key_AVM_Medians_fcra rt) := 
		TRANSFORM
			
			AVM_V2.MOD_get_AVM_from_History.MAC_get_Medians(rt, history_date, median_record);

			SELF.median_valuation := median_record.median_valuation;
			SELF.raw_payload := rt;
			SELF := le;
		END;
		
		payload_with_avm_medians := JOIN(with_geolinks, AVM_V2.Key_AVM_Medians_FCRA,
															LEFT.geolink = RIGHT.fips_geo_12,
															getMedians(LEFT,RIGHT),
															LIMIT(0), KEEP(1));


		flag_recs := 
			JOIN(all_flags, FCRA.Key_Override_AVM.avm_medians, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(layout_avm_medians_disclosure_internal,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.geolink;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		override_recs := flag_recs(compliance_flags.isOverride);	
		suppressed_recs := flag_recs(compliance_flags.isSuppressed);		

		override_ids := SET(override_recs, combined_record_id);	
		suppressed_ids := SET(suppressed_recs, combined_record_id);

		// check overrides against input addresses
		corrected_AVM_Medians := JOIN(override_recs,addresses_with_seq, 
																	LEFT.geolink = RIGHT.block_geolink,
																	TRANSFORM(layout_avm_medians_disclosure_internal, 
																						SELF.block_geolink := RIGHT.block_geolink, 
																						SELF.county_geolink := RIGHT.county_geolink, 
																						SELF.tract_geolink := RIGHT.tract_geolink, 
																						SELF:= LEFT),
																	LIMIT(0), KEEP(1));


		layout_avm_medians_disclosure_internal xfaddmedians (layout_avm_medians_disclosure_internal le, DATASET(layout_avm_medians_working) rt) := 
		TRANSFORM

			SELF.median_county_value := IF(le.county_geolink = rt(whichaddr=1)[1].geolink, rt(whichaddr=1)[1].median_valuation, 0);
			SELF.median_tract_value := IF(le.tract_geolink = rt(whichaddr=2)[1].geolink, rt(whichaddr=2)[1].median_valuation, 0);
			SELF.median_block_value := IF(le.block_geolink = rt(whichaddr=3)[1].geolink, rt(whichaddr=3)[1].median_valuation, 0);

			SELF.compliance_flags.IsOverwritten := (le.block_geolink IN override_ids OR le.tract_geolink IN override_ids OR le.county_geolink IN override_ids); 
			SELF.compliance_flags.IsSuppressed := (le.block_geolink IN suppressed_ids OR le.tract_geolink IN suppressed_ids OR le.county_geolink IN suppressed_ids); 
			SELF.record_ids.RecId1 := (STRING) le.block_geolink;
			SELF.geolink := le.block_geolink;
			SELF := le;
			SELF := [];
		END;
		
		// add calculated medians and mark suppressed/overwritten recs
		disclosure_main_recs := DENORMALIZE(addresses_with_seq, payload_with_avm_medians,  
																					LEFT.block_geolink = RIGHT.block_geolink,
																					GROUP, 
																					xfaddmedians(LEFT, ROWS(RIGHT)));
		
	

		disclosure_recs_all := disclosure_main_recs + corrected_AVM_Medians;
		
		disclosure_recs_filt := disclosure_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			// below filter may exclude overrides,  should we use this filter? Should it be considered as suppression indicator??
			median_county_value<>0 OR median_tract_value<>0 OR median_block_value<>0   		
			);
										
		layout_avm_medians_disclosure_internal xformStatements(layout_avm_medians_disclosure_internal l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		disclosure_recs_final_ds := JOIN(disclosure_recs_filt, pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.record_ids.RecId1 = RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		disclosure_recs_out := PROJECT(disclosure_recs_final_ds, TRANSFORM(layout_avm_medians_disclosure_ext,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.AVM_MEDIANS);
												SELF := LEFT;			
												));			
												

		// Now combining datasets for final output
		layout_avm_medians_out xfRollDisclosure(layout_avm_medians_disclosure_ext le, 
												DATASET(layout_avm_medians_disclosure_ext) d_rows) := 
		TRANSFORM
			SELF.seq_no := le.seq_no; 
			SELF.block_geolink := le.block_geolink;
			SELF.disclosure_medians := SORT(d_rows, seq_no);
			SELF.raw_medians := [];
		END;
			
		disclosure_rolled := ROLLUP(GROUP(SORT(disclosure_recs_out, block_geolink), block_geolink), 
																	GROUP, xfRollDisclosure(LEFT, ROWS(LEFT)));	

		layout_avm_medians_out xfAddRawPayload(layout_avm_medians_out le, DATASET(layout_avm_medians_working) rt) := 
		TRANSFORM
			SELF.raw_medians := PROJECT(rt, TRANSFORM(layout_avm_medians_raw_out, 
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																								ROW({FALSE,FALSE,FALSE,FALSE},ConsumerDisclosure.Layouts.ComplianceFlags),
																								ROW({LEFT.raw_payload.fips_geo_12,'','',''},ConsumerDisclosure.Layouts.RecordIds),
																								DATASET([], FFD.Layouts.StatementIdRec),
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.AVM_MEDIANS);
												SELF := LEFT.raw_payload));
			SELF := le;
		END;
		// adding raw payload data	
		recs_out := DENORMALIZE(disclosure_rolled, payload_with_avm_medians, 
														LEFT.block_geolink = RIGHT.block_geolink,
														GROUP, 
														xfAddRawPayload(LEFT, ROWS(RIGHT)));		


		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(payload_with_avm_medians, NAMED('avm_medians_with_payload_recs')));
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(suppressed_recs, NAMED('avm_medians_suppressed_recs')));
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(override_recs, NAMED('avm_medians_override_recs')));
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(disclosure_main_recs, NAMED('avm_medians_main_recs')));
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(disclosure_recs_out, NAMED('avm_medians_disclosure_recs')));
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(recs_out, NAMED('avm_medians_combined_recs')));
		
		RETURN SORT(recs_out, block_geolink, RECORD);
	END;


	
	EXPORT GetAVMAddressData(DATASET(ConsumerDisclosure.Layouts.address_rec) in_addresses,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,														 
							  ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
		pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.AVM);
		all_flags := flag_file(file_id = FCRA.FILE_ID.AVM);
		
		flag_recs := 
			JOIN(all_flags, FCRA.key_override_avm_ffid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(layout_avm_base_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.prim_range;
					SELF.record_ids.RecId2 := (STRING) RIGHT.prim_name;
					SELF.record_ids.RecId3 := (STRING) RIGHT.sec_range;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		override_recs_prelim := flag_recs(compliance_flags.isOverride);	
		suppressed_recs := flag_recs(compliance_flags.isSuppressed);		

		// filtering to keep only overrides for input addreses
		override_recs := JOIN(override_recs_prelim, in_addresses, 
													LEFT.prim_name = RIGHT.prim_name AND
													LEFT.st = RIGHT.st AND
													LEFT.zip = RIGHT.zip AND
													LEFT.prim_range = RIGHT.prim_range AND
													LEFT.sec_range = RIGHT.sec_range,
													TRANSFORM(LEFT), 
													KEEP(1), LIMIT(0));
													
		override_ids := SET(override_recs, combined_record_id);	
		suppressed_ids := SET(suppressed_recs, combined_record_id);

		main_recs := JOIN(in_addresses, AVM_V2.Key_AVM_Address_FCRA,
												KEYED(LEFT.prim_name = RIGHT.prim_name AND
															LEFT.st = RIGHT.st AND
															LEFT.zip = RIGHT.zip AND
															LEFT.prim_range = RIGHT.prim_range AND
															LEFT.sec_range = RIGHT.sec_range),
													TRANSFORM(layout_avm_base_rawrec,
																		rec_id := TRIM(RIGHT.prim_range) + TRIM(RIGHT.prim_name) + TRIM(RIGHT.sec_range);
                                    AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(RIGHT, history_date, avm_with_valuations);	 
                                    
																		SELF.compliance_flags.IsOverwritten := (rec_id IN override_ids), 
																		SELF.compliance_flags.IsSuppressed := (rec_id IN suppressed_ids), 
																		SELF.subject_did := LEFT.subject_did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.prim_range,
																		SELF.record_ids.RecId2 := (STRING) RIGHT.prim_name,
																		SELF.record_ids.RecId3 := (STRING) RIGHT.sec_range,
                                    SELF.SnapshotData.AutomatedValuationCurrent := avm_with_valuations.automated_valuation;
                                    SELF.SnapshotData.AutomatedValuation1 := avm_with_valuations.automated_valuation2;
                                    SELF.SnapshotData.AutomatedValuation2 := avm_with_valuations.automated_valuation3;
                                    SELF.SnapshotData.AutomatedValuation3 := avm_with_valuations.automated_valuation4;
                                    SELF.SnapshotData.AutomatedValuation4 := avm_with_valuations.automated_valuation5;
                                    SELF.SnapshotData.AutomatedValuation5 := avm_with_valuations.automated_valuation6;

																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxAVMPerAddress));
																	

		recs_all := main_recs + override_recs;
		
		recs_filt:= recs_all(
			in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
			automated_valuation<>0   // should we use this filter ?
			);
										
		layout_avm_base_rawrec xformStatements(layout_avm_base_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		recs_final_ds := JOIN(recs_filt, pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.record_ids.RecId1 = RIGHT.RecID1 AND
													LEFT.record_ids.RecId2 = RIGHT.RecID2 AND
													LEFT.record_ids.RecId3 = RIGHT.RecID3,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_avm_address_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.AVM);
												SELF := LEFT;			
												));			
												
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(suppressed_recs, NAMED('avm_address_suppressed_recs')));
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(override_recs, NAMED('avm_address_override_recs')));
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(main_recs, NAMED('avm_address_main_recs')));
		IF(ConsumerDisclosure.Debug AND in_mod.IncludeAVM,OUTPUT(recs_out, NAMED('avm_address_recs')));
		
		RETURN SORT(recs_out, -recording_date, -assessed_value_year, zip, prim_range, prim_name, predir, postdir, sec_range);
	END;
	

END;
