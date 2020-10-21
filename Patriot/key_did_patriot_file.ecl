import doxie;
// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_patriot_delta_rid
// ---------------------------------------------------------------

layout_pat_keybuild := record
	patriot.Layout_Patriot_addressid;
	unsigned8	__fpos {virtual(fileposition)};
end;

ds := dataset('~thor_data400::in::patriot_file',Layout_Pat_keybuild,flat);

xl :=
RECORD
	unsigned6 did;
	patriot.Layout_Patriot;
	unsigned8	__fpos {virtual(fileposition)};
END;

xl appendDid(patriot.Dids_With_Namehook le, ds ri) :=
TRANSFORM
	SELF.did := le.did;
	self.prim_range			:= ri.aid_prim_range;
	self.predir				:= ri.aid_predir;
	self.prim_name			:= ri.aid_prim_name; 
	self.addr_suffix		:= ri.aid_addr_suffix;
	self.postdir			:= ri.aid_postdir;
	self.unit_desig			:= ri.aid_unit_desig;
	self.sec_range			:= ri.aid_sec_range;
	self.p_city_name		:= ri.aid_p_city_name;
	self.v_city_name		:= ri.aid_v_city_name;
	self.st					:= ri.aid_st;
	self.zip				:= ri.aid_zip;
	self.zip4				:= ri.aid_zip4;
	self.cart				:= ri.aid_cart;
	self.cr_sort_sz			:= ri.aid_cr_sort_sz;
	self.lot				:= ri.aid_lot;
	self.lot_order			:= ri.aid_lot_order;
	self.dpbc				:= ri.aid_dpbc;
	self.chk_digit			:= ri.aid_chk_digit;
	self.record_type		:= ri.aid_record_type;
	self.ace_fips_st		:= ri.aid_fips_st;
	self.county				:= ri.aid_county;
	self.geo_lat			:= ri.aid_geo_lat;
	self.geo_long			:= ri.aid_geo_long;
	self.msa				:= ri.aid_msa;
	self.geo_blk			:= ri.aid_geo_blk;
	self.geo_match			:= ri.aid_geo_match;
	self.err_stat			:= ri.aid_err_stat;
	SELF := ri;
END;
j := JOIN(patriot.Dids_With_Namehook,ds,LEFT.fname=RIGHT.fname AND
								LEFT.mname=RIGHT.mname AND
								LEFT.lname=RIGHT.lname, appendDid(LEFT,RIGHT), HASH);

d := DEDUP(j,ALL,local);

export key_did_patriot_file := INDEX(d,{did},{j},'~thor_data400::key::patriot_did_file_'+doxie.Version_SuperKey);