IMPORT Doxie, Gateway, Iesp, Phones, PhonesInfo, STD, UT;

EXPORT GetPhoneMetadata_wLIDB(DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dBatchPhonesIn,
	Phones.IParam.PhoneAttributes.BatchParams in_mod) := FUNCTION

	Consts := Phones.Constants.PhoneAttributes;
	Layout_BatchOut := Phones.Layouts.PhoneAttributes.BatchOut;
	Layout_BatchRaw	:= Phones.Layouts.PhoneAttributes.Raw;
	today := STD.Date.Today();
	earliestAllowedDate := (UNSIGNED)ut.date_math((STRING)today, -in_mod.max_lidb_age_days);

	//Get phone data from Roxie
	dPortedMetadataPhones := JOIN(dBatchPhonesIn, PhonesInfo.Key_Phones.Ported_Metadata,
	KEYED(LEFT.phoneno = RIGHT.phone),
	TRANSFORM(Layout_BatchRaw,
		SELF.acctno := LEFT.acctno,
		SELF.error_desc := '',
		SELF.carrier_city := '',
		SELF.carrier_state := '',
		SELF := RIGHT,
		SELF := []),
	LIMIT(0), KEEP(Consts.MaxRecsPerPhone));

	//Get phone data from the deltabase
	phoneRec := {STRING10 phone};
	numbersForDelta := DEDUP(SORT(PROJECT(dBatchPhonesIn, TRANSFORM(phoneRec,
		SELF.phone := LEFT.phoneno
	)), phone), phone);

	deltaATTPhones := Phones.GetATTPhones_Deltabase(numbersForDelta,,in_mod.gateways);

	//Keep only latest records from deltabase that aren't missing information.
	filteredDeltaATTPhones := DEDUP(SORT(deltaATTPhones(
		reply_code <> '' AND account_owner <> '' AND carrier_name <> '' AND carrier_category <> '' AND
		local_area_transport_area <> '' AND point_code <> ''),
		acctno,phone, -vendor_last_reported_dt, -vendor_last_reported_time), phone);

	//Add account numbers back from input data.
	dPortedDeltaPhones := JOIN(dBatchPhonesIn, filteredDeltaATTPhones,
		LEFT.phoneno = RIGHT.phone,
		TRANSFORM(Layout_BatchRaw,
			SELF.acctno := LEFT.acctno,
			SELF.phone := LEFT.phoneno,
			SELF := RIGHT),
		LIMIT(0), KEEP(Consts.MaxRecsPerPhone));

	//Add the deltabase records to the metadata records and eliminate duplicates.
	dPortedMetadataDeltaPhones := DEDUP(SORT(dPortedMetadataPhones + dPortedDeltaPhones,
		acctno,phone,-dt_last_reported,-port_start_dt,-port_start_time,-swap_start_dt,-swap_start_time,-deact_start_dt,-deact_start_time,-react_start_dt,-react_start_time,reference_id),
		acctno,phone, dt_last_reported, port_start_dt, port_start_time, swap_start_dt, swap_start_time, deact_start_dt, deact_start_time, react_start_dt, react_start_time,reference_id);

	// identify latest records per phone that need real time update
	latestPhoneRecs := DEDUP(SORT(dPortedMetadataDeltaPhones, phone, -MAX(dt_last_reported, port_start_dt, swap_start_dt, deact_start_dt, react_start_dt)), phone);

	oldOrIncompleteRecs := latestPhoneRecs(MAX(dt_last_reported, port_start_dt, swap_start_dt, deact_start_dt, react_start_dt)
		<= earliestAllowedDate //old records
		OR (source <> Consts.ATT_LIDB_Delta AND (line='' OR serv=''))); //missing line and serv types

	//Find numbers with no match at all
	numbersWithNoData := DEDUP(SORT(JOIN(dBatchPhonesIn, latestPhoneRecs, LEFT.phoneno = RIGHT.phone, TRANSFORM(phoneRec,
		SELF.phone := LEFT.phoneno), LEFT ONLY), phone), phone);

	//We don't need deduping here since OldOrIncomplete and NumbersWithNoData are both deduped already and can't contain each other.
	numbersForRealtime := PROJECT(oldOrIncompleteRecs, phoneRec) + numbersWithNoData;
	attLIBD_enabled := in_mod.use_realtime_lidb AND ~Doxie.DataRestriction.isATT_LIDBRestricted(in_mod.DataRestrictionMask);

	//get real time LIDB data
	attGateway  := in_mod.gateways(Gateway.Configuration.IsAttIapQuery(servicename))[1];
	
	realtimeAttPhones := IF(EXISTS(numbersForRealtime) AND attGateway.url<>'' AND attLIBD_enabled,
		Gateway.Soapcall_ATTPhoneSearch(numbersForRealtime, attGateway, attLIBD_enabled));

	//Eliminate records with no phone number. This is more in line with the old logic that wasn't filtering.
	//It also allows us to pass errors through to error_desc
	filteredAttPhones := realtimeAttPhones(Response.AttMessage.EchoData.Custom1 <> '');

	//Convert response to our layout and add the account numbers back.
	Layout_BatchRaw transformRealTimeLIDB(Phones.Layouts.PhoneAttributes.BatchIn l, iesp.att_iap.t_ATTIapQueryResponseEx r) := TRANSFORM
		EchoData := r.Response.AttMessage.EchoData;
		AttResponse := r.Response.AttMessage.AttResponse;
		eventDate := IF(ATTResponse.Status='OK',today,0);
		SELF.acctno := l.acctno;
		SELF.phone := l.phoneno;
		SELF.source := Consts.ATT_LIDB_RealTime; //identifier to track royalties for RealTime ATT
		SELF.dt_first_reported := eventDate;
		SELF.dt_last_reported := eventDate;
		SELF.reply_code := ATTResponse.InformationRetrievalResponse.DataGatewayReplyCode;
		SELF.account_owner := ATTResponse.InformationRetrievalResponse.AccountOwner;
		SELF.carrier_name := ATTResponse.InformationRetrievalResponse.CarrierName;
		SELF.carrier_category := ATTResponse.InformationRetrievalResponse.Category;
		SELF.local_area_transport_area := ATTResponse.InformationRetrievalResponse.LocalAccessAndTransport;
		SELF.point_code := ATTResponse.InformationRetrievalResponse.PointCode;
		SELF.error_desc := IF(ATTResponse.Status <> 'OK','LIDB: '+ ATTResponse.Status + ';','');
		//Layout_BatchRaw contains many fields we don't yet have information for so we blank the rest.
		//We already have all the information needed from the response.
		SELF := [];
	END;

	dPortedRealtime := JOIN(dBatchPhonesIn, filteredAttPhones, LEFT.phoneno = RIGHT.Response.AttMessage.EchoData.Custom1,
		transformRealTimeLIDB(LEFT, RIGHT));

	//Add the realtime info, shouldn't need to dedupe - only delta and metadata recs that weren't good enough are added.
	dPortedPhones := dPortedMetadataDeltaPhones + dPortedRealtime;

	//Add additional carrier info only to deltabase and realtime records. They don't contain this information.
	//However records retrieved from the metadata file should be left alone.
	//is_current looks like it's true for all records but we are keeping the old logic for now.
		Layout_BatchRaw tAppendCarrierRefInfo1(Layout_BatchRaw le, RECORDOF(PhonesInfo.Key_Source_Reference.ocn_name) ri) :=
  TRANSFORM
      
    is_carrier_info := ri.contact_function = '' AND ri.overall_ocn <> '' AND (ri.carrier_city != '' OR ri.carrier_state != '');
    
    //All records get carrier_city and carrier_state added
    SELF.ocn_abbr_name           := IF(is_carrier_info, ri.ocn_abbr_name, le.ocn_abbr_name);
    SELF.carrier_city            := IF(is_carrier_info, ri.carrier_city, le.carrier_city);
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
			
	SET OF STRING2 sourcesMissingInfo := [Consts.ATT_LIDB_Delta, Consts.ATT_LIDB_RealTime];
	recNeedsLineServ := le.source IN sourcesMissingInfo AND le.error_desc = '';

	//Add the remaining information only to deltabase and realtime records.
	SELF.line:=IF(recNeedsLineServ, ri.line, le.line);
	SELF.serv:=IF(recNeedsLineServ, ri.serv, le.serv);
	SELF.spid:=IF(recNeedsLineServ, ri.spid, le.spid);
	SELF.prepaid:=IF(recNeedsLineServ, ri.prepaid, le.prepaid);
	SELF.operator_fullname:=IF(recNeedsLineServ, ri.operator_full_name, le.operator_fullname);

	//Remove temporary PD source.
	SELF.source := IF(le.source=Consts.ATT_LIDB_Delta,Consts.ATT_LIDB_SRC,le.source);
	SELF := le;
   
  END;
  
	//denormalize to join index records for contact function = '' and overall ocn <> '' -  limit to 100
  dPortedPhonesFinal := DENORMALIZE(dPortedPhones, PhonesInfo.Key_Source_Reference.ocn_name,
									KEYED(LEFT.account_owner = RIGHT.ocn) AND
									Phones.Functions.StandardName(LEFT.carrier_name) = RIGHT.name AND
									RIGHT.is_current,
									tAppendCarrierRefInfo1(LEFT, RIGHT),
									LEFT OUTER, LIMIT(100, SKIP));
				
				
	//prioritize Realtime LIDB
	dPortedPhonesSorted := SORT(dPortedPhonesFinal, acctno,phone, -dt_last_reported, -dt_first_reported,
										source <> Consts.ATT_LIDB_RealTime, record);
		
	Layout_BatchRaw  ProcessRecs(Layout_BatchRaw L) := TRANSFORM
		SELF.acctno := L.acctno;
		SELF.phoneno := L.phone;
		SELF.is_current	:= FALSE;

		// * Disconnect event_date = deact_start_dt
		// * Ported phone event_date = port_start_dt
		// * Swap Phone Number event_date = swap_start_dt
		// * Suspended Number event_date = deact_start_dt
		// * Reactivated Number event_date = react_start_dt
		boolean ported_phone := L.source = Consts.ICONECTIV_SRC;
		boolean ported_line := ported_phone or  L.source IN Consts.set_ATT_LIDB;

		//identifies both historic and current disconnect records
		//is_deact can also be P - Ported
		boolean disconnected := L.deact_code = Consts.DISCONNECTED_CODE;  // and (L.is_deact = 'Y' OR L.is_deact = 'N');
		boolean number_swapped := L.phone_swap <> '';
		boolean suspended := L.deact_code = Consts.SUSPENDED_CODE and in_mod.include_temp_susp_reactivate;
		boolean reactivated := L.is_react = 'Y'; //remove L.deact_code=Consts.SUSPENDED_CODE to include PX(suspension reacts) and PG(Gong additions)
		boolean lidb_verfication := L.source IN Consts.set_ATT_LIDB;
		event_type := if(ported_phone, Consts.PORTED_PHONE, '') +
						if(disconnected and not ported_phone, Consts.DISCONNECTED, '') +
						if(reactivated, Consts.REACTIVATED, '') +
						if(number_swapped, Consts.NUMBER_SWAPPED, '') +
						if(suspended, Consts.SUSPENDED, '') +
						if(lidb_verfication, Consts.LIDB_VERFICATION, '');

		event_date := if(lidb_verfication,L.dt_last_reported,MAX(L.port_start_dt, L.swap_start_dt, L.deact_start_dt, L.react_start_dt));
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
										Consts.ATT_LIDB_SRC => L.dt_last_reported,
										Consts.ATT_LIDB_RealTime => L.dt_last_reported,
										Consts.ICONECTIV_SRC => L.port_start_dt, //probably should include port_end_dt
										Consts.GONG_DISCONNECT_SRC => MAX(L.deact_start_dt,L.deact_end_dt,L.react_start_dt,L.react_end_dt),
										0);
		SELF.phone_serv_type := if(ported_line, L.serv, ''); // PG are not always shown as landlines even though they came from gong ???
		SELF.phone_line_type := if(ported_line, L.line, '');
		SELF.swapped_phone_number_date := if(number_swapped, L.swap_start_dt, 0);
		SELF.new_phone_number_from_swap	:= L.phone_swap;
		SELF.suspended_date := if(suspended, L.deact_start_dt, 0);
		SELF.reactivated_date := if(reactivated, L.react_start_dt, 0);
		SELF.source := L.source;
		SELF.prepaid := L.prepaid;
		SELF.error_desc	:= L.error_desc;
		SELF.carrier_city := L.carrier_city;
		SELF.carrier_state := L.carrier_state;

		//Check if the current record is outdated, from PX, or has an error_code, if so we mark dialable false.
		today := STD.Date.Today();
		earliestAllowedDate_libd := (UNSIGNED)ut.date_math((STRING)today, -in_mod.max_lidb_age_days);
		boolean is_outdated := SELF.event_date < earliestAllowedDate_libd;
		SELF.dialable := ~is_outdated AND L.error_desc = '' AND L.source <> Consts.DISCONNECT_SRC;

		//These values are assigned below when all the most recent data is combined so they match what is being displayed.
		SELF.phone_line_type_desc := '';
		SELF.phone_serv_type_desc := '';
		SELF := L;
	END;
	dPhones_w_Metadata := PROJECT(dPortedPhonesSorted, ProcessRecs(LEFT));
	
 	#IF(Phones.Constants.Debug.PhoneMetadata_wLIDB)
        OUTPUT(dBatchPhonesIn,NAMED('dBatchPhonesIn'), EXTEND);
        OUTPUT(dPortedMetadataPhones,NAMED('dPortedMetadataPhones'), EXTEND);
        OUTPUT(numbersForDelta,NAMED('numbersForDelta'), EXTEND);
        OUTPUT(deltaATTPhones,NAMED('deltaATTPhones'), EXTEND);
        OUTPUT(filteredDeltaATTPhones,NAMED('filteredDeltaATTPhones'), EXTEND);
        OUTPUT(dPortedDeltaPhones,NAMED('dPortedDeltaPhones'), EXTEND);
        OUTPUT(dPortedMetadataDeltaPhones,NAMED('dPortedMetadataDeltaPhones'), EXTEND);
        OUTPUT(latestPhoneRecs,NAMED('latestPhoneRecs'), EXTEND);
        OUTPUT(oldOrIncompleteRecs,NAMED('oldOrIncompleteRecs'), EXTEND); 
        OUTPUT(numbersWithNoData,NAMED('numbersWithNoData'), EXTEND);
	    OUTPUT(numbersForRealtime,NAMED('numbersForRealtime'), EXTEND);
		OUTPUT(realtimeATTPhones,NAMED('realtimeATTPhones'), EXTEND);
		OUTPUT(filteredAttPhones,NAMED('filteredAttPhones'), EXTEND);
		OUTPUT(dPortedRealtime,NAMED('dPortedRealtime'), EXTEND);
		OUTPUT(dPortedPhones,NAMED('dPortedPhones'), EXTEND);
		OUTPUT(dPortedPhonesFinal,NAMED('dPortedPhonesFinal'), EXTEND);
	    OUTPUT(dPortedPhonesSorted,NAMED('dPortedPhonesSorted'), EXTEND);
	    OUTPUT(dPhones_w_Metadata,NAMED('dPhones_w_Metadata'), EXTEND);
	#END
RETURN dPhones_w_Metadata;
END;