export Layout_ID_canyon  
	:=RECORD
		STRING   ID;
		STRING   Name;
		STRING   Photo; // for some files this field is the arrest date.  This is dealt with in the mapping attribute.
		STRING   Charge;
	END;