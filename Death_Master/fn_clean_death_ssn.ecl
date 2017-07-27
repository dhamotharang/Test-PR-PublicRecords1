IMPORT ut;

// If allowPlus4=TRUE, this function will allow SSNs such as *****1234, 9876, 000003456
// If allowPlus4=FALSE, all invalid SSN's will be removed.
EXPORT fn_clean_death_ssn(STRING9 in_ssn, BOOLEAN allowPlus4=TRUE) := FUNCTION

	set_invalid_ssn	:= ['000000000','111111111','222222222','333333333','444444444','555555555',
											'666666666','777777777','888888888','999999999','123456789'];
	
	// If we are allowing LAST4, Replace characters with zero and make length 9 digits
	my_ssn	:=	IF(allowPlus4,INTFORMAT((UNSIGNED)(REGEXREPLACE('[^0-9]',TRIM(in_ssn,ALL),'0')),9,1),in_ssn);
		
	BOOLEAN	is_invalid_length		:= ut.ssn_length(my_ssn) <> 9;
	BOOLEAN	is_not_numeric			:= ~(ut.isNumeric(my_ssn));
	BOOLEAN	is_invalid_ssn			:= my_ssn IN set_invalid_ssn;
	BOOLEAN	is_666							:= my_ssn[1..3]='666';
	BOOLEAN	is_advertising			:= my_ssn between '987654320' and '987654329';
	BOOLEAN	is_woolworth				:= my_ssn='078051120';
	BOOLEAN	is_invalid_area			:= my_ssn[1..3]= '000';
	BOOLEAN	is_invalid_group		:= my_ssn[4..5]=  '00';
	BOOLEAN	is_invalid_serial		:= my_ssn[6..9]='0000';

	clean_ssn	:=	IF(allowPlus4,
										// Allows SSN=000001234
										IF(
												is_not_numeric		OR
												is_invalid_ssn		OR
												is_666						OR
												is_advertising		OR
												is_woolworth			OR
												is_invalid_serial
												,'',my_ssn
										),
										//	Does a full SSN check
										IF(
												is_invalid_length	OR
												is_not_numeric		OR
												is_invalid_ssn		OR
												is_666						OR
												is_advertising		OR
												is_woolworth			OR
												is_invalid_area		OR
												is_invalid_group	OR
												is_invalid_serial
												,'',my_ssn
										)
									);

	RETURN clean_ssn;
END;
