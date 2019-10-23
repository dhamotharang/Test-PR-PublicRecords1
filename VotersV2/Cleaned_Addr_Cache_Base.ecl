import Address, ut, AID;
//Added AID to the build
in_file := VotersV2.Cleaned_Voters_DID;

out_layout := record
	unsigned6 DID       := 0;
	unsigned1 did_score := 0;
	string9	  ssn       := '';
	string1   addr_type := '';
  VotersV2.Layouts_Voters.Layout_Voters_Common_new;	
end;
															
// Transform to Normalize the Mailing Addresses.
// Skip's the normalized mailing records that only contain the mailing city, st and zip populate 
// and are equivalent to resident addr city, st and zip values. or all mailing address parts are
// blank.
out_layout trfNormMailAddr(in_file l, unsigned c) := transform
	 ,skip(c = 2 and
	       trim(l.p_city_name,left,right) = trim(l.mail_p_city_name,left,right) and
		   trim(l.st,left,right)          = trim(l.mail_st,left,right) and
		   trim(l.zip,left,right)         = trim(l.mail_ace_zip,left,right) and
		   trim(l.p_city_name,left,right) + trim(l.zip,left,right) <> '' and
		   trim(l.mail_prim_range, left, right) = '' and
		   trim(l.mail_predir,left,right)  = '' and
		   trim(l.mail_prim_name,left,right)  = '' and
		   trim(l.mail_addr_suffix,left,right) = '' and
		   trim(l.mail_postdir,left,right) = '' and
		   trim(l.mail_unit_desig,left,right) = '' and
		   trim(l.mail_sec_range,left,right) = '')
  
	self.prim_range      := choose(c, l.prim_range, l.mail_prim_range);
	self.predir          := choose(c, l.predir, l.mail_predir);
	self.prim_name       := choose(c, l.prim_name, l.mail_prim_name);	
	self.addr_suffix     := choose(c, l.addr_suffix, l.mail_addr_suffix);
	self.postdir         := choose(c, l.postdir, l.mail_postdir);
	self.unit_desig      := choose(c, l.unit_desig, l.mail_unit_desig);
	self.sec_range       := choose(c, l.sec_range, l.mail_sec_range);
	self.p_city_name     := choose(c, l.p_city_name, l.mail_p_city_name);
	self.v_city_name     := choose(c, l.v_city_name, l.mail_v_city_name);
	self.st              := choose(c, l.st, l.mail_st);
	self.zip             := choose(c, l.zip, l.mail_ace_zip);
	self.zip4            := choose(c, l.zip4, l.mail_zip4);
	self.cart            := choose(c, l.cart, l.mail_cart);
	self.cr_sort_sz      := choose(c, l.cr_sort_sz, l.mail_cr_sort_sz);
	self.lot             := choose(c, l.lot, l.mail_lot);
	self.lot_order       := choose(c, l.lot_order, l.mail_lot_order);
	self.dpbc            := choose(c, l.dpbc, l.mail_dpbc);
	self.chk_digit       := choose(c, l.chk_digit, l.mail_chk_digit);
	self.rec_type        := choose(c, l.rec_type, l.mail_rec_type);
	self.ace_fips_st     := choose(c, l.ace_fips_st, l.mail_ace_fips_st);
	self.fips_county     := choose(c, l.fips_county, l.mail_fips_county);
	self.geo_lat         := choose(c, l.geo_lat, l.mail_geo_lat);
	self.geo_long        := choose(c, l.geo_long, l.mail_geo_long);
	self.msa             := choose(c, l.msa, l.mail_msa);
	self.geo_blk         := choose(c, l.geo_blk, l.mail_geo_blk);
	self.geo_match       := choose(c, l.geo_match, l.mail_geo_match);
	self.err_stat        := choose(c, l.err_stat, l.mail_err_stat);	
	self.addr_type       := choose(c, '','M');
	self := l;
end;

// Normalize the Mailing Addresses 
Clean_Addr_Norn_file  := NORMALIZE(in_file,
								   if((trim(left.mail_p_city_name,left,right) + trim(left.mail_st,left,right) = '' and
								       (integer)left.mail_ace_zip = 0)  or 
								      (trim(left.prim_range,left,right)  = trim(left.mail_prim_range,left,right) and
									   trim(left.predir,left,right)      = trim(left.mail_predir,left,right) and
								       trim(left.prim_name,left,right)   = trim(left.mail_prim_name,left,right) and									   
								       trim(left.addr_suffix,left,right) = trim(left.mail_addr_suffix,left,right) and
								       trim(left.postdir,left,right)     = trim(left.mail_postdir,left,right) and
								       trim(left.unit_desig,left,right)  = trim(left.mail_unit_desig,left,right) and
								       trim(left.sec_range,left,right)   = trim(left.mail_sec_range,left,right) and
								       trim(left.v_city_name,left,right) = trim(left.mail_v_city_name,left,right) and
								       trim(left.st,left,right)          = trim(left.mail_st,left,right) and
								       trim(left.zip,left,right)         = trim(left.mail_ace_zip,left,right) and
								       trim(left.zip4,left,right)        = trim(left.mail_zip4,left,right)),1,2)								      
								   ,trfNormMailAddr(left,counter));

//Added AID fields
layout_voters_for_cache := record
	out_layout;
	string70 addr1_for_clean := '';
	string40 addr2_for_clean := '';	
	unsigned8	raw_aid	:= 0;													
	unsigned8	ace_aid	:= 0;
end;

Clean_File_filt := Clean_Addr_Norn_file(trim(p_city_name,left,right) <> '' and
										trim(st,left,right)  <> '' and
										trim(zip,left,right) <> '');

Clean_file_emty := Clean_Addr_Norn_file(trim(p_city_name,left,right) = '' or
										trim(st,left,right)  = '' or
										trim(zip,left,right) = '');

layout_voters_for_cache trfForAddrCache(Clean_File_filt l):= transform
	self := l;
	self.addr1_for_clean := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, 
												        l.addr_suffix, l.postdir, l.unit_desig,
												        l.sec_range); 
	self.addr2_for_clean := Address.Addr2FromComponents(l.p_city_name, l.st, l.zip);
end;

clean_file_for_cache := project(Clean_File_filt, trfForAddrCache(left));

Address.MAC_Address_Clean(clean_file_for_cache,  //input file
				          addr1_for_clean,       //addr1
				          addr2_for_clean,       //addr2
				          true,                  //'clean_misses'?
				          Clean_Addr_File)       //output file					

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

//Added AID
AID.MacAppendFromRaw_2Line(clean_file_for_cache, addr1_for_clean, addr2_for_clean, raw_aid, dwithAID, lFlags);

clean_cache_addr_file := project(dwithAID
			,transform(layout_voters_for_cache,			
			 self.ace_aid	      := left.aidwork_acecache.aid					;
				self.raw_aid        := left.aidwork_rawaid								;
				self.prim_range			:= left.aidwork_acecache.prim_range		;
				self.predir					:= left.aidwork_acecache.predir				;
				self.prim_name			:= left.aidwork_acecache.prim_name		;
				self.addr_suffix		:= left.aidwork_acecache.addr_suffix	;
				self.postdir				:= left.aidwork_acecache.postdir			;
				self.unit_desig			:= left.aidwork_acecache.unit_desig		;
				self.sec_range			:= left.aidwork_acecache.sec_range		;
				self.p_city_name		:= left.aidwork_acecache.p_city_name	;
				self.v_city_name		:= left.aidwork_acecache.v_city_name	;
				self.st							:= left.aidwork_acecache.st						;
				self.zip						:= left.aidwork_acecache.zip5					;
				self.zip4						:= left.aidwork_acecache.zip4					;
				self.cart						:= left.aidwork_acecache.cart					;
				self.cr_sort_sz			:= left.aidwork_acecache.cr_sort_sz		;
				self.lot						:= left.aidwork_acecache.lot					;
				self.lot_order			:= left.aidwork_acecache.lot_order		;
				self.dpbc						:= left.aidwork_acecache.dbpc					;
				self.chk_digit			:= left.aidwork_acecache.chk_digit		;
				self.rec_type				:= left.aidwork_acecache.rec_type			;
				self.ace_fips_st    := left.aidwork_acecache.county[1..2]	;
				self.fips_county		:= left.aidwork_acecache.county[3..]	;
				self.geo_lat				:= left.aidwork_acecache.geo_lat			;
				self.geo_long				:= left.aidwork_acecache.geo_long			;
				self.msa						:= left.aidwork_acecache.msa					;
				self.geo_blk				:= left.aidwork_acecache.geo_blk			;
				self.geo_match			:= left.aidwork_acecache.geo_match		;
				self.err_stat				:= left.aidwork_acecache.err_stat			;
				self.addr1_for_clean := left.addr1_for_clean;
				self.addr2_for_clean := left.addr2_for_clean;
				self								                      := left																;
			)
		)
		+ project(Clean_file_emty,transform(layout_voters_for_cache, 
		self := left
		,self := []));

clean_cache_file      := clean_cache_addr_file;

clean_cache_file_dist := distribute(clean_cache_file, vtid);

full_norm_file := sort(clean_cache_file_dist, vtid, -process_date, -date_first_seen, addr_type, local);

export Cleaned_Addr_Cache_Base :=  full_norm_file: persist(VotersV2.Cluster+'persist::voters::cache_Addr_base',SINGLE);