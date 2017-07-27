import Risk_Indicators;

export GetNewAreaCodeDate(STRING3 old_npa_in,STRING7 phone) := FUNCTION
	p_start := Risk_Indicators.Key_AreaCode_Change(old_nxx = phone[1..3] AND old_npa = old_npa_in);
	RETURN IF(old_npa_in = '','',p_start[1].permissive_start);
END;