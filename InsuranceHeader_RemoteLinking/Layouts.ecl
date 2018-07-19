IMPORT SALT37;
EXPORT Layouts := MODULE
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

EXPORT ServiceOutputLayout := RECORD
    SALT37.UIDType Best_Lexid;
    BOOLEAN Match;
    SALT37.UIDType Inquiry_Lexid;
    SALT37.UIDType Results_Lexid;
    InsuranceHeader_RemoteLinking.Debug(Blank_Data,InsuranceHeader_RemoteLinking.Specificities(Blank_Data).Specificities[1]).Layout_Sample_Matches;
  END;
END;