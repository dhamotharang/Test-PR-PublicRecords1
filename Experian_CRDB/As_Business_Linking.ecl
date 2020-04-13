#OPTION('multiplePersistInstances',FALSE);
import ut, business_header, mdr, lib_stringlib, email_data, _validate;

EXPORT As_Business_Linking ( boolean pUseOtherEnviron 		= _Constants().IsDataland
														,dataset(layouts.Base) pBase 	= files().base.qa(company_name<>'')
	                          ,boolean IsPersist = true
													  ) := function
			//COMPANY MAPPING
		business_header.layout_business_linking.linking_interface	trfMapBLInterface(layouts.Base l,unsigned8 ctr):= transform	,skip(ctr=2 and trim(l.Clean_DBA_Name)='')
				self.source_record_id            := l.source_rec_id;
				self.vl_id                       := trim(l.Experian_Bus_Id) ;
				self.source                      := mdr.sourcetools.src_Experian_CRDB;
				self.company_phone               := ut.cleanPhone(l.Phone_Number);
				self.phone_score                 := if((integer)self.company_phone=0,0,1);
				self.phone_type     						 := if((integer)self.company_phone=0,'','T');
				self.company_bdid			   	       := l.bdid;
				self.company_rawaid			         := l.raw_aid ;
				self.company_name 			         := choose(ctr,trim(l.company_name,left,right),trim(l.Clean_DBA_Name,left,right));
			  self.company_name_type_raw 			 := if(ctr=1 and trim(l.company_name)<>'' ,'LEGAL',if(ctr=2 and trim(l.Clean_DBA_Name) <>'', 'DBA', ''));
				self.company_sic_code1           := l.Primary_SIC_Code;
				self.company_sic_code2					 := l.Second_SIC_Code	;
				self.company_sic_code3					 := l.Third_SIC_Code;
				self.company_sic_code4					 := l.Fourth_SIC_Code;
				self.company_sic_code5					 := l.Fifth_SIC_Code; 
				self.company_naics_code1				 := l.Primary_NAICS_Code;
				self.company_naics_code2				 := l.Second_NAICS_Code;
				self.company_naics_code3				 := l.Third_NAICS_Code;
				self.company_naics_code4				 := l.Fourth_NAICS_Code;
				self.company_address_type_raw    := 'CC';
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
				self.company_url								 := trim(l.url,left,right);								 
				self.dt_first_seen               := (unsigned4)l.Last_Experian_Inquiry_Date;				
				self.dt_last_seen                := (unsigned4)l.Last_Experian_Inquiry_Date;
				self.dt_vendor_first_reported    := (unsigned4)l.dt_vendor_first_reported;
				self.dt_vendor_last_reported     := (unsigned4)l.dt_vendor_last_reported;			
				self.contact_job_title_raw			 := l.Executive_Title; //Raw vendor data or vendors field name - Examples: CHIEF EXECUTIVE
				self.contact_name.title          := l.title;
				self.contact_name.fname          := l.fname;
				self.contact_name.mname          := l.mname;
				self.contact_name.lname          := l.lname;
				self.contact_name.name_suffix		 := l.name_suffix;
				self.contact_name.name_score     := Business_Header.CleanName(l.fname, l.mname, l.lname, l.name_suffix)[142];
				self.current					           := true;
				self.dppa						             := false;
				string temp_employees            := if(trim(l.estimated_number_of_employees) != '0',trim(l.estimated_number_of_employees),'');
				string sales_sign                := if(trim(l.estimated_annual_sales_amount_sign) = '-',trim(l.estimated_annual_sales_amount_sign),'');
		    self.employee_count_local_raw    := if(temp_employees != '0', temp_employees, '');
				self.revenue_local_raw           := if((STRING)((INTEGER)(l.estimated_annual_sales_amount)) != '0',sales_sign + trim(l.estimated_annual_sales_amount),'');
				self 							   						 := l;
				self 							   						 := [];
		end;											
		
		mapping_company_res				  := normalize(pBase,2,trfMapBLInterface(left,counter));
		from_Experian_CRDB_dist 		:= distribute(mapping_company_res,hash(vl_id,company_name));
		from_Experian_CRDB_sort    	:= sort(from_Experian_CRDB_dist, vl_id, company_name, -company_address.zip, -company_address.prim_name, -company_address.prim_range, -company_address.v_city_name, -company_address.st, 
																				contact_name.fname, contact_name.mname, contact_name.lname, contact_job_title_raw, dt_vendor_first_reported, local);
		
	  business_header.layout_business_linking.linking_interface  x4(business_header.layout_business_linking.linking_interface  l, business_header.layout_business_linking.linking_interface  r) := transform
			self.dt_first_seen            := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen, r.dt_first_seen),
																											 ut.EarliestDate(l.dt_last_seen, r.dt_last_seen));
			self.dt_last_seen             := max(l.dt_last_seen, r.dt_last_seen);
			self.dt_vendor_last_reported  := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
			self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
			self.source_record_id					:= if(l.dt_vendor_first_reported < r.dt_vendor_first_reported, l.source_record_id, r.source_record_id);
			self 													:= l;			
	  end;
		
		from_Experian_CRDB_rollup_persist    := rollup(from_Experian_CRDB_sort,
																							    left.vl_id 							  				= right.vl_id
																			and         left.company_name	  						  = right.company_name
																			and(  (     left.company_address.zip			    =	right.company_address.zip 
																							and left.company_address.prim_name    =	right.company_address.prim_name 
																							and left.company_address.prim_range   = right.company_address.prim_range
																							and left.company_address.v_city_name  = right.company_address.v_city_name
																							and left.company_address.st           = right.company_address.st
																						 )      		OR 
																						 (     right.company_address.zip				='' 
																						   and right.company_address.prim_name  ='' 
																							 and right.company_address.prim_range	='' 
																							 and right.company_address.v_city_name='' 
																							 and right.company_address.st					=''
																						  )
											                    )
																	 	   and(        left.contact_name.fname					= right.contact_name.fname
																					     and left.contact_name.mname    			= right.contact_name.mname
																					     and left.contact_name.lname   				= right.contact_name.lname
																					     and left.contact_job_title_raw 			= right.contact_job_title_raw
														              ),x4(left,right),local)	: persist(Experian_CRDB.persistnames().root + '::As_Business_Linking');
																					
		
		from_Experian_CRDB_rollup_nopersist    := rollup(from_Experian_CRDB_sort,
																							    left.vl_id 							  				= right.vl_id
																			and         left.company_name	  						  = right.company_name
																			and(  (     left.company_address.zip			    =	right.company_address.zip 
																							and left.company_address.prim_name    =	right.company_address.prim_name 
																							and left.company_address.prim_range   = right.company_address.prim_range
																							and left.company_address.v_city_name  = right.company_address.v_city_name
																							and left.company_address.st           = right.company_address.st
																						 )      		OR 
																						 (     right.company_address.zip				='' 
																						   and right.company_address.prim_name  ='' 
																							 and right.company_address.prim_range	='' 
																							 and right.company_address.v_city_name='' 
																							 and right.company_address.st					=''
																						  )
											                    )
																	 	   and(        left.contact_name.fname					= right.contact_name.fname
																					     and left.contact_name.mname    			= right.contact_name.mname
																					     and left.contact_name.lname   				= right.contact_name.lname
																					     and left.contact_job_title_raw 			= right.contact_job_title_raw
														              ),x4(left,right),local);	
																					
		from_Experian_CRDB_rollup := if(IsPersist, from_Experian_CRDB_rollup_persist, from_Experian_CRDB_rollup_nopersist);																			
																					
		return from_Experian_CRDB_rollup;
		
end;