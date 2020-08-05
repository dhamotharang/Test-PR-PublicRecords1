IMPORT doxie, suppress, FFD, STD;

UCCv2_Services.MAC_Field_Declare();

gm := AutoStandardI.GlobalModule();

EXPORT fn_format_parties(
  DATASET(uccv2_services.layout_ucc_party_raw) in_data,
  STRING1 in_party,
  STRING in_ssn_mask_type,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

  // Skip worthless records
  in_decent := in_data(
    party_type = in_party,
    ssn != '' OR
    fein != '' OR
    orig_name != '' OR
    lname != '' OR
    fname != '' OR
    mname != '' OR
    name_suffix != ''
  );

  // Narrow to (flattened) name information
  layout_name := RECORD
    in_data.tmsid;
    in_data.Party_type;
    in_data.Orig_name;
    in_data.company_name;
    UCCv2_Services.layout_ucc_party_parsed;
    FFD.Layouts.CommonRawRecordElements;
  END;
  names := PROJECT(in_decent, TRANSFORM(layout_name, SELF := LEFT, SELF := []));

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
    uccv2_services.layout_ucc_party_address;
    FFD.Layouts.CommonRawRecordElements;
  END;
  addresses := PROJECT(in_decent, TRANSFORM(layout_addr, SELF := LEFT; SELF := []));

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
    DATASET(UCCv2_Services.layout_ucc_party_parsed) names{MAXCOUNT(25)};
    UNSIGNED2 penalt1;
    UNSIGNED2 penalt2;
    FFD.Layouts.CommonRawRecordElements;
  END;

  // Mask SSNs (after SSN penalty has been calculated)
  DATASET(UCCv2_Services.layout_ucc_party_parsed) maskNames(layout_name l) := FUNCTION
    nms := DATASET([TRANSFORM(UCCv2_Services.layout_ucc_party_parsed,SELF:=L)]);
    Suppress.MAC_Mask(nms, names_masked, ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask_type);
    RETURN names_masked;
  END;
  
  layout_name_child xf_name_child(layout_name L) := TRANSFORM
    temp_mod_biz_name_1 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
      EXPORT cname_field := l.company_name;
    END;
    temp_mod_biz_name_2 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
      EXPORT companyname := gm.entity2_companyname;
      EXPORT cname_field := l.company_name;
    END;
    temp_mod_bdid_1 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
      EXPORT bdid_field := (STRING)l.bdid;
    END;
    temp_mod_bdid_2 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
      EXPORT bdid := gm.entity2_bdid;
      EXPORT bdid_field := (STRING)l.bdid;
    END;
    temp_mod_business_ids_1 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_BusinessIds.full,opt))
      EXPORT ultid_field := l.ultid;
      EXPORT orgid_field := l.orgid;
      EXPORT seleid_field := l.seleid;
      EXPORT proxid_field := l.proxid;
      EXPORT powid_field := l.powid;
      EXPORT empid_field := l.empid;
      EXPORT dotid_field := l.dotid;
    END;
    temp_mod_did_1 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
      EXPORT did_field := (STRING)l.did;
    END;
    temp_mod_did_2 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
      EXPORT did := gm.entity2_did;
      EXPORT did_field := (STRING)l.did;
    END;
    temp_mod_ssn_1 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
      EXPORT ssn_field := l.ssn;
    END;
    temp_mod_ssn_2 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
      EXPORT ssn := gm.entity2_ssn;
      EXPORT ssn_field := l.ssn;
    END;
    temp_mod_fein_1 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
      EXPORT fein_field := l.fein;
    END;
    temp_mod_fein_2 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
      EXPORT fein := gm.entity2_fein;
      EXPORT fein_field := l.fein;
    END;
    temp_mod_indv_name_1 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
      EXPORT allow_wildcard := FALSE;
      EXPORT fname_field := l.fname;
      EXPORT mname_field := l.mname;
      EXPORT lname_field := l.lname;
    END;
    temp_mod_indv_name_2 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
      EXPORT allow_wildcard := FALSE;
      EXPORT unparsedfullname := gm.entity2_unparsedfullname;
      EXPORT allownicknames := gm.entity2_allownicknames;
      EXPORT phoneticmatch := gm.entity2_phoneticmatch;
      EXPORT firstname := gm.entity2_firstname;
      EXPORT middlename := gm.entity2_middlename;
      EXPORT lastname := gm.entity2_lastname;
      EXPORT fname_field := l.fname;
      EXPORT mname_field := l.mname;
      EXPORT lname_field := l.lname;
    END;
    SELF.penalt1 := IF (IsFCRA, 0,
      AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(temp_mod_biz_name_1) +
      AutoStandardI.LIBCALL_PenaltyI_BDID.val(temp_mod_bdid_1) +
      AutoStandardI.LIBCALL_PenaltyI_BusinessIds.val(temp_mod_business_ids_1) +
      AutoStandardI.LIBCALL_PenaltyI_DID.val(temp_mod_did_1) +
      AutoStandardI.LIBCALL_PenaltyI_SSN.val(temp_mod_ssn_1) +
      AutoStandardI.LIBCALL_PenaltyI_FEIN.val(temp_mod_fein_1) +
      AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(temp_mod_indv_name_1));
    SELF.penalt2 := IF (IsFCRA OR ~gm.TwoPartySearch, 0,
      AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(temp_mod_biz_name_2) +
      AutoStandardI.LIBCALL_PenaltyI_BDID.val(temp_mod_bdid_2) +
      AutoStandardI.LIBCALL_PenaltyI_DID.val(temp_mod_did_2) +
      AutoStandardI.LIBCALL_PenaltyI_SSN.val(temp_mod_ssn_2) +
      AutoStandardI.LIBCALL_PenaltyI_FEIN.val(temp_mod_fein_2) +
      AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(temp_mod_indv_name_2));
    SELF.names := maskNames(l);
    SELF.statementids := l.statementids;
    SELF.isdisputed := l.isdisputed;
    SELF := l;
  END;

  // prune old ssn references if requested
  doxie.MAC_PruneOldSSNs(deduped_names, deduped_names_pruned, ssn, did, IsFCRA);

  name_child := PROJECT(deduped_names_pruned, xf_name_child(LEFT));

  // Concatenate all related records from each of the child datasets.
  layout_name_child xf_rollup_name_child(layout_name_child l, layout_name_child r) := TRANSFORM
    SELF.names := CHOOSEN(l.names + r.names,25);
    SELF.statementids := l.statementids + r.statementids;
    SELF.isdisputed := l.isdisputed OR r.isdisputed;
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
      LEFT.did = 0 AND
      RIGHT.did = 0 AND
      LEFT.bdid = 0 AND
      RIGHT.bdid = 0,
    xf_rollup_name_child(LEFT, RIGHT)
  );

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
    DATASET(UCCv2_Services.layout_ucc_party_address) addresses{MAXCOUNT(25)};
    UNSIGNED2 penalt1;
    UNSIGNED2 penalt2;
    BOOLEAN is_addr_empty;
    FFD.Layouts.CommonRawRecordElements;
  END;
  layout_addr_child xf_addr_child(layout_addr L) := TRANSFORM
    temp_mod_addr_1 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
      EXPORT allow_wildcard := FALSE;
      EXPORT prange_field := l.prim_range;
      EXPORT predir_field := l.predir;
      EXPORT pname_field := l.prim_name;
      EXPORT suffix_field := l.addr_suffix;
      EXPORT postdir_field := l.postdir;
      EXPORT srange_field := l.sec_range;
      EXPORT city_field := l.v_city_name;
      EXPORT city2_field := '';
      EXPORT state_field := l.st;
      EXPORT zip_field := l.zip5;
    END;
    temp_mod_addr_2 := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
      EXPORT allow_wildcard := FALSE;
      EXPORT addr := gm.entity2_addr;
      EXPORT city := gm.entity2_city;
      EXPORT state := gm.entity2_state;
      EXPORT zip := gm.entity2_zip;
      EXPORT zipradius := gm.entity2_zipradius;
      EXPORT prange_field := l.prim_range;
      EXPORT predir_field := l.predir;
      EXPORT pname_field := l.prim_name;
      EXPORT suffix_field := l.addr_suffix;
      EXPORT postdir_field := l.postdir;
      EXPORT srange_field := l.sec_range;
      EXPORT city_field := l.v_city_name;
      EXPORT city2_field := '';
      EXPORT state_field := l.st;
      EXPORT zip_field := l.zip5;
    END;
    SELF.penalt1 := AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_mod_addr_1);
    SELF.penalt2 := IF (~gm.TwoPartySearch, 0, AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_mod_addr_2));
    SELF.addresses := DATASET([TRANSFORM(UCCv2_Services.layout_ucc_party_address,SELF:=l)]);
    SELF.is_addr_empty := TRIM(l.address1 + l.address2)='';
    SELF.statementids := l.statementids;
    SELF.isdisputed := l.isdisputed;
    SELF := l;
  END;
  addr_child := PROJECT(deduped_addresses, xf_addr_child(LEFT));

  // Specify yet another TRANSFORM, which will roll up (i.e. concatenate) all related
  // records from each of the child datasets.
  layout_addr_child xf_rollup_addr_child(layout_addr_child l, layout_addr_child r) := TRANSFORM
    SELF.addresses := CHOOSEN(l.addresses & r.addresses,25);
    SELF.statementids := l.statementids + r.statementids;
    SELF.isdisputed := l.isdisputed OR r.isdisputed;
    SELF := l;
  END;

  // Build the new recordset/rollup.
  rollup_addr_child := ROLLUP(
    SORT(
      addr_child,
      tmsid, orig_name, lname, fname, mname, name_suffix, penalt1 + penalt2, is_addr_empty
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
    xf_rollup_addr_child(LEFT, RIGHT)
  );

  // Join the party's NAMES to their ADDRESSES.
  layout_party := RECORD
    UCCv2_Services.layout_ucc_party_raw_src.tmsid;
    DATASET(UCCv2_Services.layout_ucc_party) parties{MAXCOUNT(25)};
    UNSIGNED2 penalt;
  END;
  layout_party_exp := RECORD
    layout_party;
    BOOLEAN is_addr_empty;
  END;
  layout_party_exp xf_party(layout_name_child L, layout_addr_child R) := TRANSFORM
    SELF.penalt := IF(
      // Were we searching against these parties? (needed for penalties)
      (party_type='') OR (party_type=in_party),
      MAX(L.penalt1 + R.penalt1,L.penalt2 + R.penalt2),
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
        CHOOSEN(L.names,10),
        CHOOSEN(R.addresses,10),
        DEDUP(L.statementids + R.statementids, all),
        L.isdisputed OR R.isdisputed
      }],
    UCCv2_Services.layout_ucc_party
    );
    SELF.is_addr_empty := R.is_addr_empty;
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
  party_sorted := PROJECT(SORT(party, tmsid, penalt,is_addr_empty, RECORD),layout_party);
  layout_party xf_roll_party(layout_party l, layout_party r) := TRANSFORM
    SELF.penalt := L.penalt;
    SELF.tmsid := l.tmsid;
    SELF.parties := CHOOSEN(l.parties & r.parties,max_parties);
  END;
  rollup_party := ROLLUP(
    party_sorted,
    LEFT.tmsid = RIGHT.tmsid,
    xf_roll_party(LEFT,RIGHT)
  );

  // Limit max parties
  limit_party := DEDUP(party_sorted, tmsid, KEEP(max_parties));

  // Optionally return debtors separately
  results_party := IF(max_parties>1, rollup_party, limit_party);
  // DONE!
  
  RETURN results_party;
END;
