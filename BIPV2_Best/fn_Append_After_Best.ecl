import BIPV2, BIPV2_Best,ut, Census_Data, BIPv2_HRCHY;
EXPORT fn_Append_After_Best (linkid,best_file,pHrchyBase,pFips2County) := FUNCTIONMACRO
bip_business_header := pHrchyBase;
best_company_name_l := RECORD
  BIPV2_Best.Layouts.linkids;
  unsigned6 company_bdid;
  BIPV2_Best.Layouts.company_name;
  string250 cnp_name := '';
  string10 cnp_number := '';
  string10 cnp_btype := '';
  string20 cnp_lowv := '';
  unsigned4 dt_first_seen := 0;
  unsigned4 dt_last_seen := 0;
  string2 name_source := '';
  unsigned8 name_source_record_id := 0;
  string34 name_vl_id := '';
END;
best_dba_name_l := RECORD
  unsigned6 linkid;
  BIPV2_Best.Layouts.dba_name;
END;
best_company_address_l := RECORD
  unsigned6 linkid;
  BIPV2_Best.Layouts.company_address;
  string25 address_v_city_name := '';
  string18 county_name := '';
  string2 state_fips:= '';
  string3 county_fips:= '';
 END;
 best_company_phone_l := RECORD
  unsigned6 linkid;
  BIPV2_Best.Layouts.company_phone_case_layout;
 END;
company_fein := RECORD
   string9 company_fein;
   unsigned2 company_fein_data_permits;
   unsigned1 company_fein_method;
   unsigned company_fein_own_cnt;
   boolean company_fein_owns;
  END;
best_company_fein_l := RECORD
  unsigned6 linkid;
  BIPV2_Best.Layouts.company_fein;
  string2 fein_source := '';
  unsigned8 fein_source_record_id := 0;
  string34 fein_vl_id := '';
 END;
best_company_url_l := RECORD
  unsigned6 linkid;
  BIPV2_Best.Layouts.company_url_case_layout;
 END;
 best_company_incorporation_date_l := RECORD
  unsigned6 linkid;
  BIPV2_Best.Layouts.company_incorporation_date;
  string2 incorporation_date_source := '';
  unsigned8 incorporation_date_source_record_id := 0;
  string34 incorporation_date_vl_id := '';
END;
best_duns_number_l := RECORD
  unsigned6 linkid;
  BIPV2_Best.Layouts.duns_number_case_layout;
 END;
best_sic_l := RECORD
  UNSIGNED6 linkid;
  BIPV2_Best.Layouts.sic_code_case_layout;
END;
best_naics_l := RECORD
  UNSIGNED6 linkid;
  BIPV2_Best.Layouts.naics_code_case_layout;
END;
best_child_ds := best_file;
//dedup datasets
best_child_ds_ded:=PROJECT(best_child_ds,TRANSFORM(RECORDOF(LEFT),
  SELF.company_name_cases        := DEDUP(SORT(LEFT.company_name_cases,company_name_data_permits,company_name_method,company_name),company_name_data_permits);
	 SELF.dba_name_cases            := DEDUP(SORT(LEFT.dba_name_cases,dba_name_data_permits,dba_name_method,dba_name),dba_name_data_permits);
  SELF.address_cases             := DEDUP(SORT(LEFT.address_cases,address_data_permits,address_method),address_data_permits);
  SELF.company_phone_cases       := DEDUP(SORT(LEFT.company_phone_cases,company_phone_data_permits,company_phone_method,company_phone),company_phone_data_permits);
  SELF.company_fein_cases        := DEDUP(SORT(LEFT.company_fein_cases,company_fein_data_permits,company_fein_method,company_fein),company_fein_data_permits);
  SELF.company_url_cases         := DEDUP(SORT(LEFT.company_url_cases,company_url_data_permits,company_url_method,company_url),company_url_data_permits);
  SELF.duns_number_cases         := DEDUP(SORT(LEFT.duns_number_cases,duns_number_data_permits,duns_number_method,duns_number),duns_number_data_permits);
  SELF.company_sic_code1_cases   := DEDUP(SORT(LEFT.company_sic_code1_cases,company_sic_code1_data_permits,company_sic_code1_method,company_sic_code1),company_sic_code1_data_permits);
  SELF.company_naics_code1_cases := DEDUP(SORT(LEFT.company_naics_code1_cases,company_naics_code1_data_permits,company_naics_code1_method,company_naics_code1),company_naics_code1_data_permits);
  SELF := LEFT;
));
norm_name    := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,company_name_cases,best_company_name_l);
norm_dba     := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,dba_name_cases,best_dba_name_l);
norm_address := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,address_cases,best_company_address_l);
norm_phone   := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,company_phone_cases,best_company_phone_l);
norm_fein    := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,company_fein_cases,best_company_fein_l);
norm_url     := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,company_url_cases,best_company_url_l);
norm_duns    := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,duns_number_cases,best_duns_number_l);
norm_sic     := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,company_sic_code1_cases,best_sic_l);
norm_naics   := BIPV2_Best.MAC_Normalize_Child(best_child_ds_ded,company_naics_code1_cases,best_naics_l);
//APPEND ADDITIONAL DATA
slim_layout:=RECORD
  UNSIGNED6 linkid;
  STRING120 company_name;
  STRING250 cnp_name;
  STRING10 cnp_number;
  STRING10 cnp_btype;
  STRING20 cnp_lowv;
  STRING9 company_fein;
  STRING2 source;
  UNSIGNED8 source_record_id;
  STRING34 vl_id;
  UNSIGNED4 dt_first_seen;
  UNSIGNED4 dt_last_seen;
  UNSIGNED company_incorporation_date;
END;
//--------------append dates
company_names_ := project(bip_business_header (linkid > 0 ), transform(slim_layout, self.company_name := if(BIPV2_Best.fn_valid_cname(left.company_name,''), left.company_name, ''), self := left));
company_names := sort(distribute(company_names_, hash(linkid)), linkid, trim(cnp_name,all), cnp_number, cnp_btype, cnp_lowv, company_name, local);
append_clean_name := join(
  distribute(norm_name, hash(linkid)),
  distribute(company_names, hash(linkid)),
  left.linkid = right.linkid and trim(left.company_name, all) = trim(right.company_name, all),
  transform(
    best_company_name_l,
    self.company_name := trim(left.company_name, left, right),
    self := right,
    self := left
  ),keep(1),left outer,local
);
aggr_company_name_dts := rollup(
  company_names,
  left.linkid=right.linkid and
  trim(left.cnp_name,all)=trim(right.cnp_name,all) and
  left.cnp_number=right.cnp_number and
  left.cnp_btype=right.cnp_btype and
  left.cnp_lowv=right.cnp_lowv,
  TRANSFORM(
    recordof(company_names),
    self.dt_first_seen := ut.Min2(LEFT.dt_first_seen, RIGHT.dt_first_seen);
		//self.dt_last_seen := ut.Max2(LEFT.dt_last_seen, RIGHT.dt_last_seen);
    self.dt_last_seen := Max(LEFT.dt_last_seen, RIGHT.dt_last_seen);
    self := RIGHT;
    self := LEFT;
  ),local
);
best_dts_append := join(
  distribute(append_clean_name,hash(linkid)),
  distribute(aggr_company_name_dts,hash(linkid)),
  left.linkid=right.linkid and
  trim(left.cnp_name,all)=trim(right.cnp_name,all) and
  left.cnp_number=right.cnp_number and
  left.cnp_btype=right.cnp_btype and
  left.cnp_lowv=right.cnp_lowv,
  transform(
    best_company_name_l,
    self.dt_first_seen := right.dt_first_seen,
    self.dt_last_seen := right.dt_last_seen,
    self := left,
    self := right
  ),local,left outer
);
 //--------append source, source_record_id, vl_id for company name
source_name := dedup(sort(distribute(company_names, hash(linkid)),linkid, trim(cnp_name,all), cnp_number, cnp_btype, cnp_lowv, source, source_record_id, vl_id, local) ,linkid, trim(cnp_name,all), cnp_number, cnp_btype, cnp_lowv, source, source_record_id, vl_id, local);
best_src_name_append := join(
  distribute(best_dts_append, hash(linkid)),
  distribute(source_name, hash(linkid)),
  left.linkid = right.linkid and
  trim(left.cnp_name,all)  = trim(right.cnp_name,all) and
  left.cnp_number  = right.cnp_number and
  left.cnp_btype  = right.cnp_btype and
  left.cnp_lowv  = right.cnp_lowv,
  transform(
    best_company_name_l,
    self.name_source := right.source;
    self.name_source_record_id := right.source_record_id;
    self.name_vl_id := right.vl_id,
    self := left
  ),local,left outer
);
temp_lay1 := record
  unsigned6 linkid;
  string120 company_name;
  unsigned2 company_name_data_permits; 
end;
best_src_name_append_p := distribute(project(best_src_name_append,transform(temp_lay1,
  self.company_name_data_permits := BIPV2.mod_sources.src2bmap(left.name_source, left.name_vl_id),
  self := left)
),hash(linkid));
aggr_company_name_src := rollup(best_src_name_append_p,left.linkid=right.linkid and trim(left.company_name,all)=trim(right.company_name,all),TRANSFORM(temp_lay1,
  self.company_name_data_permits := LEFT.company_name_data_permits | RIGHT.company_name_data_permits;
  self := LEFT;
),local);
company_name_permits := join(
  distribute(best_src_name_append, hash(linkid)),
  distribute(aggr_company_name_src, hash(linkid)),
  left.linkid = right.linkid and trim(left.company_name,all) = trim(right.company_name,all),
  transform(
    best_company_name_l,
    self.company_name_data_permits := right.company_name_data_permits,
    self := left
  ),local
);
company_name_flat := dedup(sort(distribute(company_name_permits, hash(linkid)), linkid, company_name_data_permits, name_source, company_name_method, local), linkid, company_name_data_permits, name_source, local);
//--------append source, source_record_id, vl_id for company fein
source_fein := dedup(sort(distribute(company_names(company_fein <> ''), hash(linkid)),linkid, company_fein, source, source_record_id, vl_id, local) ,linkid, company_fein, source, /*source_record_id, vl_id,*/ local);
company_fein_flat := join(
  distribute(norm_fein, hash(linkid)),
  distribute(source_fein, hash(linkid)),
  left.linkid = right.linkid and trim(left.company_fein, left, right) = trim(right.company_fein, left, right),
  transform(
    best_company_fein_l,
    self.company_fein := trim(left.company_fein, left, right);
    self.fein_source := right.source;
    self.fein_source_record_id := right.source_record_id;
    self.fein_vl_id := right.vl_id,
    self := left
  ),local,left outer
);
//--------append county data
fips :=  dedup(sort(distribute(project(bip_business_header, {unsigned6 linkid,string10  prim_range,string2    predir, string28  prim_name, string4    addr_suffix, string2    postdir, string10 unit_desig, string8   sec_range, string5    zip, string4    zip4,  string25 p_city_name, string v_city_name, string2 fips_state,  string3 fips_county}), hash(linkid)),
                                                                   linkid, prim_range, predir,prim_name,addr_suffix, postdir,unit_desig, sec_range, zip, -zip4, -p_city_name, -v_city_name,  -fips_state, -fips_county, local),
                                                                         linkid, prim_range, predir,prim_name,addr_suffix, postdir,unit_desig, sec_range, zip, local);
append_fips := join(
  norm_address,
  fips,
  left.linkid = right.linkid and
  left.address_prim_range = right.prim_range and
  left.address_predir = right.predir and
  left.address_prim_name = right.prim_name and
  left.address_addr_suffix = right.addr_suffix and
  left.address_postdir = right.postdir and
  left.address_unit_desig = right.unit_desig and
  left.address_sec_range = right.sec_range and
  left.address_zip = right.zip,
  transform(
    best_company_address_l,
    self.address_p_city_name := right.p_city_name;
    self.address_v_city_name := right.v_city_name;
    self.address_zip4 := right.zip4;
    self.state_fips:= right.fips_state;
    self.county_fips := right.fips_county;
    self := left
  ),left outer
);
company_address_flat := join(
  append_fips,
  pFips2County,
  left.state_fips = right.state_fips and left.county_fips = right.county_fips,
  transform(
    best_company_address_l,
    self.county_name:= right.county_name;
    self := left
  ),lookup,left outer
);
//-------append company_incorporation_date
isYearOnlyDate := company_names_.company_incorporation_date%10000 = 0;
isYearMonthOnlyDate := company_names_.company_incorporation_date%100 = 0;
isValidIncDate := company_names_.company_incorporation_date >=17641029; // 17641029 per Tim Bernhard: As far as the oldest date – let’s just draw a line with 17641029… There are some older, still existing cos, but I’m using the Hartford Courant as my oldest, valid date.
company_inc_dt := dedup(sort(distribute(company_names_(isValidIncDate), hash(linkid)), linkid, isYearOnlyDate, isYearMonthOnlyDate, company_incorporation_date, local), linkid, local);


company_inc_dt_src := dedup(sort(join(
  distribute(company_inc_dt, hash(linkid)),
  distribute(company_names_, hash(linkid)),
  left.linkid = right.linkid and left.company_incorporation_date = right.company_incorporation_date,
  transform(
    recordof(company_inc_dt),
    self.company_incorporation_date := left.company_incorporation_date,
    self.source := right.source,
    self.source_record_id := right.source_record_id,
    self.vl_id := right.vl_id,
    self := left
  ),local
),linkid, company_incorporation_date, source,source_record_id, vl_id, local),linkid, company_incorporation_date, source,source_record_id, vl_id, local);
temp_lay2 := record
  unsigned6 linkid;
  unsigned2 company_incorporation_date_permits;
end;
company_inc_dt_src_p := distribute(project(company_inc_dt_src, transform(temp_lay2, self.company_incorporation_date_permits := BIPV2.mod_sources.src2bmap(left.source, left.vl_id), self := left)), hash(linkid));
aggr_company_inc_dt_src := rollup(company_inc_dt_src_p,left.linkid = right.linkid,transform(temp_lay2,
  self.company_incorporation_date_permits := LEFT.company_incorporation_date_permits | RIGHT.company_incorporation_date_permits;
  self := LEFT;
),local);
company_inc_date_flat := join(
  distribute(company_inc_dt_src, hash(linkid)),
  distribute(aggr_company_inc_dt_src, hash(linkid)),
  left.linkid = right.linkid,
  transform(
    best_company_incorporation_date_l,
    self.incorporation_date_source := left.source,
    self.company_incorporation_date_permits := right.company_incorporation_date_permits,
    self.incorporation_date_source_record_id := left.source_record_id,
    self.incorporation_date_vl_id  := left.vl_id,
    self.company_incorporation_date_method := 1,
    self := left
  ),local
);
//****Layouts for each component denormalized
company_name_base               := {BIPV2_Best.Layouts.linkids;DATASET(BIPV2_Best.Layouts.company_name_case_layout) company_name;};
company_address_base            := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.company_address_case_layout) company_address;};
company_phone_base              := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.company_phone_case_layout) company_phone;};
company_fein_base               := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.company_fein_case_layout) company_fein;};
company_url_base                := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.company_url_case_layout) company_url};
company_incorporation_date_base := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.company_incorporation_date_layout) company_incorporation_date;};
company_duns_number_base        := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.duns_number_case_layout) duns_number;};
sic_code_base                   := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.sic_code_case_layout) sic_code;};
naics_code_base                 := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.naics_code_case_layout) naics_code;};
dba_base                        := {UNSIGNED6 linkid;DATASET(BIPV2_Best.Layouts.dba_name_case_layout) dba_name;};
//****************Denormalize name
company_name_flat_ded := DEDUP(SORT(DISTRIBUTE(company_name_flat,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_name_grp      := GROUP(SORT(DISTRIBUTE(company_name_flat,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_name_base t_name_denorm(company_name_grp le,DATASET(RECORDOF(company_name_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.company_name_case_layout t_name(company_name_grp le,DATASET(RECORDOF(company_name_grp)) ri) := TRANSFORM
    BIPV2_Best.Layouts.Source t_sources_name (company_name_grp le) := TRANSFORM
      SELF.source := le.name_source;
      SELF.source_record_id  := le.name_source_record_id;
      SELF.vl_id  := le.name_vl_id;
    END;
    SELF.Sources := DEDUP(SORT(PROJECT(ri, t_sources_name(LEFT)), RECORD),ALL);
    SELF := le;
  END;
  SELF.company_name := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.company_name=RIGHT.company_name,GROUP,t_name(LEFT,ROWS(RIGHT))),RECORD),ALL),company_name_method)(company_name_method>0);
  SELF := le;
end;
name_denorm := DENORMALIZE(company_name_flat_ded,company_name_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_name_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize DBA
dba_flat_ded := DEDUP(SORT(DISTRIBUTE(norm_dba,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
dba_grp      := GROUP(SORT(DISTRIBUTE(norm_dba,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
dba_base t_dba_denorm(dba_grp le,DATASET(RECORDOF(dba_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.dba_name_case_layout t_dba(dba_grp le,DATASET(RECORDOF(dba_grp)) ri) := TRANSFORM 
    SELF := le;
  END;
  SELF.dba_name := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.dba_name=RIGHT.dba_name,GROUP,t_dba(LEFT, ROWS(RIGHT))),RECORD),ALL),dba_name_method)(dba_name_method>0);
  SELF := le;
end;
dba_denorm := DENORMALIZE(dba_flat_ded,dba_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_dba_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize Address
company_address_flat_ded := DEDUP(SORT(DISTRIBUTE(company_address_flat,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_address_grp      := GROUP(SORT(DISTRIBUTE(company_address_flat,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_address_base t_address_denorm(company_address_grp le,DATASET(RECORDOF(company_address_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.company_address_case_layout t_address (company_address_grp le,DATASET(RECORDOF(company_address_grp)) ri) := TRANSFORM
    SELF.company_prim_range := TRIM(le.address_prim_range,LEFT,RIGHT);
    SELF.company_predir := TRIM(le.address_predir,LEFT,RIGHT);
    SELF.company_prim_name := TRIM(le.address_prim_name,LEFT,RIGHT);
    SELF.company_addr_suffix := TRIM(le.address_addr_suffix,LEFT,RIGHT);
    SELF.company_postdir := TRIM(le.address_postdir,LEFT,RIGHT);
    SELF.company_unit_desig := TRIM(le.address_unit_desig,LEFT,RIGHT);
    SELF.company_sec_range :=  TRIM(le.address_sec_range,LEFT,RIGHT);
    SELF.company_p_city_name := TRIM(le.address_p_city_name,LEFT,RIGHT);
    SELF.company_st := TRIM(le.address_st,LEFT,RIGHT);
    SELF.company_zip5 := TRIM(le.address_zip,LEFT,RIGHT);
    SELF.company_zip4 := TRIM(le.address_zip4,LEFT,RIGHT);
    SELF.company_address_data_permits  := le.address_data_permits;
    SELF.company_address_method := le.address_method;
    SELF := le;
  end;
  self.company_address := sort(dedup(sort(denormalize(ri,ri,left.address_prim_range=right.address_prim_range and
    left.address_predir=right.address_predir and
    left.address_prim_name=right.address_prim_name and
    left.address_addr_suffix=right.address_addr_suffix and
    left.address_postdir=right.address_postdir and
    left.address_unit_desig=right.address_unit_desig and
    left.address_sec_range=right.address_sec_range and
    left.address_p_city_name=right.address_p_city_name and
    left.address_st=right.address_st  and
    left.address_zip=right.address_zip and
    left.address_zip4=right.address_zip4,GROUP,t_address(LEFT,ROWS(RIGHT))),RECORD),ALL),company_address_method);
  SELF := le;
end;
address_denorm := DENORMALIZE(company_address_flat_ded,company_address_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_address_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize Phone
company_phone_flat_ded := DEDUP(SORT(DISTRIBUTE(norm_phone,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_phone_grp      := GROUP(SORT(DISTRIBUTE(norm_phone,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_phone_base t_phone_denorm(company_phone_grp le,DATASET(RECORDOF(company_phone_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.company_phone_case_layout t_phone(company_phone_grp le,DATASET(RECORDOF(company_phone_grp)) ri) := TRANSFORM
    SELF := le;
  END;
  SELF.company_phone := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.company_phone=RIGHT.company_phone,GROUP,t_phone(LEFT,ROWS(RIGHT))),RECORD),ALL),company_phone_method)(company_phone_method>0);
  SELF := le;
END;
phone_denorm := DENORMALIZE(company_phone_flat_ded,company_phone_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_phone_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize Fein
company_fein_flat_ded := DEDUP(SORT(DISTRIBUTE(company_fein_flat,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_fein_grp      := GROUP(SORT(DISTRIBUTE(company_fein_flat,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_fein_base t_fein_denorm(company_fein_grp le,DATASET(RECORDOF(company_fein_grp)) ri) := transform
  BIPV2_Best.Layouts.company_fein_case_layout t_fein(company_fein_grp le,DATASET(RECORDOF(company_fein_grp)) ri) := TRANSFORM
    BIPV2_Best.Layouts.Source t_sources_fein(company_fein_grp le) := transform
      SELF.source := le.fein_source;
      SELF.source_record_id := le.fein_source_record_id;
      SELF.vl_id := le.fein_vl_id;
    END;
    SELF.Sources := DEDUP(SORT(PROJECT(ri,t_sources_fein(LEFT)),RECORD),ALL);
    SELF := le;
  END;
  SELF.company_fein := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.company_fein=RIGHT.company_fein,GROUP,t_fein(LEFT,ROWS(RIGHT))),RECORD),ALL),company_fein_method)(company_fein_method>0);
  SELF := le;
end;
fein_denorm := DENORMALIZE(company_fein_flat_ded,company_fein_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_fein_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize URL
company_url_flat_ded := DEDUP(SORT(DISTRIBUTE(norm_url,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_url_grp      := GROUP(SORT(DISTRIBUTE(norm_url,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_url_base t_url_denorm(company_url_grp le, DATASET(RECORDOF(company_url_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.company_url_case_layout t_url(company_url_grp le,DATASET(RECORDOF(company_url_grp)) ri) := TRANSFORM
    SELF.company_url := TRIM(le.company_url,LEFT,RIGHT);
    SELF := le;
  END;
  SELF.company_url := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.company_url=RIGHT.company_url,GROUP,t_url(LEFT,ROWS(RIGHT))),RECORD),ALL),company_url_method)(company_url_method>0);
  SELF := le;
end;
url_denorm := DENORMALIZE(company_url_flat_ded,company_url_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_url_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize Incorporaton Date
company_inc_date_flat_ded := DEDUP(SORT(DISTRIBUTE(company_inc_date_flat,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_inc_date_grp      := GROUP(SORT(DISTRIBUTE(company_inc_date_flat,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_incorporation_date_base t_inc_date_denorm(company_inc_date_grp le,DATASET(RECORDOF(company_inc_date_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.company_incorporation_date_layout t_inc_date(company_inc_date_grp le,DATASET(RECORDOF(company_inc_date_grp)) ri) := transform
    BIPV2_Best.Layouts.Source t_sources_inc_date (company_inc_date_grp le) := TRANSFORM
      SELF.source := le.incorporation_date_source;
      SELF.source_record_id  := le.incorporation_date_source_record_id;
      SELF.vl_id  := le.incorporation_date_vl_id;
    END;
    SELF.Sources := DEDUP(SORT(PROJECT(ri,t_sources_inc_date(LEFT)),RECORD),ALL);
    SELF := le;
  end;
  self.company_incorporation_date := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.company_incorporation_date=RIGHT.company_incorporation_date,GROUP,t_inc_date(LEFT, ROWS(RIGHT))),RECORD),ALL),company_incorporation_date_method)(company_incorporation_date > 0);
  SELF := le;
END;
inc_date_denorm := DENORMALIZE(company_inc_date_flat_ded,company_inc_date_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_inc_date_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize duns Number
duns_number_flat_ded := DEDUP(SORT(DISTRIBUTE(norm_duns,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
duns_number_grp      := GROUP(SORT(DISTRIBUTE(norm_duns,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
company_duns_number_base t_duns_denorm(duns_number_grp le,DATASET(RECORDOF(duns_number_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.duns_number_case_layout t_duns(duns_number_grp le,DATASET(RECORDOF(duns_number_grp)) ri) := TRANSFORM
    SELF := le;
  END;
  SELF.duns_number := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.duns_number=RIGHT.duns_number,GROUP,t_duns(LEFT, ROWS(RIGHT))),RECORD),ALL),duns_number_method)(duns_number_method>0);
  SELF := le;
end;
duns_denorm := DENORMALIZE(duns_number_flat_ded,duns_number_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_duns_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize SIC code
sic_code_flat_ded := DEDUP(SORT(DISTRIBUTE(norm_sic,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
sic_code_grp      := GROUP(SORT(DISTRIBUTE(norm_sic,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
sic_code_base t_sic_denorm(sic_code_grp le,DATASET(RECORDOF(sic_code_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.sic_code_case_layout t_sic(sic_code_grp le,DATASET(RECORDOF(sic_code_grp)) ri) := TRANSFORM
    SELF := le;
  END;
  SELF.sic_code := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.company_sic_code1=RIGHT.company_sic_code1,GROUP,t_sic(LEFT, ROWS(RIGHT))),RECORD),ALL),company_sic_code1_method)(company_sic_code1_method>0);
  SELF := le;
end;
sic_denorm := DENORMALIZE(sic_code_flat_ded,sic_code_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_sic_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//****************Denormalize NAICS code
naics_code_flat_ded := DEDUP(SORT(DISTRIBUTE(norm_naics,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
naics_code_grp      := GROUP(SORT(DISTRIBUTE(norm_naics,HASH(linkid)),linkid,LOCAL),linkid,LOCAL);
naics_code_base t_naics_denorm(naics_code_grp le,DATASET(RECORDOF(naics_code_grp)) ri) := TRANSFORM
  BIPV2_Best.Layouts.naics_code_case_layout t_naics(naics_code_grp le,DATASET(RECORDOF(naics_code_grp)) ri) := TRANSFORM
    SELF := le;
  END;
  SELF.naics_code := SORT(DEDUP(SORT(DENORMALIZE(ri,ri,LEFT.company_naics_code1=RIGHT.company_naics_code1,GROUP,t_naics(LEFT, ROWS(RIGHT))),RECORD),ALL),company_naics_code1_method)(company_naics_code1_method>0);
  SELF := le;
end;
naics_denorm := DENORMALIZE(naics_code_flat_ded,naics_code_grp,LEFT.linkid=RIGHT.linkid,GROUP,t_naics_denorm(LEFT,ROWS(RIGHT)),LOCAL);
//---------Join all componets to base layout
linkids := project(bip_business_header, {BIPV2_Best.Layouts.linkids, unsigned6 company_bdid});
linkids_unq := dedup(sort(distribute(linkids, hash(linkid)), linkid, local), linkid, local);
linkids_nm := join(linkids_unq, name_denorm, left.linkid = right.linkid, left outer);
nm_addr := join(linkids_nm, address_denorm,left.linkid = right.linkid,left outer,local);
nm_addr_ph:= join(nm_addr, phone_denorm,left.linkid = right.linkid,left outer,local);
nm_addr_ph_fein:= join(nm_addr_ph, fein_denorm,left.linkid = right.linkid,left outer,local);
nm_addr_ph_fein_url:= join(nm_addr_ph_fein, url_denorm,left.linkid = right.linkid,left outer,local);
nm_addr_ph_fein_url_dunn:= join(nm_addr_ph_fein_url, duns_denorm,left.linkid = right.linkid,left outer,local);
nm_with_sic:=JOIN(nm_addr_ph_fein_url_dunn,sic_denorm,left.linkid = right.linkid,left outer,local);
nm_with_naics:=JOIN(nm_with_sic,naics_denorm,left.linkid = right.linkid,left outer,local);
nm_with_dba:=join(nm_with_naics,dba_denorm,left.linkid = right.linkid,left outer,local);
final_base := join(nm_with_dba, inc_date_denorm,left.linkid = right.linkid,transform(BIPV2_Best.Layouts.base,self := left,self := right;SELF:=[];),left outer,local);

// output(norm_dba, named('norm_dba'));
// output(dba_flat_ded, named('dba_flat_ded'));
// output(dba_grp, named('dba_grp'));
// output(dba_denorm, named('dba_denorm'));
// output(nm_with_dba, named('nm_with_dba'));

return final_base;
endmacro;