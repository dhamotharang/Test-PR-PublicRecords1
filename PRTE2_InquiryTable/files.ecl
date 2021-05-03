Export files:=Module

EXPORT Inquiry_1 := DATASET(constants.input_file_1, in_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT Inquiry_2 := DATASET(constants.input_file_2, in_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT Inquiry_3 := DATASET(constants.input_file_3, in_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

Export Inquiry_In:=Inquiry_1 + Inquiry_2 + Inquiry_3;

EXPORT Inquiry_base := DATASET(constants.Base_Inquiry, base_layout, FLAT );

Export ds_linkid:=project(inquiry_base,
Transform(linkid_layout,
self.bus_intel.primary_market_code:=left.bus_intel_primary_market_code;
self.bus_intel.secondary_market_code:=left.bus_intel_secondary_market_code;
self.bus_intel.industry_1_code :=left.bus_intel_industry_1_code;
self.bus_intel.industry_2_code:=left.bus_intel_industry_2_code;
self.bus_intel.sub_market :=left.bus_intel_sub_market;
self.bus_intel.vertical :=left.bus_intel_vertical;
self.bus_intel.use:=left.bus_intel_use;
self.bus_intel.industry :=left.bus_intel_industry;

self.bus_q.cname:=left.bus_q_cname;

self.bus_q.address:=left.bus_q_address;
self.bus_q.city:=left.bus_q_city;
self.bus_q.state:=left.bus_q_state;
self.bus_q.zip:=left.bus_q_zip;

self.bus_q.company_phone:=left.bus_q_company_phone;
self.bus_q.ein:=left.bus_q_ein;
self.bus_q.prim_range:=left.bus_q10_prim_range;
self.bus_q.predir:=left.bus_q2_predir;
self.bus_q.prim_name:=left.bus_q28_prim_name;
self.bus_q.addr_suffix:=left.bus_q4_addr_suffix;
self.bus_q.postdir:=left.bus_q2_postdir;
self.bus_q.unit_desig:=left.bus_q10_unit_desig;
self.bus_q.sec_range:=left.bus_q8_sec_range;
self.bus_q.v_city_name:=left.bus_q25_v_city_name;
self.bus_q.st:=left.bus_q2_st;
self.bus_q.zip5:=left.bus_q5_zip5;
self.bus_q.zip4:=left.bus_q4_zip4;
self.bus_q.addr_rec_type:=left.bus_q2_addr_rec_type;
self.bus_q.fips_state:=left.bus_q2_fips_state;
self.bus_q.fips_county:=left.bus_q3_fips_county;
self.bus_q.geo_lat:=left.bus_q10_geo_lat;
self.bus_q.geo_long:=left.bus_q11_geo_long;
self.bus_q.geo_blk:=left.bus_q7_geo_blk;
self.bus_q.geo_match:=left.bus_q1_geo_match;
self.bus_q.err_stat:=left.bus_q4_err_stat;
self.bus_q.appended_bdid:=left.appended_bdid;
self.bus_q.appended_ein:=left.link_FEIN;
self.bus_q.bus_start_date:=left.Link_inc_date;

self.permissions.glb_purpose:=left.permissions_glb_purpose;
self.permissions.dppa_purpose:=left.permissions_dppa_purpose;

self.permissions.fcra_purpose:=left.permissions_fcra_purpose;

self.search_info.datetime:=left.search_info_datetime;
self.search_info.transaction_id:=left.search_info_transaction_id;
self.search_info.sequence_number:=left.search_info_sequence_number;
self.search_info.method:=left.search_info_method;
self.search_info.product_code:=left.search_info_product_code;
self.search_info.transaction_type:=left.search_info_transaction_type;
self.search_info.function_description:=left.search_info_function_description;
self.search_info.ipaddr:=left.search_info_ipaddr;

self.allow_flags.allowflags:=(unsigned8)left.allow_flags_allowflags;

self.ccpa.global_sid:=left.ccpa_global_sid;

self.person_q.full_name:=left.person_q_full_name;

self.person_q.first_name:=left.person_q_first_name;
self.person_q.middle_name :=left.person_q_middle_name;
self.person_q.last_name :=left.person_q_last_name;

self.person_q.fname:=left.person_q_fname;
self.person_q.mname :=left.person_q_mname;
self.person_q.lname :=left.person_q_lname;

self.person_q.address:=left.person_q_address;
self.person_q.city:=left.person_q_city;
self.person_q.state:=left.person_q_state;
self.person_q.zip:=left.person_q_zip;
self.person_q.personal_phone := left.person_q_personal_phone;
self.person_q.work_phone:= left.person_q_work_phone;
self.person_q.dob:=left.person_q_dob;
self.person_q.email_address:=left.person_q_email_address;
self.person_q.ssn :=left.person_q_ssn;
self.person_q.linkid:=left.person_q_linkid;
self.person_q.ipaddr:=left.person_q_ipaddr;	

 self.person_q.prim_range:=left.person_q_prim_range;
self.person_q.predir:=left.person_q_predir;
self.person_q.prim_name:=left.person_q_prim_name;
self.person_q.addr_suffix:=left.person_q_addr_suffix;
self.person_q.postdir:=left.person_q_postdir;
self.person_q.unit_desig:=left.person_q_unit_desig;
self.person_q.sec_range:=left.person_q_sec_range;
self.person_q.v_city_name:=left.person_q_v_city_name;
self.person_q.st:=left.person_q_st;
self.person_q.zip5:=left.person_q_zip5;
self.person_q.zip4:=left.person_q_zip4;
self.person_q.addr_rec_type:=left.person_q_addr_rec_type;
self.person_q.fips_state:=left.person_q_fips_state;
self.person_q.fips_county:=left.person_q_fips_county;
self.person_q.geo_lat:=left.person_q_geo_lat;
self.person_q.geo_long:=left.person_q_geo_long;
self.person_q.geo_blk:=left.person_q_geo_blk;
self.person_q.geo_match:=left.person_q_geo_match;
self.person_q.err_stat:=left.person_q_err_stat;				

Self:=left;
self := []; 
));

Export ds_fein :=project(ds_linkid(bus_q.cname !=''),
Transform(fein_layout,
self.appended_ein:=left.bus_q.appended_ein;
self:=left;
self := [];
));

Export ds_did :=project(ds_linkid(bus_q.cname =''),
Transform(did_layout,
self.s_did:=left.person_q.appended_adl;
self:=left;
self := [];
));

Export ds_address :=project(ds_linkid(bus_q.cname =''),
Transform(address_layout,
self.zip:='- ' + left.person_q.zip5[1..3];
self.prim_name:=left.person_q.prim_name;
self.prim_range:=left.person_q.prim_range;
self.sec_range:=left.person_q.sec_range;
self:=left;
self := [];
));

Export ds_phone :=project(ds_linkid(bus_q.cname =''),
Transform(phone_layout,
self.phone10:= left.person_q.personal_phone;
self:=left;
self := [];
));

Export ds_email :=project(ds_linkid(bus_q.cname =''),
Transform(email_layout,
self.email_address:= left.person_q.email_address;
self:=left;
self := [];
));

Export ds_ssn :=project(ds_linkid(bus_q.cname =''),
Transform(ssn_layout,
self.ssn:= left.person_q.ssn;
self:=left;
self := [];
));

Export ds_transaction_id :=project(ds_linkid,
Transform(transaction_id_layout,
self.transaction_id:= left.search_info.transaction_id;
self.appended_adl:=left.person_q.appended_adl;
self.datetime:=left.search_info.datetime;
self.industry :=left.bus_intel.industry;
self.vertical :=left.bus_intel.vertical;
self.sub_market :=left.bus_intel.sub_market;
self.function_description:=left.search_info.function_description;
self.product_code:=left.search_info.product_code;
self.use:=left.bus_intel.use;
self.sequence_number:=left.search_info.sequence_number;
self:=left;
self := [];
));

Export ds_fcra_address :=project(ds_linkid(bus_q.cname =''),
Transform(fcra_address_layout,
self.zip:='-' + left.person_q.zip5[1..4];
self.person_q.zip:='-' + left.person_q.zip5[1..4];
self.prim_name:=left.person_q.prim_name;
self.prim_range:=left.person_q.prim_range;
self.sec_range:=left.person_q.sec_range;
self:=left;
self := [];
));

Export ds_fcra_did :=project(ds_linkid(bus_q.cname =''),
Transform(fcra_did_layout,
self.appended_adl:=left.person_q.appended_adl;
self:=left;
self := [];
));

Export ds_fcra_ssn:=project(ds_linkid(bus_q.cname =''),
Transform(fcra_ssn_layout,
self.ssn:=left.person_q.ssn;
self:=left;
self := [];
));

Export ds_fcra_phone:=project(ds_linkid(bus_q.cname =''),
Transform(fcra_phone_layout,
self.phone10:=left.person_q.personal_phone;
self:=left;
self := [];
));

Export ds_fcra_login:=project(ds_linkid,
Transform(fcra_login_layout,
self.s_company_id:=left.mbs.company_id;
self.s_product_id:='0';
self.vertical:=left.bus_intel.vertical;
self.industry:=left.bus_intel.industry;
self.sub_market:=left.bus_intel.sub_market;

self:=left;
self := [];
));

Export ds_ipaddr        := dataset([],ipaddr_layout);
Export ds_name          := dataset([],name_layout);
Export ds_bill          := dataset([],bill_layout);
Export ds_vertical      := dataset([],fcra_vertical_layout);

end;