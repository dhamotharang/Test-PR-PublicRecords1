IMPORT Bair_ExternalLinkKeys;
IMPORT BairRx_Common, BairRx_PSS;

EXPORT SALTSearch := MODULE
	
	SHARED GetMod(DATASET(BairRx_PSS.SALTLayout.LayoutIn) inParam) := Bair_ExternalLinkKeys.MEOW_PS(inParam);
	EXPORT GetIDs(DATASET(BairRx_PSS.SALTLayout.LayoutIn) inParam) := NORMALIZE(GetMod(inParam).Raw_Results, LEFT.Results(eid_hash<>0), TRANSFORM(RIGHT));		
	EXPORT GetRawRecs(DATASET(BairRx_PSS.SALTLayout.LayoutIn) inParam) := FUNCTION

		dRaw := GetMod(inParam).Data_;

		match_person(dRaw L, INTEGER record_score)  := record_score>0 AND (L.match_lexid>0 OR (L.match_lname>0 AND L.match_fname>=0) OR L.match_dob>0 OR L.match_possible_ssn>0 OR L.Match_DL>0); 
		match_vehicle(dRaw L, INTEGER record_score)  := record_score>0 AND (L.match_vin>0 OR L.match_plate>0 OR (L.match_st>0 AND L.match_p_city_name>0) OR L.match_zip>0);
		match_phone(dRaw L, INTEGER record_score)  := record_score>0 AND L.match_phone>=0;
		 
		dRawRecs := PROJECT(dRaw,
			TRANSFORM(BairRx_PSS.SALTLayout.LayoutOut, 
					// Update record score if input has Plate and State, BAIR-581
					_record_score := IF(inParam[1].plate<>'' AND inParam[1].st <>'' AND LEFT.plate_st = inParam[1].st, LEFT.record_score + 4,LEFT.record_score);
				SELF.record_score := _record_score;
				SELF.person_match := IF(BairRx_PSS.Constants.IsPersonalRecord(LEFT.prepped_rec_type), match_person(LEFT,_record_score), FALSE);
				SELF.vehicle_match := IF(BairRx_PSS.Constants.IsVehicleRecord(LEFT.prepped_rec_type), match_vehicle(LEFT,_record_score), FALSE);
				SELF.phone_match := IF(BairRx_PSS.Constants.IsPhoneRecord(LEFT.prepped_rec_type), match_phone(LEFT,_record_score), FALSE),
				SELF.match := SELF.person_match OR SELF.vehicle_match OR SELF.phone_match, 			
				SELF := LEFT));
		
		RETURN dRawRecs;
	END;	
	
	// get raw recs plus filters (group access control, include options, dates)
	EXPORT GetCleanRecs(DATASET(BairRx_PSS.SALTLayout.LayoutIn) inParams) := FUNCTION
		
		inParam := inParams[1];		
		dRawRecs := GetRawRecs(inParams);			
		
		// Drop records based on include options
		dRecsInc := 
				IF(inParam.IncludeEvents,dRawRecs(BairRx_Common.EID.IsEvent(eid)))
			+ if(inParam.IncludeCFS,dRawRecs(BairRx_Common.EID.IsCFS(eid)))
			+ if(inParam.IncludeCrash,dRawRecs(BairRx_Common.EID.IsCrash(eid)))
			+ if(inParam.IncludeLPR,dRawRecs(BairRx_Common.EID.IsLPR(eid)))
			+ if(inParam.IncludeOffenders,dRawRecs(BairRx_Common.EID.IsOffender(eid)));
						
		// Apply Group access restrictions
		dRecsClean:= BairRx_Common.GroupAccessControl.Clean(dRecsInc, inParam.agencyORI, data_provider_ori);
																				
		// Taking care of Delta and Main key records along with Date filter
	 
		SlimEIDrec := RECORD
			BairRx_PSS.SALTLayout.LayoutOut.eid;
			BairRx_PSS.SALTLayout.LayoutOut.sequence;
			BairRx_PSS.SALTLayout.LayoutOut.DT_FIRST_SEEN;
			BairRx_PSS.SALTLayout.LayoutOut.DT_LAST_SEEN;
		END;
		
		// Get max sequence for each EID in Slim layout
		dEIDSequenceRecs := DEDUP(SORT(PROJECT(dRecsClean(BairRx_PSS.Constants.IsIncidentRecord(prepped_rec_type)),TRANSFORM(SlimEIDrec,SELF := LEFT)),EID,-Sequence),EID);
		
		//Apply date filter on the max sequenced EIDs
		dEIDCleanDate := dEIDSequenceRecs((inParam.DT_FIRST_SEEN=0 OR (dt_last_seen <> 0 AND  inParam.DT_FIRST_SEEN <= dt_last_seen)),
																 (inParam.DT_LAST_SEEN=0  OR (dt_first_seen <> 0 AND inParam.DT_LAST_SEEN >= dt_first_seen))); 	
		
		// Join back using EID and sequence(maximum) to get the latest key records for each date filtered EID
		dRecsout := JOIN(dRecsClean,dEIDCleanDate, LEFT.EID = RIGHT.EID AND LEFT.Sequence = RIGHT.Sequence,
									TRANSFORM(BairRx_PSS.SALTLayout.LayoutOut, SELF := LEFT));

		RETURN dRecsout;										
		
	END;
		
END;