IMPORT BIPV2, BIPV2_Best, BIPV2_Contacts, doxie_cbrs, Corp2, Corp2_services, MDR, doxie, ut, iesp, AutoStandardI, STD;
EXPORT Raw := MODULE
  SHARED mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  SHARED makeBusinessIds_BIP(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in) := FUNCTION
    bip_ids := project(ds_in,
      TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
        SELF.proxweight := 0;
        SELF.proxscore := 0;
        SELF.seleweight := 0;
        SELF.selescore := 0;
        SELF.ultscore := 0;
        SELF.ultweight := 0;
        SELF.dotscore := 0;
        SELF.dotweight := 0;
        SELF.orgscore := 0;
        SELF.orgweight := 0;
        SELF.powscore := 0;
        SELF.powweight := 0;
        SELF.empscore := 0;
        SELF.empweight := 0;
        SELF := LEFT,
      ));
    RETURN bip_ids;
  END;

  SHARED getBusinessHeaderBest_BIP(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                                   BusinessContactCard.IParam.options in_mod) := FUNCTION
    bip_ids := makeBusinessIds_BIP(ds_in);

    FETCH_LEVEL := in_mod.BusinessReportFetchLevel;
    SELEID_FILTER := FETCH_LEVEL in [BIPV2.IDconstants.Fetch_Level_UltID, BIPV2.IDconstants.Fetch_Level_OrgID, BIPV2.IDconstants.Fetch_Level_SELEID];
    
    ds_businessHeader_raw := BIPV2_Best.Key_LinkIds.KFetch2(bip_ids,FETCH_LEVEL);
    ds_businessHeader := IF(SELEID_FILTER, ds_businessHeader_raw(proxid = 0), ds_businessHeader_raw);
    
    ds_businessHeader_best:= JOIN(ds_in, ds_businessHeader,
      LEFT.ultid = RIGHT.ultid AND
      LEFT.orgid = RIGHT.orgid AND
      LEFT.seleid = RIGHT.seleid,
      TRANSFORM(BusinessContactCard.Layouts.rec_company_best,
        company_name := RIGHT.company_name[1];
        company_address := RIGHT.company_address[1];
        company_phone := RIGHT.company_phone[1];
        company_fein := RIGHT.company_fein[1];
        SELF.acctno := LEFT.acctno,
        SELF.bdid := RIGHT.company_bdid,
        SELF.company_name := company_name.company_name,
        SELF.dt_last_seen := (STRING)company_name.dt_last_seen,
        SELF.prim_range := company_address.company_prim_range,
        SELF.predir := company_address.company_predir,
        SELF.prim_name := company_address.company_prim_name,
        SELF.addr_suffix := company_address.company_addr_suffix,
        SELF.postdir := company_address.company_postdir,
        SELF.unit_desig := company_address.company_unit_desig,
        SELF.sec_range := company_address.company_sec_range,
        SELF.city := company_address.address_v_city_name,
        SELF.state := company_address.company_st,
        SELF.zip := company_address.company_zip5,
        SELF.zip4 := company_address.company_zip4,
        SELF.county_name := company_address.county_name,
        SELF.phone := company_phone.company_phone,
        SELF.fein := company_fein.company_fein,
        SELF := LEFT, //BIP ids
        SELF := [] //fromdca, best_flags, isCurrent, hasBBB, level, msaDesc, msa
        ),
      LIMIT(0), KEEP(1));

    RETURN ds_businessHeader_best;
  END;

  SHARED getBusinessHeaderBest_BDID(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in) := FUNCTION
    
    FOR_SUBJECT_COMPANY := false;
    just_bdids := DEDUP(SORT( PROJECT(ds_in, doxie_cbrs.layout_references), bdid ), bdid);
    ds_businessHeader := doxie_cbrs.fn_best_information(just_bdids,FOR_SUBJECT_COMPANY);
    
    ds_businessHeader_best := JOIN(ds_in, ds_businessHeader,
      LEFT.group_id = (UNSIGNED6)RIGHT.bdid,
      TRANSFORM(BusinessContactCard.Layouts.rec_company_best,
        SELF.acctno := LEFT.acctno,
        SELF.bdid := (UNSIGNED6)RIGHT.bdid,
        SELF.group_id := LEFT.group_id,
        SELF := RIGHT),
    LIMIT(0), KEEP(1));

    RETURN ds_businessHeader_best;
  END;

  EXPORT getBusinessHeaderBest(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                               BusinessContactCard.IParam.options in_mod) := FUNCTION
    ds_businessHeaderBest_BIP := getBusinessHeaderBest_BIP(ds_in, in_mod);
    ds_businessHeaderBest_BDID := getBusinessHeaderBest_BDID(ds_in);
    ds_businessHeaderBest_raw := IF(in_mod.isBIPReport, ds_businessHeaderBest_BIP, ds_businessHeaderBest_BDID);
    ds_BusinessHeaderBest := DEDUP(SORT(ds_businessHeaderBest_raw, record), record);
    // output(ds_businessHeaderBest_BIP, named('ds_businessHeaderBest_BIP'));
    // output(ds_businessHeaderBest_BDID, named('ds_businessHeaderBest_BDID'));
    RETURN ds_businessHeaderBest;
  END;

  SHARED getCorpRecords_BIP(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                           BusinessContactCard.IParam.options in_mod) := FUNCTION
    bip_ids := makeBusinessIds_BIP(ds_in);
    FETCH_LEVEL := in_mod.BusinessReportFetchLevel;
    ds_corpRecords := JOIN(ds_in, Corp2.Key_Linkids.Corp.kFetch2(bip_ids,FETCH_LEVEL),
      LEFT.ultid = RIGHT.ultid AND
      LEFT.orgid = RIGHT.orgid AND
      LEFT.seleid = RIGHT.seleid,
      TRANSFORM(BusinessContactCard.Layouts.rec_corp,
        SELF.corp_status_desc := RIGHT.corp_status_desc,
        SELF.corp_status_date := RIGHT.corp_status_date,
        SELF := LEFT),
      LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CORP2_PER_REC_BIP));
    RETURN ds_corpRecords;
  END;

  SHARED getCorpRecords_BDID(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in) := FUNCTION
    acctnos_bdids := DEDUP(SORT( PROJECT(ds_in, doxie_cbrs.layout_references_acctno), acctno, bdid ), acctno, bdid);

    ds_corp_keys := Corp2_services.corp2_raw.get_corpkeys_from_bdids_batch(acctnos_bdids);

    grouped_in_corpkeys := GROUP(SORT(ds_corp_keys, corp_key), corp_key);

    ds_corpRecs_raw := JOIN(grouped_in_corpkeys, corp2.Key_Corp_corpkey,
      KEYED(RIGHT.corp_key = LEFT.corp_key),
      TRANSFORM( RECORDOF(corp2.Key_Corp_corpkey), SELF := RIGHT, SELF := []),
      LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CORP2_PER_REC_BDID));

    ds_corpRecords := JOIN(ds_corp_keys, ds_corpRecs_raw,
      LEFT.corp_key = RIGHT.corp_key,
      TRANSFORM(BusinessContactCard.Layouts.rec_corp,
        SELF.corp_status_desc := RIGHT.corp_status_desc,
        SELF.corp_status_date := RIGHT.corp_status_date,
        SELF := LEFT),
      LEFT OUTER,
      LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CORP2_PER_REC_BDID));
    RETURN ds_corpRecords;
  END;

  EXPORT getCorpRecords(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                        BusinessContactCard.IParam.options in_mod) := FUNCTION
    ds_corpRecords_BIP := getCorpRecords_BIP(ds_in, in_mod);
    ds_corpRecords_BDID := getCorpRecords_BDID(ds_in);
    ds_corpRecords_raw := IF(in_mod.isBIPReport, ds_corpRecords_BIP, ds_corpRecords_BDID);
    ds_corpRecords := DEDUP(SORT(ds_corpRecords_raw, acctno, -corp_status_date), acctno);
    // output(ds_corpRecords_BIP, named('ds_corpRecords_BIP'));
    // output(ds_corpRecords_BDID, named('ds_corpRecords_BDID'));
    RETURN ds_corpRecords;
  END;

  SHARED getBusinessHeaderParentRecord_BIP(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                                           BusinessContactCard.IParam.options in_mod) := FUNCTION
    FETCH_LEVEL := in_mod.BusinessReportFetchLevel;
    
    BusinessContactCard.Layouts.rec_company_best xformBIPParentRec(ds_in in_rec) := TRANSFORM
      bip_ids := makeBusinessIds_BIP(DATASET(in_rec));
      ds_busHeaderRecs := BIPV2.Key_BH_Linking_Ids.kfetch2(bip_ids, FETCH_LEVEL,,,,,,,, mod_access);
      dsUltlinkIDInfo := DEDUP(SORT(project(ds_BusHeaderRecs(ParentAboveSELE = true),
        TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
          SELF.ultid := 0;
          SELF.orgid := 0;
          SELF.seleid := 0;// not sure what to put here.
          SELF.proxid := LEFT.ultimate_proxid;
          SELF.powid := 0;
          SELF.empid := 0;
          SELF.dotid := 0;
          SELF := [];
          )),
      proxid), proxid);

      // SPECIFICALLY use the ProxID level fetch here since we want a specific parent
      // for a particular proxid
      ds_parentRecord_raw := IF(EXISTS(dsUltlinkIDInfo), BIPV2_Best.Key_LinkIds.kfetch(dsUltlinkIDInfo, BIPV2.IDconstants.Fetch_Level_PROXID,,,false))[1];
      company_name := ds_parentRecord_raw.company_name[1];
      company_address := ds_parentRecord_raw.company_address[1];
      company_phone := ds_parentRecord_raw.company_phone[1];
      company_fein := ds_parentRecord_raw.company_fein[1];
      SELF.acctno := in_rec.acctno,
      SELF.parent_ids.bdid := ds_parentRecord_raw.company_bdid,
      SELF.parent_ids.proxid := ds_parentRecord_raw.proxid,
      SELF.parent_ids.ultid := ds_parentRecord_raw.ultid,
      SELF.parent_ids.orgid := ds_parentRecord_raw.orgid,
      SELF.parent_ids.seleid := ds_parentRecord_raw.seleid,
      SELF.parent_ids.dotid := ds_parentRecord_raw.dotid,
      SELF.parent_ids.empid := ds_parentRecord_raw.empid,
      SELF.parent_ids.powid := ds_parentRecord_raw.powid,
      SELF.company_name := company_name.company_name,
      SELF.dt_last_seen := (STRING)company_name.dt_last_seen,
      SELF.prim_range := company_address.company_prim_range,
      SELF.predir := company_address.company_predir,
      SELF.prim_name := company_address.company_prim_name,
      SELF.addr_suffix := company_address.company_addr_suffix,
      SELF.postdir := company_address.company_postdir,
      SELF.unit_desig := company_address.company_unit_desig,
      SELF.sec_range := company_address.company_sec_range,
      SELF.city := company_address.address_v_city_name,
      SELF.state := company_address.company_st,
      SELF.zip := company_address.company_zip5,
      SELF.zip4 := company_address.company_zip4,
      SELF.county_name := company_address.county_name,
      SELF.phone := company_phone.company_phone,
      SELF.fein := company_fein.company_fein,
      SELF := in_rec, //BIP ids
      SELF := [] //fromdca, best_flags, isCurrent, hasBBB, level, msaDesc, msa
    END;
    ds_parentRecord := project(ds_in, xformBIPParentRec(LEFT));
    RETURN ds_parentRecord;
  END;

  SHARED getBusinessHeaderParentRecord_BDID(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in) := FUNCTION
    //equivalent of doxie_cbrs.ultimate_parent_information() without needing to call Business_Header.Key_BH_SuperGroup_BDID again since we already have the groupid
    bdids := CHOOSEN(DEDUP(SORT(ds_in, bdid), bdid),1);
    just_bdids := PROJECT(bdids, TRANSFORM(doxie_cbrs.layout_references,
                                                          SELF.bdid := LEFT.group_id));
    ds_parentRecord_raw := CHOOSEN(JOIN(just_bdids,doxie_cbrs.fn_best_information(just_bdids,true),LEFT.bdid=(UNSIGNED6)RIGHT.bdid),1);
    ds_ParentRecord := JOIN(ds_in, ds_parentRecord_raw,
      LEFT.group_id = (UNSIGNED6)RIGHT.bdid,
      TRANSFORM(BusinessContactCard.Layouts.rec_company_best,
        SELF.acctno := LEFT.acctno;
        SELF.bdid := (UNSIGNED6)RIGHT.bdid;
        SELF.group_id := LEFT.group_id;
        SELF.parent_ids.bdid := LEFT.group_id;
        SELF := RIGHT),
      LIMIT(0), KEEP(1));
    RETURN ds_ParentRecord;
  END;

  EXPORT getBusinessHeaderParentRecord(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                                      BusinessContactCard.IParam.options in_mod) := FUNCTION
    ds_parentRecord_BIP := getBusinessHeaderParentRecord_BIP(ds_in, in_mod);
    ds_parentRecord_BDID := getBusinessHeaderParentRecord_BDID(ds_in);
    ds_parentRecord_Raw := IF(in_mod.isBIPReport, ds_parentRecord_BIP, ds_parentRecord_BDID);
    ds_parentRecord := DEDUP(SORT(ds_parentRecord_Raw, record), record);
    // output(ds_parentRecord_BIP, named('ds_parentRecord_BIP'));
    // output(ds_parentRecord_BDID, named('ds_parentRecord_BDID'));
    RETURN ds_parentRecord;
  END;

  SHARED getPhoneVariationsRecords_BIP(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                                       BusinessContactCard.IParam.options in_mod) := FUNCTION
    FETCH_LEVEL := in_mod.BusinessReportFetchLevel;
    bip_ids := makeBusinessIds_BIP(ds_in);
    ds_busHeaderRecs := BIPV2.Key_BH_Linking_Ids.kfetch2(bip_ids, FETCH_LEVEL,,,,,,,, mod_access)(NOT MDR.sourceTools.SourceIsEBR(source) OR NOT doxie.DataRestriction.EBR);
    
    ds_phoneVariations_raw := JOIN(ds_in, ds_busHeaderRecs(company_phone <>''),
      LEFT.ultid = RIGHT.ultid AND
      LEFT.orgid = RIGHT.orgid AND
      LEFT.seleid = RIGHT.seleid,
      TRANSFORM(BusinessContactCard.Layouts.rec_phone_variations_normalized,
        SELF.phone := RIGHT.company_phone,
        SELF := LEFT),
      LIMIT(0), KEEP(iesp.constants.BR.MaxPhones));
    ds_phoneVariations := DEDUP(SORT(ds_phoneVariations_raw, acctno, phone), acctno, phone);
    
    RETURN ds_phoneVariations;
  END;

  SHARED getPhoneVariationsRecords_BDID(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in) := FUNCTION
    get_phone_variations(UNSIGNED6 unique_id) := FUNCTION
      ds_phone_variations := doxie_cbrs.phone_variations_base( DATASET( [{unique_id}], doxie_cbrs.layout_references ) ).records;
      RETURN PROJECT(ds_phone_variations, BusinessContactCard.Layouts.rec_phones);
    END;
    
    ds_phoneVariations_raw := PROJECT(ds_in, TRANSFORM(BusinessContactCard.Layouts.rec_phone_variations,
      SELF.phones := CHOOSEN(get_phone_variations(LEFT.bdid), iesp.constants.BR.MaxPhones);
      SELF := LEFT));
    
    ds_phoneVariations := NORMALIZE(ds_phoneVariations_raw, LEFT.phones,
      TRANSFORM(BusinessContactCard.Layouts.rec_phone_variations_normalized,
        SELF := LEFT;
        SELF := RIGHT));
    
    RETURN ds_phoneVariations;
  
  END;

  EXPORT getPhoneVariationsRecords(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                                   BusinessContactCard.IParam.options in_mod) := FUNCTION
    ds_phoneVariationsRecords_BIP := getPhoneVariationsRecords_BIP(ds_in, in_mod);
    ds_phoneVariationsRecords_BDID:= getPhoneVariationsRecords_BDID(ds_in);
    ds_phoneVariationsRecords := IF(in_mod.isBIPReport, ds_phoneVariationsRecords_BIP, ds_phoneVariationsRecords_BDID);
    // output(ds_phoneVariationsRecords_BIP, named('ds_phoneVariationsRecords_BIP'));
    // output(ds_phoneVariationsRecords_BDID, named('ds_phoneVariationsRecords_BDID'));
    RETURN ds_phoneVariationsRecords;
  END;

  SHARED getBusinessHeaderContact_BIP(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                                      BusinessContactCard.IParam.options in_mod) := FUNCTION
    bip_ids := makeBusinessIds_BIP(ds_in);
    FETCH_LEVEL := in_mod.BusinessReportFetchLevel;
    STRING8 CurDate := (STRING8) STD.Date.Today();
    
    ds_businessHeaderContact_raw := BIPV2_Contacts.key_contact_linkids.kFetch(bip_ids, FETCH_LEVEL,,,,,mod_access)
      (current OR
      ((UNSIGNED4) dt_last_seen_contact <> 0 AND
      (UNSIGNED4) dt_last_seen_contact >= (UNSIGNED4) ut.DateFrom_DaysSince1900(ut.DaysSince1900(CurDate[1..4], CurDate[5..6], CurDate[7..8]) - (INTEGER)'730')));
    
    BusinessContactCard.Layouts.rec_contact xformContact(BusinessContactCard.Layouts.rec_ids_in L, ds_businessHeaderContact_raw R) := TRANSFORM
      SELF.did := R.contact_did;
      SELF.record_type := ''; //no equivalent in BIP?
      SELF.company_title:= R.contact_job_title_derived;
      SELF.title := R.contact_name.title;
      SELF.fname := R.contact_name.fname;
      SELF.mname := R.contact_name.mname;
      SELF.lname := R.contact_name.lname;
      SELF.name_suffix := R.contact_name.name_suffix;
      SELF.name_score := R.contact_name.name_score;
      SELF.ssn := R.contact_ssn;
      SELF.prim_range := R.company_address.prim_range;
      SELF.predir := R.company_address.predir;
      SELF.prim_name := R.company_address.prim_name;
      SELF.addr_suffix := R.company_address.addr_suffix;
      SELF.postdir := R.company_address.postdir;
      SELF.unit_desig := R.company_address.unit_desig;
      SELF.sec_range := R.company_address.sec_range;
      SELF.city := R.company_address.v_city_name;
      SELF.state := R.company_address.st;
      SELF.zip := (INTEGER)R.company_address.zip;
      SELF.zip4 := (INTEGER)R.company_address.zip4;
      SELF.county := '';//L.company_address.fips_county;
      SELF.geo_lat := R.company_address.geo_lat;
      SELF.geo_long := R.company_address.geo_long;
      SELF.phone := IF(R.company_phone <> '', (INTEGER)R.company_phone, (INTEGER)R.contact_phone);
      SELF.email_address:= R.contact_email;
      SELF.title_rank := 0;
      SELF.is_exec := false;
      SELF := L;//acctno, BIP ids
      SELF := R;// dt_first_seen, dt_last_seen, source, from_hdr, company_department
    END;
    ds_businessHeaderContact_acctno := JOIN(ds_in, ds_businessHeaderContact_raw,
      LEFT.ultid = RIGHT.ultid AND
      LEFT.orgid = RIGHT.orgid AND
      LEFT.seleid = RIGHT.seleid,
      xformContact(LEFT, RIGHT),
      LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CONTACTS_PER_REC));

    ds_businessHeaderContact := DEDUP(SORT(ds_businessHeaderContact_acctno(did != 0), ultid, orgid, seleid, did, -dt_last_seen), ultid, orgid, seleid, did);
    // output(ds_businessHeaderContact_raw, named('ds_businessHeaderContact_raw'));
    // output(ds_businessHeaderContact, named('ds_businessHeaderContact'));
    RETURN ds_businessHeaderContact;
  END;

  SHARED getBusinessHeaderContact_BDID(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in) := FUNCTION
    
    CURRENT := 'C';
    just_bdids := DEDUP(SORT( PROJECT(ds_in, doxie_cbrs.layout_references), bdid ), bdid);
    ds_businessHeaderContact_raw := doxie_cbrs.contact_records(just_bdids)(record_type = CURRENT AND TRIM(lname) != ''); //doxie_cbrs.layout_contacts
    ds_businessHeaderContact_acctno := JOIN( ds_in, ds_businessHeaderContact_raw,
      LEFT.bdid = (UNSIGNED6)RIGHT.bdid,
      TRANSFORM(BusinessContactCard.Layouts.rec_contact,
        SELF := LEFT; //acctno, ids
        SELF := RIGHT;
        SELF.title_rank := 0;
        SELF.is_exec := false),
      LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CONTACTS_PER_REC));

    ds_businessHeaderContact := DEDUP(SORT(ds_businessHeaderContact_acctno(did != 0), bdid, did, -dt_last_seen), bdid, did);
    RETURN ds_businessHeaderContact;
  END;

  EXPORT getBusinessHeaderContacts(DATASET(BusinessContactCard.Layouts.rec_ids_in) ds_in,
                                   BusinessContactCard.IParam.options in_mod) := FUNCTION
    // Go get the Contacts records.
    // Note that the 'same' Contact may be retrieved, as he/she may be a Contact for more than one business.
    // Dedup and sort will need to be handled by the caller
    ds_businessHeaderContact_BIP := getBusinessHeaderContact_BIP(ds_in, in_mod);
    ds_businessHeaderContact_BDID := getBusinessHeaderContact_BDID(ds_in);
    ds_businessHeaderContact := IF(in_mod.isBIPReport, ds_businessHeaderContact_BIP, ds_businessHeaderContact_BDID);
    // output(ds_businessHeaderContact_BIP, named('ds_businessHeaderContact_BIP'));
    // output(ds_businessHeaderContact_BDID, named('ds_businessHeaderContact_BDID'));
    RETURN ds_businessHeaderContact;
  END;

END;
