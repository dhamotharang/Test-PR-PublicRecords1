IMPORT ut, DID_Add, header_slimsort;

DID_Test_CID := equifax.Ready_For_DID;

// DID using Name/Address, Date of Birth, and SSN
Equifax_DID_Matchset := ['A','D','S'];

DID_Add.MAC_Match_Flex
	(DID_Test_CID, Equifax_DID_Matchset,
	 ssn, dob_YYYYMM, fname, mname, lname, suffix, 
	 prim_range, prim_name, sec_range, z5, NONE, 
	 TRUE, did,
	 TRUE, PreGLB_DID,
     TRUE,
	 equifax.Layout_DID_Test_Temp, 
	 TRUE, DID_Score, PreGLB_DID_Score,
	 TRUE, DID_Test_Debug,
	 0,						//added this parm
	 DID_Test_Match)

// Project file to final format
Equifax.Layout_DID_Test_Match FormatDIDMatch(Layout_DID_Test_Temp L) := TRANSFORM
SELF := L;
END;

DID_Test_Match_Out := PROJECT(DID_Test_Match, FormatDIDMatch(LEFT));

COUNT(DID_Test_Match_Out);
COUNT(DID_Test_Match_Out(did<>0));

OUTPUT(DID_Test_Match_Out,,'Equifax::DID_Test_Match', OVERWRITE);
OUTPUT(DID_Test_Debug,,'TMTEMP::DID_Test_Debug', OVERWRITE);