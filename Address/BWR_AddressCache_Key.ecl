#workunit('name','Build Address Cache Key');

//Build address cache key
buildindex(address.Key_AddressCache, '~thor_data400::key::address_cache.addr1.addr2',overwrite);

/*
//Build the prim_name, city, st, zip key
h := header.file_headers;

tab := record
	h.prim_name;
	h.city_name;
	h.st;
	h.zip;
	unsigned8	fake := 0;
end;

h2 := table(h,tab);

h3 := dedup(h2,all);

tab2 := record
	h3.prim_name;
	h3.city_name;
	h3.st;
	unsigned2	cnt := count(group);
end;

h4 := table(h3,tab2,prim_name,city_name,st);

tab make_table(h3 L, h4 R) := transform
	self := L;
end;

h5 := join(distribute(h3,hash(prim_Name,city_name,st)),distribute(h4,hash(prim_Name,city_name,st)),
				left.prim_name = right.prim_name and 
				left.city_name = right.city_name and
				left.st = right.st and right.cnt = 1,
				make_table(LEFT,RIGHT),local);

buildindex(h5,,'~thor_Data400::key::pname_city_st_to_zip',overwrite);
*/