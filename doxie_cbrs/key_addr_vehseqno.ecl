import doxie_files, doxie;
d0 := doxie_files.File_VehicleContacts(prim_name <> '' and zip5 <> '' and seq_no <> 0);
d := dedup(d0, prim_name,prim_range,zip5,sec_range, seq_no, all);

export key_addr_vehseqno := index(d,
{prim_name,prim_range,zip5,sec_range},
{seq_no},
'~thor_data400::key::cbrs.addr_vehseqno_' + doxie.Version_SuperKey);