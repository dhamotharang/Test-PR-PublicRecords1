
IMPORT Address, AutoStandardI, Doxie, iesp, PhonesFeedback_Services, Business_Header;

EXPORT ReportView(DATASET(iesp.businesscontactcardreport.t_BCCReportBy) input_rec,
                  BusinessContactCard.IParam.options in_mod) := FUNCTION

  mod_access := PROJECT(in_mod, Doxie.IDataAccess);
  // ==================== Local constants and variables. ====================
  EMPTY_PHONESPLUS := DATASET([],BusinessContactCard.Layouts.rec_BCCPhonesPlusRecordWithFeedback_acctno);
  EMPTY_PHONES_FEEDBACK := DATASET([],PhonesFeedback_Services.Layouts.feedback_report);

  include_phones_plus := in_mod.IncludePhonesPlus;
  include_phones_feedback := in_mod.IncludePhonesFeedback;


  // ==================== Find all BDIDs. ====================
  //

  // Since the Service interface must accept (a) a single BDID, (b) a list of many BDIDs,
  // or (c) a group_id, we need to derive a list of all possible BDIDs given the input.
  mod_bdid := MODULE
    EXPORT STRING bdid := (STRING)input_rec[1].BusinessId;
    EXPORT STRING bdl := '';
    EXPORT BOOLEAN useSupergroup := in_mod.useSupergroup;
    EXPORT BOOLEAN useLevels := in_mod.useLevels;
  END;

  tempmod1 := MODULE( PROJECT(mod_bdid, AutoStandardI.InterfaceTranslator.bdid_dataset.params, OPT) )
    END;

  tempmod2 := MODULE( PROJECT(mod_bdid, AutoStandardI.InterfaceTranslator.multiBDID.params, OPT) )
    END;

  // NOTE: ds_bdids will contain zero to many bdids. IT IS ASSUMED that ds_bdids contains all
  // bdids that have been resolved from a group_id if such is supplied by the consuming attribute.
  ds_bdids := AutoStandardI.InterfaceTranslator.bdid_dataset.val(tempmod1);

  is_multiBDID := AutoStandardI.InterfaceTranslator.multiBDID.val(tempmod2);
  getParentRecord := is_multiBDID or in_mod.isBIPReport;//(in_mod.isBIPReport and input_rec[1].BusinessIds.proxid <> 0);

  ds_search_ids_bip := PROJECT(input_rec, TRANSFORM(BusinessContactCard.Layouts.rec_ids_in,
    SELF.acctno := '1';
    SELF.bdid := 0;
    SELF.group_id := 0;
    SELF := LEFT.BusinessIds));//BIP ids

  ds_search_ids_bdid := JOIN(ds_bdids, Business_Header.Key_BH_SuperGroup_BDID,
    KEYED(LEFT.bdid = RIGHT.bdid),
    TRANSFORM(BusinessContactCard.Layouts.rec_ids_in,
      SELF.acctno := '1';
      SELF.bdid := (UNSIGNED6)LEFT.bdid;
      SELF.group_id := (UNSIGNED6)RIGHT.group_id;
      SELF := []//BIP ids
    ),
    LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_GROUPID_PER_BDID));

  ds_search_ids := IF(in_mod.isBIPReport, ds_search_ids_bip, ds_search_ids_bdid);

  // | | | | | | | | | | Instantiate Business Contact Card. | | | | | | | | | |
  // V V V V V V V V V V                                    V V V V V V V V V V

  pr := BusinessContactCard.ProductRecords;
  companyRecords := pr.companyRecords(ds_search_ids, in_mod);
  phoneVariationsRecords := pr.phoneVariationsRecords(ds_search_ids, in_mod);
  parentsRecords := pr.parentsRecords(ds_search_ids, in_mod);
  contactRecords_raw := BusinessContactCard.Raw.getBusinessHeaderContacts(ds_search_ids, in_mod);
  contactsRecords := pr.contactsRecords(contactRecords_raw, in_mod);
  contactRecords_did := PROJECT(contactRecords_raw, BusinessContactCard.Layouts.rec_ids_did_in);
  contactDidRecords_BDID := DEDUP(SORT(contactRecords_did, acctno, group_id, did), acctno, group_id, did);
  contactDidRecords_BIP := DEDUP(SORT(contactRecords_did, acctno, ultid, orgid, seleid, did), acctno, ultid, orgid, seleid, did);
  contactDidRecords := IF(in_mod.isBIPReport, contactDidRecords_BIP, contactDidRecords_BDID);
  gongRecords := pr.gongRecords(contactDidRecords, mod_access);
  phonesPlusRecords := pr.phonesPlusRecords(contactDidRecords);

  // Build the output result, which will consist of three sections:
  // (1) The Subject Company
  // (2) the Execs/Owners/Associates associated with the Subject Company
  // (3) the Parent Company.
  //
  // Begin constructing our output dataset using the subject company (joined to phone variations)
  // as the seed. Then, attach the Parent Company. Finally, attach the Contacts,
  // i.e. Execs/Owners/Associates. But, Contacts must be joined first to their associated EDA/Gong
  // and PhonesPlus records; and, these phone records must first be joined to any PhonesFeedback records.

  // 1. Project Subject Company records into the output layout for that particular section
  // of the report.
  subj_company :=
      PROJECT(companyRecords,
        TRANSFORM(BusinessContactCard.Layouts.rec_BCCSubject_acctno,
          SELF.acctno := LEFT.acctno,
          SELF.businessid := (STRING)LEFT.bdid,
          SELF.businessIDs.proxid := LEFT.proxid;
          SELF.businessIDs.dotid := LEFT.dotid;
          SELF.businessIDs.powid := LEFT.powid;
          SELF.businessIDs.seleid := LEFT.seleid;
          SELF.businessIDs.empid := LEFT.empid;
          SELF.businessIDs.ultid := LEFT.ultid;
          SELF.businessIDs.orgid := LEFT.orgid;
          SELF.companyname := LEFT.company_name,
          SELF.fein := LEFT.fein,
          SELF.status := LEFT.corp_status_desc,
          SELF.address.streetname := LEFT.prim_name,
          SELF.address.streetnumber := LEFT.prim_range,
          SELF.address.streetpredirection := LEFT.predir,
          SELF.address.streetpostdirection := LEFT.postdir,
          SELF.address.streetsuffix := LEFT.addr_suffix,
          SELF.address.unitdesignation := LEFT.unit_desig,
          SELF.address.unitnumber := LEFT.sec_range,
          SELF.address.streetaddress1 := BusinessContactCard.Functions.get_addr1(LEFT),
          SELF.address.streetaddress2 := BusinessContactCard.Functions.get_addr2(LEFT),
          SELF.address.state := LEFT.state,
          SELF.address.city := LEFT.city,
          SELF.address.zip5 := LEFT.zip,
          SELF.address.zip4 := LEFT.zip4,
          SELF.address.county := LEFT.county_name,
          SELF.address.postalcode := '',
          SELF.address.statecityzip := BusinessContactCard.Functions.get_addr2(LEFT),
          SELF := []));

  // ... Join phone variations to the subject company. Dedup in spite of bdid, because we want all phones
  // deduped regardless of whether there's more than one BDID or not. We want the best company phone number
  // to appear at the top of the list of company phone variations, so we need to grab it from pr.companies
  // and work it into the list.

  rec_phone_variations := RECORD
    BusinessContactCard.Layouts.rec_phone_variations_normalized;
    BOOLEAN is_best := FALSE;
  END;

  company_best_phones :=
    PROJECT(
      companyRecords,
      TRANSFORM(rec_phone_variations,
        SELF.is_best := TRUE,
        SELF := LEFT,
        SELF := [])
    );

  phone_variations :=
    PROJECT(
      phoneVariationsRecords,
      TRANSFORM(rec_phone_variations,
        SELF.is_best := FALSE,
        SELF := LEFT,
        SELF := [])
    );

  all_phones := company_best_phones + phone_variations;

  // Sort and dedup to remove duplicate 'best' phone listed in variations.
  all_phones_deduped := DEDUP(SORT(all_phones, acctno, phone, -is_best), acctno, phone);

  // Resort to place 'best' phone on top.
  all_phones_grouped := GROUP(SORT(all_phones_deduped, acctno, -is_best, phone), acctno);

  BusinessContactCard.Layouts.rec_phone_variations rollupPhoneVars(rec_phone_variations l, DATASET(rec_phone_variations) allRows) :=
    TRANSFORM
      SELF.phones := CHOOSEN( PROJECT(allRows, TRANSFORM(BusinessContactCard.Layouts.rec_phones, SELF := LEFT)), iesp.constants.BR.MaxPhones );
      SELF := l;
    END;

  phone_variations_rolled := ROLLUP(all_phones_grouped, GROUP, rollupPhoneVars(LEFT,ROWS(LEFT)));

  company_with_phone_variations :=
    JOIN(subj_company, phone_variations_rolled,
      LEFT.acctno = RIGHT.acctno
      // and LEFT.bdid = RIGHT.bdid //TODO: remove this condition later?
      ,
      TRANSFORM(BusinessContactCard.Layouts.rec_BCCSubject_acctno,
        SELF.phones :=
          PROJECT(RIGHT.phones,
            TRANSFORM(iesp.share.t_PhoneInfo,
              SELF.phone10 := LEFT.phone,
              SELF := [])),
        SELF := LEFT),
      LEFT OUTER,
      LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_RECS_PER_ACCTNO));

  // Project Subject Company into the final layout. We'll Denormalize the other sections onto
  // this attribute.
  subj_company_final_layout :=
      PROJECT(company_with_phone_variations,
        TRANSFORM(BusinessContactCard.Layouts.rec_BCCReport_acctno,
          SELF.CompanyInfo := LEFT,
          SELF := LEFT,
          SELF := []));

  // 2. Project Parent Company record into the output layout for its section.
  parent_company :=
    IF( is_multiBDID or (in_mod.isBIPReport and EXISTS(parentsRecords)),
      PROJECT(parentsRecords,
        TRANSFORM(BusinessContactCard.Layouts.rec_BCCParent_acctno,
          SELF.acctno := LEFT.acctno,
          SELF.businessid := (STRING)LEFT.parent_ids.bdid,
          SELF.BusinessIDs.proxid := LEFT.parent_ids.proxid,
          SELF.businessIDs.ultid := LEFT.parent_ids.ultid,
          SELF.businessIDs.orgid := LEFT.parent_ids.orgid,
          SELF.businessIDs.seleid := LEFT.parent_ids.seleid,
          SELF.businessIDs.dotid := LEFT.parent_ids.dotid,
          SELF.BusinessIDs.empid := LEFT.parent_ids.empid,
          SELF.BusinessIDs.powid := LEFT.parent_ids.powid,
          SELF.companyname := LEFT.company_name,
          SELF.fein := LEFT.fein,
          SELF.address.streetname := LEFT.prim_name,
          SELF.address.streetnumber := LEFT.prim_range,
          SELF.address.streetpredirection := LEFT.predir,
          SELF.address.streetpostdirection := LEFT.postdir,
          SELF.address.streetsuffix := LEFT.addr_suffix,
          SELF.address.unitdesignation := LEFT.unit_desig,
          SELF.address.unitnumber := LEFT.sec_range,
          SELF.address.streetaddress1 := BusinessContactCard.Functions.get_addr1(LEFT),
          SELF.address.streetaddress2 := BusinessContactCard.Functions.get_addr2(LEFT),
          SELF.address.state := LEFT.state,
          SELF.address.city := LEFT.city,
          SELF.address.zip5 := LEFT.zip,
          SELF.address.zip4 := LEFT.zip4,
          SELF.address.county := LEFT.county_name,
          SELF.address.postalcode := '',
          SELF.address.statecityzip := BusinessContactCard.Functions.get_addr2(LEFT),
          SELF.phoneinfo.phone10 := LEFT.phone,
          SELF := LEFT,
          SELF := []))
      , DATASET([],BusinessContactCard.Layouts.rec_BCCParent_acctno)
    );

  // Bolt the parent company onto the subject company in the final report layout.
  subj_company_parent_company :=
      DENORMALIZE(subj_company_final_layout, parent_company,
        LEFT.acctno = RIGHT.acctno AND
        ((~in_mod.isBIPReport AND (unsigned)LEFT.CompanyInfo.businessid = RIGHT.bdid)
        OR
        (in_mod.isBIPReport AND LEFT.CompanyInfo.BusinessIds.UltID = RIGHT.UltID
                            AND LEFT.CompanyInfo.BusinessIds.OrgID = RIGHT.OrgID
                            AND LEFT.CompanyInfo.BusinessIds.SeleID = RIGHT.SeleID)),
        GROUP,
        TRANSFORM(BusinessContactCard.Layouts.rec_BCCReport_acctno,
          SELF.ParentCompanyInfo := PROJECT(RIGHT, TRANSFORM(iesp.businesscontactcardreport.t_BCCParent, SELF := LEFT)),
          SELF := LEFT,
          SELF := [])
        );

  // 3. Now get the Contacts (Executives/Owners/Associates) for the subject company.
	execs_owners_asscs_sorted := SORT(contactsRecords, acctno, group_id, did, -dt_last_seen);
	execs_owners_asscs_deduped := DEDUP(execs_owners_asscs_sorted, acctno, group_id, did);
	execs_owners_asscs_grouped := GROUP(execs_owners_asscs_deduped, acctno, group_id);
	execs_owners_asscs_resorted := SORT(execs_owners_asscs_grouped, title_rank, -( TRIM(title) != '' ), lname, fname);
	execs_owners_asscs_topped := CHOOSEN(execs_owners_asscs_grouped, iesp.constants.BR.MaxPeopleAtWork);

  execs_owners_asscs :=
    PROJECT( execs_owners_asscs_topped,
      TRANSFORM(BusinessContactCard.Layouts.rec_BCCExecs_acctno,
        SELF.acctno := LEFT.acctno,
        SELF.group_id := LEFT.group_id,
        SELF.bdid := LEFT.bdid,
        SELF.uniqueid := (STRING)LEFT.did,
        SELF.datelastseen.Year := LEFT.dt_last_seen DIV 10000,
        SELF.datelastseen.Month := (LEFT.dt_last_seen % 10000) DIV 100,
        SELF.datelastseen.Day := LEFT.dt_last_seen % 100,
        SELF.name.full := IF( TRIM(LEFT.lname) != '', TRIM(LEFT.lname), '' ) +
                                            IF( TRIM(LEFT.fname) != '', ', ' + TRIM(LEFT.fname), '' ) +
                                            IF( TRIM(LEFT.mname) != '', ' ' + TRIM(LEFT.mname), '' ),
        SELF.name.first := LEFT.fname,
        SELF.name.middle := LEFT.mname,
        SELF.name.last := LEFT.lname,
        SELF.name.suffix := LEFT.name_suffix,
        SELF.name.prefix := LEFT.title,
        SELF.ssninfo.ssn := LEFT.ssn,
        SELF.title := LEFT.company_title,
        SELF.isexecutiveowner := LEFT.is_exec,
        SELF.address.streetname := LEFT.prim_name,
        SELF.address.streetnumber := LEFT.prim_range,
        SELF.address.streetpredirection := LEFT.predir,
        SELF.address.streetpostdirection := LEFT.postdir,
        SELF.address.streetsuffix := LEFT.addr_suffix,
        SELF.address.unitdesignation := LEFT.unit_desig,
        SELF.address.unitnumber := LEFT.sec_range,
        SELF.address.streetaddress1 := Address.Addr1FromComponents( LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range),
        SELF.address.streetaddress2 := Address.Addr2FromComponents( LEFT.city, LEFT.state, (STRING)LEFT.zip + IF( LEFT.zip4 != 0, '-' + TRIM((STRING)LEFT.zip4), '' ) ),
        SELF.address.state := LEFT.state,
        SELF.address.city := LEFT.city,
        SELF.address.zip5 := (STRING)LEFT.zip,
        SELF.address.zip4 := (STRING)LEFT.zip4,
        SELF.address.county := LEFT.county,
        SELF.address.postalcode := '',
        SELF.address.statecityzip := Address.Addr2FromComponents( LEFT.city, LEFT.state, (STRING)LEFT.zip + IF( LEFT.zip4 != 0, '-' + TRIM((STRING)LEFT.zip4), '' ) ),
        SELF := LEFT,
        SELF.phoneinfo := [],
        SELF.phonespluses := [],
        SELF := []));

  // ... Join EDA/Gong records with PhonesFeedback to the Contacts.

  BusinessContactCard.Layouts.rec_BCCPhoneInfoWithFeedback_acctno xfm_gong_recs(BusinessContactCard.Layouts.rec_gong_records_acctno l ) :=
    TRANSFORM
        in_rec := PROJECT(l, TRANSFORM(PhonesFeedback_Services.Layouts.rec_in_request,
                                       SELF.Phone_Number := LEFT.phone10,
                                       SELF.in_DID := (STRING)LEFT.did));

        ds_phonefeedback := IF( include_phones_feedback,
                                PhonesFeedback_Services.Raw.feedback_rpt(DATASET(in_rec)),
                                EMPTY_PHONES_FEEDBACK
                               );

      SELF.phone10 := l.phone10;
      SELF.pubnonpub := l.publish_code;
      SELF.listingphone10 := l.phone10;
      SELF.listingname := l.listed_name;
      SELF.timezone := l.timezone;
      SELF.listingtimezone := '';
      SELF.phonesfeedback.feedbackcount := ds_phonefeedback[1].feedback_count;
      SELF.phonesfeedback.lastfeedbackresult := ds_phonefeedback[1].last_feedback_result;
      SELF.phonesfeedback.lastfeedbackresultprovided := (STRING)ds_phonefeedback[1].last_feedback_result_provided;
      SELF := l;
    END;

  gong_recs_deduped := DEDUP(SORT(gongRecords, acctno, group_id, did), acctno, group_id, did);
  gong_records := PROJECT(gong_recs_deduped, xfm_gong_recs(LEFT));

  execs_with_gong_recs :=
      JOIN(execs_owners_asscs, gong_records,
        LEFT.acctno = RIGHT.acctno AND
        LEFT.uniqueid = (STRING)RIGHT.did,
        TRANSFORM(BusinessContactCard.Layouts.rec_BCCExecs_acctno,
          SELF.phoneinfo := RIGHT,
          SELF := LEFT,
          SELF := []),
        LEFT OUTER,
        LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_RECS_PER_ACCTNO));

  // ... Join PhonesPlus records with PhonesFeedback to the Contacts.

  BusinessContactCard.Layouts.rec_BCCPhonesPlusRecordWithFeedback_acctno xfm_phonesplus_recs(BusinessContactCard.Layouts.rec_phonesplus_acctno l ) :=
    TRANSFORM
        in_rec := PROJECT(l, TRANSFORM(PhonesFeedback_Services.Layouts.rec_in_request,
                                       SELF.Phone_Number := LEFT.phoneno,
                                       SELF.in_DID := (STRING)LEFT.did));

        ds_phonefeedback := IF( include_phones_feedback,
                                PhonesFeedback_Services.Raw.feedback_rpt(DATASET(in_rec)),
                                EMPTY_PHONES_FEEDBACK
                               );
        // FYI: see PersonReports.phonesplus_records
      SELF.ListedName := l.listed_name;
      SELF.Name := iesp.ECL2ESP.SetName(l.name_first, l.name_middle, l.name_last, l.name_suffix, '');
      Address1 := Address.Addr1FromComponents( l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range);
      Address2 := Address.Addr2FromComponents( l.city, l.st, l.z5 + IF( TRIM(l.z4) != '', '-' + TRIM(l.z4), '' ) );
      statecityzip := Address.Addr2FromComponents( l.city, l.st, l.z5 + IF( TRIM(l.z4) != '', '-' + TRIM(l.z4), '' ) );
      SELF.Address := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
                                                                  l.suffix, l.unit_desig, l.sec_range, l.city,
                                                                  l.st, l.z5, l.z4, '',
                                                                  '', Address1, Address2, statecityzip);
      SELF.PhoneNumber := l.phoneno;
      SELF.timezone := l.timezone;
      SELF.phonetype := l.phonetype;
      // SELF.phonetype := CASE( STD.STR.ToUpperCase(TRIM(l.phonetype,LEFT,RIGHT)),
      // 'MOBILE' => 'Possible Cell Phone',
      // 'RESIDENTIAL' => 'Possible Non-DA',
      // l.phonetype );
      SELF.CarrierName := l.carrier;
      SELF.CarrierCity := l.carrier_city;
      SELF.CarrierState := l.carrier_state;
      SELF.ListingTypes := DATASET( [{l.listing_type_bus}, {l.listing_type_res}, {l.listing_type_cell}], iesp.share.t_StringArrayItem );//MAX is IESP.CONSTANTS.DAW.MAX_LISTING_TYPES, but we are creating dataset of 1 rec
      SELF.phonefeedback.feedbackcount := ds_phonefeedback[1].feedback_count;
      SELF.phonefeedback.lastfeedbackresult := ds_phonefeedback[1].last_feedback_result;
      SELF.phonefeedback.lastfeedbackresultprovided := (STRING)ds_phonefeedback[1].last_feedback_result_provided;
      SELF.did := (UNSIGNED6)l.did;
      SELF := l;
    END;

  phonesplus_recs := IF( include_phones_plus,
                                PROJECT(phonesPlusRecords, xfm_phonesplus_recs(LEFT)),
                                EMPTY_PHONESPLUS
                               );

  // ... Attach PhonesPlus to Contacts-and-EDA/Gong records.
  execs_with_gong_and_phonesplus_recs_unsorted :=
      DENORMALIZE(execs_with_gong_recs, phonesplus_recs,
        LEFT.acctno = RIGHT.acctno AND
        LEFT.uniqueid = (STRING)RIGHT.did,
        GROUP,
        TRANSFORM(BusinessContactCard.Layouts.rec_BCCExecs_acctno,
          SELF.phonespluses := CHOOSEN(PROJECT(ROWS(RIGHT), iesp.businesscontactcardreport.t_BCCPhonesPlusRecordWithFeedback), iesp.constants.BR.MaxPhonesPlus),
          SELF := LEFT,
          SELF := [])
        );

  execs_with_gong_and_phonesplus_recs := SORT(execs_with_gong_and_phonesplus_recs_unsorted, title_rank, -( TRIM(title) != '' ), name.last, name.first);

  // And finally join the Contacts to the Subject and Parent Companies, in the final Report layout.
  businesscontactcard_entire :=
      DENORMALIZE(subj_company_parent_company, execs_with_gong_and_phonesplus_recs,
        LEFT.acctno = RIGHT.acctno AND
        ((~in_mod.isBIPReport and LEFT.CompanyInfo.businessid = (STRING)RIGHT.group_id)
        OR
        (in_mod.isBIPReport AND LEFT.CompanyInfo.BusinessIds.UltID = RIGHT.UltID
                            AND LEFT.CompanyInfo.BusinessIds.OrgID = RIGHT.OrgID
                            AND LEFT.CompanyInfo.BusinessIds.SeleID = RIGHT.SeleID)),
        GROUP,
        TRANSFORM(BusinessContactCard.Layouts.rec_BCCReport_acctno,
          SELF.ExecutivesAssociates := CHOOSEN( PROJECT(ROWS(RIGHT), iesp.businesscontactcardreport.t_BCCExecs), iesp.constants.BR.MaxPeopleAtWork ),
          SELF := LEFT,
          SELF := [])
        );

  RETURN businesscontactcard_entire;
END;

