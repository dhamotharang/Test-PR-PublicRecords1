IMPORT address;

EXPORT ca_CA (string addr_first_line, string addr_second_line) := MODULE (ICleanAddress)
  // force to parse first address line even when city, state, etc. not provided:
  shared second_line_adjusted := IF (trim (addr_second_line) != '', addr_second_line, 'Vancouver BC');

  shared string clean_addr := Address.CleanCanadaAddress109 (addr_first_line, addr_second_line) : GLOBAL;
  // direct call:
//  shared string clean_addr := CanadaCleanLib.CanadaAddress109 (addr_first_line, addr_second_line,, 'victor2.br.seisint.com', 12345) : GLOBAL;
  export string prim_range := clean_addr [1..10];
  export string predir     := clean_addr [11..12];
  export string prim_name  := clean_addr [13..40];
  export string suffix     := clean_addr [41..44];
  export string unit_desig := clean_addr [45..54];
  export string sec_range  := clean_addr [55..62];
  export string p_city     := clean_addr [63..92];
  export string v_city     := p_city;
  export string state      := clean_addr [93..94];
  export string province   := state;
  export string zip        := clean_addr [95..100];

	export string addr_type  := clean_addr [101..102];
  export string language   := clean_addr [103];
  export string error_msg  := clean_addr [104..109];
END;
