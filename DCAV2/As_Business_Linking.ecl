#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut, address,mdr,_Validate;

export As_Business_Linking(boolean pUseOtherEnviron = _Constants().IsDataland
	,dataset(layouts.Base.contacts)	 pContactBase		= files(,pUseOtherEnviron).base.contacts.qa
	,dataset(layouts.Base.companies) pCompaniesBase	= files(,pUseOtherEnviron).base.companies.qa
	,boolean isPersist = true
			   ):= function			 

	//*************************************************************************
	//* Contacts Mapping
	//*************************************************************************
	Business_Header.Layout_Business_Linking.Contact Translate_dca_to_BCF(dcav2.layouts.Base.contacts l, integer CTR)
	    := transform
	
		self.tmp_join_id_contact  				:= (string)l.rawfields.enterprise_num;
		self.dt_first_seen_contact				:= if(_validate.date.fIsValid((string)l.date_first_seen),(unsigned4)l.date_first_seen,0);
		self.dt_last_seen_contact 				:= if(_validate.date.fIsValid((string)l.date_last_seen),(unsigned4)l.date_last_seen,0);
		self.contact_did          				:= l.did;
		self.contact_name.title						:= l.clean_name.title;
		self.contact_name.fname 					:= l.clean_name.fname;
		self.contact_name.mname						:= l.clean_name.mname;
		self.contact_name.lname						:= l.clean_name.lname;
		self.contact_name.name_suffix			:= l.clean_name.name_suffix;
		self.contact_name.name_score 		  := Business_Header.CleanName(l.clean_name.fname,l.clean_name.mname,l.clean_name.lname, l.clean_name.name_suffix)[142];
		self.contact_job_title_raw			  := stringlib.stringtouppercase(trim(l.rawfields.executive.title)[1..35]); 
		self.contact_ssn               		:= ''; //Not available in Contacts Base file
		self.contact_dob               		:= (integer)l.birth_year;
		self.contact_phone            		:= if(l.rawfields.address1.state <> '' or l.rawfields.address1.country = '', ut.cleanphone(l.clean_phones.Phone), '');	 
		self.contact_email               	:= ''; //Not available in Contacts Base file
		self.contact_email_username      	:= ''; //Not available in Contacts Base file
		self.contact_email_domain        	:= ''; //Not available in Contacts Base file
		self.contact_type_raw             := ''; //Not available in Contacts Base file
		self.contact_status_raw           := ''; //Not available in Contacts Base file
		self.contact_address.prim_range 	:= choose(CTR ,l.physical_address.prim_range	,l.mailing_address.prim_range	 );
		self.contact_address.predir 			:= choose(CTR ,l.physical_address.predir			,l.mailing_address.predir			 );
		self.contact_address.prim_name 		:= choose(CTR ,l.physical_address.prim_name		,l.mailing_address.prim_name	 );
		self.contact_address.addr_suffix 	:= choose(CTR ,l.physical_address.addr_suffix	,l.mailing_address.addr_suffix );
		self.contact_address.postdir 			:= choose(CTR ,l.physical_address.postdir			,l.mailing_address.postdir		 );
		self.contact_address.unit_desig 	:= choose(CTR ,l.physical_address.unit_desig	,l.mailing_address.unit_desig	 );
		self.contact_address.sec_range 		:= choose(CTR ,l.physical_address.sec_range		,l.mailing_address.sec_range	 );
		self.contact_address.v_city_name	:= choose(CTR ,l.physical_address.v_city_name	,l.mailing_address.v_city_name );
		self.contact_address.p_city_name	:= choose(CTR ,l.physical_address.p_city_name	,l.mailing_address.p_city_name );
		self.contact_address.st		 				:= choose(CTR ,l.physical_address.st					,l.mailing_address.st					 );
		self.contact_address.zip					:= choose(CTR ,l.physical_address.zip					,l.mailing_address.zip				 );
		self.contact_address.zip4 				:= choose(CTR ,l.physical_address.zip4				,l.mailing_address.zip4				 );
		self.contact_address.fips_county	:= choose(CTR ,l.physical_address.fips_county ,l.mailing_address.fips_county );
		self.contact_address.fips_state 	:= choose(CTR ,l.physical_address.fips_state  ,l.mailing_address.fips_state  );		
		self.contact_address.msa 					:= choose(CTR ,l.physical_address.msa					,l.mailing_address.msa				 );
		self.contact_address.geo_lat 			:= choose(CTR ,l.physical_address.geo_lat			,l.mailing_address.geo_lat		 );
		self.contact_address.geo_long 		:= choose(CTR ,l.physical_address.geo_long		,l.mailing_address.geo_long		 );
		self.contact_address.cart			 		:= choose(CTR ,l.physical_address.cart				,l.mailing_address.cart				 );
		self.contact_address.cr_sort_sz		:= choose(CTR ,l.physical_address.cr_sort_sz	,l.mailing_address.cr_sort_sz	 );
		self.contact_address.lot			 		:= choose(CTR ,l.physical_address.lot					,l.mailing_address.lot				 );
		self.contact_address.lot_order		:= choose(CTR ,l.physical_address.lot_order		,l.mailing_address.lot_order	 );
		self.contact_address.dbpc			 		:= choose(CTR ,l.physical_address.dbpc				,l.mailing_address.dbpc				 );
		self.contact_address.chk_digit		:= choose(CTR ,l.physical_address.chk_digit		,l.mailing_address.chk_digit	 );
		self.contact_address.rec_type	 		:= choose(CTR ,l.physical_address.rec_type		,l.mailing_address.rec_type		 );
		self.contact_address.geo_blk	 		:= choose(CTR ,l.physical_address.geo_blk			,l.mailing_address.geo_blk		 );
		self.contact_address.geo_match 		:= choose(CTR ,l.physical_address.geo_match		,l.mailing_address.geo_match	 );
		self.contact_address.err_stat	 		:= choose(CTR ,l.physical_address.err_stat		,l.mailing_address.err_stat		 );
		self.contact_rawaid								:= choose(CTR ,if (l.physical_RawAID!=0 and l.physical_address.prim_name !='',
																			  								 l.physical_RawAID,0)									,
																										 if (l.mailing_RawAID!=0 and l.mailing_address.prim_name != '',
																												 l.mailing_RawAID,0));
		self.contact_aceaid								:= choose(CTR ,if (l.physical_aceAID!=0 and l.physical_address.prim_name !='',
																												 l.physical_aceAID,0)									,
																										 if (l.mailing_aceAID!=0 and l.mailing_address.prim_name != '',
																												 l.mailing_aceAID,0));																																
		self.contact_address_type         := choose(CTR ,if (l.physical_aceAID!=0 and l.physical_address.prim_name !='','CP',''),
																		  							 if (l.mailing_aceAID!=0 and l.mailing_address.prim_name != '','CM',''));
		self.is_contact                   := false; //Will be set during linking
		self.cid												  := 0;  //Not available	
		self.contact_score							  := 0;  //Not available
		self.from_hdr										  := 'N';		
		self.company_department					  :='';  //Not available		
		self 															:= l;
		self															:= [];
	end;
	

	//--------------------------------------------
	// Normalize addresses
	//--------------------------------------------
	cont_dca_norm := normalize(distribute(pContactBase,hash(trim(rawfields.enterprise_num))), if (left.physical_RawAID != left.mailing_RawAID and left.mailing_address.prim_range != '',2,1), Translate_dca_To_BCF(left, counter),local);

	// Removed extra contacts with blank addresses
	cont_dca_dist := distribute(cont_dca_norm, hash(trim(tmp_join_id_contact), trim(contact_name.fname),trim(contact_name.lname),contact_name.mname));

	cont_dca_sort := sort(cont_dca_dist, tmp_join_id_contact, contact_name.fname, contact_name.mname, contact_name.lname, contact_name.name_suffix,
												contact_job_title_raw, contact_phone, if(contact_address.zip <> '', 0, 1), contact_address.zip, contact_address.prim_name, 
												contact_address.prim_range, local);
												
	cont_dca_dedup := dedup(cont_dca_sort,
													left.tmp_join_id_contact = right.tmp_join_id_contact and
												  left.contact_name.fname= right.contact_name.fname and
												  left.contact_name.mname = right.contact_name.mname and
												  left.contact_name.lname = right.contact_name.lname and
												  left.contact_name.name_suffix = right.contact_name.name_suffix and
												  left.contact_job_title_raw = right.contact_job_title_raw and
												  ((left.contact_address.zip = right.contact_address.zip and
												  left.contact_address.prim_name = right.contact_address.prim_name and
												  left.contact_address.prim_range = right.contact_address.prim_range) or
												  (left.contact_address.zip <> '' and right.contact_address.zip = '')),
												  local);


	cont_dedup_filt := cont_dca_dedup((integer)contact_name.name_score < 3, Business_Header.CheckPersonName(contact_name.fname, contact_name.mname, contact_name.lname, contact_name.name_suffix));

	
	//*************************************************************************
	// Companies Mapping
	//*************************************************************************
	Layouts_UniqueId :=record
		unsigned6 unique_id;
		DCAv2.layouts.Base.companies;
	end;

	//Add unique id
	Layouts_UniqueId tAddUniqueId(DCAv2.layouts.Base.companies l, unsigned6 cnt) :=transform
		self.unique_id	:= cnt	;
		self						:= l	;
	end;   
		
	dAddUniqueId := distribute(project(pCompaniesBase, tAddUniqueId(left,counter)),hash(unique_id));
	
	Business_Header.Layout_Business_Linking.Company_ Normalize_DCA_Addr(Layouts_UniqueId l, integer ctr) := transform
		self.tmp_join_id_company        			:= l.rawfields.enterprise_num;
		self.vl_id     												:= l.rawfields.enterprise_num;
	  self.source 													:= MDR.sourceTools.src_DCA;
		self.source_record_id									:= l.src_rid;
		self.company_bdid											:= l.bdid;
		// DCA has international companies so blank phone number if non-US
	  self.company_phone 										:= if(l.rawfields.address1.state <> '' or l.rawfields.address1.country = '', l.clean_phones.Phone, '');
	  self.phone_score 											:= IF((UNSIGNED8)self.company_phone = 0, 0, 1);
		self.phone_type												:= if(self.company_phone !='','T','');
	  self.company_name 										:= Stringlib.StringToUpperCase(l.rawfields.Name);
	  self.company_fein 										:= '';
		self.best_fein_Indicator              := ''; //Only for FEIN. 
		self.company_url											:= trim(l.rawfields.URL);
		self.company_naics_code1							:= trim(l.rawfields.Naics1);
		self.company_naics_code2							:= trim(l.rawfields.Naics2);
		self.company_naics_code3							:= trim(l.rawfields.Naics3);
		self.company_naics_code4							:= trim(l.rawfields.Naics4);
		self.company_naics_code5							:= trim(l.rawfields.Naics5);
		self.company_sic_code1								:= trim(l.rawfields.sic1);
		self.company_sic_code2								:= trim(l.rawfields.sic2);
		self.company_sic_code3								:= trim(l.rawfields.sic3);
		self.company_sic_code4								:= trim(l.rawfields.sic4);
		self.company_sic_code5								:= trim(l.rawfields.sic5);
	  self.company_address_type_raw  				:= choose(ctr, if(l.physical_address.prim_name!='','PHYSICAL',''),if(l.mailing_address.prim_name!='','MAILING',''));
	  self.company_address.prim_range 			:= choose(ctr, l.physical_address.prim_range			,l.mailing_address.prim_range				);
	  self.company_address.predir 					:= choose(ctr, l.physical_address.predir					,l.mailing_address.predir						);
	  self.company_address.prim_name 				:= choose(ctr, l.physical_address.prim_name				,l.mailing_address.prim_name				);
	  self.company_address.addr_suffix 			:= choose(ctr, l.physical_address.addr_suffix			,l.mailing_address.addr_suffix			);
	  self.company_address.postdir 					:= choose(ctr, l.physical_address.postdir					,l.mailing_address.postdir					);
	  self.company_address.unit_desig 			:= choose(ctr, l.physical_address.unit_desig			,l.mailing_address.unit_desig				);
	  self.company_address.sec_range 				:= choose(ctr, l.physical_address.sec_range				,l.mailing_address.sec_range				);
	  self.company_address.v_city_name			:= choose(ctr, l.physical_address.v_city_name			,l.mailing_address.v_city_name			);
	  self.company_address.p_city_name			:= choose(ctr, l.physical_address.p_city_name			,l.mailing_address.p_city_name			);
	  self.company_address.st 							:= choose(ctr, l.physical_address.st							,l.mailing_address.st								);
	  self.company_address.zip 						  := choose(ctr, l.physical_address.zip							,l.mailing_address.zip							);
	  self.company_address.zip4 						:= choose(ctr, l.physical_address.zip4						,l.mailing_address.zip4							);
	  self.company_address.fips_county 			:= choose(ctr, l.physical_address.fips_county			,l.mailing_address.fips_county			);
		self.company_address.fips_state 			:= choose(ctr, l.physical_address.fips_state			,l.mailing_address.fips_state 			);
	  self.company_address.msa 							:= choose(ctr, l.physical_address.msa							,l.mailing_address.msa							);
	  self.company_address.geo_lat 					:= choose(ctr, l.physical_address.geo_lat					,l.mailing_address.geo_lat					);
	  self.company_address.geo_long 				:= choose(ctr, l.physical_address.geo_long				,l.mailing_address.geo_long					);
    self.company_address.cart			 		    := choose(ctr ,l.physical_address.cart						,l.mailing_address.cart				 			);
		self.company_address.cr_sort_sz		    := choose(ctr ,l.physical_address.cr_sort_sz			,l.mailing_address.cr_sort_sz	 			);
		self.company_address.lot			 			  := choose(ctr ,l.physical_address.lot							,l.mailing_address.lot				 			);
		self.company_address.lot_order				:= choose(ctr ,l.physical_address.lot_order				,l.mailing_address.lot_order	 			);
		self.company_address.dbpc			 				:= choose(ctr ,l.physical_address.dbpc						,l.mailing_address.dbpc				 			);
		self.company_address.chk_digit				:= choose(ctr ,l.physical_address.chk_digit				,l.mailing_address.chk_digit	 			);
		self.company_address.rec_type	 				:= choose(ctr ,l.physical_address.rec_type				,l.mailing_address.rec_type		 			);
		self.company_address.geo_blk	 				:= choose(ctr ,l.physical_address.geo_blk					,l.mailing_address.geo_blk					);
		self.company_address.geo_match 				:= choose(ctr ,l.physical_address.geo_match				,l.mailing_address.geo_match				);
		self.company_address.err_stat	 				:= choose(ctr ,l.physical_address.err_stat				,l.mailing_address.err_stat		 			);		
		self.company_rawaid										:= choose(ctr, l.physical_rawAID									,l.mailing_rawAID										);
		self.company_aceaid										:= choose(ctr, l.physical_aceAID									,l.mailing_aceAID										);
		self.dt_first_seen 										:= if(_validate.date.fIsValid((string)l.date_first_seen),(unsigned4)l.date_first_seen,0);
	  self.dt_last_seen 										:= if(_validate.date.fIsValid((string)l.date_last_seen),(unsigned4)l.date_last_seen,0);
	  self.dt_vendor_first_reported 				:= if(_validate.date.fIsValid((string)l.date_vendor_first_reported),(unsigned4)l.date_vendor_first_reported,0);
	  self.dt_vendor_last_reported 					:= if(_validate.date.fIsValid((string)l.date_vendor_last_reported),(unsigned4)l.date_vendor_last_reported,0);
		self.company_name_type_raw            := ''; //Not available
		self.company_address_category         := ''; //Not available
		self.dt_first_seen_company_name  			:= 0;  //Not available
		self.dt_last_seen_company_name   			:= 0;  //Not available
		self.dt_first_seen_company_address		:= 0;  //Not available
		self.dt_last_seen_company_address			:= 0;  //Not available
		self.company_org_structure_raw        := ''; //Not available
		self.company_incorporation_date	      := 0;  //Not available
		self.company_ticker                   := trim(l.rawfields.ticker_symbol); 
    self.company_ticker_exchange          := trim(l.rawfields.exchange1); 
		self.company_inc_state			          := trim(l.rawfields.incorp);
		self.company_foreign_domestic         := ''; //Not available	
		self.company_charter_number           := ''; //Not available
		self.company_filing_date              := 0;  //Not available
		self.company_status_date              := 0;  //Not available
		self.company_foreign_date             := 0;  //Not available
		self.event_filing_date                := 0;  //Not available
		self.company_name_status_raw          := ''; //Not available
		self.company_status_raw               := if(l.killreport.comp_type in [/*'N',*/'P','PX','S'],
																							  'INACTIVE','');
		self.current 													:= true;
		self.glb												 			:= false;
		self.dppa										     			:= false;
		self.match_company_name								:= ''; //Not available
		self.match_branch_city 					 			:= ''; //Not available
		self.match_geo_city							 			:= ''; //Not available	
		self.rcid 											      := 0;	 //Not available	
		string temp_emp_count                 := if(trim(l.rawfields.emp_num) = '0','',trim(l.rawfields.emp_num));
		string temp_revenue                   := if(trim(l.rawfields.sales) = '0','',trim(l.rawfields.sales));
    self.employee_count_local_raw         := temp_emp_count;
		self.revenue_local_raw                := temp_revenue;
		self																	:= l;
		self																	:= [];
	END;

	comp_dca_norm := normalize(dAddUniqueId, if(left.mailing_rawaid<>0 and left.mailing_rawaid!= left.physical_rawAID ,2,1), Normalize_DCA_Addr(LEFT, COUNTER),local);
	
	//--------------------------------------------
	// Rollup on name and address
	//--------------------------------------------
	comp_dca_norm_dist := distribute(comp_dca_norm, hash(source_record_id, ut.CleanCompany(company_name)));
	comp_dca_norm_sort := sort(comp_dca_norm_dist, source_record_id, ut.CleanCompany(company_name),  -company_address.zip, company_address.prim_name, company_address.prim_range, -company_address.v_city_name, -company_address.st, local);

	Business_Header.Layout_Business_Linking.Company_ RollupdcaNorm(Business_Header.Layout_Business_Linking.Company_ l, Business_Header.Layout_Business_Linking.Company_ r) := transform
		self := l;
	end;

	comp_dca_norm_rollup := rollup(comp_dca_norm_sort,
																	left.source_record_id = right.source_record_id and
																	ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name) and
																	((left.company_address.zip = right.company_address.zip and
																	 left.company_address.prim_name = right.company_address.prim_name and
																	 left.company_address.prim_range = right.company_address.prim_range and
																	 left.company_address.v_city_name = right.company_address.v_city_name and
																	 left.company_address.st = right.company_address.st)
																	OR
																	 (right.company_address.zip = '' and
																		right.company_address.prim_name = '' and
																		right.company_address.prim_range = '' and
																		right.company_address.v_city_name = '' and
																		right.company_address.st = '')
																	 ),
																	RollupdcaNorm(LEFT, RIGHT),
																	LOCAL);


	// Final Rollup
	Business_Header.Layout_Business_Linking.Company_ Rollupdca(Business_Header.Layout_Business_Linking.Company_ l, Business_Header.Layout_Business_Linking.Company_ r) := 
	transform
		self.dt_first_seen 									:= ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen)
																													,ut.EarliestDate(l.dt_last_seen	,r.dt_last_seen	) 			);
		self.dt_last_seen 									:= max	(l.dt_last_seen							,r.dt_last_seen							);
		self.dt_vendor_last_reported 				:= max	(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
		self.dt_vendor_first_reported				:= ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);
		self.vl_id 													:= if(l.vl_id = '', r.vl_id, l.vl_id);
		self.company_name 									:= if(l.company_name = '', r.company_name, l.company_name);
		self.company_phone 									:= if(l.company_phone = '', r.company_phone, l.company_phone);
		self.phone_score 										:= if(l.company_phone = '', r.phone_score, l.phone_score);
		self.phone_type 										:= if(l.phone_type = '', r.phone_type, l.phone_type);		
		self.company_address.prim_range 		:= if(l.company_address.prim_range = '' and l.company_address.zip4 = '', r.company_address.prim_range, l.company_address.prim_range);
		self.company_address.predir 				:= if(l.company_address.predir = '' and l.company_address.zip4 = '', r.company_address.predir, l.company_address.predir);
		self.company_address.prim_name 			:= if(l.company_address.prim_name = '' and l.company_address.zip4 = '', r.company_address.prim_name, l.company_address.prim_name);
		self.company_address.addr_suffix 		:= if(l.company_address.addr_suffix = '' and l.company_address.zip4 = '', r.company_address.addr_suffix, l.company_address.addr_suffix);
		self.company_address.postdir 				:= if(l.company_address.postdir = '' and l.company_address.zip4 = '', r.company_address.postdir, l.company_address.postdir);
		self.company_address.unit_desig 		:= if(l.company_address.unit_desig = ''and l.company_address.zip4 = '', r.company_address.unit_desig, l.company_address.unit_desig);
		self.company_address.sec_range 			:= if(l.company_address.sec_range = '' and l.company_address.zip4 = '', r.company_address.sec_range, l.company_address.sec_range);
		self.company_address.v_city_name 		:= if(l.company_address.v_city_name = '' and l.company_address.zip4 = '', r.company_address.v_city_name, l.company_address.v_city_name);
		self.company_address.p_city_name 		:= if(l.company_address.p_city_name = '' and l.company_address.zip4 = '', r.company_address.p_city_name, l.company_address.p_city_name);		
		self.company_address.st		 					:= if(l.company_address.st = '' and l.company_address.zip4 = '', r.company_address.st, l.company_address.st);
		self.company_address.zip 		  			:= if(l.company_address.zip = '' and l.company_address.zip4 = '', r.company_address.zip, l.company_address.zip);
		self.company_address.zip4 					:= if(l.company_address.zip4 = '', r.company_address.zip4, l.company_address.zip4);
		self.company_address.fips_county		:= if(l.company_address.fips_county = '' and l.company_address.zip4 = '', r.company_address.fips_county, l.company_address.fips_county);
		self.company_address.fips_state 		:= if(l.company_address.fips_state = '' and l.company_address.zip4 = '', r.company_address.fips_state, l.company_address.fips_state);		
		self.company_address.msa 						:= if(l.company_address.msa = '' and l.company_address.zip4 = '', r.company_address.msa, l.company_address.msa);
		self.company_address.geo_lat 				:= if(l.company_address.geo_lat = '' and l.company_address.zip4 = '', r.company_address.geo_lat, l.company_address.geo_lat);
		self.company_address.geo_long 			:= if(l.company_address.geo_long = '' and l.company_address.zip4 = '', r.company_address.geo_long, l.company_address.geo_long);
		self.company_rawaid									:= if(l.company_rawaid = 0 and l.company_address.zip4 = '', r.company_rawaid, l.company_rawaid);
		self 																:= l;
	end;

	dca_comp_clean_dist := distribute(comp_dca_norm_rollup,
																		hash(company_address.zip, trim(company_address.prim_name), trim(company_address.prim_range), trim(vl_id), trim(company_name)));
	dca_comp_clean_sort := sort(dca_comp_clean_dist, company_address.zip, company_address.prim_range, company_address.prim_name, company_name, vl_id, 
															if(company_address.sec_range <> '', 0, 1), company_address.sec_range,
															if(company_phone <> '', 0, 1), company_phone,
															dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
	dca_comp_clean_rollup := rollup(dca_comp_clean_sort,
																	left.company_address.zip = right.company_address.zip and
																	left.company_address.prim_name = right.company_address.prim_name and
																	left.company_address.prim_range = right.company_address.prim_range and
																	left.company_name = right.company_name and
																	left.vl_id = right.vl_id and
																	(right.company_address.sec_range = '' or left.company_address.sec_range = right.company_address.sec_range) and
																	(right.company_phone = '' or left.company_phone = right.company_phone),
																	Rollupdca(left, right), local);

	 ds_contact := distribute(cont_dedup_filt,hash(tmp_join_id_contact));
	 ds_company := distribute(dca_comp_clean_rollup,hash(tmp_join_id_company));

	 Business_Header.Layout_Business_Linking.Combined x8(Business_Header.Layout_Business_Linking.Company_ L, Business_Header.Layout_Business_Linking.Contact R) := transform
	 	self.contact_address_type			:= 	if(l.company_aceaid=r.contact_aceaid and l.company_aceaid!=0, 'CC', r.contact_address_type);
		self.company_address_type_raw := 	if(l.company_aceaid=r.contact_aceaid and l.company_aceaid!=0, 'CC', l.company_address_type_raw);
		self := l;
		self := r;
	 end;

	 j1 := join(ds_company,ds_contact,left.tmp_join_id_company=right.tmp_join_id_contact,x8(left,right),left outer,local);
	 
	 Business_Header.Layout_Business_Linking.Combined x9(Business_Header.Layout_Business_Linking.Combined l, Business_Header.Layout_Business_Linking.Contact r) := transform
		self.company_rawaid              := r.contact_rawaid;  
		self.company_aceaid  			 			 := r.contact_aceaid;			
		self.company_address.prim_range  := r.contact_address.prim_range;
		self.company_address.predir      := r.contact_address.predir;
		self.company_address.prim_name   := r.contact_address.prim_name;
		self.company_address.addr_suffix := r.contact_address.addr_suffix;
		self.company_address.postdir     := r.contact_address.postdir;
		self.company_address.unit_desig  := r.contact_address.unit_desig;
		self.company_address.sec_range   := r.contact_address.sec_range;	
		self.company_address.p_city_name := r.contact_address.p_city_name;
		self.company_address.v_city_name := r.contact_address.v_city_name;
		self.company_address.st          := r.contact_address.st;
		self.company_address.zip         := r.contact_address.zip;
		self.company_address.zip4        := r.contact_address.zip4;
		self.company_address.cart				 := r.contact_address.cart;
		self.company_address.cr_sort_sz  := r.contact_address.cr_sort_sz;
		self.company_address.lot         := r.contact_address.lot;
		self.company_address.lot_order   := r.contact_address.lot_order;
		self.company_address.dbpc        := r.contact_address.dbpc;
		self.company_address.chk_digit   := r.contact_address.chk_digit;
		self.company_address.rec_type    := r.contact_address.rec_type;
		self.company_address.fips_county := r.contact_address.fips_county;
		self.company_address.fips_state  := r.contact_address.fips_state;
		self.company_address.msa         := r.contact_address.msa;
		self.company_address.geo_lat     := r.contact_address.geo_lat;
		self.company_address.geo_long    := r.contact_address.geo_long;
		self.company_address.geo_blk     := r.contact_address.geo_blk;
		self.company_address.geo_match   := r.contact_address.geo_match;
		self.company_address.err_stat    := r.contact_address.err_stat;
		self.company_address_type_raw    := if(l.company_aceaid=r.contact_aceaid and l.company_aceaid!=0, 'CC', r.contact_address_type);
		self := l;
	 end;

	 //add contact name to the join to avoid mingling every contact with every other contact's address	
	 j2 := join(j1,ds_contact(contact_address.prim_range<>'' or contact_address.prim_name<>'' or contact_address.zip<>''),
						left.tmp_join_id_company=right.tmp_join_id_contact and 
						left.contact_name.fname=right.contact_name.fname and 
						left.contact_name.lname=right.contact_name.lname,x9(left,right),local);
	 
	 concat      := j1+j2;
	 // concat_dupd := dedup(project(concat(company_name<>''),Business_Header.Layout_Business_Linking.Linking_Interface),
											// except contact_name.name_score,company_rawaid,all)
										 // : persist(dcav2.persistnames().root + 'As_Business_Linking');
										 
	 concat_persist := dedup(project(concat(company_name<>''),Business_Header.Layout_Business_Linking.Linking_Interface),
											except contact_name.name_score,company_rawaid,all)
										 : persist(dcav2.persistnames().root + 'As_Business_Linking');
										 
	 concat_nopersist := dedup(project(concat(company_name<>''),Business_Header.Layout_Business_Linking.Linking_Interface),
											except contact_name.name_score,company_rawaid,all);								 
								
   concat_dupd := if(isPersist, concat_persist, concat_nopersist);								
								
	return concat_dupd;
	
end;