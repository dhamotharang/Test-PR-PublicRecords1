import mdr, drivers, doxie, business_header_ss;
doxie.MAC_Header_Field_Declare();

bhk2 := business_header_ss.key_bh_bdid_pl;

export clean_dppa_glba_records(dataset(recordof(bhk2)) infile) := function
  return infile(~dppa OR (dppa_ok and drivers.state_dppa_ok(vendor_st,dppa_purpose,,source)));
end;