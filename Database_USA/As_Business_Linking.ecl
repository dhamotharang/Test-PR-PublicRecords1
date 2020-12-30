#OPTION('multiplePersistInstances',FALSE);
import ut, business_header, mdr, lib_stringlib, email_data;

EXPORT As_Business_Linking (
	 boolean pUseOtherEnviron = _Constants().IsDataland
	,dataset(Database_USA.layouts.Base) pBase = files(,pUseOtherEnviron).base.qa
	,boolean IsPersist = true
	) := function		
		
		business_header.layout_business_linking.linking_interface	trfMapBLInterface(Database_USA.layouts.Base l, unsigned4 cnt) := transform																				
			,skip (cnt=2 and L.Mail_Addr_Standardized = '') 											 
				self.source_record_id            := l.record_sid; 
				self.rcid												 := 0;
				self.vl_id                       := trim(l.DBUSA_Business_ID) + trim(l.DBUSA_Executive_ID);
				self.source                      := mdr.sourcetools.src_Database_USA;
				self.company_phone               := l.Phone;
				self.phone_score                 := if((integer)self.company_phone=0,0,1);
				self.phone_type     						 := if((integer)self.company_phone=0,'','T');
				self.company_rawaid			         := l.phy_raw_aid;
				self.company_name 			         := l.Company_Name;
				self.company_name_type_raw       := l.BusinessTypeDesc;
				self.company_sic_code1:= If(ut.fn_SIC_functions.fn_validate_SICCode(l.Primary_SIC[1..4]) = 1,ut.CleanSpacesAndUpper(l.Primary_SIC[1..4]),''); 
				self.company_sic_code2 := If(ut.fn_SIC_functions.fn_validate_SICCode(l.SIC02[1..4]) = 1,ut.CleanSpacesAndUpper(l.SIC02[1..4]),'');
				self.company_sic_code3 := If(ut.fn_SIC_functions.fn_validate_SICCode(l.SIC03[1..4]) = 1,ut.CleanSpacesAndUpper(l.SIC03[1..4]),'');
				self.company_sic_code4 := If(ut.fn_SIC_functions.fn_validate_SICCode(l.SIC04[1..4]) = 1,ut.CleanSpacesAndUpper(l.SIC04[1..4]),'');
				self.company_sic_code5 := If(ut.fn_SIC_functions.fn_validate_SICCode(l.SIC05[1..4]) = 1,ut.CleanSpacesAndUpper(l.SIC05[1..4]),'');
        self.company_naics_code1 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS01) = 1,ut.CleanSpacesAndUpper(l.NAICS01),'');
        self.company_naics_code2 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS02) = 1,ut.CleanSpacesAndUpper(l.NAICS02),'');
        self.company_naics_code3 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS03) = 1,ut.CleanSpacesAndUpper(l.NAICS03),'');
        self.company_naics_code4 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS04) = 1,ut.CleanSpacesAndUpper(l.NAICS04),'');
        self.company_naics_code5 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS05) = 1,ut.CleanSpacesAndUpper(l.NAICS05),'');
				self.company_org_structure_raw   := l.business_status_code;
				self.company_address_type_raw    := choose(cnt ,'PHYSICAL'
																										   ,'MAILING'
																				           );     
				self.company_address.prim_range  := choose(cnt ,l.phy_prim_range
																										   ,l.mail_prim_range
																				           );              
				self.company_address.predir      := choose(cnt ,l.phy_predir
																										   ,l.mail_predir
																				           );                     
				self.company_address.prim_name   := choose(cnt ,l.phy_prim_name
																										   ,l.mail_prim_name
																				           );            
				self.company_address.addr_suffix := choose(cnt ,l.phy_addr_suffix
																										   ,l.mail_addr_suffix
																				           );            
				self.company_address.postdir     := choose(cnt ,l.phy_postdir
																										   ,l.mail_postdir
																				           );            
				self.company_address.unit_desig  := choose(cnt ,l.phy_unit_desig
																										   ,l.mail_unit_desig
																				           );            
				self.company_address.sec_range   := choose(cnt ,l.phy_sec_range
																										   ,l.mail_sec_range
																				           );            
				self.company_address.p_city_name := choose(cnt ,l.phy_p_city_name
																										   ,l.mail_p_city_name
																				           );            
				self.company_address.v_city_name := choose(cnt ,l.phy_v_city_name
																										   ,l.mail_v_city_name
																				           );            
				self.company_address.st          := choose(cnt ,l.phy_st
																										   ,l.mail_st
																				           );            
				self.company_address.zip	       := choose(cnt ,l.phy_zip
																										   ,l.mail_zip
																				           );            
				self.company_address.zip4        := choose(cnt ,l.phy_zip4
																										   ,l.mail_zip4
																				           );            
				self.company_address.fips_state  := choose(cnt ,l.phy_fips_state
																										   ,l.mail_fips_state
																				           );            
				self.company_address.fips_county := choose(cnt ,l.phy_fips_county
																										   ,l.mail_fips_county
																				           );            
				self.company_address.msa         := choose(cnt ,l.phy_msa
																										   ,l.mail_msa
																				           );            
				self.company_address.geo_lat     := choose(cnt ,l.phy_geo_lat
																										   ,l.mail_geo_lat
																				           );            
				self.company_address.geo_long    := choose(cnt ,l.phy_geo_long
																										   ,l.mail_geo_long
																				           );            
				self.company_url								 := l.URL;
				self.company_ticker              := l.ticker_symbol;
				self.company_ticker_exchange     := l.stock_exchange;
				self.dt_first_seen               := l.dt_first_seen;
				self.dt_last_seen                := l.dt_last_seen;
				self.dt_vendor_last_reported     := l.dt_vendor_last_reported;
				self.dt_vendor_first_reported    := l.dt_vendor_first_reported;
				self.current					           := true;
				self.dppa						             := false;
				self.contact_did                 := l.did;
				self.contact_job_title_raw       := if(l.sourcetitle != '',l.sourcetitle,l.standardized_title);
				self.contact_name.title          := l.title;
				self.contact_name.fname          := l.fname;
				self.contact_name.mname          := l.mname;
				self.contact_name.lname          := l.lname;
				self.contact_name.name_suffix		 := l.name_suffix;
				self.contact_name.name_score     := l.name_score;
				self.contact_email							 := l.email;
				self.contact_email_username			 := email_data.fn_clean_email_username(l.email);
				self.contact_email_domain				 := email_data.fn_clean_email_domain(l.email);				
			  self.employee_count_org_raw      := l.corporate_employee_total;
		    self.employee_count_local_raw    := l.location_employees_total;
		    self.revenue_local_raw           := l.location_sales_total;
				self 							   						 := l;
				self 							   						 := [];
		end;
		
		from_base      := NORMALIZE(pBase, 2, trfMapBLInterface(LEFT, counter),local);

    // Roll Up - to eliminate duplicates and keep the oldest (first) source_record_id
	  from_base_Dist := DISTRIBUTE(from_base, HASH(vl_id));
	  from_base_Sort := SORT(from_base_Dist 
												,vl_id 											,source 										,company_phone    					
												,phone_score 								,phone_type              		,company_name 							
												,company_name_type_raw			,company_sic_code1       		,company_sic_code2					
												,company_sic_code3          ,company_sic_code4       		,company_sic_code5          
												,company_address_type_raw   ,company_address.prim_range ,company_address.predir     
												,company_address.prim_name 	,company_address.postdir    ,company_address.sec_range	
												,company_address.v_city_name,company_address.st         ,company_address.zip       
												,company_address.zip4      	,company_url                ,company_ticker              
												,company_ticker_exchange    ,company_inc_state  				,contact_job_title_raw        
												,contact_name.title         ,contact_name.fname         ,contact_name.mname           
												,contact_name.lname         ,contact_name.name_suffix   ,contact_email
												,LOCAL );
	
	business_header.layout_business_linking.linking_interface RollupLinking(
												 business_header.layout_business_linking.linking_interface L, 
												 business_header.layout_business_linking.linking_interface R) := TRANSFORM
	
		Earliest_Date                 := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		SELF.source_record_id					:= IF(Earliest_Date = L.dt_vendor_first_reported, L.source_record_id, R.source_record_id);  

		SELF.dt_first_seen 						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen)
																						        ,ut.EarliestDate(L.dt_last_seen,  R.dt_last_seen));
		SELF.dt_last_seen 						:= max(L.dt_last_seen, R.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		SELF                          := L;
	END;

	from_base_Rollup := ROLLUP(from_base_Sort ,RollupLinking(LEFT, RIGHT)
												,vl_id 											,source 										,company_phone    					
												,phone_score 								,phone_type              		,company_name 							
												,company_name_type_raw			,company_sic_code1       		,company_sic_code2					
												,company_sic_code3          ,company_sic_code4       		,company_sic_code5          
												,company_address_type_raw   ,company_address.prim_range ,company_address.predir     
												,company_address.prim_name 	,company_address.postdir    ,company_address.sec_range	
												,company_address.v_city_name,company_address.st         ,company_address.zip       
												,company_address.zip4      	,company_url                ,company_ticker              
												,company_ticker_exchange    ,company_inc_state  				,contact_job_title_raw        
												,contact_name.title         ,contact_name.fname         ,contact_name.mname           
												,contact_name.lname         ,contact_name.name_suffix   ,contact_email
												,LOCAL );

    from_persist   := dedup(sort(distribute(from_base_Rollup,hash(vl_id,company_name)),record, local),record, local)
													 : persist(Database_USA.persist_names().root + '::As_Business_Linking', REFRESH(TRUE), SINGLE);											 
		
    from_nopersist := dedup(sort(distribute(from_base_Rollup,hash(vl_id,company_name)),record, local),record, local);
													 													 													
    from_dedp      := if(IsPersist, from_persist, from_nopersist);

		return from_dedp;
		
end;