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
	self.prim_range 				:= pInput.AIDWork_ACECache.prim_range;
	self.predir 					:= pInput.AIDWork_ACECache.predir;
	self.prim_name 					:= pInput.AIDWork_ACECache.prim_name;
	self.addr_suffix 				:= pInput.AIDWork_ACECache.addr_suffix;
	self.postdir 					:= pInput.AIDWork_ACECache.postdir;
	self.unit_desig 				:= pInput.AIDWork_ACECache.unit_desig;
	self.sec_range 					:= pInput.AIDWork_ACECache.sec_range;
	self.p_city_name 				:= pInput.AIDWork_ACECache.p_city_name;
	self.v_city_name 				:= pInput.AIDWork_ACECache.v_city_name;
	self.st 						:= pInput.AIDWork_ACECache.st;
	self.zip 						:= pInput.AIDWork_ACECache.zip5;
	self.zip4 						:= pInput.AIDWork_ACECache.zip4;
	self.cart 						:= pInput.AIDWork_ACECache.cart;
	self.cr_sort_sz 				:= pInput.AIDWork_ACECache.cr_sort_sz;
	self.lot 						:= pInput.AIDWork_ACECache.lot;
	self.lot_order 					:= pInput.AIDWork_ACECache.lot_order;
	self.dpbc						:= pInput.AIDWork_ACECache.dbpc;
	self.chk_digit 					:= pInput.AIDWork_ACECache.chk_digit;
	self.rec_type 					:= pInput.AIDWork_ACECache.rec_type;
	self.ace_fips_st                :=  pInput.AIDWork_ACECache.county[1..2]; 
	self.county 					:= pInput.AIDWork_ACECache.county[3..5];
	self.geo_lat 					:= pInput.AIDWork_ACECache.geo_lat;
	self.geo_long 					:= pInput.AIDWork_ACECache.geo_long;
	self.msa 						:= pInput.AIDWork_ACECache.msa;
	self.geo_blk 					:= pInput.AIDWork_ACECache.geo_blk;
	self.geo_match 					:= pInput.AIDWork_ACECache.geo_match;
	self.err_stat 					:= pInput.AIDWork_ACECache.err_stat;

self := pInput;
self :=[];
end;

outfile:= project(infile,%tCleancontactAddressAppended%(left));
endmacro;