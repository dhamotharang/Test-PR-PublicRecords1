import risk_indicators;

export layout_person_phone := record
	layout_phone;
	dataset(risk_indicators.Layout_Desc) HRI_Phone { maxcount(consts.max_hri_phone) };
end;