import doxie_build, Data_Services;

d:=dataset([], doxie_build.Layout_D2C_Lookup);

EXPORT key_D2C_lookup(string v='qa') := index(d,{did},{d},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::D2C_lookups_' + v);