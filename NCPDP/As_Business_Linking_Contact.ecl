IMPORT BIPV2, tools, ut, business_header, mdr, lib_STRINGlib, email_data;

EXPORT As_Business_Linking_Contact (
	  DATASET(NCPDP.layouts.Keybuild) pHead = files().keybuild_base.Built) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(NCPDP.layouts.Keybuild l, UNSIGNED8 ctr) := 
      TRANSFORM, SKIP((ctr = 1 AND ut.cleanPhone(l.phys_loc_phone) = '') OR
                      (ctr = 2 AND ut.cleanPhone(l.phys_loc_fax_number) = ''))
																							 
				SELF.source                      := MDR.sourceTools.src_NCPDP;
				SELF.dt_first_seen               := (UNSIGNED4)l.dt_first_seen;
				SELF.dt_last_seen                := (UNSIGNED4)l.dt_last_seen;
 				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := ut.fnTrim2Upper(l.legal_business_name);
				SELF.company_address.prim_range  := l.phys_prim_range;
				SELF.company_address.predir      := l.phys_predir;
				SELF.company_address.prim_name   := l.phys_prim_name;
				SELF.company_address.addr_suffix := l.phys_addr_suffix;
				SELF.company_address.postdir     := l.phys_postdir;
				SELF.company_address.unit_desig  := l.phys_unit_desig;
				SELF.company_address.sec_range   := l.phys_sec_range;
				SELF.company_address.p_city_name := l.phys_p_city_name;
				SELF.company_address.v_city_name := l.phys_v_city_name;
				SELF.company_address.st          := l.phys_state;
				SELF.company_address.zip	       := l.phys_zip5;
				SELF.company_address.zip4        := l.phys_zip4;
				SELF.company_fein                := l.federal_tax_id;
 				SELF.company_phone               := CHOOSE(ctr,ut.cleanPhone(l.phys_loc_phone),ut.cleanPhone(l.phys_loc_fax_number));
				// SELF.phone_score                 := IF((INTEGER)SELF.company_phone=0,0,1);
				SELF.phone_type     						 := IF((INTEGER)SELF.company_phone=0,'',IF(ctr=1,'T','F'));
				SELF.contact_name.title          := l.contact_title;
				SELF.contact_name.fname          := l.contact_first_name;
				SELF.contact_name.mname          := l.contact_middle_initial;
				SELF.contact_name.lname          := l.contact_last_name;
				SELF.contact_name.name_suffix		 := l.suffix;
				SELF.contact_email							 := TRIM(l.contact_email);
 				SELF.contact_phone               := ut.cleanPhone(l.contact_phone);       
				// SELF.company_rawaid			         := l.raw_aid ;
				// SELF.company_name_type_raw 			 := CHOOSE(ctr,'DBA','LEGAL');
				// SELF.best_fein_Indicator         := '';
				// SELF.company_sic_code1           := l.sic_code;
				// SELF.company_address_type_raw    := IF(l.v_city_name<>'' OR l.st<>'' OR l.zip <>'' , 'BUSINESS','');
				// SELF.company_address.fips_state  := l.fips_state;
				// SELF.company_address.fips_county := l.fips_county;
				// SELF.company_address.msa         := l.msa;
				// SELF.company_address.geo_lat     := l.geo_lat;
				// SELF.company_address.geo_long    := l.geo_long;
				// SELF.company_url								 := TRIM(l.website_url,LEFT,RIGHT);
				// SELF.dt_vendor_last_reported     := (UNSIGNED4)l.dt_vendor_last_reported;
				// SELF.dt_vendor_first_reported    := (UNSIGNED4)l.dt_vendor_last_reported;
				// SELF.current					           := TRUE;
				// SELF.dppa						             := FALSE;
				// SELF.contact_job_title_raw       := '';
				// SELF.contact_name.name_score     := '';
				// SELF.contact_email_username			 := email_data.fn_clean_email_username(l.email);
				// SELF.contact_email_domain				 := email_data.fn_clean_email_domain(l.email);
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_ncpdp_norm	:= NORMALIZE(pHead, 2, trfMAPBLInterface(LEFT,COUNTER));
																	
		from_ncpdp_dedp  := DEDUP(SORT(DISTRIBUTE(from_ncpdp_norm,HASH(company_fein,company_name)),RECORD, LOCAL),RECORD, LOCAL);

		RETURN from_ncpdp_dedp;
END;