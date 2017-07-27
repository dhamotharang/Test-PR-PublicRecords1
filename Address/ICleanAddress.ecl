EXPORT ICleanAddress := INTERFACE
  export string prim_range := '';      // same for US and CAN
  export string predir     := '';      // same for US and CAN
  export string prim_name  := '';      // same for US and CAN
  export string suffix     := '';      // same for US and CAN
  export string postdir    := '';
  export string unit_desig := '';
  export string sec_range  := '';
  export string p_city     := '';
  export string v_city     := '';
  export string state      := '';
  export string province   := '';
  export string zip        := '';
  export string address_type := '';
  export string latitude   := '';
  export string longitude  := '';
  export string geo_blk    := '';
  export string geo_match  := '';

  // so far not used in doxie.MAC_Header_Field_Declare:
  export string zip4 := 		'';
  export string county := '';
  export string error_msg  := '';
END;
