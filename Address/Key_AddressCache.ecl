import data_services;
full_file := file_address_cache;
export Key_AddressCache := index(full_file, {s_addr1 := (string120) addr1, s_addr2 := (string120) addr2}, {clean} ,data_services.data_location.prefix() + 'thor_data400::key::address_cache.addr1.addr2');