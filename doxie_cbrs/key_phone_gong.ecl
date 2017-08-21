import gong_Neustar, doxie;
f := gong_Neustar.File_Gong_Full_Prepped_For_Keys_1(phone10 <> '' and (integer)phone10 <> 0);

export key_phone_gong := INDEX(f, 
{phone10},
{f}, 
'~thor_data400::key::cbrs.phone10_gong_' + doxie.Version_SuperKey);