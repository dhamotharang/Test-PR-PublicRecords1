EXPORT Layouts := MODULE

EXPORT Inrec := RECORD 
  UNSIGNED  seleid,
  UNSIGNED  proxiD,
END; 

EXPORT BASE := RECORD 
  UNSIGNED  seleid,
  UNSIGNED  proxiD,
  STRING25  userid;
	UNSIGNED4 dt_added;
END;

END; 