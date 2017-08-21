import Business_Header, Risk_Indicators, Corp, DCA;

#option('outputLimit', 100);

// Output special file with groups
amex_iclic_test_base := TM_Test.amex_iclic_test_group;

layout_group_id_list := record
amex_iclic_test_base.group_id;
end;

amex_groups := table(amex_iclic_test_base(group_id <> 0), layout_group_id_list);
amex_groups_dedup := dedup(amex_groups, all);

bh_group := Business_Header.File_Super_Group;

// get list of bdids for each group
amex_bdid_groups_init := join(bh_group,
                              amex_groups_dedup,
					     left.group_id = right.group_id,
					     transform(Business_Header.Layout_BH_Super_Group, self := left),
					     lookup);
					
layout_group_id_stat := record
amex_bdid_groups_init.group_id;
cnt := count(group);
end;

amex_bdid_group_stat := table(amex_bdid_groups_init, layout_group_id_stat, group_id, few);

// Select 50 companies with 2 or more in the group and less than 100 BDIDs
// and 50 companies with 10 or more in the group and less than 100 BDIDs
amex_bdid_group_select := enth(amex_bdid_group_stat(cnt between 2 and 100), 50) +
                          enth(amex_bdid_group_stat(cnt between 10 and 100), 50);

layout_group_seq := record
unsigned4 seq := 0;
Business_Header.Layout_BH_Super_Group;
end;

amex_bdid_groups_select := join(amex_bdid_groups_init,
                                amex_bdid_group_select,
					       left.group_id = right.group_id,
					       transform(layout_group_seq, self := left),
					       lookup);
						  
// Sequence the selected records
layout_group_seq SequenceGroups(layout_group_seq l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

amex_bdid_groups := project(dedup(amex_bdid_groups_select,all), SequenceGroups(left, counter));
					
layout_group_best := record
unsigned4 seq;
unsigned6 group_id;
unsigned6 bdid;
string120 best_CompanyName;
string60 best_addr1;
string60 best_addr2;
string10 best_phone;
string9  best_fein;
end;

bh_best := Business_Header.File_Business_Header_Best;

os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

layout_group_best CombineBest(amex_bdid_groups l, bh_best r) := transform
self.seq := l.seq;
self.group_id := l.group_id;
self.bdid := l.bdid;
self.best_CompanyName := r.company_name;

self.best_addr1 := 
			os(r.prim_range) + 
			os(r.predir) + 
			os(r.prim_name) +
			os(r.addr_suffix) +
			os(r.postdir) +
				if(ut.tails(r.prim_name, os(r.unit_desig) + os(r.sec_range)),
					'',
					os(r.unit_desig) + os(r.sec_range));

SELF.best_addr2 := 
			os(r.city) +
			os(r.state) +
			if(r.zip = 0, '', intformat(r.zip, 5, 1)) + 
				if(r.zip4 <> 0, '-' + intformat(r.zip4, 4, 1), '');

self.best_phone := if(r.phone <> 0, intformat(r.phone, 10, 1), '');
self.best_fein := if(r.fein <> 0, intformat(r.fein, 9, 1), '');
end;


amex_bdid_group_best := join(amex_bdid_groups,
                             bh_best,
					    left.bdid = right.bdid,
					    CombineBest(left, right),
					    hash);

// Combine group best info with base records
layout_fileb_temp := record
unsigned4 seq;
unsigned6 group_id;
unsigned  bdid;
unsigned6 did;
string AXP_Vendor_Key;
string Company_Name;
string Address_1;
string Address_2;
string City;
string State;
string Zip;
string Phone;
string Country_Code;
string duns_number;
string CEO_Name;
// principal clean name
string5  title;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
string3  name_score;
// clean phones
string10  phone10;
// Best Company Information
string120 best_CompanyName;
string60 best_addr1;
string60 best_addr2;
string10 best_phone;
string9  best_fein;
// Additional Appended data
string20 phone_type := '';
string35 CEO_Title := '';
string60 Type_Of_Business := '';
string8  SIC_Code1 := '';
string8  SIC_Code2 := '';
string8  SIC_Code3 := '';
string9  Number_Of_Employees := '';
string12 Annual_Sales := '';
string60 Executive_Name := '';
string35 Executive_Title := '';
string1  duns_flag := '';
end;

layout_fileb_temp AppendBest(amex_iclic_test_base l, amex_bdid_group_best r) := transform

boolean baserec := l.group_id = r.group_id and l.bdid = r.bdid;

self.Company_Name := if(baserec, l.Company_name, '');
self.Address_1 := if(baserec, l.Address_1, '');
self.Address_2 := if(baserec, l.Address_2, '');
self.City := if(baserec, l.City, '');
self.State := if(baserec, l.State, '');
self.Zip := if(baserec, l.Zip, '');
self.Phone := if(baserec, l.Phone, '');
self.Country_Code := if(baserec, l.Country_Code, '');
self.duns_number := if(baserec, l.duns_number, '');
self.CEO_Name := if(baserec, l.CEO_Name, '');
self.title := if(baserec, l.title, '');
self.fname := if(baserec, l.fname, '');
self.mname := if(baserec, l.mname, '');
self.lname := if(baserec, l.lname, '');
self.name_suffix := if(baserec, l.name_suffix, '');
self.name_score := if(baserec, l.name_score, '');
// clean phones
self.phone10 := if(baserec, l.phone10, r.best_phone);
self := r;
self := l;
end;

amex_iclic_test_group_select := dedup(join(amex_iclic_test_base,
                                     amex_bdid_group_best,
					            left.group_id = right.group_id,
					            AppendBest(left, right),
					            hash),all);

// Append phone type
layout_phone_append := record
amex_iclic_test_group_select.seq;
amex_iclic_test_group_select.phone10;
string2 nxx_type := '';
string20 phone_type := '';
end;

phone_type_init := table(amex_iclic_test_group_select(phone10 <> ''), layout_phone_append);
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
amex_iclic_test_group_select.seq;
amex_iclic_test_group_select.bdid;
string60 Type_Of_Business := '';
end;

corp_type_init := table(amex_iclic_test_group_select(bdid <> 0), layout_corp_type_append);
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
amex_iclic_test_group_select.seq;
amex_iclic_test_group_select.bdid;
string8  SIC_Code1 := '';
string8  SIC_Code2 := '';
string8  SIC_Code3 := '';
end;

sic_code_init := table(amex_iclic_test_group_select(bdid <> 0), layout_sic_code_append);
sic_code_init_dist := distribute(sic_code_init, hash(bdid));

bh_sic := Business_Header.BH_BDID_SIC;

// Select SIC Codes
bh_sic_select := join(bh_sic,
                      sic_code_init,
				  left.bdid = right.bdid,
				  transform(Business_Header.Layout_SIC_Code, self := left),
				  lookup);

bh_sic_select_dist := distribute(bh_sic_select, hash(bdid));
bh_sic_select_dist_sort := sort(bh_sic_select_dist, Business_Header.Map_Source_Hierarchy(source), local);

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
amex_iclic_test_group_select.seq;
amex_iclic_test_group_select.bdid;
string9  Number_Of_Employees := '';
string12 Annual_Sales := '';
end;

dca_append_init := table(amex_iclic_test_group_select(bdid <> 0), layout_dca_append);
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
amex_iclic_test_group_select.seq;
amex_iclic_test_group_select.bdid;
amex_iclic_test_group_select.did;
amex_iclic_test_group_select.fname;
amex_iclic_test_group_select.mname;
amex_iclic_test_group_select.lname;
amex_iclic_test_group_select.name_suffix;
string35 CEO_Title := '';
unsigned1 title_rank := 30;
end;

ceo_append_init := table(amex_iclic_test_group_select(bdid <> 0, CEO_Name <> ''), layout_ceo_append);
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
amex_iclic_test_group_select.seq;
amex_iclic_test_group_select.bdid;
amex_iclic_test_group_select.did;
amex_iclic_test_group_select.fname;
amex_iclic_test_group_select.mname;
amex_iclic_test_group_select.lname;
amex_iclic_test_group_select.name_suffix;
string60 Executive_Name := '';
string35 Executive_Title := '';
unsigned1 title_rank := 30;
end;

exec_append_init := table(amex_iclic_test_group_select(bdid <> 0), layout_exec_append);
exec_append_dist := distribute(exec_append_init, hash(bdid));

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
amex_iclic_append_phone_type := join(amex_iclic_test_group_select,
                                     phone_type_nxx,
							  left.seq = right.seq,
							  transform(layout_fileb_temp,
							            self.phone_type := right.phone_type,
									  self := left),
							  left outer,
							  hash);
							  
amex_iclic_append_business_type := join(amex_iclic_append_phone_type,
                                        corp_business_type,
							     left.seq = right.seq,
							     transform(layout_fileb_temp,
							                self.Type_Of_Business := right.Type_Of_Business,
									      self := left),
							     left outer,
							     hash);

amex_iclic_append_sic_codes := join(amex_iclic_append_business_type,
                                    sic_codes,
							 left.seq = right.seq,
							 transform(layout_fileb_temp,
							           self.SIC_Code1 := right.SIC_Code1,
							           self.SIC_Code2 := right.SIC_Code2,
							           self.SIC_Code3 := right.SIC_Code3,
									 self := left),
							 left outer,
							 hash);

amex_iclic_append_dca_data := join(amex_iclic_append_sic_codes,
                                   dca_append,
							left.seq = right.seq,
							transform(layout_fileb_temp,
							          self.Number_Of_Employees := right.Number_Of_Employees,
							          self.Annual_Sales := right.Annual_Sales,
									self := left),
							left outer,
							hash);

amex_iclic_append_ceo_title := join(amex_iclic_append_dca_data,
                                    ceo_append,
							 left.seq = right.seq,
							 transform(layout_fileb_temp,
							           self.CEO_Title := right.CEO_Title,
									 self := left),
							 left outer,
							 hash);

amex_iclic_append_exec := join(amex_iclic_append_ceo_title,
                               exec_append,
						 left.seq = right.seq,
						 transform(layout_fileb_temp,
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
							 transform(layout_fileb_temp,
							           self.duns_flag := if(right.bdid <> 0, 'Y', left.duns_flag),
									 self := left),
							 left outer,
							 hash);

amex_iclic_append_duns_dedup := dedup(amex_iclic_append_duns_flag, all);
amex_iclic_append_duns_sort := sort(amex_iclic_append_duns_dedup, AXP_Vendor_Key, group_id, -Company_Name, bdid) : persist('TMTEST::amex_iclic_test_fileb_group');

count(amex_iclic_append_duns_sort);
output(amex_iclic_append_duns_sort, all);
			    
// Format output layout
TM_Test.Layout_Output_File_B_Group FormatOutput(layout_fileb_temp l) := transform
self.group_id := intformat(l.group_id, 12, 1);
self.bdid := intformat(l.bdid, 12, 1);
self.did := if(l.did <> 0, intformat(l.did, 12, 1), '');
self := l;
end;

amex_bdid_group_out := project(amex_iclic_append_duns_sort, FormatOutput(left));
amex_bdid_group_out_sort := sort(amex_bdid_group_out, AXP_Vendor_Key, group_id, -Company_Name, bdid);


output(amex_bdid_group_out_sort,,'tmtest::amex_iclic_test_File_B_Group',overwrite);
output(amex_bdid_group_out_sort,all);


