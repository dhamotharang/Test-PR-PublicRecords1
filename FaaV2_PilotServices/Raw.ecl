import doxie, FaaV2_PilotServices, faa, iesp, suppress, ut,fcra, FFD;

rec_slim := faav2_PilotServices.Layouts.pilotUniqueIDPlus;
rec_pilot := faav2_pilotServices.layouts.pilotRawRec;
rec_cert := FaaV2_PilotServices.Layouts.PilotReportRawrec;

export Raw := module
		// called by: autokeys_ids, getbyID
		export rec_slim byDIDs (dataset(doxie.layout_references) in_dids, boolean isFCRA = false) := function		
			 deduped := dedup(sort(in_dids,did),did);
			 joinup := join(deduped,faa.Key_airmen_did(isFCRA),keyed( left.did  = right.did), 
			   transform(rec_slim, self := right),
				  limit(ut.limits.AIRMAN_PER_DID, skip));
			 return joinup;
		end;

  export rec_slim byUniqueID (dataset (rec_slim) in_uid, boolean isFCRA = false) := function		
    deduped := dedup (sort(in_uid,unique_id, record), unique_id, record);
    joinup := join (deduped, faa.key_airmen_id (isFCRA),
                    keyed (left.unique_id  = right.unique_id) and
                    // to be backward compatible I need to allow blank letter code
                    ((left.letter_code ='') or (left.letter_code = right.letter_code)),
                    transform (rec_slim,
                               self.airmen_id := right.airmen_id,
															 self.did := (unsigned)right.did_out,
                               self := left),
                    limit(ut.limits.REGISTRATIONS_PER_AIRMAN,skip));
    return joinup;
  end;

  //main pilot's data access (we need "airmen_id" only from input)
	export rec_pilot joinByAirmenId(
		dataset(rec_slim) in_ds, 
		string32 applicationType,
		boolean isFCRA = false, 
		dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile, 
		dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim, 
		integer8 inFFDOptionsMask = 0) := function
	
		 boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
		 boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

		 correct_pilot_id := SET (flagfile (file_id = FCRA.FILE_ID.PILOT_REGISTRATION), record_id);
     correct_pilot_ffid := SET (flagfile (file_id = FCRA.FILE_ID.PILOT_REGISTRATION), flag_file_id);

     deduped := dedup (sort(in_ds, airmen_id), airmen_id);
		 retVal := join (deduped, faa.key_airmen_rid (isFCRA),
                      keyed(left.airmen_id = right.airmen_id) and
											(~IsFCRA or ((string)Right.persistent_record_id not in correct_pilot_id)),
                      transform(rec_pilot, self := right),
                      keep (1), limit(0));
										
											//Add Overrides here
		Suppress.MAC_Suppress(retVal,retVal_pulled,applicationType,Suppress.Constants.LinkTypes.DID,did_out);
			
		pilot_override := CHOOSEN (fcra.key_override_faa.airmen_reg (keyed (flag_file_id IN correct_pilot_ffid)),
																 FCRA.compliance.MAX_OVERRIDE_LIMIT);
			// put overrides into same layout, combine main data and overrides;
		pilot_override_st := project (pilot_override, transform (rec_pilot, self.airmen_id:=0,Self := Left));
		pilot_fcra := retVal_pulled + pilot_override_st;

    //---------------------------------------FCRA FFD----------------------------------------------------------------	
	
    rec_pilot xformPILOT ( rec_pilot L , FFD.Layouts.PersonContextBatchSlim R ) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs))) 
			self.StatementIDs := r.StatementIDs;
			self.isDisputed :=	r.isDisputed;
			self := L;
	  end;
																
	  pilot_ds  := join(pilot_fcra, slim_pc_recs, 
												 (string)left.persistent_record_id = right.RecID1 and
												 (((unsigned)left.did_out  = (unsigned) right.lexid) OR 
														(right.acctno = FFD.Constants.SingleSearchAcctno)
													//Left this condition for future use as there is no batch component using it.
												 )and 
												 right.DataGroup = FFD.Constants.DataGroups.PILOT_REGISTRATION,
  											 xformPILOT(left, right), 
												 left outer,
												 keep(1),
												 limit(0));													
	
		pilot_raw := if (IsFCRA, pilot_ds, retVal_pulled);
	
  return pilot_raw;
  end;
//-------------------------------------------------------------------------------------------------------				
  //certificate data access (by unique_id!)
	export rec_cert GetRawCert (
		dataset(rec_slim) in_airmenUniqueId,
		boolean isFCRA = false,	
		dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile, 
		unsigned3 dateval = 0, 
		dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim, 
		integer8 inFFDOptionsMask = 0) := function		
		
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
			boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

			 correct_cert_id := SET (flagfile (file_id = FCRA.FILE_ID.PILOT_CERTIFICATE), record_id);
			 correct_cert_ffid := SET (flagfile (file_id = FCRA.FILE_ID.PILOT_CERTIFICATE), flag_file_id);
		 
			 key_certs := faa.key_airmen_certs (IsFCRA);
			 deduped := dedup(sort(in_airmenUniqueId,unique_id, record),unique_id, record);
			 
			 raw := join (deduped, key_certs,
                keyed(left.unique_id=right.uid)
                and (dateVal = 0 OR (unsigned3)(right.date_first_seen[1..6]) <= dateVal) and
                // suppress or override records on FCRA side
                (~IsFCRA or ((string) Right.persistent_record_id not in correct_cert_id)),
                transform (rec_cert, Self := Right),
                LIMIT (ut.limits.AIRMAN_CERTIFICATES_MAX, SKIP));
								
			 deduped2 := dedup(sort(raw, unique_id, record), unique_id, record);
   
			 // overrides
			 cert_override := CHOOSEN (fcra.key_override_faa.airmen_cert (keyed (flag_file_id IN correct_cert_ffid)),
                             FCRA.compliance.MAX_OVERRIDE_LIMIT);
   
       // put overrides into same layout, combine main data and overrides;
			 cert_override_st := project (cert_override, transform (rec_cert,Self.uid := Left.unique_id, Self := Left));
       cert_fcra := deduped2 + cert_override_st;

			//---------------------------------------FCRA FFD----------------------------------------------------------------	
			
			rec_cert xformCERT ( rec_cert L , FFD.Layouts.PersonContextBatchSlim R ) := transform,
			skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs))) 
			self.StatementIDs := r.StatementIDs;
			self.isDisputed :=	r.isDisputed;
			self := L;
			end;
																
			cert_ds  := join(cert_fcra, slim_pc_recs, 
												 (string)left.persistent_record_id = right.RecID1 and
												 ((right.acctno = FFD.Constants.SingleSearchAcctno) 
												 )AND 
												 right.DataGroup = FFD.Constants.DataGroups.PILOT_CERTIFICATE,
  											 xformCERT(left, right), 
												 left outer,
												 keep(1),
												 limit(0));													
	 	 cert_raw := if (IsFCRA, cert_ds, deduped2);
		 
		 return cert_raw;
	end;
//-------------------------------------------------------------------------------------------------------	

    // --------------------------------------------------------------------------------------------
    // WARNING: these functions are not id- or did-safe: 
    // will work appropriately only for one entity (single DID or set IDs belonging to same person)
    // --------------------------------------------------------------------------------------------

    // warning: multiple records can be returned here, whereas only ACTIVE is needed in report
    //function used by asset report/bps report
  export iesp.faapilot_Fcra.t_FcraPilotReportRecord getReportByID (
		dataset(rec_slim) in_ids, 
		string32 applicationType, 
		boolean isFCRA = false, 
		dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile, 
		dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim, 
		integer8 inFFDOptionsMask = 0 ) := function
	 
			Suppress.MAC_Suppress(in_ids,in_ids_pulled,applicationType,Suppress.Constants.LinkTypes.DID,did);
      pilot_recs := joinByAirmenId (in_ids_pulled, applicationtype,isFCRA,flagfile, slim_pc_recs, inFFDOptionsMask);
      cert_recs := GetRawCert (in_ids_pulled,isFCRA,flagfile, ,slim_pc_recs, inFFDOptionsMask);		
			
			 
      pilot_final_record := faav2_pilotservices.functions.setReportStructure(cert_recs, pilot_recs);
  		// Sort, returning active records first, if any.
      pilot_final_recs_sorted := sort(pilot_final_record, ~(RecordType = 'A'), -DateExpiresMedical.year,   
                                      -DateExpiresMedical.month, -DateExpiresMedical.day, record);		
																	
			return pilot_final_recs_sorted;
  end;

	export iesp.bpsreport_fcra.t_FcraBpsFAACertification getBpsReportByDID (
			dataset(doxie.layout_references) in_dids, 
			string32 applicationType, boolean isFCRA = false, 
			dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
			dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0 ) := function
			
			Suppress.MAC_Suppress(in_dids,in_dids_pulled,applicationType,Suppress.Constants.LinkTypes.DID,did);
      in_ids := byDIDs (in_dids_pulled,isFCRA);

      pilot_recs := joinByAirmenId (in_ids, applicationtype,isFCRA,flagfile,slim_pc_recs,inFFDOptionsMask);
      cert_recs := GetRawCert (in_ids,isFCRA,flagfile, ,slim_pc_recs,inFFDOptionsMask);		  
			 
      pilot_final_record := faav2_pilotservices.functions.GetBpsReportView(cert_recs, pilot_recs);
  		// Sort, returning active records first, if any.
			//TODO: verified A?
      pilot_final_recs_sorted := sort(pilot_final_record, ~(RecordType = 'A'), -DateExpiresMedical.year, 
                                      -DateExpiresMedical.month, -DateExpiresMedical.day, record);				
																			
			return pilot_final_recs_sorted;
		end;

end;
