import header, Business_Header, Gong, VehLic, Drivers, Property;
 
#workunit ('name', 'Build Address_Cache_' + Address.Version_Address_Cache);
 
// Extract unique addresses from Header
Address.Layout_Unique_Address AddrFromHeader(header.Layout_Header L) := transform
self := L;
end;
 
fh := project(dataset('~thor_data400::base::header_prod',header.Layout_Header,flat)(prim_name <> ''), AddrFromHeader(left));
 
// Extract addresses from Business Header
Address.Layout_Unique_Address AddrFromBusHeader(Business_Header.Layout_Business_Header_Base L) := transform
self.city_name := L.city;
self.zip := (qstring5)intformat(L.zip, 5, 1);
self.suffix := L.addr_suffix;
self.st := L.state;
self := L;
end;
 
fbh := project(Business_Header.File_Business_Header(prim_name <> ''), AddrFromBusHeader(left));
 
// Extract addresses from Gong
Address.Layout_Unique_Address AddrFromGong(Gong.Layout_bscurrent_raw L) := transform
self.city_name := L.p_city_name;
self.zip := L.z5;
self := L;
end;
 
fg := project(Gong.File_Gong_Dirty(prim_name <> ''), AddrFromGong(left));
 
// Extract owner and registrant addresses from Vehicles
Address.Layout_Unique_Address AddrFromVehicles(VehLic.Layout_Vehicles L, unsigned1 cnt) := transform
self.prim_range := choose(cnt, L.own_1_prim_range, L.own_2_prim_range, L.reg_1_prim_range, L.reg_2_prim_range);
self.predir := choose(cnt, L.own_1_predir, L.own_2_predir, L.reg_1_predir, L.reg_2_predir);
self.prim_name := choose(cnt, L.own_1_prim_name, L.own_2_prim_name, L.reg_1_prim_name, L.reg_2_prim_name);
self.suffix := choose(cnt, L.own_1_suffix, L.own_2_suffix, L.reg_1_suffix, L.reg_2_suffix);
self.postdir := choose(cnt, L.own_1_postdir, L.own_2_postdir, L.reg_1_postdir, L.reg_2_postdir);
self.unit_desig := choose(cnt, L.own_1_unit_desig, L.own_2_unit_desig, L.reg_1_unit_desig, L.reg_2_unit_desig);
self.sec_range := choose(cnt, L.own_1_sec_range, L.own_2_sec_range, L.reg_1_sec_range, L.reg_2_sec_range);
self.city_name := choose(cnt, L.own_1_p_city_name, L.own_2_p_city_name, L.reg_1_p_city_name, L.reg_2_p_city_name);
self.st := choose(cnt, L.own_1_state_2, L.own_2_state_2, L.reg_1_state_2, L.reg_2_state_2);
self.zip := choose(cnt, L.own_1_zip5, L.own_2_zip5, L.reg_1_zip5, L.reg_2_zip5);
end;
 
fvnorm := normalize(VehLic.File_Vehicles, 4, AddrFromVehicles(left, counter));
fv := fvnorm(prim_name <> '');
 
// Extract addresses from Drivers License
Address.Layout_Unique_Address AddrFromDL(drivers.layout_dl L) := transform
self.city_name := L.p_city_name;
self.zip := L.zip5;
self := L;
end;
 
fdl := project(Drivers.File_Dl(prim_name <> ''), AddrFromDL(left));
 
// Extract addresses from Fares_Assessor
Address.Layout_Unique_Address AddrFromAssessors(Property.Layout_Fares_Assessor L, unsigned1 cnt) := transform
self.prim_range := choose(cnt, L.prop_prim_range, L.own_prim_range);
self.predir := choose(cnt, L.prop_predir, L.own_predir);
self.prim_name := choose(cnt, L.prop_prim_name, L.own_prim_name);
self.suffix := choose(cnt, L.prop_suffix, L.own_suffix);
self.postdir := choose(cnt, L.prop_postdir, L.own_postdir);
self.unit_desig := choose(cnt, L.prop_unit_desig, L.own_unit_desig);
self.sec_range := choose(cnt, L.prop_sec_range, L.own_sec_range);
self.city_name := choose(cnt, L.prop_p_city_name, L.own_p_city_name);
self.st := choose(cnt, L.prop_st, L.own_ace_state);
self.zip := choose(cnt, L.prop_zip, L.own_ace_zip);
end;
 
ffanorm := normalize(Property.File_Fares_Assessor, 2, AddrFromAssessors(left, counter));
ffa := ffanorm(prim_name <> '');
 
// Extract addresses from Fares_Deeds
Address.Layout_Unique_Address AddrFromDeeds(Property.Layout_Fares_Deeds L, unsigned1 cnt) := transform
self.prim_range := choose(cnt, L.prop_prim_range, L.own_prim_range);
self.predir := choose(cnt, L.prop_predir, L.own_predir);
self.prim_name := choose(cnt, L.prop_prim_name, L.own_prim_name);
self.suffix := choose(cnt, L.prop_suffix, L.own_suffix);
self.postdir := choose(cnt, L.prop_postdir, L.own_postdir);
self.unit_desig := choose(cnt, L.prop_unit_desig, L.own_unit_desig);
self.sec_range := choose(cnt, L.prop_sec_range, L.own_sec_range);
self.city_name := choose(cnt, L.prop_p_city_name, L.own_p_city_name);
self.st := choose(cnt, L.prop_ace_state, L.own_ace_state);
self.zip := choose(cnt, L.prop_ace_zip, L.own_ace_zip);
end;
 
ffdnorm := normalize(Property.File_Fares_Deeds, 2, AddrFromDeeds(left, counter));
ffd := ffdnorm(prim_name <> '');
 
// combine all unique component addresses and dedup
addr_init := fh + fbh + fg + fv + fdl + ffa + ffd;
 

Layout_Raw_Address := record
  qstring120 addr1;
  qstring120 addr2;
end;
 
Layout_Raw_Address FormAddrFromComponents(Address.Layout_Unique_Address L) := transform
self.addr1 := (qstring)Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name,
                                  L.suffix, L.postdir, L.unit_desig, L.sec_range);
self.addr2 := (qstring)Address.Addr2FromComponents(L.city_name, L.st, L.zip);
end;
 
addr_raw := project(addr_init, FormAddrFromComponents(left));
 
addr_to_clean := addr_raw;
addr_to_clean_dedup := dedup(addr_to_clean, all) : persist('persist::vettemp::before_clean');
 
// Clean the addresses
Address.Layout_Address_Cache CleanAddresses(Layout_Raw_Address L) := transform
self.clean := AddrCleanLib.CleanAddress182((string)L.addr1,(string)L.addr2);
self := L;
end;
 
addr_clean1 := project(sample(addr_to_clean_dedup,4,1), CleanAddresses(left)) : persist('persist::vettemp::clean_1');
addr_clean2 := project(sample(addr_to_clean_dedup,4,2), CleanAddresses(left)) : persist('persist::vettemp::clean_2');
addr_clean3 := project(sample(addr_to_clean_dedup,4,3), CleanAddresses(left)) : persist('persist::vettemp::clean_3');
addr_clean4 := project(sample(addr_to_clean_dedup,4,4), CleanAddresses(left)) : persist('persist::vettemp::clean_4');
 

addr_clean_dist := distribute(addr_clean1 + addr_clean2 + addr_clean3 + addr_clean4, hash(trim(addr1), trim(addr2)));
 
output(addr_clean_dist,,'BASE::Address_Cache_' + Address.Version_Address_Cache, overwrite);