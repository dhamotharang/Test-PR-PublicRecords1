export layout_events_out := RECORD

  string30 corp_supp_key;
	unsigned4 dt_last_seen;
	unsigned4 corp_process_date;
	string30  event_filing_reference_nbr;
	string3   event_amendment_nbr;
	string8	  event_filing_date;
	string3   event_date_type_cd; // do we want this?
	string30  event_date_type_desc;
	string8	  event_filing_cd;
	string60  event_filing_desc;
	string32  event_corp_nbr;
	string1   event_corp_nbr_cd;
	string30  event_corp_nbr_desc;
	string10  event_roll;
	string10  event_frame;
	string8   event_start;
	string8   event_end;
	string10  event_microfilm_nbr;		
	string500 event_desc;
	end;