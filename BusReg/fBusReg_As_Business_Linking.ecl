import mdr,business_header,ut;

//NOTE:  
//No data exists in the fax number field and therefore it is not being mapped here.
//

export fBusReg_As_Business_Linking(dataset(BusReg.Layout_BusReg_Company) pCompany_Base, dataset(BusReg.Layout_BusReg_Contact) pContact_Base) := function

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to BH-Contact format
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout_contact := business_header.Layout_Business_Linking.Contact;

		//CONTACTS MAPPING
		bh_layout_contact x1(pContact_Base l) := transform
				self.tmp_join_id_contact         := (string)l.br_id;
				self.contact_rawaid              := l.append_rawaid;	
				self.contact_aceaid              := l.append_aceaid;		
				self.contact_address.prim_range  := l.prim_range;
				self.contact_address.predir      := l.predir;
				self.contact_address.prim_name   := l.prim_name;
				self.contact_address.addr_suffix := l.addr_suffix;
				self.contact_address.postdir     := l.postdir;
				self.contact_address.unit_desig  := l.unit_desig;
				self.contact_address.sec_range   := l.sec_range;
				self.contact_address.p_city_name := l.p_city_name;	
				self.contact_address.v_city_name := l.v_city_name;
				self.contact_address.st          := l.st;
				self.contact_address.zip         := l.zip;
				self.contact_address.zip4        := l.zip4;
				self.contact_address.cart        := l.cart;
				self.contact_address.cr_sort_sz  := l.cr_sort_sz;
				self.contact_address.lot         := l.lot;
				self.contact_address.lot_order   := l.lot_order;
				self.contact_address.dbpc        := l.dpbc;
				self.contact_address.chk_digit   := l.chk_digit;
				self.contact_address.rec_type    := l.rec_type;
				self.contact_address.fips_state  := if(regexfind('[0-9]+',l.ace_fips_st),'',l.ace_fips_st);				
				self.contact_address.fips_county := if(regexfind('[a-z]+',l.fipscounty,NOCASE),'',l.fipscounty);
				self.contact_address.geo_lat     := l.geo_lat;
				self.contact_address.geo_long    := l.geo_long;
				self.contact_address.msa         := l.msa;
				self.contact_address.geo_blk 		 := l.geo_blk;
				self.contact_address.geo_match 	 := l.geo_match;
				self.contact_address.err_stat 	 := l.err_stat;
				self.contact_address_type        := 'C'; //Contact
				self.is_contact									 := false;
				self.dt_first_seen_contact       := (unsigned4)l.dt_first_seen;
				self.dt_last_seen_contact        := (unsigned4)l.dt_last_seen;
				self.contact_did                 := l.did;
				self.contact_name.title          := l.name_prefix;
				self.contact_name.fname          := l.name_first;
				self.contact_name.mname          := l.name_middle;
				self.contact_name.lname          := l.name_last;
				self.contact_name.name_suffix		 := l.name_suffix;
				self.contact_name.name_score     := l.name_score;
				self.contact_type_raw						 := '';
				self.contact_job_title_raw       := busreg.MapTitleCode(l.title);	
				self.contact_ssn                 := l.ssn;
				self.contact_dob								 := 0;
				self.contact_status_raw					 := '';
				self.contact_email							 := '';
				self.contact_email_username			 := '';
				self.contact_email_domain				 := '';
				self.contact_phone               := ut.CleanPhone(l.phone);
				self.cid												 := 0;
				self.contact_score							 := 0;
				self.from_hdr										 := 'N';
				self.company_department					 := '';
				self := l;
				self := [];
		 end;

		 mapping_contacts := project(pContact_Base,x1(left));

		 ds_contact_dist 	:= sort(distribute(mapping_contacts,hash(tmp_join_id_contact)),record, EXCEPT dt_first_seen_contact, dt_last_seen_contact, contact_rawaid, local);

		 //This rollup ensures unique contacts exist and the earliest record first seen date and latest last seen date are kept.		
		 bh_layout_contact RollupUpdate(bh_layout_contact l, bh_layout_contact r) := transform
				self.dt_first_seen_contact	:=	ut.EarliestDate(
																							ut.EarliestDate(l.dt_first_seen_contact, r.dt_first_seen_contact),
																							ut.EarliestDate(l.dt_last_seen_contact, r.dt_last_seen_contact)
																							);
				self.dt_last_seen_contact		:=	MAX(l.dt_last_seen_contact,r.dt_last_seen_contact);
				self                				:=  l;
		 end;		
				
		//This rollup ensures unique contacts exist.				
		ds_contact_rollup := rollup(ds_contact_dist,
																RollupUpdate(left, right),
																record,
																except 					
																	dt_first_seen_contact
																 ,dt_last_seen_contact
																 ,contact_rawaid
																 ,LOCAL
																);

		//COMPANY MAPPING
		 layout_bhf_local := record
				Business_Header.Layout_Business_Linking.Company_;
				unsigned6 group1_id;				
				unsigned6 orig_id;
				unsigned6 split_id:=0;
		 end;

		 br_init := project(pcompany_base,transform({busreg.layout_busreg_company_rid},self:=left,self:=[]));

		 ut.MAC_Sequence_Records(br_init,record_id,br_seq)

		 layout_bhf_local x2(busreg.layout_busreg_company_rid L, integer ctr) := transform
				self.tmp_join_id_company         		:= ut.CleanSpacesAndUpper((string)l.br_id);
				self.source                      		:= mdr.sourceTools.src_Business_Registration;
				self.dt_first_seen               		:= (unsigned4)l.dt_first_seen;
				self.dt_last_seen                		:= (unsigned4)l.dt_last_seen;
				self.dt_vendor_last_reported     		:= (unsigned4)l.record_date;
				self.dt_vendor_first_reported    		:= (unsigned4)l.record_date;		
				self.rcid												 		:= 0;
				self.company_bdid								 		:= l.bdid;
				self.company_name								 		:= ut.CleanSpacesAndUpper(l.company_name);
				company_name_type										:= ut.CleanSpacesAndUpper(busreg.functions.fTranslate_CorpCode(l.corpcode));
				self.company_name_type_raw       		:= if (company_name_type <> 'UNKNOWN',company_name_type,'');
				self.company_rawaid              		:= choose(ctr, l.append_mailrawaid,l.append_locrawaid);
				self.company_aceaid              		:= choose(ctr, l.append_mailaceaid,l.append_locaceaid);		
				self.company_address.prim_range  		:= choose(ctr, l.mail_prim_range, l.loc_prim_range);
				self.company_address.predir      		:= choose(ctr, l.mail_predir,     l.loc_predir);
				self.company_address.prim_name   		:= choose(ctr, l.mail_prim_name,  l.loc_prim_name);
				self.company_address.addr_suffix 		:= choose(ctr, l.mail_addr_suffix,l.loc_addr_suffix);
				self.company_address.postdir     		:= choose(ctr, l.mail_postdir,    l.loc_postdir);
				self.company_address.unit_desig  		:= choose(ctr, l.mail_unit_desig, l.loc_unit_desig);
				self.company_address.sec_range   		:= choose(ctr, l.mail_sec_range,  l.loc_sec_range);
				self.company_address.p_city_name 		:= choose(ctr, l.mail_p_city_name,l.loc_p_city_name);		
				self.company_address.v_city_name 		:= choose(ctr, l.mail_v_city_name,l.loc_v_city_name);
				self.company_address.st         		:= choose(ctr, l.mail_st,         l.loc_st);
				self.company_address.zip       	 		:= choose(ctr, l.mail_zip,        l.loc_zip);
				self.company_address.zip4        		:= choose(ctr, l.mail_zip4,       l.loc_zip4);
				self.company_address.cart        		:= choose(ctr, l.mail_cart,       l.loc_cart);
				self.company_address.cr_sort_sz  		:= choose(ctr, l.mail_cr_sort_sz, l.loc_cr_sort_sz);
				self.company_address.lot         		:= choose(ctr, l.mail_lot,       	l.loc_lot);
				self.company_address.lot_order   		:= choose(ctr, l.mail_lot_order,  l.loc_lot_order);
				self.company_address.dbpc        		:= choose(ctr, l.mail_dpbc,       l.loc_dpbc);
				self.company_address.chk_digit  		:= choose(ctr, l.mail_chk_digit,  l.loc_chk_digit);
				self.company_address.rec_type   		:= choose(ctr, l.mail_record_type,l.loc_record_type);
				lfips_st 														:= choose(ctr, l.mail_ace_fips_st,l.loc_ace_fips_st);
				self.company_address.fips_state    	:= if(regexfind('[0-9]+',lfips_st),'',lfips_st);				
				lfips_county												:= choose(ctr, l.mail_fipscounty, l.loc_fipscounty);		
				self.company_address.fips_county    := if(regexfind('[a-z]+',lfips_county,nocase),'',lfips_county);
				self.company_address.geo_lat     		:= choose(ctr, l.mail_geo_lat,    l.loc_geo_lat);
				self.company_address.geo_long    		:= choose(ctr, l.mail_geo_long,   l.loc_geo_long);
				self.company_address.msa         		:= choose(ctr, l.mail_msa,        l.loc_msa);
				self.company_address.geo_blk 		 		:= choose(ctr, l.mail_geo_blk,    l.loc_geo_blk);
				self.company_address.geo_match 	 		:= choose(ctr, l.mail_geo_match,  l.loc_geo_match);
				self.company_address.err_stat 	 		:= choose(ctr, l.mail_err_stat,   l.loc_err_stat);
			  address_type_mailing								:= if (l.mail_p_city_name = '' AND l.mail_st='' AND l.mail_zip = '','','MAILING');
				address_type_local									:= if (l.loc_p_city_name  = '' AND l.loc_st ='' AND l.loc_zip  = '','','BUSINESS');
				self.company_address_type_raw    		:= choose(ctr,address_type_mailing,address_type_local);
				self.company_address_category		 		:= '';
				self.company_fein                		:= l.co_fei;
				self.company_phone               		:= ut.CleanPhone(l.company_phone10);
				self.phone_type	  									:= if (self.company_phone<>'','T','');
				company_org_structure								:= ut.CleanSpacesAndUpper(busreg.functions.fTranslate_SOSCode(l.sos_code));
				self.company_org_structure_raw   		:= if (ut.CleanSpacesAndUpper(company_org_structure) <> 'UNKNOWN',company_org_structure,'');
				self.company_incorporation_date			:= 0;
				self.company_sic_code1            	:= ut.CleanSpacesAndUpper(l.sic);
				self.company_sic_code2            	:= '';
				self.company_sic_code3            	:= '';
				self.company_sic_code4            	:= '';
				self.company_sic_code5            	:= '';		
				self.company_naics_code1         		:= ut.CleanSpacesAndUpper(l.naics);
				self.company_naics_code2         		:= '';
				self.company_naics_code3         		:= '';
				self.company_naics_code4         		:= '';
				self.company_naics_code5         		:= '';
				self.company_foreign_domestic		 		:= '';
				self.company_url										:= '';
				self.company_inc_state							:= '';
				self.company_charter_number					:= '';
				self.company_filing_date						:= (unsigned4)l.file_date;
				self.company_status_date						:= 0;	
				self.company_foreign_date						:= 0;	
				self.event_filing_date							:= 0;
				self.company_name_status_raw				:= '';
				company_status											:= ut.CleanSpacesAndUpper(busreg.functions.fTranslate_Status(l.status));
				self.company_status_raw							:= if (company_status <> 'UNKNOWN',company_status,'');
				self.dt_first_seen_company_name			:= 0;
				self.dt_last_seen_company_name			:= 0;
				self.dt_first_seen_company_address	:= 0;
				self.dt_last_seen_company_address		:= 0;
				self.vl_id                       		:= ut.CleanSpacesAndUpper('BRC'+(STRING)l.br_id);
				self.current                     		:= l.record_type='C';
				self.source_record_id						 		:= l.source_rec_id;
				self.glb												 		:= false;
				self.dppa												 		:= false;
				self.group1_id											:= 0;
				self.phone_score                 		:= if((integer)self.company_phone=0,0,1);		
				self.match_company_name					 		:= '';
				self.match_branch_city					 		:= '';
				self.match_geo_city							 		:= '';
				self.orig_id                	      := l.record_id;
        self.employee_count_local_raw       := if(trim(l.emp_size) != '0',trim(l.emp_size),'');
				self 																:= l;
				self 																:= [];
			end;

			from_br_norm      := normalize(br_seq,2,x2(left,counter));
			from_br_norm_dist := distribute(from_br_norm,hash(orig_id,company_name));
			from_br_norm_sort := sort(from_br_norm_dist,orig_id,company_name,-company_address.prim_name,-company_address.prim_range,-company_address.v_city_name,-company_address.st,-company_address.zip,local);

		 layout_bhf_local x3(layout_bhf_local L, layout_bhf_local R) := transform
				self := l;
		 end;
		 
		 from_br_norm_rollup := rollup(from_br_norm_sort,
														 left.orig_id = right.orig_id
												 and left.company_name=right.company_name
												 and ((    left.company_address.zip=right.company_address.zip 
															 and left.company_address.prim_name=right.company_address.prim_name 
															 and left.company_address.prim_range=right.company_address.prim_range
															 and left.company_address.v_city_name=right.company_address.v_city_name
															 and left.company_address.st=right.company_address.st)
												 or (right.company_address.zip='' and right.company_address.prim_name='' and right.company_address.prim_range='' and right.company_address.v_city_name='' and right.company_address.st='')
											),x3(left,right),local);
			
		 ut.MAC_Sequence_Records(from_br_norm_rollup,split_id,from_br_seq)

		 //group by original id
		 from_br_dist      := distribute(from_br_seq,hash(orig_id));
		 from_br_sort      := sort(from_br_dist,orig_id,local);
		 from_br_grpd      := group(from_br_sort,orig_id,local);
		 from_br_grpd_sort := sort(from_br_grpd,split_id);

		 layout_bhf_local x4(layout_bhf_local L, layout_bhf_local R) := transform
				self.group1_id := if(l.group1_id<>0,l.group1_id,r.split_id);
				self           := r;
		 end;

			// Set group id
			from_br_iter := group(iterate(from_br_grpd_sort,x4(LEFT, RIGHT)));

			layout_group_stat := record
				 from_br_iter.group1_id;
				 cnt := count(group);
			end;

			br_group_stat := table(from_br_iter,layout_group_stat,group1_id);

		 //Clean single group ids and format
		 layout_bhf_local x5(layout_bhf_local L, layout_group_stat R) := transform
				self.group1_id := r.group1_id;
				self           := l;
		 end;

		 br_group_cleaned := join(from_br_iter,br_group_stat(cnt>1),left.group1_id=right.group1_id,x5(left,right),left outer,lookup);
		 br_group_clean 	:= project(br_group_cleaned,transform({Business_Header.Layout_Business_Linking.Company_},self:=left,self:=[]));		 
		 
		 Business_Header.Layout_Business_Linking.Company_ x6(busreg.layout_busreg_company_rid L) := transform
				self.tmp_join_id_company         := ut.CleanSpacesAndUpper((string)l.br_id);
				self.source                      := mdr.sourceTools.src_Business_Registration;
				self.dt_first_seen               := (unsigned4)l.dt_first_seen;
				self.dt_last_seen                := (unsigned4)l.dt_last_seen;
				self.dt_vendor_last_reported     := (unsigned4)l.dt_last_seen;
				self.dt_vendor_first_reported    := (unsigned4)l.dt_first_seen;
				self.vl_id                       := ut.CleanSpacesAndUpper('BRO'+(STRING)l.br_id);
				self.company_name                := ut.CleanSpacesAndUpper((l.OFC1_NAME));
				self.company_phone               := ut.CleanPhone(l.ofc1_phone10);
				self.phone_type	  							 := if (self.company_phone<>'','T','');
				self.phone_score                 := if((integer)self.company_phone=0,0,1);		
				self.company_fein                := l.co_fei;
				self.company_address_type_raw    := '';
				self.company_address.prim_range  := l.ofc1_prim_range;
				self.company_address.predir      := l.ofc1_predir;
				self.company_address.prim_name   := l.ofc1_prim_name;
				self.company_address.postdir     := l.ofc1_postdir;
				self.company_address.addr_suffix := l.ofc1_addr_suffix;
				self.company_address.unit_desig  := l.ofc1_unit_desig;
				self.company_address.sec_range   := l.ofc1_sec_range;
				self.company_address.v_city_name := l.ofc1_v_city_name;
				self.company_address.st          := l.ofc1_st;
				self.company_address.zip        := l.ofc1_zip;
				self.company_address.zip4        := l.ofc1_zip4;
				self.company_address.msa         := l.ofc1_msa;
				self.company_address.geo_lat     := l.ofc1_geo_Lat;
				self.company_address.geo_long    := l.ofc1_geo_Long;
				self.current                     := l.record_type='C';
				self.source_record_id						 := l.source_rec_id;
				self := l;
				self := [];
		 end;

		 //Fix for Accutrend Data Problem
		 //Create list of Agent companies to use as filters for owners
		 busreg_owner           := br_seq(OWNR_CODE='C', OFC1_NAME <> '', OFC1_TITLE <> 'AGT', ofc1_prim_name <> '', ofc1_v_city_name <> '');
		 busreg_owner_no_agents := busreg.remove_agents(busreg_owner,1000);

		 //Business Registration Owner Information
		 busreg_owner_filtered := project(busreg_owner_no_agents,x6(left));

		 Business_Header.Layout_Business_Linking.Company_ x7(Business_Header.Layout_Business_Linking.Company_ L, Business_Header.Layout_Business_Linking.Company_ R) := transform
				self.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
				self.dt_last_seen                := MAX(l.dt_last_seen,r.dt_last_seen);
				self.dt_vendor_last_reported     := MAX(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
				self.dt_vendor_first_reported    := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
				self.source_record_id    				 := ut.Min2(l.source_record_id, r.source_record_id);
				self.company_name                := if(l.company_name='', r.company_name, l.company_name);
				self.company_name_type_raw       := if(l.company_name='', r.company_name_type_raw, l.company_name_type_raw);
				self.vl_id                       := if(l.vl_id='', r.vl_id, l.vl_id);
				self.company_phone               := if(l.company_phone='', r.company_phone, l.company_phone);
				self.phone_type	                 := if(l.phone_type='', r.phone_type, l.phone_type);				
				self.phone_score                 := if(l.company_phone='', r.phone_score, l.phone_score);
				self.company_fein                := if(l.company_fein='', r.company_fein, l.company_fein);
				self.company_address.prim_range  := if(l.company_address.prim_range = ''  and l.company_address.zip4 = '', r.company_address.prim_range, l.company_address.prim_range);
				self.company_address.predir      := if(l.company_address.predir = ''      and l.company_address.zip4 = '', r.company_address.predir, l.company_address.predir);
				self.company_address.prim_name   := if(l.company_address.prim_name = ''   and l.company_address.zip4 = '', r.company_address.prim_name, l.company_address.prim_name);
				self.company_address.addr_suffix := if(l.company_address.addr_suffix = '' and l.company_address.zip4 = '', r.company_address.addr_suffix, l.company_address.addr_suffix);
				self.company_address.postdir     := if(l.company_address.postdir = ''     and l.company_address.zip4 = '', r.company_address.postdir, l.company_address.postdir);
				self.company_address.unit_desig  := if(l.company_address.unit_desig = ''  and l.company_address.zip4 = '', r.company_address.unit_desig, l.company_address.unit_desig);
				self.company_address.sec_range   := if(l.company_address.sec_range = ''   and l.company_address.zip4 = '', r.company_address.sec_range, l.company_address.sec_range);
				self.company_address.v_city_name := if(l.company_address.v_city_name = '' and l.company_address.zip4 = '', r.company_address.v_city_name, l.company_address.v_city_name);
				self.company_address.st          := if(l.company_address.st = ''          and l.company_address.zip4 = '', r.company_address.st, l.company_address.st);
				self.company_address.zip         := if(l.company_address.zip = ''        	and l.company_address.zip4 = '', r.company_address.zip, l.company_address.zip);
				self.company_address.zip4        := if(l.company_address.zip4 = '', r.company_address.zip4, l.company_address.zip4);
				self.company_address.fips_state  := if(l.company_address.fips_state = ''  and l.company_address.zip4 = '', r.company_address.fips_state, l.company_address.fips_state);
				self.company_address.fips_county := if(l.company_address.fips_county = '' and l.company_address.zip4 = '', r.company_address.fips_county, l.company_address.fips_county);
				self.company_address.msa         := if(l.company_address.msa = ''         and l.company_address.zip4 = '', r.company_address.msa, l.company_address.msa);
				self.company_address.geo_lat     := if(l.company_address.geo_lat = ''     and l.company_address.zip4 = '', r.company_address.geo_lat, l.company_address.geo_lat);
				self.company_address.geo_long    := if(l.company_address.geo_long = ''    and l.company_address.zip4 = '', r.company_address.geo_long, l.company_address.geo_long);
				self := l;
				self := [];
		 end;

		 br_clean_dist := distribute(br_group_clean+busreg_owner_filtered,hash(company_address.zip,trim(company_address.prim_name),trim(company_address.prim_range),trim(company_name)));
			
		 br_clean_sort := sort(br_clean_dist,tmp_join_id_company,company_address.zip,company_address.prim_range,company_address.prim_name,company_name,
														if(company_address.sec_range<>'',0,1),company_address.sec_range,
														if(company_phone<>'',0,1),company_phone,
														if(company_fein<>'',0,1),company_fein,
														dt_vendor_last_reported,dt_vendor_first_reported,dt_last_seen,
													 local);
								
		 rollup_companies := rollup(br_clean_sort,
											left.tmp_join_id_company				= right.tmp_join_id_company
									and left.company_address.zip       = right.company_address.zip
									and left.company_address.prim_name  = right.company_address.prim_name
									and left.company_address.prim_range = right.company_address.prim_range
									and left.company_name               = right.company_name
									and     (right.company_address.sec_range = '' or left.company_address.sec_range = right.company_address.sec_range)
											and (right.company_phone='' 							or left.company_phone=right.company_phone)
											and (right.company_fein='' 								or left.company_fein=right.company_fein),
									x7(left,right),local);
			
		 ds_contact := distribute(ds_contact_rollup,hash(tmp_join_id_contact));
		 ds_company := distribute(rollup_companies,hash(tmp_join_id_company));

		 Business_Header.Layout_Business_Linking.Combined x8(Business_Header.Layout_Business_Linking.Company_ L, Business_Header.Layout_Business_Linking.Contact R) := transform
			  self.company_address_type_raw := if(l.company_aceaid = r.contact_aceaid and l.company_aceaid <> 0,'CC',l.company_address_type_raw);
				self.contact_address_type			:= if(l.company_aceaid = r.contact_aceaid and l.company_aceaid <> 0,'CC',r.contact_address_type);
				self := l;
				self := r;
		 end;

		 j1 := join(ds_company,ds_contact,left.tmp_join_id_company=right.tmp_join_id_contact,x8(left,right),left outer,local);
		 
		 Business_Header.Layout_Business_Linking.Combined x9(Business_Header.Layout_Business_Linking.Combined l, Business_Header.Layout_Business_Linking.Contact r) := transform
				self.company_rawaid              := r.contact_rawaid;  
				self.company_aceaid              := r.contact_aceaid;  	
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
				self.company_address.cart        := r.contact_address.cart;
				self.company_address.cr_sort_sz  := r.contact_address.cr_sort_sz;
				self.company_address.lot         := r.contact_address.lot;
				self.company_address.lot_order   := r.contact_address.lot_order;
				self.company_address.dbpc        := r.contact_address.dbpc;
				self.company_address.chk_digit   := r.contact_address.chk_digit;
				self.company_address.rec_type    := r.contact_address.rec_type;	
				self.company_address.fips_state  := r.contact_address.fips_state;
				self.company_address.fips_county := r.contact_address.fips_county;				
				self.company_address.geo_lat     := r.contact_address.geo_lat;
				self.company_address.geo_long    := r.contact_address.geo_long;  
				self.company_address.msa         := r.contact_address.msa;
				self.company_address.err_stat    := r.contact_address.err_stat;
				self.company_address_type_raw    := r.contact_address_type;
				self := l;
		 end;
		 
		 //add contact name to the join to avoid mingling every contact with every other contact's address	
		 j2 := join(j1,ds_contact(contact_address.prim_range<>'' or contact_address.prim_name<>'' or contact_address.zip<>''),left.tmp_join_id_company=right.tmp_join_id_contact and left.contact_name.fname=right.contact_name.fname and left.contact_name.lname=right.contact_name.lname,x9(left,right),local);
		 
		 concat      := j1+j2;
		 concat_dupd := dedup(project(concat,Business_Header.Layout_Business_Linking.Linking_Interface),record,all);
			
		 return concat_dupd;
	
end;