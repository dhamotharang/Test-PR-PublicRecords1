import address;
//retrieve the clean address cache
addr_clean := Address.File_Address_Cache;
addr_clean_dist := distribute(addr_clean, hash(trim(addr1), trim(addr2)));
addr_clean_sort := sort(addr_clean_dist, trim(addr1), trim(addr2), local);

// Clean the addresses
Address.Layout_Address_Cache CleanAddresses(Address.Layout_Address_Cache L) := transform
self.clean := Address.CleanAddress182((string)L.addr1,(string)L.addr2);
self := L;
end;

addr_clean1 := project(sample(addr_clean,10,1), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_1');
addr_clean2 := project(sample(addr_clean,10,2), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_2');
addr_clean3 := project(sample(addr_clean,10,3), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_3');
addr_clean4 := project(sample(addr_clean,10,4), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_4');
addr_clean5 := project(sample(addr_clean,10,5), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_5');
addr_clean6 := project(sample(addr_clean,10,6), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_6');
addr_clean7 := project(sample(addr_clean,10,7), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_7');
addr_clean8 := project(sample(addr_clean,10,8), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_8');
addr_clean9 := project(sample(addr_clean,10,9), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_9');
addr_clean10 := project(sample(addr_clean,10,10), CleanAddresses(left)) : persist('~thor_200::persist::address_cache::clean_10');

addr_reclean_dist := distribute(addr_clean1 + addr_clean2 + addr_clean3 + addr_clean4 + addr_clean5 + addr_clean6 + addr_clean7 + addr_clean8
                   + addr_clean9 + addr_clean10, hash(trim(addr1), trim(addr2)));
addr_reclean_sort := sort(addr_reclean_dist, trim(addr1), trim(addr2), local);

//create new address cache

Address.Layout_Address_Cache tjoin(addr_reclean_sort R, addr_clean_sort L) := transform

self.clean := if(R.clean[179] = 'E' and L.clean[179] = 'S', L.clean, R.clean);
self := R;
end;

new_addr_clean := join(addr_reclean_sort, addr_clean_sort, trim(left.addr1) = trim(right.addr1) and 
                  trim(left.addr2) = trim(right.addr2), tjoin(left, right),local);
output(new_addr_clean,,'~thor_200::BASE::Address_Cache_' + Address.Version_Address_Cache, overwrite);


