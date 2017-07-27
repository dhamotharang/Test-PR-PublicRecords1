IMPORT 	AddrBest, Address, DidVille;
	
EXPORT Get_Ranked_Best_Addr(DATASET(DidVille.Layout_Did_OutBatch) in_recs) := FUNCTION 
	dedupedRecs := dedup(sort(in_recs,did),did);
	AddrBest.Layout_BestAddr.Batch_in makeAddrBestBatch(DidVille.Layout_Did_OutBatch l, unsigned c) := TRANSFORM
		SELF.acctno 			:= (string)c;
		SELF.did		 			:= l.did;
		SELF.name_first 	:= l.fname;
		SELF.name_middle 	:= l.mname;
		SELF.name_last 		:= l.lname;
		SELF.name_suffix	:= l.suffix;	
		SELF.suffix				:= l.addr_suffix;	
		SELF := l;
		SELF := [];
	end;
	addrBest_batch := project(dedupedRecs, makeAddrBestBatch(LEFT, counter));
					
	addrBest_mod := MODULE(AddrBest.Iparams.SearchParams) 
		EXPORT IncludeRanking 					:= TRUE; //automatically applied to GOV applications to always get best ranked addr
	END;
	addrBest := AddrBest.Records(addrBest_batch, addrBest_mod).best_records;
	
	DidVille.Layout_Did_OutBatch mergeResults(in_recs l, addrBest r) := transform
		self.best_addr1   	:= Address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
																																			r.suffix, r.postdir, '', r.sec_range);
		self.best_city    	:= r.p_city_name,
		SELF.best_state			:= r.st;
		SELF.best_zip				:= r.z5;
		SELF.best_zip4			:= r.zip4;
		SELF.best_addr_date	:= (unsigned)r.addr_dt_last_seen;
		SELF := l;
		SELF :=[];
	end;
	
	best_recs:= join(in_recs, addrBest,
									left.did = right.did,
									mergeResults(left, right), left outer, limit(0),keep(1));							
									
	RETURN best_recs;
END; // end of GetGOVBestAddr