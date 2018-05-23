﻿#OPTION('multiplePersistInstances',FALSE);
import ut, business_header, mdr, lib_stringlib, email_data;

EXPORT As_Business_Linking (
	 boolean pUseOtherEnviron = _Constants().IsDataland
	,dataset(Infutor_NARB.layouts.Base) pBase = files(,pUseOtherEnviron).base.qa
	,boolean IsPersist = true
	) := function
	
		// Normalize on the two company phone numbers
		Infutor_NARB.Layouts.Base normTrf(Infutor_NARB.Layouts.Base L, unsigned1 cnt) := transform
			,skip ( (cnt=2 and ut.CleanPhone(L.toll_free_number) in ['','0',l.clean_phone]) or
			        (cnt=2 and L.normCompany_Type = 'P') ) 
				 
				 self.clean_phone  := choose(cnt ,L.clean_phone ,ut.CleanPhone(L.toll_free_number));  
				 self			         := L;
				 self 						 := [];
			end;
		normPhones	:= normalize(pBase, 2, normTrf(left, counter));
		
																
		//COMPANY MAPPING
		business_header.layout_business_linking.linking_interface	trfMapBLInterface(Infutor_NARB.layouts.Base l) := transform																				
																							 
				self.rcid                        := l.rcid;
				self.vl_id                       := trim(l.pid) + trim(l.record_id);
				self.source                      := mdr.sourcetools.src_infutor_narb;
				self.company_phone               := l.clean_phone;
				self.phone_score                 := if((integer)self.company_phone=0,0,1);
				self.phone_type     						 := if((integer)self.company_phone=0,'','T');
				self.company_rawaid			         := l.raw_aid ;
				self.company_name 			         := l.clean_company_name;
				self.company_sic_code1           := l.sic1;
				self.company_sic_code2           := l.sic2;
				self.company_sic_code3           := l.sic3;
				self.company_sic_code4           := l.sic4;
				self.company_sic_code5           := l.sic5;
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
				self.company_url								 := l.url;
				self.company_ticker              := l.stock_symbol;
				self.company_ticker_exchange     := l.stock_exchange;
				self.company_inc_state           := l.incorporation_state;
				self.dt_first_seen               := l.dt_first_seen;
				self.dt_last_seen                := l.dt_last_seen;
				self.dt_vendor_last_reported     := l.dt_vendor_last_reported;
				self.dt_vendor_first_reported    := l.dt_vendor_last_reported;
				self.current					           := true;
				self.dppa						             := false;
				self.contact_did                 := l.did;
				self.contact_job_title_raw       := l.contact_title;
				self.contact_name.title          := l.title;
				self.contact_name.fname          := l.fname;
				self.contact_name.mname          := l.mname;
				self.contact_name.lname          := l.lname;
				self.contact_name.name_suffix		 := l.name_suffix;
				self.contact_name.name_score     := l.name_score;
				self.contact_email							 := l.email;
				self.contact_email_username			 := email_data.fn_clean_email_username(l.email);
				self.contact_email_domain				 := email_data.fn_clean_email_domain(l.email);
				self 							   						 := l;
				self 							   						 := [];
		end;
		
		from_base      := PROJECT(normPhones,trfMapBLInterface(LEFT));

    from_persist   := dedup(sort(distribute(from_base,hash(vl_id,company_name)),record, local),record, local)
													 : persist(Infutor_NARB.persistnames().root + '::As_Business_Linking');											 
		
    from_nopersist := dedup(sort(distribute(from_base,hash(vl_id,company_name)),record, local),record, local);
													 													 													
    from_dedp      := if(IsPersist, from_persist, from_nopersist);

		return from_dedp;
		
end;