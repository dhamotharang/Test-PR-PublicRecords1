IMPORT header_services;

EXPORT file_supplemental := module


EXPORT in_supp := utilfile.regulatory.supplemental_data();

//cleanup driver license and phone
UtilFile.mac_cleandates(in_supp,dates_out)
utilfile.mac_convert_util_type(dates_out, convert_out)
Utilfile.Mac_clean_phone(convert_out, phone_out)

EXPORT out_supp := phone_out;//DF-26747 Remove Persist

end;