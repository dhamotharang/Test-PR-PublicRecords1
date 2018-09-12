IMPORT SALT37;
EXPORT Layouts := MODULE
  //Main Layout, use this for most work
  EXPORT ServiceInputLayout_Batch := RECORD
    TYPEOF(layout_header.RemID) ReferenceID;
    TYPEOF(layout_header.RemLexid)  Inquiry_Lexid;
    TYPEOF(layout_header.RemLexid) Results_Lexid;
    TYPEOF(layout_header.VENDOR_ID) VENDOR_ID_Inq;
    TYPEOF(layout_header.BOCA_DID) BOCA_DID_Inq;
    TYPEOF(layout_header.SRC) SRC_Inq;
    TYPEOF(layout_header.SSN) SSN_Inq;
    TYPEOF(layout_header.DOB) DOB_Inq;
    TYPEOF(layout_header.SNAME) SNAME_Inq;
    TYPEOF(layout_header.FNAME) FNAME_Inq;
    TYPEOF(layout_header.MNAME) MNAME_Inq;
    TYPEOF(layout_header.LNAME) LNAME_Inq;
    TYPEOF(layout_header.GENDER) GENDER_Inq;
    TYPEOF(layout_header.DERIVED_GENDER) DERIVED_GENDER_Inq;
    TYPEOF(layout_header.PRIM_NAME) PRIM_NAME_Inq;
    TYPEOF(layout_header.PRIM_RANGE) PRIM_RANGE_Inq;
    TYPEOF(layout_header.SEC_RANGE) SEC_RANGE_Inq;
    TYPEOF(layout_header.CITY) CITY_Inq;
    TYPEOF(layout_header.ST) ST_Inq;
    TYPEOF(layout_header.ZIP) ZIP_Inq;
    TYPEOF(layout_header.POLICY_NUMBER) POLICY_NUMBER_Inq;
    TYPEOF(layout_header.CLAIM_NUMBER) CLAIM_NUMBER_Inq;
    TYPEOF(layout_header.DT_FIRST_SEEN) DT_FIRST_SEEN_Inq;
    TYPEOF(layout_header.DT_LAST_SEEN) DT_LAST_SEEN_Inq;
    TYPEOF(layout_header.DL_STATE) DL_STATE_Inq;
    TYPEOF(layout_header.DL_NBR) DL_NBR_Inq;
    TYPEOF(layout_header.AMBEST) AMBEST_Inq;
    TYPEOF(layout_header.VENDOR_ID) VENDOR_ID_Res;
    TYPEOF(layout_header.BOCA_DID) BOCA_DID_Res;
    TYPEOF(layout_header.SRC) SRC_Res;
    TYPEOF(layout_header.SSN) SSN_Res;
    TYPEOF(layout_header.DOB) DOB_Res;
    TYPEOF(layout_header.SNAME) SNAME_Res;
    TYPEOF(layout_header.FNAME) FNAME_Res;
    TYPEOF(layout_header.MNAME) MNAME_Res;
    TYPEOF(layout_header.LNAME) LNAME_Res;
    TYPEOF(layout_header.GENDER) GENDER_Res;
    TYPEOF(layout_header.DERIVED_GENDER) DERIVED_GENDER_Res;
    TYPEOF(layout_header.PRIM_NAME) PRIM_NAME_Res;
    TYPEOF(layout_header.PRIM_RANGE) PRIM_RANGE_Res;
    TYPEOF(layout_header.SEC_RANGE) SEC_RANGE_Res;
    TYPEOF(layout_header.CITY) CITY_Res;
    TYPEOF(layout_header.ST) ST_Res;
    TYPEOF(layout_header.ZIP) ZIP_Res;
    TYPEOF(layout_header.POLICY_NUMBER) POLICY_NUMBER_Res;
    TYPEOF(layout_header.CLAIM_NUMBER) CLAIM_NUMBER_Res;
    TYPEOF(layout_header.DT_FIRST_SEEN) DT_FIRST_SEEN_Res;
    TYPEOF(layout_header.DT_LAST_SEEN) DT_LAST_SEEN_Res;
    TYPEOF(layout_header.DL_STATE) DL_STATE_Res;
    TYPEOF(layout_header.DL_NBR) DL_NBR_Res;
    TYPEOF(layout_header.AMBEST) AMBEST_Res;
  END;

  //Depreciated Layout for alpha, use Batch if possible
  EXPORT ServiceInputLayout := RECORD
    SALT37.UIDType Inquiry_Lexid;
    SALT37.UIDType Results_Lexid;
    SALT37.StrType VENDOR_ID_1;
    SALT37.StrType BOCA_DID_1;
    SALT37.StrType SRC_1;
    SALT37.StrType SSN_1;
    SALT37.StrType DOB_1;
    SALT37.StrType SNAME_1;
    SALT37.StrType FNAME_1;
    SALT37.StrType MNAME_1;
    SALT37.StrType LNAME_1;
    SALT37.StrType GENDER_1;
    SALT37.StrType DERIVED_GENDER_1;
    SALT37.StrType PRIM_NAME_1;
    SALT37.StrType PRIM_RANGE_1;
    SALT37.StrType SEC_RANGE_1;
    SALT37.StrType CITY_1;
    SALT37.StrType ST_1;
    SALT37.StrType ZIP_1;
    SALT37.StrType POLICY_NUMBER_1;
    SALT37.StrType CLAIM_NUMBER_1;
    SALT37.StrType DT_FIRST_SEEN_1;
    SALT37.StrType DT_LAST_SEEN_1;
    SALT37.StrType DL_STATE_1;
    SALT37.StrType DL_NBR_1;
    SALT37.StrType AMBEST_1;
    SALT37.StrType VENDOR_ID_2;
    SALT37.StrType BOCA_DID_2;
    SALT37.StrType SRC_2;
    SALT37.StrType SSN_2;
    SALT37.StrType DOB_2;
    SALT37.StrType SNAME_2;
    SALT37.StrType FNAME_2;
    SALT37.StrType MNAME_2;
    SALT37.StrType LNAME_2;
    SALT37.StrType GENDER_2;
    SALT37.StrType DERIVED_GENDER_2;
    SALT37.StrType PRIM_NAME_2;
    SALT37.StrType PRIM_RANGE_2;
    SALT37.StrType SEC_RANGE_2;
    SALT37.StrType CITY_2;
    SALT37.StrType ST_2;
    SALT37.StrType ZIP_2;
    SALT37.StrType POLICY_NUMBER_2;
    SALT37.StrType CLAIM_NUMBER_2;
    SALT37.StrType DT_FIRST_SEEN_2;
    SALT37.StrType DT_LAST_SEEN_2;
    SALT37.StrType DL_STATE_2;
    SALT37.StrType DL_NBR_2;
    SALT37.StrType AMBEST_2;
  END;

  //Dummy data used to get the layout out of debug. 
  InsuranceHeader_RemoteLinking.Layout_HEADER Dummy_Data() := TRANSFORM
    SELF := [];
  END;
  Blank_Data := DATASET([Dummy_Data()]);

  EXPORT ServiceOutputLayout_Batch := RECORD
    SALT37.UIDType Best_Lexid;
    BOOLEAN Match;
    SALT37.UIDType Inquiry_Lexid;
    SALT37.UIDType Results_Lexid;
    InsuranceHeader_RemoteLinking.Debug(Blank_Data,InsuranceHeader_RemoteLinking.Specificities(Blank_Data).Specificities[1]).Layout_Sample_Matches;
  END;
  
  //Depreciated Layout for alpha, use Batch if possible
  EXPORT ServiceOutputLayout := RECORD
    ServiceOutputLayout_Batch AND NOT [ReferenceID]; 
  END;
  
  EXPORT Soapcall_Layout := RECORD
    DATASET(ServiceInputLayout_Batch) input_data;
  END;
  
  EXPORT layout_header NormEm(RECORDOF(ServiceInputLayout_Batch) L, UNSIGNED2 C) := TRANSFORM
    SELF.VENDOR_ID := (TYPEOF(self.VENDOR_ID))IF(C=1, L.VENDOR_ID_Inq, L.VENDOR_ID_Res );
    SELF.BOCA_DID := (TYPEOF(self.BOCA_DID))IF(C=1, L.BOCA_DID_Inq, L.BOCA_DID_Res );
    SELF.SRC := (TYPEOF(self.SRC))IF(C=1, L.SRC_Inq, L.SRC_Res );
    SELF.SSN := (TYPEOF(self.SSN))IF(C=1, L.SSN_Inq, L.SSN_Res );
    SELF.DOB := (TYPEOF(self.DOB))IF(C=1, L.DOB_Inq, L.DOB_Res );
    SELF.DL_NBR := (TYPEOF(self.DL_NBR))IF(C=1, L.DL_NBR_Inq, L.DL_NBR_Res );
    SELF.SNAME := (TYPEOF(self.SNAME))IF(C=1, L.SNAME_Inq, L.SNAME_Res );
    SELF.FNAME := (TYPEOF(self.FNAME))IF(C=1, L.FNAME_Inq, L.FNAME_Res );
    SELF.MNAME := (TYPEOF(self.MNAME))IF(C=1, L.MNAME_Inq, L.MNAME_Res );
    SELF.LNAME := (TYPEOF(self.LNAME))IF(C=1, L.LNAME_Inq, L.LNAME_Res );
    SELF.GENDER := (TYPEOF(self.GENDER))IF(C=1, L.GENDER_Inq, L.GENDER_Res );
    SELF.DERIVED_GENDER := (TYPEOF(self.DERIVED_GENDER))IF(C=1, L.DERIVED_GENDER_Inq, L.DERIVED_GENDER_Res );
    SELF.PRIM_NAME := (TYPEOF(self.PRIM_NAME))IF(C=1, L.PRIM_NAME_Inq, L.PRIM_NAME_Res );
    SELF.PRIM_RANGE := (TYPEOF(self.PRIM_RANGE))IF(C=1, L.PRIM_RANGE_Inq, L.PRIM_RANGE_Res );
    SELF.SEC_RANGE := (TYPEOF(self.SEC_RANGE))IF(C=1, L.SEC_RANGE_Inq, L.SEC_RANGE_Res );
    SELF.CITY := (TYPEOF(self.CITY))IF(C=1, L.CITY_Inq, L.CITY_Res );
    SELF.ST := (TYPEOF(self.ST))IF(C=1, L.ST_Inq, L.ST_Res );
    SELF.ZIP := (TYPEOF(self.ZIP))IF(C=1, L.ZIP_Inq, L.ZIP_Res );
    SELF.POLICY_NUMBER := (TYPEOF(self.POLICY_NUMBER))IF(C=1, L.POLICY_NUMBER_Inq, L.POLICY_NUMBER_Res );
    SELF.CLAIM_NUMBER := (TYPEOF(self.CLAIM_NUMBER))IF(C=1, L.CLAIM_NUMBER_Inq, L.CLAIM_NUMBER_Res );
    SELF.DT_FIRST_SEEN := (TYPEOF(self.DT_FIRST_SEEN))IF(C=1, L.DT_FIRST_SEEN_Inq, L.DT_FIRST_SEEN_Res );
    SELF.DT_LAST_SEEN := (TYPEOF(self.DT_LAST_SEEN))IF(C=1, L.DT_LAST_SEEN_Inq, L.DT_LAST_SEEN_Res );
    SELF.DL_STATE := (TYPEOF(self.DL_STATE))IF(C=1, L.DL_STATE_Inq, L.DL_STATE_Res );
    SELF.AMBEST := (TYPEOF(self.AMBEST))IF(C=1, L.AMBEST_Inq, L.AMBEST_Res );
    SELF.RID := C; // Have to be different records
    SELF.DID := L.ReferenceID + IF(C=1,0,1); // In different clusters
    SELF.RemID := L.ReferenceID;
    SELF.RemLexid := (TYPEOF(self.RemLexid))IF(C=1, L.Inquiry_Lexid, L.Results_Lexid );
    SELF.RemFlag := IF(C=1, TRUE, FALSE);  
    SELF := [];
  END;
       
END;