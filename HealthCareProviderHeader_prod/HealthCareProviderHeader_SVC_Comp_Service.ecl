/*--SOAP--
<message name="HealthCareProviderHeader_SVC_Comp_Service">
<part name="VENDOR_ID" type="xsd:string"/>
<part name="DID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="LIC_NBR" type="xsd:string"/>
<part name="UPIN" type="xsd:string"/>
<part name="ADDR1" type="xsd:string"/>
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
<part name="LIC_STATE" type="xsd:string"/>
<part name="CNAME" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="DT_FIRST_SEEN" type="xsd:string"/>
<part name="DT_LAST_SEEN" type="xsd:string"/>
<part name="GEO_LAT" type="xsd:string"/>
<part name="GEO_LONG" type="xsd:string"/>
<part name="LNPID" type="unsignedInt"/>
<part name="RID" type="unsignedInt"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/

/*--INFO-- Return all available data for a given entity set. <p>The search criteria needs to be very tight!</p><p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
*/
EXPORT HealthCareProviderHeader_SVC_Comp_Service := MACRO
IMPORT SALT26b2,HealthCareProviderHeader_prod;
SALT26b2.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID');
SALT26b2.StrType Input_DID := '' : STORED('DID');
SALT26b2.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER');
SALT26b2.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER');
SALT26b2.StrType Input_MAINNAME := '' : STORED('MAINNAME');
SALT26b2.StrType Input_FULLNAME := '' : STORED('FULLNAME');
SALT26b2.StrType Input_LIC_NBR := '' : STORED('LIC_NBR');
SALT26b2.StrType Input_UPIN := '' : STORED('UPIN');
SALT26b2.StrType Input_ADDR1 := '' : STORED('ADDR1');
SALT26b2.StrType Input_ADDRESS := '' : STORED('ADDRESS');
SALT26b2.StrType Input_TAX_ID := '' : STORED('TAX_ID');
SALT26b2.StrType Input_DOB := '' : STORED('DOB');
SALT26b2.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME');
SALT26b2.StrType Input_ZIP := '' : STORED('ZIP');
SALT26b2.StrType Input_LOCALE := '' : STORED('LOCALE');
SALT26b2.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE');
SALT26b2.StrType Input_LNAME := '' : STORED('LNAME');
SALT26b2.StrType Input_V_CITY_NAME := '' : STORED('V_CITY_NAME');
SALT26b2.StrType Input_MNAME := '' : STORED('MNAME');
SALT26b2.StrType Input_FNAME := '' : STORED('FNAME');
SALT26b2.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE');
SALT26b2.StrType Input_SNAME := '' : STORED('SNAME');
SALT26b2.StrType Input_ST := '' : STORED('ST');
SALT26b2.StrType Input_GENDER := '' : STORED('GENDER');
SALT26b2.StrType Input_LIC_STATE := '' : STORED('LIC_STATE');
SALT26b2.StrType Input_CNAME := '' : STORED('CNAME');
SALT26b2.StrType Input_SRC := '' : STORED('SRC');
SALT26b2.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN');
SALT26b2.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN');
SALT26b2.StrType Input_GEO_LAT := '' : STORED('GEO_LAT');
SALT26b2.StrType Input_GEO_LONG := '' : STORED('GEO_LONG');
UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
UNSIGNED e_LNPID := 0 : STORED('LNPID');
UNSIGNED e_RID := 0 : STORED('RID');
// Options to override the data-bomb fetch

Template := DATASET([],HealthCareProviderHeader_prod.Process_HealthCareProviderHeader_SVC_Layouts.InputLayout);
Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID
,(typeof(Template.VENDOR_ID))HealthCareProviderHeader_prod.Fields.Make_VENDOR_ID((SALT26b2.StrType)Input_VENDOR_ID)
,(typeof(Template.DID))HealthCareProviderHeader_prod.Fields.Make_DID((SALT26b2.StrType)Input_DID)
,(typeof(Template.NPI_NUMBER))HealthCareProviderHeader_prod.Fields.Make_NPI_NUMBER((SALT26b2.StrType)Input_NPI_NUMBER)
,(typeof(Template.DEA_NUMBER))HealthCareProviderHeader_prod.Fields.Make_DEA_NUMBER((SALT26b2.StrType)Input_DEA_NUMBER)
,(typeof(Template.MAINNAME))HealthCareProviderHeader_prod.Fields.Make_MAINNAME((SALT26b2.StrType)Input_MAINNAME)
,(typeof(Template.FULLNAME))HealthCareProviderHeader_prod.Fields.Make_FULLNAME((SALT26b2.StrType)Input_FULLNAME)
,(typeof(Template.LIC_NBR))HealthCareProviderHeader_prod.Fields.Make_LIC_NBR((SALT26b2.StrType)Input_LIC_NBR)
,(typeof(Template.UPIN))HealthCareProviderHeader_prod.Fields.Make_UPIN((SALT26b2.StrType)Input_UPIN)
,(typeof(Template.ADDR1))HealthCareProviderHeader_prod.Fields.Make_ADDR1((SALT26b2.StrType)Input_ADDR1)
,(typeof(Template.ADDRESS))HealthCareProviderHeader_prod.Fields.Make_ADDRESS((SALT26b2.StrType)Input_ADDRESS)
,(typeof(Template.TAX_ID))HealthCareProviderHeader_prod.Fields.Make_TAX_ID((SALT26b2.StrType)Input_TAX_ID)
,(typeof(Template.DOB))HealthCareProviderHeader_prod.Fields.Make_DOB((SALT26b2.StrType)Input_DOB)
,(typeof(Template.PRIM_NAME))HealthCareProviderHeader_prod.Fields.Make_PRIM_NAME((SALT26b2.StrType)Input_PRIM_NAME)
,(typeof(Template.ZIP))HealthCareProviderHeader_prod.Fields.Make_ZIP((SALT26b2.StrType)Input_ZIP)
,(typeof(Template.LOCALE))HealthCareProviderHeader_prod.Fields.Make_LOCALE((SALT26b2.StrType)Input_LOCALE)
,(typeof(Template.PRIM_RANGE))HealthCareProviderHeader_prod.Fields.Make_PRIM_RANGE((SALT26b2.StrType)Input_PRIM_RANGE)
,(typeof(Template.LNAME))HealthCareProviderHeader_prod.Fields.Make_LNAME((SALT26b2.StrType)Input_LNAME)
,(typeof(Template.V_CITY_NAME))HealthCareProviderHeader_prod.Fields.Make_V_CITY_NAME((SALT26b2.StrType)Input_V_CITY_NAME)
,
,(typeof(Template.MNAME))HealthCareProviderHeader_prod.Fields.Make_MNAME((SALT26b2.StrType)Input_MNAME)
,(typeof(Template.FNAME))HealthCareProviderHeader_prod.Fields.Make_FNAME((SALT26b2.StrType)Input_FNAME)
,(typeof(Template.SEC_RANGE))HealthCareProviderHeader_prod.Fields.Make_SEC_RANGE((SALT26b2.StrType)Input_SEC_RANGE)
,(typeof(Template.SNAME))HealthCareProviderHeader_prod.Fields.Make_SNAME((SALT26b2.StrType)Input_SNAME)
,(typeof(Template.ST))HealthCareProviderHeader_prod.Fields.Make_ST((SALT26b2.StrType)Input_ST)
,IF ( HealthCareProviderHeader_prod.Fields.Invalid_GENDER((SALT26b2.StrType)Input_GENDER)=0,(typeof(Template.GENDER))Input_GENDER,(typeof(Template.GENDER))'')
,(typeof(Template.LIC_STATE))HealthCareProviderHeader_prod.Fields.Make_LIC_STATE((SALT26b2.StrType)Input_LIC_STATE)
,(typeof(Template.CNAME))HealthCareProviderHeader_prod.Fields.Make_CNAME((SALT26b2.StrType)Input_CNAME)
,(typeof(Template.SRC))HealthCareProviderHeader_prod.Fields.Make_SRC((SALT26b2.StrType)Input_SRC)
,(typeof(Template.DT_FIRST_SEEN))HealthCareProviderHeader_prod.Fields.Make_DT_FIRST_SEEN((SALT26b2.StrType)Input_DT_FIRST_SEEN)
,(typeof(Template.DT_LAST_SEEN))HealthCareProviderHeader_prod.Fields.Make_DT_LAST_SEEN((SALT26b2.StrType)Input_DT_LAST_SEEN)
,(typeof(Template.GEO_LAT))HealthCareProviderHeader_prod.Fields.Make_GEO_LAT((SALT26b2.StrType)Input_GEO_LAT)
,(typeof(Template.GEO_LONG))HealthCareProviderHeader_prod.Fields.Make_GEO_LONG((SALT26b2.StrType)Input_GEO_LONG)
,false,false,e_RID,e_LNPID}],HealthCareProviderHeader_prod.Process_HealthCareProviderHeader_SVC_Layouts.InputLayout);

pm := HealthCareProviderHeader_prod.MEOW_HealthCareProviderHeader_SVC(Input_Data); // This module performs regular xLNPID functions
Options := MODULE(HealthCareProviderHeader_prod.Externals.FetchParams) // Interface to pass parameters to fetch
EXPORT SET OF INTEGER2 ToFetch := [];
END;
e := HealthCareProviderHeader_prod.Externals.Fetch(pm.Uid_Results,Options); // Perform data-bomb fetch
OUTPUT(e,NAMED('DataBombs'));
ENDMACRO;
