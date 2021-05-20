import ut, business_header, mdr, std, cortera;

asBusinessLinkingBase := Cortera.Files().Base.Executives.QA; //dataset('~thor_data400::cortera::executives', cortera.Layout_Executives, thor);

EXPORT As_Business_Linking() := FUNCTION

		/**
			counter values
				1		primary name, phone
				2		primary name, fax
				3		alternate name, phone
				4		alternate name, fax
		**/
		business_header.layout_business_linking.linking_interface xBiz(asBusinessLinkingBase hdr, integer n) := TRANSFORM,
				SKIP((n in [2,4] and hdr.clean_fax='') OR (n in [3,4] and hdr.alternate_business_name=''))

		self.rcid := 0;
		self.vl_id := (string)hdr.LINK_ID;
		self.source := Mdr.sourceTools.src_Cortera;
		SELF.dt_first_seen						:= hdr.dt_first_seen;
		SELF.dt_last_seen							:= hdr.dt_last_seen;
		SELF.dt_vendor_first_reported := hdr.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= hdr.dt_vendor_last_reported;
		
		self.company_name	:= CHOOSE(n,hdr.name,hdr.name,
																		hdr.alternate_business_name,hdr.alternate_business_name,'');
		self.company_name_type_raw	:= CHOOSE(n,'LEGAL','DBA','');
		
		self.company_incorporation_date := 10000 * (integer)hdr.YEAR_START;
		self.company_org_structure_raw := CASE(hdr.OWNERSHIP,
																				'P' => 'PUBLIC',
																				'V' => 'PRIVATE',
																				'');
		self.company_status_raw := IF(hdr.Is_Closed='Y', 'CLOSED', CASE(hdr.STATUS,
																					'A' => 'ACTIVE',
																					'D' => 'DORMANT',''));
	
		// address fields
		self.company_address_type_raw    := if(hdr.v_city_name<>'' Or hdr.st<>'' Or hdr.zip <>'' , 
																						CASE(hdr.POSITION_TYPE,
																						'H' => 'HEADQUARTERS',
																						'B' => 'BRANCH',
																						'S' => 'PRIMARY',
																						'BUSINESS'),
																				'');
		self.dt_first_seen_company_address := (unsigned4)hdr.LOC_DATE_LAST_SEEN;
		self.company_address.prim_range  := hdr.prim_range;
		self.company_address.predir      := hdr.predir;
		self.company_address.prim_name   := hdr.prim_name;
		self.company_address.addr_suffix := hdr.addr_suffix;
		self.company_address.postdir     := hdr.postdir;
		self.company_address.unit_desig  := hdr.unit_desig;
		self.company_address.sec_range   := hdr.sec_range;
		self.company_address.p_city_name := hdr.p_city_name;
		self.company_address.v_city_name := hdr.v_city_name;
		self.company_address.st          := hdr.st;
		self.company_address.zip	       := hdr.zip;
		self.company_address.zip4        := hdr.zip4;
		self.company_address.fips_state  := hdr.county[1..2];
		self.company_address.fips_county := hdr.county[3..5];
		self.company_address.msa         := hdr.msa;
		self.company_address.geo_lat     := hdr.geo_lat;
		self.company_address.geo_long    := hdr.geo_long;
		self.company_address.cart				 := hdr.cart;
		self.company_address.cr_sort_sz  := hdr.cr_sort_sz;
		self.company_address.lot				 := hdr.lot;	
		self.company_address.lot_order	 := hdr.lot_order;
		self.company_address.dbpc	 := hdr.dbpc;
		self.company_address.chk_digit	 := hdr.chk_digit;
		self.company_address.rec_type	 := hdr.rec_type;
		self.company_address.geo_blk	 := hdr.geo_blk;
		self.company_address.geo_match	 := hdr.geo_match;
		self.company_address.err_stat	 := hdr.err_stat;
		
		self.company_url								 := trim(hdr.url,left,right);
		
		self.company_fein := hdr.fein;
		self.company_sic_code1 := hdr.PRIMARY_SIC;
		self.company_naics_code1 := hdr.PRIMARY_NAICS;
		
		SELF.company_phone := CHOOSE(n,hdr.clean_phone,hdr.clean_fax,hdr.clean_phone,hdr.clean_fax);
		self.phone_type := IF(self.company_phone = '', '', 
													CHOOSE(n, 'T','F','T','F',''));
		self.phone_score := if((integer)self.company_phone=0,0,1);
		
		// contact info
		self.contact_name.title					:= hdr.title;
		self.contact_name.fname					:= hdr.fname;
		self.contact_name.mname					:= hdr.mname;
		self.contact_name.lname					:= hdr.lname;
		self.contact_name.name_suffix		:= hdr.name_suffix;
		self.contact_did   							:= hdr.did;
		self.contact_type_raw 					:= 'EXECUTIVE';
		self.contact_job_title_raw			:= hdr.Executive_Title;
		
		self.company_foreign_domestic := IF(hdr.country='US','D','F');

		self.source_record_id            := ((unsigned8)hdr.link_id << 32) | HASH32(self.company_name,SELF.company_phone,hdr.EXECUTIVE_NAME,hdr.Executive_Title);   
		string temp_employees            := if(trim(hdr.total_employees) = '' OR trim(hdr.total_employees) = '0', trim(hdr.employee_range), trim(hdr.total_employees));
		string temp_sales                := map(trim(hdr.total_sales) = '' OR trim(hdr.total_sales) = '0' => trim(hdr.sales_range)
                                          , trim(hdr.sales_range) != '' and (unsigned)trim(hdr.total_sales) < 700000000 => trim(hdr.total_sales)  //total sales needs a range too.  the ones without a range are bad.  either too large(trillions) or negative numbers
                                          ,                                                              ''
                                        );
    self.employee_count_local_raw    := if(temp_employees != '0', 
		                                    temp_employees, '');
		self.revenue_local_raw           := if(temp_sales != '0', 
		                                    temp_sales, '');
		self := [];
	END;

	 link := NORMALIZE(asBusinessLinkingBase, 4, xBiz(Left, counter));
	
		link_dist 		  := distribute(link(trim(company_name) <> ''),(integer)vl_id);
		link_sort    	:= sort(link_dist ,vl_id,company_name,-company_address.zip,-company_address.prim_name,-company_address.prim_range,-company_address.v_city_name,-company_address.st
		                                ,contact_name.fname,contact_name.mname,contact_name.lname,contact_job_title_raw,-company_phone,dt_vendor_first_reported,local);
		
	  business_header.layout_business_linking.linking_interface  x4(business_header.layout_business_linking.linking_interface  l, business_header.layout_business_linking.linking_interface  r) := transform
     	self.dt_first_seen		        := min(l.dt_first_seen,	r.dt_first_seen);
			self.dt_last_seen 		        := max(l.dt_last_seen,	r.dt_last_seen);
			self.dt_vendor_last_reported  := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
			self.dt_vendor_first_reported := min(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
			self.source_record_id					:= if(l.dt_vendor_first_reported < r.dt_vendor_first_reported, l.source_record_id, r.source_record_id);
			self                          := l;
	  end;
		
		link_rollup    := rollup(link_sort,
																							    left.vl_id 							  				= right.vl_id
																			and         left.company_name	  						  = right.company_name
																			and(  (     left.company_address.zip			    =	right.company_address.zip 
																							and left.company_address.prim_name    =	right.company_address.prim_name 
																							and left.company_address.prim_range   = right.company_address.prim_range
																							and left.company_address.v_city_name  = right.company_address.v_city_name
																							and left.company_address.st           = right.company_address.st
																							and left.company_phone                = right.company_phone
																						 )      		OR 
																						 (     right.company_address.zip				='' 
																						   and right.company_address.prim_name  ='' 
																							 and right.company_address.prim_range	='' 
																							 and right.company_address.v_city_name='' 
																							 and right.company_address.st					=''
																							 and right.company_phone    					=''
																						  )
											                    )
																	 	   and(        left.contact_name.fname					= right.contact_name.fname
																					     and left.contact_name.mname    			= right.contact_name.mname
																					     and left.contact_name.lname   				= right.contact_name.lname
																					     and left.contact_job_title_raw 			= right.contact_job_title_raw
														              ),x4(left,right),local);

	biz := link_rollup: persist('~thor_data400::persist::Cortera::As_Business_Linking', REFRESH(TRUE), SINGLE);
	
	return biz;


END;