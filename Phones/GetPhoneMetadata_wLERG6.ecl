IMPORT Doxie, Phones, PhonesInfo, STD, UT, dx_PhonesInfo;

EXPORT GetPhoneMetadata_wLERG6(DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dBatchPhonesIn,
	Phones.IParam.BatchParams in_mod) := FUNCTION

	Layout_BatchRaw	:= Phones.Layouts.PhoneAttributes.Raw;
	today := STD.Date.Today();
	earliestAllowedDate := (UNSIGNED)ut.date_math((STRING)today, -in_mod.max_age_days);

	//Get phone data from Roxie

dPortedMetadataPhones := JOIN(dBatchPhonesIn,PhonesInfo.Key_Phones.Ported_Metadata, 
													LEFT.phoneno = RIGHT.phone,
													TRANSFORM(Layout_BatchRaw,
													SELF.acctno := LEFT.acctno,
													SELF.phoneno := LEFT.phoneno,
													SELF := RIGHT,
													SELF := []),
													LIMIT(0), LEFT OUTER, KEEP(Phones.Constants.PhoneAttributes.MaxRecsPerPhone));

dPhone_wCurrentCarrierInfo := dPortedMetadataPhones(is_ported OR source = Phones.Constants.Sources.Lerg6);

dPhone_wOldCarrierInfo := DEDUP(SORT(JOIN(dPortedMetadataPhones, dPhone_wCurrentCarrierInfo,
														LEFT.phoneno = RIGHT.phone,
														TRANSFORM(Layout_BatchRaw,
														SELF.acctno := LEFT.acctno,
														SELF := LEFT),
														LEFT ONLY), acctno, phone), acctno, phone);		//Should look up Lerg6 index only if that data is not available in ported_metadata index														 

Layout_BatchRaw transformLerg6(Layout_BatchRaw l, recordof(dx_PhonesInfo.Key_Phones_Lerg6) r) := TRANSFORM
		is_block := (r.block_id = Phones.Constants.PhoneAttributes.DEFAULT_BLOCK_ID);
		SELF.acctno := l.acctno;
		SELF.phone := l.phoneno;
		SELF.source := r.source;  
		SELF.dt_first_reported := IF(is_block, 0, (Integer)r.dt_first_reported);
		SELF.dt_last_reported := IF(is_block, 0, (Integer)r.dt_last_reported);// Need to keep default at bottom as it is not an exact match
		SELF.account_owner := r.ocn;
		SELF.local_area_transport_area := r.lata;
		SELF.vendor_last_reported_dt := IF(is_block, 0,(Integer)r.dt_last_reported);
		SELF.vendor_first_reported_dt := IF(is_block, 0,(Integer)r.dt_first_reported);
		SELF := [];
	END;
	
dLerg6Phones := JOIN(dPhone_wOldCarrierInfo, dx_PhonesInfo.Key_Phones_Lerg6, (LEFT.phone[1..3] =RIGHT.npa and left.phone[4..6]=RIGHT.nxx 
																    and (left.phone[7]=RIGHT.block_id or RIGHT.block_id = Phones.Constants.PhoneAttributes.DEFAULT_BLOCK_ID) 
																	   and RIGHT.is_current = TRUE),
		                  transformLerg6(LEFT, RIGHT),LEFT OUTER, LIMIT(0),KEEP(Phones.Constants.PhoneAttributes.MaxRecsPerPhone));

filteredLerg6Phones := SORT(dLerg6Phones,acctno,phone,-dt_last_reported);

   

dPortedPhones := dPortedMetadataPhones + filteredLerg6Phones;

	//Add additional carrier info to Lerg6 records. They don't contain this information.
	//However records retrieved from the metadata file should be left alone.
	//is_current looks like it's true for all records but we are keeping the old logic for now.
Layout_BatchRaw tAppendCarrierRefInfo1(Layout_BatchRaw le, RECORDOF(dx_PhonesInfo.Key_Source_Reference.ocn_name) ri) :=  TRANSFORM
      
    is_carrier_info := ri.contact_function = '' AND ri.overall_ocn <> '' AND (ri.carrier_city != '' OR ri.carrier_state != '');
    
    //All records get carrier_city and carrier_state added
    SELF.ocn_abbr_name           := IF(is_carrier_info, ri.ocn_abbr_name, le.ocn_abbr_name);
    SELF.carrier_city            := IF(is_carrier_info, ri.carrier_city, le.carrier_city);
    SELF.carrier_name            := IF(is_carrier_info, ri.carrier_name, le.carrier_name);
    SELF.carrier_category        := IF(is_carrier_info, ri.category, le.carrier_category);
    SELF.carrier_state           := IF(is_carrier_info, ri.carrier_state, le.carrier_state);
    SELF.carrier_route           := IF(is_carrier_info, ri.cart, le.carrier_route);
    SELF.carrier_route_zonecode  := IF(is_carrier_info, ri.cr_sort_sz, le.carrier_route_zonecode);
    SELF.delivery_point_code     := IF(is_carrier_info, ri.dpbc, le.delivery_point_code);
    SELF.affiliated_to           := IF(is_carrier_info, ri.affiliated_to, le.affiliated_to);
    SELF.contact_name            := IF(is_carrier_info, ri.contact_name, le.contact_name);
	SELF.contact_address1        := IF(is_carrier_info, ri.carrier_address1, le.contact_address1);
	SELF.contact_address2        := IF(is_carrier_info, ri.carrier_address2, le.contact_address2);
	SELF.contact_city            := IF(is_carrier_info, ri.carrier_city, le.carrier_city);
   	SELF.contact_state           := IF(is_carrier_info, ri.carrier_state, le.carrier_state);
   	SELF.contact_zip             := IF(is_carrier_info, ri.carrier_zip, le.contact_zip);
    SELF.contact_phone           := IF(is_carrier_info, ri.carrier_phone, le.contact_phone);
    SELF.contact_fax             := IF(is_carrier_info, ri.contact_fax, le.contact_fax);
    SELF.contact_email           := IF(is_carrier_info, ri.contact_email, le.contact_email);

 	recNeedsLineServ := (le.source = Phones.Constants.Sources.LERG6);
	//Add the remaining information only to Lerg6 records.
	SELF.line:=IF(recNeedsLineServ, ri.line, le.line);
	SELF.serv:=IF(recNeedsLineServ, ri.serv, le.serv);
	SELF.spid:=IF(recNeedsLineServ, ri.spid, le.spid);
	SELF.prepaid:=IF(recNeedsLineServ, ri.prepaid, le.prepaid);
	SELF.operator_fullname:=IF(recNeedsLineServ, ri.operator_full_name, le.operator_fullname);
	SELF := le;
   
  END;
  
	//denormalize to join index records for contact function = '' and overall ocn <> '' -  limit to 100
dPortedPhonesFinal := DENORMALIZE(dPortedPhones, dx_PhonesInfo.Key_Source_Reference.ocn_name,
									KEYED(LEFT.account_owner = RIGHT.ocn) AND
									RIGHT.is_current, 
									tAppendCarrierRefInfo1(LEFT, RIGHT),
									LEFT OUTER, LIMIT(100, SKIP));			
	//prioritize PORTED
dPortedPhonesSorted := SORT(dPortedPhonesFinal, acctno, phone, -vendor_last_reported_dt, 
								vendor_first_reported_dt, -dt_last_reported, dt_first_reported, source <> Phones.Constants.Sources.ICONECTIV_SRC,
								record);

		
Layout_BatchRaw  ProcessRecs(Layout_BatchRaw L) := TRANSFORM
		SELF.acctno := L.acctno;
		SELF.phoneno := L.phone;
		SELF.is_current	:= FALSE;

		// * Disconnect event_date = deact_start_dt
		// * Ported phone event_date = port_start_dt
		// * Swap Phone Number event_date = swap_start_dt
		// * Suspended Number event_date = deact_start_dt
		// * Reactivated Number event_date = react_start_dt
		boolean ported_phone := L.source = Phones.Constants.Sources.ICONECTIV_SRC;


		//identifies both historic and current disconnect records
		//is_deact can also be P - Ported - we want to ignore P records because they don't represent true disconnects.
		boolean disconnected := L.deact_code = Phones.Constants.TransactionCodes.DISCONNECTED_CODE and (L.is_deact = 'Y' OR L.is_deact = 'N');
		boolean number_swapped := L.phone_swap <> '';
		boolean suspended := L.deact_code = Phones.Constants.TransactionCodes.SUSPENDED_CODE and in_mod.include_temp_susp_reactivate;
		boolean reactivated := L.is_react = 'Y'; //remove L.deact_code=Consts.SUSPENDED_CODE to include PX(suspension reacts) and PG(Gong additions)
		boolean VERFICATION := L.source IN Phones.Constants.Sources.SET_VERIFICATION;
		event_type := if(ported_phone, Phones.Constants.PhoneAttributes.PORTED_PHONE, '') +
						if(disconnected and not ported_phone, Phones.Constants.PhoneAttributes.DISCONNECTED, '') +
						if(reactivated, Phones.Constants.TransactionCodes.REACTIVATED, '') +
						if(number_swapped, Phones.Constants.PhoneAttributes.NUMBER_SWAPPED, '') +
						if(suspended, Phones.Constants.PhoneAttributes.SUSPENDED, '') +
						if(VERFICATION, Phones.Constants.PhoneAttributes.VERFICATION, '');
		event_date := if(VERFICATION,L.vendor_last_reported_dt,MAX(L.port_start_dt, L.swap_start_dt, L.deact_start_dt, L.react_start_dt));
		SELF.event_type := event_type;
		SELF.event_date	:= if(event_type <> '', event_date, 0);

		// populate disconnect date based on record's event type to report most recent event date
		SELF.disconnect_date := MAP(disconnected => L.deact_start_dt,
									number_swapped => L.swap_start_dt, 
									0);

		SELF.ported_date := if(ported_phone, L.port_start_dt, 0);
		SELF.carrier_id	:= L.account_owner;
		SELF.carrier_name := L.carrier_name;
		SELF.carrier_category := L.carrier_category;
		SELF.operator_id := L.spid;
		SELF.operator_name := if(L.operator_fullname <> '', L.operator_fullname, L.carrier_name);
		SELF.line_type_last_seen := CASE(L.source,
										Phones.Constants.Sources.ATT_LIDB_SRC => L.dt_last_reported,
										Phones.Constants.Sources.LERG6 => L.dt_last_reported, 
										Phones.Constants.Sources.ICONECTIV_SRC => L.port_start_dt, //probably should include port_end_dt
										Phones.Constants.Sources.GONG_DISCONNECT_SRC => MAX(L.deact_start_dt,L.deact_end_dt,L.react_start_dt,L.react_end_dt),
										0);
		SELF.phone_serv_type := if(ported_phone or VERFICATION, L.serv, ''); // PG are not always shown as landlines even though they came from gong ???
		SELF.phone_line_type := if(ported_phone or VERFICATION, L.line, '');
		SELF.swapped_phone_number_date := if(number_swapped, L.swap_start_dt, 0);
		SELF.new_phone_number_from_swap	:= L.phone_swap;
		SELF.suspended_date := if(suspended, L.deact_start_dt, 0);
		SELF.reactivated_date := if(reactivated, L.react_start_dt, 0);
		SELF.source := L.source;
		SELF.prepaid := L.prepaid;
		SELF.error_desc	:= L.error_desc;
		SELF.carrier_city := L.carrier_city;
		SELF.carrier_state := L.carrier_state;

		//Check if the current record is outdated, from L6, if so we mark dialable false.
		boolean is_outdated := SELF.event_date < earliestAllowedDate;
		SELF.dialable := ~is_outdated AND L.source <> Phones.Constants.Sources.DISCONNECT_SRC;

		//These values are assigned below when all the most recent data is combined so they match what is being displayed.
		SELF.phone_line_type_desc := '';
		SELF.phone_serv_type_desc := '';
		SELF := L;
	END;
	dPhones_w_Metadata := PROJECT(dPortedPhonesSorted, ProcessRecs(LEFT));
	
 	#IF(Phones.Constants.Debug.PhoneMetadata_wLIDB)
        OUTPUT(dBatchPhonesIn,NAMED('dBatchPhonesIn'), EXTEND);
        OUTPUT(dPortedMetadataPhones,NAMED('dPortedMetadataPhones'), EXTEND);
        // OUTPUT(numbersForDelta,NAMED('numbersForDelta'), EXTEND);
        // OUTPUT(deltaATTPhones,NAMED('deltaATTPhones'), EXTEND);
        // OUTPUT(filteredDeltaATTPhones,NAMED('filteredDeltaATTPhones'), EXTEND);
        // OUTPUT(dPortedDeltaPhones,NAMED('dPortedDeltaPhones'), EXTEND);
        // OUTPUT(dPortedMetadataDeltaPhones,NAMED('dPortedMetadataDeltaPhones'), EXTEND);
        // OUTPUT(latestPhoneRecs,NAMED('latestPhoneRecs'), EXTEND);
        // OUTPUT(oldOrIncompleteRecs,NAMED('oldOrIncompleteRecs'), EXTEND); 
        // OUTPUT(numbersWithNoData,NAMED('numbersWithNoData'), EXTEND);
	       // OUTPUT(numbersForRealtime,NAMED('numbersForRealtime'), EXTEND);
								// OUTPUT(realtimeATTPhones,NAMED('realtimeATTPhones'), EXTEND);
								// OUTPUT(filteredAttPhones,NAMED('filteredAttPhones'), EXTEND);
								// OUTPUT(dPortedRealtime,NAMED('dPortedRealtime'), EXTEND);
								OUTPUT(dPortedPhones,NAMED('dPortedPhones'), EXTEND);
								OUTPUT(dPortedPhonesFinal,NAMED('dPortedPhonesFinal'), EXTEND);
								OUTPUT(dPortedPhonesSorted,NAMED('dPortedPhonesSorted'), EXTEND);
								OUTPUT(filteredLerg6Phones,NAMED('filteredLerg6Phones'), EXTEND);
	#END

RETURN dPhones_w_Metadata;
END;