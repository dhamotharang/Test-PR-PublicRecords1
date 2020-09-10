IMPORT AutoStandardI, doxie, iesp, standard, ut, Header, NID, Address, Suppress,
  Email_Data, std, American_student_list, dx_header;

EXPORT Functions := MODULE

  SHARED UNSIGNED2 OLD_MaxCountNames := 5;
  SHARED UNSIGNED2 OLD_MaxCountAddresses := 5;

  EXPORT PrefFirstMatch2(STRING20 pfname, STRING20 r) := FUNCTION
    RETURN NID.mod_PFirstTools.SubLinPFR(pfname, r) OR pfname[1..LENGTH(TRIM(r))]=r;
  END;
  EXPORT TeaserSearchServices.Layouts.records_plus combine(
    Header.layout_teaser l,
    DATASET(Header.layout_teaser) r,
    BOOLEAN IncludeAllAddresses = FALSE) := TRANSFORM
    // need to calc penalties on each of the historical records, then preserve the lowest for the group
    layout_pen := RECORD(Header.layout_teaser)
      UNSIGNED1 name_penalt;
      UNSIGNED1 addr_penalt;
      UNSIGNED1 penalt;
    END;

    layout_pen calcPen(Header.layout_teaser rec) := TRANSFORM
      name_p := doxie.FN_Tra_Penalty_Name(rec.fname,rec.mname,rec.lname);
      addr_p := doxie.FN_Tra_Penalty_Addr('','',rec.prim_name,'','','',rec.city_name,rec.st,rec.zip) +
                                          // this will slighty penalize each of the non-current addresses
                                          // so that a match on current address will bubble to the top
                                          IF(rec.isCurrent, 0, 1);
      SELF.name_penalt := name_p;
      SELF.addr_penalt := addr_p;
      SELF.penalt := name_p + addr_p;
      SELF := rec;
    END;

    with_pen := PROJECT(r, calcPen(LEFT));

    SELF.penalt := MIN(with_pen, penalt);

    layout_name_pen := RECORD(iesp.share.t_Name)
      UNSIGNED1 penalt;
      UNSIGNED1 nameOrder;
    END;

    layout_name_pen xformName(with_pen ri) := TRANSFORM
      SELF.Prefix := ri.title;
      SELF.First := ri.fname;
      SELF.Middle := ri.mname;
      SELF.Last := ri.lname;
      SELF.Suffix := ri.name_suffix;
      SELF.penalt := ri.name_penalt;
      SELF.nameOrder := ri.nameOrder;
      SELF := [];
    END;

    names := PROJECT(with_pen, xformName(LEFT));

    // allow for mname NNEQ behavior; keep the longest of the equiv mnames
    nneq_mname(STRING mn1, STRING mn2) := mn1 = '' OR mn2 = '' OR mn1 = mn2 OR
                                          mn1[1] = mn2 OR mn1 = mn2[1];

    layout_name_pen getNames(names l, names r) := TRANSFORM
      SELF.middle := IF(LENGTH(l.middle) > LENGTH(r.middle), l.middle, r.middle);
      SELF := l;
    END;

    names_ddp := ROLLUP(SORT(names, last, first, middle, prefix, suffix),
      LEFT.last = RIGHT.last AND
      LEFT.first = RIGHT.first AND
      nneq_mname(LEFT.middle, RIGHT.middle) AND
      ut.nneq(LEFT.prefix, RIGHT.prefix) AND
      ut.nneq(LEFT.suffix, RIGHT.suffix), getNames(LEFT, RIGHT));
     SELF.Names := PROJECT(TOPN(names_ddp,
          IF(IncludeAllAddresses, iesp.Constants.ThinRps.MaxCountNames, OLD_MaxCountNames), -nameOrder, penalt),
        iesp.share.t_Name);

    iesp.thinrolluppersonsearch.t_ThinRpsAddress makeAddrs(Header.layout_teaser ri) := TRANSFORM
      SELF.DateLastSeen := iesp.ECL2ESP.toDateYM(ri.dt_last_seen);
      SELF.VendorDateLastSeen := iesp.ECL2ESP.toDateYM(ri.dt_vendor_last_reported);
      SELF.City := ri.city_name;
      SELF.State := ri.st;
      SELF.Zip5 := ri.zip;
      SELF.Zip4 := ri.zip4;
      SELF := [];
    END;
    uniqAddrs := DEDUP(SORT(r, prim_name, city_name, zip, -dt_last_seen, -dt_vendor_last_reported, RECORD), prim_name, city_name, zip);
    // need to combine the slimmed addresses and dedup, keeping the best addr first
    allAddrs := DEDUP(PROJECT(SORT(uniqAddrs, -dt_last_seen, -dt_vendor_last_reported),makeAddrs(LEFT)), city, zip5);
    SELF.Addresses := CHOOSEN(allAddrs, IF(IncludeAllAddresses, 
      iesp.Constants.ThinRps.MaxCountAddresses, OLD_MaxCountAddresses));

    yob(INTEGER4 dob) := dob div 10000;
    mob(INTEGER4 dob) := (dob % 10000) div 100;
    day(INTEGER4 dob) := dob % 100;
    EquivDates(INTEGER4 d1, INTEGER4 d2) := 
      ut.nneq_int((STRING)(yob(d1)),(STRING)(yob(d2))) AND
      ut.nneq_int((STRING)mob(d1),(STRING)mob(d2)) AND
      ut.nneq_int((STRING)day(d1),(STRING)day(d2));

    uniqDOBs := DEDUP(SORT(r, dob), equivDates(LEFT.dob, RIGHT.dob), RIGHT);
    iesp.thinrolluppersonsearch.t_ThinRpsDOB makeDOB(Header.layout_teaser ri) := TRANSFORM
      SELF.DOB := iesp.ECL2ESP.toDate(ri.dob);
      SELF.Age := ut.Age(ri.dob);
    END;

    SELF.DOBs := PROJECT(uniqDOBs, makeDOB(LEFT));

    uniqDODs := DEDUP(SORT(r, dod), equivDates(LEFT.dod, RIGHT.dod), RIGHT);
    iesp.thinrolluppersonsearch.t_ThinRpsDOD makeDOD(Header.layout_teaser ri) := TRANSFORM
      SELF.DOD := iesp.ECL2ESP.toDate(ri.dod);
      SELF.DeadAge := IF(ri.dod<>0 AND ri.dob<>0, (ri.dod-ri.dob) div 10000, 0);
    END;

    SELF.DODs := PROJECT(uniqDODs, makeDOD(LEFT));

    SELF.UniqueId := INTFORMAT(l.did,12,1);
    SELF := l;
    SELF.Relatives := [];
    SELF.RelativesNew := [];
  END;

  EXPORT AddPhoneIndicator(DATASET(TeaserSearchServices.Layouts.records_plus) recs_in,
    Doxie.IDataAccess mod_access,
    BOOLEAN display_phone) := FUNCTION

    recs_pres := PROJECT(recs_in, TRANSFORM(doxie.layout_presentation,
      SELF.city_name := LEFT.Addresses[1].city,
      SELF.st := LEFT.Addresses[1].state,
      SELF.zip := LEFT.Addresses[1].zip5,
      SELF.did := (UNSIGNED6) LEFT.uniqueId,
      SELF.fname := LEFT.Names[1].First,
      SELF.lname := LEFT.Names[1].Last,
      // append gong rolls up by RID, so need them unique
      SELF.rid := COUNTER,
      SELF := LEFT,
      SELF := []));

    recs_hhid := JOIN(recs_pres, dx_header.key_did_hhid(), 
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM(doxie.layout_presentation, SELF.hhid := RIGHT.hhid; SELF := LEFT),
      // not sure why keep(1), there can be more than one match;
      // but to be consistent with it, I'm using limit(0)
      LEFT OUTER, LIMIT (0), KEEP(1));

    recs_dids := PROJECT(recs_in, TRANSFORM(doxie.layout_references,
      SELF.did := (UNSIGNED6) LEFT.uniqueId));

    // Call doxie relative dids to retrieve necessary relative info
    rel_dids := doxie.relative_dids(recs_dids);

    recs_append := doxie.Append_Gong(recs_hhid, rel_dids, mod_access);

    recs_in setPhoneInd(recs_in le, recs_append ri) := TRANSFORM
      hasPhone := ri.did <> 0 AND ri.tnt in ['B', 'V'] AND ri.listed_phone <> '';
      phoneNum := IF(hasPhone, ri.listed_phone[1..3] + ri.listed_phone[4..4]+'XXXXXX','');

      SELF.addresses := PROJECT(le.addresses,
        TRANSFORM(iesp.thinrolluppersonsearch.t_ThinRpsAddress,
        // addresses are reverse chron; only the first one can get the phone indicator
        phn_flag := COUNTER = 1 AND hasPhone;
        SELF.phoneIndicator := phn_flag;
        SELF.phone := IF(phn_flag AND display_phone, phoneNum, '');
        SELF := LEFT));
      SELF := le;
    END;

    with_ind := JOIN(recs_in, recs_append, 
      (UNSIGNED6) LEFT.uniqueId = RIGHT.did,
      setPhoneInd(LEFT,RIGHT));
    RETURN with_ind;
  END;

  EXPORT historicalNamesAddrs(DATASET(doxie.layout_references) dids, BOOLEAN IncludeAllAddresses,
                              doxie.IDataAccess mod_access) := FUNCTION

    uniq_dids := DEDUP(SORT(dids, did), did);

    hist_recs_pre := JOIN(uniq_dids, Header.Key_Teaser_cnsmr_did, 
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM(Header.layout_teaser, SELF := RIGHT),
      LIMIT(ut.limits.FETCH_KEYED, SKIP));
    hist_recs := Suppress.MAC_SuppressSource(hist_recs_pre,mod_access);
    recs_grp := GROUP(SORT(hist_recs, did, -isCurrent), did);
    recs_history := ROLLUP(recs_grp, GROUP, combine(LEFT,ROWS(LEFT), IncludeAllAddresses));
    RETURN recs_history;
  END;

  EXPORT AddRelativeNames(
      DATASET(TeaserSearchServices.Layouts.records_plus) recs_in,
      STRING32 application_type_value
    ) := FUNCTION

    dids := PROJECT(recs_in,TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED)LEFT.UniqueId));
    dids_grpd := GROUP(SORT(dids, did), did);
    rels := doxie.relative_names(dids_grpd,FALSE, TRUE);

    iesp.ThinRollupPersonSearch.t_ThinRpsRelative xformRelsNew(Standard.Name_DID r) := TRANSFORM
      SELF.Name.First := r.fname;
      SELF.Name.Middle := r.mname;
      SELF.Name.Last := r.lname;
      SELF.Name.Suffix := r.name_suffix;
      SELF.UniqueID := INTFORMAT(r.DID,12,1);
      SELF := [];
    END;

    iesp.share.t_Name xformRels(Standard.Name_DID r) := TRANSFORM
      SELF.First := r.fname;
      SELF.Middle := r.mname;
      SELF.Last := r.lname;
      SELF.Suffix := r.name_suffix;
      SELF := [];
    END;

    TeaserSearchServices.Layouts.records_plus addRels(recs_in le, rels ri) := TRANSFORM
      SELF.RelativesNew := PROJECT(CHOOSEN(ri.names,iesp.Constants.ThinRps.MaxCountRelatives),xformRelsNew(LEFT));
      SELF.Relatives := PROJECT(CHOOSEN(ri.names,iesp.Constants.ThinRps.MaxCountRelatives),xformRels(LEFT));
      SELF := le;
    END;

    // adding necessary suppression here for relatives V3
    relsSuppressed := PROJECT(rels, TRANSFORM(RECORDOF(LEFT),
      tmpNames := PROJECT(LEFT.Names, TRANSFORM(LEFT));
      Suppress.MAC_Suppress(tmpNames,tmpNamesSuppressed,
        application_type_value,Suppress.Constants.LinkTypes.DID,DID);
      SELF.Names := tmpNamesSuppressed;
      SELF := LEFT;
    ));

    with_rels := JOIN(recs_in, relsSuppressed, 
      (UNSIGNED6) LEFT.UniqueId=RIGHT.did, 
      addRels(LEFT,RIGHT), 
      LOOKUP, LEFT OUTER);

    RETURN with_rels;
  END;

  EXPORT getFakeAddress(iesp.thinrolluppersonsearch.t_ThinRpsSearchRecord inrec) := FUNCTION
    rnd:=random() : INDEPENDENT;
    rndID:=rnd%1195;
    validatedRndID:=IF(rndID>1000,rndID-1000,rndID);
    getData:=TeaserSearchServices.Fake_Address_Info(id=validatedRndID);
    //create fake data based on last address....
    iesp.thinrolluppersonsearch.t_ThinRpsAddress appendFakeData(iesp.thinrolluppersonsearch.t_ThinRpsSearchRecord inrec, STRING2 fakeState, STRING fakeCity, STRING5 fakeZip) := TRANSFORM
      INTEGER4 CntAddresses := COUNT(inrec.Addresses);
      fakeYear := inrec.Addresses[CntAddresses].DateLastSeen.year - 1;
      fakeMonth := inrec.Addresses[CntAddresses].DateLastSeen.month;
      fakeDay := inrec.Addresses[CntAddresses].DateLastSeen.day;
      SELF.DateLastSeen.Year := fakeYear;
      SELF.DateLastSeen.Month := fakeMonth;
      SELF.DateLastSeen.Day := fakeDay;
      SELF.VendorDateLastSeen.Year := fakeYear;
      SELF.VendorDateLastSeen.Month := fakeMonth;
      SELF.VendorDateLastSeen.Day := fakeDay;
      SELF.VendorDateFirstSeen.Year := fakeYear;
      SELF.VendorDateFirstSeen.Month := fakeMonth;
      SELF.VendorDateFirstSeen.day := fakeDay;
      SELF.City := fakeCity;
      SELF.State := fakeState;
      SELF.Zip5 := fakeZip;
      SELF.Zip4 := '';
      SELF.PhoneIndicator := FALSE;
      SELF.Phone := '';
    END;
    //project results
    results:=PROJECT(inrec,appendFakeData(LEFT,getData[1].State,getData[1].City_Name,getData[1].zip));
    RETURN results;
  END;

  /*--- FakeData for Intelius ---*/
  EXPORT getExtendedFakeAddress(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord inrec) := FUNCTION
    rnd:=random() : INDEPENDENT;
    rndID:=rnd%1195;
    validatedRndID:=IF(rndID>1000,rndID-1000,rndID);
    getData:=TeaserSearchServices.Fake_Address_Info(id=validatedRndID);

    //create fake data based on last address....
    iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchAddress appendFakeDataExtended(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord inrec, STRING2 fakeState, STRING fakeCity, STRING5 fakeZip) := TRANSFORM
      INTEGER4 CntAddresses := COUNT(inrec.Addresses);
      fakeYear := inrec.Addresses[CntAddresses].DateLastSeen.year - 1;
      fakeMonth := inrec.Addresses[CntAddresses].DateLastSeen.month;
      fakeDay := inrec.Addresses[CntAddresses].DateLastSeen.day;
      SELF.DateLastSeen.Year := fakeYear;
      SELF.DateLastSeen.Month := fakeMonth;
      SELF.DateLastSeen.Day := fakeDay;
      SELF.VendorDateLastSeen.Year := fakeYear;
      SELF.VendorDateLastSeen.Month := fakeMonth;
      SELF.VendorDateLastSeen.Day := fakeDay;
      SELF.VendorDateFirstSeen.Year := fakeYear;
      SELF.VendorDateFirstSeen.Month := fakeMonth;
      SELF.VendorDateFirstSeen.day := fakeDay;
      SELF.StreetNumber := inrec.Addresses[1].StreetNumber;
      SELF.StreetPreDirection := inrec.Addresses[1].StreetPreDirection;
      SELF.StreetName := inrec.Addresses[1].StreetName;
      SELF.StreetSuffix := inrec.Addresses[1].StreetSuffix;
      SELF.StreetPostDirection := inrec.Addresses[1].StreetPostDirection;
      SELF.UnitDesignation := inrec.Addresses[1].UnitDesignation;
      SELF.UnitNumber := inrec.Addresses[1].UnitNumber;
      SELF.StreetAddress1 := inrec.Addresses[1].StreetAddress1;
      SELF.StreetAddress2 := '';
      SELF.City := fakeCity;
      SELF.State := fakeState;
      SELF.Zip5 := fakeZip;
      SELF.zip4 := '';
      SELF.County := '';
      SELF.PostalCode := '';
      SELF.StateCityZip := Address.Addr2FromComponents(fakeCity, fakeState, fakeZip);
      SELF.Phones := [];
    END;
    //project results
    results := PROJECT(inrec,appendFakeDataExtended(LEFT,getData[1].State,getData[1].City_Name,getData[1].zip));
    RETURN results;
  END;



  /*--- getAdditionalData appends extra data from doxie.header_records_byDID for ThinTeaserRollup
        while preserving original ThinTeaser did order: ---*/
  EXPORT getAdditionalData(
    DATASET(TeaserSearchServices.Layouts.records) in_rec,
    BOOLEAN AllAddresses,
    BOOLEAN IncludeFullHistory,
    BOOLEAN IncludePhones,
    BOOLEAN DtcPhoneAddressTeaserMask,
    BOOLEAN IncludePhoneNumber,
    BOOLEAN IncludeAddress,
    BOOLEAN IncludeEmailAddress,
    BOOLEAN IncludeEducationInformation,
    STRING32 application_Type_value
    ) := FUNCTION

    glb_mod := AutoStandardI.GlobalModule();
    mod_access := MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated (glb_mod))
      EXPORT STRING32 application_type := application_Type_value;
    END;

    /*--- Sequence results to preserve order from tempresults ---*/
    seq_records := RECORD(TeaserSearchServices.Layouts.records)
      UNSIGNED seq;
    END;

    seq_records getSequence(in_rec L, INTEGER C) := TRANSFORM
      SELF.seq := C;
      SELF := L;
    END;
    inrec_seq := PROJECT(in_rec, getSequence(LEFT, COUNTER));

    /*--- Get additional data through doxie.header_records_byDID ---*/
    dids := PROJECT(in_rec, TRANSFORM(doxie.layout_references_hh, SELF.did := (INTEGER)LEFT.uniqueId));
    additional_data_recs := doxie.header_records_byDID(dids,
      include_dailies := FALSE,
      IncludeAllRecords := TRUE,
      GongByDidOnly := TRUE);

    /*--- Format addresses ---*/
    address_rec := RECORD
      doxie.Layout_presentation;
      DATASET(iesp.share.t_PhoneInfo) Phones {MAXCOUNT(iesp.Constants.ThinRpsExt.MaxPhones)};
    END;

    sorted_address := PROJECT(
      SORT(additional_data_recs, did, prim_range, predir, prim_name, suffix, postdir,
        sec_range, city_name, st, zip,
        -dt_last_seen),
      TRANSFORM(address_rec, SELF.Phones := []; SELF := LEFT));

    iesp.share.t_PhoneInfo addPhoneInfo(address_rec L) := TRANSFORM
      SELF.Phone10:=l.phone;
      SELF.PubNonpub:=l.publish_code;
      SELF.ListingPhone10:=l.phone;
      SELF.ListingName:=l.listed_name;
      SELF.TimeZone:=l.timezone;
      SELF.ListingTimeZone:='';
    END;

    address_rec rollupAddr(address_rec L, address_rec R) := TRANSFORM
        BOOLEAN hasEmptyAddress := L.prim_name = '' AND L.prim_range = '';
        SELF.dt_vendor_last_reported := IF(R.dt_vendor_last_reported > L.dt_vendor_last_reported OR hasEmptyAddress,
          R.dt_vendor_last_reported, L.dt_vendor_last_reported);
        SELF.dt_vendor_first_reported := IF(R.dt_vendor_first_reported < L.dt_vendor_first_reported AND R.dt_vendor_first_reported <> 0 OR hasEmptyAddress,
          R.dt_vendor_first_reported, L.dt_vendor_first_reported);
        SELF.dt_last_seen := IF(R.dt_last_seen > L.dt_last_seen,
          R.dt_last_seen, L.dt_last_seen);
        SELF.prim_range := IF(L.prim_range <> '', L.prim_range, R.prim_range);
        SELF.predir := IF(L.predir <> '', L.predir, R.predir);
        SELF.prim_name := IF(L.prim_name <> '', L.prim_name, R.prim_name);
        SELF.suffix := IF(L.suffix <> '', L.suffix, R.suffix);
        SELF.postdir := IF(L.postdir <> '', L.postdir, R.postdir);
        SELF.sec_range := IF(L.sec_range <> '', L.sec_range, R.sec_range);
        SELF.unit_desig := MAP(L.sec_range <> '' => L.unit_desig,
          R.sec_range <> '' => R.unit_desig,
          '');
        SELF.city_name := IF(L.city_name <> '', L.city_name, R.city_name);
        SELF.st := IF(L.st <> '', L.st, R.st);
        SELF.zip := IF(L.zip <> '', L.zip, R.zip);
        Phones := L.Phones + PROJECT(R, addPhoneInfo(LEFT));
        SELF.Phones := CHOOSEN(Phones(Phone10 != ''), iesp.Constants.ThinRpsExt.MaxPhones);
        SELF := L;
    END;

    //rollup addresses and re-sort by dates last seen
    rolled_address := SORT(ROLLUP(sorted_address, LEFT.did = RIGHT.did AND
                                  (LEFT.prim_range = RIGHT.prim_range OR LEFT.prim_range = '') AND
                                  ut.nneq(LEFT.predir, RIGHT.predir) AND
                                  (LEFT.prim_name = RIGHT.prim_name OR LEFT.prim_name = '') AND
                                  ut.nneq(LEFT.suffix, RIGHT.suffix) AND
                                  ut.nneq(LEFT.postdir, RIGHT.postdir) AND
                                  ut.nneq(LEFT.sec_range, RIGHT.sec_range) AND
                                  ut.nneq(LEFT.city_name, RIGHT.city_name) AND
                                  ut.nneq(LEFT.st, RIGHT.st) AND
                                  ut.nneq(LEFT.zip, RIGHT.zip),
                                  rollupAddr(LEFT, RIGHT)),
                          did, -dt_last_seen, -dt_vendor_last_reported, dt_first_seen);

    //Select addresses based on input options
    addresses := MAP(
      AllAddresses => rolled_address, //KEEP ALL addresses
      IncludeFullHistory => DEDUP(rolled_address, did, KEEP(OLD_MaxCountAddresses)), //KEEP 5 most recent addresses to match ThinTeaserService (line 84)
      DEDUP(rolled_address, did)); // KEEP only most recent address

    /*--- Format additional data ---*/
    data_rollup_rec := RECORD
      UNSIGNED did;
      DATASET(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchAddress) Addresses {MAXCOUNT(iesp.Constants.ThinRpsExt.MaxAddresses)};
    END;

    iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchAddress setAddresses(address_rec L) := TRANSFORM
      SELF.StreetAddress1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range);
      SELF.StreetAddress2 := '';
      SELF.StreetNumber := L.prim_range;
      SELF.StreetPreDirection := L.predir;
      SELF.StreetName := L.prim_name;
      SELF.StreetSuffix := L.suffix;
      SELF.StreetPostDirection := L.postdir;
      SELF.UnitDesignation := L.unit_desig;
      SELF.UnitNumber := L.sec_range;
      SELF.City := L.city_name;
      SELF.State := L.st;
      SELF.zip5 := L.zip;
      SELF.zip4 := L.zip4;
      SELF.County := L.county_name;
      SELF.PostalCode := '';
      SELF.StateCityZip := Address.Addr2FromComponents(l.city_name, l.st, l.zip);
      dt_vendor_last_seen := iesp.ECL2ESP.toDateYM((UNSIGNED3)L.dt_vendor_last_reported);
      dt_last_seen := iesp.ECL2ESP.toDateYM((UNSIGNED3)L.dt_last_seen);
      SELF.DateLastSeen := dt_last_seen;
      SELF.VendorDateLastSeen.Year := dt_vendor_last_seen.year;
      SELF.VendorDateLastSeen.Month := dt_vendor_last_seen.month;
      SELF.VendorDateLastSeen.Day := dt_vendor_last_seen.day;
      SELF.VendorDateFirstSeen := [];
      SELF.Phones := IF(IncludePhones OR IncludePhoneNumber, L.phones, DATASET([], iesp.share.t_PhoneInfo));
    END;

    data_rollup_rec rollupHeaderRec(data_rollup_rec L, data_rollup_rec R) := TRANSFORM
      SELF.did := L.did;
      Address := L.Addresses + R.Addresses;
      SELF.Addresses := CHOOSEN(Address, iesp.Constants.ThinRpsExt.MaxAddresses);
    END;
    //rollup based on did
    rollup_extra_data_rec := ROLLUP(PROJECT(addresses, TRANSFORM(data_rollup_rec,
      SELF.Addresses := PROJECT(LEFT, setAddresses(LEFT)),
      SELF := LEFT)),
      LEFT.did = RIGHT.did,
      rollupHeaderRec(LEFT, RIGHT));

    /*--- Join extra data with original ThinTeaser results (in_rec) ---*/
    seq_rollup_rec := RECORD
      UNSIGNED seq;
      iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord;
    END;

    seq_rollup_rec AddExtraData(seq_records L, data_rollup_rec R) := TRANSFORM
      SELF.seq := L.seq;
      SELF.Addresses := CHOOSEN(R.Addresses, iesp.Constants.ThinRpsExt.MaxAddresses);
      SELF := L; //everything else from original TeaserSearch
      SELF := [];
    END;

    recs_w_extra := JOIN(inrec_seq, rollup_extra_data_rec,
      LEFT.UniqueId = INTFORMAT (RIGHT.did, 12, 1),
      AddExtraData(LEFT, RIGHT),
      LIMIT(0), KEEP(1), //1:1 matching
      LEFT OUTER);

    /*--- Sort by seq to preserve ThinTeaser original order ---*/
    sort_recs := PROJECT(SORT(recs_w_extra, seq), TRANSFORM(
      iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord,
      SELF := LEFT;
      ));

     AddressesTmp := PROJECT(sort_recs, TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord,
        MaskedAddresses := PROJECT(CHOOSEN(LEFT.addresses,iesp.Constants.ThinRpsExt.MaxAddresses),
          TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchMaskedAddress,
            StreetNumOrig := LEFT.StreetNumber;
            prim_rangeMasked := TeaserSearchServices.Constants.AddrMaskString;
            StreetNum := IF (DtcPhoneAddressTeaserMask, prim_rangeMasked, LEFT.streetNumber);
            SELF.StreetNumber := StreetNum;
            // special case to masks streetName if PO BOX only is in the
            MaskStreetName := IF ( 
                DtcPhoneAddressTeaserMask AND
                ((STD.Str.Find(LEFT.StreetName, 'PO',1) > 0) AND
                (STD.str.Find(LEFT.StreetName, 'BOX',1) > 0) AND
                StreetNumOrig = '')
                OR
                (DTCPhoneAddressTeaserMask AND
                (STD.str.Find(LEFT.StreetName, 'RR ',1) > 0) AND
                StreetNumOrig = ''),
              TeaserSearchServices.Constants.AddrMaskString,
              LEFT.StreetName);
            SELF.StreetName := MaskStreetName;

            STRING60 nonmaskedStreetInfo := TRIM(
                LEFT.StreetPreDirection + ' ' + MaskStreetName + ' ' +
                LEFT.StreetSuffix + ' ' + LEFT.StreetPostDirection + ' ' +
                LEFT.UnitDesignation + ' ' + LEFT.UnitNumber, 
              LEFT, RIGHT);
            SELF.StreetAddress1 := IF (DtcPhoneAddressTeaserMask, 
              prim_rangeMasked + ' ' + nonmaskedStreetInfo,
              LEFT.StreetNumber + ' ' + NonMaskedStreetInfo);

            SELF.Phones :=IF (DtcPhoneAddressTeaserMask AND IncludePhoneNumber,
              PROJECT(CHOOSEN(LEFT.Phones, iesp.Constants.ThinRpsExt.MaxPhones), TRANSFORM(iesp.share.t_StringArrayItem,
                tmpPhone10 := TRIM(LEFT.Phone10, LEFT, RIGHT);
                SELF.value := IF (tmpphone10 <> '',
                  '(' + tmpPhone10[1..3] + ') ' + TeaserSearchServices.Constants.phoneMaskString, 
                  LEFT.Phone10);
                SELF := [];
              )), DATASET([], iesp.share.t_StringArrayItem));
          SELF := LEFT;
        ));
        MaskedPhonesOnly := IF (DtcPhoneAddressTeaserMask AND IncludePhoneNumber AND (NOT(IncludeAddress)),
          PROJECT(MaskedAddresses, TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchMaskedAddress,
            SELF.Phones := IF (DtcPhoneAddressTeaserMask AND IncludePhoneNumber,
              PROJECT(CHOOSEN(LEFT.Phones, iesp.Constants.ThinRpsExt.MaxPhones),
                TRANSFORM(iesp.share.t_StringArrayItem,
                  tmpPhone10 := LEFT.value;
                  SELF.value := IF (tmpphone10 <> '',
                            '(' + tmpPhone10[1..3] + ') ' + TeaserSearchServices.Constants.phoneMaskString, LEFT.value);
                  SELF := [];
                )), 
              DATASET([],iesp.share.t_StringArrayItem));
            SELF := [];
          ))
        );
        SELF.MaskedAddresses := IF (DtcPhoneAddressTeaserMask AND IncludeAddress, MaskedAddresses,
          IF (DtcPhoneAddressTeaserMask AND IncludePhoneNumber AND (NOT(IncludeAddress)),
            MaskedPhonesOnly,
            DATASET([],iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchMaskedAddress)
          )
        );
        SELF := LEFT;
        SELF := []));

    //Student data routines
    college_name_rec := RECORD
      UNSIGNED6 DID;
      STRING50 LN_COLLEGE_NAME;
      UNSIGNED4 global_sid;
      UNSIGNED8 record_sid;
    END;

    student_data := JOIN(DEDUP(SORT(AddressesTmp,UniqueID),UniqueID),American_student_list.key_DID,
      KEYED((INTEGER)RIGHT.L_DID = (INTEGER)LEFT.UniqueID) AND
      RIGHT.LN_college_name <> '',
      TRANSFORM(RECORDOF(college_name_rec), SELF := RIGHT),
      LIMIT(0), KEEP(iesp.Constants.ThinRpsExt.MaxCountCollegeAddresses)) ;

    student_data_suppressed := Suppress.MAC_SuppressSource(student_data,mod_access,did);

    // now hit the email did key and get back email addressess and mask them.
    // did suppression already done.
    sort_recs_WithEmail := PROJECT(AddressesTmp,
      TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord,
        didValDS := DATASET([{(UNSIGNED6) LEFT.uniqueID}], doxie.layout_references);
        UNSIGNED6 didVal := (UNSIGNED6) LEFT.UniqueID;
        SELF.MaskedEmailAddresses :=
          IF (DtcPhoneAddressTeaserMask AND IncludeEmailAddress,
            JOIN(didValDS,Email_Data.Key_Did,
              LEFT.did = RIGHT.did,
              TRANSFORM( iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchEmail,
                tmpEmail := TRIM(RIGHT.clean_email,LEFT,RIGHT);
                // code to mask email here
                len := LENGTH(tmpemail);
                AtSignPos := std.str.find(tmpEmail,TeaserSearchServices.Constants.Atsign);
                MaskItAll := NOT(AtSignPos > 0);
                PositionOfLastDot := len - 3; // as in 3 from END 'abc@yahoo.com
                maskString := '*******************************************'; //
                MaskedEmail := 
                  tmpEmail[1] +
                  maskString[1..AtSignPos-2] +
                  TeaserSearchServices.Constants.AtSign +
                  maskstring[1..positionOfLastDot-AtSignPos-1] +
                  tmpEmail[len-3..len];
                        // ^^ 2 here is 1 past 1st char and 1 less than where @ sign is
                SELF.MaskedEmailAddress := MaskedEmail;
              ),LIMIT(0), KEEP(iesp.Constants.ThinRpsExt.MaxEmailAddresses)
               // ^^^^^ no choosen needed cause of this keep
            ),
            DATASET([], IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchEmail)
          );
      college_name := TRIM(student_data_suppressed(did = DIDval)[1].ln_college_name, LEFT, RIGHT);
      SELF.CollegeAddresses := CHOOSEN(
        IF (IncludeEducationInformation,
          PROJECT(
            PROJECT(American_student_list.key_Address_List(KEYED(LN_COLLEGE_NAME = college_name)),
                    TRANSFORM(LEFT)),
            TRANSFORM(IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchCollegeAddress,
              SELF.city := LEFT.v_city_name;
              SELF.state := LEFT.st)),
          DATASET([], IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchCollegeAddress)
        ),
        iesp.Constants.ThinRpsExt.MaxCountCollegeAddresses
      );
      SELF := LEFT;
    ));
    
    RETURN sort_recs_WithEmail;
  END;
  EXPORT getCounts(
    DATASET(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord) inrecs,
    INTEGER IncludeCounts,
    STRING32 application_Type_value
  ) := FUNCTION

   dsLookups := JOIN(inrecs, doxie.key_D2C_lookup(),
    (UNSIGNED6) LEFT.UNIQUEID = RIGHT.DID,
    TRANSFORM(RECORDOF(RIGHT),
      SELF := RIGHT;
    ),LIMIT(0), KEEP(1));

   dsLookupsIndexed := NORMALIZE(dsLookups,COUNT(TeaserSearchServices.Constants.Category),
    TRANSFORM({UNSIGNED6 didValue;
      iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedPersonCount;
      INTEGER categoryIndex},
        SELF.Didvalue := LEFT.did;
        SELF.Category := TeaserSearchServices.Constants.Category[COUNTER].categoryString;
        SELF.COUNT := CHOOSE(COUNTER
          ,LEFT.Addresses_cnt
          ,LEFT.PhonesPlus_cnt
          ,LEFT.Email_cnt
          ,LEFT.Education_Student_cnt
          ,LEFT.Possible_Relatives_and_Associates_cnt
          ,LEFT.Possible_Properties_owned_cnt
          ,LEFT.Criminal_Records_cnt
          ,LEFT.Sexual_Offenses_cnt
          ,LEFT.Liens_and_Judgements_cnt
          ,LEFT.Bankruptcies_cnt
          ,LEFT.Marriage_and_Divorce_cnt
          ,LEFT.Professional_Licenses_cnt
          ,LEFT.People_at_Work_possible_employment_records_cnt
          ,LEFT.Businesses_records_cnt
          ,LEFT.Corporate_affiliations_cnt
          ,LEFT.UCC_cnt
          ,LEFT.Hunting_and_Fishing_Permits_cnt
          ,LEFT.Concealed_Weapon_Permits_cnt
          ,LEFT.Firearms_and_Explosives_cnt
          ,LEFT.FAA_Aircraft_cnt
          ,LEFT.FAA_Pilot_cnt
        );
      SELF.categoryIndex := COUNTER;
      SELF.EXISTS := '';
    ));

  outrecs := PROJECT(inRecs,
    TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord,
      uniqueID := LEFT.UniqueID;
      SELF.uniqueID := LEFT.UniqueId;

      CountSet := dsLookupsIndexed(didvalue = (UNSIGNED6) UniqueID);
      SELF.personCounts := CHOOSEN(
        IF (IncludeCounts > 1,
          PROJECT(countSet,
            TRANSFORM(IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedPersonCount,
              SELF.category := Countset(categoryIndex = COUNTER)[1].Category;
              SELF.COUNT := IF (includeCounts = 3, countset(categoryIndex = COUNTER)[1].COUNT, 0);
              SELF.EXISTS := IF (includeCounts = 2 AND countset(categoryIndex = COUNTER)[1].COUNT > 0, 'Y','');
            )),
          DATASET([], IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedPersonCount)
        )
        , iesp.Constants.ThinRpsExt.MaxCountPersonCounts); // MAXCOUNT FOR CHOOSEN
        SELF := LEFT;
        ));
       RETURN outrecs;
    END;

END;
