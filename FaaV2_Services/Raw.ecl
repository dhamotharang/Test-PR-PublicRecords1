import doxie, doxie_cbrs, faa, suppress, fcra, census_data, FFD;

export Raw := module
		export faav2_services.Layouts.aircraftNumberPlus byDIDs(dataset(doxie.layout_references) in_dids,boolean isFCRA=false) := function		
			deduped := dedup(sort(in_dids,did),did);
			joinup := join(deduped,FAA.Key_Aircraft_did(isFCRA),keyed(left.did= right.did),transform(Layouts.aircraftNumberPlus,
				self.aircraft_id :=  right.aircraft_id, 
				self.n_number := right.n_number,
				self.did := right.did,
				self.bdid := 0,
				self := []), limit(faav2_services.constants.max_recs_on_did_join, skip));
			return joinup;
		end;
				
		export Layouts.aircraftNumberPlus byBDIDs(dataset(doxie_cbrs.layout_references) in_bdids) := function
			deduped := dedup(sort(in_bdids,bdid),bdid);
			joinup := join(deduped,FAA.Key_Aircraft_Reg_BDID,keyed(left.bdid=  right.bd),transform(Layouts.aircraftNumberPlus,
				self.n_number := right.n_number,
				self.aircraft_id :=  right.aircraft_id,
			  self.did := 0,
				self.bdid := right.bd,
				self := []),limit(faav2_services.constants.max_recs_on_bdid_join, skip));
				
			return joinup;
		end;		
		export Layouts.aircraftNumberPlus byAircraftNumber(dataset(Layouts.aircraftNumberPlus) in_aircraftNumber) := function
			deduped := dedup(sort(in_aircraftNumber,n_number),n_number);
			joinup := join(deduped,faa.Key_Aircraft_Reg_NNum (),
											keyed(left.n_number =  right.n_number),
												 transform(Layouts.aircraftNumberPlus,														 
															 self.aircraft_id := right.aircraft_id,
															 self.n_number := right.n_number,
															 self.bdid := 0,
															 self.did := 0,
															 self := []), limit(faav2_services.constants.max_recs_on_aircraftNumber_join, skip));
													
			deduped2 := dedup(sort(joinup, aircraft_id), aircraft_id);
			return deduped2;
		end;
		
		export FaaV2_Services.Layouts.Rawrec getByAircraftId(
		  dataset(FaaV2_Services.Layouts.search_id) in_recs, 
			string32 applicationType, boolean isFCRA = false, 
			dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile, 
			dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0 ) := function
			
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
			boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

			aircraft_correct_rec_id := SET (flagfile (file_id = FCRA.FILE_ID.AIRCRAFT), record_id);
			aircraft_correct_ffid    := SET (flagfile (file_id = FCRA.FILE_ID.AIRCRAFT), flag_file_id);
			
			// join to payload key
			// added condition to limit our records coming back.
			recs_raw := join(in_recs,faa.Key_Aircraft_id (isFCRA),
		             keyed(left.aircraft_id =  right.aircraft_id) 
												and ~(isFCRA and (string)right.persistent_record_id in aircraft_correct_rec_id),
											transform(FaaV2_Services.Layouts.Rawrec,	
																self.isDeepDive := left.isDeepDive,
																self:=right), 
																limit(1, skip));  // why not keep(1),limit(0) ? Why are we skipping records?
																
  		Suppress.MAC_Suppress(recs_raw,recs_1,applicationType,Suppress.Constants.LinkTypes.DID,did_out);
																
			recs_over := project( choosen(FCRA.key_override_faa.aircraft (keyed(flag_file_id in aircraft_correct_ffid) and isFCRA),FCRA.compliance.MAX_OVERRIDE_LIMIT),
											transform(FaaV2_Services.Layouts.Rawrec,self:=left,self:=[]));
			recs_over1 :=	recs_1 + recs_over ;
			
			//---------------------------------------FCRA FFD----------------------------------------------------------------	
	
			FaaV2_Services.Layouts.Rawrec xformAircraft ( FaaV2_Services.Layouts.Rawrec L , FFD.Layouts.PersonContextBatchSlim R ) := transform,
			skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs))) 
			self.StatementIDs := r.StatementIDs;
			self.isDisputed :=	r.isDisputed;
			self := L;
			end;
																	
			faa_raw_ds  := join(recs_over1, slim_pc_recs, 
												 (string)left.persistent_record_id = right.RecID1 and
												 (((unsigned)left.did_out  = (unsigned) right.lexid) or
														(right.acctno = FFD.Constants.SingleSearchAcctno)) 
												  and right.DataGroup = FFD.Constants.DataGroups.AIRCRAFT,
  											 xformAircraft(left, right), 
												 left outer,
												 keep(1),
												 limit(0));													
	
			recs := if (isFCRA, faa_raw_ds, recs_1);	
			
			//-------------------------------------------------------------------------------------------------------
			recs_countyname := join(recs,Census_Data.Key_Fips2County, 
				(left.state = right.state_code) and (left.county = right.county_fips),
				transform(FaaV2_Services.Layouts.Rawrec,
					self.county_name := right.county_name,
					self := left, 
					self:=[]),
				keep(1),limit(0),left outer); 	
						
			return recs_countyname;
		end;

		export FaaV2_Services.Layouts.aircraft_full addDetail(
				dataset(FaaV2_Services.Layouts.aircraft_full) in_air, 
				boolean isFCRA = false,
				dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
				dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
				integer8 inFFDOptionsMask = 0) := function
		
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
			boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

		 	info_correct_rec_id := SET (flagfile (file_id = FCRA.FILE_ID.AIRCRAFT_DETAILS), record_id);
  		info_correct_ffid    := SET (flagfile (file_id = FCRA.FILE_ID.AIRCRAFT_DETAILS), flag_file_id);
			aircraft_info_added_1 := join(in_air(~(isFCRA AND aircraft.mfr_mdl_code IN info_correct_rec_id)), faa.key_aircraft_info (isFCRA), 
											(left.aircraft.mfr_mdl_code = right.code ),
											transform(FaaV2_Services.Layouts.aircraft_full,self.detail := right, self := left),
											// transform(faa.layout_aircraft_info,self.aircraft_mfr_model_code := left.mfr_mdl_code,self:=RIGHT),
											LEFT OUTER, KEEP(1), LIMIT(0));
											
			info_overrecs := choosen(FCRA.key_override_faa.aircraft_details(keyed(flag_file_id in info_correct_ffid)), FCRA.compliance.MAX_OVERRIDE_LIMIT);
															
			aircraft_infoover_added := join(in_air(isFCRA AND aircraft.mfr_mdl_code IN info_correct_rec_id),info_overrecs, 
											(left.aircraft.mfr_mdl_code = right.aircraft_mfr_model_code),
											transform(FaaV2_Services.Layouts.aircraft_full,self.detail := right, self := left),
											// transform(faa.layout_aircraft_info,self:=RIGHT),
											KEEP(1), LIMIT(0));
											
			aircraft_infoover := aircraft_info_added_1 + aircraft_infoover_added ;						
		
			//---------------------------------------FCRA FFD----------------------------------------------------------------	
			FaaV2_Services.Layouts.aircraft_full xformAircraftDetail ( FaaV2_Services.Layouts.aircraft_full L , FFD.Layouts.PersonContextBatchSlim R ) := transform
			self.detail.StatementIDs := if(ShowConsumerStatements,r.StatementIDs,FFD.Constants.BlankStatements);
			self.detail.isDisputed := ShowDisputedRecords and r.isDisputed;
			self.detail := if((ShowDisputedRecords or ~r.isDisputed) and (ShowConsumerStatements or ~exists(r.StatementIDs)),L.detail);
			self := L;
			end;
											
			aircraft_infoover_ds  := join(aircraft_infoover, slim_pc_recs, 
												 (string)left.aircraft.mfr_mdl_code = right.RecID1 and
												 (((unsigned)left.aircraft.did_out  = (unsigned) right.lexid) OR 
														(right.acctno = FFD.Constants.SingleSearchAcctno) 
												 )and 
												 right.DataGroup = FFD.Constants.DataGroups.AIRCRAFT_DETAILS,
  											 xformAircraftDetail(left, right), 
												 left outer,
												 keep(1),
												 limit(0));	
												 
			aircraft_info_added := if (isFCRA, aircraft_infoover_ds, aircraft_info_added_1);
	
			//-------------------------------------------------------------------------------------------------------									
			return aircraft_info_added;
		end;

		export FaaV2_Services.Layouts.aircraft_full addEngine(
			dataset(FaaV2_Services.Layouts.aircraft_full) in_air, 
			boolean isFCRA = false,
			dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile, 
			dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0) := function
		
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
			boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

   		engine_correct_rec_id := SET (flagfile (file_id = FCRA.FILE_ID.AIRCRAFT_ENGINE), record_id);
		  engine_correct_ffid    := SET (flagfile (file_id = FCRA.FILE_ID.AIRCRAFT_ENGINE), flag_file_id);

			aircraft_engine_info_added_1 := join(in_air( ~(isFCRA AND aircraft.eng_mfr_mdl IN engine_correct_rec_id)), faa.key_engine_info (isFCRA),
											(left.aircraft.eng_mfr_mdl = right.code),							
									transform(FaaV2_Services.Layouts.aircraft_full,self.engine:=RIGHT,self:=left),
									LEFT OUTER, KEEP(1), LIMIT(0));

			engine_overrecs := choosen(FCRA.key_override_faa.aircraft_engine(keyed(flag_file_id in engine_correct_ffid)),FCRA.compliance.MAX_OVERRIDE_LIMIT);	
			
			aircraft_engineover_info_added := join(in_air(isFCRA AND aircraft.eng_mfr_mdl IN engine_correct_rec_id), engine_overrecs,
											(left.aircraft.eng_mfr_mdl = right.engine_mfr_model_code),							
									transform(FaaV2_Services.Layouts.aircraft_full,self.engine:=RIGHT,self:=left),
									KEEP(1), LIMIT(0));
			aircraft_engineover_info := aircraft_engine_info_added_1 + aircraft_engineover_info_added ;
			
			//---------------------------------------FCRA FFD----------------------------------------------------------------	
			FaaV2_Services.Layouts.aircraft_full xformAircraft ( FaaV2_Services.Layouts.aircraft_full L , FFD.Layouts.PersonContextBatchSlim R ) := transform
			    self.engine.StatementIDs := if(ShowConsumerStatements,r.StatementIDs,FFD.Constants.BlankStatements),
					self.engine.isDisputed := ShowDisputedRecords and r.isDisputed;
					self.engine := if((ShowDisputedRecords or ~r.isDisputed) and (ShowConsumerStatements or ~exists(r.StatementIDs)),L.engine);
					self := L;
			end;
	
			aircraft_engine_info_added_ds  := 
				join(aircraft_engineover_info, slim_pc_recs, 
				 (string)left.aircraft.eng_mfr_mdl = right.RecID1 and
				 (((unsigned)left.aircraft.did_out  = (unsigned) right.lexid) OR 
						(right.acctno = FFD.Constants.SingleSearchAcctno) 
				 )and 
				 right.DataGroup = FFD.Constants.DataGroups.AIRCRAFT_ENGINE,
				 xformAircraft(left, right), 
				 left outer, keep(1), limit(0));													
	
			aircraft_engine_info_added := if (isFCRA, aircraft_engine_info_added_ds, aircraft_engine_info_added_1);
			
			//-------------------------------------------------------------------------------------------------------	
			return aircraft_engine_info_added;
		end;
		
		export FaaV2_Services.Layouts.aircraft_full getFullAircraft(
			dataset(FaaV2_Services.Layouts.search_id) in_ids, 
			string32 applicationType,
			boolean isFCRA = false, 
			dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile, 
			boolean bestAircraft = false, 
			dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0) := function

			aircraft := getByAircraftId(in_ids,applicationType,isFCRA,flagfile, slim_pc_recs, inFFDOptionsMask);
  		raw_srt := sort (aircraft, did_out, bdid_out, n_number, -last_action_date, -date_last_seen);
			reg_raw := dedup (raw_srt, did_out, bdid_out, n_number);
			aircraft_2 := if (bestAircraft, reg_raw, aircraft);
			aircraft_3 := project(aircraft_2, transform(FaaV2_Services.Layouts.aircraft_full, self.aircraft := left,self.aircraft_id := left.aircraft_id,
															self.county_name := left.county_name,self.detail:=[], self.engine:=[],
															self.aircraft.lf:='',
															self := left));//business_ids
			aircraft_details := addDetail(aircraft_3, isFcra, flagfile, slim_pc_recs, inFFDOptionsMask);
			air_plus_engine := addEngine(aircraft_details, isFcra, flagfile, slim_pc_recs, inFFDOptionsMask);

			return air_plus_engine;			
		end;	
		
   end;
