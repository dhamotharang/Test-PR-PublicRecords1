lc := doxie_cbrs.layout_contacts;

export layout_contact_address := record

unsigned4 address_id := 0;

lc.prim_range;
lc.predir;
lc.prim_name;
lc.addr_suffix;
lc.postdir;
lc.unit_desig;
lc.sec_range;
lc.city;
lc.state;
lc.zip;
lc.zip4;
lc.county;
lc.msa;
lc.geo_lat;
lc.geo_long;

end;