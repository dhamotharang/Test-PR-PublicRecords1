import $;

export MatchCodes := MODULE
  export string1 name  := 'N'; // Name/AKA/Business/DBA
  export string1 ssn_full := 'S'; // Full SSN
  export string1 ssn_red  := 'R'; // Redacted SSN
  export string1 ssn_prob := 'P'; // Probable SSN
  export string1 addr  := 'A'; // Street Address/Address History
  export string1 city  := 'C'; //City+State/Address History
  export string1 zip  := 'Z'; // Zip Code/Address History
  export string1 did  := 'L'; // ADL

  // SSN + partial name match codes
  export string1 last_fi   := 'V'; // full last name + first initial
  export string1 lastname  := 'W'; // full last name
  export string1 first_li  := 'X'; // full first name + last initial
  export string1 firstname := 'Y'; // full first name
  export string mc_include_partial_name := 'SV,SVC,SVZ,SVZC,SVA,SVAC,SVAZ,SVAZC,SW,SWC,SWZ,SWZC,SWA,SWAC,SWAZ,SWAZC,SX,SXC,SXZ,SXZC,SXA,SXAC,SXAZ,SXAZC,SY,SYC,SYZ,SYZC,SYA,SYAC,SYAZ,SYAZC';

  // list of matchcodes to return
  // export string default_mcs := 'ANSZC,ANSC,ANSZ,ANS,ANZC,ANC,ANZ,SAZC,ANZC,SNC,SNZ,SAZ,SZC,SN,SA,SC,SZ,S,ANPZC,ANPC,ANPZ,ANP,PAZC,PNZC,PNC,PNZ,PAZ,PZC,PN,PZ,ANRZC,ANRC,ANRZ,ANR,RAZC,RNZC,RNC,RNZ,RAZ,RN,L';
  export string default_includes := '';

  export stripN_list_mname := ['RNZC','PN','PNC','PNZ','ANR','ANRC','ANRZ'];

  export stripN_list_sffix := ['N','NC','NZ','NZC','SN','SNC','SNZ','SNZC',
    'AN','ANC','ANZ','ANZC','ANS','ANSC','ANSZ','ANSZC', 'RN','RNZC','PN','PNC',
    'PNZ','PNZC', 'ANR','ANRC','ANRZ','ANRZC','ANP','ANPC','ANPZ','ANPZC'];

  export filt_list_inits  := ['PZ','PZC','RAZ','PAZ'];

  export string1 DEBTOR_BUSINESS_FLAG := 'B';

  export string1 delim := ',';  // delimiter used in match code list

  // These match codes were deemed to be FCRA compliant matches for bankruptcy purposes. RQ-15783
  // The conf values come from batch, please ensure they match if making changes/additions.
  FFD_compliant_matchcodes := dictionary([
    {'ANSZC' => 64},
    {'ANRZC' => 63},
    {'ANPZC' => 62},
    {'ANSZ' => 61},
    {'ANRZ' => 60},
    {'ANPZ' => 59},
    {'ANSC' => 58},
    {'ANRC' => 57},
    {'ANPC' => 56},
    {'ANS' => 55},
    {'ANR' => 54},
    {'SNZC' => 52},
    {'RNZC' => 51},
    {'SNZ' => 49},
    {'RNZ' => 48},
    {'SNC' => 46},
    {'RNC' => 45},
    {'SN' => 43},
    {'RN' => 42},
    {'SAZC' => 40},
    {'RAZC' => 39},
    {'SAZ' => 37},
    {'SAC' => 34},
    {'SZC' => 31},
    {'ANZC' => 28},
    {'SA' => 27}],{string mc => unsigned2 conf});

  // This function returns FCRA compliant non-ambigous matches via matchcode for bankruptcy purposes.
  export fn_get_FFD_compliant_matches(DATASET($.layout_BankruptcyV3_Batch_out) bk_results) := function

    // Filter out match codes which aren't considered compliant.
    ds_compliant_matches := bk_results(matchcode in FFD_compliant_matchcodes);

    // Append conf score to records via match code.
    bk_with_conf := record($.layout_BankruptcyV3_Batch_out)
      unsigned2 conf;
    end;

    ds_compliant_matches_w_conf := project(ds_compliant_matches, transform(bk_with_conf,
      self.conf := FFD_compliant_matchcodes[left.matchcode].conf,
      // Remove leading 0s
      self.debtor_did := (string)(unsigned6)left.debtor_did,
      self := left));

    // Separate the highest scoring lexIDs.
    ds_hi_score_lexIDs := dedup(sort(ds_compliant_matches_w_conf, acctno, debtor_did, -conf), acctno, debtor_did);

    // Group by acctno to have subsequent operations run on each individual acctno.
    ds_hi_score_lexIDs_grouped := group(ds_hi_score_lexIDs, acctno);

    // Only keep records with a single highest conf score per account.
    // This removes the ambigous matches with >1 same conf scores and differing lexID values.
    bk_with_conf Roll_Remove_Ambiguous(bk_with_conf L, dataset(bk_with_conf) grouped_recs) := transform
      max_score := max(grouped_recs, conf);
      keep_rec := count(grouped_recs(conf >= max_score)) = 1;
      best_row := grouped_recs(conf=max_score)[1];
      SELF.acctno := IF(keep_rec, best_row.acctno, skip);
      SELF := best_row;
    end;

    ds_hi_score_ambig_removed := rollup(ds_hi_score_lexIDs_grouped, group, Roll_Remove_Ambiguous(left, rows(left)));

    // Add back records with matching lexID which were deduped.
    // In the case of lexID = 0, add matches that have the same conf score.
    ds_all_best_lexIDs := join(ds_compliant_matches_w_conf, ds_hi_score_ambig_removed, left.acctno = right.acctno and
      left.debtor_did = right.debtor_did AND ((unsigned6)left.debtor_did <> 0 OR left.conf = right.conf),
      transform($.layout_BankruptcyV3_Batch_out, SELF := LEFT), keep(1), limit(0));

    // ----DEBUG ---------------------------------------------------------
    // OUTPUT(ds_compliant_matches_w_conf, NAMED('ds_compliant_matches_w_conf'));
    // OUTPUT(ds_hi_score_lexIDs, NAMED('ds_hi_score_lexIDs'));
    // OUTPUT(ds_hi_score_lexIDs_grouped, NAMED('ds_hi_score_lexIDs_grouped'));
    // OUTPUT(ds_hi_score_ambig_removed, NAMED('ds_hi_score_ambig_removed'));
    // OUTPUT(ds_all_best_lexIDs, NAMED('ds_all_best_lexIDs'));
    // ----END DEBUG -----------------------------------------------------

    return ds_all_best_lexIDs;
  end;

end;