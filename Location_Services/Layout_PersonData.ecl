import risk_indicators;

export Layout_PersonData := RECORD	
	UNSIGNED6					 did;
	Layout_Name;
	dataset(Layout_person_Address)	current_address	{ maxcount(1) };
	dataset(layout_person_phone)		phones					{ maxcount(consts.max_phones) };
	dataset(layout_person_ssn)			HRI_SSN					{ maxcount(consts.max_hri_ssn) };
	boolean					 mortgage_fraud_area;
END;