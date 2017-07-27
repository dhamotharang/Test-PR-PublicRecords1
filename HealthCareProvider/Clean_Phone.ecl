import ut;
EXPORT Clean_Phone (STRING10 iPhone) := FUNCTION
	boolean isPhoneNumeric := ut.isNumeric (iPhone);
	boolean isValidPhone := regexfind('^[2-9]\\d{2}\\d{3}\\d{4}$', trim(iPhone));
	lastSeven := iPhone [4..10];
	isGTZero := (INTEGER) lastSeven > 0;
	RETURN IF (isPhoneNumeric AND isValidPhone AND isGTZero, iPhone, '');
END;