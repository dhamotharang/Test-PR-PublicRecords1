import header;

r := header.File_SSN_Map;

a := BUILDINDEX(r,{
ssn5,
start_date,
end_date,
state_name,
status_code,(big_endian unsigned8 )__filepos},'key::ssn_map' + version_keys, overwrite);

export proc_Util_Keys := a;