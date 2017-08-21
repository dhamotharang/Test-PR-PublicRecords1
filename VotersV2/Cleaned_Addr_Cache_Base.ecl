import Address, ut;

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

layout_voters_for_cache := record
	out_layout;
	string70 addr1_for_clean;
	string40 addr2_for_clean;
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

out_layout getAddrCache(Clean_Addr_File l) := transform
	self.prim_range    				:= l.clean[1..10];
	self.predir 	      			:= l.clean[11..12];
	self.prim_name 	  				:= l.clean[13..40];
	self.addr_suffix   				:= l.clean[41..44];
	self.postdir 	    			:= l.clean[45..46];
	self.unit_desig 	  			:= l.clean[47..56];
	self.sec_range 	  				:= l.clean[57..64];
	self.p_city_name	  			:= l.clean[65..89];
	self.v_city_name	  			:= l.clean[90..114];
	self.st 			      		:= if(l.clean[115..116] = '',
					                      ziplib.ZipToState2(l.clean[117..121]),
					                      l.clean[115..116]);
	self.zip 		      			:= l.clean[117..121];
	self.zip4 		      			:= l.clean[122..125];
	self.cart 		      			:= l.clean[126..129];
	self.cr_sort_sz 	 		 	:= l.clean[130];
	self.lot 		      			:= l.clean[131..134];
	self.lot_order 	  				:= l.clean[135];
	self.dpbc 		      			:= l.clean[136..137];
	self.chk_digit 	  				:= l.clean[138];
	self.rec_type		  			:= l.clean[139..140];
	self.ace_fips_st	  			:= l.clean[141..142];
	self.fips_county 	  			:= l.clean[143..145];
	self.geo_lat 	    			:= l.clean[146..155];
	self.geo_long 	    			:= l.clean[156..166];
	self.msa 		      			:= l.clean[167..170];
	self.geo_blk                    := l.clean[171..177];
	self.geo_match 	  				:= l.clean[178];
	self.err_stat 	    			:= l.clean[179..182];
	self := l;
end;

clean_cache_addr_file := project(Clean_Addr_File, getAddrCache(left));

clean_cache_file      := clean_cache_addr_file + Clean_file_emty;

clean_cache_file_dist := distribute(clean_cache_file, vtid);

full_norm_file := sort(clean_cache_file_dist, vtid, -process_date, -date_first_seen, addr_type, local);

export Cleaned_Addr_Cache_Base :=  full_norm_file: persist(VotersV2.Cluster+'persist::voters::cache_Addr_base');