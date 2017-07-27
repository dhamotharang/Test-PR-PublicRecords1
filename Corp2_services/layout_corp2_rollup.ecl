
IMPORT Corp2;

export layout_corp2_rollup := RECORD
	string30 corp_key;  
	string32  corp_orig_sos_charter_nbr;
	string32  corp_sos_charter_nbr; 
	string2	  corp_state_origin;
	string25 corp_state_origin_decoded;

	dataset(corp2_services.layout_contact_out) contacts{MAXCOUNT(Corp2.constants.MAXCOUNT_CONTACTS)};
	dataset(corp2_services.layout_events_out) events{MAXCOUNT(Corp2.constants.MAXCOUNT_EVENTS)};
	dataset(corp2_services.layout_stocks_out) stocks{MAXCOUNT(Corp2.constants.MAXCOUNT_STOCKS)};
	dataset(corp2_services.layout_ar_out) annual_reports{MAXCOUNT(Corp2.constants.MAXCOUNT_ANNUAL_REPORTS)};
	dataset(corp2_services.layout_corps_out) corp_hist{MAXCOUNT(Corp2.constants.MAXCOUNT_CORP_HIST)};
	dataset(corp2_services.layout_trades_out) tradenames{MAXCOUNT(Corp2.constants.MAXCOUNT_TRADENAMES)};
	dataset(corp2_services.layout_trades_out) trademarks{MAXCOUNT(Corp2.constants.MAXCOUNT_TRADEMARKS)};
end;    
