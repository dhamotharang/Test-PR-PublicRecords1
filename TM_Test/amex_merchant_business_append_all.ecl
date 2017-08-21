import Corp, Gong;

amex_merchant_init := project(TM_Test.amex_merchant_prep,
                              transform(Layout_Amex_Merchant_Business_Append, self := left));
						
amex_merchant_init_dist := distribute(amex_merchant_init(bdid <> 0), hash(bdid));

// Determine Organizational Type from Corporate Data
layout_corp_type_append := record
amex_merchant_init_dist.bdid;
string2  corp_state_origin := '';
string60 corp_org_type := '';
string1 corp_mkt_flag := 'N';
end;

corp_type_init := table(amex_merchant_init_dist, layout_corp_type_append);

// Join to corp base to determine business type
corp_base := Corp.File_Corp_Base(record_type =  'C', bdid <> 0);

layout_corp_type := record
corp_base.bdid;
corp_base.corp_state_origin;
corp_base.corp_orig_org_structure_desc;
end;

//set_corp_states_mkt_restricted := ['IL','NM','KS','WA'];
set_corp_states_mkt_restricted := [];

corp_base_types := table(corp_base(corp_orig_org_structure_desc <> ''), layout_corp_type);
corp_base_types_dedup := dedup(corp_base_types, all);
corp_base_types_dist := distribute(corp_base_types_dedup, hash(bdid));

corp_business_type := join(corp_type_init,
                           corp_base_types_dist,
					  left.bdid = right.bdid,
					  transform(layout_corp_type_append, self.corp_org_type := right.corp_orig_org_structure_desc,
					                                     self := left),
					  left outer,
					  local);
					  
corp_business_type_sort := sort(corp_business_type, bdid, if(corp_state_origin not in set_corp_states_mkt_restricted, 0, 1), local);
corp_business_type_dedup := dedup(corp_business_type_sort, bdid, local);

corp_business_type_filtered := project(corp_business_type_dedup,
                                       transform(layout_corp_type_append, self.corp_mkt_flag := if(left.corp_state_origin in  set_corp_states_mkt_restricted, 'Y', 'N'),
							                                       self.corp_org_type := if(left.corp_state_origin in  set_corp_states_mkt_restricted, '', left.corp_org_type),
														    self := left));

// Append corp org type
Layout_Amex_Merchant_Business_Append AppendCorpInfo(Layout_Amex_Merchant_Business_Append l, layout_corp_type_append r) := transform
self.corp_org_type := r.corp_org_type;
self.corp_mkt_flag := r.corp_mkt_flag;
self := l;
end;

amex_merchant_corp := join(amex_merchant_init_dist,
                           corp_business_type_filtered,
			            left.bdid = right.bdid,
			            AppendCorpInfo(left, right),
			            left outer,
			            local);

// Append up to 3 SIC codes
// Append SIC Codes
layout_sic_code_append := record
amex_merchant_corp.bdid;
string4  SIC_Code1 := '';
string4  SIC_Code2 := '';
string4  SIC_Code3 := '';
end;

sic_code_init := table(amex_merchant_corp, layout_sic_code_append);
sic_code_init_dedup := dedup(sic_code_init, bdid, local);

// Cannot uses SIC codes from some sources due to marketing restrictions
//bh_sic := Business_Header.BH_BDID_SIC(source not in ['BR', 'D', 'Y', 'IA', 'ID', 'IF', 'II', 'W', 'DC', 'SK', 'LP']);
bh_sic := Business_Header.BH_BDID_SIC;
bh_sic_dist := distribute(bh_sic, hash(bdid));

// Select SIC Codes
bh_sic_select := join(bh_sic_dist,
                      sic_code_init_dedup,
				  left.bdid = right.bdid,
				  transform(Business_Header.Layout_SIC_Code, self := left),
				  local);

bh_sic_select_sort := sort(bh_sic_select, bdid, Business_Header.Map_Source_Hierarchy(source), local);

// Append up to 3 SIC codes
layout_sic_code_append AppendSICCOdes(layout_sic_code_append l, Business_Header.Layout_SIC_Code r, unsigned1 cnt) := transform
self.SIC_Code1 := if(cnt = 1, r.sic_code, l.SIC_Code1);
self.SIC_Code2 := if(cnt = 2, r.sic_code, l.SIC_Code2);
self.SIC_Code3 := if(cnt = 3, r.sic_code, l.SIC_Code3);
self := l;
end;

sic_codes := denormalize(sic_code_init_dedup,
		               bh_sic_select_sort,
					left.bdid = right.bdid,
					AppendSICCodes(left, right, counter),
					left outer,
					local);

amex_merchant_sic_codes := join(amex_merchant_corp,
                                sic_codes,
						  left.bdid = right.bdid,
						  transform(Layout_Amex_Merchant_Business_Append,
							           self.SIC_Code1 := right.SIC_Code1,
							           self.SIC_Code2 := right.SIC_Code2,
							           self.SIC_Code3 := right.SIC_Code3,
									 self := left),
						  left outer,
						  local);

// Determine if input phone is active
amex_merchant_sic_codes_all := amex_merchant_sic_codes + amex_merchant_init(bdid = 0);

layout_input_phone_active := record
amex_merchant_sic_codes_all.phone10;
string1 input_phone_active := '';
end;

amex_merchant_phone_active_init := table(amex_merchant_sic_codes_all(phone10 <> ''), layout_input_phone_active);
amex_merchant_phone_active_init_dist := distribute(dedup(amex_merchant_phone_active_init, all), hash(phone10));

gf := Gong.File_Gong_History_Full(bdid <> 0, phone10 <> '');

layout_phone_info := record
gf.phone10;
gf.current_record_flag;  
gf.deletion_date;
gf.disc_cnt6;
gf.disc_cnt12;
gf.disc_cnt18;
end;

gf_phone_info := table(gf, layout_phone_info);
gf_phone_info_dist := distribute(gf_phone_info, hash(phone10));
gf_phone_info_sort := sort(gf_phone_info_dist, phone10, if(current_record_flag = 'Y', 0, 1), local);
gf_phone_info_dedup := dedup(gf_phone_info_sort, phone10, local);

amex_merchant_phone_active_append := join(gf_phone_info_dedup,
                                          amex_merchant_phone_active_init_dist,
								  left.phone10 = right.phone10,
								  transform(layout_input_phone_active, self.input_phone_active := if(left.phone10 <> '', if(left.current_record_flag = 'Y', 'Y', 'N'), ''),
								                                       self := right),
								  right outer,
								  local);
								  
// Append active phone flag
amex_merchant_phone_active := join(amex_merchant_sic_codes_all(phone10 <> ''),
                                   amex_merchant_phone_active_append,
						     left.phone10 = right.phone10,
						     transform(Layout_Amex_Merchant_Business_Append,
							           self.input_phone_active := right.input_phone_active,
									 self := left),
						     left outer,
						     local);

amex_merchant_phone_active_all := amex_merchant_phone_active + amex_merchant_sic_codes_all(phone10 = '');

// Append any additional active phone numbers for bdid
bh := Business_Header.File_Business_Header_MktApp;

layout_bdid_phone := record
bh.bdid;
string10 phone10 := if(bh.phone = 0, '', intformat(bh.phone, 10, 1));
string1 phone_active := '';
end;

bh_phones := table(bh, layout_bdid_phone);
bh_phones_dedup := dedup(bh_phones, all);
bh_phones_dist := distribute(bh_phones_dedup, hash(phone10));

bh_phones_active_append := join(gf_phone_info_dedup,
                                bh_phones_dist,
						  left.phone10 = right.phone10,
						  transform(layout_bdid_phone, self.phone_active := if(left.phone10 <> '', if(left.current_record_flag = 'Y', 'Y', 'N'), ''),
								                     self := right),
						  right outer,
						  local);

// Exclude any phone numbers already reported as Best for the BDID
layout_bdid_best_phone := record
amex_merchant_phone_active_all.bdid;
amex_merchant_phone_active_all.best_phone;
end;

amex_merchant_best_phone := table(amex_merchant_phone_active_all(phone10 <> ''), layout_bdid_best_phone);
amex_merchant_best_phone_dist := distribute(dedup(amex_merchant_best_phone, all), hash(best_phone));

bh_phones_active_append_new := join(bh_phones_active_append,
                                    amex_merchant_best_phone_dist,
							 left.phone10 = right.best_phone,
							 transform(layout_bdid_phone, self := left),
							 left only,
							 local);
							 
// Now add these phones to base
layout_phone_append := record
amex_merchant_phone_active_all.bdid;
string10 additional_phone2 := '';
string10 additional_phone3 := '';
end;

additional_phone_append := table(amex_merchant_phone_active_all(bdid <> 0), layout_phone_append);
additional_phone_append_dist := distribute(dedup(additional_phone_append, all), hash(bdid));

// Append up to 2 additional active phones
layout_phone_append AppendAdditionalPhones(layout_phone_append l, layout_bdid_phone r, unsigned1 cnt) := transform
self.additional_phone2 := if(cnt = 1, r.phone10, l.additional_phone2);
self.additional_phone3 := if(cnt = 2, r.phone10, l.additional_phone3);
self := l;
end;

additional_phones := denormalize(additional_phone_append_dist,
		                       bh_phones_active_append_new,
					        left.bdid = right.bdid,
					        AppendAdditionalPhones(left, right, counter),
					        left outer,
					        local);
						   
amex_merchant_additional_phones := join(distribute(amex_merchant_phone_active_all(bdid <> 0), hash(bdid)),
                                        additional_phones,
						          left.bdid = right.bdid,
						          transform(Layout_Amex_Merchant_Business_Append,
							           self.additional_phone2 := right.additional_phone2,
							           self.additional_phone3 := right.additional_phone3,
									 self := left),
						          left outer,
						          local);
								
amex_merchant_additional_phones_all := amex_merchant_additional_phones + amex_merchant_phone_active_all(bdid = 0);

amex_merchant_business_append_sort := sort(amex_merchant_additional_phones_all, rid, seq);

export amex_merchant_business_append_all := amex_merchant_business_append_sort : persist('TMTEST::amex_merchant_business_append_all');
