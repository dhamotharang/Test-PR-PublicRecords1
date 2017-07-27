IMPORT doxie;

EXPORT ca_US (string addr_first_line, string addr_second_line) := MODULE (ICleanAddress)
  // force to parse first address line even when city, state, etc. not provided:
  shared second_line_adjusted := IF (trim (addr_second_line) != '', addr_second_line, 'New York NY');

  shared string clean_addr := doxie.cleanaddress182 (addr_first_line, addr_second_line) : GLOBAL;

  export string prim_range := clean_addr [1..10];
  export string predir     := clean_addr [11..12];
  export string prim_name  := clean_addr [13..40];
  export string suffix     := clean_addr [41..44];
  export string postdir    := clean_addr [45..46];
  export string unit_desig := clean_addr [47..56];
  export string sec_range  := clean_addr [57..64];
  export string p_city     := clean_addr [65..89];
  export string v_city     := clean_addr [90..114];

  export string state := clean_addr [115..116];
  export string zip   := clean_addr [117..121];

  export string zip4       := clean_addr [122..125];
  export string cart       := clean_addr [126..129];
  export string cr_sort_sz := clean_addr [130];
  export string lot        := clean_addr [131..134];
  export string lot_order  := clean_addr [135];
  export string dbpc       := clean_addr [136..137];
  export string chk_digit  := clean_addr [138];
  export string rec_type   := clean_addr [139..140];
  export string county     := clean_addr [141..145];
  export string geo_lat    := clean_addr [146..155];
  export string geo_long   := clean_addr [156..166];
  export string msa        := clean_addr [167..170];
  export string geo_blk    := clean_addr [171..177];
  export string geo_match  := clean_addr [178];
  export string error_msg  := clean_addr [179..182];
END;



