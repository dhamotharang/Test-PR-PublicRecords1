EXPORT Layout_Corporate_Direct_Event_Base_Expanded := record
	unsigned6 	bdid := 0;       // Seisint Business Identifier
	unsigned4 	dt_first_seen;
	unsigned4 	dt_last_seen;
	unsigned4 	dt_vendor_first_reported;
	unsigned4 	dt_vendor_last_reported;
	Layout_Corporate_Direct_Event_In;
	string250		event_revocation_comment1;
	string250		event_revocation_comment2;
	string9			event_book_number;
	string9			event_page_number;
	string9			event_certification_number;
	STRING1   	record_type;	// 'C' Current
														// 'H' Historical	
end;