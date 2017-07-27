IMPORT doxie,lib_CanadaClean;

EXPORT Components := MODULE

// list of countries different address styles are supported for (ISO codes) 
EXPORT Country := MODULE
  export unsigned1 US := 0;
  export unsigned1 CA := 1;
END;


EXPORT Constants := MODULE
  export unsigned1 A_PRANGE  := 1;
  export unsigned1 A_PREDIR  := 2;
  export unsigned1 A_PNAME   := 3;
  export unsigned1 A_SUFFIX  := 4;
  export unsigned1 A_POSTDIR := 5; 
  export unsigned1 A_SRANGE  := 6;
  export unsigned1 A_CITY    := 7;   // "main" city value: v_city for US, p_city for Canada
  export unsigned1 A_CITY2   := 8;   // alternative city: p_city for US
  export unsigned1 A_STATE   := 9;
  export unsigned1 A_PROVINCE := A_STATE;  // province for Canada
  export unsigned1 A_ZIP     := 10;  // "main" zip: zip5 for US, (postal code) zip6 for Canada
  export unsigned1 A_ZIP2    := 11;
  export unsigned1 A_COUNTY  := 12;
  export unsigned1 A_ERROR   := 13;
END;

// splits into separate components using specific address cleaner
EXPORT set of string ComponentsSet (string addr_first_line, string addr_second_line, unsigned1 region) := FUNCTION
  // force to parse first address line even when city, state, etc. not provided:
  second_line_adjusted := IF (trim (addr_second_line) != '', 
                              addr_second_line,
                              MAP (region = Country.US => 'New York NY',
                                   region = Country.US => 'Vancouver BC', ''));

  string clean_addr := MAP (region = Country.US => doxie.cleanaddress182 (addr_first_line, second_line_adjusted),
                            region = Country.CA => CanadaCleanLib.CanadaAddress109 (addr_first_line, addr_second_line), '');
                                     
  string prim_range := clean_addr [1..10];       // same for US and CAN
  string predir     := clean_addr [11..12];      // same for US and CAN
  string prim_name  := clean_addr [13..40];      // same for US and CAN
  string suffix     := clean_addr [41..44];      // same for US and CAN
  string postdir    := CASE (region, 0=> clean_addr [45..46], '');
  string unit_desig := CASE (region, 0=> clean_addr [47..56], 1=> clean_addr [45..54], '');
  string sec_range  := CASE (region, 0=> clean_addr [57..64], 1=> clean_addr [55..62], '');
  string p_city     := CASE (region, 0=> clean_addr [65..89], 1=> clean_addr [63..92], '');
  string v_city     := CASE (region, 0=> clean_addr [90..114], '');
  string state      := CASE (region, 0=> clean_addr [115..116], 1=> clean_addr [93..94], '');
  string zip        := CASE (region, 0=> clean_addr [117..121], 1=> clean_addr [95..100], '');
  // so far not used in doxie.MAC_Header_Field_Declare:
//  string zip4 := 		clean_addr[122..125];
//  string county := 		clean_addr[141..145];
  string error_msg  := CASE (region, 0=> clean_addr [179..182], 1=> clean_addr [104..109], '');

  // add exactly in the order specified in Constants:
  components := [prim_range, predir, prim_name, suffix, postdir, sec_range, 
                 CASE (region, 0=> v_city, 1=> p_city, ''), //main city
                 p_city, state, zip, '', '', error_msg]; 
  return components;
END;

END;