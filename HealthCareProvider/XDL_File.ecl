import IDL_Header, IDLExternalLinking, InsuranceHeader_Salt_xIDL, Health_Provider_Test;
EXPORT XDL_File (DATASET (Health_Provider_Test.Layouts.HealthCareProvider_Header) Infile) := FUNCTION 
	
	IDLExternalLinking.mac_xlinking_on_thor (Infile, 
																					 DID,
																					 SNAME,
																					 FNAME,
																					 MNAME, 
																					 LNAME, 
																					 GENDER, 
																					 DERIVED_GENDER, 
																				   PRIM_NAME, 
																					 PRIM_RANGE, 
																					 SEC_RANGE, 
																					 V_CITY_NAME, 
																					 ST, 
																					 ZIP, 
																					 SSN, 
																					 DOB, 
																					 , //DL_STATE 
																					 , //DL_NBR
																					 , //SOURCE
																					 , //SOURCE_RID
																					 Result,,45,6); 
																					 
	RETURN Result;
	
END;

