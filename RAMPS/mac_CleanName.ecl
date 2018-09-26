IMPORT Address;

EXPORT mac_CleanName(JobId, InData, InName, OutFile) := MACRO

InputData := InData;

AddressClean_rec := RECORD
  recordof(InputData);
	//cleaned input address
	INTEGER   SEQ;
	STRING    clean_fname;
	STRING    clean_mname;
	STRING    clean_lname;
END;

AddressClean_rec CleanName(InputData l, INTEGER c) := TRANSFORM
			SELF.seq := c;
			clean_name := Address.CleanPersonFML73(l.InName);
			SELF.clean_fname := clean_name[6..25];
			SELF.clean_mname := clean_name[26..45];
			SELF.clean_lname := clean_name[46..65];
			SELF := l;
			SELF := [];
	END;

OutFile := PROJECT(InputData, CleanName(LEFT, COUNTER));
ENDMACRO;