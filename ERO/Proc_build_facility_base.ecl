import ut,address,AID;
export Proc_build_facility_base(string filedate) := function
ds_fac := file_in_facility(office <> 'Office');

Facility_temp := record 
Layout_facility_base;
	string100 	append_Prep_Address1;
	string50  	append_Prep_Address2;
	unsigned8 	append_Rawaid;
end;	
Facility_temp build_it(ds_fac L) := transform
	street_address_1 := trim(l.street);
	city_st_zip      := trim(l.city)+', '+trim(l.state)+' '+trim(l.zip);
	process_date     := filedate;
  self.Process_date        := process_date;
  self.date_first_reported := process_date;
  self.date_last_reported  := process_date;
  self.Office       := l.office;    
  self.Orig_Street  := l.street;
  self.orig_City    := l.city;
  self.orig_State   := l.state;  
  self.orig_zip     := l.zip;
  self.append_Prep_Address1 := street_address_1;
  self.append_Prep_Address2 := city_st_zip;
  self := L;
  self := [];
end; 
prepAddress := project(ds_fac,build_it(left));

unsigned4 lAIDAppendFlags		:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
			
	AID.MacAppendFromRaw_2Line(prepAddress, Append_Prep_Address1, Append_Prep_Address2, Append_RawAID, addressCleaned, lAIDAppendFlags);
//output(addressCleaned);
Layout_Facility_base addressAppended(addressCleaned L) := transform
	self.rawaid   				:= L.AIDWork_RawAID;
	self.prim_range 			:= L.AIDWork_ACECache.prim_range;
	self.predir 					:= L.AIDWork_ACECache.predir;
	self.prim_name 				:= L.AIDWork_ACECache.prim_name;
	self.addr_suffix 		  := L.AIDWork_ACECache.addr_suffix;
	self.postdir 					:= L.AIDWork_ACECache.postdir;
	self.unit_desig 			:= L.AIDWork_ACECache.unit_desig;
	self.sec_range 				:= L.AIDWork_ACECache.sec_range;
	self.p_city_name 			:= L.AIDWork_ACECache.p_city_name;
	self.v_city_name 			:= L.AIDWork_ACECache.v_city_name;
	self.st 						  := L.AIDWork_ACECache.st;
	self.zip 						  := L.AIDWork_ACECache.zip5;
	self.zip4 						:= L.AIDWork_ACECache.zip4;
	self.cart 						:= L.AIDWork_ACECache.cart;
	self.cr_sort_sz 			:= L.AIDWork_ACECache.cr_sort_sz;
	self.lot 						  := L.AIDWork_ACECache.lot;
	self.lot_order 				:= L.AIDWork_ACECache.lot_order;
	self.dbpc 						:= L.AIDWork_ACECache.dbpc;
	self.chk_digit 				:= L.AIDWork_ACECache.chk_digit;
	self.rec_type 				:= L.AIDWork_ACECache.rec_type;
	self.county 					:= L.AIDWork_ACECache.county;
	self.geo_lat 					:= L.AIDWork_ACECache.geo_lat;
	self.geo_long 				:= L.AIDWork_ACECache.geo_long;
	self.msa 						  := L.AIDWork_ACECache.msa;
	self.geo_blk 					:= L.AIDWork_ACECache.geo_blk;
	self.geo_match 				:= L.AIDWork_ACECache.geo_match;
	self.err_stat 				:= L.AIDWork_ACECache.err_stat;
	self							    := L;
	end;
	out_fac := Project(addressCleaned,addressAppended(left)) : persist('persist::ERO::Facility_list');
 ut.MAC_SF_BuildProcess(out_fac,'~thor_Data400::base::Facility_list' ,outfac,2);
  return //out_fac
	       sequential(outfac);

end;