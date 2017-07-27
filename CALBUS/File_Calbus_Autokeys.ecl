
in_base := Calbus.File_Calbus_Base;

Layout_Autokeys := Calbus.Layouts_Calbus.Layout_Autokeys;

Layout_Autokeys normAddr(in_base l, integer c) := transform
  	self.addr.prim_range      := choose(c,l.Business_prim_range, l.Mailing_prim_range) ;
	self.addr.predir 	      := choose(c,l.Business_predir, l.Mailing_predir);
	self.addr.prim_name 	  := choose(c,l.Business_prim_name, l.Mailing_prim_name);
	self.addr.addr_suffix     := choose(c,l.Business_addr_suffix, l.Mailing_addr_suffix);
	self.addr.postdir 	      := choose(c,l.Business_postdir, l.Mailing_postdir);
	self.addr.unit_desig 	  := choose(c,l.Business_unit_desig, l.Mailing_unit_desig);
	self.addr.sec_range 	  := choose(c,l.Business_sec_range, l.Mailing_sec_range);
	self.addr.p_city_name	  := choose(c,l.Business_p_city_name, l.Mailing_p_city_name);
	self.addr.v_city_name	  := choose(c,l.Business_v_city_name, l.Mailing_v_city_name);
	self.addr.st 			  := choose(c,l.Business_st, l.Mailing_st);
	self.addr.zip5 		      := choose(c,l.Business_zip5, l.Mailing_zip5);
	self.addr.zip4 		      := choose(c,l.Business_zip4, l.Mailing_zip4);
	self.addr.addr_rec_type   := choose(c,l.Business_addr_rec_type, l.Mailing_addr_rec_type);
	self.addr.fips_state	  := choose(c,l.Business_fips_state, l.Mailing_fips_state);
	self.addr.fips_county 	  := choose(c,l.Business_fips_county, l.Mailing_fips_county);
//	self.addr.cart 		      := choose(c,l.Business_cart, l.Mailing_cart);
//	self.addr.cr_sort_sz 	  := choose(c,l.Business_cr_sort_sz, l.Mailing_cr_sort_sz);
//	self.addr.lot 		      := choose(c,l.Business_lot, l.Mailing_lot);
//	self.addr.lot_order 	  := choose(c,l.Business_lot_order, l.Mailing_lot_order);
//	self.addr.dpbc 		      := choose(c,l.Business_dpbc, l.Mailing_dpbc);
//	self.addr.chk_digit 	  := choose(c,l.Business_chk_digit, l.Mailing_chk_digit);
//	self.addr.geo_lat 	      := choose(c,l.Business_geo_lat, l.Mailing_geo_lat);
//	self.addr.geo_long 	      := choose(c,l.Business_geo_long, l.Mailing_geo_long);
//	self.addr.cbsa 		      := choose(c,l.Business_cbsa, l.Mailing_cbsa);
//	self.addr.geo_blk         := choose(c,l.Business_geo_blk, l.Mailing_geo_blk);
//	self.addr.geo_match 	  := choose(c,l.Business_geo_match, l.Mailing_geo_match);
//	self.addr.err_stat 	      := choose(c,l.Business_err_stat, l.Mailing_err_stat);
  self.OwnerCleanName.title 			:= l.Owner_title;
	self.OwnerCleanName.fname 			:= l.Owner_fname;
	self.OwnerCleanName.mname 			:= l.Owner_mname;
	self.OwnerCleanName.lname 			:= l.Owner_lname;
	self.OwnerCleanName.name_suffix := l.Owner_name_suffix;
	self.OwnerCleanName.name_score	:= l.Owner_name_score;
  self                      			:= l;	
end;

Addr_Norm_File := normalize(in_base, if((trim(left.Business_prim_range)  = trim(left.Mailing_prim_range) and
                                         trim(left.Business_prim_name)   = trim(left.Mailing_prim_name) and
                                         trim(left.Business_p_city_name) = trim(left.Mailing_p_city_name) and
                                         trim(left.Business_st)          = trim(left.Mailing_st) and
										                     trim(left.Business_zip5)        = trim(left.Mailing_zip5)) or
										                    (trim(left.Mailing_p_city_name) + trim(left.Mailing_st) + trim(left.Mailing_zip5) = '')
                                        ,1,2), normAddr(left, counter)); 

Layout_Autokeys normName(Addr_Norm_File l, integer c) := transform
	self.Owner_Name  := choose(c,l.Owner_Name, l.firm_Name);
	self             := l;
end;

Addr_Name_Norm_File := normalize(Addr_Norm_File, 
                                 if(left.Owner_Name <> left.firm_Name and
							                      trim(left.firm_Name) <> ''										
                                    ,2,1), normName(left, counter));

export File_Calbus_Autokeys := Addr_Name_Norm_File : persist('~thor_data400::persist::calbus::File_Autokeys');