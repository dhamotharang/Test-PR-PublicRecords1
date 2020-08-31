import risk_indicators,Location_Services;

export Layout_address_hist := record
	layout_address;
	string8   Dt_First_Seen;
	string8   Dt_Last_Seen;
	boolean	Owned_by_Subject;
	dataset(risk_indicators.Layout_Desc)	HRI_address			{ maxcount(Location_Services.consts.max_hri_addr) };
	dataset(layout_phone)									phones_children	{ maxcount(Location_Services.consts.max_hri_phone) };
end;