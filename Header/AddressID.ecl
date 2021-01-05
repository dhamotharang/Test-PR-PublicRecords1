IMPORT $, dx_Header;

EXPORT AddressID($.layout_header h) := dx_Header.functions.AddressID_Fromparts(
                         h.prim_range, h.predir, h.prim_name, h.suffix,
                         h.postdir, h.sec_range, h.zip, h.st);
