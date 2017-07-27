IMPORT doxie;

EXPORT layout_addr_connect_date := RECORD
  doxie.Layout_Rollup.AddrRec_feedback AND NOT [phoneRecs,address_cds];
  UNSIGNED4 connect_date;
	STRING30 util_type;
	unsigned6 did;
END;
