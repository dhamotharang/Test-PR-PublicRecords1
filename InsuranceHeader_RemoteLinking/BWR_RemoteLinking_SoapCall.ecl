//BWR to show using the remote linking function directly. 
//FCRA and Boca based products will want to use this approach. 

InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout Inquiry_Data() := TRANSFORM
  SELF.Inquiry_Lexid := 0;
  SELF.Results_Lexid := 0;
  SELF.VENDOR_ID_1 := '';
  SELF.BOCA_DID_1 := '';
  SELF.SRC_1 := '';
  SELF.SSN_1 := '';
  SELF.DOB_1 := '';
  SELF.SNAME_1 := '';
  SELF.FNAME_1 := '';
  SELF.MNAME_1 := '';
  SELF.LNAME_1 := '';
  SELF.GENDER_1 := '';
  SELF.DERIVED_GENDER_1 := '';
  SELF.PRIM_NAME_1 := '';
  SELF.PRIM_RANGE_1 := '';
  SELF.SEC_RANGE_1 := '';
  SELF.CITY_1 := '';
  SELF.ST_1 := '';
  SELF.ZIP_1 := '';
  SELF.POLICY_NUMBER_1 := '';
  SELF.CLAIM_NUMBER_1 := '';
  SELF.DT_FIRST_SEEN_1 := '';
  SELF.DT_LAST_SEEN_1 := '';
  SELF.DL_STATE_1 := '';
  SELF.DL_NBR_1 := '';
  SELF.AMBEST_1 := '';
  SELF.VENDOR_ID_2 := '';
  SELF.BOCA_DID_2 := '';
  SELF.SRC_2 := '';
  SELF.SSN_2 := '';
  SELF.DOB_2 := '';
  SELF.SNAME_2 := '';
  SELF.FNAME_2 := '';
  SELF.MNAME_2 := '';
  SELF.LNAME_2 := '';
  SELF.GENDER_2 := '';
  SELF.DERIVED_GENDER_2 := '';
  SELF.PRIM_NAME_2 := '';
  SELF.PRIM_RANGE_2 := '';
  SELF.SEC_RANGE_2 := '';
  SELF.CITY_2 := '';
  SELF.ST_2 := '';
  SELF.ZIP_2 := '';
  SELF.POLICY_NUMBER_2 := '';
  SELF.CLAIM_NUMBER_2 := '';
  SELF.DT_FIRST_SEEN_2 := '';
  SELF.DT_LAST_SEEN_2 := '';
  SELF.DL_STATE_2 := '';
  SELF.DL_NBR_2 := '';
  SELF.AMBEST_2 := '';
END;

Input_Data := DATASET([Inquiry_Data()]);
InsuranceHeader_RemoteLinking.fn_RemoteLinking_Soapcall(Input_Data);
