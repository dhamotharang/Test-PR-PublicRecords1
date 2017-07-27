in_file 				:= Txbus.File_Txbus_Base;

Layout_Autokeys := Txbus.Layouts_Txbus.Layout_Autokeys;

Layout_Base 		:=  Txbus.Layouts_Txbus.Layout_Base;

Layout_Base normAddr(in_file l, integer c) := transform
	self.Taxpayer_prim_range      := choose(c,l.Taxpayer_prim_range, l.Outlet_prim_range) ;
	self.Taxpayer_predir 	     		:= choose(c,l.Taxpayer_predir, l.Outlet_predir);
	self.Taxpayer_prim_name 	  	:= choose(c,l.Taxpayer_prim_name, l.Outlet_prim_name);
	self.Taxpayer_addr_suffix     := choose(c,l.Taxpayer_addr_suffix, l.Outlet_addr_suffix);
	self.Taxpayer_postdir 	      := choose(c,l.Taxpayer_postdir, l.Outlet_postdir);
	self.Taxpayer_unit_desig 	  	:= choose(c,l.Taxpayer_unit_desig, l.Outlet_unit_desig);
	self.Taxpayer_sec_range 	  	:= choose(c,l.Taxpayer_sec_range, l.Outlet_sec_range);
	self.Taxpayer_p_city_name	  	:= choose(c,l.Taxpayer_p_city_name, l.Outlet_p_city_name);
	self.Taxpayer_v_city_name	  	:= choose(c,l.Taxpayer_v_city_name, l.outlet_v_city_name);
	self.Taxpayer_st 			  			:= choose(c,l.Taxpayer_st, l.Outlet_st);
	self.Taxpayer_zip5 		      	:= choose(c,l.Taxpayer_zip5, l.Outlet_zip5);
	self.Taxpayer_zip4 		      	:= choose(c,l.Taxpayer_zip4, l.Outlet_zip4);
	self.Taxpayer_cart 		      	:= choose(c,l.Taxpayer_cart, l.outlet_cart);
	self.Taxpayer_cr_sort_sz 	  	:= choose(c,l.Taxpayer_cr_sort_sz, l.Outlet_cr_sort_sz);
	self.Taxpayer_lot 		      	:= choose(c,l.Taxpayer_lot, l.Outlet_lot);
	self.Taxpayer_lot_order 	  	:= choose(c,l.Taxpayer_lot_order, l.Outlet_lot_order);
	self.Taxpayer_dpbc 		      	:= choose(c,l.Taxpayer_dpbc, l.Outlet_dpbc);
	self.Taxpayer_chk_digit 	  	:= choose(c,l.Taxpayer_chk_digit, l.Outlet_chk_digit);
	self.Taxpayer_addr_rec_type	  := choose(c,l.Taxpayer_addr_rec_type, l.Outlet_addr_rec_type);
	self.Taxpayer_fips_state	  	:= choose(c,l.Taxpayer_fips_state, l.Outlet_fips_state);
	self.Taxpayer_fips_county 	  := choose(c,l.Taxpayer_fips_county, l.Outlet_fips_county);
	self.Taxpayer_geo_lat 	      := choose(c,l.Taxpayer_geo_lat, l.Outlet_geo_lat);
	self.Taxpayer_geo_long 	      := choose(c,l.Taxpayer_geo_long, l.Outlet_geo_long);
	self.Taxpayer_cbsa 		      	:= choose(c,l.Taxpayer_cbsa, l.Outlet_cbsa);
	self.Taxpayer_geo_blk         := choose(c,l.Taxpayer_geo_blk, l.Outlet_geo_blk);
	self.Taxpayer_geo_match 	  	:= choose(c,l.Taxpayer_geo_match, l.Outlet_geo_match);
	self.Taxpayer_err_stat 	      := choose(c,l.Taxpayer_err_stat, l.Outlet_err_stat);	
	self := l;
end;

Addr_Norm_File := normalize(in_file, if((trim(left.Taxpayer_prim_range)  = trim(left.Outlet_prim_range) and
                                         trim(left.Taxpayer_prim_name)   = trim(left.Outlet_prim_name) and
                                         trim(left.Taxpayer_p_city_name) = trim(left.Outlet_p_city_name) and
                                         trim(left.Taxpayer_st)          = trim(left.Outlet_st) and
										                     trim(left.Taxpayer_zip5)        = trim(left.Outlet_zip5)) or 
										                    (trim(left.Outlet_p_city_name) + trim(left.Outlet_st) + trim(left.Outlet_zip5) = '')										
                                        ,1,2), normAddr(left, counter));


Layout_Base normName(Addr_Norm_File l, integer c) := transform
	self.Taxpayer_Name  := choose(c,l.Taxpayer_Name, l.Outlet_Name);
	self                := l;
end;

Name_Addr_Norm_File := normalize(Addr_Norm_File, 
                                 if(left.Taxpayer_Name <> left.Outlet_Name and
									                  trim(left.Outlet_Name) <> ''										
                                    ,2,1), normName(left, counter));

Layout_Base normPhone(Name_Addr_Norm_File l, integer c) := transform
	self.Taxpayer_Phone   := choose(c,l.Taxpayer_Phone, l.Outlet_Phone);
	self                  := l;
end;

Phone_Name_Addr_Norm_File := normalize(Name_Addr_Norm_File, 
                                       if(left.Taxpayer_Phone <> left.Outlet_Phone and
										                      trim(left.Outlet_Phone) <> ''										
                                          ,2,1), normPhone(left, counter));


Layout_Autokeys trfAutokeys(Phone_Name_Addr_Norm_File l) := transform
	self.Name                          := l.Taxpayer_Name;
	self.addr.prim_range               := l.Taxpayer_prim_range;
	self.addr.predir 	         	       := l.Taxpayer_predir;
	self.addr.prim_name                := l.Taxpayer_prim_name;
	self.addr.addr_suffix              := l.Taxpayer_addr_suffix;
	self.addr.postdir 	               := l.Taxpayer_postdir;
	self.addr.unit_desig               := l.Taxpayer_unit_desig;
	self.addr.sec_range                := l.Taxpayer_sec_range;
	self.addr.p_city_name              := l.Taxpayer_p_city_name;
	self.addr.v_city_name              := l.Taxpayer_v_city_name;
	self.addr.st 		         		       := l.Taxpayer_st;
	self.addr.zip5 		         	       := l.Taxpayer_zip5;
	self.addr.zip4 		           			 := l.Taxpayer_zip4;
	self.addr.addr_rec_type            := l.Taxpayer_addr_rec_type;
	self.addr.fips_state               := l.Taxpayer_fips_state;
	self.addr.fips_county              := l.Taxpayer_fips_county;
	//self.addr.cart 		     := l.Taxpayer_cart;
	//self.addr.cr_sort_sz       := l.Taxpayer_cr_sort_sz;
	//self.addr.lot 		     := l.Taxpayer_lot;
	//self.addr.lot_order        := l.Taxpayer_lot_order;
	//self.addr.dpbc 		     := l.Taxpayer_dpbc;
	//self.addr.chk_digit        := l.Taxpayer_chk_digit;
	//self.addr.geo_lat 	     := l.Taxpayer_geo_lat;
	//self.addr.geo_long 	     := l.Taxpayer_geo_long;
	//self.addr.cbsa 		     := l.Taxpayer_cbsa;
	//self.addr.geo_blk          := l.Taxpayer_geo_blk;
	//self.addr.geo_match        := l.Taxpayer_geo_match;
	//self.addr.err_stat 	     := l.Taxpayer_err_stat;
	self.Phone                         := l.Taxpayer_Phone;
	self.taxpayerCleanName.title       := l.Taxpayer_title;
	self.taxpayerCleanName.fname       := l.Taxpayer_fname;
	self.taxpayerCleanName.mname       := l.Taxpayer_mname;
	self.taxpayerCleanName.lname       := l.Taxpayer_lname;
	self.taxpayerCleanName.name_suffix := l.Taxpayer_name_suffix;
	self.taxpayerCleanName.name_score  := l.Taxpayer_name_score;
	self                               := l;	
end;

File_For_Autokeys := project(Phone_Name_Addr_Norm_File, trfAutokeys(left));

dis_file          := distribute(File_For_Autokeys, hash64(Taxpayer_Number, Outlet_Number, Name));

deduped_file      := dedup(sort(dis_file, record, local), record, local);

export File_Txbus_Autokeys := deduped_file : persist(Txbus.Constants.cluster +'persist::txbus::Autokeys_base');