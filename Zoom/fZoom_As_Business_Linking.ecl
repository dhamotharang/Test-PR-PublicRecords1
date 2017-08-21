import Address, Business_Header, Email_Data, MDR, UT;

export fZoom_As_Business_Linking(dataset(layouts.base) pDataset = ZOOM.Files().Base.QA) :=
function

	// Slim file layout that includes only the cleaned fields for name, company address, person address, 
	// last update date, company phone and contact phone.
	slim_base :=	record
			string	tmp_join_id;
			string	contact_name;
			layouts.base.did;
			layouts.base.bdid;
			layouts.base.raw_aid;
			layouts.base.ace_aid;
			layouts.base.dt_first_seen;
			layouts.base.dt_last_seen;
			layouts.base.dt_vendor_first_reported;
			layouts.base.dt_vendor_last_reported;
			layouts.base.record_type;
			layouts.base.rawfields								rawfields;
			layouts.base.clean_contact_name 			clean_contact_name;
			string1 name_flag 										:= '';
			layouts.base.clean_company_address 		clean_company_address;		
			layouts.base.clean_person_address 		clean_person_address;	
			layouts.base.clean_dates 							clean_dates;
			layouts.base.clean_phones							clean_phones;	
			layouts.base.source_rec_id;			
		end;

	// Slim the file and include only cleaned fields for name, company address, person address, 
	// last update date, company phone and contact phone.
	slim_base tSlim_Base(layouts.base L) := 
	transform
		filtered_zoomid												 := if(stringlib.stringfilterout(l.rawfields.zoomid,'0123456789') <> '','',ut.fntrim2upper(l.rawfields.zoomid));
		filtered_zoomcompanyid								 := if(stringlib.stringfilterout(l.rawfields.zoom_company_id,'-0123456789 ') <> '','',ut.fntrim2upper(l.rawfields.zoom_company_id));
		//self.tmp_join_id_company						   := if(filtered_zoomcompanyid <> '',filtered_zoomid+'c'+filtered_zoomcompanyid,filtered_zoomid);		
		self.tmp_join_id											 := if(filtered_zoomcompanyid <> '',filtered_zoomid+'c'+filtered_zoomcompanyid,filtered_zoomid);
		self.rawfields.zoomid									 := l.rawfields.zoomid;
		self.rawfields.job_title							 := ut.fntrim2upper(l.rawfields.job_title);
		self.rawfields.email_address					 := ut.fntrim2upper(l.rawfields.email_address);
		self.rawfields.zoom_company_id				 := l.rawfields.zoom_company_id;
		self.rawfields.company_name						 := ut.fntrim2upper(l.rawfields.company_name);
		self.rawfields.company_domain_name		 := ut.fntrim2upper(l.rawfields.company_domain_name);
		self.contact_name											 := ut.fntrim2upper(l.clean_contact_name.fname + ' ' + l.clean_contact_name.mname + ' ' + l.clean_contact_name.lname);
		self																	 := l;
	end;

	ds_slim_base	 			:= project(pDataset, tSlim_Base(LEFT));	
	ds_slim_base_fil    := ds_slim_base(tmp_join_id != '');
	
	cln_layout := RECORD
			slim_base;
			string5         cln_title;
			string20        cln_fname;
			string20        cln_mname;
			string20        cln_lname;
			string5         cln_suffix;
			string5         cln_title2;
			string20        cln_fname2;
			string20        cln_mname2;
			string20        cln_lname2;
			string5         cln_suffix2;
	END;

	Address.Mac_Is_Business( ds_slim_base_fil, contact_name, ds_cln_Cont_Name, name_flag, false, true );
	
	ds_slim_cln_names		:= project(ds_cln_Cont_Name, transform(slim_base,self := left));
	
	dSlimBase_dist		  := distribute(ds_slim_cln_names, hash(tmp_join_id));
	
	dSlimBase_sort  		:= sort(dSlimBase_dist
												 ,record
												 ,except
														tmp_join_id
														,did
														,bdid
														,raw_aid
														,ace_aid
														,dt_first_seen
														,dt_last_seen
														,dt_vendor_last_reported
														,dt_vendor_first_reported
														,record_type
														,clean_dates.last_updated_date
														,name_flag
														,local
								);
	
	slim_base RollupSlimBase(slim_base l, slim_base r) := 
	transform
		SELF.dt_first_seen 									:= ut.EarliestDate(
																							ut.EarliestDate(L.dt_first_seen	,r.dt_first_seen)
																							,ut.EarliestDate(L.dt_last_seen		,r.dt_last_seen	)
																					);
		SELF.dt_last_seen 									:= ut.LatestDate(L.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 				:= ut.LatestDate(L.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported 			:= ut.EarliestDate(L.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.clean_dates.last_updated_date	:= ut.EarliestDate(L.clean_dates.last_updated_date, r.clean_dates.last_updated_date);
		SELF.record_type										:= if(L.record_type = 'C' or r.record_type = 'C', 'C', 'H');
		SELF 																:= l;
	end;		

	dSlimBase_rollup 	:= rollup(dSlimBase_sort
															,RollupSlimBase(left, right)
															,record
															,except
																 did
																,bdid
																,raw_aid
																,ace_aid
																,dt_first_seen
																,dt_last_seen
																,dt_vendor_last_reported
																,dt_vendor_first_reported
																,record_type
																,clean_dates.last_updated_date
																,local
												);					

	//////////////////////////////////////////////////////////////////////////////////////////////
	// --Company Mapping
	//////////////////////////////////////////////////////////////////////////////////////////////
		
	bh_layout_company := Business_Header.Layout_Business_Linking.Company_;
	
	//*** Modified code for Bug: 153999  - DATA: URL showing partial information 
	bad_urls := ['HTTP:','HTTP://','HTTPS://','HTTPS:','HTTP://WWW','HTTP://WWW.','HTTPS://WWW','HTTPS://WWW.','WWW','WWW.'];

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH Layout_Business_Linking.Company_
	//////////////////////////////////////////////////////////////////////////////////////////////
	
	bh_layout_company tAsBusinessHeader(slim_base L) := 
	transform
		SELF.tmp_join_id_company						:= L.tmp_join_id;
		SELF.company_aceaid									:= L.ace_aid;
		SELF.source 												:= mdr.sourceTools.src_ZOOM;
		SELF.dt_first_seen 									:= L.dt_first_seen;
		SELF.dt_last_seen 									:= L.dt_last_seen;	
		SELF.dt_vendor_first_reported				:= L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported				:= L.dt_vendor_last_reported;
		SELF.rcid														:= 0;
		SELF.company_bdid										:= L.BDID;
		SELF.company_name 									:= L.rawfields.company_name;
		SELF.company_name_type_raw 					:= '';	
		SELF.company_rawaid									:= L.raw_aid;
		SELF.company_address.prim_range 		:= L.clean_company_address.prim_range;
		SELF.company_address.predir 				:= L.clean_company_address.predir;
		SELF.company_address.prim_name 			:= L.clean_company_address.prim_name;
		SELF.company_address.addr_suffix 		:= L.clean_company_address.addr_suffix;
		SELF.company_address.postdir 				:= L.clean_company_address.postdir;
		SELF.company_address.unit_desig 		:= L.clean_company_address.unit_desig;
		SELF.company_address.sec_range 			:= L.clean_company_address.sec_range;
		SELF.company_address.p_city_name 		:= L.clean_company_address.p_city_name;		
		SELF.company_address.v_city_name 		:= L.clean_company_address.v_city_name;
		SELF.company_address.st 					 	:= L.clean_company_address.st;
		SELF.company_address.zip						:= L.clean_company_address.zip;
		SELF.company_address.zip4 					:= L.clean_company_address.zip4;
		SELF.company_address.cart						:= L.clean_company_address.cart;
		SELF.company_address.cr_sort_sz			:= L.clean_company_address.cr_sort_sz;
		SELF.company_address.lot						:= L.clean_company_address.lot;
		SELF.company_address.lot_order			:= L.clean_company_address.lot_order;
		SELF.company_address.dbpc						:= L.clean_company_address.dbpc;
		SELF.company_address.chk_digit			:= L.clean_company_address.chk_digit;
		SELF.company_address.rec_type				:= L.clean_company_address.rec_type;
		SELF.company_address.fips_state			:= L.clean_company_address.fips_state;
		SELF.company_address.fips_county		:= L.clean_company_address.fips_county;		
		SELF.company_address.geo_lat				:= L.clean_company_address.geo_lat;
		SELF.company_address.geo_long				:= L.clean_company_address.geo_long;
		SELF.company_address.msa						:= L.clean_company_address.msa;
		SELF.company_address.geo_blk				:= L.clean_company_address.geo_blk;
		SELF.company_address.geo_match			:= L.clean_company_address.geo_match;
		SELF.company_address.err_stat				:= L.clean_company_address.err_stat;
		SELF.company_address_type_raw				:= '';
		SELF.company_address_category				:= '';		
		SELF.company_fein 									:= '';
		SELF.best_fein_Indicator						:= '';
		SELF.company_phone 									:= L.clean_phones.company_phone;
		SELF.phone_type											:= if(SELF.company_phone<>'','T','');
		SELF.company_org_structure_raw			:= '';
		SELF.company_incorporation_date			:= 0;
		SELF.company_sic_code1							:= IF(LENGTH(TRIM(L.rawfields.SIC1)) = 4 AND
		                                             REGEXFIND('^[0-9]+$', TRIM(L.rawfields.SIC1)),
		                                          L.rawfields.SIC1,
																							'');
		SELF.company_sic_code2							:= IF(LENGTH(TRIM(L.rawfields.SIC2)) = 4 AND
		                                             REGEXFIND('^[0-9]+$', TRIM(L.rawfields.SIC2)),
		                                          L.rawfields.SIC2,
																							'');		
		SELF.company_sic_code3							:= '';		
		SELF.company_sic_code4							:= '';
		SELF.company_sic_code5							:= '';
		SELF.company_naics_code1						:= IF(LENGTH(TRIM(L.rawfields.NAICS1)) = 6 AND
		                                             REGEXFIND('^[0-9]+$', TRIM(L.rawfields.NAICS1)),
		                                          L.rawfields.NAICS1,
																							'');
		SELF.company_naics_code2						:= IF(LENGTH(TRIM(L.rawfields.NAICS2)) = 6 AND
		                                             REGEXFIND('^[0-9]+$', TRIM(L.rawfields.NAICS2)),
		                                          L.rawfields.NAICS2,
																							'');
		SELF.company_naics_code3						:= '';	
		SELF.company_naics_code4						:= '';	
		SELF.company_naics_code5						:= '';
		SELF.company_ticker									:= '';
		SELF.company_ticker_exchange				:= '';
		SELF.company_foreign_domestic				:= '';
		//*** Bug: 153999  - DATA: URL showing partial information
		SELF.company_url										:= if(ut.fnTrim2Upper(L.rawfields.company_domain_name) not in bad_urls, stringlib.stringcleanspaces(L.rawfields.company_domain_name),'');
		SELF.company_inc_state							:= '';
		SELF.company_charter_number					:= '';
		SELF.company_filing_date						:= 0;
		SELF.company_status_date						:= 0;
		SELF.company_foreign_date						:= 0;
		SELF.event_filing_date							:= 0;
		SELF.company_name_status_raw				:= '';
		SELF.company_status_raw							:= '';
		SELF.dt_first_seen_company_name			:= 0;
		SELF.dt_last_seen_company_name			:= 0;
		SELF.dt_first_seen_company_address	:= 0;
		SELF.dt_last_seen_company_address		:= 0;
		//Note: vendor_id no longer exists and since vl_id is 25% blank, moving the "derived vl_id" here.
		SELF.vl_id					 								:= L.tmp_join_id;
		SELF.current 												:= if(L.record_type = 'C', TRUE, FALSE);
		SELF.source_record_id						 		:= L.source_rec_id;
		SELF.glb														:= false;
		SELF.dppa														:= false;
		SELF.phone_score										:= if((unsigned6)SELF.company_phone = 0, 0, 1);
		SELF.match_company_name							:= '';
		SELF.match_branch_city							:= '';
		SELF.match_geo_city									:= '';
	end;


  dAsBusinessCompany 			 := project(dSlimBase_rollup, tAsBusinessHeader(LEFT));
	
	dAsBusinessCompany_dist	 := distribute(dAsBusinessCompany, hash(tmp_join_id_company));	

	dAsBusinessCompany_sort  := sort(dAsBusinessCompany_dist
																	 ,tmp_join_id_company
																	 ,company_name													 
																	 ,company_address.prim_range
																	 ,company_address.prim_name
																	 ,company_address.addr_suffix
																	 ,company_address.predir
																	 ,company_address.postdir
																	 ,company_address.unit_desig
																	 ,company_address.sec_range
																	 ,company_address.p_city_name
																	 ,company_address.v_city_name
																	 ,company_address.st
																	 ,company_address.zip
																	 ,company_phone
																	 ,company_url
																	 ,-dt_last_seen,local);
/*	
	dAsBusinessCompany_dedp  := dedup(dAsBusinessCompany_sort
													 ,tmp_join_id_company
													 ,company_name													 
													 ,company_address.prim_range
													 ,company_address.prim_name
													 ,company_address.addr_suffix
													 ,company_address.predir
													 ,company_address.postdir
													 ,company_address.unit_desig
													 ,company_address.sec_range
													 ,company_address.p_city_name
													 ,company_address.v_city_name
													 ,company_address.st
													 ,company_address.zip
													 ,company_phone
													 ,local);
*/													 	
	bh_layout_company RollupCompany(bh_layout_company l, bh_layout_company r) := 
	transform
		SELF.dt_first_seen 							:= ut.EarliestDate(
																					 ut.EarliestDate(L.dt_first_seen	,r.dt_first_seen)
																					,ut.EarliestDate(L.dt_last_seen		,r.dt_last_seen	)
																			);
		SELF.dt_last_seen 							:= ut.LatestDate(L.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 		:= ut.LatestDate(L.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported 	:= ut.EarliestDate(L.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.current 										:= if(L.current or r.current = TRUE, TRUE, FALSE);		
		SELF 														:= l;
	end;	

	dAsBusinessCompany_rollup := rollup( dAsBusinessCompany_sort
																			,left.tmp_join_id_company = right.tmp_join_id_company
																			and left.company_name=right.company_name
																			and ((     left.company_address.zip=right.company_address.zip 
																						 and left.company_address.prim_name=right.company_address.prim_name 
																						 and left.company_address.prim_range=right.company_address.prim_range
																						 and left.company_address.v_city_name=right.company_address.v_city_name
																						 and left.company_address.st=right.company_address.st)															 
																						 or (right.company_address.zip='' and right.company_address.prim_name='' and right.company_address.prim_range='' and right.company_address.v_city_name='' and right.company_address.st='')
																					 )
																			and (left.company_phone=right.company_phone or right.company_phone = '')
																			and (left.company_url = right.company_url or right.company_url = '')
																			,RollupCompany(left, right)
																			,local
																		 );

	ds_company	:= dAsBusinessCompany_rollup;
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	// --Contact Mapping
	//////////////////////////////////////////////////////////////////////////////////////////////

	
	//dContNameBlank      := project(dSlimBase_rollup(tmp_join_id_contact = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	
	//dContCleanName      := dClean_Cont_Name   +  dContNameBlank;

	dContactFiltered 		:= dSlimBase_rollup(name_flag in ['P','D']); //Person or Dual
/*
	dContactSorted 			:= sort(dContactProj, tmp_join_id_contact, clean_contact_name.fname, clean_contact_name.lname, clean_contact_name.mname, clean_contact_name.name_suffix, rawfields.zoom_company_id, clean_company_address.prim_range, clean_company_address.prim_name, clean_company_address.addr_suffix, clean_company_address.predir, clean_company_address.postdir, clean_company_address.unit_desig, clean_company_address.sec_range, clean_company_address.p_city_name, clean_company_address.st, clean_company_address.zip, rawfields.company_name, rawfields.job_title, clean_phones.phone, clean_phones.company_phone, rawfields.email_address, -dt_last_seen, local);

	dContactDedup  			:= dedup(dContactSorted,  tmp_join_id_contact, clean_contact_name.fname, clean_contact_name.lname, clean_contact_name.mname, clean_contact_name.name_suffix, rawfields.zoom_company_id, clean_company_address.prim_range, clean_company_address.prim_name, clean_company_address.addr_suffix, clean_company_address.predir, clean_company_address.postdir, clean_company_address.unit_desig, clean_company_address.sec_range, clean_company_address.p_city_name, clean_company_address.st, clean_company_address.zip, rawfields.company_name, rawfields.job_title, clean_phones.phone, clean_phones.company_phone, rawfields.email_address, local);
*/
	bh_layout_contact 	:= Business_Header.Layout_Business_Linking.Contact;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH Layout_Business_Linking.Contact
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout_contact tAsBusinessContact(slim_base L) :=
	transform
		SELF.tmp_join_id_contact						:= L.tmp_join_id;
		SELF.contact_rawaid									:= 0;	//note: the current build process does not create rawaids for contacts
		SELF.contact_aceaid									:= 0; //note: the current build process does not create aceaids for contacts
		SELF.contact_address.prim_range 		:= L.Clean_Person_address.prim_range;
		SELF.contact_address.predir 				:= L.Clean_Person_address.predir;
		SELF.contact_address.prim_name 			:= L.Clean_Person_address.prim_name;
		SELF.contact_address.addr_suffix 		:= L.Clean_Person_address.addr_suffix;
		SELF.contact_address.postdir 				:= L.Clean_Person_address.postdir;
		SELF.contact_address.unit_desig 		:= L.Clean_Person_address.unit_desig;
		SELF.contact_address.sec_range 			:= L.Clean_Person_address.sec_range;
		SELF.contact_address.p_city_name 		:= L.Clean_Person_address.p_city_name;		
		SELF.contact_address.v_city_name 		:= L.Clean_Person_address.v_city_name;
		SELF.contact_address.st 					 	:= L.Clean_Person_address.st;
		SELF.contact_address.zip						:= L.Clean_Person_address.zip;
		SELF.contact_address.zip4 					:= L.Clean_Person_address.zip4;
		SELF.contact_address.cart						:= L.Clean_Person_address.cart;
		SELF.contact_address.cr_sort_sz			:= L.Clean_Person_address.cr_sort_sz;
		SELF.contact_address.lot						:= L.Clean_Person_address.lot;
		SELF.contact_address.lot_order			:= L.Clean_Person_address.lot_order;
		SELF.contact_address.dbpc						:= L.Clean_Person_address.dbpc;
		SELF.contact_address.chk_digit			:= L.Clean_Person_address.chk_digit;
		SELF.contact_address.rec_type				:= L.Clean_Person_address.rec_type;
		SELF.contact_address.fips_state			:= L.Clean_Person_address.fips_state;
		SELF.contact_address.fips_county		:= L.Clean_Person_address.fips_county;				
		SELF.contact_address.geo_lat				:= L.Clean_Person_address.geo_lat;
		SELF.contact_address.geo_long				:= L.Clean_Person_address.geo_long;
		SELF.contact_address.msa						:= L.Clean_Person_address.msa;
		SELF.contact_address.geo_blk				:= L.Clean_Person_address.geo_blk;
		SELF.contact_address.geo_match			:= L.Clean_Person_address.geo_match;
		SELF.contact_address.err_stat				:= L.Clean_Person_address.err_stat;		
		SELF.contact_address_type						:= if(L.Clean_Person_address.p_city_name = '' AND L.Clean_Person_address.st = '' AND L.Clean_Person_address.zip = '','','C');
		SELF.is_contact											:= false;
		SELF.dt_first_seen_contact					:= 0;
		SELF.dt_last_seen_contact						:= L.clean_dates.last_updated_date;
		SELF.contact_did										:= L.DID;
		SELF.contact_name.title							:= L.clean_contact_name.title;
		SELF.contact_name.fname							:= L.clean_contact_name.fname;
		SELF.contact_name.mname							:= L.clean_contact_name.mname;
		SELF.contact_name.lname							:= L.clean_contact_name.lname;
		SELF.contact_name.name_suffix				:= L.clean_contact_name.name_suffix;
		SELF.contact_name.name_score				:= '';			
		SELF.contact_type_raw								:= '';
		SELF.contact_job_title_raw					:= L.rawfields.Job_Title;
		SELF.contact_ssn										:= '';
		SELF.contact_dob										:= 0;
		SELF.contact_status_raw							:= '';
		SELF.contact_email									:= L.rawfields.Email_Address;
		SELF.contact_email_username					:= email_data.Fn_Clean_Email_Username(SELF.contact_email);
		SELF.contact_email_domain						:= email_data.Fn_Clean_Email_Domain(SELF.contact_email);
		SELF.contact_phone									:= L.clean_phones.phone;
		SELF.cid														:= 0;
		SELF.contact_score									:= 0;
		SELF.from_hdr												:= 'N';
		SELF.company_department							:= '';
	end;

	dASBusinessContact	 				:= project(dContactFiltered, tAsBusinessContact(LEFT));
	dASBusinessContact_dist	 		:= distribute(dASBusinessContact, hash(tmp_join_id_contact));
	
	dAsBusinessContactSorted 		:= sort(dASBusinessContact_dist, tmp_join_id_contact, contact_name.fname, contact_name.lname, contact_name.mname, contact_name.name_suffix, contact_address.prim_range, contact_address.prim_name, contact_address.addr_suffix, contact_address.predir, contact_address.postdir, contact_address.unit_desig, contact_address.sec_range, contact_address.p_city_name, contact_address.st, contact_address.zip, contact_job_title_raw, contact_phone, contact_email, -dt_last_seen_contact,local);
	dAsBusinessContactdedup  		:= dedup(dAsBusinessContactSorted,  tmp_join_id_contact, contact_name.fname, contact_name.lname, contact_name.mname, contact_name.name_suffix, contact_address.prim_range, contact_address.prim_name, contact_address.addr_suffix, contact_address.predir, contact_address.postdir, contact_address.unit_desig, contact_address.sec_range, contact_address.p_city_name, contact_address.st, contact_address.zip, contact_job_title_raw, contact_phone, contact_email, local);

	ds_Contact									:= dAsBusinessContactdedup;

	Business_Header.Layout_Business_Linking.Combined joinfiles(bh_layout_company L, bh_layout_contact R) :=
	transform
				self := l;
				self := r;
	end;

	j1 := join(ds_company(tmp_join_id_company != ''),ds_contact(tmp_join_id_contact != '')
						 ,left.tmp_join_id_company = right.tmp_join_id_contact					
						 ,joinfiles(left,right)
						 ,left outer
						 ,hash);

	Business_Header.Layout_Business_Linking.Combined MapContactAddresses(Business_Header.Layout_Business_Linking.Combined l, Business_Header.Layout_Business_Linking.Contact r) := transform
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
				self.company_address.zip        := r.contact_address.zip;
				self.company_address.zip4        := r.contact_address.zip4;	
				self.company_address.cart        := r.contact_address.cart;
				self.company_address.cr_sort_sz  := r.contact_address.cr_sort_sz;
				self.company_address.lot         := r.contact_address.lot;
				self.company_address.lot_order   := r.contact_address.lot_order;
				self.company_address.dbpc        := r.contact_address.dbpc;
				self.company_address.chk_digit   := r.contact_address.chk_digit;
				self.company_address.rec_type    := r.contact_address.rec_type;			
				self.company_address.fips_state	 := r.contact_address.fips_state;
				self.company_address.fips_county := r.contact_address.fips_county;			
				self.company_address.geo_lat     := r.contact_address.geo_lat;
				self.company_address.geo_long    := r.contact_address.geo_long;  
				self.company_address.msa         := r.contact_address.msa;
				self.company_address.err_stat    := r.contact_address.err_stat;
				self.company_address_type_raw    := r.contact_address_type;
				self := l;
	end;
		 
	//add contact name to the join to avoid mingling every contact with every other contact's address	
  ds_contact_filter := ds_contact((contact_address.prim_range	<> '' or 
													 contact_address.prim_name	<> '' or
													 contact_address.zip				<> '') and tmp_join_id_contact != '' and contact_name.fname != '' and contact_name.lname != '') 
                           : independent;
                           
  j1_filter := j1(tmp_join_id_company != '',contact_name.fname != '',contact_name.lname != '') : independent;
  
	j2 := join(j1_filter,ds_contact_filter
													,left.tmp_join_id_company		=	right.tmp_join_id_contact and
													 left.contact_name.fname		=	right.contact_name.fname 	and
													 left.contact_name.lname		=	right.contact_name.lname
													,MapContactAddresses(left,right),hash);
	 
	concat      := j1+j2;
	ds_concat 	:= project(concat,Business_Header.Layout_Business_Linking.Linking_Interface);
	
	concat_dupd := dedup(sort(distribute(ds_concat,hash(vl_id)),record,local),record,local);
			
	return concat_dupd;
	
end;
