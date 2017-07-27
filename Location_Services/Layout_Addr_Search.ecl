import risk_indicators;

export Layout_Addr_Search := record, maxlength(100000)
	layout_address;
	dataset(risk_indicators.Layout_Desc) hri_address;
	dataset(layout_phone) phones_children;
end;
