import doxie, Address, dx_Header, doxie_raw, DeathV2_Services;

// Code below has been moved from BatchServices.Functions.fn_xtra_death_info()
EXPORT GetExtraDeathInfo(DATASET(DeathV2_Services.Layouts.BatchIntermediateData) inrecs,
                         doxie.IDataAccess mod_access) := FUNCTION

    //create temporary module for fetching header records
    this_mod_access := MODULE(PROJECT(mod_access, doxie.IDataAccess))
      EXPORT unsigned3 date_threshold := 0;
      EXPORT boolean ln_branded := TRUE;
      EXPORT boolean probation_override := TRUE;
      EXPORT string ssn_mask := 'NONE';
    END;

    // Logic to pull dids by SSNs below is based on SSN_Services.SSNBatchConfirmDiscrepantService
    layout_ssn := RECORD
      UNSIGNED8 seq;
      STRING9   ssn;
      UNSIGNED6 did;
    END;

    // doxie.layout_inBatchMaster xfm_inBatchMaster(Layouts.BatchIntermediateData L, integer C) := TRANSFORM
    layout_ssn transform_SSNBatchCDInputToSSN(DeathV2_Services.Layouts.BatchIntermediateData L, integer C) := TRANSFORM
      SELF.seq := C; // to avoid calling ut.MAC_Sequence_Records;
      SELF.ssn := L.ssn;
      SELF.did := 0; // L.did ???
      // SELF.max_results := '50'; // ?? don't think this was really needed...
    END;

    in_ssn_dup := DEDUP(SORT(inrecs(ssn!=''),EXCEPT acctno),EXCEPT acctno);
    in_ssns := GROUP(PROJECT(in_ssn_dup, transform_SSNBatchCDInputToSSN(LEFT, COUNTER)), ssn);

    //****** GET THE DIDS

    key_header_ssn := dx_Header.key_SSN();
    layout_ssn get_dds(layout_ssn l, key_header_ssn r) := TRANSFORM
      SELF.seq := l.seq;
      SELF.ssn := l.ssn;
      SELF.did := r.did;
    END;

    wdid := JOIN(in_ssns, key_header_ssn,
              LEFT.ssn[1]=RIGHT.s1 AND
              LEFT.ssn[2]=RIGHT.s2 AND
              LEFT.ssn[3]=RIGHT.s3 AND
              LEFT.ssn[4]=RIGHT.s4 AND
              LEFT.ssn[5]=RIGHT.s5 AND
              LEFT.ssn[6]=RIGHT.s6 AND
              LEFT.ssn[7]=RIGHT.s7 AND
              LEFT.ssn[8]=RIGHT.s8 AND
              LEFT.ssn[9]=RIGHT.s9,get_dds(LEFT, RIGHT), LEFT OUTER, ATMOST(500));

    dids := DEDUP(wdid, ALL);

    //****** GET HEADER RECS FOR DIDS

    doxie_raw.Layout_HeaderRawBatchInput transform_SSNForHead(layout_ssn l) :=
    TRANSFORM
      SELF.input.seq := l.seq;
      SELF.input.did := l.did;
      SELF := [];
    END;

    forhead := GROUP(PROJECT(dids,transform_SSNForHead(LEFT)), did);

    head := doxie_raw.Header_Raw_batch(forhead, this_mod_access)(prim_name[1..4]<>'DOD '); // ?? what is this???
    ds_ungrp := UNGROUP(head);

    //   slim and dedup header records being used in the JOIN below
    Layout_HeaderRawBatchSlim := RECORD
      doxie_raw.Layout_HeaderRawBatchInput
      AND NOT [input, s_did, did, rid, pflag1, pflag2, pflag3, src, dt_first_seen, dt_last_seen,
      dt_vendor_first_reported, dt_nonglb_last_seen, rec_type, vendor_id, phone, dob, title,
      mname, lname, name_suffix, geo_blk, cbsa, tnt, valid_ssn, jflag1, jflag2, jflag3, valid_dob,
      hhid, listed_name, listed_phone, dod, death_code, lookup_did, glb, dppa, ssn_unmasked];
      //TODO: find out if these can/should be also removed: RawAID, persistent_record_ID, global_sid, record_sid
    END;

    ds_ungrp_slim := PROJECT(ds_ungrp,Layout_HeaderRawBatchSlim);
    ds_ungrp_addr := SORT(ds_ungrp_slim,ssn,prim_range,predir,prim_name,suffix,
                          postdir,unit_desig,sec_range,city_name,st,zip,fname,-dt_vendor_last_reported);
    ds_ungrp_dup := DEDUP(ds_ungrp_addr,EXCEPT dt_vendor_last_reported);

    //   give preference to latest address for records being used in the JOIN below
    ds_ungrp_srt := SORT(ds_ungrp_dup, -dt_vendor_last_reported);

    // overwriting zip_lastres and state values on death record to be consistent with address being used
    DeathV2_Services.Layouts.BatchOut xfm_out(DeathV2_Services.Layouts.BatchIntermediateData L, Layout_HeaderRawBatchSlim R ) :=
    TRANSFORM
      SELF.prim_range   := R.prim_range;
      SELF.predir       := R.predir;
      SELF.prim_name    := R.prim_name;
      SELF.addr_suffix  := R.suffix;
      SELF.postdir      := R.postdir;
      SELF.unit_desig   := R.unit_desig;
      SELF.sec_range    := R.sec_range;
      SELF.p_city_name  := R.city_name;
      SELF.county_name  := R.county_name;
      SELF.state        := R.st;
      SELF.st           := R.st;
      SELF.zip_lastres  := R.zip;
      SELF.zip          := R.zip;
      SELF.zip4         := R.zip4;
      SELF.fipscounty   := R.county;
      SELF.address      := Address.Addr1FromComponents(R.prim_range, R.predir, R.prim_name,
                                R.suffix, R.postdir, R.unit_desig, R.sec_range);
      SELF := L;
    END;

    //
    //  join header info to input dataset
    //  keeping the records that match input address info, fname, ssn
    //  for now, not taking unit_desig and sec_range into account to allow
    //  for more changes of matching something in the address info rather
    //  than assuring that the apartment number, etc. is the same
    //
    IncomingAddressMatches() := MACRO
      (LEFT.incoming_prim_range  = RIGHT.prim_range OR LEFT.incoming_prim_range  = '') AND
      (LEFT.incoming_predir      = RIGHT.predir     OR LEFT.incoming_predir      = '') AND
      (LEFT.incoming_prim_name   = RIGHT.prim_name  OR LEFT.incoming_prim_name   = '') AND
      (LEFT.incoming_addr_suffix = RIGHT.suffix     OR LEFT.incoming_addr_suffix = '') AND
      (LEFT.incoming_postdir     = RIGHT.postdir    OR LEFT.incoming_postdir     = '') AND
      // (LEFT.incoming_unit_desig   = RIGHT.unit_desig    OR LEFT.incoming_unit_desig    = '') AND
      // (LEFT.incoming_sec_range   = RIGHT.sec_range    OR LEFT.incoming_sec_range    = '') AND
      (LEFT.incoming_p_city_name = RIGHT.city_name  OR LEFT.incoming_p_city_name  = '') AND
      (LEFT.incoming_st          = RIGHT.st         OR LEFT.incoming_st = '') AND
      (LEFT.incoming_z5          = RIGHT.zip        OR LEFT.incoming_z5 = '')
    ENDMACRO;

    IncomingAddressEmpty() := MACRO
      TRIM(
        LEFT.incoming_prim_range   + LEFT.incoming_predir   + LEFT.incoming_prim_name   +
        LEFT.incoming_addr_suffix   + LEFT.incoming_postdir + LEFT.incoming_p_city_name
        , ALL) = ''
    ENDMACRO;

    //
    //  keep records whose incoming addresses either match something on the header
    //  or if their incoming address is empty, match header records whose zip and state
    //  match that provided in the death key (zip_lastres and state on RIGHT)
    //
    JoinCond() := MACRO
      (LEFT.ssn = RIGHT.ssn)
      AND
      (LEFT.fname = RIGHT.fname OR LEFT.fname = '')
      AND
      (
        IncomingAddressMatches()
        OR
        (
          IncomingAddressEmpty()
          AND
          (
            (LEFT.state = RIGHT.st AND LEFT.zip_lastres = RIGHT.zip)
            OR
            (LEFT.state = '' AND LEFT.zip_lastres = '')
          )
        )
      )
    ENDMACRO;

    ds_jn   := JOIN(inrecs(ssn!=''), ds_ungrp_srt, JoinCond(), xfm_out(LEFT, RIGHT)); ///, KEEP(1));

    //
    //  Now add recs that weren't true in the join condition.
    //  The reason for not just doing a LEFT JOIN is to avoid the records that don't evaluate to
    //  true from passing through the transform. I then apply a PROJECT to those separately below.
    //  (that way, i can preserve info on the original record whether or not the address matches
    //  something in the header)
    //
    //
    ds_in_dcout_rec := PROJECT(inrecs, DeathV2_Services.Layouts.BatchOut);
    ds_all := ds_jn + ds_in_dcout_rec;

    // favor those recs that have a address and st in the sort and those recs with higher did_score
    ds_srt   := SORT(ds_all, acctno, state_death_id, IF(address!='',0,1), IF(st!='',0,1), -did_score);
    ds_ddp   := DEDUP(ds_srt, acctno, state_death_id);
    RETURN ds_ddp;

END;
