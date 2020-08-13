import Corp2_Services, Autokey_Batch, AutokeyB2, Corp2, Business_Header, Domains, doxie_cbrs, doxie, AutoStandardI, Suppress;

export DCALead_BatchService_Records(dataset(Autokey_Batch.Layouts.rec_inBatchMaster) autokey_in) := function

	autokey_outpl_rec := dataset([], Corp2_Services.assorted_layouts.layout_common);

	// First try and go find the data by Corporate Filings.
	corp_autokey_config := MODULE(BatchServices.Interfaces.i_AK_Config)
			export skip_set :=  ['P','Q','S'];
	END;
	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());													
	corp_autokey_base := '~thor_data400::key::corp2::qa::autokey::';
	corp_autokey_out := Autokey_batch.get_fids(autokey_in, corp_autokey_base, corp_autokey_config);

	corp_typestr := 'BC';
	AutokeyB2.mac_get_payload(corp_autokey_out,corp_autokey_base,autokey_outpl_rec,outPLfat,person_did,bdid,corp_typestr)
	
	// Fields I'm interested in
	temp_corp_results_rec := record
		outplfat.acctno;
		corp2.Key_Corp_Corpkey.corp_key;
		Business_Header.Key_BH_Supergroup_BDID.group_id;
		corp2.Key_Corp_Corpkey.bdid;
		corp2.Key_Corp_Corpkey.corp_state_origin;
		corp2.Key_Corp_Corpkey.corp_legal_name;
		corp2.Key_Corp_Corpkey.corp_ln_name_type_desc;
		corp2.Key_Corp_Corpkey.corp_address1_type_desc;
		corp2.Key_Corp_Corpkey.corp_addr1_prim_range;
		corp2.Key_Corp_Corpkey.corp_addr1_predir;
		corp2.Key_Corp_Corpkey.corp_addr1_prim_name;
		corp2.Key_Corp_Corpkey.corp_addr1_addr_suffix;
		corp2.Key_Corp_Corpkey.corp_addr1_postdir;
		corp2.Key_Corp_Corpkey.corp_addr1_unit_desig;
		corp2.Key_Corp_Corpkey.corp_addr1_sec_range;
		corp2.Key_Corp_Corpkey.corp_addr1_p_city_name;
		corp2.Key_Corp_Corpkey.corp_addr1_state;
		corp2.Key_Corp_Corpkey.corp_addr1_zip5;
		corp2.Key_Corp_Corpkey.corp_address2_type_desc;
		corp2.Key_Corp_Corpkey.corp_addr2_prim_range;
		corp2.Key_Corp_Corpkey.corp_addr2_predir;
		corp2.Key_Corp_Corpkey.corp_addr2_prim_name;
		corp2.Key_Corp_Corpkey.corp_addr2_addr_suffix;
		corp2.Key_Corp_Corpkey.corp_addr2_postdir;
		corp2.Key_Corp_Corpkey.corp_addr2_unit_desig;
		corp2.Key_Corp_Corpkey.corp_addr2_sec_range;
		corp2.Key_Corp_Corpkey.corp_addr2_p_city_name;
		corp2.Key_Corp_Corpkey.corp_addr2_state;
		corp2.Key_Corp_Corpkey.corp_addr2_zip5;
		corp2.Key_Corp_Corpkey.corp_status_desc;
		corp2.Key_Corp_Corpkey.corp_inc_date;
		corp2.Key_Corp_Corpkey.corp_forgn_state_cd;
	end;
	
	// Go get the Corp Filing data.
	corp_results := join(outplfat(corp_key != ''),corp2.Key_Corp_Corpkey,
		left.corp_key = right.corp_key,
		transform(temp_corp_results_rec,
			self := right,
			self := left,
			self := []))(bdid != 0);
	
	// output(corp_results);
	// Now, get the lowest incorp dates for each bdid
	corp_low_incorp_dates := table(
		corp_results(corp_inc_date != ''),
		{acctno,bdid,string8 corp_inc_date := min(group,corp_inc_date)},
		acctno,bdid);
	
	// Now, try to intuit the incorporation state for each bdid
	corp_incorp_state_guess := table(
		dedup(sort(
			table(
				corp_results,
				{acctno,bdid,string2 corp_inc_state := if(corp_forgn_state_cd = '',corp_state_origin,corp_forgn_state_cd),unsigned cnt := count(group)},
				acctno,bdid,if(corp_forgn_state_cd = '',corp_state_origin,corp_forgn_state_cd)),
			acctno,bdid,-cnt,corp_inc_state),acctno,bdid),
		{acctno,bdid,corp_inc_state});
	
	// Now, try to intuit the best address for each bdid
	corp_address_guess := table(
		dedup(sort(
			table(
				normalize(
					corp_results,2,transform(recordof(corp_results),
						self.corp_addr1_prim_range  := choose(counter,left.corp_addr1_prim_range ,left.corp_addr2_prim_range ),
						self.corp_addr1_predir      := choose(counter,left.corp_addr1_predir     ,left.corp_addr2_predir     ),
						self.corp_addr1_prim_name   := choose(counter,left.corp_addr1_prim_name  ,left.corp_addr2_prim_name  ),
						self.corp_addr1_addr_suffix := choose(counter,left.corp_addr1_addr_suffix,left.corp_addr2_addr_suffix),
						self.corp_addr1_postdir     := choose(counter,left.corp_addr1_postdir    ,left.corp_addr2_postdir    ),
						self.corp_addr1_unit_desig  := choose(counter,left.corp_addr1_unit_desig ,left.corp_addr2_unit_desig ),
						self.corp_addr1_sec_range   := choose(counter,left.corp_addr1_sec_range  ,left.corp_addr2_sec_range  ),
						self.corp_addr1_p_city_name := choose(counter,left.corp_addr1_p_city_name,left.corp_addr2_p_city_name),
						self.corp_addr1_state       := choose(counter,left.corp_addr1_state      ,left.corp_addr2_state      ),
						self.corp_addr1_zip5        := choose(counter,left.corp_addr1_zip5       ,left.corp_addr2_zip5       ),
						self.acctno := left.acctno,
						self.bdid := left.bdid,
						self := []))(corp_addr1_prim_name != ''),
				{acctno,bdid,corp_addr1_prim_range,corp_addr1_predir,corp_addr1_prim_name,corp_addr1_addr_suffix,corp_addr1_postdir,corp_addr1_unit_desig,corp_addr1_sec_range,corp_addr1_p_city_name,corp_addr1_state,corp_addr1_zip5,unsigned cnt := count(group)},
				acctno,bdid,corp_addr1_prim_range,corp_addr1_predir,corp_addr1_prim_name,corp_addr1_addr_suffix,corp_addr1_postdir,corp_addr1_unit_desig,corp_addr1_sec_range,corp_addr1_p_city_name,corp_addr1_state,corp_addr1_zip5),
			acctno,bdid,-cnt,corp_addr1_prim_range,corp_addr1_predir,corp_addr1_prim_name,corp_addr1_addr_suffix,corp_addr1_postdir,corp_addr1_unit_desig,corp_addr1_sec_range,corp_addr1_p_city_name,corp_addr1_state,corp_addr1_zip5),acctno,bdid),
		{acctno,bdid,corp_addr1_prim_range,corp_addr1_predir,corp_addr1_prim_name,corp_addr1_addr_suffix,corp_addr1_postdir,corp_addr1_unit_desig,corp_addr1_sec_range,corp_addr1_p_city_name,corp_addr1_state,corp_addr1_zip5});
	
	// Create a "seed" on acctno and bdid
	seed_records := dedup(sort(table(corp_results,{acctno,bdid}),acctno,bdid),acctno,bdid);
	
	// Join in the incorp date
	add_incorp_date := join(seed_records,corp_low_incorp_dates,
		left.acctno = right.acctno and
		left.bdid = right.bdid,
		left outer);
	
	// Join in the incorp state
	add_incorp_state := join(add_incorp_date,corp_incorp_state_guess,
		left.acctno = right.acctno and
		left.bdid = right.bdid,
		left outer);
	
	// Join to the best file
	add_best_data := table(
		join(add_incorp_state, Business_Header.Key_BH_Best,
			keyed (left.bdid = right.bdid) AND 
      doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
			left outer,
			keep (1), limit (0)),
		{acctno,bdid,company_name,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state, string zip := intformat(zip,5,1), string zip4 := intformat(zip4,4,1),phone,corp_inc_date,corp_inc_state});
	
	// Try adding corp data if best is empty
	add_corp_address := join(add_best_data,corp_address_guess,
		left.acctno = right.acctno and
		left.bdid = right.bdid,
		transform(recordof(add_best_data),
			self.prim_range  := if(left.prim_name = '',right.corp_addr1_prim_range ,left.prim_range ),
			self.predir      := if(left.prim_name = '',right.corp_addr1_predir     ,left.predir     ),
			self.prim_name   := if(left.prim_name = '',right.corp_addr1_prim_name  ,left.prim_name  ),
			self.addr_suffix := if(left.prim_name = '',right.corp_addr1_addr_suffix,left.addr_suffix),
			self.postdir     := if(left.prim_name = '',right.corp_addr1_postdir    ,left.postdir    ),
			self.unit_desig  := if(left.prim_name = '',right.corp_addr1_unit_desig ,left.unit_desig ),
			self.sec_range   := if(left.prim_name = '',right.corp_addr1_sec_range  ,left.sec_range  ),
			self.city        := if(left.prim_name = '',right.corp_addr1_p_city_name,left.city       ),
			self.state       := if(left.prim_name = '',right.corp_addr1_state      ,left.state      ),
			self.zip         := if(left.prim_name = '',right.corp_addr1_zip5       ,left.zip        ),
			self.zip4        := if(left.prim_name = '',''                          ,left.zip4       ),
			self := left),
		left outer);
	
	// Now, add SIC code info
	add_sic_code := denormalize(add_corp_address,Business_Header.Key_SIC_Code,
		left.bdid = right.bdid,
		group,
		transform(
			{
				recordof(add_corp_address);
				string8   siccode1;
				string8   siccode2;
				string8   siccode3;
				string8   siccode4;
				string8   siccode5;
				string8   siccode6;
				string8   siccode7;
				string8   siccode8;
				string8   siccode9;
			},
			temprows := dedup(sort(rows(right),sic_code),sic_code);
			self.siccode1 := temprows[1].sic_code,
			self.siccode2 := temprows[2].sic_code,
			self.siccode3 := temprows[3].sic_code,
			self.siccode4 := temprows[4].sic_code,
			self.siccode5 := temprows[5].sic_code,
			self.siccode6 := temprows[6].sic_code,
			self.siccode7 := temprows[7].sic_code,
			self.siccode8 := temprows[8].sic_code,
			self.siccode9 := temprows[9].sic_code,
			self := left));
	
	// Add URL from (old) domains
	add_url := denormalize(add_sic_code,domains.Key_Whois_Bdid,
		left.bdid = right.bdid,
		group,
		transform(
			{
				recordof(add_sic_code);
				string50 url1;
				string50 url2;
				string50 url3;
			},
			temprows := dedup(sort(rows(right),domain_name),domain_name);
			self.url1 := temprows[1].domain_name,
			self.url2 := temprows[2].domain_name,
			self.url3 := temprows[3].domain_name,
			self := left));
	
	// Get contacts
	get_contacts_join := join(add_url,business_header.Key_Business_Contacts_BDID,
		left.bdid = right.bdid and
		right.from_hdr = 'N');
    
  get_contacts := Suppress.MAC_SuppressSource(get_contacts_join, mod_access);
	// Add title weight
	join_titles := join(get_contacts,doxie_cbrs.executive_titles,
		left.company_title = right.stored_title,
		transform({recordof(get_contacts),doxie_cbrs.executive_titles.title_rank;},
			self.company_title := if(right.display_title != '',right.display_title,left.company_title),
			self.title_rank := if(right.display_title != '',right.title_rank,if(left.company_title != '',100,101)),
			self := left),
		left outer);
			
	// Add contacts
	add_contacts := denormalize(add_url,join_titles,
		left.bdid = right.bdid,
		group,
		transform(
			{
				recordof(add_url);
				string5  contact_prefix1;
				string20 contact_fname1;
				string20 contact_mname1;
				string20 contact_lname1;
				string5  contact_suffix1;
				string30 contact_title1;
				string5  contact_prefix2;
				string20 contact_fname2;
				string20 contact_mname2;
				string20 contact_lname2;
				string5  contact_suffix2;
				string30 contact_title2;
				string5  contact_prefix3;
				string20 contact_fname3;
				string20 contact_mname3;
				string20 contact_lname3;
				string5  contact_suffix3;
				string30 contact_title3;
				string5  contact_prefix4;
				string20 contact_fname4;
				string20 contact_mname4;
				string20 contact_lname4;
				string5  contact_suffix4;
				string30 contact_title4;
				string5  contact_prefix5;
				string20 contact_fname5;
				string20 contact_mname5;
				string20 contact_lname5;
				string5  contact_suffix5;
				string30 contact_title5;
				string5  contact_prefix6;
				string20 contact_fname6;
				string20 contact_mname6;
				string20 contact_lname6;
				string5  contact_suffix6;
				string30 contact_title6;
				string5  contact_prefix7;
				string20 contact_fname7;
				string20 contact_mname7;
				string20 contact_lname7;
				string5  contact_suffix7;
				string30 contact_title7;
				string5  contact_prefix8;
				string20 contact_fname8;
				string20 contact_mname8;
				string20 contact_lname8;
				string5  contact_suffix8;
				string30 contact_title8;
				string5  contact_prefix9;
				string20 contact_fname9;
				string20 contact_mname9;
				string20 contact_lname9;
				string5  contact_suffix9;
				string30 contact_title9;
			},
			temprows := sort(
				rollup(
					dedup(
						sort(rows(right),lname,fname,mname,name_suffix,title,title_rank,company_title),
						lname,fname,mname,name_suffix,title,title_rank,company_title),
					left.lname = right.lname and
					left.fname = right.fname and
					left.mname = right.mname and
					left.name_suffix = right.name_suffix and
					left.title = right.title,
					transform(
						recordof(right),
							self.company_title := left.company_title + if(right.company_title != '',if(left.company_title != '',',','') + right.company_title,''),
							self := left)),
				title_rank,lname,fname,mname,name_suffix,title,company_title);
			self.contact_prefix1 := temprows[1].title,
			self.contact_fname1 := temprows[1].fname,
			self.contact_mname1 := temprows[1].mname,
			self.contact_lname1 := temprows[1].lname,
			self.contact_suffix1 := temprows[1].name_suffix,
			self.contact_title1 := temprows[1].company_title,
			self.contact_prefix2 := temprows[2].title,
			self.contact_fname2 := temprows[2].fname,
			self.contact_mname2 := temprows[2].mname,
			self.contact_lname2 := temprows[2].lname,
			self.contact_suffix2 := temprows[2].name_suffix,
			self.contact_title2 := temprows[2].company_title,
			self.contact_prefix3 := temprows[3].title,
			self.contact_fname3 := temprows[3].fname,
			self.contact_mname3 := temprows[3].mname,
			self.contact_lname3 := temprows[3].lname,
			self.contact_suffix3 := temprows[3].name_suffix,
			self.contact_title3 := temprows[3].company_title,
			self.contact_prefix4 := temprows[4].title,
			self.contact_fname4 := temprows[4].fname,
			self.contact_mname4 := temprows[4].mname,
			self.contact_lname4 := temprows[4].lname,
			self.contact_suffix4 := temprows[4].name_suffix,
			self.contact_title4 := temprows[4].company_title,
			self.contact_prefix5 := temprows[5].title,
			self.contact_fname5 := temprows[5].fname,
			self.contact_mname5 := temprows[5].mname,
			self.contact_lname5 := temprows[5].lname,
			self.contact_suffix5 := temprows[5].name_suffix,
			self.contact_title5 := temprows[5].company_title,
			self.contact_prefix6 := temprows[6].title,
			self.contact_fname6 := temprows[6].fname,
			self.contact_mname6 := temprows[6].mname,
			self.contact_lname6 := temprows[6].lname,
			self.contact_suffix6 := temprows[6].name_suffix,
			self.contact_title6 := temprows[6].company_title,
			self.contact_prefix7 := temprows[7].title,
			self.contact_fname7 := temprows[7].fname,
			self.contact_mname7 := temprows[7].mname,
			self.contact_lname7 := temprows[7].lname,
			self.contact_suffix7 := temprows[7].name_suffix,
			self.contact_title7 := temprows[7].company_title,
			self.contact_prefix8 := temprows[8].title,
			self.contact_fname8 := temprows[8].fname,
			self.contact_mname8 := temprows[8].mname,
			self.contact_lname8 := temprows[8].lname,
			self.contact_suffix8 := temprows[8].name_suffix,
			self.contact_title8 := temprows[8].company_title,
			self.contact_prefix9 := temprows[9].title,
			self.contact_fname9 := temprows[9].fname,
			self.contact_mname9 := temprows[9].mname,
			self.contact_lname9 := temprows[9].lname,
			self.contact_suffix9 := temprows[9].name_suffix,
			self.contact_title9 := temprows[9].company_title,
			self := left));
	
	// Join back to input
	final_results := join(autokey_in,add_contacts,
		left.acctno = right.acctno and
		(left.comp_name = '' or ut.CompanySimilar100(left.comp_name,right.company_name) < 35),
		transform(right));
		
	return final_results;

end;
