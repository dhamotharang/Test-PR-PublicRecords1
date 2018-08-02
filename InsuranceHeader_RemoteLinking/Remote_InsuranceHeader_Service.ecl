/*--SOAP--
<message name="Remote_InsuranceHeader_Service">
<part name="VENDOR_ID_1" type="xsd:string"/>
<part name="BOCA_DID_1" type="xsd:string"/>
<part name="SRC_1" type="xsd:string"/>
<part name="SSN_1" type="xsd:string"/>
<part name="DOB_1" type="xsd:string"/>
<part name="DL_NBR_1" type="xsd:string"/>
<part name="SNAME_1" type="xsd:string"/>
<part name="FNAME_1" type="xsd:string"/>
<part name="MNAME_1" type="xsd:string"/>
<part name="LNAME_1" type="xsd:string"/>
<part name="GENDER_1" type="xsd:string"/>
<part name="DERIVED_GENDER_1" type="xsd:string"/>
<part name="PRIM_NAME_1" type="xsd:string"/>
<part name="PRIM_RANGE_1" type="xsd:string"/>
<part name="SEC_RANGE_1" type="xsd:string"/>
<part name="CITY_1" type="xsd:string"/>
<part name="ST_1" type="xsd:string"/>
<part name="ZIP_1" type="xsd:string"/>
<part name="POLICY_NUMBER_1" type="xsd:string"/>
<part name="CLAIM_NUMBER_1" type="xsd:string"/>
<part name="DT_FIRST_SEEN_1" type="xsd:string"/>
<part name="DT_LAST_SEEN_1" type="xsd:string"/>
<part name="DL_STATE_1" type="xsd:string"/>
<part name="AMBEST_1" type="xsd:string"/>
<part name="VENDOR_ID_2" type="xsd:string"/>
<part name="BOCA_DID_2" type="xsd:string"/>
<part name="SRC_2" type="xsd:string"/>
<part name="SSN_2" type="xsd:string"/>
<part name="DOB_2" type="xsd:string"/>
<part name="DL_NBR_2" type="xsd:string"/>
<part name="SNAME_2" type="xsd:string"/>
<part name="FNAME_2" type="xsd:string"/>
<part name="MNAME_2" type="xsd:string"/>
<part name="LNAME_2" type="xsd:string"/>
<part name="GENDER_2" type="xsd:string"/>
<part name="DERIVED_GENDER_2" type="xsd:string"/>
<part name="PRIM_NAME_2" type="xsd:string"/>
<part name="PRIM_RANGE_2" type="xsd:string"/>
<part name="SEC_RANGE_2" type="xsd:string"/>
<part name="CITY_2" type="xsd:string"/>
<part name="ST_2" type="xsd:string"/>
<part name="ZIP_2" type="xsd:string"/>
<part name="POLICY_NUMBER_2" type="xsd:string"/>
<part name="CLAIM_NUMBER_2" type="xsd:string"/>
<part name="DT_FIRST_SEEN_2" type="xsd:string"/>
<part name="DT_LAST_SEEN_2" type="xsd:string"/>
<part name="DL_STATE_2" type="xsd:string"/>
<part name="AMBEST_2" type="xsd:string"/>
</message>
*/
 
/*--INFO-- Match together two records using the provided fields*/
EXPORT Remote_InsuranceHeader_Service := MACRO
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
  SALT37.StrType Input_VENDOR_ID_1 := '' : STORED('VENDOR_ID_1');
  SALT37.StrType Input_BOCA_DID_1 := '' : STORED('BOCA_DID_1');
  SALT37.StrType Input_SRC_1 := '' : STORED('SRC_1');
  SALT37.StrType Input_SSN_1 := '' : STORED('SSN_1');
  SALT37.StrType Input_DOB_1 := '' : STORED('DOB_1');
  SALT37.StrType Input_DL_NBR_1 := '' : STORED('DL_NBR_1');
  SALT37.StrType Input_SNAME_1 := '' : STORED('SNAME_1');
  SALT37.StrType Input_FNAME_1 := '' : STORED('FNAME_1');
  SALT37.StrType Input_MNAME_1 := '' : STORED('MNAME_1');
  SALT37.StrType Input_LNAME_1 := '' : STORED('LNAME_1');
  SALT37.StrType Input_GENDER_1 := '' : STORED('GENDER_1');
  SALT37.StrType Input_DERIVED_GENDER_1 := '' : STORED('DERIVED_GENDER_1');
  SALT37.StrType Input_PRIM_NAME_1 := '' : STORED('PRIM_NAME_1');
  SALT37.StrType Input_PRIM_RANGE_1 := '' : STORED('PRIM_RANGE_1');
  SALT37.StrType Input_SEC_RANGE_1 := '' : STORED('SEC_RANGE_1');
  SALT37.StrType Input_CITY_1 := '' : STORED('CITY_1');
  SALT37.StrType Input_ST_1 := '' : STORED('ST_1');
  SALT37.StrType Input_ZIP_1 := '' : STORED('ZIP_1');
  SALT37.StrType Input_POLICY_NUMBER_1 := '' : STORED('POLICY_NUMBER_1');
  SALT37.StrType Input_CLAIM_NUMBER_1 := '' : STORED('CLAIM_NUMBER_1');
  SALT37.StrType Input_DT_FIRST_SEEN_1 := '' : STORED('DT_FIRST_SEEN_1');
  SALT37.StrType Input_DT_LAST_SEEN_1 := '' : STORED('DT_LAST_SEEN_1');
  SALT37.StrType Input_DL_STATE_1 := '' : STORED('DL_STATE_1');
  SALT37.StrType Input_AMBEST_1 := '' : STORED('AMBEST_1');
  SALT37.StrType Input_VENDOR_ID_2 := '' : STORED('VENDOR_ID_2');
  SALT37.StrType Input_BOCA_DID_2 := '' : STORED('BOCA_DID_2');
  SALT37.StrType Input_SRC_2 := '' : STORED('SRC_2');
  SALT37.StrType Input_SSN_2 := '' : STORED('SSN_2');
  SALT37.StrType Input_DOB_2 := '' : STORED('DOB_2');
  SALT37.StrType Input_DL_NBR_2 := '' : STORED('DL_NBR_2');
  SALT37.StrType Input_SNAME_2 := '' : STORED('SNAME_2');
  SALT37.StrType Input_FNAME_2 := '' : STORED('FNAME_2');
  SALT37.StrType Input_MNAME_2 := '' : STORED('MNAME_2');
  SALT37.StrType Input_LNAME_2 := '' : STORED('LNAME_2');
  SALT37.StrType Input_GENDER_2 := '' : STORED('GENDER_2');
  SALT37.StrType Input_DERIVED_GENDER_2 := '' : STORED('DERIVED_GENDER_2');
  SALT37.StrType Input_PRIM_NAME_2 := '' : STORED('PRIM_NAME_2');
  SALT37.StrType Input_PRIM_RANGE_2 := '' : STORED('PRIM_RANGE_2');
  SALT37.StrType Input_SEC_RANGE_2 := '' : STORED('SEC_RANGE_2');
  SALT37.StrType Input_CITY_2 := '' : STORED('CITY_2');
  SALT37.StrType Input_ST_2 := '' : STORED('ST_2');
  SALT37.StrType Input_ZIP_2 := '' : STORED('ZIP_2');
  SALT37.StrType Input_POLICY_NUMBER_2 := '' : STORED('POLICY_NUMBER_2');
  SALT37.StrType Input_CLAIM_NUMBER_2 := '' : STORED('CLAIM_NUMBER_2');
  SALT37.StrType Input_DT_FIRST_SEEN_2 := '' : STORED('DT_FIRST_SEEN_2');
  SALT37.StrType Input_DT_LAST_SEEN_2 := '' : STORED('DT_LAST_SEEN_2');
  SALT37.StrType Input_DL_STATE_2 := '' : STORED('DL_STATE_2');
  SALT37.StrType Input_AMBEST_2 := '' : STORED('AMBEST_2');
  Template := DATASET([{1},{2}],{UNSIGNED1 num});
  InsuranceHeader_RemoteLinking.Layout_HEADER Into(Template Le) := TRANSFORM
    SELF.VENDOR_ID := (TYPEOF(self.VENDOR_ID))IF (le.num=1, Input_VENDOR_ID_1, Input_VENDOR_ID_2 );
    SELF.BOCA_DID := (TYPEOF(self.BOCA_DID))IF (le.num=1, Input_BOCA_DID_1, Input_BOCA_DID_2 );
    SELF.SRC := (TYPEOF(self.SRC))IF (le.num=1, Input_SRC_1, Input_SRC_2 );
    SELF.SSN := (TYPEOF(self.SSN))IF (le.num=1, Input_SSN_1, Input_SSN_2 );
    SELF.DOB := (TYPEOF(self.DOB))IF (le.num=1, Input_DOB_1, Input_DOB_2 );
    SELF.DL_NBR := (TYPEOF(self.DL_NBR))IF (le.num=1, Input_DL_NBR_1, Input_DL_NBR_2 );
    SELF.SNAME := (TYPEOF(self.SNAME))IF (le.num=1, Input_SNAME_1, Input_SNAME_2 );
    SELF.FNAME := (TYPEOF(self.FNAME))IF (le.num=1, Input_FNAME_1, Input_FNAME_2 );
    SELF.MNAME := (TYPEOF(self.MNAME))IF (le.num=1, Input_MNAME_1, Input_MNAME_2 );
    SELF.LNAME := (TYPEOF(self.LNAME))IF (le.num=1, Input_LNAME_1, Input_LNAME_2 );
    SELF.GENDER := (TYPEOF(self.GENDER))IF (le.num=1, Input_GENDER_1, Input_GENDER_2 );
    SELF.DERIVED_GENDER := (TYPEOF(self.DERIVED_GENDER))IF (le.num=1, Input_DERIVED_GENDER_1, Input_DERIVED_GENDER_2 );
    SELF.PRIM_NAME := (TYPEOF(self.PRIM_NAME))IF (le.num=1, Input_PRIM_NAME_1, Input_PRIM_NAME_2 );
    SELF.PRIM_RANGE := (TYPEOF(self.PRIM_RANGE))IF (le.num=1, Input_PRIM_RANGE_1, Input_PRIM_RANGE_2 );
    SELF.SEC_RANGE := (TYPEOF(self.SEC_RANGE))IF (le.num=1, Input_SEC_RANGE_1, Input_SEC_RANGE_2 );
    SELF.CITY := (TYPEOF(self.CITY))IF (le.num=1, Input_CITY_1, Input_CITY_2 );
    SELF.ST := (TYPEOF(self.ST))IF (le.num=1, Input_ST_1, Input_ST_2 );
    SELF.ZIP := (TYPEOF(self.ZIP))IF (le.num=1, Input_ZIP_1, Input_ZIP_2 );
    SELF.POLICY_NUMBER := (TYPEOF(self.POLICY_NUMBER))IF (le.num=1, Input_POLICY_NUMBER_1, Input_POLICY_NUMBER_2 );
    SELF.CLAIM_NUMBER := (TYPEOF(self.CLAIM_NUMBER))IF (le.num=1, Input_CLAIM_NUMBER_1, Input_CLAIM_NUMBER_2 );
    SELF.DT_FIRST_SEEN := (TYPEOF(self.DT_FIRST_SEEN))IF (le.num=1, Input_DT_FIRST_SEEN_1, Input_DT_FIRST_SEEN_2 );
    SELF.DT_LAST_SEEN := (TYPEOF(self.DT_LAST_SEEN))IF (le.num=1, Input_DT_LAST_SEEN_1, Input_DT_LAST_SEEN_2 );
    SELF.DL_STATE := (TYPEOF(self.DL_STATE))IF (le.num=1, Input_DL_STATE_1, Input_DL_STATE_2 );
    SELF.AMBEST := (TYPEOF(self.AMBEST))IF (le.num=1, Input_AMBEST_1, Input_AMBEST_2 );
    SELF.RID := le.num; // Have to be different records
    SELF.DID := le.num; // In different clusters
  END;
  Input_Data := PROJECT(Template,Into(LEFT));
  Input_Candidates := InsuranceHeader_RemoteLinking.Match_Candidates(Input_Data).Candidates;
  //OUTPUT(Input_Candidates); Can be used to debug if required
  s := InsuranceHeader_RemoteLinking.Specificities(Input_Data).Specificities[1];
  LinkScore := JOIN(Input_Candidates,Input_Candidates,left.RID>right.RID,InsuranceHeader_RemoteLinking.Debug(Input_Data,s).sample_match_join(LEFT,RIGHT,0),ALL);
  OUTPUT(LinkScore);
ENDMACRO;
