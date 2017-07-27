import risk_indicators;

export layout_person_address := record
	layout_address;
	UNSIGNED3	 	addr_dt_last_seen;
	dataset(risk_indicators.Layout_Desc) HRI_Address	{ maxcount(consts.max_hri_addr) };
end;