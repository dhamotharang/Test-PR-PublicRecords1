#OPTION('multiplePersistInstances',FALSE);
import ut, business_header, mdr, lib_stringlib, email_data;

EXPORT As_Business_Linking ( boolean pUseOtherEnviron = _Constants().IsDataland
	,dataset(experian_fein.layouts.Base) pBase = files(,pUseOtherEnviron).base.qa, boolean IsPRCT = false	
	) := function
		
		//COMPANY MAPPING
		business_header.layout_business_linking.linking_interface	trfMap(experian_fein.layouts.Base l) := transform																				
				self.source_record_id            := l.source_rec_id;
				self.vl_id                       := trim(l.Business_Identification_Number) + trim(l.Norm_Tax_ID);
				self.source                      := l.source;
				self.company_bdid			   	       := l.bdid;
				self.company_rawaid			         := l.raw_aid ;
				self.company_name  							 := if(l.Business_Name <> ''  /* Sometimes Business_Name is blank, */
																							,l.Business_Name		    /* so use Long_Name if so.   */
																							,l.Long_Name);
				self.dt_vendor_first_reported    := (unsigned4)l.dt_vendor_last_reported;
				self.dt_vendor_last_reported     := (unsigned4)l.dt_vendor_last_reported;
				self.company_fein                := l.norm_tax_id;
				self.company_address_type_raw    := if(l.v_city_name<>'' Or l.st<>'' Or l.zip <>'' , 'BUSINESS','');
				self.company_address.prim_range  := l.prim_range;
				self.company_address.predir      := l.predir;
				self.company_address.prim_name   := l.prim_name;
				self.company_address.addr_suffix := l.addr_suffix;
				self.company_address.postdir     := l.postdir;
				self.company_address.unit_desig  := l.unit_desig;
				self.company_address.sec_range   := l.sec_range;
				self.company_address.p_city_name := l.p_city_name;
				self.company_address.v_city_name := l.v_city_name;
				self.company_address.st          := l.st;
				self.company_address.zip	       := l.zip;
				self.company_address.zip4        := l.zip4;
				self.company_address.fips_state  := l.fips_state;
				self.company_address.fips_county := l.fips_county;
				self.company_address.msa         := l.msa;
				self.company_address.geo_lat     := l.geo_lat;
				self.company_address.geo_long    := l.geo_long;
				self.company_address.cart				 := l.cart;
				self.company_address.cr_sort_sz	 := l.cr_sort_sz;
				self.company_address.lot				 := l.lot;
				self.company_address.lot_order	 := l.lot_order;
				self.company_address.dbpc				 := l.dbpc;
				self.company_address.chk_digit	 := l.chk_digit;
				self.company_address.rec_type		 := l.rec_type;
				self.company_address.geo_blk 		 := l.geo_blk;
				self.company_address.geo_match 	 := l.geo_match;
				self.company_address.err_stat 	 := l.err_stat;
  			self 							   						 := l;
				self 							   						 := [];
		end;
																	
		dMapped := project(pBase,trfMap(left));
		
		dAsLinking     := dedup(sort(distribute(dMapped,hash(vl_id,company_name)),record, local),record, local);
		dAsLinking_pst := dAsLinking : persist(experian_fein.persistnames().root + '::As_Business_Linking');
		
		return IF(IsPRCT, dAsLinking, dAsLinking_pst);
end;

