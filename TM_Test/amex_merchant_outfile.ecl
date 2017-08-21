import ut;

// Append mkt filter flag to unfiltered business append
business_append_mktapp_fitered := amex_merchant_business_append(bdid_mkt_flag = 'Y');

layout_mktapp_filtered := record
business_append_mktapp_fitered.rid;
business_append_mktapp_fitered.seq;
business_append_mktapp_fitered.bdid_mkt_flag;
end;

mktapp_filtered_list := dedup(table(business_append_mktapp_fitered, layout_mktapp_filtered), all);

business_append_all := join(amex_merchant_business_append_all,
                            mktapp_filtered_list,
					   left.rid = right.rid and
					   left.seq = right.seq,
					   transform(Layout_Amex_Merchant_Business_Append,
					             self.bdid_mkt_flag := if(right.bdid_mkt_flag = 'Y', 'Y', 'N'), self := left),
					   left outer,
					   hash);

// Initialize output format
Layout_Amex_Merchant_Out InitOut(amex_merchant_business_append_all l) := transform
self.rid := intformat(l.rid, 8, 1);
self.group_id := if(l.group_id <> 0, intformat(l.group_id, 12, 1), '');
self.bdid := if(l.bdid <> 0, intformat(l.bdid, 12, 1), '');
self := l;
end;


amex_merchant_out_init := project(business_append_all, InitOut(left));
						    
amex_merchant_out_init_dist := distribute(amex_merchant_out_init, hash((unsigned4)rid));
amex_merchant_out_init_sort := sort(amex_merchant_out_init_dist, rid, group_id, bdid, local);
amex_merchant_out_init_dedup := dedup(amex_merchant_out_init_sort, rid, group_id, bdid, local);
						    
// Append original input data
layout_amex_merchant_seq := record
unsigned4 rid;
unsigned4 seq;
layout_amex_merchant_in;
end;

amex_merchant_seq := dataset('TMTEST::Amex_Merchant_Seq', layout_amex_merchant_seq, flat);
amex_merchant_seq_dist := distribute(amex_merchant_seq, hash(rid));

Layout_Amex_Merchant_Out AppendOriginalInput(Layout_Amex_Merchant_Out l, layout_amex_merchant_seq r) := transform
self.BIN := r.BIN;
self.Business_Name := r.Business_Name;
self.DBA := r.DBA;
self.Address1 := r.Address1;
self.Address2 := r.Address2;
self.City := r.City;
self.State := r.State;
self.Zipcode := r.Zipcode;
self.Status := r.Status;
self.Acctclass8 := r.Acctclass8;
self.Industry := r.Industry;
self.Business_Phone := r.Business_Phone;
self.SIC := r.SIC;
self.Correspondence_Address1 := r.Correspondence_Address1;
self.Correspondence_Address2 := r.Correspondence_Address2;
self.Correspondence_City := r.Correspondence_City;
self.Correspondence_State := r.Correspondence_State;
self.Correspondence_Zip := r.Correspondence_Zip;
self := l;
end;


amex_merchant_out_append_input := join(amex_merchant_out_init_dedup,
                                       amex_merchant_seq_dist,
							    (unsigned4)left.rid = right.rid,
							    AppendOriginalInput(left, right),
							    left outer,
							    local);
							    
// Dedup Employees
emp_init := amex_merchant_employee;
emp_init_dist := distribute(emp_init, hash(rid));
emp_init_sort := sort(emp_init_dist, rid, did, seq, local);
emp_init_dedup := dedup(emp_init_sort, rid, did, local);

// Append employee data
os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

Layout_Amex_Merchant_Out AppendEmp(Layout_Amex_Merchant_Out l, emp_init_dedup r) := transform
self.did := if(r.did <> 0, intformat(r.did, 12, 1), '');
self.emp_company_title := r.company_title;
self.emp_phone := r.emp_phone;
self.emp_ssn := r.emp_ssn;
self.emp_dob := if(r.emp_dob <> 0, intformat(r.emp_dob, 8, 1), '');
self.emp_fname := r.emp_fname;
self.emp_mname := r.emp_mname;
self.emp_lname := r.emp_lname;
self.emp_addr1 := os(r.emp_prim_range) + 
			   os(r.emp_predir) + 
			   os(r.emp_prim_name) +
			   os(r.emp_suffix) +
			   os(r.emp_postdir) +
				if(ut.tails(r.emp_prim_name, os(r.emp_unit_desig) + os(r.emp_sec_range)),
					'',
					os(r.emp_unit_desig) + os(r.emp_sec_range));
self.emp_city_name := r.emp_city_name;
self.emp_st := r.emp_st;
self.emp_zip := r.emp_zip;
self.emp_zip4 := r.emp_zip4;
self := l;
end;

amex_merchant_out_append_emp := join(amex_merchant_out_append_input,
                                     emp_init_dedup,
							  (unsigned4)left.rid = right.rid,
							  AppendEmp(left, right),
							  left outer,
							  local);

amex_merchant_out_append_emp_sort := sort(amex_merchant_out_append_emp, rid, group_id, bdid, did);

export amex_merchant_outfile := amex_merchant_out_append_emp_sort : persist('TMTEST::amex_merchant_out');
