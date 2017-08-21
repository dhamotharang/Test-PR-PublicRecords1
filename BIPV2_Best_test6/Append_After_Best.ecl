import BIPV2, BIPV2_Best,ut, Census_Data;
bip_business_header := BIPV2.Files.business_header_building;

best_flat_l1 := RECORD
  unsigned6 proxid;
  BIPV2_Best.Layouts.company_name;
  DATASET(BIPV2_Best.Layouts.company_address) address_cases;
  DATASET(BIPV2_Best.Layouts.company_phone) company_phone_cases;
  DATASET(BIPV2_Best.Layouts.company_fein) company_fein_cases;
  DATASET(BIPV2_Best.Layouts.company_url) company_url_cases;
 END;
 
 best_flat_l2 := RECORD
  unsigned6 proxid;
  BIPV2_Best.Layouts.company_name;
  BIPV2_Best.Layouts.company_address;
  DATASET(BIPV2_Best.Layouts.company_phone) company_phone_cases;
  DATASET(BIPV2_Best.Layouts.company_fein) company_fein_cases;
  DATASET(BIPV2_Best.Layouts.company_url) company_url_cases;
 END;
 
  best_flat_l3 := RECORD
  unsigned6 proxid;
  BIPV2_Best.Layouts.company_name;
  BIPV2_Best.Layouts.company_address;
  BIPV2_Best.Layouts.company_phone;
  DATASET(BIPV2_Best.Layouts.company_fein) company_fein_cases;
  DATASET(BIPV2_Best.Layouts.company_url) company_url_cases;
 END;
 
 best_flat_l4 := RECORD
  unsigned6 proxid;
  BIPV2_Best.Layouts.company_name;
  BIPV2_Best.Layouts.company_address;
  BIPV2_Best.Layouts.company_phone;
  BIPV2_Best.Layouts.company_fein;
  DATASET(BIPV2_Best.Layouts.company_url) company_url_cases;
 END;

best_flat_l5 := RECORD
  unsigned6 proxid;
  BIPV2_Best.Layouts.company_name;
  BIPV2_Best.Layouts.company_address;
  BIPV2_Best.Layouts.company_phone;
  BIPV2_Best.Layouts.company_fein;
  BIPV2_Best.Layouts.company_url;
 END;
 
best_child_ds := best(In_Base).BestBy_Proxid_child;

//dedup datasets
recordof(best_child_ds)  t_dedup_ds (best_child_ds le) := transform
      SELF.company_name_cases := dedup(sort(le.company_name_cases, company_name_data_permits, company_name_method, company_name), company_name_data_permits) ;
		  SELF.address_cases := dedup(sort(le.address_cases, address_data_permits, address_method), address_data_permits);
			SELF.company_phone_cases := dedup(sort(le.company_phone_cases, company_phone_data_permits, company_phone_method, company_phone), company_phone_data_permits);	
			SELF.company_fein_cases := dedup(sort(le.company_fein_cases, company_fein_data_permits, company_fein_method, company_fein), company_fein_data_permits);
			SELF.company_url_cases := dedup(sort(le.company_url_cases, company_url_data_permits, company_url_method, company_url),  company_url_data_permits);		
			SELF := le,
end;

best_child_ds_ded := project(best_child_ds, t_dedup_ds(left));

best_child_ds_without_names := best_child_ds_ded(company_name_cases[1].company_name_method = 0);
MAC_Normalize_Child(best_flat_l1, BIPV2_Best.Layouts.company_name,  best_child_ds_ded, company_name_cases,  norm_name);
no_name_p := project(best_child_ds_without_names, transform(best_flat_l1, self := left, self := []));
all_names := norm_name + no_name_p;

without_address := all_names(address_cases[1].address_method = 0);
MAC_Normalize_Child(best_flat_l2, BIPV2_Best.Layouts.company_address,       all_names,     address_cases,       norm_address);
no_address_p := project(without_address, transform(best_flat_l2, self := left, self := []));
all_addresses := norm_address + no_address_p;

without_phone := all_addresses(company_phone_cases[1].company_phone_method = 0);
MAC_Normalize_Child(best_flat_l3, BIPV2_Best.Layouts.company_phone, all_addresses,  company_phone_cases, norm_phone);
no_phones_p := project(without_phone, transform(best_flat_l3, self := left, self := []));
all_phones := norm_phone + no_phones_p;

without_fein := all_phones(company_fein_cases[1].company_fein_method = 0);
MAC_Normalize_Child(best_flat_l4, BIPV2_Best.Layouts.company_fein,  all_phones,    company_fein_cases,  norm_fein);
no_feins_p := project(without_fein, transform(best_flat_l4, self := left, self := []));
all_feins := norm_fein + no_feins_p;

without_url := all_feins(company_url_cases[1].company_url_method = 0);
MAC_Normalize_Child(best_flat_l5, BIPV2_Best.Layouts.company_url,   all_feins,     company_url_cases,   norm_url);
no_urls_p := project(without_url, transform(best_flat_l5, self := left, self := []));
all_urls := norm_url + no_urls_p;

//APPEND ADDITIONAL DATA

slim_layout := record
unsigned6 proxid;
unsigned seleid; 
unsigned6 ultid;
unsigned orgid; 
string120 company_name; 
string250 cnp_name; 
string10 cnp_number;  
string10 cnp_btype;  
string20 cnp_lowv; 
string9 company_fein; 
string2 source;  
unsigned8 source_record_id; 	
string34 vl_id; 
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned company_incorporation_date;
end;

//--------------append dates
company_names_ := project(bip_business_header (proxid > 0 ), transform(slim_layout, self.company_name := if(fn_valid_cname(left.company_name,''), left.company_name, ''), self := left));
company_names := sort(distribute(company_names_, hash(proxid)), proxid, cnp_name, cnp_number, cnp_btype, cnp_lowv, company_name, local);

append_clean_name := join(distribute(all_urls, hash(proxid)),
													distribute(company_names, hash(proxid)),
													left.proxid = right.proxid and
													left.company_name = right.company_name,
													keep(1),
													left outer,
													local);
													
												
recordof(company_names) t_roll(company_names le, company_names ri) := transform
self.dt_first_seen := ut.Min2(le.dt_first_seen, ri.dt_first_seen);
self.dt_last_seen := ut.Max2(le.dt_last_seen, ri.dt_last_seen);
self := ri;
self := le;
end;
																			

aggr_company_name_dts := rollup(company_names,
														left.proxid = right.proxid and
														left.cnp_name  = right.cnp_name and
														left.cnp_number  = right.cnp_number and
														left.cnp_btype  = right.cnp_btype and 
														left.cnp_lowv  = right.cnp_lowv,
														t_roll(left, right),
														 local);
	
best_dts_append := join(distribute(append_clean_name, hash(proxid)),
											 distribute(aggr_company_name_dts, hash(proxid)),
											 left.proxid = right.proxid and
											 left.cnp_name  = right.cnp_name and
											 left.cnp_number  = right.cnp_number and
											 left.cnp_btype  = right.cnp_btype and 
											 left.cnp_lowv  = right.cnp_lowv,
											 transform(BIPV2_Best.Layouts.flat_best,
																self.dt_first_seen := right.dt_first_seen,
																self.dt_last_seen := right.dt_last_seen,
																self.seleid := right.seleid,																
																self.ultid := right.ultid,
																self.orgid := right.orgid,
																self := left,
																self := right),
											 local,
											 left outer);
											
 //--------append source, source_record_id, vl_id for company name
source_name := dedup(sort(distribute(company_names, hash(proxid)),proxid, cnp_name, cnp_number, cnp_btype, cnp_lowv, source, source_record_id, vl_id, local) ,proxid, cnp_name, cnp_number, cnp_btype, cnp_lowv, source, /*source_record_id, vl_id, */local);
 
best_src_name_append := join(distribute(best_dts_append, hash(proxid)),
												distribute(source_name, hash(proxid)),
												left.proxid = right.proxid and
											  left.cnp_name  = right.cnp_name and
											  left.cnp_number  = right.cnp_number and
											  left.cnp_btype  = right.cnp_btype and 
											  left.cnp_lowv  = right.cnp_lowv,
												transform(BIPV2_Best.Layouts.flat_best,
																	self.name_source := right.source;
																	self.name_source_record_id := right.source_record_id;
																	self.name_vl_id := right.vl_id,
																	self := left), 
																	keep(10),
																	local,
																	left outer);
temp_lay1 := record
unsigned6 proxid;
string120 company_name;
unsigned1 company_name_data_permits  := 0;
string2 name_source;
end;

best_src_name_append_p := distribute(project(best_src_name_append, temp_lay1), hash(proxid));

 
temp_lay1 t_roll1(best_src_name_append_p le, best_src_name_append_p ri) := transform
self.company_name_data_permits := BIPV2.mod_sources.src2bmap(le.name_source) | BIPV2.mod_sources.src2bmap(ri.name_source);
self := le;
end;
																		

aggr_company_name_src := rollup(best_src_name_append_p,
														left.proxid = right.proxid and 
														left.company_name = right.company_name,
														t_roll1(left, right),
														local); 
 
 
aggr_company_name_permits := join(distribute(best_src_name_append, hash(proxid)),
																		distribute(aggr_company_name_src, hash(proxid)),
																		left.proxid = right.proxid and
																		left.company_name = right.company_name,
																		transform(BIPV2_Best.Layouts.flat_best,
																						  self.company_name_data_permits := right.company_name_data_permits,
																							self := left),
																							
																		local); 
 //--------append source, source_record_id, vl_id for company fein 
source_fein := dedup(sort(distribute(company_names(company_fein <> ''), hash(proxid)),proxid, company_fein, source, source_record_id, vl_id, local) ,proxid, company_fein, source, /*source_record_id, vl_id,*/ local);
 
best_src_fein_append := join(distribute(aggr_company_name_permits, hash(proxid)),
												distribute(source_fein, hash(proxid)),
												left.proxid = right.proxid and
												left.company_fein = right.company_fein,
												transform(BIPV2_Best.Layouts.flat_best,
																	self.fein_source := right.source;
																	self.fein_source_record_id := right.source_record_id;
																	self.fein_vl_id := right.vl_id,
																	self := left), 
																	keep(10),
																	local,
																	left outer);
																										
//--------append county data
fips :=  dedup(sort(distribute(project(bip_business_header, {unsigned6 proxid,string10	prim_range,string2		predir, string28	prim_name, string4		addr_suffix, string2		postdir, string10	unit_desig, string8		sec_range, string5		zip, string4		zip4,  string25 p_city_name, string v_city_name, string2 fips_state,  string3 fips_county}), hash(proxid)),
																																				 proxid, prim_range, predir,prim_name,addr_suffix, postdir,unit_desig, sec_range, zip, zip4, p_city_name, -v_city_name,  -fips_state, -fips_county, local),
																																				 proxid, prim_range, predir,prim_name,addr_suffix, postdir,unit_desig, sec_range, zip, zip4, p_city_name, local);
append_fips := join(best_src_fein_append,
										fips,
										left.proxid = right.proxid and
										left.address_prim_range = right.prim_range and
										left.address_predir = right.predir and
										left.address_prim_name = right.prim_name and
										left.address_addr_suffix = right.addr_suffix and
										left.address_postdir = right.postdir and
										left.address_unit_desig = right.unit_desig and
										left.address_sec_range = right.sec_range and
										left.address_zip = right.zip and
										left.address_zip4 = right.zip4 and
										left.address_p_city_name = right.p_city_name,
										transform(BIPV2_Best.Layouts.flat_best,
                              self.address_v_city_name := right.v_city_name;															
															self.state_fips:= right.fips_state;
															self.county_fips := right.fips_county;
															self := left),
															left outer);
																
append_county_name := join(append_fips,
													 Census_Data.file_Fips2County,
													 left.state_fips = right.state_fips and
													 left.county_fips = right.county_fips,
											transform(BIPV2_Best.Layouts.flat_best,
															self.county_name:= right.county_name;
															self := left),
															lookup, 
															left outer);
															
//-------append company_incorporation_date
company_inc_dt := dedup(sort(distribute(company_names_(company_incorporation_date > 0), hash(proxid)), proxid, company_incorporation_date, local), proxid, local);

company_inc_dt_src := dedup(sort(
											join(distribute(company_inc_dt, hash(proxid)),
													 distribute(company_names_, hash(proxid)),
													 left.proxid = right.proxid and 
													 left.company_incorporation_date = right.company_incorporation_date,
													 transform(recordof(company_inc_dt),
													 self := right),
													 local), 
													 proxid, company_incorporation_date, source,source_record_id, vl_id, local), 
													 proxid, company_incorporation_date, source,source_record_id, vl_id, local);
													 
temp_lay2 := record
unsigned6 proxid;
unsigned1 company_incorporation_date_permits  := 0;
string2 source;
end;

company_inc_dt_src_p := distribute(project(company_inc_dt_src, transform(temp_lay2, self.company_incorporation_date_permits := BIPV2.mod_sources.src2bmap(left.source), self := left)), hash(proxid));

temp_lay2 t_roll2(company_inc_dt_src_p le, company_inc_dt_src_p ri) := transform
self.company_incorporation_date_permits := BIPV2.mod_sources.src2bmap(le.source) | BIPV2.mod_sources.src2bmap(ri.source);
self := le;
end;
																			

aggr_company_inc_dt_src := rollup(company_inc_dt_src_p,
														left.proxid = right.proxid, 
														t_roll2(left, right),
														local);


company_inc_dt_src_permits := join(distribute(company_inc_dt_src, hash(proxid)),
																		distribute(aggr_company_inc_dt_src, hash(proxid)),
																		left.proxid = right.proxid,
																		local);

		
flat_ds  := join(distribute(append_county_name, hash(proxid)),
												distribute(company_inc_dt_src_permits, hash(proxid)),
												left.proxid = right.proxid,
												transform(BIPV2_Best.Layouts.flat_best,
																	self.company_incorporation_date := right.company_incorporation_date;
																	self.company_incorporation_date_permits := right.company_incorporation_date_permits;
																	self.company_incorporation_date_method := 1;																	
																	self.incorporation_date_source := right.source;
																	self.incorporation_date_source_record_id := right.source_record_id;
																	self.incorporation_date_vl_id := right.vl_id,
																	self := left), 
																	keep(10),
																	local,
																	left outer);


flat_ds_ded := dedup(sort(distribute(flat_ds, hash(proxid)), proxid, local), proxid,local);

grp_proxid := group(sort(flat_ds, proxid, local), proxid, local);


//----------------------------COMPANY NAME-----------------------------------------
BIPV2_Best.Layouts.Base t_infinal(flat_ds le, dataset(recordof(flat_ds)) ri) := transform
		
		BIPV2_Best.Layouts.Source t_sources_name (flat_ds le) := transform
			self.source := le.name_source;
			self.source_record_id  := le.name_source_record_id;
			self.vl_id  := le.name_vl_id;
	end;
		
		BIPV2_Best.Layouts.company_name_case_layout t_name(flat_ds le, dataset(recordof(flat_ds)) ri) := transform
	    self.Sources := choosen(dedup(sort(project(ri, t_sources_name(left)), record),all), 5);
			self := le;
	end;
//----------------------------COMPANY ADDRESS----------------------------------------
		BIPV2_Best.Layouts.company_address_case_layout t_address (flat_ds le, dataset(recordof(flat_ds)) ri) := transform
	    self.company_prim_range := le.address_prim_range;
	    self.company_predir := le.address_predir;
	    self.company_prim_name := le.address_prim_name;
	    self.company_addr_suffix := le.address_addr_suffix;
	    self.company_postdir := le.address_postdir;
	    self.company_unit_desig := le.address_unit_desig;
	    self.company_sec_range :=  le.address_sec_range;
	    self.company_p_city_name := le.address_p_city_name;
	    self.company_st := le.address_st;
	    self.company_zip5 := le.address_zip;
	    self.company_zip4 := le.address_zip4;
	    self.company_address_data_permits  := le.address_data_permits;
	    self.company_address_method := le.address_method;
			self := le;
	end;
//----------------------------COMPANY PHONE----------------------------------------
		BIPV2_Best.Layouts.company_phone_case_layout t_phone(flat_ds le, dataset(recordof(flat_ds)) ri) := transform
	   self := le;
	end;
//----------------------------COMPANY FEIN----------------------------------------
		BIPV2_Best.Layouts.Source t_sources_fein (flat_ds le) := transform
			self.source := le.fein_source;
			self.source_record_id  := le.fein_source_record_id;
			self.vl_id  := le.fein_vl_id;
	end;
		
		BIPV2_Best.Layouts.company_fein_case_layout t_fein(flat_ds le, dataset(recordof(flat_ds)) ri) := transform
	    self.Sources := choosen(dedup(sort(project(ri, t_sources_fein(left)), record),all), 5);
			self := le;
	end;

//----------------------------COMPANY URL----------------------------------------
		BIPV2_Best.Layouts.company_url_case_layout t_url(flat_ds le, dataset(recordof(flat_ds)) ri) := transform
	   self := le;
	end;
	
//----------------------------INCORPORATION DATE----------------------------------------
		BIPV2_Best.Layouts.Source t_sources_inc_date (flat_ds le) := transform
			self.source := le.incorporation_date_source;
			self.source_record_id  := le.incorporation_date_source_record_id;
			self.vl_id  := le.incorporation_date_vl_id;
	end;
		
		BIPV2_Best.Layouts.company_incorporation_date_layout t_inc_date(flat_ds le, dataset(recordof(flat_ds)) ri) := transform
	    self.Sources := choosen(dedup(sort(project(ri, t_sources_inc_date(left)), record),all), 5);
			self := le;
	end;
	
		self.company_name :=   sort(dedup(sort(denormalize(ri, ri, left.company_name = right.company_name,
																 group,t_name(left, rows(right))), record), all), company_name_method) (company_name_method > 0); 
	
		self.company_address := sort(dedup(sort(denormalize(ri, ri, left.address_prim_range = right.address_prim_range and
																	left.address_predir  = right.address_predir and
																	left.address_prim_name  = right.address_prim_name and
																	left.address_addr_suffix  = right.address_addr_suffix and
																	left.address_postdir  = right.address_postdir and
																	left.address_unit_desig  = right.address_unit_desig and
																	left.address_sec_range  = right.address_sec_range and
																	left.address_p_city_name  = right.address_p_city_name and
																	left.address_st  = right.address_st  and
																	left.address_zip  = right.address_zip and
																	left.address_zip4  = right.address_zip4,	
																	group,t_address(left, rows(right))), record), all), company_address_method); 
			
		self.company_phone := sort(dedup(sort(denormalize(ri, ri, left.company_phone = right.company_phone,
																 group,t_phone(left, rows(right))), record), all), company_phone_method) (company_phone_method > 0); 
		
		self.company_fein :=   sort(dedup(sort(denormalize(ri, ri, left.company_fein = right.company_fein,
																 group,t_fein(left, rows(right))), record), all), company_fein_method)(company_fein_method > 0); 
		
		self.company_url := sort(dedup(sort(denormalize(ri, ri, left.company_url = right.company_url,
																 group,t_url(left, rows(right))), record), all), company_url_method) (company_url_method > 0); 
		
		
		self.company_incorporation_date := sort(dedup(sort(denormalize(ri, ri, left.company_incorporation_date = right.company_incorporation_date,
																 group,t_inc_date(left, rows(right))), record), all), company_incorporation_date_method) (company_incorporation_date > 0); 
		self.proxid := le.proxid;
		self.ultid := le.ultid;
		self.orgid := le.orgid;
		self := le;
		self := [];
end;

js_p := denormalize(flat_ds_ded , grp_proxid,
										left.proxid = right.proxid,
										group,
										t_infinal(left,rows(right)),
										local);

EXPORT Append_After_Best := js_p;