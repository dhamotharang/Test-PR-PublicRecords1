IMPORT header_services;

EXPORT file_supplemental := module

header_services.Supplemental_Data.mac_verify('file_utility_inj.thor',Utilfile.Layout_DID_Out,read);
 
EXPORT in_supp := read();

//cleanup driver license and phone
UtilFile.mac_cleandates(in_supp,dates_out)
utilfile.mac_convert_util_type(dates_out, convert_out)
Utilfile.Mac_clean_phone(convert_out, phone_out)

EXPORT out_supp := phone_out : persist('~thor_data400::persist::utility_supplemental_data');

end;