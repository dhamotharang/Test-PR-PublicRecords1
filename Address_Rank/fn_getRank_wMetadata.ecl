IMPORT Address_Rank;
EXPORT fn_getRank_wMetadata(DATASET(Address_Rank.Layouts.Batch_in) ds_batch = DATASET([],Address_Rank.Layouts.Batch_in),
											 Address_Rank.IParams.BatchParams in_mod) := FUNCTION
											 
	//***************get header recs with rolled up dates*********/										 
	hdr_recs 		:= Address_Rank.Functions.fn_getHdrAddrRecs(ds_batch,in_mod);
	
	//*****************get address history seq from public records version of the Insurance Header Address Rank Key to determine best address
	addrHistory	:= Address_Rank.fn_getAddressHistory(hdr_recs, in_mod.MaxRecordsToReturn);	
									 
 //***************append best addr to input and clean and compare NCOA addr***********************/
	Address_Rank.Layouts.Bestrec updateBest(ds_batch l, addrHistory r) := TRANSFORM
		SELF.acctno 		:= l.acctno;
		SELF.did		 		:= r.did;
		SELF.BA_flag 		:= IF(r.did <> 0 AND r.addr_dt_first_seen <> '' AND r.addr_dt_last_seen <> '' AND
														r.addr_dt_last_seen >= l.MatchMoveEffDate,'B','');
		SELF.NCOA_flag 	:= IF((l.NCOA_prim_name <> '' OR l.NCOA_addr1 <> '') AND 
														 l.MatchMoveEffDate >= r.addr_dt_last_seen,'N','');	
		SELF.NCOA_prim_range 		:= l.NCOA_prim_range;
		SELF.NCOA_prim_name 		:= l.NCOA_prim_name;
		SELF.NCOA_predir 				:= l.NCOA_predir;
		SELF.NCOA_addr_suffix 	:= l.NCOA_addr_suffix;
		SELF.NCOA_postdir 			:= l.NCOA_postdir;
		SELF.NCOA_sec_range 		:= l.NCOA_sec_range;
		SELF.NCOA_city					:= l.NCOA_city;
		SELF.NCOA_state	 				:= l.NCOA_state;
		SELF.NCOA_zip	 					:= l.NCOA_zip;
		SELF.MatchMoveEffDate 	:= l.MatchMoveEffDate;
		SELF := r;
		SELF := [];
	END;
	bestjoin 	:= JOIN(ds_batch, addrHistory, 
									 LEFT.acctno = RIGHT.acctno,
									 updateBest(LEFT,RIGHT), LEFT OUTER, LIMIT(0), KEEP(in_mod.MaxRecordsToReturn));	
								 
	with_ADVO := Address_Rank.fn_getADVO_Values(bestjoin);				//append ADVO values to label best Addr												
	RETURN with_ADVO;
END;
