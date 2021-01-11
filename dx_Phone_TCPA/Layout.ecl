EXPORT Layout := MODULE
	
	EXPORT i_tcpa_phone_history := RECORD
			string10		phone;
			boolean			is_current;
			unsigned8		dt_first_seen;
			unsigned8		dt_last_seen;
			string1			phone_type;
	END;

END;
