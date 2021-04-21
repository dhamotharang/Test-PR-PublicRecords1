import Address_Rank, AutoStandardI, Doxie;

export Records (dataset(AddrBest.Layout_BestAddr.Batch_in) batch_in,
  AddrBest.IParams.SearchParams in_mod) := module

  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

  //*****************Get ranked records to account for any address not returned based on input***************/
  rank_batch_in := project(batch_in, transform(Address_Rank.Layouts.Batch_in, self:=left, self:=[]));
  temp_mod := module(project(in_mod, Address_Rank.IParams.BatchParams, opt))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    export unsigned1 MaxRecordsToReturn := max(in_mod.MaxRecordsToReturn,Address_Rank.Constants.MaxRecordsToReturn);
  end;
  ranked_recs := Address_Rank.fn_getRank_wMetadata(rank_batch_in,temp_mod);

  AddrBest.layout_header_ext popHeaderFormat(Address_Rank.Layouts.Bestrec l):= transform
    self.did := (unsigned)l.acctno;
    self.rid := l.did;
    self.ssn := l.ssn;
    self.dob := (unsigned)l.dob;
    self.fname := l.name_first;
    self.mname := l.name_middle;
    self.lname := l.name_last;
    self.city_name := l.p_city_name;
    self.zip := l.z5;
    self.src := l.srcs;
    self.dt_last_seen := (unsigned)l.addr_dt_last_seen;
    self.dt_first_seen := (unsigned)l.addr_dt_first_seen;
    self.best_address_number := l.address_history_seq;
    self := l;
    self := [];
  end;
  rank_in := project(ranked_recs, popHeaderFormat(left));
  rank_result :=if(in_mod.IncludeRanking,rank_in, dataset([],AddrBest.layout_header_ext)); // Conditionally use ranked records

  //*****************process original Addr_best code***************/
  orig_best_recs := AddrBest.fn_getAddrBestOrig(batch_in, mod_access, rank_result, in_mod);

  //*****************restore ranked attributes***************/
  recordof(orig_best_recs) getAddrSeq (orig_best_recs l, ranked_recs r):= transform
    self.address_history_seq := r.address_history_seq;
    self.ba_flag := r.ba_flag;
    self.ncoa_flag := r.ncoa_flag;
    self.ncoa_addr1 := r.ncoa_addr1;
    self.ncoa_addr2 := r.ncoa_addr2;
    self.ncoa_prim_range := r.ncoa_prim_range;
    self.ncoa_predir := r.ncoa_predir;
    self.ncoa_prim_name := r.ncoa_prim_name;
    self.ncoa_addr_suffix := r.ncoa_addr_suffix;
    self.ncoa_postdir := r.ncoa_postdir;
    self.ncoa_sec_range := r.ncoa_sec_range;
    self.ncoa_city := r.ncoa_city;
    self.ncoa_state := r.ncoa_state;
    self.ncoa_zip := r.ncoa_zip;
    self.matchmoveeffdate := r.matchmoveeffdate;
    self.college_addr := r.college_addr;
    self.business_addr := r.business_addr;
    self.location_id := r.location_id;
    self := l;
    self := [];
  end;
  include_rank := join(orig_best_recs, ranked_recs,
    left.acctno = right.acctno and
    left.z5 = right.z5 and
    left.prim_range = right.prim_range and
    left.predir = right.predir and
    left.prim_name = right.prim_name and
    left.postdir = right.postdir and
    left.suffix = right.suffix and
    left.sec_range = right.sec_range,
    getAddrSeq(left, right),
    limit(0),keep(1));

  best_recs := if(not in_mod.IncludeRanking, orig_best_recs, include_rank);

  //*****************conditionally append Short Term Rental***************/
  best_final := if(in_mod.IncludeRanking and (in_mod.IncludeShortTermRental or in_mod.IncludeSTRSplitFlag),
    Address_Rank.fn_getSTR_Values(best_recs,project(in_mod, Address_Rank.IParams.BatchParams, opt)),
    best_recs);

  export best_records := sort(best_final, acctno, address_history_seq);
end;
