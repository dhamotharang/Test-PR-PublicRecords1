// Get UCC data by tmsid records, and restructure in legacy format

IMPORT $, uccd, doxie_crs, UCCv2, suppress, Address, Census_data, doxie;

EXPORT Legacy := MODULE

SHARED fn_getUCC_legacy_super(
  DATASET($.layout_legacy.level_rec) in_levels,
  STRING in_ssn_mask_type,
  STRING32 appType = Suppress.Constants.ApplicationTypes.Default
) := FUNCTION
  // Suppress by tmsid
  Suppress.MAC_Suppress(in_levels,in_levels_suppress,appType,,,Suppress.Constants.DocTypes.UCC_TMSID,tmsid);
    
  // keys and layouts
  k_main := UCCV2.Key_Rmsid_Main(FALSE);
  k_party := UCCV2.Key_Rmsid_Party(FALSE);
  l_out := $.layout_legacy.super_rec;

  
  // ======================================================================= Filing data

  // transform filing to output-style fields
  l_fRaw := RECORD
    k_main.tmsid;
    k_main.rmsid;
    l_out.ucc_key;
      
    DATASET($.layout_legacy.collateral_rec) collateral_children {MAXCOUNT ($.Constants.MAX_LEGACY_COLLATERAL_RECS)};
    
    l_out.filing_state;
    l_out.orig_filing_date;
    l_out.filing_date;
    l_out.event_document_num;
    l_out.filing_type_desc;
    
    l_out.filing_count;
    l_out.document_count;
    
    l_out.level; // raw only
    l_out.debtor_event_key; // raw only
    l_out.debtor_status_desc; // raw only
    l_out.secured_event_key; // raw only
    l_out.secured_status_desc; // raw only
    l_out.ucc_exp_date; // raw only
    l_out.ucc_filing_type_desc; // raw only
    l_out.event_key; // raw only
    l_out.orig_filing_num; // raw only
  END;
  l_fRaw toFiling(in_levels_suppress L, k_main R) := TRANSFORM
    SELF.tmsid := R.tmsid;
    SELF.rmsid := R.rmsid;
    SELF.ucc_key := R.orig_filing_number;
    
    SELF.collateral_children := IF(
      R.collateral_desc<>'',
      DATASET( [{R.collateral_desc}], $.layout_legacy.collateral_rec ),
      DATASET( [], $.layout_legacy.collateral_rec )
    );
    
    SELF.filing_state := r.filing_jurisdiction;
    SELF.orig_filing_date := r.orig_filing_date;
    SELF.filing_date := r.filing_date;
    SELF.event_document_num := r.filing_number;
    SELF.filing_type_desc := r.filing_type;
    
    SELF.level := L.level;
    SELF.debtor_event_key := R.orig_filing_number;
    SELF.debtor_status_desc := R.status_type;
    SELF.secured_event_key := R.orig_filing_number;
    SELF.secured_status_desc := R.status_type;
    SELF.ucc_exp_date := R.expiration_date;
    SELF.ucc_filing_type_desc := R.orig_filing_type;
    SELF.event_key := R.orig_filing_number;
    SELF.orig_filing_num := R.orig_filing_number;
    
    // we'll fill these in later
    SELF.filing_count := '';
    SELF.document_count := '';
  END;

  // retrieve filings from key
  filing_raw := JOIN(
    in_levels_suppress, k_main,
    KEYED(LEFT.tmsid = RIGHT.tmsid),
    toFiling(LEFT,RIGHT),
    LIMIT($.Constants.MAX_LEGACY_RAW_FILINGS,SKIP)
  );
  
  // rollup collateral
  filing_raw toRollup(filing_raw l, filing_raw r) := TRANSFORM
    SELF.collateral_children := CHOOSEN(L.collateral_children & R.collateral_children, $.Constants.MAX_LEGACY_COLLATERAL_RECS);
    SELF := L;
  END;
  filing_rolled := ROLLUP(
    SORT(filing_raw, tmsid, rmsid, RECORD),
    toRollup(LEFT, RIGHT),
    tmsid, rmsid
  );
  
  // generate counts
  l_fCnt := RECORD
    STRING50 tmsid := filing_rolled.tmsid;
    STRING4 filing_count := (STRING) COUNT(GROUP); // STUB - this is apparently wrong. see did=2121691822
    STRING4 document_count := (STRING) COUNT(GROUP); // # of rmsids per tmsid
  END;
  filing_c := table(filing_rolled, l_fCnt, tmsid);

  // and merge them back into the filing recs
  filing_counted := JOIN(
    filing_rolled, filing_c,
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(l_fRaw, SELF:=RIGHT, SELF:= LEFT)
  );
  

  // ======================================================================= Party data
  
  // retrieve from key and add county_name
  l_pCounty := { k_party; STRING18 county_name; };
  party_raw := CHOOSEN(JOIN(
    in_levels_suppress, k_party,
    KEYED(LEFT.tmsid = RIGHT.tmsid),
    TRANSFORM(l_pCounty, SELF.county_name:='', SELF:=RIGHT),
    LIMIT(10000,SKIP)
  )(party_type='D' OR party_type='S'), $.Constants.MAX_LEGACY_RAW_PARTIES);
  Census_Data.MAC_Fips2County_Keyed(party_raw, st, county, county_name, party_county);
  
  // transform output-style fields
  l_pRaw := RECORD
    k_party.tmsid;
    k_party.party_type;
    
    l_out.penalt;
    l_out.did;
    l_out.bdid;
    
    l_out.debtor_fname;
    l_out.debtor_mname;
    l_out.debtor_lname;
    l_out.debtor_name_suffix;
    
    l_out.debtor_name;
    l_out.debtor_prim_range;
    l_out.debtor_predir;
    l_out.debtor_prim_name;
    l_out.debtor_addr_suffix;
    l_out.debtor_postdir;
    l_out.debtor_unit_desig;
    l_out.debtor_sec_range;
    l_out.debtor_city_name;
    l_out.debtor_county_name;
    l_out.debtor_st;
    l_out.debtor_zip;
    l_out.debtor_zip4;
    
    l_out.secured_name;
    l_out.secured_prim_range;
    l_out.secured_predir;
    l_out.secured_prim_name;
    l_out.secured_addr_suffix;
    l_out.secured_postdir;
    l_out.secured_unit_desig;
    l_out.secured_sec_range;
    l_out.secured_city_name;
    l_out.secured_county_name;
    l_out.secured_st;
    l_out.secured_zip;
    l_out.secured_zip4;
    
    l_out.debtor_count;
    l_out.secured_count;
  END;
  l_pRaw toParty(party_county R) := TRANSFORM
    SELF.tmsid := R.tmsid;
    SELF.party_type := R.party_type;
    
    SELF.penalt :=
      doxie.FN_Tra_Penalty_CName( R.company_name ) +
      doxie.FN_Tra_Penalty_BDID( (STRING)R.bdid ) +
      doxie.FN_Tra_Penalty_DID( (STRING)R.did ) +
      doxie.FN_Tra_Penalty_SSN(R.ssn) +
      doxie.FN_Tra_Penalty_FEIN(R.fein) +
      doxie.FN_Tra_Penalty_Name(R.fname, R.mname, R.lname);
         
    isDebtor := (R.party_type='D');
    isSecured := (R.party_type='S');
    
    SELF.did := IF(isDebtor, R.did, 0);
    SELF.bdid := IF(isDebtor, R.bdid, 0);
    SELF.debtor_fname := IF(isDebtor, R.fname, '');
    SELF.debtor_mname := IF(isDebtor, R.mname, '');
    SELF.debtor_lname := IF(isDebtor, R.lname, '');
    SELF.debtor_name_suffix := IF(isDebtor, R.name_suffix, '');
    SELF.debtor_name := IF(isDebtor, R.orig_name, '');
    SELF.debtor_prim_range := IF(isDebtor, R.prim_range, '');
    SELF.debtor_predir := IF(isDebtor, R.predir, '');
    SELF.debtor_prim_name := IF(isDebtor, R.prim_name, '');
    SELF.debtor_addr_suffix := IF(isDebtor, R.suffix, '');
    SELF.debtor_postdir := IF(isDebtor, R.postdir, '');
    SELF.debtor_unit_desig := IF(isDebtor, R.unit_desig, '');
    SELF.debtor_sec_range := IF(isDebtor, R.sec_range, '');
    SELF.debtor_city_name := IF(isDebtor, R.p_city_name, '');
    SELF.debtor_county_name := IF(isDebtor, R.county_name, '');
    SELF.debtor_st := IF(isDebtor, R.st, '');
    SELF.debtor_zip := IF(isDebtor, R.zip5, '');
    SELF.debtor_zip4 := IF(isDebtor, R.zip4, '');
    
    SELF.secured_name := IF(isSecured, R.orig_name, '');
    SELF.secured_prim_range := IF(isSecured, R.prim_range, '');
    SELF.secured_predir := IF(isSecured, R.predir, '');
    SELF.secured_prim_name := IF(isSecured, R.prim_name, '');
    SELF.secured_addr_suffix := IF(isSecured, R.suffix, '');
    SELF.secured_postdir := IF(isSecured, R.postdir, '');
    SELF.secured_unit_desig := IF(isSecured, R.unit_desig, '');
    SELF.secured_sec_range := IF(isSecured, R.sec_range, '');
    SELF.secured_city_name := IF(isSecured, R.p_city_name, '');
    SELF.secured_county_name := IF(isSecured, R.county_name, '');
    SELF.secured_st := IF(isSecured, R.st, '');
    SELF.secured_zip := IF(isSecured, R.zip5, '');
    SELF.secured_zip4 := IF(isSecured, R.zip4, '');
    
    // we'll fill these in later
    SELF.debtor_count := '';
    SELF.secured_count := '';
  END;
  party_out := PROJECT(party_county, toParty(LEFT));
  
  // dedup
  party_dedup := DEDUP(SORT(party_out,RECORD), RECORD);

  // populate party counts
  l_pCnt := RECORD
    STRING50 tmsid := party_dedup.tmsid;
    STRING3 cnt := (STRING) COUNT(GROUP);
  END;
  party_cd := table(party_dedup(party_type='D'), l_pCnt, tmsid);
  party_cs := table(party_dedup(party_type='S'), l_pCnt, tmsid);
  
  // and join them back together
  party_tmp := JOIN(
    party_dedup, party_cd, // debtor
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(l_pRaw, SELF.debtor_count:=RIGHT.cnt, SELF:=LEFT)
  );
  party_counted := JOIN(
    party_tmp, party_cs, // secured
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(l_pRaw, SELF.secured_count:=RIGHT.cnt, SELF:=LEFT)
  );

  // reduce to one debtor and one secured (preferring low penalties)
  party_reduced := DEDUP(
    SORT(party_counted, tmsid, party_type, penalt, RECORD),
    tmsid, party_type
  );
  

  // ======================================================================= Assimilate Filing & Party Data

  // add debtor
  filing_with_d := JOIN(
    filing_counted, party_reduced,
    LEFT.tmsid=RIGHT.tmsid AND RIGHT.party_type='D'
  );
  
  // add secured & convert to final format
  l_out addSecured(filing_with_d L, party_reduced R) := TRANSFORM
    SELF.secured_name := R.secured_name;
    SELF.secured_prim_range := R.secured_prim_range;
    SELF.secured_predir := R.secured_predir;
    SELF.secured_prim_name := R.secured_prim_name;
    SELF.secured_addr_suffix := R.secured_addr_suffix;
    SELF.secured_postdir := R.secured_postdir;
    SELF.secured_unit_desig := R.secured_unit_desig;
    SELF.secured_sec_range := R.secured_sec_range;
    SELF.secured_city_name := R.secured_city_name;
    SELF.secured_county_name := R.secured_county_name;
    SELF.secured_st := R.secured_st;
    SELF.secured_zip := R.secured_zip;
    SELF.secured_zip4 := R.secured_zip4;
    SELF := L;
  END;
  filing_with_sd := JOIN(
    filing_with_d, party_reduced,
    LEFT.tmsid=RIGHT.tmsid AND RIGHT.party_type='S',
    addSecured(LEFT,RIGHT)
  );
  
  // final sort
  ucc_legacy := SORT(filing_with_sd, orig_filing_date, filing_date, RECORD);
  // NOTE: Looking at the old system, I see it's sorting by orig_filing_date,
  // but doesn't have a secondary sort by filing_date. That doesn't make much
  // sense to me. I'm adding it anyway.



  RETURN(ucc_legacy);

END; // fn_getUCC_legacy_super

EXPORT fn_getUCC_legacy_raw(
  DATASET(UCCv2_services.layout_tmsid) in_tmsids,
  STRING in_ssn_mask_type
) := FUNCTION

  // create a fake level (which we'll strip later anyway)
  in_levels := PROJECT( in_tmsids, TRANSFORM($.layout_legacy.level_rec, SELF.level:=0, SELF:=LEFT) );
  
  super := fn_getUCC_legacy_super(in_levels, in_ssn_mask_type);
  
  raw := PROJECT( super, $.layout_legacy.raw_rec );
  
  RETURN(raw);

END; // fn_getUCC_legacy_raw

EXPORT fn_getUCC_legacy_rawLevels(
  DATASET($.layout_legacy.level_rec) in_levels,
  STRING in_ssn_mask_type
) := FUNCTION

  super := fn_getUCC_legacy_super(in_levels, in_ssn_mask_type);
  
  raw := PROJECT( super, $.layout_legacy.raw_level_rec );
  
  RETURN(raw);

END; // fn_getUCC_legacy_rawLevels

EXPORT fn_getUCC_legacy(
  DATASET(UCCv2_services.layout_tmsid) in_tmsids,
  STRING in_ssn_mask_type
) := FUNCTION

  // create a fake level (which we'll strip later anyway)
  in_levels := PROJECT( in_tmsids, TRANSFORM($.layout_legacy.level_rec, SELF.level:=0, SELF:=LEFT) );
  
  // retrieve results (a bit wider than necessary)
  raw := fn_getUCC_legacy_super(in_levels, in_ssn_mask_type);

  // narrow to output format
  outrecs := PROJECT( raw, $.layout_legacy.ucc_rec );

  // final sort
  ucc_legacy := SORT(outrecs, orig_filing_date, filing_date, RECORD);
  // NOTE: Looking at the old system, I see it's sorting by orig_filing_date,
  // but doesn't have a secondary sort by filing_date. That doesn't make much
  // sense to me. I'm adding it anyway.
  
  RETURN(ucc_legacy);

END; // fn_getUCC_legacy

END; // Legacy
