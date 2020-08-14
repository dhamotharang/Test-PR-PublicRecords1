IMPORT AddrBest, Address, DidVille;
  
EXPORT Get_Ranked_Best_Addr(DATASET(DidVille.Layout_Did_OutBatch) in_recs) := FUNCTION
  dedupedRecs := DEDUP(SORT(in_recs,did),did);
  AddrBest.Layout_BestAddr.Batch_in makeAddrBestBatch(DidVille.Layout_Did_OutBatch l, UNSIGNED c) := TRANSFORM
    SELF.acctno := (STRING)c;
    SELF.did := l.did;
    SELF.name_first := l.fname;
    SELF.name_middle := l.mname;
    SELF.name_last := l.lname;
    SELF.name_suffix := l.suffix;
    SELF.suffix := l.addr_suffix;
    SELF := l;
    SELF := [];
  END;
  addrBest_batch := PROJECT(dedupedRecs, makeAddrBestBatch(LEFT, COUNTER));
          
  addrBest_mod := MODULE(AddrBest.Iparams.SearchParams)
    EXPORT IncludeRanking := TRUE; //automatically applied to GOV applications to always get best ranked addr
  END;
  addrBest := AddrBest.Records(addrBest_batch, addrBest_mod).best_records;
  
  DidVille.Layout_Did_OutBatch mergeResults(in_recs l, addrBest r) := TRANSFORM
    SELF.best_addr1 := Address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                      r.suffix, r.postdir, '', r.sec_range);
    SELF.best_city := r.p_city_name,
    SELF.best_state := r.st;
    SELF.best_zip := r.z5;
    SELF.best_zip4 := r.zip4;
    SELF.best_addr_date := (UNSIGNED)r.addr_dt_last_seen;
    SELF := l;
    SELF :=[];
  END;
  
  best_recs:= JOIN(in_recs, addrBest,
    LEFT.did = RIGHT.did,
    mergeResults(LEFT, RIGHT), LEFT OUTER, LIMIT(0), KEEP(1));
                  
  RETURN best_recs;
END; // end of GetGOVBestAddr
