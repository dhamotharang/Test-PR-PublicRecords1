import doxie, Risk_Indicators;

// if you add fields to this layout, also add the same fields to riskwise.layouts_vru.layout_header_data
export Layout_Override_Header := RECORD
	recordof(Doxie.Key_Header)- [global_sid, record_sid] head;
	Risk_Indicators.Layouts.Layout_Addr_Flags2 Addr_Flags;
	string2 high_risk_address_source := '';
	string50 high_risk_address_description := ''; 
	string35 blankout;
END;