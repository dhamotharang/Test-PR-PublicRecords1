IMPORT mdr, drivers, doxie, business_header_ss;
doxie.MAC_Header_Field_Declare();

bhk2 := business_header_ss.key_bh_bdid_pl;

EXPORT clean_dppa_glba_records(DATASET(RECORDOF(bhk2)) infile) := FUNCTION
  RETURN infile(~dppa OR (dppa_ok AND drivers.state_dppa_ok(vendor_st,dppa_purpose,,source)));
END;
