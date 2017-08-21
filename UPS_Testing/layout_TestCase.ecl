IMPORT UPS_Services;
Constant := UPS_Services.Constants;

export layout_TestCase := RECORD
	STRING4   queryID := '0';
	STRING60  fname := '';
	STRING60  mname := '';
	STRING60  lname := '';
	STRING120 cname := '';
	STRING120 addr := '';
	STRING60  city := '';
	STRING60  state := '';
	STRING5   zip := '';
	STRING10  phone := '';
	STRING100 powersearch := '';
	STRING12  entityType := Constant.TAG_ENTITY_UNK;
END;