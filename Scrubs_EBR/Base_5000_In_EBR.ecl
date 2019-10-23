import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~');

dBase := dataset(dl_or_prod + 'thor_data400::base::ebr_5000_bank_details_aid', EBR.Layout_5000_Bank_Details_Base_AID,thor);
 
	// Transform to flatten the file due to nested fields in the Base layout
	Scrubs_EBR.Base_5000_Layout_EBR trf(EBR.Layout_5000_Bank_Details_Base_AID l):= transform
			 self.clean_address_prim_range	:= l.clean_address.prim_range;
			 self.clean_address_predir			:= l.clean_address.predir;
			 self.clean_address_prim_name		:= l.clean_address.prim_name;
			 self.clean_address_addr_suffix	:= l.clean_address.addr_suffix;
			 self.clean_address_postdir			:= l.clean_address.postdir;
			 self.clean_address_unit_desig	:= l.clean_address.unit_desig;
			 self.clean_address_sec_range		:= l.clean_address.sec_range;
			 self.clean_address_p_city_name	:= l.clean_address.p_city_name;
			 self.clean_address_v_city_name	:= l.clean_address.v_city_name;
			 self.clean_address_st					:= l.clean_address.st;
			 self.clean_address_zip					:= l.clean_address.zip;
			 self.clean_address_zip4				:= l.clean_address.zip4;
			 self.clean_address_cart				:= l.clean_address.cart;
			 self.clean_address_cr_sort_sz	:= l.clean_address.cr_sort_sz;
			 self.clean_address_lot					:= l.clean_address.lot;
			 self.clean_address_lot_order		:= l.clean_address.lot_order;
			 self.clean_address_dbpc				:= l.clean_address.dbpc;
			 self.clean_address_chk_digit		:= l.clean_address.chk_digit;
			 self.clean_address_rec_type		:= l.clean_address.rec_type;
			 self.clean_address_county			:= l.clean_address.county;
			 self.clean_address_geo_lat			:= l.clean_address.geo_lat;
			 self.clean_address_geo_long		:= l.clean_address.geo_long;
			 self.clean_address_msa					:= l.clean_address.msa;
			 self.clean_address_geo_blk			:= l.clean_address.geo_blk;
			 self.clean_address_geo_match		:= l.clean_address.geo_match;
			 self.clean_address_err_stat		:= l.clean_address.err_stat;
			 self                          	:= l;																				
			 self														:= [];
	end; 

  EXPORT Base_5000_In_EBR := project(dBase, trf(left));
