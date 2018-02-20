import header;

export unsigned3 get_header_last_seen(header.layout_header L) :=  
  header.get_last_seen(l.dt_first_seen,l.dt_last_seen,l.dt_vendor_first_reported,l.dt_vendor_last_reported);