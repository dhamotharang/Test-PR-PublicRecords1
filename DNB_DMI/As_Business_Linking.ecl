#OPTION('multiplePersistInstances',FALSE);
import dnb_dmi,mdr,business_header,ut,_Validate,address,business_headerv2,mdr,lib_stringlib;

export As_Business_Linking (boolean pUseOtherEnviron = _Constants().IsDataland
	// ,dataset(layouts.Base.companiesforBip2) pCompany_Base = files(,pUseOtherEnviron).base.companies.qa																												
	,dataset(layouts.Base.CompaniesForBIP2) pCompany_Base = files(,pUseOtherEnviron).base.companies.qa																												
	,dataset(layouts.Base.contacts)	 pContact_Base = files(,pUseOtherEnviron).base.contacts.qa	,
	Boolean IsPRCT = false
	) := function

//CONTACTS MAPPING
	Business_Header.Layout_Business_Linking.Contact x1(pContact_Base l) := transform
		self.tmp_join_id_contact         := l.duns_number;
		self.contact_rawaid  	           := l.rawaid;
		self.contact_aceaid              := l.aceaid;
		self.contact_address.prim_range  := l.clean_company_address.prim_range;
		self.contact_address.predir      := l.clean_company_address.predir;
		self.contact_address.prim_name   := l.clean_company_address.prim_name;
		self.contact_address.addr_suffix := l.clean_company_address.addr_suffix;
		self.contact_address.postdir     := l.clean_company_address.postdir;
		self.contact_address.unit_desig  := l.clean_company_address.unit_desig;
		self.contact_address.sec_range   := l.clean_company_address.sec_range;	
		self.contact_address.p_city_name := l.clean_company_address.p_city_name;
		self.contact_address.v_city_name := l.clean_company_address.v_city_name;
		self.contact_address.st          := l.clean_company_address.st;
		self.contact_address.zip         := l.clean_company_address.zip;
		self.contact_address.zip4        := l.clean_company_address.zip4;
		self.contact_address.cart        := l.clean_company_address.cart;
		self.contact_address.cr_sort_sz  := l.clean_company_address.cr_sort_sz;
		self.contact_address.lot         := l.clean_company_address.lot;
		self.contact_address.lot_order   := l.clean_company_address.lot_order;
		self.contact_address.dbpc        := l.clean_company_address.dbpc;
		self.contact_address.chk_digit   := l.clean_company_address.chk_digit;
		self.contact_address.rec_type    := l.clean_company_address.rec_type;		
		self.contact_address.fips_county := l.clean_company_address.fips_county;
		self.contact_address.fips_state  := l.clean_company_address.fips_state;
		self.contact_address.geo_lat     := l.clean_company_address.geo_lat;
		self.contact_address.geo_long    := l.clean_company_address.geo_long;
		self.contact_address.msa         := l.clean_company_address.msa;
		self.contact_address.geo_blk     := l.clean_company_address.geo_blk;
		self.contact_address.geo_match   := l.clean_company_address.geo_match;
		self.contact_address.err_stat    := l.clean_company_address.err_stat;
		self.contact_address_type        := if((l.clean_company_address.p_city_name='' and
		                                        l.clean_company_address.st='' and
																					  l.clean_company_address.zip='')
																						,'','CB'); //Contact Business Address 
		self.is_contact                  := false; //Will be set during linking
		self.dt_first_seen_contact       := if(_validate.date.fIsValid((string)l.date_first_seen),(unsigned4)l.date_first_seen,0);
		self.dt_last_seen_contact        := if(_validate.date.fIsValid((string)l.date_last_seen),(unsigned4)l.date_last_seen,0);
		self.contact_did                 := l.did;
		self.contact_name.title          := l.clean_name.title;
		self.contact_name.fname          := l.clean_name.fname;
		self.contact_name.mname          := l.clean_name.mname;
		self.contact_name.lname          := l.clean_name.lname;
		self.contact_name.name_suffix    := l.clean_name.name_suffix;
		self.contact_name.name_score     := l.clean_name.name_score;
		self.contact_type_raw            := ''; //Not available
		self.contact_job_title_raw       := stringlib.stringtouppercase(l.rawfields.exec_title);
		self.contact_ssn                 := ''; //Not available
		self.contact_dob                 := 0;  //Not available
		self.contact_status_raw          := ''; //Not available
		self.contact_email               := ''; //Not available
		self.contact_email_username      := ''; //Not available
		self.contact_email_domain        := ''; //Not available
		self.contact_phone               := ut.cleanPhone(l.company_phone10);
		self.cid												 := 0;  //Not available
		self.contact_score							 := 0;  //Not available
		self.from_hdr										 := 'N';		
		self.company_department					 :='';  //Not available
		self 														 := l;
		self 														 := [];
	end;

	mapping_contacts := project(pContact_Base,x1(left));
   
	layout_bhf_local := record
		Business_Header.Layout_Business_Linking.Company_;
		unsigned6 orig_id;
		unsigned6 split_id:=0;
		unsigned1 ntyp := 0;
		unsigned6 group1_id;	
	end;
 
	//COMPANY MAPPING
  //layout_bhf_local x2(dnb_dmi.layouts.Base.companiesforBip2 L, integer ctr, unsigned1 ntyp) := transform
  layout_bhf_local x2(dnb_dmi.layouts.Base.CompaniesForBIP2 L, integer ctr, unsigned1 ntyp) := transform

		self.tmp_join_id_company         := (string)l.rawfields.duns_number;
		self.orig_id                     := l.rid;
		self.vl_id                       := l.rawfields.duns_number;
		self.source                      := MDr.sourceTools.src_Dunn_Bradstreet;
		self.dt_first_seen               := if(_validate.date.fIsValid((string)l.date_first_seen)
																					,(unsigned4)l.date_first_seen, 0);
		self.dt_last_seen                := if(_validate.date.fIsValid((string)l.date_last_seen)
																					,(unsigned4)l.date_last_seen, 0);
		self.dt_vendor_first_reported    := if(_validate.date.fIsValid((string)l.date_vendor_first_reported)
																					,(unsigned4)l.date_vendor_first_reported
																					,self.dt_first_seen);
		self.dt_vendor_last_reported     := if(_validate.date.fIsValid((string)l.date_vendor_last_reported)
																					,(unsigned4)l.date_vendor_last_reported
																					,self.dt_first_seen);
    self.rcid 											 := 0;		
		self.company_bdid                := l.bdid;
		self.company_name                := choose(ntyp, stringlib.stringtouppercase(trim(l.rawfields.business_name)), stringlib.stringtouppercase(trim(l.rawfields.trade_style)));
		self.company_name_type_raw       := choose(ntyp, 'LEGAL', 'TRADE STYLE');
		self.company_rawaid							 := choose(ctr, l.mail_rawaid,									 l.rawaid);
		self.company_aceaid							 := choose(ctr, l.mail_aceaid,									 l.aceaid);
  	self.company_address.prim_range  := choose(ctr, l.clean_mail_address.prim_range, l.clean_address.prim_range);
		self.company_address.predir      := choose(ctr, l.clean_mail_address.predir,     l.clean_address.predir);
		self.company_address.prim_name   := choose(ctr, l.clean_mail_address.prim_name,  l.clean_address.prim_name);
		self.company_address.addr_suffix := choose(ctr, l.clean_mail_address.addr_suffix,l.clean_address.addr_suffix);
		self.company_address.postdir     := choose(ctr, l.clean_mail_address.postdir,    l.clean_address.postdir);
		self.company_address.unit_desig  := choose(ctr, l.clean_mail_address.unit_desig, l.clean_address.unit_desig);
		self.company_address.sec_range   := choose(ctr, l.clean_mail_address.sec_range,  l.clean_address.sec_range);
		self.company_address.p_city_name := choose(ctr, l.clean_mail_address.p_city_name,l.clean_address.p_city_name);
		self.company_address.v_city_name := choose(ctr, l.clean_mail_address.v_city_name,l.clean_address.v_city_name);
		self.company_address.st          := choose(ctr, l.clean_mail_address.st,         l.clean_address.st);
		self.company_address.zip         := choose(ctr, l.clean_mail_address.zip,        l.clean_address.zip);
		self.company_address.zip4        := choose(ctr, l.clean_mail_address.zip4,       l.clean_address.zip4);
		self.company_address.cart        := choose(ctr, l.clean_mail_address.cart,       l.clean_address.cart);		
		self.company_address.cr_sort_sz  := choose(ctr, l.clean_mail_address.cr_sort_sz, l.clean_address.cr_sort_sz);		
		self.company_address.lot         := choose(ctr, l.clean_mail_address.lot,        l.clean_address.lot);
		self.company_address.lot_order   := choose(ctr, l.clean_mail_address.lot_order,  l.clean_address.lot_order);		
		self.company_address.dbpc        := choose(ctr, l.clean_mail_address.dbpc,       l.clean_address.dbpc);
		self.company_address.chk_digit   := choose(ctr, l.clean_mail_address.chk_digit,  l.clean_address.chk_digit);		
		self.company_address.rec_type    := choose(ctr, l.clean_mail_address.rec_type,   l.clean_address.rec_type);			
		self.company_address.fips_county := choose(ctr, l.clean_mail_address.fips_county,l.clean_address.fips_county);
		self.company_address.fips_state  := choose(ctr, l.clean_mail_address.fips_state, l.clean_address.fips_state);
		self.company_address.msa         := choose(ctr, l.clean_mail_address.msa,        l.clean_address.msa);
		self.company_address.geo_lat     := choose(ctr, l.clean_mail_address.geo_lat,    l.clean_address.geo_lat);
		self.company_address.geo_long    := choose(ctr, l.clean_mail_address.geo_long,   l.clean_address.geo_long);
		self.company_address.geo_blk     := choose(ctr, l.clean_mail_address.geo_blk,    l.clean_address.geo_blk);
		self.company_address.geo_match   := choose(ctr, l.clean_mail_address.geo_match,  l.clean_address.geo_match);
		self.company_address.err_stat    := choose(ctr, l.clean_mail_address.err_stat,   l.clean_address.err_stat);
		self.company_sic_code1					 := l.rawfields.sic1a; 
		self.company_sic_code2					 := l.rawfields.sic2a; 
		self.company_sic_code3					 := l.rawfields.sic3a; 
		self.company_sic_code4					 := l.rawfields.sic4a; 
		self.company_sic_code5					 := l.rawfields.sic5a; 
		self.company_address_type_raw    := choose(ctr
																							 ,if((l.clean_mail_address.p_city_name='' and
		                                                l.clean_mail_address.st='' and
																					          l.clean_mail_address.zip=''),'','MAILING')
																							 ,'');	
		self.company_address_category    := ''; //Not available
		self.company_fein                := ''; //Not available
		self.company_phone               := ut.CleanPhone(l.rawfields.telephone_number);
		self.phone_type                  := if((unsigned8)ut.CleanPhone(l.rawfields.telephone_number)=0,'','T'); 
		self.company_org_structure_raw   := map(trim(l.rawfields.structure_type) = '1' => 'PROPRIETORSHIP',
																						trim(l.rawfields.structure_type) = '2' => 'PARTNERSHIP',
																						trim(l.rawfields.structure_type) = '3' => 'CORPORATION',
																						'');
		self.company_incorporation_date	 := if(_validate.date.fIsValid((string)l.rawfields.date_of_incorporation), (unsigned4)l.rawfields.date_of_incorporation, 0);
		self.company_naics_code1         := ''; //Not available
		self.company_naics_code2         := ''; //Not available
		self.company_naics_code3         := ''; //Not available
		self.company_naics_code4         := ''; //Not available
		self.company_naics_code5         := ''; //Not available
		self.company_foreign_domestic    := ''; //Not available	
		self.company_url                 := ''; //Not available	
		self.company_inc_state			     := trim(l.rawfields.state_of_incorporation_abbr);
		self.company_charter_number      := ''; //Not available
		self.company_filing_date         := 0;  //Not available
		self.company_status_date         := 0;  //Not available
		self.company_foreign_date        := 0;  //Not available
		self.event_filing_date           := 0;  //Not available
		self.company_name_status_raw     := ''; //Not available
		self.company_status_raw          := map(l.active_duns_number = 'Y' => 'ACTIVE',
																						l.active_duns_number = 'N' => 'INACTIVE',
																						'');
		self.dt_first_seen_company_name  := 0;  //Not available
		self.dt_last_seen_company_name   := 0;  //Not available
		self.dt_first_seen_company_address:=0;  //Not available
		self.dt_last_seen_company_address:= 0;  //Not available
		self.best_fein_Indicator         := ''; //Only for FEIN.  Not for DMI.
		self.company_ticker              := ''; //Not available
    self.company_ticker_exchange     := ''; //Not available
		self.current										 := TRUE;
		self.source_record_id						 := l.rid;		
		self.glb												 := false;
		self.dppa										     := false;
		self.phone_score                 := if((unsigned8)ut.CleanPhone(l.rawfields.telephone_number) = 0, 0, 1); 		
		self.match_company_name					 := ''; //Not available
		self.match_branch_city 					 := ''; //Not available
		self.match_geo_city							 := ''; //Not available		
		self.group1_id									 := 0;	
		self.duns_number								 := l.rawfields.duns_number;			
    temp_employees_total_sign        := if(trim(l.rawfields.employees_total_sign) = '-', '-', '');
    temp_annual_sales_volume_sign    := if(trim(l.rawfields.annual_sales_volume_sign) = '-', '-', '');
    temp_employees_here_sign         := if(trim(l.rawfields.employees_here_sign) = '-', '-', '');
		temp_employees_org               := if(trim(l.rawfields.employees_total) != '0',trim(l.rawfields.employees_total),'');
		temp_employees_local             := if(trim(l.rawfields.employees_here) != '0',trim(l.rawfields.employees_here),'');
		temp_sales                       := if(trim(l.rawfields.annual_sales_volume) != '0',trim(l.rawfields.annual_sales_volume),'');
    self.employee_count_org_raw      := trim(temp_employees_total_sign) +temp_employees_org;
    self.revenue_org_raw             := trim(temp_annual_sales_volume_sign) +temp_sales;
    self.employee_count_local_raw    := trim(temp_employees_here_sign) +temp_employees_local;
		self.revenue_local_raw           := '';
		self 														 := l;
		self 														 := [];
	end;

	from_dnb_norm1 := normalize(pCompany_Base(rawfields.business_name<>''),
																							2,x2(left,counter,1));		
		
	from_dnb_norm2 := normalize(pCompany_Base(rawfields.trade_style<>''), 
																						  2,x2(left,counter,2));
		
	from_dnb_norm_dist	:= distribute((from_dnb_norm1 + from_dnb_norm2), hash(orig_id, ut.CleanCompany(company_name)));
  	
	from_dnb_norm_sort	:= sort(from_dnb_norm_dist, orig_id, ut.CleanCompany(company_name),  -   company_address.zip, -company_address.st, -company_address.v_city_name, local);
		
	Layout_BHF_Local RollupDNBNorm(Layout_BHF_Local L, Layout_BHF_Local R) := transform
	  self.dt_first_seen		        := min(l.dt_first_seen,	r.dt_first_seen);
		self.dt_last_seen 		        := max(l.dt_last_seen,	r.dt_last_seen);
		self.dt_vendor_last_reported  := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.dt_vendor_first_reported := min(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		//The source_record_id is a generated number.  It is generated in the Ingest Companies attribute.
		self.source_record_id	        := if (l.source_record_id < r.source_record_id, l.source_record_id, r.source_record_id);
		self                          := L;
	end;

	from_dnb_norm_rollup := rollup(from_dnb_norm_sort,
																	LEFT.orig_id = RIGHT.orig_id AND
																	ut.CleanCompany(LEFT.company_name) = ut.CleanCompany(RIGHT.company_name) AND
																	((LEFT.company_address.zip = RIGHT.company_address.zip AND
																	  LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
																	  LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
																	  LEFT.company_address.v_city_name = RIGHT.company_address.v_city_name AND
																	  LEFT.company_address.st = RIGHT.company_address.st)
																	OR
																	 (RIGHT.company_address.zip = '' AND
																		RIGHT.company_address.prim_name = '' AND
																		RIGHT.company_address.prim_range = '' AND
																		RIGHT.company_address.v_city_name = '' AND
																		RIGHT.company_address.st = '')
																	),
																	RollupDNBNorm(LEFT, RIGHT),
																	LOCAL);
  	
	ut.MAC_Sequence_Records(from_dnb_norm_rollup, split_id, from_dnb_seq)
	
	// Group by original id
	from_dnb_dist 			:= distribute(from_dnb_seq, hash(orig_id));
		
	from_dnb_sort 			:= SORT(from_dnb_dist, orig_id, ntyp, LOCAL);
		
	from_dnb_grpd 			:= GROUP(from_dnb_sort, orig_id, ntyp, LOCAL);
		
	from_dnb_grpd_sort 	:= SORT(from_dnb_grpd, split_id);
	
	Layout_BHF_Local SetGroupId(Layout_BHF_Local L, Layout_BHF_Local R) := TRANSFORM
		self.group1_id := if(l.group1_id <> 0, l.group1_id, r.split_id);
		self 					 := R;
	end;

	// Set group id
	from_dnb_iter := GROUP(ITERATE(from_dnb_grpd_sort, SetGroupId(LEFT, RIGHT)));
	
	// Calculate stat to determine count by group_id
	Layout_Group_List := record
		from_dnb_iter.group1_id;
	end;

	dnb_group_list := TABLE(from_dnb_iter, Layout_Group_List);
  
	Layout_Group_Stat := record
		dnb_group_list.group1_id;
		cnt := COUNT(GROUP);
	end;

	dnb_group_stat := TABLE(dnb_group_list, Layout_Group_Stat, group1_id);
  
  layout_bhf_local FormatToBHF(layout_bhf_local L, layout_group_stat R) := transform
				self.group1_id := r.group1_id;
				self           := l;
		 end;
		 
  dnb_group_clean1 := JOIN(from_dnb_iter,
													 dnb_group_stat(cnt > 1),
													 LEFT.group1_id = RIGHT.group1_id,
													 FormatToBHF(LEFT, RIGHT),
													 LEFT OUTER);
  
	dnb_group_clean  := project(dnb_group_clean1,
												transform({Business_Header.Layout_Business_Linking.Company_},
												self:=left,self:=[]));
		
	// Rollup
	Business_Header.Layout_Business_Linking.Company_ RollupDNB(Business_Header.Layout_Business_Linking.Company_ l, Business_Header.Layout_Business_Linking.Company_ r) := transform
		self.dt_first_seen := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
											     ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
		self.dt_last_seen 								:= MAX(l.dt_last_seen,r.dt_last_seen);
		self.dt_vendor_last_reported			:= MAX(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.dt_vendor_first_reported			:= ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.vl_id 												:= if(l.vl_id = '', r.vl_id, l.vl_id);
   	self.company_name 								:= if(l.company_name = '', r.company_name, l.company_name);
		self.company_phone								:= if(l.company_phone = '', r.company_phone, l.company_phone);
		self.phone_score 									:= if(l.company_phone = '', r.phone_score, l.phone_score);
		self.company_fein 								:= if(l.company_fein = '', r.company_fein, l.company_fein);
		self.company_address.prim_range 	:= if(l.company_address.prim_range = '' AND l.company_address.zip4 = '', r.company_address.prim_range, l.company_address.prim_range);
		self.company_address.predir 			:= if(l.company_address.predir = '' AND l.company_address.zip4 = '', r.company_address.predir, l.company_address.predir);
		self.company_address.prim_name 		:= if(l.company_address.prim_name = '' AND l.company_address.zip4 = '', r.company_address.prim_name, l.company_address.prim_name);
		self.company_address.addr_suffix 	:= if(l.company_address.addr_suffix = '' AND l.company_address.zip4 = '', r.company_address.addr_suffix, l.company_address.addr_suffix);
		self.company_address.postdir 			:= if(l.company_address.postdir = '' AND l.company_address.zip4 = '', r.company_address.postdir, l.company_address.postdir);
		self.company_address.unit_desig 	:= if(l.company_address.unit_desig = ''AND l.company_address.zip4 = '', r.company_address.unit_desig, l.company_address.unit_desig);
		self.company_address.sec_range 		:= if(l.company_address.sec_range = '' AND l.company_address.zip4 = '', r.company_address.sec_range, l.company_address.sec_range);
		self.company_address.p_city_name	:= if(l.company_address.p_city_name = '' AND l.company_address.zip4 = '', r.company_address.p_city_name, l.company_address.p_city_name);
		self.company_address.v_city_name	:= if(l.company_address.v_city_name = '' AND l.company_address.zip4 = '', r.company_address.v_city_name, l.company_address.v_city_name);
		self.company_address.st 					:= if(l.company_address.st = '' AND l.company_address.zip4 = '', r.company_address.st, l.company_address.st);
		self.company_address.zip					:= if(l.company_address.zip = '' AND l.company_address.zip4 = '', r.company_address.zip, l.company_address.zip);
		self.company_address.zip4 				:= if(l.company_address.zip4 = '', r.company_address.zip4, l.company_address.zip4);
		self.company_address.fips_county 	:= if(l.company_address.fips_county = '' AND l.company_address.zip4 = '', r.company_address.fips_county, l.company_address.fips_county);
		self.company_address.fips_state 	:= if(l.company_address.fips_state = '' AND l.company_address.zip4 = '', r.company_address.fips_state, l.company_address.fips_state);
		self.company_address.msa 					:= if(l.company_address.msa = '' AND l.company_address.zip4 = '', r.company_address.msa, l.company_address.msa);
		self.company_address.geo_lat 			:= if(l.company_address.geo_lat = '' AND l.company_address.zip4 = '', r.company_address.geo_lat, l.company_address.geo_lat);
		self.company_address.geo_long 		:= if(l.company_address.geo_long = '' AND l.company_address.zip4 = '', r.company_address.geo_long, l.company_address.geo_long);
		self.company_rawaid 							:= if(l.company_rawaid = 0 AND l.company_address.zip4 = '', r.company_rawaid, l.company_rawaid);
		self.company_aceaid 							:= if(l.company_aceaid = 0, r.company_aceaid, l.company_aceaid);
		self 															:= l;
	end;
	
	dnb_clean_dist := DISTRIBUTE(dnb_group_clean, HASH(vl_id, company_aceaid, TRIM(company_name)));
  	
	dnb_clean_sort := SORT(dnb_clean_dist, vl_id, company_aceaid, company_name,
													if(company_phone <> '', 0, 1), company_phone,
													if(company_fein <> '', 0, 1), company_fein,
													dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
  	
	dasbh := ROLLUP(dnb_clean_sort,
									left.vl_id = right.vl_id and
									left.company_aceaid = right.company_aceaid and
									left.company_name = right.company_name and
									(right.company_phone = '' OR left.company_phone = right.company_phone) and
									(right.company_fein = '' OR left.company_fein = right.company_fein),
									RollupDNB(LEFT, RIGHT), LOCAL);
		
	ds_contact := distribute(mapping_contacts,hash(tmp_join_id_contact));
	ds_company := distribute(dasbh,hash(tmp_join_id_company));
	
	Business_Header.Layout_Business_Linking.Combined x8(Business_Header.Layout_Business_Linking.Company_ L, Business_Header.Layout_Business_Linking.Contact R) := transform
		self.company_address_type_raw := if(l.company_aceaid <> 0 and (l.company_aceaid = r.contact_aceaid), 'CC', l.company_address_type_raw);
		self.contact_address_type			:= if(l.company_aceaid <> 0 and (l.company_aceaid = r.contact_aceaid), 'CC', r.contact_address_type);		
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
		self.company_address.fips_county := r.contact_address.fips_county;
		self.company_address.fips_state  := r.contact_address.fips_state;
		self.company_address.msa         := r.contact_address.msa;
		self.company_address.geo_lat     := r.contact_address.geo_lat;
		self.company_address.geo_long    := r.contact_address.geo_long;
		self.company_address_type_raw    := r.contact_address_type;
		self := l;
	end;

	//add contact name to the join to avoid mingling every contact with every other contact's address	
	j2 := join(j1,ds_contact(contact_address.prim_range<>'' or contact_address.prim_name<>'' or contact_address.zip<>''),
						 left.tmp_join_id_company=right.tmp_join_id_contact and 
						 left.contact_name.fname=right.contact_name.fname and 
						 left.contact_name.lname=right.contact_name.lname, x9(left,right),local);

	concat      := j1+j2;
	
	concat_sort_dist := dedup(sort(distribute(concat, hash(vl_id)), record, local), record, except company_address_type_raw, local);
	
	concat_dupd := project(concat_sort_dist(company_name<>''),
										Business_Header.Layout_Business_Linking.Linking_Interface);
										
	persist := concat_dupd : persist('~thor_data400::persist::DNB_DMI::As_Business_Linking');
		
 return if (IsPRCT, concat_dupd, persist);

end;