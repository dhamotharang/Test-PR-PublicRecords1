/*--SOAP--
<message name="MEOW_LNPID_Service">
<part name="VENDOR_ID" type="xsd:string"/>
<part name="DID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="LIC_NBR" type="xsd:string"/>
<part name="UPIN" type="xsd:string"/>
<part name="ADDR" type="xsd:string"/>
<part name="ADDRESS" type="xsd:string"/>
<part name="TAX_ID" type="xsd:string"/>
<part name="DOB" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="ZIP" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="LNAME" type="xsd:string"/>
<part name="V_CITY_NAME" type="xsd:string"/>
<part name="MNAME" type="xsd:string"/>
<part name="FNAME" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="SNAME" type="xsd:string"/>
<part name="ST" type="xsd:string"/>
<part name="GENDER" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="LIC_STATE" type="xsd:string"/>
<part name="ADDRESS_ID" type="xsd:string"/>
<part name="CNAME" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="DT_FIRST_SEEN" type="xsd:string"/>
<part name="DT_LAST_SEEN" type="xsd:string"/>
<part name="DT_LIC_EXPIRATION" type="xsd:string"/>
<part name="DT_DEA_EXPIRATION" type="xsd:string"/>
<part name="GEO_LAT" type="xsd:string"/>
<part name="GEO_LONG" type="xsd:string"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/

/*--INFO-- Attempt to resolve or find LNPIDs.<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
*/
EXPORT MEOW_LNPID_Service := MACRO
IMPORT SALT27,HealthCareProviderHeader_prod;
SALT27.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID');
SALT27.StrType Input_DID := '' : STORED('DID');
SALT27.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER');
SALT27.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER');
SALT27.StrType Input_MAINNAME := '' : STORED('MAINNAME');
SALT27.StrType Input_FULLNAME := '' : STORED('FULLNAME');
SALT27.StrType Input_LIC_NBR := '' : STORED('LIC_NBR');
SALT27.StrType Input_UPIN := '' : STORED('UPIN');
SALT27.StrType Input_ADDR := '' : STORED('ADDR');
SALT27.StrType Input_ADDRESS := '' : STORED('ADDRESS');
SALT27.StrType Input_TAX_ID := '' : STORED('TAX_ID');
SALT27.StrType Input_DOB := '' : STORED('DOB');
SALT27.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME');
SALT27.StrType Input_ZIP := '' : STORED('ZIP');
SALT27.StrType Input_LOCALE := '' : STORED('LOCALE');
SALT27.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE');
SALT27.StrType Input_LNAME := '' : STORED('LNAME');
SALT27.StrType Input_V_CITY_NAME := '' : STORED('V_CITY_NAME');
SALT27.StrType Input_MNAME := '' : STORED('MNAME');
SALT27.StrType Input_FNAME := '' : STORED('FNAME');
SALT27.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE');
SALT27.StrType Input_SNAME := '' : STORED('SNAME');
SALT27.StrType Input_ST := '' : STORED('ST');
SALT27.StrType Input_GENDER := '' : STORED('GENDER');
SALT27.StrType Input_PHONE := '' : STORED('PHONE');
SALT27.StrType Input_LIC_STATE := '' : STORED('LIC_STATE');
SALT27.StrType Input_ADDRESS_ID := '' : STORED('ADDRESS_ID');
SALT27.StrType Input_CNAME := '' : STORED('CNAME');
SALT27.StrType Input_SRC := '' : STORED('SRC');
SALT27.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN');
SALT27.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN');
SALT27.StrType Input_DT_LIC_EXPIRATION := '' : STORED('DT_LIC_EXPIRATION');
SALT27.StrType Input_DT_DEA_EXPIRATION := '' : STORED('DT_DEA_EXPIRATION');
SALT27.StrType Input_GEO_LAT := '' : STORED('GEO_LAT');
SALT27.StrType Input_GEO_LONG := '' : STORED('GEO_LONG');
UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
UNSIGNED e_LNPID := 0 : STORED('LNPID');
UNSIGNED e_RID := 0 : STORED('RID');

Template := DATASET([],HealthCareProviderHeader_prod.Process_LNPID_Layouts.InputLayout);
Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds
,(typeof(Template.VENDOR_ID))HealthCareProviderHeader_prod.Fields.Make_VENDOR_ID((SALT27.StrType)Input_VENDOR_ID)
,(typeof(Template.DID))Input_DID
,(typeof(Template.NPI_NUMBER))HealthCareProviderHeader_prod.Fields.Make_NPI_NUMBER((SALT27.StrType)Input_NPI_NUMBER)
,(typeof(Template.DEA_NUMBER))HealthCareProviderHeader_prod.Fields.Make_DEA_NUMBER((SALT27.StrType)Input_DEA_NUMBER)
,(typeof(Template.MAINNAME))HealthCareProviderHeader_prod.Fields.Make_MAINNAME((SALT27.StrType)Input_MAINNAME)
,(typeof(Template.FULLNAME))HealthCareProviderHeader_prod.Fields.Make_FULLNAME((SALT27.StrType)Input_FULLNAME)
,(typeof(Template.LIC_NBR))HealthCareProviderHeader_prod.Fields.Make_LIC_NBR((SALT27.StrType)Input_LIC_NBR)
,(typeof(Template.UPIN))HealthCareProviderHeader_prod.Fields.Make_UPIN((SALT27.StrType)Input_UPIN)
,(typeof(Template.ADDR))HealthCareProviderHeader_prod.Fields.Make_ADDR((SALT27.StrType)Input_ADDR)
,(typeof(Template.ADDRESS))HealthCareProviderHeader_prod.Fields.Make_ADDRESS((SALT27.StrType)Input_ADDRESS)
,(typeof(Template.TAX_ID))HealthCareProviderHeader_prod.Fields.Make_TAX_ID((SALT27.StrType)Input_TAX_ID)
,(typeof(Template.DOB))HealthCareProviderHeader_prod.Fields.Make_DOB((SALT27.StrType)Input_DOB)
,(typeof(Template.PRIM_NAME))HealthCareProviderHeader_prod.Fields.Make_PRIM_NAME((SALT27.StrType)Input_PRIM_NAME)
,(typeof(Template.ZIP))HealthCareProviderHeader_prod.Fields.Make_ZIP((SALT27.StrType)Input_ZIP)
,(typeof(Template.LOCALE))HealthCareProviderHeader_prod.Fields.Make_LOCALE((SALT27.StrType)Input_LOCALE)
,(typeof(Template.PRIM_RANGE))HealthCareProviderHeader_prod.Fields.Make_PRIM_RANGE((SALT27.StrType)Input_PRIM_RANGE)
,(typeof(Template.LNAME))HealthCareProviderHeader_prod.Fields.Make_LNAME((SALT27.StrType)Input_LNAME)
,(typeof(Template.V_CITY_NAME))HealthCareProviderHeader_prod.Fields.Make_V_CITY_NAME((SALT27.StrType)Input_V_CITY_NAME)
,
,(typeof(Template.MNAME))HealthCareProviderHeader_prod.Fields.Make_MNAME((SALT27.StrType)Input_MNAME)
,(typeof(Template.FNAME))HealthCareProviderHeader_prod.Fields.Make_FNAME((SALT27.StrType)Input_FNAME)
,(typeof(Template.SEC_RANGE))HealthCareProviderHeader_prod.Fields.Make_SEC_RANGE((SALT27.StrType)Input_SEC_RANGE)
,(typeof(Template.SNAME))HealthCareProviderHeader_prod.Fields.Make_SNAME((SALT27.StrType)Input_SNAME)
,(typeof(Template.ST))HealthCareProviderHeader_prod.Fields.Make_ST((SALT27.StrType)Input_ST)
,IF ( HealthCareProviderHeader_prod.Fields.Invalid_GENDER((SALT27.StrType)Input_GENDER)=0,(typeof(Template.GENDER))Input_GENDER,(typeof(Template.GENDER))'')
,(typeof(Template.PHONE))HealthCareProviderHeader_prod.Fields.Make_PHONE((SALT27.StrType)Input_PHONE)
,(typeof(Template.LIC_STATE))HealthCareProviderHeader_prod.Fields.Make_LIC_STATE((SALT27.StrType)Input_LIC_STATE)
,(typeof(Template.ADDRESS_ID))Input_ADDRESS_ID
,(typeof(Template.CNAME))HealthCareProviderHeader_prod.Fields.Make_CNAME((SALT27.StrType)Input_CNAME)
,(typeof(Template.SRC))HealthCareProviderHeader_prod.Fields.Make_SRC((SALT27.StrType)Input_SRC)
,(typeof(Template.DT_FIRST_SEEN))HealthCareProviderHeader_prod.Fields.Make_DT_FIRST_SEEN((SALT27.StrType)Input_DT_FIRST_SEEN)
,(typeof(Template.DT_LAST_SEEN))HealthCareProviderHeader_prod.Fields.Make_DT_LAST_SEEN((SALT27.StrType)Input_DT_LAST_SEEN)
,(typeof(Template.DT_LIC_EXPIRATION))HealthCareProviderHeader_prod.Fields.Make_DT_LIC_EXPIRATION((SALT27.StrType)Input_DT_LIC_EXPIRATION)
,(typeof(Template.DT_DEA_EXPIRATION))HealthCareProviderHeader_prod.Fields.Make_DT_DEA_EXPIRATION((SALT27.StrType)Input_DT_DEA_EXPIRATION)
,(typeof(Template.GEO_LAT))HealthCareProviderHeader_prod.Fields.Make_GEO_LAT((SALT27.StrType)Input_GEO_LAT)
,(typeof(Template.GEO_LONG))HealthCareProviderHeader_prod.Fields.Make_GEO_LONG((SALT27.StrType)Input_GEO_LONG)
,false,false,0,0}],HealthCareProviderHeader_prod.Process_LNPID_Layouts.InputLayout);

pm := HealthCareProviderHeader_prod.MEOW_LNPID(Input_Data); // This module performs regular xLNPID functions
OUTPUT(pm.Raw_Results,NAMED('Results'));
ENDMACRO;
