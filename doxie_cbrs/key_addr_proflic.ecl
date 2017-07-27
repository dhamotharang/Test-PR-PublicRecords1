import prof_license, doxie;
d := prof_license.file_keybase(prim_name <> '' and zip <> '');

export key_addr_proflic := index(d,
{prim_name,prim_range,zip,sec_range},
{d},
'~thor_data400::key::cbrs.addr_proflic_' + doxie.Version_SuperKey);