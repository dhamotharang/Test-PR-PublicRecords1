IMPORT progressive_phone;

EXPORT layout_experian_phones := RECORD
	STRING15 Seq := '';
	progressive_phone.layout_progressive_phone_common;
	STRING15 ExperianPIN := '';
	STRING3 Phone_Last3Digits := '';
END;