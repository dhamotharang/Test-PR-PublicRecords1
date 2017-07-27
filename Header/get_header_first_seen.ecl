import header;
export unsigned3 get_header_first_seen(header.Layout_Header L) := 
  header.get_first_seen(l.dt_first_seen,l.dt_last_seen,l.dt_vendor_first_reported,l.dt_vendor_last_reported);