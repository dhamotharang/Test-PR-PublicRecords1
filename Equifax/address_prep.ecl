import Address;

// Clean input information
layout_input_init := record
Layout_Address;
string182 clean_address;
end;

layout_input_init CleanInput(Layout_Address l) := transform
self.clean_address := AddrCleanLib.CleanAddress182(l.delivery_line, trim(l.city_name) + ' ' + l.state + ' ' + l.zip_code[1..5]);
self.phone_number1 := Address.CleanPhone(l.phone_number1);
self.phone_number2 := Address.CleanPhone(l.phone_number2);
self.phone_number3 := Address.CleanPhone(l.phone_number3);
self.phone_number4 := Address.CleanPhone(l.phone_number4);
self.phone_number5 := Address.CleanPhone(l.phone_number5);
self := L;
end;

address_init := project(File_Address, CleanInput(left));


// Format the clean address fields
Layout_Address_Clean FormatClean(layout_input_init l) := transform
self.prim_range := l.clean_address[1..10];
self.predir := l.clean_address[11..12];
self.prim_name := l.clean_address[13..40];
self.addr_suffix := l.clean_address[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
self.postdir := l.clean_address[45..46];
self.unit_desig := l.clean_address[47..56];
self.sec_range := l.clean_address[57..64];
self.p_city_name := l.clean_address[65..89];
self.v_city_name := l.clean_address[90..114];
self.st := l.clean_address[115..116];
self.zip := l.clean_address[117..121];
self.zip4 := l.clean_address[122..125];
self.cart := l.clean_address[126..129];
self.cr_sort_sz := l.clean_address[130];
self.lot := l.clean_address[131..134];
self.lot_order := l.clean_address[135];
self.dbpc := l.clean_address[136..137];
self.chk_digit := l.clean_address[138];
self.rec_type := l.clean_address[139..140];
self.fips_state := l.clean_address[141..142];
self.fips_county := l.clean_address[143..145];
self.geo_lat := l.clean_address[146..155];
self.geo_long := l.clean_address[156..166];
self.msa := l.clean_address[167..170];
self.geo_blk := l.clean_address[171..177];
self.geo_match := l.clean_address[178];
self.err_stat := l.clean_address[179..182];
self := l;
end;

export address_prep := project(address_init, FormatClean(left)) : persist('TEMP::equifax_address_clean');