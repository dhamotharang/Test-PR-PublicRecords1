import ut, Business_Header, Business_Header_SS, did_add;

// Combine business, address, as tax_id information
Layout_Business_Init := record
unsigned6 rid;
unsigned6 bdid;
Layout_Business;
end;

// Assign record ids
Layout_Business_Init AssignId(Layout_Business l, integer cnt) := transform
self.rid := cnt;
self.bdid := 0;
self := l;
end;

business_init := project(File_Business, AssignId(left, counter));

// Normalize Business names
Layout_Business_Norm := record
unsigned6 rid;
unsigned6 bdid;
string18 cid;
string20 pid;
string80 business_name;
end;

Layout_Business_Norm NormBusinessName(Layout_Business_Init l, unsigned1 cnt) := transform
self.business_name := choose(cnt, l.business_name, l.dba1, l.dba2, l.dba3, l.dba4, l.dba5, '');
self := l;
end;

business_norm := normalize(business_init, 6, NormBusinessName(left, counter));


// Join to Clean addresses
business_norm_dist := distribute(business_norm(business_name <> ''), hash(cid, pid));
address_clean_dist := distribute(address_prep, hash(cid, pid));

Layout_Business_Clean LinkAddress(Layout_Business_Norm l, Layout_Address_Clean r) := transform
self.rid := l.rid;
self.bdid := l.bdid;
self.business_name := l.business_name;
self.cid := l.cid;
self.pid := l.pid;
self := r;
end;

business_addr := join(business_norm_dist,
                      address_clean_dist,
					  left.cid = right.cid and
					    left.pid = right.pid,
					  LinkAddress(left, right),
					  left outer,
					  local);

// Append tax id
//taxid_init := File_SSN(ssn_type = '1');
taxid_init := File_SSN;
taxid_dist := distribute(taxid_init, hash(cid, pid));

Layout_Business_Clean AppendTaxId(Layout_Business_Clean l, Layout_SSN r) := transform
self.ssn_taxid := r.ssn_taxid;
self.ssn_type := r.ssn_type;
self := l;
end;

business_address_taxid := join(business_addr,
                               taxid_dist,
					          left.cid = right.cid and
					            left.pid = right.pid,
					          AppendTaxId(left, right),
					          left outer,
					          local);
							  

// BDID the Principal Businesses
bdid_matchset := ['A','F'];

Business_Header_SS.MAC_Add_BDID_Flex(business_address_taxid,
                                  bdid_matchset,
                                  business_name,
                                  prim_range, prim_name, zip,
                                  sec_range, st,
                                  phone_field, ssn_taxid,
                                  bdid, Layout_Business_Clean,
                                  FALSE, BDID_score_field,
                                  business_address_taxid_bdid)

business_address_taxid_sort := sort(business_address_taxid_bdid, rid);
							   

export business_prep := business_address_taxid_sort : persist('TEMP::equifax_business_clean');