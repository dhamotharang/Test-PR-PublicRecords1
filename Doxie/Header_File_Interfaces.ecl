

EXPORT Header_File_Interfaces := MODULE

	// Define interfaces consisting of personally-identifying and 
	// address information pertaining to a single person:
	EXPORT i_PersonalInfo_Basic := 
		INTERFACE
			EXPORT UNSIGNED6 did   :=  0;
			EXPORT STRING30  fname := '';
			EXPORT STRING30  mname := '';
			EXPORT STRING30  lname := '';
			EXPORT STRING9   ssn   := '';
			EXPORT UNSIGNED4 dob   :=  0;	
		END;
	
	EXPORT i_AddressInfo_Basic :=
		INTERFACE
			EXPORT STRING10 prim_range := ''; 
			EXPORT STRING2  predir     := ''; 
			EXPORT STRING28 prim_name  := '';
			EXPORT STRING4  suffix     := '';
			EXPORT STRING2  postdir    := '';
			EXPORT STRING8  sec_range  := '';
			EXPORT STRING25 city       := '';
			EXPORT STRING2  state      := '';	
			EXPORT SET OF INTEGER4 zips := [];
		END;
	
END;