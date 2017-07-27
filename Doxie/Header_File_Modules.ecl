
IMPORT doxie, Address;
	
doxie.MAC_Header_Field_Declare()
	
EXPORT Header_File_Modules := MODULE

	EXPORT m_AddressInfo_Basic :=
		MODULE(doxie.Header_File_Interfaces.i_AddressInfo_Basic)
			EXPORT STRING10 prim_range := TRIM(clean_address[1..10]);
			EXPORT STRING2  predir     := TRIM(clean_address[11..12]);
			EXPORT STRING28 prim_name  := TRIM(clean_address[13..40]);
			EXPORT STRING4  suffix     := TRIM(clean_address[41..44]);
			EXPORT STRING2  postdir    := TRIM(clean_address[45..46]);
			EXPORT STRING8  sec_range  := TRIM(clean_address[57..64]);	
			EXPORT STRING25 city       := TRIM(clean_address[90..114]);
			EXPORT STRING2  state      := TRIM(clean_address[115..116]);	
			EXPORT SET OF INTEGER4 zips := zip_value;
		END;	
			
	EXPORT m_PersonalInfo_Basic :=
		MODULE(doxie.Header_File_Interfaces.i_PersonalInfo_Basic)
			EXPORT UNSIGNED6 did   := (UNSIGNED6)did_value;
			EXPORT STRING30  fname := fname_value;
			EXPORT STRING30  mname := mname_value;
			EXPORT STRING30  lname := lname_value;
			EXPORT STRING9   ssn   := ssn_filtered_value;
			EXPORT UNSIGNED4 dob   := (UNSIGNED4)Dob_val;	
		END;
	
END;