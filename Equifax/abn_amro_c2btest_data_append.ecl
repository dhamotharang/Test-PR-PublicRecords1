import ut, Business_Header, DCA, InfoUSA;

// Append associated companies from PAW using DID and Name-Address
abn_amro_init := abn_amrow_c2btest_paw_append;

// Append SIC Codes
layout_sic_code_append := record
abn_amro_init.seq;
abn_amro_init.bdid;
string4  SIC_Code1 := '';
string4  SIC_Code2 := '';
string4  SIC_Code3 := '';
end;

sic_code_init := table(abn_amro_init(bdid <> 0), layout_sic_code_append);
sic_code_init_dist := distribute(sic_code_init, hash(bdid));

bh_sic := Business_Header.BH_BDID_SIC;

layout_sic_code := record
unsigned6 bdid;
string2 source;
string4 sic_code;
end;

// Select SIC Codes
bh_sic_select := join(bh_sic,
                      sic_code_init,
				  left.bdid = right.bdid,
				  transform(layout_sic_code, self.sic_code := left.sic_code[1..4], self := left),
				  lookup);

bh_sic_select_dist := distribute(bh_sic_select, hash(bdid));
bh_sic_select_sort := sort(bh_sic_select_dist, bdid, sic_code, Business_Header.Map_Source_Hierarchy(source), local);
bh_sic_select_dedup := dedup(bh_sic_select_sort, bdid, sic_code, local);
bh_sic_select_sort1 := sort(bh_sic_select_dedup, bdid, Business_Header.Map_Source_Hierarchy(source), local);

// Append up to 3 SIC codes
layout_sic_code_append AppendSICCOdes(layout_sic_code_append l, layout_sic_code r, unsigned1 cnt) := transform
self.SIC_Code1 := if(cnt = 1, r.sic_code, l.SIC_Code1);
self.SIC_Code2 := if(cnt = 2, r.sic_code, l.SIC_Code2);
self.SIC_Code3 := if(cnt = 3, r.sic_code, l.SIC_Code3);
self := l;
end;

sic_codes := denormalize(sic_code_init_dist,
		               bh_sic_select_sort1,
					left.bdid = right.bdid,
					AppendSICCodes(left, right, counter),
					left outer,
					local); 

// Append Sales and Employee Counts from DCA file
layout_dca_append := record
abn_amro_init.seq;
abn_amro_init.bdid;
string9  Number_Of_Employees := '';
string12 Annual_Sales := '';
end;

dca_append_init := table(abn_amro_init(bdid <> 0), layout_dca_append);
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

// Append Sales and Employee Counts from InfoUSA file
layout_iusa_append := record
abn_amro_init.seq;
abn_amro_init.bdid;
string9  Number_Of_Employees := '';
string12 Annual_Sales := '';
end;

iusa_append_init := table(abn_amro_init(bdid <> 0), layout_iusa_append);
iusa_append_init_dist := distribute(iusa_append_init, hash(bdid));


iusa_base := InfoUSA.File_ABIUS_Company_Base(bdid <> 0);

layout_iusa_info := record
unsigned6 bdid;
unsigned3 infousa_number_employees;
unsigned6 infousa_revenues;
end;

layout_iusa_info GetIUSAInfo(iusa_base l) := transform
self.infousa_number_employees := map((unsigned3)l.TOTAL_EMPLOYEES_ACTUAL <> 0 => (unsigned3)l.TOTAL_EMPLOYEES_ACTUAL,
                                          (unsigned3)l.NUM_EMPLOYEES_ACTUAL <> 0 => (unsigned3)l.NUM_EMPLOYEES_ACTUAL,
								  l.EMPLOYEE_SIZE_CD <> '' => case(l.EMPLOYEE_SIZE_CD,
								    'A' => 4,
								    'B' => 9,
								    'C' => 19,
								    'D' => 49,
								    'E' => 99,
								    'F' => 249,
								    'G' => 499,
								    'H' => 999,
								    'I' => 4999,
								    'J' => 9999,
								    'K' => 10000,
								     0),
								  0);
self.infousa_revenues := case(l.SALES_VOLUME_CD,
                                    'A' => 250000,
                                    'B' => 750000,
                                    'C' => 1750000,
                                    'D' => 3750000,
                                    'E' => 7500000,
                                    'F' => 15000000,
                                    'G' => 35000000,
                                    'H' => 75000000,
                                    'I' => 300000000,
                                    'J' => 750000000,
                                    'K' => 1000000000,
							 0);
self := l;
end;

iusa_info := project(iusa_base, GetIUSAInfo(left));
iusa_info_dist := distribute(iusa_info, hash(bdid));
iusa_info_sort := sort(iusa_info_dist, bdid, -infousa_revenues, -infousa_number_employees, local);
iusa_info_dedup := dedup(iusa_info_sort, bdid, local);

layout_iusa_append AppendIUSAInfo(layout_iusa_append l, layout_iusa_info r) := transform
self.Number_Of_Employees := if(r.infousa_number_employees <> 0, intformat(r.infousa_number_employees, 9, 1), '');
self.Annual_Sales := if(r.infousa_revenues <> 0, intformat(r.infousa_revenues, 12, 1), '');
self := l;
end;

iusa_append := join(iusa_append_init_dist,
                    iusa_info_dedup,
			     left.bdid = right.bdid,
				AppendIUSAInfo(left, right),
			     keep(1),
			     left outer,
			     local);

// Append data				
abn_amro_append_sic_codes := join(abn_amro_init,
                                  sic_codes,
						    left.seq = right.seq and
						      left.bdid = right.bdid,
						    transform(Layout_ABN_AMRO_C2BTest_Base,
							           self.SIC_Code1 := right.SIC_Code1,
							           self.SIC_Code2 := right.SIC_Code2,
							           self.SIC_Code3 := right.SIC_Code3,
									 self := left),
						    left outer,
						    hash);
						    
abn_amro_append_iusa_data := join(abn_amro_append_sic_codes,
                                 iusa_append,
						   left.seq = right.seq and
						     left.bdid = right.bdid,
						   transform(Layout_ABN_AMRO_C2BTest_Base,
							          self.Number_Of_Employees := if(left.Number_Of_Employees = '', right.Number_Of_Employees, left.Number_Of_Employees),
							          self.Annual_Sales := if(left.Annual_Sales = '', right.Annual_Sales, left.Annual_Sales),
									self := left),
						   left outer,
						   hash);

abn_amro_append_dca_data := join(abn_amro_append_iusa_data,
                                 dca_append,
						   left.seq = right.seq and
						     left.bdid = right.bdid,
						   transform(Layout_ABN_AMRO_C2BTest_Base,
							          self.Number_Of_Employees := if(left.Number_Of_Employees = '', right.Number_Of_Employees, left.Number_Of_Employees),
							          self.Annual_Sales := if(left.Annual_Sales = '', right.Annual_Sales, left.Annual_Sales),
									self := left),
						   left outer,
						   hash);

abn_amro_append_sort := sort(abn_amro_append_dca_data, seq, confidence_level, group_id, bdid)  : persist('TMTEST::abn_amro_c2btest_data_append');

export abn_amro_c2btest_data_append := abn_amro_append_sort;