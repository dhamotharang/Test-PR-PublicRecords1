import Business_Header, Business_Header_SS, doxie_cbrs, ut, DCA, Domains, Gong, YellowPages, AutoStandardI;

// Get the 'best' information for this group of bdids
bhbk := Business_Header.Key_BH_Best;
tr := true : stored('tru');

Layout_Business_Search_Criteria_Raw AppendBest(bhbk r) := transform
	self.phone := if (r.phone = 0, '', (string)r.phone);
	self.fein  := if (r.fein = 0, '', intformat(r.fein, 9, 1));
	self.zip   := if(r.zip > 0, intformat(r.zip,5,1), '');
	self.zip4  := if(r.zip4 > 0, intformat(r.zip4,4,1), '');
			          self.alias_company_names := [];
			          self.relative_company_names := [];
							  self.city_names := [];
							  self.addresses := [];
							  self.domain_names := [];
							  self.key_employees := [];
							  self.active_phones := [];
							  self.other_phones := [];
							  self.email_stems := [];
	self := r;
END;
// Initialize search criteria raw data
scr_best := project(bhbk,AppendBest(left));
							  
// Append the group_id
gidk := Business_Header.Key_BH_SuperGroup_BDID;

scr_gid := join(scr_best,
                gidk(bdid<>0),
				left.bdid = right.bdid,
				transform(Layout_Business_Search_Criteria_Raw,
				          self.group_id := right.group_id,
						  self := left),hash);
						  
// Append alias names from similar name-address, name-phone, and fbn filing relatives
kbr := Business_Header.Key_Business_Relatives;

br_alias := join(scr_gid,
                 kbr(bdid1<>0),
			     left.bdid = right.bdid1 and
			        (not right.rel_group and (right.name_address or right.phone or right.fbn_filing)),
			     transform(Business_Header.Layout_Business_Relative, self := right),hash);
			 
// get best company name information
layout_company_name_temp := record
unsigned6 bdid;
unsigned6 bdid_other;
Business_Web.Layout_Company_Name;
end;

alias_names := join(br_alias,
                    bhbk(bdid<>0),
				    left.bdid2 = right.bdid,
				    transform(layout_company_name_temp,
				              self.bdid := left.bdid1,
							  self.bdid_other := left.bdid2,
							  self.company_name := right.company_name),hash);
							 
alias_names_dedup := dedup(sort(alias_names, bdid, ut.CleanCompany(company_name)), bdid, ut.CleanCompany(company_name));
							 
// Combine alias names
Layout_Business_Search_Criteria_Raw CombineAliasNames(scr_gid l, layout_company_name_temp r) := transform
self.alias_company_names := if ( count(l.alias_company_names)<100,l.alias_company_names + dataset([{r.company_name}], Business_Web.Layout_Company_Name),l.alias_company_names);
self := l;
end;

scr_alias := denormalize(scr_gid,
                         alias_names_dedup, 
						 left.bdid = right.bdid,
						 CombineAliasNames(left, right),
						 left outer,skew(1));				

/*
// Append group company names
gbdidk := Business_Header.Key_BH_SuperGroup_GroupID;

layout_group_temp := record
unsigned6 bdid;
unsigned6 group_bdid := 0;
Business_Web.Layout_Company_Name;
end;

group_names_init := join(scr_alias,
                         gbdidk,
						 left.group_id = right.group_id,
						 transform(layout_group_temp,
						           self.bdid := left.bdid,
								   self.group_bdid := right.bdid));
								   
group_names := join(group_names_init,
                    bhbk,
				    left.group_bdid = right.bdid,
				    transform(layout_company_name_temp,
							  self.company_name := right.company_name,
							  self.bdid_other := left.group_bdid,
							  self := left));
							 
group_names_dedup := dedup(sort(group_names, bdid, ut.CleanCompany(company_name)), bdid, ut.CleanCompany(company_name));

// Combine group company names
Layout_Business_Search_Criteria_Raw CombineGroupNames(scr_alias l, layout_group_temp r) := transform
self.group_company_names := l.group_company_names + dataset([{r.company_name}], Business_Web.Layout_Company_Name);
self := l;
end;

scr_group := denormalize(scr_alias,
                         group_names_dedup, 
						 left.bdid = right.bdid,
						 CombineGroupNames(left, right),
						 left outer);				

*/

// Append 1st degree relative names
br_first_degree := join(scr_alias,
                        kbr(bdid1<>0),
			            left.bdid = right.bdid1 and
			            (Business_Header.mac_isGroupRel(right)) and
						 not (right.dca_hierarchy or right.abi_hierarchy),
			            transform(Business_Header.Layout_Business_Relative, self := right),hash);
			 
// get best company name information
relative_names := join(br_first_degree,
                       bhbk(bdid<>0),
				       left.bdid2 = right.bdid,
				       transform(layout_company_name_temp,
				                 self.bdid := left.bdid1,
								 self.bdid_other := left.bdid2,
							     self.company_name := right.company_name),hash);
							  
// get dca parent and child records
dcabk := DCA.Key_DCA_Hierarchy_BDID;
dcarsk := DCA.Key_DCA_Hierarchy_Root_Sub;

layout_dca_hierarchy := record
unsigned6 bdid;
unsigned6 dca_bdid;
string2 level;
string9 root;
string4 sub;
string9 parent_root;
string4 parent_sub;
end;

dca_init := join(scr_alias,
                 dcabk(bdid<>0),
				 left.bdid = right.bdid,
				 transform(layout_dca_hierarchy,
				           self.bdid := left.bdid,
				           self.dca_bdid := right.bdid,
				           self := right),hash);
				 
// get parent record
dca_parent := join(dca_init,
                   dcarsk(tr),
				   left.parent_root = right.root and
				     left.parent_sub = right.sub,
				   transform(layout_dca_hierarchy,
				             self.bdid := left.bdid,
				             self.dca_bdid := right.bdid,
				             self := right),hash);
                   
// get common root records
dca_common := join(dca_init,
                   dcarsk(tr),
				   left.root = right.root and
				     left.bdid <> right.bdid,
				   transform(layout_dca_hierarchy,
				             self.bdid := left.bdid,
				             self.dca_bdid := right.bdid,
				             self := right),hash);
							 
// get children
dca_children := join(dca_init,
                     dca_common(tr),
					 left.root = right.parent_root and
					   left.sub = right.parent_sub,
				     transform(layout_dca_hierarchy,
				               self.bdid := left.bdid,
				               self.dca_bdid := right.bdid,
				               self := right),hash);
                     
dca_relatives_init := dca_parent + dca_children;

// get best company name information
dca_relative_names := join(dca_relatives_init,
                           bhbk(bdid<>0),
				           left.dca_bdid = right.bdid,
				           transform(layout_company_name_temp,
				                 self.bdid := left.bdid,
								 self.bdid_other := left.dca_bdid;
							     self.company_name := right.company_name),hash);

			 
relative_names_dedup := dedup(sort(relative_names + dca_relative_names, bdid, ut.CleanCompany(company_name)), bdid, ut.CleanCompany(company_name));

					 
// Combine relative names
Layout_Business_Search_Criteria_Raw CombineRelativeNames(scr_alias l, layout_company_name_temp r) := transform
self.relative_company_names := if ( count ( l.relative_company_names) < 100, l.relative_company_names + dataset([{r.company_name}], Business_Web.Layout_Company_Name), l.relative_company_names);
self := l;
end;

scr_relatives := denormalize(scr_alias,
                             relative_names_dedup, 
						     left.bdid = right.bdid,
						     CombineRelativeNames(left, right),
						     left outer,skew(1));

// Append city names

layout_best_temp := record
unsigned6 bdid;
unsigned6 bdid_other;
// from best company information
	qstring120 	company_name := '';
	qstring10 	prim_range := '';
	string2   	predir := '';
	qstring28 	prim_name := '';
	qstring4  	addr_suffix := '';
	string2   	postdir := '';
	qstring5  	unit_desig := '';
	qstring8  	sec_range := '';
	qstring25 	city := '';
	string2   	state := '';
	string5	 	zip := '';
	string4		zip4 := '';
	string10	phone := '';
	string10	fein := '';
end;

relative_best := join(relative_names + dca_relative_names,
                      bhbk(bdid<>0),
				      left.bdid_other = right.bdid,
				      transform(layout_best_temp,
					            self.bdid := left.bdid,
								self.bdid_other := left.bdid_other,
								self.phone := if (right.phone = 0, '', (string)right.phone);
	                            self.fein  := if (right.fein = 0, '', intformat(right.fein, 9, 1));
	                            self.zip   := if(right.zip > 0, intformat(right.zip,5,1), '');
	                            self.zip4  := if(right.zip4 > 0, intformat(right.zip4,4,1), '');
								self := right),hash);
								
indata_best := project(scr_best,
                       transform(layout_best_temp,
					             self.bdid := left.bdid,
								 self.bdid_other := left.bdid,
								 self := left));

combined_best := relative_best + indata_best;

layout_city_temp := record
unsigned6 bdid;
unsigned6 bdid_other;
Business_Web.Layout_City_Name;
end;

city_names := project(combined_best(city <> ''), transform(layout_city_temp, self := left));
city_names_dedup := dedup(sort(city_names, bdid, city), bdid, city);

Layout_Business_Search_Criteria_Raw CombineCityNames(scr_relatives l, layout_city_temp r) := transform
self.city_names := if ( count(l.city_names)<100,l.city_names + dataset([{r.city}], Business_Web.Layout_City_Name),l.city_names);
self := l;
end;

scr_cities := denormalize(scr_relatives,
                         city_names_dedup, 
						 left.bdid = right.bdid,
						 CombineCityNames(left, right),
						 left outer,skew(1));				

// Append addresses
layout_address_temp := record
unsigned6 bdid;
unsigned6 bdid_other;
Business_Web.Layout_Address;
end;

addresses := project(combined_best((integer)zip <> 0, prim_name <> ''), transform(layout_address_temp, self := left));
addresses_dedup0 := dedup(sort(addresses, except bdid_other), except bdid_other);
addresses_dedup := dedup(sort(addresses, bdid), bdid, keep(100));

Layout_Business_Search_Criteria_Raw CombineAddresses(scr_cities l, layout_address_temp r) := transform
self.addresses := if ( count(l.addresses)<100, l.addresses + dataset([{r.prim_range,
                                     	  r.predir,
                                          r.prim_name,
                                          r.addr_suffix,
                                          r.postdir,
                                          r.unit_desig,
                                          r.sec_range,
                                          r.city,
                                          r.state,
                                          r.zip,
                                          r.zip4}], Business_Web.Layout_Address) , l.addresses );
self := l;
end;

scr_addresses := denormalize(scr_cities,
                             addresses_dedup, 
						     left.bdid = right.bdid,
						     CombineAddresses(left, right),
						     left outer,skew(1));				

// Append domain names
dnk := Domains.Key_Whois_Bdid;

layout_domain_name_temp := record
unsigned6 bdid;
unsigned6 bdid_other;
Business_Web.Layout_Domain_Name;
end;

domain_names := join(combined_best,
                     dnk(bdid<>0),
					 left.bdid_other = right.bdid,
					 transform(layout_domain_name_temp,
					           self.bdid := left.bdid,
							   self.bdid_other := left.bdid_other;
					           self.domain_name := right.domain_name),hash,atmost(1000));
							   
domain_names_dedup := dedup(sort(domain_names(domain_name <> ''), bdid, domain_name), bdid, domain_name);

Layout_Business_Search_Criteria_Raw CombineDomainNames(scr_addresses l, layout_domain_name_temp r) := transform
self.domain_names := if ( count(l.domain_names)<100,l.domain_names + dataset([{r.domain_name}], Business_Web.Layout_Domain_Name),l.domain_names);
self := l;
end;

scr_domains := denormalize(scr_addresses,
                           domain_names_dedup, 
						   left.bdid = right.bdid,
						   CombineDomainNames(left, right),
						   left outer,skew(1));				

// Append key employees
bck := Business_Header.Key_Business_Contacts_BDID;

layout_key_employee_temp := record
unsigned6 bdid;
unsigned6 bdid_other;
Business_Web.Layout_Key_Employees;
end;

key_employees := join(combined_best,
                      bck(bdid<>0),
					  left.bdid_other = right.bdid and
					    right.from_hdr = 'N' and
						(right.company_title = '' or ut.TitleRank(right.company_title) <= 6),
					  transform(layout_key_employee_temp,
					            self.bdid := left.bdid,
								self.bdid_other := left.bdid_other,
					            self := right),hash);

key_employees_dedup := dedup(key_employees(lname <> ''),bdid, lname, fname, mname, name_suffix, did, company_title, email_address,all);
Layout_Business_Search_Criteria_Raw CombineKeyEmployees(scr_domains l, layout_key_employee_temp r) := transform
self.key_employees := if ( count(l.key_employees) < 100, l.key_employees + dataset([{r.did,
                                                  r.fname,
                                                  r.mname,
                                                  r.lname,
                                                  r.name_suffix,
                                                  r.company_title,
                                                  r.email_address}], Business_Web.Layout_Key_employees),l.key_employees);
self := l;
end;

scr_key_employees := denormalize(scr_domains,
                                 key_employees_dedup, 
						         left.bdid = right.bdid,
						         CombineKeyEmployees(left, right),
						         left outer,skew(1));			

// Append active phones from Gong and Yellow Pages
ghk := Gong.Key_History_BDID;
ypk := YellowPages.key_YellowPages_BDID;

layout_phone_temp := record
unsigned6 bdid;
unsigned6 bdid_other;
Business_Web.Layout_Phone;
end;

active_phones_gong := join(combined_best,
                           ghk(bdid<>0),
					       left.bdid_other = right.bdid,
					       transform(layout_phone_temp,
						             self.bdid := left.bdid,
						             self.bdid_other := left.bdid_other,
						             self.phone := right.phone10),hash);
						   
active_phones_yp := join(combined_best,
                         ypk(bdid<>0),
					     left.bdid_other = right.bdid,
					     transform(layout_phone_temp,
						           self.bdid := left.bdid,
						           self.bdid_other := left.bdid_other,
						           self.phone := right.phone10),hash);
					
active_phones := active_phones_gong + active_phones_yp;
active_phones_dedup := dedup(sort(active_phones, bdid, phone), bdid, phone);

Layout_Business_Search_Criteria_Raw CombineActivePhones(scr_key_employees l, layout_phone_temp r) := transform
self.active_phones := if ( count(l.active_phones) < 100,l.active_phones + dataset([{r.phone}], Business_Web.Layout_Phone),l.active_phones);
self := l;
end;

scr_active_phones := denormalize(scr_key_employees,
                                 active_phones_dedup, 
						         left.bdid = right.bdid,
						         CombineActivePhones(left, right),
						         left outer,skew(1));				

// Append other phones from Business Header
bhk := Business_Header_SS.Key_BH_BDID_pl;

glb_purpose:=AutoStandardI.InterfaceTranslator.glb_purpose.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.glb_purpose.params));
other_phones_init := join(combined_best,
                          bhk(bdid<>0),
						  left.bdid_other = right.bdid and
						    right.phone <> 0 AND
                ut.PermissionTools.glb.SrcOk(glb_purpose,right.source),
					      transform(layout_phone_temp,
						            self.bdid := left.bdid,
						            self.bdid_other := left.bdid_other,
						            self.phone := intformat(right.phone, 10, 1)),hash);
						  
other_phones_init_dedup := dedup(sort(other_phones_init, bdid, phone), bdid, phone);

// remove the active phones
other_phones := join(other_phones_init_dedup,
                     active_phones_dedup(tr),
					 left.phone = right.phone,
					 left only,hash);

Layout_Business_Search_Criteria_Raw CombineOtherPhones(scr_active_phones l, layout_phone_temp r) := transform
self.other_phones := if ( count(l.other_phones)<100,l.other_phones + dataset([{r.phone}], Business_Web.Layout_Phone),l.other_phones);
self := l;
end;

scr_other_phones := denormalize(scr_active_phones,
                                other_phones, 
						        left.bdid = right.bdid,
						        CombineOtherPhones(left, right),
						        left outer,skew(1));				
// Add email stems
layout_email_stem_temp := record
unsigned6 bdid;
unsigned6 bdid_other;
Business_Web.Layout_Email_Stem;
end;

// Get known stems from business contacts
email_stems_known_init := join(combined_best,
                               bck(bdid<>0),
					           left.bdid_other = right.bdid and
					             right.from_hdr = 'N' and
						         right.email_address <> '',
                               transform(layout_email_stem_temp,
								         self.email_stem := if(Stringlib.StringFind(right.email_address, '@', 1) > 0,
										                       right.email_address[Stringlib.StringFind(right.email_address, '@', 1)..],
													           ''),
							             self := left),hash);

// Get suspected stems from company name primary matching domains
email_stems_suspected_init := project(combined_best,
                                      transform(layout_email_stem_temp,
									            self.email_stem := if(length(trim(datalib.CompanyClean(left.company_name)[1..40], all)) <= 56,
												                      trim(datalib.CompanyClean(left.company_name)[1..40], all) + '.COM',
												                      ''),
												self := left));

email_stems_suspected_match1 := join(email_stems_suspected_init(email_stem <> ''),
                                   domain_names_dedup(bdid<>0),
								   left.bdid = right.bdid and
								     ut.StringSimilar100(left.email_stem, right.domain_name) <= 30,
								   transform(layout_email_stem_temp,
								             self := left),hash);

email_stems_suspected_match2 := join(email_stems_suspected_init(email_stem <> ''),
                                   domain_names_dedup(bdid<>0),
								   left.bdid = right.bdid and
								     ut.StringSimilar100(left.email_stem, right.domain_name) <= 30,
								   transform(layout_email_stem_temp,
								             self.bdid := left.bdid,
											 self.bdid_other := right.bdid,
											 self.email_stem := right.domain_name),hash);

// If there are no domains for a company or relative, then use primary name only as suspected email stem
// Note: may want to add primary+secondary as suspected email stem when a new CompanyClean funtion is available
//       that strips the furniture words only

email_stems_suspected_match3 := join(email_stems_suspected_init(email_stem <> ''),
                                     domain_names_dedup(bdid<>0),
								     left.bdid_other = right.bdid_other,
								     transform(layout_email_stem_temp,
								             self := left),
									 left only,hash);

email_stems_suspected_combined := email_stems_suspected_match1 + email_stems_suspected_match2 + email_stems_suspected_match3;
											 
email_stems_suspected := project(email_stems_suspected_combined,
                                 transform(layout_email_stem_temp,
								           self.email_stem := '@' + left.email_stem,
										   self := left));

email_stems := dedup(sort((email_stems_known_init + email_stems_suspected)(email_stem <> ''), bdid, email_stem), bdid, email_stem);

										   
Layout_Business_Search_Criteria_Raw CombineEmailStems(scr_other_phones l, layout_email_stem_temp r) := transform
self.email_stems := if ( count(l.email_stems)<100,l.email_stems + dataset([{r.email_stem}], Business_Web.Layout_Email_Stem),l.email_stems);
self := l;
end;

scr_email_stems := denormalize(scr_other_phones,
                               email_stems, 
						       left.bdid = right.bdid,
						       CombineEmailStems(left, right),
						       left outer,skew(1));				

export Search_Criteria_All := scr_email_stems : persist('dabtemp::company_reports');