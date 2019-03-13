#OPTION('multiplePersistInstances',FALSE);
import ut, business_header, mdr, lib_stringlib, email_data;

EXPORT As_Business_Linking (
	 boolean pUseOtherEnviron = _Constants().IsDataland
	,dataset(Equifax_Business_Data.layouts.Base) pBase = files(,pUseOtherEnviron).base.qa
  ,boolean IsPersist = true	
	) := function		
																
		//COMPANY MAPPING
		business_header.layout_business_linking.linking_interface	trfMapBLInterface(Equifax_Business_Data.layouts.Base l) := transform																				
																							 
				self.source_record_id            := l.rcid;
				self.rcid                        := 0;
				self.vl_id                       := trim(l.efx_id);
				self.source                      := mdr.sourcetools.src_Equifax_Business_Data;        
				self.company_phone               := l.clean_phone;
				self.phone_score                 := if((integer)self.company_phone=0,0,1);       
				self.phone_type     						 := if((integer)self.company_phone=0,'','T');
				self.company_rawaid			         := l.raw_aid ;
				self.company_name 			         := l.clean_company_name;			
				self.company_name_type_raw 			 := if(l.normCompany_Type = 'D', 'DBA', 'LEGAL');
				self.company_sic_code1           := l.efx_primsic;
				self.company_sic_code2           := l.efx_secsic1;
				self.company_sic_code3           := l.efx_secsic2;
				self.company_sic_code4           := l.efx_secsic3;
				self.company_sic_code5           := l.efx_secsic4;
				self.company_org_structure_raw := l.EFX_BUSSTAT;
        self.company_incorporation_date := 0;
        self.company_naics_code1 := l.EFX_PRIMNAICSCODE; 
        self.company_naics_code2 := l.EFX_SECNAICS1;
        self.company_naics_code3 := l.EFX_SECNAICS2;
        self.company_naics_code4 := l.EFX_SECNAICS3;
        self.company_naics_code5 := l.EFX_SECNAICS4;	
        //P = physical address, M = mailing address;
        self.company_address_type_raw    		:= if(l.v_city_name<>'' Or l.st<>'' Or l.zip <>'',
				                                         if(l.normAddress_Type = 'P', 'PHYSICAL', 'MAILING'),'');				
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
				self.company_url								 := l.efx_web;
				self.company_ticker              := l.efx_tcksym;
				self.company_ticker_exchange     := l.efx_stkexc;
				self.company_inc_state           := '';
				self.dt_first_seen               := l.dt_first_seen;
				self.dt_last_seen                := l.dt_last_seen;
				self.dt_vendor_last_reported     := l.dt_vendor_last_reported;
				self.dt_vendor_first_reported    := l.dt_vendor_first_reported;
				self.current					           := true;
				self.dppa						             := false;
        self.company_foreign_domestic := if(l.EFX_FOREIGN = '', 'D', 'F'); 
        self.company_charter_number := '';
        self.company_filing_date := 0;  
        self.company_status_date := 0; 
        self.company_foreign_date := 0;  
        self.event_filing_date := 0;  
        self.company_name_status_raw := '';
        self.company_status_raw := '';  
				//possible future change
        // self.company_status_raw := if(l.EFX_DEAD = 'Y', 'DEFUNCT', '');  
				self.dt_first_seen_company_name := 0;
        self.dt_last_seen_company_name := 0;
        self.dt_first_seen_company_address := 0;
        self.dt_last_seen_company_address := 0;
        self.match_company_name := '';
        self.match_branch_city := '';
        self.match_geo_city := '';
				self.company_fein := '';
        self.duns_number := '';	
				self.contact_ssn := '';
				self 							   						 := l;
				self 							   						 := [];
		end;
		
		from_base      := PROJECT(pBase, trfMapBLInterface(LEFT));

 // Roll Up - to eliminate duplicates and keep the oldest (first) source_record_id
	  from_base_Dist := DISTRIBUTE(from_base, HASH(vl_id));
	  from_base_Sort := SORT(from_base_Dist 
				,rcid                        
				,vl_id                       
				,source                             
				,company_phone               
				,phone_score                       
				,phone_type     						 
				,company_rawaid			         
				,company_name 			         		
				,company_name_type_raw 			 
				,company_sic_code1           
				,company_sic_code2           
				,company_sic_code3           
				,company_sic_code4           
				,company_sic_code5           
				,company_org_structure_raw 
        ,company_incorporation_date 
        ,company_naics_code1 
        ,company_naics_code2 
        ,company_naics_code3 
        ,company_naics_code4 
        ,company_naics_code5 
        ,company_address_type_raw    		
				,company_address.prim_range  
				,company_address.predir      
				,company_address.prim_name   
				,company_address.addr_suffix 
				,company_address.postdir     
				,company_address.unit_desig  
				,company_address.sec_range   
				,company_address.p_city_name 
				,company_address.v_city_name 
				,company_address.st          
				,company_address.zip	       
				,company_address.zip4        
				,company_address.fips_state  
				,company_address.fips_county 
				,company_address.msa         
				,company_address.geo_lat     
				,company_address.geo_long    
				,company_url								 
				,company_ticker              
				,company_ticker_exchange     
				,company_inc_state           
				,dt_first_seen               
				,dt_last_seen                
				,dt_vendor_last_reported     
				,dt_vendor_first_reported    
				,current					           
				,dppa						             
        ,company_foreign_domestic  
        ,company_charter_number 
        ,company_filing_date  
        ,company_status_date  
        ,company_foreign_date  
        ,event_filing_date  
        ,company_name_status_raw 
        ,company_status_raw   
				,dt_first_seen_company_name 
        ,dt_last_seen_company_name 
        ,dt_first_seen_company_address 
        ,dt_last_seen_company_address 
        ,match_company_name 
        ,match_branch_city 
        ,match_geo_city 
				,company_fein 
        ,duns_number 	
				,contact_ssn 
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
				,rcid                        
				,vl_id                       
				,source                             
				,company_phone               
				,phone_score                       
				,phone_type     						 
				,company_rawaid			         
				,company_name 			         		
				,company_name_type_raw 			 
				,company_sic_code1           
				,company_sic_code2           
				,company_sic_code3           
				,company_sic_code4           
				,company_sic_code5           
				,company_org_structure_raw 
        ,company_incorporation_date 
        ,company_naics_code1 
        ,company_naics_code2 
        ,company_naics_code3 
        ,company_naics_code4 
        ,company_naics_code5 
        ,company_address_type_raw    		
				,company_address.prim_range  
				,company_address.predir      
				,company_address.prim_name   
				,company_address.addr_suffix 
				,company_address.postdir     
				,company_address.unit_desig  
				,company_address.sec_range   
				,company_address.p_city_name 
				,company_address.v_city_name 
				,company_address.st          
				,company_address.zip	       
				,company_address.zip4        
				,company_address.fips_state  
				,company_address.fips_county 
				,company_address.msa         
				,company_address.geo_lat     
				,company_address.geo_long    
				,company_url								 
				,company_ticker              
				,company_ticker_exchange     
				,company_inc_state           
				,dt_first_seen               
				,dt_last_seen                
				,dt_vendor_last_reported     
				,dt_vendor_first_reported    
				,current					           
				,dppa						             
        ,company_foreign_domestic  
        ,company_charter_number 
        ,company_filing_date  
        ,company_status_date  
        ,company_foreign_date  
        ,event_filing_date  
        ,company_name_status_raw 
        ,company_status_raw   
				,dt_first_seen_company_name 
        ,dt_last_seen_company_name 
        ,dt_first_seen_company_address 
        ,dt_last_seen_company_address 
        ,match_company_name 
        ,match_branch_city 
        ,match_geo_city 
				,company_fein 
        ,duns_number 	
				,contact_ssn 
				,LOCAL );

    from_persist   := dedup(sort(distribute(from_base_Rollup,hash(vl_id,company_name)),record, local),record, local)
													 : persist(Equifax_Business_Data.persistnames().root + '::As_Business_Linking');											 
		
    from_nopersist := dedup(sort(distribute(from_base_Rollup,hash(vl_id,company_name)),record, local),record, local);
													 													 													
    from_dedp      := if(IsPersist, from_persist, from_nopersist);

		return from_dedp;
		
end;