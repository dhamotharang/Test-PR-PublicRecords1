IMPORT doxie,Risk_Indicators;

// impelmentation of 'Social Securtiy Number Randomization_Requirements_v1 8.docx' 
EXPORT random_ssn(STRING9 ssn,UNSIGNED6 did) := MODULE

	pocketbook_ssn := ['022281852','042103580','062360749','062360794','078051120','095073645',
		'128036045','135016629','141186941','165167999','165187999','165207999','165247999','189092294',
		'212097694','212099999','219099998','219099999','306302348','308125070','468288779','549241889'];

	BOOLEAN is_numeric        := REGEXFIND('^[0-9]{9}$',ssn);
	BOOLEAN is_900_999        := ssn[1] = '9';
	BOOLEAN is_666            := ssn[1..3] = '666';
	BOOLEAN is_invalid_area   := ssn[1..3] = '000';
	BOOLEAN is_invalid_group  := ssn[4..5] = '00';
	BOOLEAN is_invalid_serial := ssn[6..9] = '0000';
	BOOLEAN is_pocketbook     := ssn IN pocketbook_ssn;

	// section 6.1.1.3
	EXPORT BOOLEAN is_invalid := (NOT is_numeric) OR is_900_999 OR is_666 OR is_invalid_area
		OR is_invalid_group OR is_invalid_serial OR is_pocketbook; 

	// section 6.1.2.4
	EXPORT issued := JOIN(DATASET([{ssn}],{STRING9 ssn}), doxie.Key_SSN_Map,
						KEYED(LEFT.ssn [1..5] = RIGHT.ssn5) AND
						KEYED(LEFT.ssn [6..9] BETWEEN RIGHT.start_serial AND RIGHT.end_serial),
						KEEP(1));

	EXPORT BOOLEAN is_random := NOT EXISTS(issued) AND NOT is_invalid;

	// section 6.1.3.4
	EXPORT BOOLEAN is_legacy := is_random AND Risk_Indicators.searchLegacySSN(ssn,did); 

	EXPORT code := MAP(
		is_invalid => '0006', // SSN is invalid.
		is_legacy =>  '0160', // SSN is potentially randomized by the SSA, but invalid when first associated with the consumer.
		is_random =>  '0155', // SSN is potentially randomized by the SSA.
		'');
END;