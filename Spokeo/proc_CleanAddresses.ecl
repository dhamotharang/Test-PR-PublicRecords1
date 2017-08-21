import aid, address;

EXPORT proc_CleanAddresses(dataset(Spokeo.Layout_temp) basein) := FUNCTION


	spknoaid := proc_CleanAddresses_small(basein(prepped_addr1='' OR prepped_addr2=''));
	
	aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;
	
	spkaid := basein(prepped_addr1<>'',prepped_addr2<>'');
	aid.MacAppendFromRaw_2Line(spkaid, prepped_addr1, prepped_addr2, rawaid , spkcln, laidappendflags);
	
	spkcln2 := PROJECT(spkcln, TRANSFORM(Spokeo.Layout_Temp,
								self.rawaid := left.aidwork_rawaid;
								self.prim_range		:=	left.AIDWork_AceCache.prim_range;
								self.predir				:=	left.AIDWork_AceCache.predir;
								self.prim_name		:=	left.AIDWork_AceCache.prim_name;
								self.addr_suffix	:=	left.AIDWork_AceCache.addr_suffix;
								self.postdir			:=	left.AIDWork_AceCache.postdir;
								self.unit_desig		:=	left.AIDWork_AceCache.unit_desig;
								self.sec_range		:=	left.AIDWork_AceCache.sec_range;
								self.p_city_name	:=	left.AIDWork_AceCache.p_city_name;
								self.v_city_name	:=	left.AIDWork_AceCache.v_city_name;
								self.st						:=	left.AIDWork_AceCache.st;
								self.zip					:=	left.AIDWork_AceCache.zip5;
								self.zip4					:=	left.AIDWork_AceCache.zip4;
								self.cart					:=	left.AIDWork_AceCache.cart;
								self.cr_sort_sz		:=	left.AIDWork_AceCache.cr_sort_sz;
								self.lot					:=	left.AIDWork_AceCache.lot;
								self.lot_order		:=	left.AIDWork_AceCache.lot_order;
								self.dbpc					:=	left.AIDWork_AceCache.dbpc;
								self.chk_digit		:=	left.AIDWork_AceCache.chk_digit;
								self.rec_type			:=	left.AIDWork_AceCache.rec_type;
								self.county				:=	left.AIDWork_AceCache.county;
								self.geo_lat			:=	left.AIDWork_AceCache.geo_lat;
								self.geo_long			:=	left.AIDWork_AceCache.geo_long;
								self.msa					:=	left.AIDWork_AceCache.msa;
								self.geo_blk			:=	left.AIDWork_AceCache.geo_blk;
								self.geo_match		:=	left.AIDWork_AceCache.geo_match;
								self.err_stat			:=	left.AIDWork_AceCache.err_stat;
								
								self.address_id := HASH64(self.Prim_range, self.predir, self.prim_name, 
																					self.addr_suffix, self.postdir, self.sec_range, self.p_city_name, self.st, self.zip);
	
								self := left;
				)) : INDEPENDENT;	
						// : PERSIST('~thor::spokeo::persist::cleanaddresses');
	
	return spknoaid + spkcln2;
	
END;
