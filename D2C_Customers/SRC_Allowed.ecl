D2C_AND_BULK_Allowed_PL  := [''];
D2C_AND_BULK_Allowed_PR  := [''];

EXPORT SRC_Allowed(unsigned1 record_type, string src) := 
      case(record_type,
		1 => src in D2C_AND_BULK_Allowed_PL,
		2 => src in D2C_AND_BULK_Allowed_PR,
		src in D2C_AND_BULK_Allowed_PR
	   );