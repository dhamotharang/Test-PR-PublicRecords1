export Layout_UCC_Event_In := record
string50  ucc_key;
string2   ucc_vendor;
string2   ucc_state_origin;
string8   ucc_process_date;
//
string1	processing_rule;
//
string32  ucc_filing_num;
string8   ucc_filing_date;
string4   ucc_filing_time;
//
string20  event_key;
//
string1   event_trans_type;
string8   event_trans_date;
//
string32  event_reference_num;
string32  event_document_num;
//
string8   event_date;
string4   event_time;
string8   event_type_cd;
string60  event_type_desc;
string8   event_action_cd;
string60  event_action_desc;
string25  event_place_id;
string60  event_place_desc;
//
string30  event_document_pages;
string512 event_desc;
//
//string4	event_std_type;
//string25	event_std_collateral_cds;
end;

/*
ucc_key	UCC key to link records
ucc_vendor	Filing state FIPS code
ucc_state_origin	Filing state code
ucc_process_date	Vendor extract date
	PROCESSING RULE
processing_rule	Identifier to determine if relationship exists between events & party and events & collateral. ('V' if yes, blank if no.)
	UCC FILING INFORMATION
ucc_filing_num	Uniform Commercial Code (UCC) state Identifier for the filing
ucc_filing_date	Original filing date
ucc_filing_time	Original filing time
	KEY(S)
event_key	Key to identify event(s) associated with UCC (e.g. "<fips_code>-event_key")
	EVENT INFORMATION
event_trans_type	Type of transaction: 'C'reate, 'R'eplace, 'U'pdate, 'D'elete or <blank>
event_trans_date	Transaction date
event_reference_num	Reference number
event_document_num	Document number
event_date	Event date
event_time	Event time
event_type_cd	Event type (code)
event_type_desc	Event type (description)
event_action_cd	Type of action (code)
event_action_desc	Type of action (description)
event_place_id	Location of event
event_place_desc	Location of event (description)
event_document_pages	Number of pages for event
event_desc	Event description (Populate with Life Expectancy, Expiration Date, and other relevant Initial Filing data not already mapped.)
*/