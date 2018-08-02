//BWR to show using the remote linking function directly. 
//Non-FCRA Alpha based products will want to use this approach. 

InsuranceHeader_RemoteLinking.Layout_HEADER Inquiry_Data() := TRANSFORM
  SELF.VENDOR_ID := '';
  SELF.BOCA_DID := 0;
  SELF.SRC := '';
  SELF.SSN := '';
  SELF.DOB := 0;
  SELF.DL_NBR := '';
  SELF.DL_STATE := '';
  SELF.SNAME := '';
  SELF.FNAME := '';
  SELF.MNAME := '';
  SELF.LNAME := '';
  SELF.GENDER := '';
  SELF.DERIVED_GENDER := '';
  SELF.PRIM_NAME := '';
  SELF.PRIM_RANGE := '';
  SELF.SEC_RANGE := '';
  SELF.CITY := '';
  SELF.ST := '';
  SELF.ZIP := '';
  SELF.POLICY_NUMBER := '';
  SELF.CLAIM_NUMBER := '';
  SELF.DT_FIRST_SEEN := 0;
  SELF.DT_LAST_SEEN := 0;
  SELF.AMBEST := '';
  SELF.RID := 1; // Have to be different records
  SELF.DID := 1; // In different clusters
  SELF := [];
END;
InsuranceHeader_RemoteLinking.Layout_HEADER Results_Data() := TRANSFORM
  SELF.VENDOR_ID := '';
  SELF.BOCA_DID := 0;
  SELF.SRC := '';
  SELF.SSN := '';
  SELF.DOB := 0;
  SELF.DL_NBR := '';
  SELF.DL_STATE := '';
  SELF.SNAME := '';
  SELF.FNAME := '';
  SELF.MNAME := '';
  SELF.LNAME := '';
  SELF.GENDER := '';
  SELF.DERIVED_GENDER := '';
  SELF.PRIM_NAME := '';
  SELF.PRIM_RANGE := '';
  SELF.SEC_RANGE := '';
  SELF.CITY := '';
  SELF.ST := '';
  SELF.ZIP := '';
  SELF.POLICY_NUMBER := '';
  SELF.CLAIM_NUMBER := '';
  SELF.DT_FIRST_SEEN := 0;
  SELF.DT_LAST_SEEN := 0;
  SELF.AMBEST := '';
  SELF.RID := 2; // Have to be different records
  SELF.DID := 2; // In different clusters
  SELF := [];
END;

Input_Data := DATASET([Inquiry_Data(),Results_Data()]);
Input_Inquiry_Lexid := 0;
Input_Results_Lexid := 0;
InsuranceHeader_RemoteLinking.fn_RemoteLinking(Input_Data,Input_Inquiry_Lexid,Input_Results_Lexid);
