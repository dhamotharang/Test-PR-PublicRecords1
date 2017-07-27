import Risk_Indicators;

export GetNewAreaCode(STRING3 old_npa_in,STRING7 phone) := FUNCTION
	new_npa_recs := Risk_Indicators.Key_AreaCode_Change(old_nxx = phone[1..3] AND old_npa = old_npa_in);
	RETURN IF(old_npa_in = '','',new_npa_recs[1].new_npa);
END;