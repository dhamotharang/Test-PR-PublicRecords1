import risk_indicators;

export layout_SSN_INFO := record
	string9	ssn;
	string1	valid_ssn;
	unsigned3	ssn_issue_early;
	unsigned3	ssn_issue_last;
	string2	ssn_issue_place;
	dataset(risk_indicators.Layout_Desc) HRI_SSN	{ maxcount(consts.max_hri_ssn) };
end;
