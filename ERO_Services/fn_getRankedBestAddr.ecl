/*2015-10-26T18:53:07Z (Janielle Goolgar)
Govt AddrBest ranking implementation
*/
IMPORT AddrBest, Doxie;
EXPORT fn_getRankedBestAddr(DATASET(doxie.Layout_Comp_Addresses) in_recs) := FUNCTION 
	recs := dedup(sort(in_recs,did),did);
	AddrBest.Layout_BestAddr.Batch_in makeAddrBestBatch(doxie.Layout_Comp_Addresses l, unsigned c) := TRANSFORM
		SELF.acctno 			:= (string)c;
		SELF.did		 			:= l.did;
		SELF.name_first 	:= l.fname;
		SELF.name_middle 	:= l.mname;
		SELF.name_last 		:= l.lname;
		SELF.name_suffix	:= l.name_suffix;
		SELF.prim_range		:= l.prim_range;
		SELF.prim_name		:= l.prim_name;
		SELF.suffix				:= l.suffix;
		SELF.unit_desig		:= l.unit_desig;
		SELF.sec_range		:= l.sec_range;		
		SELF.p_city_name	:= l.city_name;
		SELF.st						:= l.st;
		SELF.z5						:= l.zip;
		SELF := [];
	end;
	addrBest_batch := project(recs, makeAddrBestBatch(LEFT, COUNTER));
					
	addrBest_mod := MODULE(AddrBest.Iparams.SearchParams) 
		EXPORT MaxRecordsToReturn 			:= 2;
		EXPORT IncludeRanking 					:= TRUE; //automatically applied to GOV applications to always get best ranked addr
	END;
	addrBest := AddrBest.Records(addrBest_batch, addrBest_mod).best_records;
	
	doxie.Layout_Comp_Addresses mergeAddrRecs(addrBest l,  in_recs r) := TRANSFORM
		self.city_name  		:= l.p_city_name;
		self.zip  					:= l.z5;
		self.dt_first_seen  := (unsigned)l.addr_dt_first_seen;
		self.dt_last_seen 	:= (unsigned)l.addr_dt_last_seen;
		self.address_seq_no	:= (unsigned)l.address_history_seq;
		self := l;
		self := r;
		self := [];
	end;
	best_join := JOIN(addrBest,  in_recs,
										left.did 					= right.did and
										left.prim_range   = right.prim_range and
										left.predir		    = right.predir and
										left.prim_name    = right.prim_name and
										left.suffix		    = right.suffix and
										left.postdir	    = right.postdir and
										left.sec_range    = right.sec_range and
										left.p_city_name  = right.city_name and
										left.st				    = right.st and
										left.z5				    = right.zip,
										mergeAddrRecs(left, right),
										left outer, limit(0), keep(1));
	RETURN best_join;
END; // end of GetGOVBestAddr