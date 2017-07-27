export Layout_Corporate_Direct_Event_Base := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
//Layout_Corporate_Direct_Event_In;
//**********************************************

string30  corp_key;
string30  corp_supp_key;
string2	  corp_vendor;
string3   corp_vendor_county;
string5   corp_vendor_subcode;
string2	  corp_state_origin;
string8	  corp_process_date;
string32  corp_sos_charter_nbr;
	
string30  event_filing_reference_nbr;
string3   event_amendment_nbr;
string8	  event_filing_date;
string3   event_date_type_cd;
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
//************************************This will be replaced with Event_In layout
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;