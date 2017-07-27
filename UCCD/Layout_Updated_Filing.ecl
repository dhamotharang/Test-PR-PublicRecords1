export Layout_Updated_Filing := record

	unsigned6 	 bdid := 0;
	unsigned6 	 did := 0;
	
	unsigned4    dt_first_seen;
	unsigned4    dt_last_seen;
	unsigned4    dt_vendor_first_reported;
	unsigned4    dt_vendor_last_reported;
	string1 		 record_type := 'H';  //current/historical

	uccd.Layout_UCC_filing_In;
	
end;