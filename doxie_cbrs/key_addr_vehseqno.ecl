IMPORT doxie_files, doxie, data_services;

d0 := doxie_files.File_VehicleContacts(prim_name <> '' AND zip5 <> '' AND seq_no <> 0);
d := DEDUP(d0, prim_name,prim_range,zip5,sec_range, seq_no, ALL);

EXPORT key_addr_vehseqno := index(d,
{prim_name,prim_range,zip5,sec_range},
{seq_no},
data_services.data_location.prefix() + 'thor_data400::key::cbrs.addr_vehseqno_' + doxie.Version_SuperKey);
