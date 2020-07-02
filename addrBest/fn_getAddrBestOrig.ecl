import AddrBest, Doxie, ut;

export fn_getAddrBestOrig(dataset(AddrBest.Layout_BestAddr.Batch_in) batch_in,
  doxie.IDataAccess mod_access,
  dataset(AddrBest.layout_header_ext) rank_in,
  AddrBest.IParams.SearchParams in_mod) := function

  // call address common for best data
  f_in_raw := project(batch_in,
    transform(AddrBest.Layout_BestAddr.Batch_in,
    self.ssn := Stringlib.StringFilter(left.ssn, '1234567890');
    self := left));

  address_recs := AddrBest.BestAddr_common(f_in_raw,
    mod_access,
    in_mod := in_mod,
    rank_in := rank_in);

  out_recs := address_recs((unsigned)name_score between in_mod.minNameScore and in_mod.maxNameScore);

  AddrBest.Layout_BestAddr.Batch_out_matchcodes final_trans(out_recs l) := transform
    ut.MAC_ds_to_string(l.srcs,src,outstring);
    self.srcs := outstring;
    self := l;
    self := [];
  end;
  out_0 := project(out_recs,final_trans(left));
  out_final_clean := AddrBest.functions.fn_add_optional_data(out_0, in_mod);

  out_final_w_nohits := join(f_in_raw, out_final_clean,
    left.acctno = right.acctno,
    transform(AddrBest.Layout_BestAddr.batch_out_final,
      validDid := right.did <> 0;
      self.acctno := left.acctno;
      srch_too_broad := left.ssn='' and left.dob='' and left.p_city_name='' and left.z5='';
      self.unq_id_subject := IF(not validDid and in_mod.ReturnOverLimitIndicator and srch_too_broad,
        AddrBest.Constants.Over_Limit_Indicator, '');
      self.conf_addr_match_code := IF(not validDid and in_mod.ReturnConfirmedMatchCode,
        AddrBest.Constants.Not_Confirmed, right.conf_addr_match_code);
      self.name_score := if(validDid, right.name_score, (string)AddrBest.Constants.max_score);
      self.ssn_score := if(validDid, right.ssn_score, (string)AddrBest.Constants.max_score);
      self.dob_score := if(validDid, right.dob_score, (string)AddrBest.Constants.max_score);
      self := right
    ),
    left outer)(did<>0 or unq_id_subject=AddrBest.Constants.Over_Limit_Indicator or conf_addr_match_code=AddrBest.Constants.Not_Confirmed);

  out_nohits_or_clean := if(in_mod.ReturnOverLimitIndicator or in_mod.ReturnConfirmedMatchCode, out_final_w_nohits, out_final_clean);

  // create a dataset in the final layout with the proper fields set
  // this dataset will contain all of the records for requested subjects, even if there are no matches at all
  out_w_ssn_loose_match := AddrBest.functions.fn_setSSNlooseMatch(f_in_raw, out_nohits_or_clean);

  // finally, create the results dataset based on whichever dataset matches ssn_loose_match request
  out_final := if(in_mod.ReturnSSNLooseMatchIndicator, out_w_ssn_loose_match, out_nohits_or_clean);

  return out_final;
end;
