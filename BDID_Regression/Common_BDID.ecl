import business_header_ss, ut, header_slimsort,didville, business_header, did_add;

bdid_regression.layout_common bdids(bdid_regression.layout_common l) := transform
	self.bdid := 0;
	self.bdid_score := 0;
	self := l;
end;

common_in := project(bdid_regression.common_prep, bdids(left));

matchset := ['A','F','P','N'];

business_header_ss.MAC_Match_Flex
	(common_in, matchset,						
	 name,
	 prim_range, prim_name, z5, sec_range, st, phone10, fein,
	 BDID,   			
	 bdid_regression.layout_common, 
	 true, bdid_score,
	 common_wbdid)

export common_bdid := common_wbdid; //persist('~common_did', '400way');