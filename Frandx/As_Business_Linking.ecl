#OPTION('multiplePersistInstances',FALSE);
import ut, business_header, mdr, lib_stringlib, email_data;

EXPORT As_Business_Linking (
		boolean pUseOtherEnviron = _Constants().IsDataland
	,dataset(Frandx.layouts.Base) pBase = files(,pUseOtherEnviron).base.qa	
	) := function
	
	
		Frandx.layouts.Base  trfNormPhones(Frandx.layouts.Base l, unsigned6 ctr) := transform
				self.clean_phone	:= choose(ctr,ut.cleanPhone(l.clean_phone),ut.cleanPhone(l.clean_secondary_phone));
				self 							:= l;
		end;
		
		choosey(string pPhone, string pPhone2) := map(		pPhone	!= ''
																									and pPhone2	!= '' => 2, 1);
		
		dFrandx_ph_norm	:= normalize(pBase
																 ,choosey(ut.cleanPhone(trim(left.clean_phone,left,right)), ut.cleanPhone(trim(left.clean_secondary_phone,left,right)))
																 ,trfNormPhones(left,counter)
																);
	
			//COMPANY MAPPING
		business_header.layout_business_linking.linking_interface	trfMapBLInterface(Frandx.layouts.Base l, unsigned8 ctr) := transform																				
																							 
				self.source_record_id            := l.source_rec_id;
				self.vl_id                       := trim(l.Franchisee_Id) + trim(l.fruns);
				self.source                      := mdr.sourcetools.src_Frandx;
				//self.company_phone               := choose(ctr,ut.cleanPhone(l.clean_phone),ut.cleanPhone(l.clean_secondary_phone));
				self.company_phone               := ut.cleanPhone(l.clean_phone);
				self.phone_score                 := if((integer)self.company_phone=0,0,1);
				self.phone_type     						 := if((integer)self.company_phone=0,'','T');
				self.company_bdid			   	       := l.bdid;
				self.company_rawaid			         := l.raw_aid ;
				self.company_name 			         := choose(ctr,ut.CleanSpacesAndUpper(l.brand_name),ut.CleanSpacesAndUpper(l.company_name));
				self.company_name_type_raw 			 := choose(ctr,'DBA','LEGAL');
				self.best_fein_Indicator         := '';
				self.company_sic_code1           := l.sic_code;
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
				self.company_url								 := trim(l.website_url,left,right);
				self.dt_first_seen               := (unsigned4)l.dt_first_seen;
				self.dt_last_seen                := (unsigned4)l.dt_last_seen;
				self.dt_vendor_last_reported     := (unsigned4)l.dt_vendor_last_reported;
				self.dt_vendor_first_reported    := (unsigned4)l.dt_vendor_last_reported;
				self.current					           := true;
				self.dppa						             := false;
				self.company_fein                := '';
				self.contact_job_title_raw       := '';
				self.contact_name.title          := l.title;
				self.contact_name.fname          := l.fname;
				self.contact_name.mname          := l.mname;
				self.contact_name.lname          := l.lname;
				self.contact_name.name_suffix		 := l.name_suffix;
				self.contact_name.name_score     := '';
				self.contact_email							 := trim(l.email);
				self.contact_email_username			 := email_data.fn_clean_email_username(l.email);
				self.contact_email_domain				 := email_data.fn_clean_email_domain(l.email);
				self 							   						 := l;
				self 							   						 := [];
		end;
																	
		choosey1(string pBName, string pCName) := map(			pBName	!= ''
																										and pCName	!= '' => 2, 1);
																										
		from_frandx_norm	:= normalize(dFrandx_ph_norm
																	,choosey1(trim(left.brand_name,left,right), trim(left.company_name,left,right))
																	,trfMapBLInterface(left,counter)
																	);
																	
		from_frandx_dedp  := dedup(sort(distribute(from_frandx_norm,hash(vl_id,company_name)),record, local),record, local)
													: persist(Frandx.persistnames().root + '::As_Business_Linking');


		return from_frandx_dedp;
end;