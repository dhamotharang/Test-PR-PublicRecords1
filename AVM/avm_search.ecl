import ln_property, ln_mortgage, property, header, ut;

// Assessors and Deeds file restricted to Fidelity records only
ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

assessor_base := ln_property.File_Assessment;
//assessor_base := dataset('~thor_data400::base::ln_property::20060804::assessor', LN_Property.Layout_Property_Common_Model_BASE, flat);
assessor_file := assessor_base(state_code in ln_property_valid_state and vendor_source_flag in ['DAYTN','OKCTY'],
                               new_record_type_code <> 'PP');

deed_base := ln_property.File_Deed;
//deed_base := dataset('~thor_data400::base::ln_property::20060804::deed', LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, flat);
deed_file := deed_base(state in ln_property_valid_state and vendor_source_flag in ['DAYTN','OKCTY']);

//Function for unformatted apns
stripFormat(string apn) := stringlib.stringfilter(apn,
						'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');

// Use only Fidelity data and Property search records with non-blank zip codes
search_base := LN_Property.File_Search(source_code not in ['OS','SO']);
//search_base := dataset('~thor_data400::base::ln_property::20060804::search', LN_Property.Layout_Deed_Mortgage_Property_Search, flat)(source_code not in ['OS','SO']);
search_file := search_base(vendor_source_flag in ['DAYTN','OKCTY'], source_code[2] = 'P', (integer)zip <> 0);

Layout_AVM_Search InitAVMSearch(search_file l) := transform
self.avm_property_id := 0;
self.unformatted_apn := '';
self.GEOLINK := if(l.st <> '' and l.county <> '', l.st+l.county[3..5]+l.geo_blk, '');
self.county_name := '';
self := l;
end;

avm_search_init := project(search_file, InitAVMSearch(left));
avm_search_init_dedup := dedup(avm_search_init, all);

// Sequence records
Layout_AVM_Search SeqAVMSearch(Layout_AVM_Search l, unsigned6 cnt) := transform
self.avm_property_id := cnt;
self := l;
end;

avm_search_seq := project(avm_search_init_dedup, SeqAVMSearch(left, counter));

// Append County Names
string3 fips_county(string5 county) := if(county = '12025', '086', county[3..5]);

county_names := Property.File_County_Code_Names;

avm_search_county_append := join(avm_search_seq,
                                 county_names,
						   left.st = right.state and
						     fips_county(left.county) = right.fips_county_code,
						   transform(Layout_AVM_Search,
						             self.county_name := right.county_name,
								   self := left),
						   left outer,
						   hash);

// Append unformatted apn
layout_apn_slim := record
  string12  ln_fares_id;
  string45  unformatted_apn;
end;

assessor_apn := project(assessor_file(apna_or_pin_number <> ''),
                        transform(layout_apn_slim,
				              self.unformatted_apn := stripFormat(left.apna_or_pin_number),
						    self := left));
						    
deed_apn := project(deed_file(apnt_or_pin_number <> ''),
                        transform(layout_apn_slim,
				              self.unformatted_apn := stripFormat(left.apnt_or_pin_number),
						    self := left));
						    
apn_combined := assessor_apn + deed_apn;
apn_combined_dedup := dedup(apn_combined, ln_fares_id, all);

avm_search_apn_append := join(avm_search_county_append,
                              apn_combined_dedup,
						left.ln_fares_id = right.ln_fares_id,
						transform(Layout_AVM_Search,
						          self.unformatted_apn := right.unformatted_apn,
								self := left),
						left outer,
						hash);
                              

// Match search records by clean address
// Filter out addresses which look like apartments with no sec range
avm_search_nosec := avm_search_apn_append(prim_name <> '', sec_range = '');
avm_search_wsec := avm_search_apn_append(prim_name <> '', sec_range != '');

Layout_AVM_Search SecRangeCheck(avm_search_nosec l, Header.ApartmentBuildings r) := transform
self.avm_property_id := if (r.apt_cnt > 10, skip, l.avm_property_id);
self := l;
end;

apts := Header.ApartmentBuildings;

layout_apt_buildings := record
string10 prim_range := (string)apts.prim_range;
string2  predir := (string)apts.predir;
string28 prim_name := (string)apts.prim_name;
string5  zip := (string)apts.zip;
string4  suffix := (string)apts.suffix;
apts.apt_cnt;
end;

// If apartment count is more than 1, exclude if no sec range
apts_with_count := apts(apt_cnt > 1);

avm_search_apt_keep := join(avm_search_nosec,
                                apts_with_count,
						  left.prim_Range = right.prim_range and
						    left.prim_name = right.prim_name and
						    left.zip = right.zip and
						    left.suffix = right.suffix and
						    left.predir = right.predir,
				            transform(Layout_AVM_Search, self := left),
						  left only,
						  hash);
	
avm_search_apt_reject := join(avm_search_nosec,
                                apts_with_count,
						  left.prim_Range = right.prim_range and
						    left.prim_name = right.prim_name and
						    left.zip = right.zip and
						    left.suffix = right.suffix and
						    left.predir = right.predir,
				            transform(Layout_AVM_Search, self := left),
						  hash);

avm_search_byaddr_init := avm_search_wsec + avm_search_apt_keep;

// Count groups where address and APN is identical (APN could be blank)
// Exclude groups from address matching where total record count > 100
layout_address_stat := record
avm_search_byaddr_init.zip;
avm_search_byaddr_init.prim_name;
avm_search_byaddr_init.prim_range;
avm_search_byaddr_init.predir;
avm_search_byaddr_init.postdir;
avm_search_byaddr_init.suffix;
avm_search_byaddr_init.sec_range;
avm_search_byaddr_init.unformatted_apn;
cnt := count(group);
end;

avm_search_by_addr_stat := table(avm_search_byaddr_init, layout_address_stat,
                                 zip, prim_name, prim_range, predir, postdir, suffix, sec_range, unformatted_apn);
						   
avm_search_byaddr_accept := join(avm_search_byaddr_init,
                                 avm_search_by_addr_stat(cnt > 100),
						    left.zip = right.zip and
						      left.prim_name = right.prim_name and
						      left.prim_range = right.prim_range and
						      left.predir = right.predir and
							 left.postdir = right.postdir and
						      left.suffix = right.suffix and
							 left.sec_range = right.sec_range and
							 left.unformatted_apn = right.unformatted_apn,
				              transform(Layout_AVM_Search, self := left),
						    left only,
						    hash);
						   
avm_search_byaddr_reject := join(avm_search_byaddr_init,
                                 avm_search_by_addr_stat(cnt > 100),
						    left.zip = right.zip and
						      left.prim_name = right.prim_name and
						      left.prim_range = right.prim_range and
						      left.predir = right.predir and
							 left.postdir = right.postdir and
						      left.suffix = right.suffix and
							 left.sec_range = right.sec_range and
							 left.unformatted_apn = right.unformatted_apn,
				              transform(Layout_AVM_Search, self := left),
						    hash);

// Pre-id groups where address and APN are identical
avm_search_byaddr_init_dist := distribute(avm_search_byaddr_accept, hash(zip, prim_name, prim_range));
avm_search_byaddr_init_sort := sort(avm_search_byaddr_init_dist, zip, prim_name, prim_range, predir, postdir, suffix, sec_range, unformatted_apn, avm_property_id, local);
avm_search_byaddr_init_grp := group(avm_search_byaddr_init_sort, zip, prim_name, prim_range, predir, postdir, suffix, sec_range, unformatted_apn, local);

Layout_AVM_Search CopyID(Layout_AVM_Search L, Layout_AVM_Search R) := transform
self.avm_property_id := IF(l.avm_property_id = 0, r.avm_property_id, l.avm_property_id);
self := r;
end;

// Now include apts with no sec range and
avm_search_byaddr := group(iterate(avm_search_byaddr_init_grp, CopyID(left, right))) +
                     avm_search_apt_reject +
				 avm_search_byaddr_reject;

// Match by unformatted apn and zip
Layout_AVM_PairMatch MatchAVM(Layout_AVM_Search l, Layout_AVM_Search r, unsigned1 match) := transform
self.old_rid := l.avm_property_id;
self.new_rid := r.avm_property_id;
self.pflag := match;
end;

avm_match_byapn_init := avm_search_byaddr(unformatted_apn <> '');

avm_match_byapn := join(avm_match_byapn_init,
                         avm_match_byapn_init,
					left.zip = right.zip and
                            left.unformatted_apn = right.unformatted_apn and
					   (ut.NBEQ(left.prim_name, right.prim_name) or
					     ut.NBEQ(left.prim_range, right.prim_range)) and
					   left.avm_property_id < right.avm_property_id,
					 MatchAVM(left, right, 1),
					 hash);
					   
avm_matches_dedup := dedup(avm_match_byapn, new_rid, old_rid, all);

// Transitive closure of match pairs
ut.MAC_Reduce_Pairs(avm_matches_dedup, new_rid, old_rid, pflag, AVM.Layout_AVM_PairMatch, avm_matches_reduced)

// Patch new BDIDs
ut.MAC_Patch_Id(avm_search_byaddr, avm_property_id, avm_matches_reduced, old_rid, new_rid, avm_search_patched)

avm_search_sort := sort(avm_search_patched, avm_property_id);

export avm_search := avm_search_sort : persist('TEMP::avm_search');