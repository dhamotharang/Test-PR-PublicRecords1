import Business_Header, Header, Watchdog;

amex_merchant_init := amex_merchant_prep;

// create list of bdids					
layout_bdid_list := record
amex_merchant_init.rid;
amex_merchant_init.seq;
amex_merchant_init.group_id;
amex_merchant_init.bdid;
end;

amex_merchant_bdid_list := table(amex_merchant_init(bdid <> 0), layout_bdid_list);
amex_merchant_bdid_list_dist := distribute(amex_merchant_bdid_list, hash(bdid));

// Select Business Contacts for which we have an ADL
bc := Business_Header.File_Business_Contacts(bdid <> 0, from_hdr = 'N', did <> 0, not glb, not dppa);
bc_dist := distribute(bc, hash(bdid));

// Dedup contacts to keep most recent title
bc_sort := sort(bc_dist, bdid, did, if(company_title <> '', 0, 1), -dt_last_seen, ut.TitleRank(company_title), local);
bc_dedup := dedup(bc_sort, bdid, did, local);

// Append Business Contact Information
Layout_Amex_Merchant_Employee_Base AppendBusinessContactInfo(bc_dedup l, layout_bdid_list r) := transform
self.rid := r.rid;
self.seq := r.seq;
self.group_id := r.group_id;
self := l;
end;

amex_merchant_emp_init := join(bc_dedup,
                               amex_merchant_bdid_list_dist,
						 left.bdid = right.bdid,
						 AppendBusinessContactInfo(left, right),
						 local);
						 
// Append person best information (non-glb), filter out dead people
phb := Watchdog.File_Best_nonglb(DOD = '');

Layout_Amex_Merchant_Employee_Base AppendBestPersonInfo(phb l, Layout_Amex_Merchant_Employee_Base r) := transform
self.emp_phone := l.phone;
self.emp_ssn := l.ssn;
self.emp_dob := l.dob;
self.emp_fname := l.fname;
self.emp_mname := l.mname;
self.emp_lname := l.lname;
self.emp_name_suffix := l.name_suffix;
self.emp_prim_range := l.prim_range;
self.emp_predir := l.predir;
self.emp_prim_name := l.prim_name;
self.emp_suffix := l.suffix;
self.emp_postdir := l.postdir;
self.emp_unit_desig := l.unit_desig;
self.emp_sec_range := l.sec_range;
self.emp_city_name := l.city_name;
self.emp_st := l.st;
self.emp_zip := l.zip;
self.emp_zip4 := l.zip4;
self.emp_addr_dt_last_seen := l.addr_dt_last_seen;
self := r;
end;

amex_merchant_emp_best := join(phb,
                               amex_merchant_emp_init,
						 left.did = right.did,
						 AppendBestPersonInfo(left, right),
						 hash);
						 
// If person has a PO BOX address, replace with most recent street address if available
emp_pobox_init := amex_merchant_emp_best(emp_prim_name[1..6] = 'PO BOX');
emp_pobox_dist := distribute(emp_pobox_init, hash(did));

ph := Header.File_Headers_NonGLB(prim_name <> '', prim_name[1..6] <> 'PO BOX');
ph_dist := distribute(ph, hash(did));

ph_emp_select := join(ph,
                      emp_pobox_init,
				  left.did = right.did,
				  transform(Header.Layout_Header, self := left),
				  local);
				  
ph_emp_select_sort := sort(ph_emp_select, did, -dt_last_seen, local);
ph_emp_select_dedup := dedup(ph_emp_select_sort, did, local);
				  
Layout_Amex_Merchant_Employee_Base ReplacePOBoxAddr(Layout_Amex_Merchant_Employee_Base l, Header.Layout_Header r) := transform
self.emp_po_box_replaced := if(r.did <> 0, 'Y', 'N');
self.emp_prim_range := if(r.did <> 0, r.prim_range, l.emp_prim_range);
self.emp_predir := if(r.did <> 0, r.predir, l.emp_predir);
self.emp_prim_name := if(r.did <> 0, r.prim_name, l.emp_prim_name);
self.emp_suffix := if(r.did <> 0, r.suffix, l.emp_suffix);
self.emp_postdir := if(r.did <> 0, r.postdir, l.emp_postdir);
self.emp_unit_desig := if(r.did <> 0, r.unit_desig, l.emp_unit_desig);
self.emp_sec_range := if(r.did <> 0, r.sec_range, l.emp_sec_range);
self.emp_city_name := if(r.did <> 0, r.city_name, l.emp_city_name);
self.emp_st := if(r.did <> 0, r.st, l.emp_st);
self.emp_zip := if(r.did <> 0, r.zip, l.emp_zip);
self.emp_zip4 := if(r.did <> 0, r.zip4, l.emp_zip4);
self := l;
end;

emp_pobox_replace := join(emp_pobox_dist,
                          ph_emp_select_dedup,
					 left.did = right.did,
					 ReplacePOBoxAddr(left, right),
					 left outer,
					 local);
					 
amex_merchant_emp_best_combined := amex_merchant_emp_best(emp_prim_name[1..6] <> 'PO BOX') + emp_pobox_replace;
amex_merchant_emp_best_combined_sort := sort(amex_merchant_emp_best_combined, rid, seq);

export amex_merchant_employee := amex_merchant_emp_best_combined_sort : persist('TMTEST::amex_merchant_employee_base');
