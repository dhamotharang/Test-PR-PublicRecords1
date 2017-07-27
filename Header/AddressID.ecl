export AddressID(layout_header h) := 
  AddressID_Fromparts(h.prim_range,h.predir,h.prim_name,h.suffix,h.postdir,
     h.sec_range,h.zip,h.st);