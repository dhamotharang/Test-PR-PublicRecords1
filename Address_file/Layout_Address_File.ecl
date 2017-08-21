export Layout_address_file := record
 unsigned6 address_id := 0;
 string1   src_header;
 string1   src_bus_header;
 string1   src_pcnsr;
 string1   src_gong;
 string3   src_property;
 string1   src_so;
 string1   resident_flag;
 string1   business_flag;
 string1   govt_flag;
 Address_file.Layout_Clean_Address_FieldsToKeep;
end;
 


