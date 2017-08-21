/*--SOAP--
<message name="LNPID_Header_Service">
<part name="DID" type="xsd:string"/>
<part name="DOB" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="SNAME" type="xsd:string"/>
<part name="FNAME" type="xsd:string"/>
<part name="MNAME" type="xsd:string"/>
<part name="LNAME" type="xsd:string"/>
<part name="GENDER" type="xsd:string"/>
<part name="DERIVED_GENDER" type="xsd:string"/>
<part name="LIC_NBR" type="xsd:string"/>
<part name="ADDRESS_ID" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="V_CITY_NAME" type="xsd:string"/>
<part name="ST" type="xsd:string"/>
<part name="ZIP" type="xsd:string"/>
<part name="CNAME" type="xsd:string"/>
<part name="TAX_ID" type="xsd:string"/>
<part name="UPIN" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="VENDOR_ID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
<part name="DT_FIRST_SEEN" type="xsd:string"/>
<part name="DT_LAST_SEEN" type="xsd:string"/>
<part name="DT_LIC_EXPIRATION" type="xsd:string"/>
<part name="DT_DEA_EXPIRATION" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="FULLNAME_DOB" type="xsd:string"/>
<part name="ADDR" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="ADDRESS" type="xsd:string"/>
<part name="LIC_STATE" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="LNPID" type="unsignedInt"/>
<part name="RID" type="unsignedInt"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Find those entities having records matching the input criteria.<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT LNPID_Header_Service := MACRO
  IMPORT SALT27,HealthCareProviderHeader;
  SALT27.StrType Input_DID := '' : STORED('DID');
  SALT27.StrType Input_DOB := '' : STORED('DOB');
  SALT27.StrType Input_PHONE := '' : STORED('PHONE');
  SALT27.StrType Input_SNAME := '' : STORED('SNAME');
  SALT27.StrType Input_FNAME := '' : STORED('FNAME');
  SALT27.StrType Input_MNAME := '' : STORED('MNAME');
  SALT27.StrType Input_LNAME := '' : STORED('LNAME');
  SALT27.StrType Input_GENDER := '' : STORED('GENDER');
  SALT27.StrType Input_DERIVED_GENDER := '' : STORED('DERIVED_GENDER');
  SALT27.StrType Input_LIC_NBR := '' : STORED('LIC_NBR');
  SALT27.StrType Input_ADDRESS_ID := '' : STORED('ADDRESS_ID');
  SALT27.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME');
  SALT27.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE');
  SALT27.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE');
  SALT27.StrType Input_V_CITY_NAME := '' : STORED('V_CITY_NAME');
  SALT27.StrType Input_ST := '' : STORED('ST');
  SALT27.StrType Input_ZIP := '' : STORED('ZIP');
  SALT27.StrType Input_CNAME := '' : STORED('CNAME');
  SALT27.StrType Input_TAX_ID := '' : STORED('TAX_ID');
  SALT27.StrType Input_UPIN := '' : STORED('UPIN');
  SALT27.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER');
  SALT27.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID');
  SALT27.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER');
  SALT27.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN');
  SALT27.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN');
  SALT27.StrType Input_DT_LIC_EXPIRATION := '' : STORED('DT_LIC_EXPIRATION');
  SALT27.StrType Input_DT_DEA_EXPIRATION := '' : STORED('DT_DEA_EXPIRATION');
  SALT27.StrType Input_MAINNAME := '' : STORED('MAINNAME');
  SALT27.StrType Input_FULLNAME := '' : STORED('FULLNAME');
  SALT27.StrType Input_FULLNAME_DOB := '' : STORED('FULLNAME_DOB');
  SALT27.StrType Input_ADDR := '' : STORED('ADDR');
  SALT27.StrType Input_LOCALE := '' : STORED('LOCALE');
  SALT27.StrType Input_ADDRESS := '' : STORED('ADDRESS');
  SALT27.StrType Input_LIC_STATE := '' : STORED('LIC_STATE');
  SALT27.StrType Input_SRC := '' : STORED('SRC');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED e_LNPID := 0 : STORED('LNPID');
  UNSIGNED e_RID := 0 : STORED('RID');
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord');
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly');
  Template := DATASET([],HealthCareProviderHeader.Process_LNPID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds
  ,(typeof(Template.DID))Input_DID
  ,(typeof(Template.DOB))HealthCareProviderHeader.Fields.Make_DOB((SALT27.StrType)Input_DOB)
  ,(typeof(Template.PHONE))HealthCareProviderHeader.Fields.Make_PHONE((SALT27.StrType)Input_PHONE)
  ,(typeof(Template.SNAME))HealthCareProviderHeader.Fields.Make_SNAME((SALT27.StrType)Input_SNAME)
  ,(typeof(Template.FNAME))HealthCareProviderHeader.Fields.Make_FNAME((SALT27.StrType)Input_FNAME)
  ,(typeof(Template.MNAME))HealthCareProviderHeader.Fields.Make_MNAME((SALT27.StrType)Input_MNAME)
  ,(typeof(Template.LNAME))HealthCareProviderHeader.Fields.Make_LNAME((SALT27.StrType)Input_LNAME)
  ,(typeof(Template.GENDER))HealthCareProviderHeader.Fields.Make_GENDER((SALT27.StrType)Input_GENDER)
  ,(typeof(Template.DERIVED_GENDER))HealthCareProviderHeader.Fields.Make_DERIVED_GENDER((SALT27.StrType)Input_DERIVED_GENDER)
  ,(typeof(Template.LIC_NBR))HealthCareProviderHeader.Fields.Make_LIC_NBR((SALT27.StrType)Input_LIC_NBR)
  ,(typeof(Template.ADDRESS_ID))Input_ADDRESS_ID
  ,(typeof(Template.PRIM_NAME))HealthCareProviderHeader.Fields.Make_PRIM_NAME((SALT27.StrType)Input_PRIM_NAME)
  ,(typeof(Template.PRIM_RANGE))HealthCareProviderHeader.Fields.Make_PRIM_RANGE((SALT27.StrType)Input_PRIM_RANGE)
  ,(typeof(Template.SEC_RANGE))HealthCareProviderHeader.Fields.Make_SEC_RANGE((SALT27.StrType)Input_SEC_RANGE)
  ,(typeof(Template.V_CITY_NAME))HealthCareProviderHeader.Fields.Make_V_CITY_NAME((SALT27.StrType)Input_V_CITY_NAME)
  ,(typeof(Template.ST))HealthCareProviderHeader.Fields.Make_ST((SALT27.StrType)Input_ST)
  ,(typeof(Template.ZIP))HealthCareProviderHeader.Fields.Make_ZIP((SALT27.StrType)Input_ZIP)
  ,(typeof(Template.CNAME))HealthCareProviderHeader.Fields.Make_CNAME((SALT27.StrType)Input_CNAME)
  ,(typeof(Template.TAX_ID))HealthCareProviderHeader.Fields.Make_TAX_ID((SALT27.StrType)Input_TAX_ID)
  ,(typeof(Template.UPIN))HealthCareProviderHeader.Fields.Make_UPIN((SALT27.StrType)Input_UPIN)
  ,(typeof(Template.DEA_NUMBER))HealthCareProviderHeader.Fields.Make_DEA_NUMBER((SALT27.StrType)Input_DEA_NUMBER)
  ,(typeof(Template.VENDOR_ID))HealthCareProviderHeader.Fields.Make_VENDOR_ID((SALT27.StrType)Input_VENDOR_ID)
  ,(typeof(Template.NPI_NUMBER))HealthCareProviderHeader.Fields.Make_NPI_NUMBER((SALT27.StrType)Input_NPI_NUMBER)
  ,(typeof(Template.DT_FIRST_SEEN))HealthCareProviderHeader.Fields.Make_DT_FIRST_SEEN((SALT27.StrType)Input_DT_FIRST_SEEN)
  ,(typeof(Template.DT_LAST_SEEN))HealthCareProviderHeader.Fields.Make_DT_LAST_SEEN((SALT27.StrType)Input_DT_LAST_SEEN)
  ,(typeof(Template.DT_LIC_EXPIRATION))HealthCareProviderHeader.Fields.Make_DT_LIC_EXPIRATION((SALT27.StrType)Input_DT_LIC_EXPIRATION)
  ,(typeof(Template.DT_DEA_EXPIRATION))HealthCareProviderHeader.Fields.Make_DT_DEA_EXPIRATION((SALT27.StrType)Input_DT_DEA_EXPIRATION)
  ,(typeof(Template.MAINNAME))HealthCareProviderHeader.Fields.Make_MAINNAME((SALT27.StrType)Input_MAINNAME)
  ,(typeof(Template.FULLNAME))HealthCareProviderHeader.Fields.Make_FULLNAME((SALT27.StrType)Input_FULLNAME)
  ,(typeof(Template.FULLNAME_DOB))HealthCareProviderHeader.Fields.Make_FULLNAME_DOB((SALT27.StrType)Input_FULLNAME_DOB)
  ,(typeof(Template.ADDR))HealthCareProviderHeader.Fields.Make_ADDR((SALT27.StrType)Input_ADDR)
  ,(typeof(Template.LOCALE))HealthCareProviderHeader.Fields.Make_LOCALE((SALT27.StrType)Input_LOCALE)
  ,(typeof(Template.ADDRESS))HealthCareProviderHeader.Fields.Make_ADDRESS((SALT27.StrType)Input_ADDRESS)
  ,(typeof(Template.LIC_STATE))Input_LIC_STATE
  ,(typeof(Template.SRC))Input_SRC
  ,RecordsOnly,FullMatch,e_RID,e_LNPID}],HealthCareProviderHeader.Process_LNPID_Layouts.InputLayout);
  pm := HealthCareProviderHeader.MEOW_LNPID(Input_Data); // This module performs regular xLNPID functions
  OUTPUT(pm.Data_,NAMED('Header_Data'));
ENDMACRO;
