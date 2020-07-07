import Seed_Files;

EXPORT fn_call_aml_batch_service(DATASET(reunion.layouts.lMainRaw) input) := FUNCTION

    kAML := pull(Seed_Files.key_AMLRiskAttributes);
	
	input append_attributes(input le, kAML re) := TRANSFORM
		SELF.IndLegalEventsIndex :=  (STRING3)if((integer)re.IndLegalEventsIndex < 0, '0', re.IndLegalEventsIndex);
		SELF := le;
	END;
		
	result := JOIN(input, kAML, 
				   RIGHT.hashvalue = Seed_Files.Hash_InstantID((STRING20)LEFT.fname, (STRING20)LEFT.lname,
									 LEFT.ssn, '', (STRING5)LEFT.zip, (STRING10)LEFT.phone, ''),
				   append_attributes(LEFT,RIGHT), LEFT OUTER, lookup);

	return result;

END;