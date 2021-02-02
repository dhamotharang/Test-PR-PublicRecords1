import Business_Header_SS, did_add;

// Clean input information
layout_input_init := record
unsigned6 rid;
unsigned6 did;
unsigned6 bdid;
Layout_Principal;
string73  clean_name;
string182 clean_address;
end;

layout_input_init CleanInput(Layout_Principal l, integer cnt) := transform
self.rid := cnt;
self.did := 0;
self.bdid := 0;
self.clean_name := AddrCleanLib.CleanPerson73(trim(l.first_name) + if(l.middle_initial <> '', (' ' + trim(l.middle_initial) + ' '), ' ') + trim(l.last_name));
self.clean_address := AddrCleanLib.CleanAddress182(l.delivery_line, trim(l.city) + ' ' + l.state + ' ' + l.zip_code[1..5]);
self := L;
end;

principal_init := project(File_Principal, CleanInput(left, counter));


// Format the clean address fields
Layout_Principal_Clean FormatClean(layout_input_init l) := transform
self.title := l.clean_name[1..5];
self.fname := l.clean_name[6..25];
self.mname := l.clean_name[26..45];
self.lname := l.clean_name[46..65];
self.name_suffix := l.clean_name[66..70];
self.name_score := l.clean_name[71..73];
self.prim_range := l.clean_address[1..10];
self.predir := l.clean_address[11..12];
self.prim_name := l.clean_address[13..40];
self.addr_suffix := l.clean_address[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
self.postdir := l.clean_address[45..46];
self.unit_desig := l.clean_address[47..56];
self.sec_range := l.clean_address[57..64];
self.p_city_name := l.clean_address[65..89];
self.v_city_name := l.clean_address[90..114];
self.st := l.clean_address[115..116];
self.zip := l.clean_address[117..121];
self.zip4 := l.clean_address[122..125];
self.cart := l.clean_address[126..129];
self.cr_sort_sz := l.clean_address[130];
self.lot := l.clean_address[131..134];
self.lot_order := l.clean_address[135];
self.dbpc := l.clean_address[136..137];
self.chk_digit := l.clean_address[138];
self.rec_type := l.clean_address[139..140];
self.fips_state := l.clean_address[141..142];
self.fips_county := l.clean_address[143..145];
self.geo_lat := l.clean_address[146..155];
self.geo_long := l.clean_address[156..166];
self.msa := l.clean_address[167..170];
self.geo_blk := l.clean_address[171..177];
self.geo_match := l.clean_address[178];
self.err_stat := l.clean_address[179..182];
self := l;
end;

principal_fmt := project(principal_init, FormatClean(left));

principal_bus := principal_fmt(business_name <> '');
principal_per := principal_fmt((first_name + middle_initial + last_name) <> '');

// Did the Principal Persons
did_matchset := ['A','S'];

did_add.MAC_Match_Flex(principal_per, did_matchset,
	 ssn_taxid, dob_field, fname, mname,lname, name_suffix,
	 prim_range, prim_name, sec_range, zip, st, phone_field,
	 did,
	 Layout_Principal_Clean,
	 false, did_score_field,
	 75,
	 principal_did)

// BDID the Principal Businesses
bdid_matchset := ['A','F'];

Business_Header_SS.MAC_Add_BDID_Flex(principal_bus,
                                  bdid_matchset,
                                  business_name,
                                  prim_range, prim_name, zip,
                                  sec_range, st,
                                  phone_field, ssn_taxid,
                                  bdid, Layout_Principal_Clean,
                                  FALSE, BDID_score_field,
                                  principal_bdid)

principal_combined := principal_did + principal_bdid;
principal_combined_sort := sort(principal_combined, rid);

Layout_Principal_Clean RollupPrincipal(Layout_Principal_Clean l, Layout_Principal_Clean r) := transform
self.did := if(l.did <> 0, l.did, r.did);
self.bdid := if(l.bdid <> 0, l.bdid, r.bdid);
self := l;
end;


principal_combined_rollup := rollup(principal_combined_sort, left.rid = right.rid, RollupPrincipal(left, right));


export principal_prep := principal_combined_rollup : persist('TEMP::equifax_principal_clean');
