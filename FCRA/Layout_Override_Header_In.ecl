import Doxie,Risk_Indicators;
EXPORT Layout_Override_Header_In := record
	recordof(Doxie.Key_Header) - [global_sid,record_sid] head;
	Risk_Indicators.Layouts.Layout_Addr_Flags2 Addr_Flags;
	string2 high_risk_address_source := '';
	string50 high_risk_address_description := ''; 
	string35 blankout;
	string14 date_created;
end;