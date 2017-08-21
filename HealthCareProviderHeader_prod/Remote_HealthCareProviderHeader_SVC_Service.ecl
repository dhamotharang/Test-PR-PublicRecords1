/*--SOAP--
<message name="Remote_HealthCareProviderHeader_SVC_Service">
<part name="VENDOR_ID_1" type="xsd:string"/>
<part name="DID_1" type="xsd:string"/>
<part name="NPI_NUMBER_1" type="xsd:string"/>
<part name="DEA_NUMBER_1" type="xsd:string"/>
<part name="LIC_NBR_1" type="xsd:string"/>
<part name="UPIN_1" type="xsd:string"/>
<part name="TAX_ID_1" type="xsd:string"/>
<part name="DOB_1" type="xsd:string"/>
<part name="PRIM_NAME_1" type="xsd:string"/>
<part name="ZIP_1" type="xsd:string"/>
<part name="PRIM_RANGE_1" type="xsd:string"/>
<part name="LNAME_1" type="xsd:string"/>
<part name="V_CITY_NAME_1" type="xsd:string"/>
<part name="MNAME_1" type="xsd:string"/>
<part name="FNAME_1" type="xsd:string"/>
<part name="SEC_RANGE_1" type="xsd:string"/>
<part name="SNAME_1" type="xsd:string"/>
<part name="ST_1" type="xsd:string"/>
<part name="GENDER_1" type="xsd:string"/>
<part name="LIC_STATE_1" type="xsd:string"/>
<part name="CNAME_1" type="xsd:string"/>
<part name="SRC_1" type="xsd:string"/>
<part name="DT_FIRST_SEEN_1" type="xsd:string"/>
<part name="DT_LAST_SEEN_1" type="xsd:string"/>
<part name="GEO_LAT_1" type="xsd:string"/>
<part name="GEO_LONG_1" type="xsd:string"/>
<part name="VENDOR_ID_2" type="xsd:string"/>
<part name="DID_2" type="xsd:string"/>
<part name="NPI_NUMBER_2" type="xsd:string"/>
<part name="DEA_NUMBER_2" type="xsd:string"/>
<part name="LIC_NBR_2" type="xsd:string"/>
<part name="UPIN_2" type="xsd:string"/>
<part name="TAX_ID_2" type="xsd:string"/>
<part name="DOB_2" type="xsd:string"/>
<part name="PRIM_NAME_2" type="xsd:string"/>
<part name="ZIP_2" type="xsd:string"/>
<part name="PRIM_RANGE_2" type="xsd:string"/>
<part name="LNAME_2" type="xsd:string"/>
<part name="V_CITY_NAME_2" type="xsd:string"/>
<part name="MNAME_2" type="xsd:string"/>
<part name="FNAME_2" type="xsd:string"/>
<part name="SEC_RANGE_2" type="xsd:string"/>
<part name="SNAME_2" type="xsd:string"/>
<part name="ST_2" type="xsd:string"/>
<part name="GENDER_2" type="xsd:string"/>
<part name="LIC_STATE_2" type="xsd:string"/>
<part name="CNAME_2" type="xsd:string"/>
<part name="SRC_2" type="xsd:string"/>
<part name="DT_FIRST_SEEN_2" type="xsd:string"/>
<part name="DT_LAST_SEEN_2" type="xsd:string"/>
<part name="GEO_LAT_2" type="xsd:string"/>
<part name="GEO_LONG_2" type="xsd:string"/>
</message>
*/

/*--INFO-- Match together two records using the provided fields*/
EXPORT Remote_HealthCareProviderHeader_SVC_Service := MACRO
IMPORT SALT26b2,HealthCareProviderHeader_prod;
SALT26b2.StrType Input_VENDOR_ID_1 := '' : STORED('VENDOR_ID_1');
SALT26b2.StrType Input_DID_1 := '' : STORED('DID_1');
SALT26b2.StrType Input_NPI_NUMBER_1 := '' : STORED('NPI_NUMBER_1');
SALT26b2.StrType Input_DEA_NUMBER_1 := '' : STORED('DEA_NUMBER_1');
SALT26b2.StrType Input_LIC_NBR_1 := '' : STORED('LIC_NBR_1');
SALT26b2.StrType Input_UPIN_1 := '' : STORED('UPIN_1');
SALT26b2.StrType Input_TAX_ID_1 := '' : STORED('TAX_ID_1');
SALT26b2.StrType Input_DOB_1 := '' : STORED('DOB_1');
SALT26b2.StrType Input_PRIM_NAME_1 := '' : STORED('PRIM_NAME_1');
SALT26b2.StrType Input_ZIP_1 := '' : STORED('ZIP_1');
SALT26b2.StrType Input_PRIM_RANGE_1 := '' : STORED('PRIM_RANGE_1');
SALT26b2.StrType Input_LNAME_1 := '' : STORED('LNAME_1');
SALT26b2.StrType Input_V_CITY_NAME_1 := '' : STORED('V_CITY_NAME_1');
SALT26b2.StrType Input_MNAME_1 := '' : STORED('MNAME_1');
SALT26b2.StrType Input_FNAME_1 := '' : STORED('FNAME_1');
SALT26b2.StrType Input_SEC_RANGE_1 := '' : STORED('SEC_RANGE_1');
SALT26b2.StrType Input_SNAME_1 := '' : STORED('SNAME_1');
SALT26b2.StrType Input_ST_1 := '' : STORED('ST_1');
SALT26b2.StrType Input_GENDER_1 := '' : STORED('GENDER_1');
SALT26b2.StrType Input_LIC_STATE_1 := '' : STORED('LIC_STATE_1');
SALT26b2.StrType Input_CNAME_1 := '' : STORED('CNAME_1');
SALT26b2.StrType Input_SRC_1 := '' : STORED('SRC_1');
SALT26b2.StrType Input_DT_FIRST_SEEN_1 := '' : STORED('DT_FIRST_SEEN_1');
SALT26b2.StrType Input_DT_LAST_SEEN_1 := '' : STORED('DT_LAST_SEEN_1');
SALT26b2.StrType Input_GEO_LAT_1 := '' : STORED('GEO_LAT_1');
SALT26b2.StrType Input_GEO_LONG_1 := '' : STORED('GEO_LONG_1');
SALT26b2.StrType Input_VENDOR_ID_2 := '' : STORED('VENDOR_ID_2');
SALT26b2.StrType Input_DID_2 := '' : STORED('DID_2');
SALT26b2.StrType Input_NPI_NUMBER_2 := '' : STORED('NPI_NUMBER_2');
SALT26b2.StrType Input_DEA_NUMBER_2 := '' : STORED('DEA_NUMBER_2');
SALT26b2.StrType Input_LIC_NBR_2 := '' : STORED('LIC_NBR_2');
SALT26b2.StrType Input_UPIN_2 := '' : STORED('UPIN_2');
SALT26b2.StrType Input_TAX_ID_2 := '' : STORED('TAX_ID_2');
SALT26b2.StrType Input_DOB_2 := '' : STORED('DOB_2');
SALT26b2.StrType Input_PRIM_NAME_2 := '' : STORED('PRIM_NAME_2');
SALT26b2.StrType Input_ZIP_2 := '' : STORED('ZIP_2');
SALT26b2.StrType Input_PRIM_RANGE_2 := '' : STORED('PRIM_RANGE_2');
SALT26b2.StrType Input_LNAME_2 := '' : STORED('LNAME_2');
SALT26b2.StrType Input_V_CITY_NAME_2 := '' : STORED('V_CITY_NAME_2');
SALT26b2.StrType Input_MNAME_2 := '' : STORED('MNAME_2');
SALT26b2.StrType Input_FNAME_2 := '' : STORED('FNAME_2');
SALT26b2.StrType Input_SEC_RANGE_2 := '' : STORED('SEC_RANGE_2');
SALT26b2.StrType Input_SNAME_2 := '' : STORED('SNAME_2');
SALT26b2.StrType Input_ST_2 := '' : STORED('ST_2');
SALT26b2.StrType Input_GENDER_2 := '' : STORED('GENDER_2');
SALT26b2.StrType Input_LIC_STATE_2 := '' : STORED('LIC_STATE_2');
SALT26b2.StrType Input_CNAME_2 := '' : STORED('CNAME_2');
SALT26b2.StrType Input_SRC_2 := '' : STORED('SRC_2');
SALT26b2.StrType Input_DT_FIRST_SEEN_2 := '' : STORED('DT_FIRST_SEEN_2');
SALT26b2.StrType Input_DT_LAST_SEEN_2 := '' : STORED('DT_LAST_SEEN_2');
SALT26b2.StrType Input_GEO_LAT_2 := '' : STORED('GEO_LAT_2');
SALT26b2.StrType Input_GEO_LONG_2 := '' : STORED('GEO_LONG_2');
Template := DATASET([{1},{2}],{UNSIGNED1 num});
HealthCareProviderHeader_prod.Layout_HealthProvider Into(Template Le) := TRANSFORM
SELF.VENDOR_ID := (TYPEOF(self.VENDOR_ID))IF (le.num=1, Input_VENDOR_ID_1, Input_VENDOR_ID_2 );
SELF.DID := (TYPEOF(self.DID))IF (le.num=1, Input_DID_1, Input_DID_2 );
SELF.NPI_NUMBER := (TYPEOF(self.NPI_NUMBER))IF (le.num=1, Input_NPI_NUMBER_1, Input_NPI_NUMBER_2 );
SELF.DEA_NUMBER := (TYPEOF(self.DEA_NUMBER))IF (le.num=1, Input_DEA_NUMBER_1, Input_DEA_NUMBER_2 );
SELF.LIC_NBR := (TYPEOF(self.LIC_NBR))IF (le.num=1, Input_LIC_NBR_1, Input_LIC_NBR_2 );
SELF.UPIN := (TYPEOF(self.UPIN))IF (le.num=1, Input_UPIN_1, Input_UPIN_2 );
SELF.TAX_ID := (TYPEOF(self.TAX_ID))IF (le.num=1, Input_TAX_ID_1, Input_TAX_ID_2 );
SELF.DOB := (TYPEOF(self.DOB))IF (le.num=1, Input_DOB_1, Input_DOB_2 );
SELF.PRIM_NAME := (TYPEOF(self.PRIM_NAME))IF (le.num=1, Input_PRIM_NAME_1, Input_PRIM_NAME_2 );
SELF.ZIP := (TYPEOF(self.ZIP))IF (le.num=1, Input_ZIP_1, Input_ZIP_2 );
SELF.PRIM_RANGE := (TYPEOF(self.PRIM_RANGE))IF (le.num=1, Input_PRIM_RANGE_1, Input_PRIM_RANGE_2 );
SELF.LNAME := (TYPEOF(self.LNAME))IF (le.num=1, Input_LNAME_1, Input_LNAME_2 );
SELF.V_CITY_NAME := (TYPEOF(self.V_CITY_NAME))IF (le.num=1, Input_V_CITY_NAME_1, Input_V_CITY_NAME_2 );
SELF.MNAME := (TYPEOF(self.MNAME))IF (le.num=1, Input_MNAME_1, Input_MNAME_2 );
SELF.FNAME := (TYPEOF(self.FNAME))IF (le.num=1, Input_FNAME_1, Input_FNAME_2 );
SELF.SEC_RANGE := (TYPEOF(self.SEC_RANGE))IF (le.num=1, Input_SEC_RANGE_1, Input_SEC_RANGE_2 );
SELF.SNAME := (TYPEOF(self.SNAME))IF (le.num=1, Input_SNAME_1, Input_SNAME_2 );
SELF.ST := (TYPEOF(self.ST))IF (le.num=1, Input_ST_1, Input_ST_2 );
SELF.GENDER := (TYPEOF(self.GENDER))IF (le.num=1, Input_GENDER_1, Input_GENDER_2 );
SELF.LIC_STATE := (TYPEOF(self.LIC_STATE))IF (le.num=1, Input_LIC_STATE_1, Input_LIC_STATE_2 );
SELF.CNAME := (TYPEOF(self.CNAME))IF (le.num=1, Input_CNAME_1, Input_CNAME_2 );
SELF.SRC := (TYPEOF(self.SRC))IF (le.num=1, Input_SRC_1, Input_SRC_2 );
SELF.DT_FIRST_SEEN := (TYPEOF(self.DT_FIRST_SEEN))IF (le.num=1, Input_DT_FIRST_SEEN_1, Input_DT_FIRST_SEEN_2 );
SELF.DT_LAST_SEEN := (TYPEOF(self.DT_LAST_SEEN))IF (le.num=1, Input_DT_LAST_SEEN_1, Input_DT_LAST_SEEN_2 );
SELF.GEO_LAT := (TYPEOF(self.GEO_LAT))IF (le.num=1, Input_GEO_LAT_1, Input_GEO_LAT_2 );
SELF.GEO_LONG := (TYPEOF(self.GEO_LONG))IF (le.num=1, Input_GEO_LONG_1, Input_GEO_LONG_2 );
SELF.RID := le.num; // Have to be different records
SELF.LNPID := le.num; // In different clusters
END;
Input_Data := PROJECT(Template,Into(LEFT));
Input_Candidates := HealthCareProviderHeader_prod.Match_Candidates(Input_Data).Candidates;
//OUTPUT(Input_Candidates); Can be used to debug if required
s := HealthCareProviderHeader_prod.Specificities(Input_Data).Specificities[1];
LinkScore := JOIN(Input_Candidates,Input_Candidates,left.RID>right.RID,HealthCareProviderHeader_prod.Debug(Input_Data,s).sample_match_join(LEFT,RIGHT,0),ALL);
OUTPUT(LinkScore);
ENDMACRO;
