import doxie, bankrupt,data_services;

f := Bankrupt.File_BK_Search;

export Key_Bkrupt_Address := INDEX(f, {prim_name, st, z5, prim_range, sec_range}, {f}, data_services.data_location.prefix() + 'thor_data400::key::bkrupt_address_'+doxie.Version_SuperKey);