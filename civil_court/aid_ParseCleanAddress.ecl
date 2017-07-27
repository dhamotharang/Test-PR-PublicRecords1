export aid_ParseCleanAddress(infile,outlayout,outfile) := macro
////////////////////////////////////////////////////////////////////////////////////////
// Macro: Parse Appended Clean Address
////////////////////////////////////////////////////////////////////////////////////////
#uniquename(rPreProcess)
#uniquename(tCleancontactAddressAppended)
#uniquename(dCleancontactAddressAppended)
#uniquename(tCleancontactAddressAppended)

outlayout %tCleancontactAddressAppended%(infile pInput) := transform
	self.rawaid		 				:= pInput.AIDWork_RawAID;
	self.prim_range1 				:= pInput.AIDWork_ACECache.prim_range;
	self.predir1 					:= pInput.AIDWork_ACECache.predir;
	self.prim_name1 				:= pInput.AIDWork_ACECache.prim_name;
	self.addr_suffix1 				:= pInput.AIDWork_ACECache.addr_suffix;
	self.postdir1 					:= pInput.AIDWork_ACECache.postdir;
	self.unit_desig1 				:= pInput.AIDWork_ACECache.unit_desig;
	self.sec_range1					:= pInput.AIDWork_ACECache.sec_range;
	self.p_city_name1 				:= pInput.AIDWork_ACECache.p_city_name;
	self.v_city_name1 				:= pInput.AIDWork_ACECache.v_city_name;
	self.st1 						:= pInput.AIDWork_ACECache.st;
	self.zip1 						:= pInput.AIDWork_ACECache.zip5;
	self.zip41 						:= pInput.AIDWork_ACECache.zip4;
	self.cart1 						:= pInput.AIDWork_ACECache.cart;
	self.cr_sort_sz1 				:= pInput.AIDWork_ACECache.cr_sort_sz;
	self.lot1 						:= pInput.AIDWork_ACECache.lot;
	self.lot_order1					:= pInput.AIDWork_ACECache.lot_order;
	self.dpbc1						:= pInput.AIDWork_ACECache.dbpc;
	self.chk_digit1					:= pInput.AIDWork_ACECache.chk_digit;
	self.rec_type1 					:= pInput.AIDWork_ACECache.rec_type;
	self.ace_fips_st1				:= pInput.AIDWork_ACECache.st;	
	self.ace_fips_county1			:= pInput.AIDWork_ACECache.county;
	self.geo_lat1 					:= pInput.AIDWork_ACECache.geo_lat;
	self.geo_long1 					:= pInput.AIDWork_ACECache.geo_long;
	self.msa1 						:= pInput.AIDWork_ACECache.msa;
	self.geo_blk1 					:= pInput.AIDWork_ACECache.geo_blk;
	self.geo_match1 				:= pInput.AIDWork_ACECache.geo_match;
	self.err_stat1 					:= pInput.AIDWork_ACECache.err_stat;

self := pInput;
end;

outfile:= project(infile,%tCleancontactAddressAppended%(left));
endmacro;