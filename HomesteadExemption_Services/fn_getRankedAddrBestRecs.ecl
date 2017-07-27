IMPORT AddrBest, Address, Didville;
EXPORT fn_getRankedAddrBestRecs(DATASET(Didville.Layout_Did_OutBatch) in_recs) := FUNCTION 

	AddrBest.Layout_BestAddr.Batch_in makeAddrBestBatch(Didville.Layout_Did_OutBatch L) := TRANSFORM
		SELF.acctno := (STRING)L.seq;
		SELF.dob := (STRING)L.dob;
		SELF := L;
		SELF := [];
	end;
	addrBest_batch := project(in_recs, makeAddrBestBatch(LEFT));
					
	addrBest_mod := MODULE(AddrBest.Iparams.SearchParams) 
		EXPORT IncludeRanking 					:= TRUE; //automatically applied to GOV applications to always get best ranked addr
	END;
	addrBest := AddrBest.Records(addrBest_batch, addrBest_mod).best_records;
	
	ds_best_join := JOIN(in_recs, addrBest,
								left.did = right.did,
								transform(Didville.Layout_Did_OutBatch,
								self.did  					:= left.did;
								self.best_addr1   	:= Address.Addr1FromComponents(right.prim_range, right.predir, right.prim_name,
																																		right.suffix, right.postdir, '', right.sec_range);
								self.best_city    	:= right.p_city_name,
								self.best_state   	:= right.st,
								self.best_zip			  := right.z5,
								self.best_addr_date := (unsigned)right.addr_dt_last_seen,
								self := left));

	RETURN ds_best_join;
END; // end of fn_getRankedAddrBestRecs