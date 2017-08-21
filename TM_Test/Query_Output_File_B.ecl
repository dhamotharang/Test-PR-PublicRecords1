import Business_Header, Risk_Indicators, Corp, DCA;

#option('outputLimit', 50);

// Output File B with appended data
amex_iclic_test_base := TM_Test.amex_iclic_test_group;

// Append phone type
layout_phone_append := record
amex_iclic_test_base.seq;
amex_iclic_test_base.phone10;
string2 nxx_type := '';
string20 phone_type := '';
end;

phone_type_init := table(amex_iclic_test_base(phone10 <> ''), layout_phone_append);
phone_type_init_dist := distribute(phone_type_init, hash(phone10[1..7]));

// Join to telcordia file to get nxx_type
tpm := Risk_Indicators.File_Telcordia_tpm;
tpm_dist := distribute(tpm, hash((string7)(npa+nxx+tb)));

layout_phone_append AppendPhoneType(layout_phone_append l, tpm r) := transform
self.nxx_type := r.nxx_type;
self.phone_type := map(Risk_Indicators.PRIIPhoneRiskFlag(l.phone10).isPOTS(r.nxx_type) => 'Standard Service',
                       Risk_Indicators.PRIIPhoneRiskFlag(l.phone10).isCellular(r.nxx_type) => 'Cellular',
				   Risk_Indicators.PRIIPhoneRiskFlag(l.phone10).isMobile(r.nxx_type) => 'Mobile',
				   Risk_Indicators.PRIIPhoneRiskFlag(l.phone10).isPaging(r.nxx_type) => 'Paging',
				   Risk_Indicators.PRIIPhoneRiskFlag(l.phone10).isOtherNonPOTS(r.nxx_type) => 'Other Non-Standard',
				   Risk_Indicators.PRIIPhoneRiskFlag(l.phone10).isPayPhone(r.nxx_type) => 'Pay Phone',
				   Risk_Indicators.PRIIPhoneRiskFlag(l.phone10).isPCS(r.nxx_type) => 'PCS',
				   Risk_Indicators.PRIIPhoneRiskFlag(l.phone10).isSpecialNumber(r.nxx_type) => 'Special Number',
				   '');
self := l;
end;

phone_type_nxx := join(phone_type_init_dist,
                    tpm_dist,
				left.phone10[1..3] = right.npa and
				left.phone10[4..6] = right.nxx and
				left.phone10[7] = right.tb,
				AppendPhoneType(left, right),
				left outer,
				keep(1),
				local);
				
// Determine Type of Business from Corporate Data
layout_corp_type_append := record
amex_iclic_test_base.seq;
amex_iclic_test_base.bdid;
string60 Type_Of_Business := '';
end;

corp_type_init := table(amex_iclic_test_base(bdid <> 0), layout_corp_type_append);
corp_type_init_dist := distribute(corp_type_init, hash(bdid));

// Join to corp base to determine business type
corp_base := Corp.File_Corp_Base(record_type =  'C');

layout_corp_type := record
corp_base.bdid;
corp_base.corp_orig_org_structure_desc;
end;

corp_base_types := table(corp_base(corp_orig_org_structure_desc <> ''), layout_corp_type);
corp_base_types_dedup := dedup(corp_base_types, all);
corp_base_types_dist := distribute(corp_base_types_dedup, hash(bdid));

corp_business_type := join(corp_type_init_dist,
                           corp_base_types_dist,
					  left.bdid = right.bdid,
					  transform(layout_corp_type_append, self.Type_Of_Business := right.corp_orig_org_structure_desc, self := left),
					  left outer,
					  keep(1),
					  local);
					  
// Append SIC Codes
layout_sic_code_append := record
amex_iclic_test_base.seq;
amex_iclic_test_base.bdid;
string8  SIC_Code1 := '';
string8  SIC_Code2 := '';
string8  SIC_Code3 := '';
end;

sic_code_init := table(amex_iclic_test_base(bdid <> 0), layout_sic_code_append);
sic_code_init_dist := distribute(sic_code_init, hash(bdid));

bh_sic := Business_Header.BH_BDID_SIC;

// Select SIC Codes
bh_sic_select := join(bh_sic,
                      sic_code_init,
				  left.bdid = right.bdid,
				  transform(Business_Header.Layout_SIC_Code, self := left),
				  lookup);

bh_sic_select_dist := distribute(bh_sic_select, hash(bdid));
bh_sic_select_dist_sort := sort(bh_sic_select_dist, bdid, Business_Header.Map_Source_Hierarchy(source), local);

// Append up to 3 SIC codes

layout_sic_code_append AppendSICCOdes(layout_sic_code_append l, Business_Header.Layout_SIC_Code r, unsigned1 cnt) := transform
self.SIC_Code1 := if(cnt = 1, r.sic_code, l.SIC_Code1);
self.SIC_Code2 := if(cnt = 2, r.sic_code, l.SIC_Code2);
self.SIC_Code3 := if(cnt = 3, r.sic_code, l.SIC_Code3);
self := l;
end;

sic_codes := denormalize(sic_code_init_dist,
		               bh_sic_select_dist_sort,
					left.bdid = right.bdid,
					AppendSICCodes(left, right, counter),
					left outer,
					local);

// Append Sales and Employee Counts from DCA file
layout_dca_append := record
amex_iclic_test_base.seq;
amex_iclic_test_base.bdid;
string9  Number_Of_Employees := '';
string12 Annual_Sales := '';
end;

dca_append_init := table(amex_iclic_test_base(bdid <> 0), layout_dca_append);
dca_append_init_dist := distribute(dca_append_init, hash(bdid));

dca_base := DCA.File_DCA_Base(bdid <> 0);

layout_dca_data := record
dca_base.bdid;
dca_base.EMP_NUM;
dca_base.Sales;
end;

dca_data_init := table(dca_base, layout_dca_data);
dca_data_dist := distribute(dca_data_init, hash(bdid));

dca_append := join(dca_append_init_dist,
                   dca_data_dist,
			    left.bdid = right.bdid,
			    transform(layout_dca_append, self.Number_Of_Employees := right.EMP_NUM,
			                                 self.Annual_Sales := right.Sales,
									   self := left),
			    keep(1),
			    left outer,
			    local);

// Append CEO title from Business Contacts
bc_base := Business_Header.File_Business_Contacts(bdid <> 0, company_title <> '');

layout_contact := record
bc_base.bdid;
bc_base.did;
bc_base.fname;
bc_base.mname;
bc_base.lname;
bc_base.name_suffix;
bc_base.name_score;
bc_base.company_title;
unsigned1 title_rank := ut.TitleRank(bc_base.company_title);
end;

contacts_init := table(bc_base, layout_contact);
contacts_init_dist := distribute(contacts_init, hash(bdid));

// Match CEO Name To Business Caontacts
layout_ceo_append := record
amex_iclic_test_base.seq;
amex_iclic_test_base.bdid;
amex_iclic_test_base.did;
amex_iclic_test_base.fname;
amex_iclic_test_base.mname;
amex_iclic_test_base.lname;
amex_iclic_test_base.name_suffix;
string35 CEO_Title := '';
unsigned1 title_rank := 30;
end;

ceo_append_init := table(amex_iclic_test_base(bdid <> 0, CEO_Name <> ''), layout_ceo_append);
ceo_append_dist := distribute(ceo_append_init, hash(bdid));

layout_ceo_append AppendCEOTitle(contacts_init_dist l, ceo_append_dist r) := transform
self.CEO_Title := l.company_title;
self.title_rank := l.title_rank;
self := r;
end;

ceo_append_title := join(contacts_init_dist,
                         ceo_append_dist,
					left.bdid = right.bdid and
                                ((left.did <> 0 and right.did <> 0 and left.did = RIGHT.did)
							     OR
							     (
								  ut.NNEQ(left.name_suffix, right.name_suffix) and
								  ut.NameMatch(left.fname, left.mname, left.lname,
								  right.fname, right.mname, right.lname) < 3
							      )),					
                         AppendCEOTitle(left, right),
					local);
					
ceo_append_sort := sort(ceo_append_title, bdid, seq, title_rank, local);
ceo_append := dedup(ceo_append_sort, bdid, seq, local);

// Append Top Executive
layout_exec_append := record
amex_iclic_test_base.seq;
amex_iclic_test_base.bdid;
amex_iclic_test_base.did;
amex_iclic_test_base.fname;
amex_iclic_test_base.mname;
amex_iclic_test_base.lname;
amex_iclic_test_base.name_suffix;
string60 Executive_Name := '';
string35 Executive_Title := '';
unsigned1 title_rank := 30;
end;

exec_append_init := table(amex_iclic_test_base(bdid <> 0), layout_exec_append);
exec_append_dist := distribute(exec_append_init, hash(bdid));

os(string s) := if(s = '', '', trim(s) + ' ');

layout_exec_append AppendExec(contacts_init_dist l, exec_append_dist r) := transform
self.fname := l.fname;
self.mname := l.mname;
self.lname := l.lname;
self.name_suffix := l.name_suffix;
self.Executive_Name := os(l.fname) + os(l.mname) + os(l.lname) + os(l.name_suffix);
self.Executive_Title := l.company_title;
self.title_rank := l.title_rank;
self := r;
end;

exec_append_name := join(contacts_init_dist(/*ut.TitleRank(company_title) <= 6*/),
                         exec_append_dist,
					left.bdid = right.bdid and
                                not ((left.did <> 0 and right.did <> 0 and left.did = RIGHT.did)
							     OR
							     (
								  ut.NNEQ(left.name_suffix, right.name_suffix) and
								  ut.NameMatch(left.fname, left.mname, left.lname,
								  right.fname, right.mname, right.lname) < 3
							      )),					
                         AppendExec(left, right),
					local);
					
exec_append_sort := sort(exec_append_name, bdid, seq, title_rank, local);
exec_append := dedup(exec_append_sort, bdid, seq, local);

// Append data to original file by seq
amex_iclic_append_phone_type := join(amex_iclic_test_base,
                                     phone_type_nxx,
							  left.seq = right.seq,
							  transform(TM_Test.Layout_Amex_iCLIC_Test_Base_Append,
							            self.phone_type := right.phone_type,
									  self := left),
							  left outer,
							  hash);
							  
amex_iclic_append_business_type := join(amex_iclic_append_phone_type,
                                        corp_business_type,
							     left.seq = right.seq,
							     transform(TM_Test.Layout_Amex_iCLIC_Test_Base_Append,
							                self.Type_Of_Business := right.Type_Of_Business,
									      self := left),
							     left outer,
							     hash);

amex_iclic_append_sic_codes := join(amex_iclic_append_business_type,
                                    sic_codes,
							 left.seq = right.seq,
							 transform(TM_Test.Layout_Amex_iCLIC_Test_Base_Append,
							           self.SIC_Code1 := right.SIC_Code1,
							           self.SIC_Code2 := right.SIC_Code2,
							           self.SIC_Code3 := right.SIC_Code3,
									 self := left),
							 left outer,
							 hash);

amex_iclic_append_dca_data := join(amex_iclic_append_sic_codes,
                                   dca_append,
							left.seq = right.seq,
							transform(TM_Test.Layout_Amex_iCLIC_Test_Base_Append,
							          self.Number_Of_Employees := right.Number_Of_Employees,
							          self.Annual_Sales := right.Annual_Sales,
									self := left),
							left outer,
							hash);

amex_iclic_append_ceo_title := join(amex_iclic_append_dca_data,
                                    ceo_append,
							 left.seq = right.seq,
							 transform(TM_Test.Layout_Amex_iCLIC_Test_Base_Append,
							           self.CEO_Title := right.CEO_Title,
									 self := left),
							 left outer,
							 hash);

amex_iclic_append_exec := join(amex_iclic_append_ceo_title,
                               exec_append,
						 left.seq = right.seq,
						 transform(TM_Test.Layout_Amex_iCLIC_Test_Base_Append,
							      self.Executive_Name := right.Executive_Name,
							      self.Executive_Title := right.Executive_Title,
							      self := left),
					      left outer,
					      hash);
						 
// Check for Duns Number and append flag
bh_base := Business_Header.File_Business_Header_Base;

layout_bh_dnb_list := record
bh_base.bdid;
bh_base.source;
bh_base.source_group;
end;

bh_dnb_list := table(bh_base(source = 'D', source_group[1] <> 'D'), layout_bh_dnb_list);
bh_dnb_list_dedup := dedup(bh_dnb_list, bdid, all);

amex_iclic_append_duns_flag := join(amex_iclic_append_exec,
                                    bh_dnb_list_dedup,
							 left.bdid = right.bdid,
							 transform(TM_Test.Layout_Amex_iCLIC_Test_Base_Append,
							           self.duns_flag := if(right.bdid <> 0, 'Y', left.duns_flag),
									 self := left),
							 left outer,
							 hash);
amex_iclic_append_duns_sort := sort(amex_iclic_append_duns_flag, AXP_Vendor_Key) : persist('TMTEST::amex_iclic_test_fileb');

count(amex_iclic_append_duns_sort);
output(amex_iclic_append_duns_sort, all);

// Convert base to output file format
TM_Test.Layout_Output_File_B FormatFileBOutput(TM_Test.Layout_Amex_iCLIC_Test_Base_Append l) := transform
self.group_id := if(l.group_id <> 0, intformat(l.group_id, 12, 1), '');
self.bdid := if(l.bdid <> 0, intformat(l.bdid, 12, 1), '');
self.bdid_score := if(l.bdid <> 0, intformat(l.bdid_score, 3, 1), '');
self.did := if(l.did <> 0, intformat(l.did, 12, 1), '');
self.did_score := if(l.did <> 0, intformat(l.score, 3, 1), '');
self.verify_best_phone := if(l.bdid <> 0, intformat(l.verify_best_phone, 3, 1), '');
self.verify_best_fein := if(l.bdid <> 0, intformat(l.verify_best_fein, 3, 1), '');
self.verify_best_address := if(l.bdid <> 0, intformat(l.verify_best_address, 3, 1), '');
self.verify_best_CompanyName := if(l.bdid <> 0, intformat(l.verify_best_CompanyName, 3, 1), '');
self := l;
end;

amex_iclic_fileb_init := project(amex_iclic_append_duns_sort, FormatFileBOutput(left));

amex_iclic_fileb_sort := sort(amex_iclic_fileb_init, AXP_Vendor_Key);

output(amex_iclic_fileb_sort,,'tmtest::amex_iclic_test_File_B',overwrite);
output(amex_iclic_fileb_sort,all);

