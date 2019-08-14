import gong, doxie, data_services;

f := PROJECT(gong.File_Gong_full(phone10 <> '' and (integer)phone10 <> 0), gong.Layout_bscurrent_raw);

export key_phone_gong := INDEX(f, 
{phone10},
{f}, 
data_services.data_location.prefix() + 'thor_data400::key::cbrs.phone10_gong_' + doxie.Version_SuperKey);