IMPORT doxie, STD, ut, suppress, UCCv2_Services;

UCCv2_Services.MAC_Field_Declare();

EXPORT fn_format_parties_src(
  DATASET(uccv2_services.layout_ucc_party_raw_src) in_data,
  STRING1 in_party,
  STRING in_ssn_mask_type,
  UNSIGNED2 max_parties_per_page = 25,
  BOOLEAN return_multiple_pages = FALSE
) := FUNCTION

  // Skip worthless records
  in_decent := in_data(
    party_type = in_party,
    ssn != '' OR
    fein != '' OR
    orig_name != '' OR
    title != '' OR
    lname != '' OR
    fname != '' OR
    mname != '' OR
    name_suffix != ''
  );
  
  // Were we searching against these parties? (needed for penalties)
  partiesSearched := ((party_type='') OR (party_type=in_party));

  // Narrow to (flattened) name information
  layout_name := RECORD
    in_data.tmsid;
    in_data.Party_type;
    in_data.Orig_name;
    in_data.company_name;
    UCCv2_Services.layout_ucc_party_parsed_src;
  END;
  names := PROJECT(in_decent, layout_name);
  
  // Sort and dedup the names
  names_p := names(lname<>'' AND fname<>''); // parsed
  names_u := names(lname='' OR fname=''); // unparsed
  names_p_d := DEDUP( SORT( names_p, RECORD, EXCEPT orig_name), RECORD, EXCEPT orig_name ); // parsed & deduped
  names_u_d := DEDUP( SORT( names_u, RECORD ), RECORD ); // unparsed & deduped
  deduped_names := SORT(names_p_d + names_u_d, RECORD); // assimilated

  // Narrow to (flattened) address information
  layout_addr := RECORD
    in_data.tmsid;
    in_data.Orig_name;
    in_data.title;
    in_data.lname;
    in_data.fname;
    in_data.mname;
    in_data.name_suffix;
    in_data.bdid;
    in_data.did;
    uccv2_services.layout_ucc_party_address_src;
  END;
  addresses := PROJECT(in_decent, layout_addr);
  
  // Sort and dedup the addresses
  deduped_addresses := DEDUP(SORT(addresses, RECORD));
  

  // Take deduped_names and project the name information
  // for a party into a child dataset, per the layout requirements.
  layout_name_child := RECORD
    in_data.tmsid;
    in_data.Party_type;
    in_data.orig_name;
    in_data.company_name;
    in_data.title;
    in_data.lname;
    in_data.fname;
    in_data.mname;
    in_data.name_suffix;
    in_data.bdid;
    in_data.did;
    DATASET(UCCv2_Services.layout_ucc_party_parsed_src) names{MAXCOUNT(25)};
    UNSIGNED2 penalt;
  END;
  
  // Mask SSNs (after SSN penalty has been calculated)
  DATASET(UCCv2_Services.layout_ucc_party_parsed) maskNames(layout_name l) := FUNCTION
    nms := DATASET(
      [{
        L.bdid,
        l.dotid,
        l.empid,
        l.powid,
        l.proxid,
        l.seleid,
        l.orgid,
        l.ultid,
        L.did,
        L.title,
        L.lname,
        L.fname,
        L.mname,
        L.name_suffix,
        L.ssn,
        L.fein,
        L.Incorp_state,
        L.corp_number,
        L.corp_type
      }],
      UCCv2_Services.layout_ucc_party_parsed
    );
    Suppress.MAC_Mask(nms, names_masked, ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask_type);
    RETURN names_masked;
  END;
  
  layout_name_child xf_name_child(layout_name L) := TRANSFORM
    old_penalt :=
         doxie.FN_Tra_Penalty_CName( L.company_name ) +
         doxie.FN_Tra_Penalty_BDID( (STRING)L.bdid ) +
         doxie.FN_Tra_Penalty_DID( (STRING)L.did ) +
         doxie.FN_Tra_Penalty_FEIN(L.fein) +
         doxie.FN_Tra_Penalty_SSN(L.ssn) +
         doxie.FN_Tra_Penalty_Name(L.fname, L.mname, L.lname);
    extra_penalt := IF(
      // only add extra penalty when company name is input
      L.company_name<>'' AND comp_name_value<>'',
      ut.STRINGsimilar100(L.company_name, comp_name_value),
      0
    );
    SELF.penalt := (old_penalt * uccPenalty.scale) + extra_penalt;
    SELF.names := maskNames(l);
    SELF := L;
  END;
  
  // prune old ssn references if requested
  doxie.MAC_PruneOldSSNs(deduped_names, deduped_names_pruned, ssn, did);
  
  name_child := PROJECT(deduped_names_pruned, xf_name_child(LEFT));


  // Concatenate all related records from each of the child datasets.
  layout_name_child xf_rollup_name_child(layout_name_child l, layout_name_child r) := TRANSFORM
    SELF.names := CHOOSEN(l.names + r.names,25);
    SELF := l;
  END;
  
  // Build the new recordset/rollup. Use the 'keyname' key to roll up those records
  // whose did is zero/invalid and bdid is zero/invalid and lname and fname and mname and
  // cname are equivalent.
  rollup_name_child := ROLLUP(
    name_child,
    LEFT.tmsid = RIGHT.tmsid AND
      LEFT.orig_name = RIGHT.orig_name AND
      LEFT.title = RIGHT.title AND
      LEFT.lname = RIGHT.lname AND
      LEFT.fname = RIGHT.fname AND
      LEFT.mname = RIGHT.mname AND
      LEFT.name_suffix = RIGHT.name_suffix AND
      LEFT.did = 0 AND RIGHT.did = 0 AND
      LEFT.bdid = 0 AND RIGHT.bdid = 0,
    xf_rollup_name_child(LEFT, RIGHT));
  
  // Take deduped_addresses and project the address information for
  // a party into a child dataset, per the layout requirements.
  layout_addr_child := RECORD
    in_data.tmsid;
    in_data.orig_name;
    in_data.title;
    in_data.lname;
    in_data.fname;
    in_data.mname;
    in_data.name_suffix;
    in_data.bdid;
    in_data.did;
    DATASET(UCCv2_Services.layout_ucc_party_address_src) addresses{MAXCOUNT(25)};
    UNSIGNED2 penalt;
  END;
  layout_addr_child xf_addr_child(layout_addr L) := TRANSFORM
    old_penalt := doxie.FN_Tra_Penalty_Addr(
      L.predir, L.prim_range, L.prim_name, L.addr_suffix, L.postdir, L.sec_range,
      L.v_city_name, L.st, L.zip5);
    SELF.penalt := old_penalt * uccPenalty.scale;
    SELF.addresses := DATASET([TRANSFORM(layout_ucc_party_address_src,SELF:=L)]);
    SELF := L;
  END;
  addr_child := PROJECT(deduped_addresses, xf_addr_child(LEFT));
  
  // Specify yet another TRANSFORM, which will roll up (i.e. concatenate) all related
  // records from each of the child datasets.
  layout_addr_child xf_rollup_addr_child(layout_addr_child l, layout_addr_child r) := TRANSFORM
    SELF.addresses := CHOOSEN(l.addresses & r.addresses,25);
    SELF := l;
  END;
  
  // Build the new recordset/rollup.
  rollup_addr_child := ROLLUP(
    SORT(
      addr_child,
      tmsid, orig_name, lname, fname, mname, name_suffix, penalt
    ),
    LEFT.tmsid = RIGHT.tmsid AND
      LEFT.orig_name = RIGHT.orig_name AND
      LEFT.title = RIGHT.title AND
      LEFT.lname = RIGHT.lname AND
      LEFT.fname = RIGHT.fname AND
      LEFT.mname = RIGHT.mname AND
      LEFT.name_suffix = RIGHT.name_suffix AND
      LEFT.did = 0 AND RIGHT.did = 0 AND
      LEFT.bdid = 0 AND RIGHT.bdid = 0,
    xf_rollup_addr_child(LEFT, RIGHT));
  
  // Join the party's NAMES to their ADDRESSES.
  layout_party := RECORD
    in_data.tmsid;
    DATASET(UCCv2_Services.layout_ucc_party_src) parties{MAXCOUNT(25)};
    UNSIGNED2 penalt;
  END;
  layout_party xf_party(layout_name_child L, layout_addr_child R) := TRANSFORM
    SELF.penalt := IF(
      partiesSearched,
      L.penalt + R.penalt,
      uccPenalty.large
    );
    SELF.tmsid := L.tmsid;
    SELF.parties := DATASET(
      [{
        IF(
          L.orig_name != '',
          L.orig_name,
          STD.Str.CleanSpaces(
            L.title + ' ' + L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix
          )
        ),
        CHOOSEN(L.names, 10),
        CHOOSEN(R.addresses, 10)
      }],
      UCCv2_Services.layout_ucc_party_src
    );
  END;
  party := JOIN(
    rollup_name_child, rollup_addr_child,
    LEFT.tmsid = RIGHT.tmsid AND
      LEFT.orig_name = RIGHT.orig_name AND
      LEFT.title = RIGHT.title AND
      LEFT.lname = RIGHT.lname AND
      LEFT.fname = RIGHT.fname AND
      LEFT.mname = RIGHT.mname AND
      LEFT.name_suffix = RIGHT.name_suffix AND
      LEFT.bdid = RIGHT.bdid AND
      LEFT.did = RIGHT.did,
    xf_party(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Optionally throw out all but one party
  max_parties := IF(
    in_party='D',
    IF(retRolledDebtors, 25, 1),
    IF(incMultSecured, 25, 1)
  );
  // NOTE: Should IncludeMultipleSecured be applied to assignee and creditor
  // records? Should they have their own comparable parameters? Should they
  // always be max_parties=1?

  // Rollup the parties under the same tmsid.

  party_sorted := SORT(party, tmsid, penalt, RECORD);

// ========================================================================

  // ***** Paginate parties. *****
  
  ds_parties_grouped := GROUP(party_sorted, tmsid);
        
  // 1. Add page number, iterating at each maxcount...
  
  layout_party_plus_page_no := RECORD
    layout_party;
    INTEGER page_no;
  END;

  layout_party_plus_page_no xfm_assign_page_no(layout_party l, INTEGER c) := TRANSFORM
    SELF.page_no := ((c - 1) DIV max_parties_per_page) + 1;
    SELF := l;
  END;

  ds_parties_with_page_no := PROJECT(ds_parties_grouped, xfm_assign_page_no(LEFT,COUNTER));

  // 2. Regroup by tmsid and page number...:

  ds_parties_regrouped := GROUP(SORT(UNGROUP(ds_parties_with_page_no), tmsid, page_no), tmsid, page_no);

  // 3. And roll up by tmsid and page number...:

  layout_parties_having_page_no := RECORD
    in_data.tmsid;
    DATASET(UCCv2_Services.layout_ucc_party_src) parties {MAXCOUNT(max_parties_per_page)};
    UNSIGNED2 penalt;
    INTEGER page_no;
  END;
  
  layout_parties_having_page_no xfm_rollup_parties(layout_party_plus_page_no l, DATASET(layout_party_plus_page_no) allRows) := TRANSFORM
    SELF.penalt := l.penalt;
    SELF.tmsid := l.tmsid;
    SELF.parties := CHOOSEN( PROJECT(allRows.parties, UCCv2_Services.layout_ucc_party_src), max_parties_per_page );
    SELF.page_no := l.page_no;
  END;
  
  ds_parties_rolled := ROLLUP(ds_parties_regrouped, GROUP, xfm_rollup_parties(LEFT,ROWS(LEFT)));
  
  RETURN IF( return_multiple_pages, ds_parties_rolled, ds_parties_rolled(page_no = 1) );
  
END;
