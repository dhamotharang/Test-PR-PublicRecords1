import ut, doxie, Business_Header, Business_Header_SS;

layout_pat_keybuild := record
	patriot.Layout_Patriot_addressid;
	unsigned8 __fpos {virtual(fileposition)};
end;

pat := dataset('~thor_data400::in::patriot_file',layout_pat_keybuild,flat)(cname <> '');

layout_pat_temp := record
	layout_pat_keybuild;
	unsigned6 bdid := 0;
	unsigned2 bdid_score := 0;
	unsigned2 name_similar_score := 0;
end;

layout_pat_temp busReform(pat l):= transform
	self.prim_range			:= l.aid_prim_range;
	self.predir				:= l.aid_predir;
	self.prim_name			:= l.aid_prim_name; 
	self.addr_suffix		:= l.aid_addr_suffix;
	self.postdir			:= l.aid_postdir;
	self.unit_desig			:= l.aid_unit_desig;
	self.sec_range			:= l.aid_sec_range;
	self.p_city_name		:= l.aid_p_city_name;
	self.v_city_name		:= l.aid_v_city_name;
	self.st					:= l.aid_st;
	self.zip				:= l.aid_zip;
	self.zip4				:= l.aid_zip4;
	self.cart				:= l.aid_cart;
	self.cr_sort_sz			:= l.aid_cr_sort_sz;
	self.lot				:= l.aid_lot;
	self.lot_order			:= l.aid_lot_order;
	self.dpbc				:= l.aid_dpbc;
	self.chk_digit			:= l.aid_chk_digit;
	self.record_type		:= l.aid_record_type;
	self.ace_fips_st		:= l.aid_fips_st;
	self.county				:= l.aid_county;
	self.geo_lat			:= l.aid_geo_lat;
	self.geo_long			:= l.aid_geo_long;
	self.msa				:= l.aid_msa;
	self.geo_blk			:= l.aid_geo_blk;
	self.geo_match			:= l.aid_geo_match;
	self.err_stat			:= l.aid_err_stat;
	self := l;
end;

pat_temp := project(pat, busReform(left));

Business_Header_SS.MAC_Match_CompanyName(pat_temp,
                                         pat_bdid,
										 bdid,
										 bdid_score,
										 name_similar_score,
										 cname)
                                         
layout_bdid_key := record
	unsigned6 bdid := 0;
	patriot.Layout_Patriot;
	unsigned8 __fpos {virtual(fileposition)};
end;

pat_bdid_key := project(pat_bdid(bdid <> 0), transform(layout_bdid_key, self := left));

pat_bdid_key_dedup := dedup(pat_bdid_key, all);

export key_bdid_patriot_file := INDEX(pat_bdid_key_dedup,{bdid},{pat_bdid_key},'~thor_data400::key::patriot_bdid_file_'+doxie.Version_SuperKey);
