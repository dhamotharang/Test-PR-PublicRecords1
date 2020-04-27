IMPORT dx_Header;

export AddressID_fromparts(string prim_range,string predir,string prim_name,
                           string suffix, string postdir,string sec_range,
                           string zip, string st) :=
  dx_Header.functions.AddressID_fromparts(prim_range, predir, prim_name,
                            suffix,  postdir, sec_range,
                            zip,  st);
