IMPORT  Gateway, MDR, PhoneFinder_Services, STD, ut, Phones, dx_PhonesInfo;

EXPORT GetPhonesPortedMetadata(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final) dSearchRecs0,
													     PhoneFinder_Services.iParam.SearchParams inMod,
													     DATASET(Gateway.Layouts.Config) dGateways,
													     DATASET(	PhoneFinder_Services.Layouts.SubjectPhone) subjectInfo,
													     DATASET(PhoneFinder_Services.Layouts.PortedMetadata) accu_rpt = DATASET([], PhoneFinder_Services.Layouts.PortedMetadata)) :=
FUNCTION

  currentDate := (STRING)STD.Date.Today();

  //Based on subject info get ALL ports and CURRENT deact records
  dInPhones := DEDUP(SORT(PROJECT(subjectInfo, TRANSFORM(Phones.Layouts.PhoneAttributes.BatchIn, SELF.phoneno := LEFT.Phone, SELF := [])), phoneno), phoneno);
  in_mod := MODULE(Phones.IParam.BatchParams)
  EXPORT UNSIGNED	max_age_days := Phones.Constants.PhoneAttributes.LastActivityThreshold;
  EXPORT BOOLEAN AllowPortingData := inMod.AllowPortingData;
  END;
  dsPhonesmetadata:= PROJECT(Phones.GetPhoneMetadata_wLERG6(dInPhones, in_mod), TRANSFORM(Phones.Layouts.portedMetadata_Main, SELF := LEFT));

  dPorted	:= JOIN(subjectInfo, dsPhonesmetadata,
                 (LEFT.phone = RIGHT.phone) AND
                  ((LEFT.FirstSeenDate <= RIGHT.port_start_dt) OR
                    (LEFT.FirstSeenDate <= RIGHT.dt_last_reported) OR
                    (RIGHT.deact_code=PhoneFinder_Services.Constants.PortingStatus.Disconnected AND RIGHT.is_deact='Y')),
                    LIMIT(PhoneFinder_Services.Constants.MetadataLimit, SKIP));

  //Check if realtime data was requested
  dDeltabasePorted := PhoneFinder_Services.GetPortedPhones_Deltabase(subjectInfo, PhoneFinder_Services.Constants.SQLSelectLimit, dGateways);

  //Join available realtime ports. Deact data is NOT available in realtime
  dDeltabasewSubject := JOIN(subjectInfo, dDeltabasePorted,
                              LEFT.phone = RIGHT.phone AND
                              RIGHT.source IN MDR.sourceTools.set_PhonesPorted AND
                              LEFT.FirstSeenDate <= RIGHT.port_start_dt,
                              KEEP(PhoneFinder_Services.Constants.MaxPortedMatches), LIMIT(0));

  //Join to Accudata OCN porting
  dAccudata := JOIN(subjectInfo, accu_rpt,
                    LEFT.phone = RIGHT.phone AND
                    LEFT.FirstSeenDate <= RIGHT.port_start_dt,
                    KEEP(PhoneFinder_Services.Constants.MaxPortedMatches), LIMIT(0));

  // This new section of coding was added for the 2021-0602 "Phone Porting Data For LE(Law Enforcement)" project to get
  // (for the phone# being "reported on"), the associated Company(carrier) name, Contact name & Contact Phone data for each 
  // of the 3 new ported data spid, alt spid and last alt spid fields requested to be output (sp=Service Provider).
  //
  // NOTE: since no TRANSFORM/layout was used in any of the 3 'JOIN's above(---^), the resulting dataset record layout is:
  //   PhoneFinder_Services.Layouts.SubjectPhone (subjectInfo)  PLUS
  //	 PhoneFinder_Services.Layouts.PortedMetadata (which uses Phones.Layouts.portedMetadata_Main)
  // with the 2nd of any matching exact field names (only the 'phone' field) removed.
  // So a new record layout was created named PhoneFinder_Services.Layouts.SubPhone_PortedMetadataMain_Comb_Plus to mimic 
  // the layout of the dataset out of those JOINs above with some addtional fields specifically needed for the project
  // and which will then be used in multiple places in the project related changes below.

  // So as was done in the original coding prior to these project changes, first the datasets out of the 3 'JOIN's above are
  // concatenated, but revised to do that here in a separate step, so the concatentated dataset can be used in the new coding below.
  ds_all_ported_concat := dPorted + dAccudata + IF(EXISTS(subjectInfo) AND inMod.UseDeltabase, dDeltabasewSubject);   //combine results

  // Then project the contatenated ds onto the combined_plus layout for use in next couple of steps below, 
  // adding a parent_seq# to each record.
  PhoneFinder_Services.Layouts.SubPhone_PortedMetadata_Comb_Plus tf_combpluslo_addseq (ds_all_ported_concat L,
                                                                                       INTEGER C) := TRANSFORM
     SELF.parent_seq := C, 
     SELF            := L,
     SELF            := [],
  END;
  ds_apc_combplus_lo := PROJECT(ds_all_ported_concat, tf_combpluslo_addseq(LEFT, COUNTER));

  // Then normalize that resulting dataset 3 times, once for each spid, alt_spid & lalt_spid
  PhoneFinder_Services.Layouts.SubPhone_PortedMetadata_Comb_Plus tf_norm_apc (ds_apc_combplus_lo L,
                                                                              INTEGER C) := TRANSFORM
    SELF.lookup_id := CHOOSE(C, L.spid, L.alt_spid, L.lalt_spid),
    SELF := L,
  END;
  ds_apc_cpl_normed := NORMALIZE(ds_apc_combplus_lo, 3, tf_norm_apc(LEFT, COUNTER));

  // Filter out blank lookup_spids and sort/dedup by lookup_spid so only hit the key once for each unique lookup_spid
  ds_apc_cpln_deduped := DEDUP(SORT(ds_apc_cpl_normed(lookup_id != ''),
                                    lookup_id),
                               lookup_id);
  
  // Use a join to "look up" all of the unique spids/lookup_ids on the Phones Source_Reference(carrier) key to get 
  // the associated Company(carrier) name, Contact_name & Contact Phone data.
  Cons := PhoneFinder_Services.Constants; 
  ds_apc_cplndd_wkeydata := JOIN(ds_apc_cpln_deduped, dx_PhonesInfo.Key_Source_Reference.ocn_name,
                                   KEYED(LEFT.lookup_id = RIGHT.ocn) AND
                                         RIGHT.is_current, // want the current info
                                 TRANSFORM(PhoneFinder_Services.Layouts.SubPhone_PortedMetadata_Comb_Plus,
                                   // Get 3 fields from right key
                                   SELF.lookup_company        := IF(RIGHT.override_file=Cons.CarrierKey_Arec, RIGHT.carrier_name,''),  //carrier_name on both 'A' & 'B records, so use 'A'
                                   SELF.lookup_contact        := IF(RIGHT.override_file=Cons.CarrierKey_Arec, RIGHT.contact_name,''),  //contact name info  appears to only be on the 'A' record
                                   SELF.lookup_contact_phone  := IF(RIGHT.override_file=Cons.CarrierKey_Brec, RIGHT.contact_phone,''), //contact_phone info appears to only be on the 'B' record
                                   // keep rest of the fields from left ds
                                   SELF := LEFT),
                                 INNER, //only keep left ds recs that have a match in the key
                                 LIMIT(PhoneFinder_Services.Constants.MetadataLimit), //=10000
                                 KEEP(2) // need to get 2 (override_flag=A & B) matching key recs
                                );

  // Since contact(name) data is on 1 key rec and the contact_phone on a 2nd key rec, will have to roll up the resulting dataset recs
  PhoneFinder_Services.Layouts.SubPhone_PortedMetadata_Comb_Plus tf_rollkeyrecs(ds_apc_cplndd_wkeydata L, 
                                                                                ds_apc_cplndd_wkeydata R) := TRANSFORM
    SELF.lookup_company        := L.carrier_name, // on both recs being rolled so doesn't matter which is used
    SELF.lookup_contact        := IF(L.lookup_contact       != '', L.lookup_contact, R.lookup_contact),
    SELF.lookup_contact_phone  := IF(L.lookup_contact_phone != '', L.lookup_contact_phone, R.lookup_contact_phone),
    SELF := l;
  END;

  ds_apc_cplndd_wkd_rolled		:= ROLLUP(SORT(ds_apc_cplndd_wkeydata,lookup_id),
                                        LEFT.lookup_id = RIGHT.lookup_id,
                                        tf_rollkeyrecs(LEFT, RIGHT));

  // Join the ds of normed recs to the ds with "looked up" key data rolled, to get the key data for all matching lookup_ids
  ds_apc_cpl_normed_wkeydata := JOIN(ds_apc_cpl_normed, ds_apc_cplndd_wkd_rolled,
                                       LEFT.lookup_id = RIGHT.lookup_id, 
                                     TRANSFORM(PhoneFinder_Services.Layouts.SubPhone_PortedMetadata_Comb_Plus,
                                       // Get 3 fields from right(key data)
                                       SELF.lookup_company        := RIGHT.lookup_company, 
                                       SELF.lookup_contact        := RIGHT.lookup_contact,
                                       SELF.lookup_contact_phone  := RIGHT.lookup_contact_phone,
                                       // keep rest of the fields from left ds
                                       SELF := LEFT),
                                     LEFT OUTER, //keep all from left ds even if no match to right
                                     LOOKUP // this optimizes code execution since right ds is small and 
                                            // also keeps resulting ds in same order as the left ds
                                    );
  
  // Denormalize the ds of all ported concatened comb_plus_lo (parent) with the ds with the key data appended (child), 
  // to put things back together in order.
  PhoneFinder_Services.Layouts.SubPhone_PortedMetadata_Comb_Plus tf_denorm_apc(ds_apc_combplus_lo L,
                                                                               ds_apc_cpl_normed_wkeydata R,
                                                                               INTEGER C) := TRANSFORM
    // Check counter/C value; C=1=sp info; C=2=alt_sp info & C=3=lalt_sp info
    SELF.sp_company            := IF(C=1, R.lookup_company, L.sp_company),
    SELF.sp_contact            := IF(C=1, R.lookup_contact, L.sp_contact),
    SELF.sp_contact_phone      := IF(C=1, R.lookup_contact_phone, L.sp_contact_phone),
    SELF.alt_sp_company        := IF(C=2, R.lookup_company, L.alt_sp_company),
    SELF.alt_sp_contact        := IF(C=2, R.lookup_contact, L.alt_sp_contact),
    SELF.alt_sp_contact_phone  := IF(C=2, R.lookup_contact_phone, L.alt_sp_contact_phone),
    SELF.lalt_sp_company       := IF(C=3, R.lookup_company, L.lalt_sp_company),
    SELF.lalt_sp_contact       := IF(C=3, R.lookup_contact, L.lalt_sp_contact),
    SELF.lalt_sp_contact_phone := IF(C=3, R.lookup_contact_phone, L.lalt_sp_contact_phone),
    SELF := L,
  END; 
  ds_all_ported_cc_wspinfo := DENORMALIZE(ds_apc_combplus_lo, ds_apc_cpl_normed_wkeydata, 
                                          LEFT.parent_seq = RIGHT.parent_seq,
                                          tf_denorm_apc(LEFT,RIGHT,COUNTER)); 

  // Only use all ported concatenated data with sp info appended if IncludePortingDetails=TRUE (DPM[38] != 0/blank)
  ds_all_ported_cc_to_use := IF(inMod.IncludePortingDetails, ds_all_ported_cc_wspinfo, ds_apc_combplus_lo);
  // ^--- end of the new section of coding added for the 'Phone Porting Data for LE' project

  // Get the latest phone activities per acctno, per did
  dPortedPhones := TOPN(GROUP(SORT(ds_all_ported_cc_to_use,   //combined results
                              acctno, phone, MAX(-dt_last_reported, -port_start_dt)), acctno, phone),
                        PhoneFinder_Services.Constants.MaxPortedMatches, acctno, phone, MAX(-dt_last_reported, -port_start_dt));

  // There are 6 sources in Ported_Metadata - PB, PG, PX, P!, PK & L6.
  // PB (LIDB) records will NOT have a port_start_dt and are base records created for gong and phonesplus records without any ports.
  // PG records are Gong History disconnects
  // PX (disconnect) records will NOT have a port_start_dt and represents disconnect activities.
  // Both PB and PX will be ordered by dt_last_reported.
  // P! are Iconectiv PortData Validate records that are currently updating
  // PK are Iconectiv historical recs no longer updating and represents actual moves between carriers recorded by port_start_dt. 
  //    These records will have a zero dt_last_reported value
  // L6 (LERG6) gives carrier information
  sortedPorts  := GROUP(SORT(dPortedPhones, acctno, phone, port_start_dt=0, port_start_dt, spid, -deact_start_dt, -dt_last_reported),
                        acctno, phone, spid);

	// select necessary fields
  portedRec :=
  RECORD
    sortedPorts.acctno;
    sortedPorts.did;
    sortedPorts.phone;
    sortedPorts.spid;
    sortedPorts.source;
    sortedPorts.operator_fullname;

    // Added next 12 lines for the 2021-06-02 Phone Ported Data for LE project
    sortedPorts.sp_company;
    sortedPorts.sp_contact;
    sortedPorts.sp_contact_phone;
    UNSIGNED4 DateOfChange          := sortedPorts.port_start_dt;
    STRING10  alt_spid              := MAX(GROUP, sortedPorts.alt_spid);
    string40  alt_sp_company        := MAX(GROUP, sortedPorts.alt_sp_company);
    string100 alt_sp_contact        := MAX(GROUP, sortedPorts.alt_sp_contact);
    string20  alt_sp_contact_phone  := MAX(GROUP, sortedPorts.alt_sp_contact_phone);
    STRING10  lalt_spid             := MAX(GROUP, sortedPorts.lalt_spid);
    string40  lalt_sp_company       := MAX(GROUP, sortedPorts.lalt_sp_company);
    string100 lalt_sp_contact       := MAX(GROUP, sortedPorts.lalt_sp_contact);
    string20  lalt_sp_contact_phone := MAX(GROUP, sortedPorts.lalt_sp_contact_phone);
 
    UNSIGNED1 PortingCount 			:= (UNSIGNED)(sortedPorts.source IN MDR.sourceTools.set_PhonesPorted);
    UNSIGNED4 FirstPortedDate 	:= sortedPorts.port_start_dt;
    UNSIGNED4 LastPortedDate  	:= MAX(MAX(GROUP, sortedPorts.port_end_dt), MAX(GROUP, sortedPorts.port_start_dt));
    UNSIGNED4 PortStartDate 		:= sortedPorts.port_start_dt;
    UNSIGNED4 PortEndDate  			:= MAX(MAX(GROUP, sortedPorts.port_end_dt), MAX(GROUP, sortedPorts.port_start_dt));
    UNSIGNED4 ActivationDate 		:= MAX(GROUP, sortedPorts.react_start_dt);		//for PFv2 - activation data not ready
    UNSIGNED4 DisconnectDate 		:= MAX(GROUP, sortedPorts.deact_start_dt);
    BOOLEAN   NoContractCarrier := MAX(GROUP, (integer) sortedPorts.high_risk_indicator) >0;
    BOOLEAN   Prepaid 					:= MAX(GROUP, (integer) sortedPorts.prepaid) > 0;
    UNSIGNED4 dt_last_reported	:= MAX(GROUP, sortedPorts.dt_last_reported);
  END;

  disconnects_src := [MDR.sourceTools.src_Phones_Disconnect, MDR.sourceTools.src_Phones_Gong_History_Disconnect];
  dPorts := UNGROUP(TABLE(sortedPorts(source NOT IN [disconnects_src, MDR.sourceTools.src_Phones_Lerg6, MDR.sourceTools.src_PhoneFraud_OTP, MDR.sourceTools.src_Phones_LIDB]), portedRec));
  dDisconnects := UNGROUP(TABLE(sortedPorts(source IN disconnects_src), portedRec));
  dPortedInfo := dPorts + dDisconnects;

  Porting_layout := RECORD
			portedRec;
			PhoneFinder_Services.Layouts.PhoneFinder.Porting;
	END;

	transformPort := PROJECT(dPortedInfo,
                            TRANSFORM(Porting_layout,
                                      SELF.PortingHistory := IF(LEFT.PortingCount > 0,
                                                                PROJECT(LEFT,
                                                                        TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.PortHistory,
                                                                                  SELF.PortStartDate 		:= LEFT.PortStartDate,
                                                                                  SELF.PortEndDate 			:= LEFT.PortEndDate,
                                                                                  SELF.ServiceProvider 	:= TRIM(LEFT.operator_fullname, LEFT, RIGHT),
                                                                                  // Added next 13 lines for the 2021-06-02 Phone Ported Data for LE project
                                                                                  SELF.ServiceProviderInfo.id            := LEFT.spid,
                                                                                  SELF.ServiceProviderInfo.company       := LEFT.sp_company,
                                                                                  SELF.ServiceProviderInfo.contact       := LEFT.sp_contact,
                                                                                  SELF.ServiceProviderInfo.contact_phone := LEFT.sp_contact_phone,
                                                                                  SELF.DateOfChange                      := LEFT.DateofChange,
                                                                                  SELF.AltServiceProviderInfo.id             := LEFT.alt_spid,
                                                                                  SELF.AltServiceProviderInfo.company        := LEFT.alt_sp_company,
                                                                                  SELF.AltServiceProviderInfo.contact        := LEFT.alt_sp_contact,
                                                                                  SELF.AltServiceProviderInfo.contact_phone  := LEFT.alt_sp_contact_phone,
                                                                                  SELF.LastAltServiceProviderInfo.id            := LEFT.lalt_spid,
                                                                                  SELF.LastAltServiceProviderInfo.company       := LEFT.lalt_sp_company,
                                                                                  SELF.LastAltServiceProviderInfo.contact       := LEFT.lalt_sp_contact,
                                                                                  SELF.LastAltServiceProviderInfo.contact_phone := LEFT.lalt_sp_contact_phone
                                                                                  ))),
                                      // Added next 13 lines for the 2021-06-02 Phone Ported Data for LE project
                                      SELF.ServiceProviderInfo.id                   := LEFT.spid,
                                      SELF.ServiceProviderInfo.company              := LEFT.sp_company,
                                      SELF.ServiceProviderInfo.contact              := LEFT.sp_contact,
                                      SELF.ServiceProviderInfo.contact_phone        := LEFT.sp_contact_phone,
                                      SELF.DateOfChange                             := LEFT.DateofChange,                                                                                  
                                      SELF.AltServiceProviderInfo.id                := LEFT.alt_spid,
                                      SELF.AltServiceProviderInfo.company           := LEFT.alt_sp_company,
                                      SELF.AltServiceProviderInfo.contact           := LEFT.alt_sp_contact,
                                      SELF.AltServiceProviderInfo.contact_phone     := LEFT.alt_sp_contact_phone,
                                      SELF.LastAltServiceProviderInfo.id            := LEFT.lalt_spid,
                                      SELF.LastAltServiceProviderInfo.company       := LEFT.lalt_sp_company,
                                      SELF.LastAltServiceProviderInfo.contact       := LEFT.lalt_sp_contact,
                                      SELF.LastAltServiceProviderInfo.contact_phone := LEFT.lalt_sp_contact_phone,
                                      SELF := LEFT,
                                      SELF := []));                            

	// The carrier often sends updates which are identified by repeated spids based on the sequencing of FirstPortedDate
	Porting_layout rollports(transformPort l, transformPort r) := TRANSFORM
    // Use to identify most current phone values - distinguishing btw PB (using dt_last_reported) and actual port records received (using port dates).
    mostCurrent := MAX(l.LastPortedDate, l.dt_last_reported) > MAX(r.LastPortedDate, r.dt_last_reported);

    SELF.PortingCount 		 := IF(l.spid <> r.spid AND r.source NOT IN disconnects_src,
                                  l.PortingCount + r.PortingCount, l.PortingCount);
    PortingHistory         := l.PortingHistory + r.PortingHistory;                              
    SELF.PortingHistory 	 := IF(r.source NOT IN disconnects_src,
                                                  PortingHistory(PortStartDate <> 0 AND PortEndDate <> 0), l.PortingHistory);
    SELF.LastPortedDate 	 := MAX(l.LastPortedDate, r.LastPortedDate);
    SELF.ActivationDate 	 := MAX(l.ActivationDate, r.ActivationDate);
    SELF.DisconnectDate 	 := MAX(l.DisconnectDate, r.DisconnectDate);
    SELF.Prepaid				 	 := IF(mostCurrent, l.Prepaid, r.Prepaid);
    SELF.NoContractCarrier := IF(mostCurrent, l.NoContractCarrier, r.NoContractCarrier);
    SELF.spid				 			 := IF(mostCurrent, l.spid, r.spid);
    // v--- Added next 13 lines for the 2021-06-02 Phone Porting Data for LE project
    SELF.ServiceProviderInfo.id            := IF(inMod.IncludePortingDetails and mostCurrent, l.ServiceProviderInfo.id, r.ServiceProviderInfo.id);
    SELF.ServiceProviderInfo.company       := IF(inMod.IncludePortingDetails and mostCurrent, l.ServiceProviderInfo.company, r.ServiceProviderInfo.company);
    SELF.ServiceProviderInfo.contact       := IF(inMod.IncludePortingDetails and mostCurrent, l.ServiceProviderInfo.contact, r.ServiceProviderInfo.contact);
    SELF.ServiceProviderInfo.contact_phone := IF(inMod.IncludePortingDetails and mostCurrent, l.ServiceProviderInfo.contact_phone, r.ServiceProviderInfo.contact_phone);
    SELF.DateOfChange 	                   := IF(inMod.IncludePortingDetails and mostCurrent, l.DateofChange, r.DateofChange);
    SELF.AltServiceProviderInfo.id            := IF(inMod.IncludePortingDetails and mostCurrent, l.AltServiceProviderInfo.id, r.AltServiceProviderInfo.id);
    SELF.AltServiceProviderInfo.company       := IF(inMod.IncludePortingDetails and mostCurrent, l.AltServiceProviderInfo.company, r.AltServiceProviderInfo.company);
    SELF.AltServiceProviderInfo.contact       := IF(inMod.IncludePortingDetails and mostCurrent, l.AltServiceProviderInfo.contact, r.AltServiceProviderInfo.contact);
    SELF.AltServiceProviderInfo.contact_phone := IF(inMod.IncludePortingDetails and mostCurrent, l.AltServiceProviderInfo.contact_phone, r.AltServiceProviderInfo.contact_phone);
    SELF.LastAltServiceProviderInfo.id            := IF(inMod.IncludePortingDetails and mostCurrent, l.LastAltServiceProviderInfo.Id, r.LastAltServiceProviderInfo.id);
    SELF.LastAltServiceProviderInfo.company       := IF(inMod.IncludePortingDetails and mostCurrent, l.LastAltServiceProviderInfo.company, r.LastAltServiceProviderInfo.company);
    SELF.LastAltServiceProviderInfo.contact       := IF(inMod.IncludePortingDetails and mostCurrent, l.LastAltServiceProviderInfo.contact, r.LastAltServiceProviderInfo.contact);
    SELF.LastAltServiceProviderInfo.contact_phone := IF(inMod.IncludePortingDetails and mostCurrent, l.LastAltServiceProviderInfo.contact_phone, r.LastAltServiceProviderInfo.contact_phone);
   SELF := l;
	END;

  // Should be rolled up on acctno, phone NOT acctno, did, phone
	dPortedDisconnectRolled		:= ROLLUP(SORT(transformPort, acctno, phone, FirstPortedDate=0, FirstPortedDate),
															LEFT.acctno = RIGHT.acctno AND
															LEFT.phone 	= RIGHT.phone,
															rollports(LEFT, RIGHT));

		//Final results joined with original dataset
	PhoneFinder_Services.Layouts.PhoneFinder.Final UpdatePhoneInfo(dSearchRecs0 l, dPortedDisconnectRolled r) := TRANSFORM
    hasPort := r.PortingCount > 0;
    // hasMetadata := l.phone=r.phone;
    SELF.PortingCode    := MAP(hasPort => 'Ported',
                                (NOT inMod.SubjectMetadataOnly OR l.isprimaryphone)=> 'Not Ported',
                                '');
    SELF.PortingCount    := IF(inMod.ReturnPortingInfo, r.PortingCount, l.PortingCount);
    SELF.PortingHistory  := IF(inMod.ReturnPortingInfo, CHOOSEN(SORT(DEDUP(r.PortingHistory, RECORD, ALL), -PortEndDate), PhoneFinder_Services.Constants.MaxPortedMatches), l.PortingHistory);
    SELF.FirstPortedDate := IF(inMod.ReturnPortingInfo, r.FirstPortedDate, l.FirstPortedDate);
    SELF.LastPortedDate  := IF(inMod.ReturnPortingInfo, r.LastPortedDate, l.LastPortedDate);
    SELF.NoContractCarrier  := IF(inMod.ReturnPortingInfo, r.NoContractCarrier, l.NoContractCarrier);
    SELF.Prepaid				 := IF(inMod.ReturnPortingInfo AND l.isprimaryphone, r.Prepaid, l.Prepaid); //Right has no information about other phones, also, prepaid info should only be shown for ReturnPortingInfo
    // deact_thresholdcheck := Std.Date.IsValidDate(r.DisconnectDate) AND (ut.DaysApart((STRING)r.DisconnectDate, currentDate) <= PhoneFinder_Services.Constants.PortingStatus.DisconnectedPhoneThreshold);
    SELF.PhoneStatus     :=  l.PhoneStatus;
    SELF.ActivationDate  := IF(l.PhoneStatus = PhoneFinder_Services.Constants.PhoneStatus.Active, r.ActivationDate, 0);
    SELF.DisconnectDate  := IF(l.PhoneStatus = PhoneFinder_Services.Constants.PhoneStatus.INACTIVE, r.DisconnectDate, 0);
    // Override TU data to use LIBD and Port data when available
    //Commenting out for now since we get this information in getPhonedetails
    // SELF.serviceType  	 := r.serviceType;
    // SELF.RealTimePhone_Ext.ServiceClass := IF(hasMetadata, (STRING)r.serviceType, l.RealTimePhone_Ext.ServiceClass);
    // SELF.COC_description := l.COC_description;
    SELF.PortingStatus   := '';
    // v--- Added next 13 lines for the 2021-06-02 Phone Porting Data for LE project
    SELF.ServiceProviderInfo.id            := IF(inMod.IncludePortingDetails, r.ServiceProviderInfo.id, l.ServiceProviderInfo.id);
    SELF.ServiceProviderInfo.company       := IF(inMod.IncludePortingDetails, r.ServiceProviderInfo.company, l.ServiceProviderInfo.company);
    SELF.ServiceProviderInfo.contact       := IF(inMod.IncludePortingDetails, r.ServiceProviderInfo.contact, l.ServiceProviderInfo.contact);
    SELF.ServiceProviderInfo.contact_phone := IF(inMOd.IncludePortingDetails, r.ServiceProviderInfo.contact_phone, l.ServiceProviderInfo.contact_phone);
    SELF.DateOfChange                      := IF(inMod.IncludePortingDetails, r.DateofChange, l.DateOfChange);
    SELF.AltServiceProviderInfo.id            := IF(inMod.IncludePortingDetails, r.AltServiceProviderInfo.id, l.AltServiceProviderInfo.id);
    SELF.AltServiceProviderInfo.company       := IF(inMod.IncludePortingDetails, r.AltServiceProviderInfo.company, l.AltServiceProviderInfo.company);
    SELF.AltServiceProviderInfo.contact       := IF(inMod.IncludePortingDetails, r.AltServiceProviderInfo.contact, l.AltServiceProviderInfo.contact);
    SELF.AltServiceProviderInfo.contact_phone := IF(inMod.IncludePortingDetails, r.AltServiceProviderInfo.contact_phone, l.AltServiceProviderInfo.contact_phone);
    SELF.LastAltServiceProviderInfo.id            := IF(inMod.IncludePortingDetails, r.LastAltServiceProviderInfo.id, l.LastAltServiceProviderInfo.id);
    SELF.LastAltServiceProviderInfo.company       := IF(inMod.IncludePortingDetails, r.LastAltServiceProviderInfo.company, l.LastAltServiceProviderInfo.company);
    SELF.LastAltServiceProviderInfo.contact       := IF(inMod.IncludePortingDetails, r.LastAltServiceProviderInfo.contact, l.LastAltServiceProviderInfo.contact);
    SELF.LastAltServiceProviderInfo.contact_phone := IF(inMod.IncludePortingDetails, r.LastAltServiceProviderInfo.contact_phone, l.LastAltServiceProviderInfo.contact_phone);
		/*
    // Temporarily remove until better disconnect data is obtained
    IF(r.DisconnectDate >= r.ActivationDate AND r.is_deact, PhoneFinder_Services.Constants.PhoneStatus.Inactive,
                                                                                    PhoneFinder_Services.Constants.PhoneStatus.Active);
    //override existing statuscode if porting data indicate phone is inactive to resolve conflicting report.
    updTURecs := SELF.PortingStatus = PhoneFinder_Services.Constants.PhoneStatus.Inactive;
    SELF.realtimephone_ext.statuscode := IF(updTURecs, PhoneFinder_Services.Constants.PhoneInactiveStatus, l.realtimephone_ext.statuscode);
    SELF.realtimephone_ext.statuscode_desc := IF(updTURecs, PhoneFinder_Services.Constants.PhoneStatus.Inactive, l.realtimephone_ext.statuscode_desc);
    SELF.realtimephone_ext.statuscode_flag := IF(updTURecs, '', l.realtimephone_ext.statuscode_flag);
    SELF.realtimephone_ext.statuscode_flagdesc := IF(updTURecs, '', l.realtimephone_ext.statuscode_flagdesc);
    */
    SELF := l;
    SELF := [];
	END;

	dPhoneMetadataWPorting := JOIN(dSearchRecs0, dPortedDisconnectRolled,
                                  LEFT.acctno	= RIGHT.acctno AND
                                  LEFT.phone 	= RIGHT.phone,
                                  UpdatePhoneInfo(LEFT, RIGHT),
                                  LEFT OUTER, KEEP(1),
                                  LIMIT(0));

  // ************************************************************************************************************************
  // v--- New section added for the 2021-06-02 Phone Porting Data for LE project
  // ****** Get the Iconectiv Elep gateway data (if requested via IncludePortingDetails (DPM[38] != 0/blank)  ****** 
  ds_iconectiv_elep_gwrecs := PhoneFinder_Services.GetIconectivElep_GatewayRecs(subjectInfo, inMod, dGateways);

  ds_subinfo_wgwporthist := IF(inMod.IncludePortingDetails, 
                               ds_iconectiv_elep_gwrecs,
                               DATASET([], PhoneFinder_Services.Layouts.SubPhone_Porting_Comb));

  // Once the iconectiv_elep gateway data is retrieved and put into the correct record layout, the PortingHistory 
  // child dataset recs (if they exist), will need to be used to replace the in-house/etc. ones for each acctno/phone#
  //
  // If at least 1 iconectiv_elep gw portinghistory record exists, replace the dPhoneMetadataWPorting.PortingHistory recs 
  // with the gateway PortingHistory recs for each acctno/phone#
  PhoneFinder_Services.Layouts.PhoneFinder.Final tf_replace_PortingHistory(dPhoneMetadataWPorting L, 
                                                                           ds_subinfo_wgwporthist R) := TRANSFORM

    SELF.PortingHistory := IF(EXISTS(R.PortingHistory) AND R.portingcount > 0,
                              R.PortingHistory,  // use R/gateway response
                              L.PortingHistory); // else keep L/in-house rolled                          
    SELF := L; //keep rest of fieds from L/in-house rolled
  END;
  
  dPhoneMetadataWPorting_and_gwphrecs := JOIN(dPhoneMetadataWPorting, 
                                              ds_subinfo_wgwporthist, 
                                                LEFT.acctno = RIGHT.acctno AND
                                                LEFT.phone  = RIGHT.phone, 
                                              tf_replace_PortingHistory(LEFT, RIGHT),
                                              LEFT OUTER, //keep all recs from left ds even if no match to right
                                              KEEP(1),
                                              LIMIT(0) 
                                             );

  // Only use PhoneMetadata with porting and iconectiv_elep gateway port history recs if IncludePortingDetails/DPM[38] != 0/blank
  ds_PhoneMetadataWPorting_ret := IF(inMod.IncludePortingDetails,
                                     dPhoneMetadataWPorting_and_gwphrecs, 
                                     dPhoneMetadataWPorting);
  // ^--- end of new section coding added for the 'Phone Porting Data for LE' project

  #IF(PhoneFinder_Services.Constants.Debug.PhoneMetadata)
	    OUTPUT(dPorted, NAMED('dPorted'));
	    OUTPUT(dDeltabasePorted, NAMED('dDeltabasePorted'));
	    OUTPUT(dPortedInfo, NAMED('dPortedInfo'));
	    OUTPUT(dPortedPhones, NAMED('dPortedPhones_getportedmetadata'));
		   OUTPUT(transformPort, NAMED('transformPort'));
		   OUTPUT(dPortedDisconnectRolled, NAMED('dPortedDisconnectRolled'));
	    OUTPUT(dphonemetadataWPorting, NAMED('dphonemetadataWPorting'));
	#END;

  // v---- Added separately for the 'Phone porting Data for LE' project, since too many to add to Outputs above and need
  // to be able to uncomment/comment out each one as needed for debug testing.
  //OUTPUT(dSearchRecs0,                 NAMED('gppmd_dSearchRecs0'));
  //OUTPUT(subjectInfo,                  NAMED('gppmd_subjectInfo'));
  //OUTPUT(inMod.AllowPortingData,       NAMED('gppmd_inmod_allowportingdata'));
  //OUTPUT(inMod.ReturnPortingInfo,      NAMED('gppmd_inmod_returnportinginfo'));
  //OUTPUT(inMod.IncludePortingDetails,  NAMED('gppmd_inmod_includeportingdetails'));
  //OUTPUT(dsPhonesmetadata,             NAMED('gppmd_dsPhonesmetadata'));
  //OUTPUT(dPorted,                      NAMED('gppmd_dPorted'));
  //OUTPUT(dDeltabasewSubject,           NAMED('gppmd_dDeltabasewSubject'));
  //OUTPUT(dAccudata,                    NAMED('gppmd_dAccudata'));
  //OUTPUT(ds_all_ported_concat,         NAMED('gppmd_ds_all_ported_concat'));
  //OUTPUT(ds_apc_combplus_lo,           NAMED('gppmd_ds_apc_combplus_lo'));
  //OUTPUT(ds_apc_cpl_normed,            NAMED('gppmd_ds_apc_cpl_normed'));
  //OUTPUT(ds_apc_cpln_deduped,          NAMED('gppmd_ds_apc_cpln_deduped'));
  //OUTPUT(ds_apc_cplndd_wkeydata,       NAMED('gppmd_ds_apc_cpln_wkeydata'));
  //OUTPUT(ds_apc_cplndd_wkd_rolled,     NAMED('gppmd_ds_apc_cpln_wkd_rolled'));
  //OUTPUT(ds_apc_cpl_normed_wkeydata,   NAMED('gppmd_ds_apc_cpl_normed_wkeydata'));
  //OUTPUT(ds_all_ported_cc_wspinfo,     NAMED('gppmd_ds_all_ported_cc_wspinfo'));
  //OUTPUT(ds_all_ported_cc_to_use,      NAMED('gppmd_ds_all_ported_cc_to_use'));
  //OUTPUT(dPortedPhones,                NAMED('gppmd_dPortedPhones'));
  //OUTPUT(sortedPorts,                  NAMED('gppmd_sortedPorts'));
  //OUTPUT(dPorts,                       NAMED('gppmd_dPorts')); 
  //OTUPUT(dDisconnects,                 NAMED('gppmd_dDisconnects'));
  //OUTPUT(dPortedInfo,                  NAMED('gppmd_dPortedInfo'));
  //OUTPUT(transformPort,                NAMED('gppmd_transformPort'));
  //OUTPUT(dPortedDisconnectRolled,      NAMED('gppmd_dPortedDisconnectRolled'));
  //OUTPUT(dphonemetadataWPorting,       NAMED('gppmd_dphonemetadataWPorting'));
  //OUTPUT(ds_iconectiv_elep_gwrecs,     NAMED('gppmd_ds_iconectiv_elep_gwrecs'));
  //OUTPUT(ds_subinfo_wgwporthist,       NAMED('gppmd_ds_subinfo_wgwporthist'));
  //OUTPUT(dPhoneMetadataWPorting_and_gwphrecs, NAMED('gppmd_dphonemetadataWPorting_and_gwphrecs'));
  //OUTPUT(ds_PhoneMetadataWPorting_ret, NAMED('gppmd_ds_phonemetadataWPorting_ret'));

	RETURN ds_PhoneMetadataWPorting_ret; // Revised for the 2021-06-02 Phone Porting Data for LE project

END;