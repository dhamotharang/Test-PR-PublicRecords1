import doxie, data_services;

df1 := corp.File_Corp_Base(bdid != 0);

export key_Corp_base_bdid_pl := 
index(
df1,
{bdid},
{df1},data_services.data_location.prefix() + 'thor_data400::key::corp_base_bdid_pl_' + doxie.Version_SuperKey);
