IMPORT Address, Address_Rank,doxie;
EXPORT Records(DATASET(Address_Rank.Layouts.Batch_in) ds_batch_in,
											 Address_Rank.IParams.BatchParams in_mod) := FUNCTION
	
	//*****************append DIDs, get header records, and rank addresses***************/
	rank_data	:= Address_Rank.fn_getRank_wMetadata(ds_batch_in, in_mod);
	filtered_rank_recs  := rank_data((UNSIGNED)addr_dt_last_seen >= (UNSIGNED)in_mod.AddrSearchDate); //Req 4.3.8 filter by AddrSearchDate (Date last seen YYYYMM)
	
	rank_data_wSTR	:= IF(in_mod.IncludeShortTermRental OR in_mod.IncludeSTRSplitFlag,
												Address_Rank.fn_getSTR_Values(filtered_rank_recs,in_mod), //get ShortTermRental flags
												filtered_rank_recs);
		
	Address_Rank.Layouts.Batch_out	formatOutput(rank_data_wSTR l) := TRANSFORM
		SELF.BA_Address		  	:= Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
                                                     l.suffix, l.postdir, '', l.sec_range);
		SELF.BA_prim_range  	:= l.prim_range;
		SELF.BA_prim_name  		:= l.prim_name;
		SELF.BA_predir		  	:= l.predir;
		SELF.BA_addr_suffix 	:= l.suffix;
		SELF.BA_postdir		  	:= l.postdir;
		SELF.BA_unit_desig  	:= l.unit_desig;
		SELF.BA_sec_range  		:= l.sec_range;
		SELF.BA_p_city_name 	:= l.p_city_name;
		SELF.BA_st  					:= l.st;
		SELF.BA_z5  					:= l.z5;
		SELF.BA_zip4 					:= l.zip4;
		SELF.BA_dt_first_seen := (STRING)l.addr_dt_first_seen;
		SELF.BA_dt_last_seen  := (STRING)l.addr_dt_last_seen;
		SELF.NCOA_Address		  := Address.Addr1FromComponents(l.NCOA_prim_range, l.NCOA_predir, l.NCOA_prim_name,
                                                     l.NCOA_addr_suffix, l.NCOA_postdir, '', l.NCOA_sec_range);
		SELF.NCOA_prim_range  := l.NCOA_prim_range;
		SELF.NCOA_predir  		:= l.NCOA_predir;
		SELF.NCOA_prim_name  	:= l.NCOA_prim_name;
		SELF.NCOA_addr_suffix := l.NCOA_addr_suffix;
		SELF.NCOA_postdir  		:= l.NCOA_postdir;
		SELF.NCOA_unit_desig  := l.NCOA_unit_desig;
		SELF.NCOA_sec_range  	:= l.NCOA_sec_range;
		SELF.NCOA_p_city_name := l.NCOA_city;
		SELF.NCOA_st  				:= l.NCOA_state;
		SELF.NCOA_z5  				:= l.NCOA_zip;
		SELF.NCOA_dt_first_seen  := (STRING)l.MatchMoveEffDate;
	
		SELF := l;
		SELF := [];
	END;
	result := PROJECT(rank_data_wSTR, formatOutput(LEFT));						
	RETURN result;
END;