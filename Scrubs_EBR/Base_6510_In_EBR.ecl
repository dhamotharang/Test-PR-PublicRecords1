import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~'); 

dBase := dataset(dl_or_prod + 'thor_data400::base::ebr_6510_Government_Debarred_Contractor_aid', EBR.Layout_6510_Government_Debarred_Contractor_Base_AID,thor);
 
	// Transform to flatten the file due to nested fields in the Base layout
	Scrubs_EBR.Base_6510_Layout_EBR trf(EBR.Layout_6510_Government_Debarred_Contractor_Base_AID l):= transform
			 self.clean_business_address_prim_range	 := l.clean_business_address.prim_range;
			 self.clean_business_address_predir			 := l.clean_business_address.predir;
			 self.clean_business_address_prim_name	 := l.clean_business_address.prim_name;
			 self.clean_business_address_addr_suffix := l.clean_business_address.addr_suffix;
			 self.clean_business_address_postdir		 := l.clean_business_address.postdir;
			 self.clean_business_address_unit_desig	 := l.clean_business_address.unit_desig;
			 self.clean_business_address_sec_range	 := l.clean_business_address.sec_range;
			 self.clean_business_address_p_city_name := l.clean_business_address.p_city_name;
			 self.clean_business_address_v_city_name := l.clean_business_address.v_city_name;
			 self.clean_business_address_st					 := l.clean_business_address.st;
			 self.clean_business_address_zip				 := l.clean_business_address.zip;
			 self.clean_business_address_zip4				 := l.clean_business_address.zip4;
			 self.clean_business_address_cart				 := l.clean_business_address.cart;
			 self.clean_business_address_cr_sort_sz	 := l.clean_business_address.cr_sort_sz;
			 self.clean_business_address_lot				 := l.clean_business_address.lot;
			 self.clean_business_address_lot_order	 := l.clean_business_address.lot_order;
			 self.clean_business_address_dbpc				 := l.clean_business_address.dbpc;
			 self.clean_business_address_chk_digit	 := l.clean_business_address.chk_digit;
			 self.clean_business_address_rec_type		 := l.clean_business_address.rec_type;
			 self.clean_business_address_county			 := l.clean_business_address.county;
			 self.clean_business_address_geo_lat		 := l.clean_business_address.geo_lat;
			 self.clean_business_address_geo_long		 := l.clean_business_address.geo_long;
			 self.clean_business_address_msa				 := l.clean_business_address.msa;
			 self.clean_business_address_geo_blk		 := l.clean_business_address.geo_blk;
			 self.clean_business_address_geo_match	 := l.clean_business_address.geo_match;
			 self.clean_business_address_err_stat		 := l.clean_business_address.err_stat;
		   self.clean_business_name_title       	 := l.clean_business_name.title;
			 self.clean_business_name_fname       	 := l.clean_business_name.fname;
			 self.clean_business_name_mname       	 := l.clean_business_name.mname;
			 self.clean_business_name_lname       	 := l.clean_business_name.lname;
			 self.clean_business_name_name_suffix 	 := l.clean_business_name.name_suffix;
			 self.clean_business_name_name_score  	 := l.clean_business_name.name_score;
			 self                          	      	 := l;																				
			 self														      	 := [];
	end; 

  EXPORT Base_6510_In_EBR := project(dBase, trf(left));