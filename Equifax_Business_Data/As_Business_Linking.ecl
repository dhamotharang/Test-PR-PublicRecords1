// #OPTION('multiplePersistInstances',FALSE);
import ut, business_header, mdr, lib_stringlib, email_data, _validate;

EXPORT As_Business_Linking (	

	 boolean                                      pUseOtherEnviron  = _Constants().IsDataland
	,dataset(Equifax_Business_Data.layouts.Base)  pBase             = Equifax_Business_Data.files(,pUseOtherEnviron).base.Companies.qa
  ,boolean                                      IsPersist         = true	

) := 
function		
																
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
			  unsigned4 temp_clean_dead_date := IF(_validate.date.fIsValid(ut.date_slashed_MMDDYYYY_to_YYYYMMDD(L.EFX_DEADDT)),
			                                            (UNSIGNED4)ut.date_slashed_MMDDYYYY_to_YYYYMMDD(L.EFX_DEADDT),
																		              0);
        self.company_status_date := if(l.EFX_DEAD = 'Y', temp_clean_dead_date, 0);
        self.company_foreign_date := 0;  
        self.event_filing_date := 0;  
        self.company_name_status_raw := '';
        self.company_status_raw := if(l.EFX_DEAD = 'Y', 'DEFUNCT', '');  
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
				string temp_emp_count_range_org :=
					MAP(		
					trim(l.efx_corpempcd)='A' => '1-4',
					trim(l.efx_corpempcd)='B' => '5-9',
					trim(l.efx_corpempcd)='C' => '10-19',
					trim(l.efx_corpempcd)='D' => '20-49',
					trim(l.efx_corpempcd)='E' => '50-99',
					trim(l.efx_corpempcd)='F' => '100-249',
					trim(l.efx_corpempcd)='G' => '250-499',
					trim(l.efx_corpempcd)='H' => '500-999',
					trim(l.efx_corpempcd)='I' => '1000-4999',
					trim(l.efx_corpempcd)='J' => '5000-9999',
					trim(l.efx_corpempcd)='K' => '10000+',					
					trim(l.efx_corpempcd)='' => '',
					'');
				string temp_emp_count_range_loc :=
					MAP(		
					trim(l.efx_locempcd)='A' => '1-4',
					trim(l.efx_locempcd)='B' => '5-9',
					trim(l.efx_locempcd)='C' => '10-19',
					trim(l.efx_locempcd)='D' => '20-49',
					trim(l.efx_locempcd)='E' => '50-99',
					trim(l.efx_locempcd)='F' => '100-249',
					trim(l.efx_locempcd)='G' => '250-499',
					trim(l.efx_locempcd)='H' => '500-999',
					trim(l.efx_locempcd)='I' => '1000-4999',
					trim(l.efx_locempcd)='J' => '5000-9999',
					trim(l.efx_locempcd)='K' => '10000+',					
					trim(l.efx_locempcd)='' => '',
					'');
				string temp_rev_range_org :=
					MAP(		
					trim(l.efx_corpamountcd)='A' => '1000-499000',
					trim(l.efx_corpamountcd)='B' => '500000-999000',
					trim(l.efx_corpamountcd)='C' => '1000000-2499000',
					trim(l.efx_corpamountcd)='D' => '2500000-4999000',
					trim(l.efx_corpamountcd)='E' => '5000000-9999000',
					trim(l.efx_corpamountcd)='F' => '10000000-19999000',
					trim(l.efx_corpamountcd)='G' => '20000000-49999000',
					trim(l.efx_corpamountcd)='H' => '50000000-99999000',
					trim(l.efx_corpamountcd)='I' => '100000000-499999000',
					trim(l.efx_corpamountcd)='J' => '500000000-999999000',
					trim(l.efx_corpamountcd)='K' => '1000000000+',					
					trim(l.efx_corpamountcd)='' => '',
					'');
				string temp_rev_range_loc :=
					MAP(		
					trim(l.efx_locamountcd)='A' => '1000-499000',
					trim(l.efx_locamountcd)='B' => '500000-999000',
					trim(l.efx_locamountcd)='C' => '1000000-2499000',
					trim(l.efx_locamountcd)='D' => '2500000-4999000',
					trim(l.efx_locamountcd)='E' => '5000000-9999000',
					trim(l.efx_locamountcd)='F' => '10000000-19999000',
					trim(l.efx_locamountcd)='G' => '20000000-49999000',
					trim(l.efx_locamountcd)='H' => '50000000-99999000',
					trim(l.efx_locamountcd)='I' => '100000000-499999000',
					trim(l.efx_locamountcd)='J' => '500000000-999999000',
					trim(l.efx_locamountcd)='K' => '1000000000+',					
					trim(l.efx_locamountcd)='' => '',
					'');	 						 						 						 					
		    self.employee_count_org_raw      := if(trim(l.efx_corpempcnt) = '' OR trim(l.efx_corpempcnt) = '0',temp_emp_count_range_org,trim(l.efx_corpempcnt));
        self.revenue_org_raw             := if(trim(l.efx_corpamount) = '' OR trim(l.efx_corpamount) = '0',temp_rev_range_org,trim(l.efx_corpamount));
        self.employee_count_local_raw    := if(trim(l.efx_locempcnt) = '' OR trim(l.efx_locempcnt) = '0',temp_emp_count_range_loc,trim(l.efx_locempcnt));
		    self.revenue_local_raw           := if(trim(l.efx_locamount) = '' OR trim(l.efx_locamount) = '0',temp_rev_range_loc,trim(l.efx_locamount));
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
        ,employee_count_org_raw
        ,revenue_org_raw
        ,employee_count_local_raw
        ,revenue_local_raw
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
        ,employee_count_org_raw
        ,revenue_org_raw
        ,employee_count_local_raw
        ,revenue_local_raw
				,LOCAL );

    from_persist   := dedup(sort(distribute(from_base_Rollup,hash(vl_id,company_name)),record, local),record, local)
													 : persist(Equifax_Business_Data.persistnames().root + '::As_Business_Linking');											 
		
    from_nopersist := dedup(sort(distribute(from_base_Rollup,hash(vl_id,company_name)),record, local),record, local);
													 													 													
    from_dedp      := if(IsPersist, from_persist, from_nopersist);
    
    // -- fix big outliers in revenue.  
    ds_fix_org_revenue    := Equifax_Business_Data._Fix_Revenue(from_dedp          ,revenue_org_raw   );
    ds_fix_local_revenue  := Equifax_Business_Data._Fix_Revenue(ds_fix_org_revenue ,revenue_local_raw );


		return ds_fix_local_revenue;
		
end;