IMPORT IDLExternalLinking;
EXPORT fn_RemoteLinking_Soapcall(DATASET(InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout)In_Data, STRING50 Roxie_IP=InsuranceHeader_RemoteLinking.Constants.HEADER_SERVICE_ROXIE_IP,soapcall_timeout=30,soapcall_retry=3) := FUNCTION
  out_layout := InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout;
  In_Data_pro := PROJECT(In_Data,TRANSFORM(InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch,
    SELF.ReferenceID := COUNTER;
    SELF.Inquiry_Lexid := (TYPEOF(self.Inquiry_Lexid))LEFT.Inquiry_Lexid;
    SELF.Results_Lexid := (TYPEOF(self.Results_Lexid))LEFT.Results_Lexid;
    SELF.VENDOR_ID_Inq := (TYPEOF(self.VENDOR_ID_Inq))LEFT.VENDOR_ID_1;
    SELF.BOCA_DID_Inq := (TYPEOF(self.BOCA_DID_Inq))LEFT.BOCA_DID_1;
    SELF.SRC_Inq := (TYPEOF(self.SRC_Inq))LEFT.SRC_1;
    SELF.SSN_Inq := (TYPEOF(self.SSN_Inq))LEFT.SSN_1;
    SELF.DOB_Inq := (TYPEOF(self.DOB_Inq))LEFT.DOB_1;
    SELF.SNAME_Inq := (TYPEOF(self.SNAME_Inq))LEFT.SNAME_1;
    SELF.FNAME_Inq := (TYPEOF(self.FNAME_Inq))LEFT.FNAME_1;
    SELF.MNAME_Inq := (TYPEOF(self.MNAME_Inq))LEFT.MNAME_1;
    SELF.LNAME_Inq := (TYPEOF(self.LNAME_Inq))LEFT.LNAME_1;
    SELF.GENDER_Inq := (TYPEOF(self.GENDER_Inq))LEFT.GENDER_1;
    SELF.DERIVED_GENDER_Inq := (TYPEOF(self.DERIVED_GENDER_Inq))LEFT.DERIVED_GENDER_1;
    SELF.PRIM_NAME_Inq := (TYPEOF(self.PRIM_NAME_Inq))LEFT.PRIM_NAME_1;
    SELF.PRIM_RANGE_Inq := (TYPEOF(self.PRIM_RANGE_Inq))LEFT.PRIM_RANGE_1;
    SELF.SEC_RANGE_Inq := (TYPEOF(self.SEC_RANGE_Inq))LEFT.SEC_RANGE_1;
    SELF.CITY_Inq := (TYPEOF(self.CITY_Inq))LEFT.CITY_1;
    SELF.ST_Inq := (TYPEOF(self.ST_Inq))LEFT.ST_1;
    SELF.ZIP_Inq := (TYPEOF(self.ZIP_Inq))LEFT.ZIP_1;
    SELF.POLICY_NUMBER_Inq := (TYPEOF(self.POLICY_NUMBER_Inq))LEFT.POLICY_NUMBER_1;
    SELF.CLAIM_NUMBER_Inq := (TYPEOF(self.CLAIM_NUMBER_Inq))LEFT.CLAIM_NUMBER_1;
    SELF.DT_FIRST_SEEN_Inq := (TYPEOF(self.DT_FIRST_SEEN_Inq))LEFT.DT_FIRST_SEEN_1;
    SELF.DT_LAST_SEEN_Inq := (TYPEOF(self.DT_LAST_SEEN_Inq))LEFT.DT_LAST_SEEN_1;
    SELF.DL_STATE_Inq := (TYPEOF(self.DL_STATE_Inq))LEFT.DL_STATE_1;
    SELF.DL_NBR_Inq := (TYPEOF(self.DL_NBR_Inq))LEFT.DL_NBR_1;
    SELF.AMBEST_Inq := (TYPEOF(self.AMBEST_Inq))LEFT.AMBEST_1;
    SELF.VENDOR_ID_Res := (TYPEOF(self.VENDOR_ID_Res))LEFT.VENDOR_ID_2;
    SELF.BOCA_DID_Res := (TYPEOF(self.BOCA_DID_Res))LEFT.BOCA_DID_2;
    SELF.SRC_Res := (TYPEOF(self.SRC_Res))LEFT.SRC_2;
    SELF.SSN_Res := (TYPEOF(self.SSN_Res))LEFT.SSN_2;
    SELF.DOB_Res := (TYPEOF(self.DOB_Res))LEFT.DOB_2;
    SELF.SNAME_Res := (TYPEOF(self.SNAME_Res))LEFT.SNAME_2;
    SELF.FNAME_Res := (TYPEOF(self.FNAME_Res))LEFT.FNAME_2;
    SELF.MNAME_Res := (TYPEOF(self.MNAME_Res))LEFT.MNAME_2;
    SELF.LNAME_Res := (TYPEOF(self.LNAME_Res))LEFT.LNAME_2;
    SELF.GENDER_Res := (TYPEOF(self.GENDER_Res))LEFT.GENDER_2;
    SELF.DERIVED_GENDER_Res := (TYPEOF(self.DERIVED_GENDER_Res))LEFT.DERIVED_GENDER_2;
    SELF.PRIM_NAME_Res := (TYPEOF(self.PRIM_NAME_Res))LEFT.PRIM_NAME_2;
    SELF.PRIM_RANGE_Res := (TYPEOF(self.PRIM_RANGE_Res))LEFT.PRIM_RANGE_2;
    SELF.SEC_RANGE_Res := (TYPEOF(self.SEC_RANGE_Res))LEFT.SEC_RANGE_2;
    SELF.CITY_Res := (TYPEOF(self.CITY_Res))LEFT.CITY_2;
    SELF.ST_Res := (TYPEOF(self.ST_Res))LEFT.ST_2;
    SELF.ZIP_Res := (TYPEOF(self.ZIP_Res))LEFT.ZIP_2;
    SELF.POLICY_NUMBER_Res := (TYPEOF(self.POLICY_NUMBER_Res))LEFT.POLICY_NUMBER_2;
    SELF.CLAIM_NUMBER_Res := (TYPEOF(self.CLAIM_NUMBER_Res))LEFT.CLAIM_NUMBER_2;
    SELF.DT_FIRST_SEEN_Res := (TYPEOF(self.DT_FIRST_SEEN_Res))LEFT.DT_FIRST_SEEN_2;
    SELF.DT_LAST_SEEN_Res := (TYPEOF(self.DT_LAST_SEEN_Res))LEFT.DT_LAST_SEEN_2;
    SELF.DL_STATE_Res := (TYPEOF(self.DL_STATE_Res))LEFT.DL_STATE_2;
    SELF.DL_NBR_Res := (TYPEOF(self.DL_NBR_Res))LEFT.DL_NBR_2;
    SELF.AMBEST_Res := (TYPEOF(self.AMBEST_Res))LEFT.AMBEST_2;
  ));
  
  In_data_fin := DATASET([{In_Data_pro}],InsuranceHeader_RemoteLinking.Layouts.Soapcall_Layout);
  
  IDLExternalLinking.MAC_Soapcall(In_data_fin,out_layout, Roxie_IP, 
        InsuranceHeader_RemoteLinking.Constants.HEADER_SERVICE_NAME, OutFile, ,soapcall_timeout, soapcall_retry);
  RETURN OutFile;
END;

