import BIPV2;

export BC_Init_Final(
		dataset(PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_CommonBase	)	pInput_BH_Init_Final		= PRTE2_BIPV2_BusHeader.BH_Init_Final()	
	
) :=
function

	//*** Business Header records
	dBH_Recs := pInput_BH_Init_Final;
	
	PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Contacts trf_Map2BusContacts(dBH_Recs l) := transform
	  self.company_address.prim_range		:= l.prim_range;
		self.company_address.predir				:= l.predir;
		self.company_address.prim_name		:= l.prim_name;
		self.company_address.addr_suffix	:= l.addr_suffix;
		self.company_address.postdir			:= l.postdir;
		self.company_address.unit_desig	 	:= l.unit_desig;
		self.company_address.sec_range		:= l.sec_range;
		self.company_address.p_city_name	:= l.p_city_name;
		self.company_address.v_city_name	:= l.v_city_name;
		self.company_address.st					 	:= l.st;
		self.company_address.zip					:= l.zip;
		self.company_address.zip4				 	:= l.zip4;
		self.company_address.cart				 	:= l.cart;
		self.company_address.cr_sort_sz	 	:= l.cr_sort_sz;
		self.company_address.lot					:= l.lot;
		self.company_address.lot_order		:= l.lot_order;
		self.company_address.dbpc				 	:= l.dbpc;
		self.company_address.chk_digit		:= l.chk_digit;
		self.company_address.rec_type		 	:= l.rec_type;
		self.company_address.fips_state	 	:= l.fips_state;
		self.company_address.fips_county	:= l.fips_county;
		self.company_address.geo_lat			:= l.geo_lat;
		self.company_address.geo_long		 	:= l.geo_long;
		self.company_address.msa					:= l.msa;
		self.company_address.geo_blk			:= l.geo_blk;
		self.company_address.geo_match		:= l.geo_match;
		self.company_address.err_stat		 	:= l.err_stat;
		self.contact_name.title			     	:= l.title;
		self.contact_name.fname			     	:= l.fname;
		self.contact_name.mname			     	:= l.mname;
		self.contact_name.lname			     	:= l.lname;
		self.contact_name.name_suffix     := l.name_suffix;
    self.contact_name.name_score	    := l.name_score;
		self                            	:= l;
		//self                              := [];
	end;
	
	dBip_BC_base := project(dBH_Recs, trf_Map2BusContacts(left));
	
	return dBip_BC_base;
	
end;
