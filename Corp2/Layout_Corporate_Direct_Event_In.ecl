export Layout_Corporate_Direct_Event_In := record

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
	
string500 event_desc; //modified length from 100 to 500
	
end;