/*--SOAP--
<message name="Remote_InsuranceHeader_Service_Dempsey">
<part name="INQUIRY_LEXID" type="xsd:unsigned"/>
<part name="RESULTS_LEXID" type="xsd:unsigned"/>
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
EXPORT Remote_InsuranceHeader_Service_Dempsey := MACRO
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
  #CONSTANT('Superfile_Name','');
  SALT37.UIDType Input_Inquiry_Lexid := 0 : STORED('INQUIRY_LEXID', FORMAT(SEQUENCE(1)));
  SALT37.UIDType Input_Results_Lexid := 0 : STORED('RESULTS_LEXID', FORMAT(SEQUENCE(2)));
  SALT37.StrType Input_VENDOR_ID_1 := '' : STORED('VENDOR_ID_1', FORMAT(SEQUENCE(3)));
  SALT37.StrType Input_BOCA_DID_1 := '' : STORED('BOCA_DID_1', FORMAT(SEQUENCE(5)));
  SALT37.StrType Input_SRC_1 := '' : STORED('SRC_1', FORMAT(SEQUENCE(7)));
  SALT37.StrType Input_SSN_1 := '' : STORED('SSN_1', FORMAT(SEQUENCE(9)));
  SALT37.StrType Input_DOB_1 := '' : STORED('DOB_1', FORMAT(SEQUENCE(11)));
  SALT37.StrType Input_DL_NBR_1 := '' : STORED('DL_NBR_1', FORMAT(SEQUENCE(13)));
  SALT37.StrType Input_SNAME_1 := '' : STORED('SNAME_1', FORMAT(SEQUENCE(15)));
  SALT37.StrType Input_FNAME_1 := '' : STORED('FNAME_1', FORMAT(SEQUENCE(17)));
  SALT37.StrType Input_MNAME_1 := '' : STORED('MNAME_1', FORMAT(SEQUENCE(19)));
  SALT37.StrType Input_LNAME_1 := '' : STORED('LNAME_1', FORMAT(SEQUENCE(21)));
  SALT37.StrType Input_GENDER_1 := '' : STORED('GENDER_1', FORMAT(SEQUENCE(23)));
  SALT37.StrType Input_DERIVED_GENDER_1 := '' : STORED('DERIVED_GENDER_1', FORMAT(SEQUENCE(25)));
  SALT37.StrType Input_PRIM_NAME_1 := '' : STORED('PRIM_NAME_1', FORMAT(SEQUENCE(27)));
  SALT37.StrType Input_PRIM_RANGE_1 := '' : STORED('PRIM_RANGE_1', FORMAT(SEQUENCE(29)));
  SALT37.StrType Input_SEC_RANGE_1 := '' : STORED('SEC_RANGE_1', FORMAT(SEQUENCE(31)));
  SALT37.StrType Input_CITY_1 := '' : STORED('CITY_1', FORMAT(SEQUENCE(33)));
  SALT37.StrType Input_ST_1 := '' : STORED('ST_1', FORMAT(SEQUENCE(35)));
  SALT37.StrType Input_ZIP_1 := '' : STORED('ZIP_1', FORMAT(SEQUENCE(37)));
  SALT37.StrType Input_POLICY_NUMBER_1 := '' : STORED('POLICY_NUMBER_1', FORMAT(SEQUENCE(39)));
  SALT37.StrType Input_CLAIM_NUMBER_1 := '' : STORED('CLAIM_NUMBER_1', FORMAT(SEQUENCE(41)));
  SALT37.StrType Input_DT_FIRST_SEEN_1 := '' : STORED('DT_FIRST_SEEN_1', FORMAT(SEQUENCE(43)));
  SALT37.StrType Input_DT_LAST_SEEN_1 := '' : STORED('DT_LAST_SEEN_1', FORMAT(SEQUENCE(45)));
  SALT37.StrType Input_DL_STATE_1 := '' : STORED('DL_STATE_1', FORMAT(SEQUENCE(47)));
  SALT37.StrType Input_AMBEST_1 := '' : STORED('AMBEST_1', FORMAT(SEQUENCE(49)));
  SALT37.StrType Input_VENDOR_ID_2 := '' : STORED('VENDOR_ID_2', FORMAT(SEQUENCE(4)));
  SALT37.StrType Input_BOCA_DID_2 := '' : STORED('BOCA_DID_2', FORMAT(SEQUENCE(6)));
  SALT37.StrType Input_SRC_2 := '' : STORED('SRC_2', FORMAT(SEQUENCE(8)));
  SALT37.StrType Input_SSN_2 := '' : STORED('SSN_2', FORMAT(SEQUENCE(10)));
  SALT37.StrType Input_DOB_2 := '' : STORED('DOB_2', FORMAT(SEQUENCE(12)));
  SALT37.StrType Input_DL_NBR_2 := '' : STORED('DL_NBR_2', FORMAT(SEQUENCE(14)));
  SALT37.StrType Input_SNAME_2 := '' : STORED('SNAME_2', FORMAT(SEQUENCE(16)));
  SALT37.StrType Input_FNAME_2 := '' : STORED('FNAME_2', FORMAT(SEQUENCE(18)));
  SALT37.StrType Input_MNAME_2 := '' : STORED('MNAME_2', FORMAT(SEQUENCE(20)));
  SALT37.StrType Input_LNAME_2 := '' : STORED('LNAME_2', FORMAT(SEQUENCE(22)));
  SALT37.StrType Input_GENDER_2 := '' : STORED('GENDER_2', FORMAT(SEQUENCE(24)));
  SALT37.StrType Input_DERIVED_GENDER_2 := '' : STORED('DERIVED_GENDER_2', FORMAT(SEQUENCE(26)));
  SALT37.StrType Input_PRIM_NAME_2 := '' : STORED('PRIM_NAME_2', FORMAT(SEQUENCE(28)));
  SALT37.StrType Input_PRIM_RANGE_2 := '' : STORED('PRIM_RANGE_2', FORMAT(SEQUENCE(30)));
  SALT37.StrType Input_SEC_RANGE_2 := '' : STORED('SEC_RANGE_2', FORMAT(SEQUENCE(32)));
  SALT37.StrType Input_CITY_2 := '' : STORED('CITY_2', FORMAT(SEQUENCE(34)));
  SALT37.StrType Input_ST_2 := '' : STORED('ST_2', FORMAT(SEQUENCE(36)));
  SALT37.StrType Input_ZIP_2 := '' : STORED('ZIP_2', FORMAT(SEQUENCE(38)));
  SALT37.StrType Input_POLICY_NUMBER_2 := '' : STORED('POLICY_NUMBER_2', FORMAT(SEQUENCE(40)));
  SALT37.StrType Input_CLAIM_NUMBER_2 := '' : STORED('CLAIM_NUMBER_2', FORMAT(SEQUENCE(42)));
  SALT37.StrType Input_DT_FIRST_SEEN_2 := '' : STORED('DT_FIRST_SEEN_2', FORMAT(SEQUENCE(44)));
  SALT37.StrType Input_DT_LAST_SEEN_2 := '' : STORED('DT_LAST_SEEN_2', FORMAT(SEQUENCE(46)));
  SALT37.StrType Input_DL_STATE_2 := '' : STORED('DL_STATE_2', FORMAT(SEQUENCE(48)));
  SALT37.StrType Input_AMBEST_2 := '' : STORED('AMBEST_2', FORMAT(SEQUENCE(50)));
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
    SELF := [];
  END;
  Input_Data := PROJECT(Template,Into(LEFT));
  OUTPUT(InsuranceHeader_RemoteLinking.fn_RemoteLinking(Input_Data,Input_Inquiry_Lexid,Input_Results_Lexid));
ENDMACRO;
