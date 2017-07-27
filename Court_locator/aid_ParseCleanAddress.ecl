export aid_ParseCleanAddress(infile,outlayout,filedate,outfile) := macro
////////////////////////////////////////////////////////////////////////////////////////
// Macro: Parse Appended Clean Address
////////////////////////////////////////////////////////////////////////////////////////
#uniquename(rPreProcess)
#uniquename(tCleancontactAddressAppended)
#uniquename(dCleancontactAddressAppended)
#uniquename(tCleancontactAddressAppended)

outlayout %tCleancontactAddressAppended%(infile pInput) := transform
string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

//self.dt_vendor_last_reported					:= fSlashedMDYtoCYMD(pInput.LastUpdated[1..length(pInput.LastUpdated)-5]);
self.process_date											:= filedate;
self.fipscode													:= intformat((unsigned)pInput.fipscode,5,1);
//self.zipcode    											:= intformat((unsigned)pInput.zipcode,5,1);
//self.zipfour													:= intformat((unsigned)pInput.zipfour,4,1);
self.mailzip    											:= intformat((unsigned)pInput.mailzip,5,1);
//self.mailzipfour											:= intformat((unsigned)pInput.mailzipfour,4,1);
//self.min_dollar_amt										:= if(pInput.min_dollar_amt='0','',stringlib.stringfilter(pInput.min_dollar_amt,'0123456789')+'00');
//self.max_dollar_amt										:= if(pInput.max_dollar_amt='0','',stringlib.stringfilter(pInput.max_dollar_amt,'0123456789')+'00');
//self.min2															:= stringlib.stringfilterout(pInput.min2,'"');
//self.max2															:= stringlib.stringfilterout(pInput.max2,'"');
self.courtname												:= stringlib.stringfilterout(pInput.courtname,'"');
self.filingamounts												:= stringlib.stringfilterout(pInput.filingamounts,'"');
self.courtcosts												:= stringlib.stringfilterout(pInput.courtcosts,'"');
self.address1											:= stringlib.stringfilterout(pInput.address1,'"');
self.mailaddress1										:= stringlib.stringfilterout(pInput.mailaddress1,'"');
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
	self.z5 						:= pInput.AIDWork_ACECache.zip5;
	self.z4 						:= pInput.AIDWork_ACECache.zip4;
	self.cart 						:= pInput.AIDWork_ACECache.cart;
	self.cr_sort_sz 				:= pInput.AIDWork_ACECache.cr_sort_sz;
	self.lot 						:= pInput.AIDWork_ACECache.lot;
	self.lot_order 					:= pInput.AIDWork_ACECache.lot_order;
	self.dpbc						:= pInput.AIDWork_ACECache.dbpc;
	self.chk_digit 					:= pInput.AIDWork_ACECache.chk_digit;
	self.rec_type 					:= pInput.AIDWork_ACECache.rec_type;
	self.county_code 					:= pInput.AIDWork_ACECache.county;
	self.geo_lat 					:= pInput.AIDWork_ACECache.geo_lat;
	self.geo_long 					:= pInput.AIDWork_ACECache.geo_long;
	self.msa 						:= pInput.AIDWork_ACECache.msa;
	self.geo_blk 					:= pInput.AIDWork_ACECache.geo_blk;
	self.geo_match 					:= pInput.AIDWork_ACECache.geo_match;
	self.err_stat 					:= pInput.AIDWork_ACECache.err_stat;

self := pInput;
self := [];
end;

outfile:= project(infile,%tCleancontactAddressAppended%(left));
endmacro;
