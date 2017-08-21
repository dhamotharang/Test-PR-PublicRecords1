layout_pat_keybuild := record
	patriot.Layout_Patriot_addressid;
	unsigned8	__fpos {virtual(fileposition)};
end;

ds := dataset('~thor_data400::in::patriot_file',Layout_Pat_keybuild,flat);

oldformat := record
	patriot.Layout_Patriot;
	unsigned8	__fpos {virtual(fileposition)};
end;

oldformat oldTran(ds le):= transform
//pull only the addressid results for the addresses
	self.prim_range			:= le.aid_prim_range;
	self.predir				:= le.aid_predir;
	self.prim_name			:= le.aid_prim_name; 
	self.addr_suffix		:= le.aid_addr_suffix;
	self.postdir			:= le.aid_postdir;
	self.unit_desig			:= le.aid_unit_desig;
	self.sec_range			:= le.aid_sec_range;
	self.p_city_name		:= le.aid_p_city_name;
	self.v_city_name		:= le.aid_v_city_name;
	self.st					:= le.aid_st;
	self.zip				:= le.aid_zip;
	self.zip4				:= le.aid_zip4;
	self.cart				:= le.aid_cart;
	self.cr_sort_sz			:= le.aid_cr_sort_sz;
	self.lot				:= le.aid_lot;
	self.lot_order			:= le.aid_lot_order;
	self.dpbc				:= le.aid_dpbc;
	self.chk_digit			:= le.aid_chk_digit;
	self.record_type		:= le.aid_record_type;
	self.ace_fips_st		:= le.aid_county[..2];
	self.county				:= le.aid_county[3..];
	self.geo_lat			:= le.aid_geo_lat;
	self.geo_long			:= le.aid_geo_long;
	self.msa				:= le.aid_msa;
	self.geo_blk			:= le.aid_geo_blk;
	self.geo_match			:= le.aid_geo_match;
	self.err_stat			:= le.aid_err_stat;
	self 					:= le;
end;

ds_project := project(ds, oldTran(left));

export file_patriot_keybuild := ds_project;