/*--SOAP--
<message name="MEOW_xLNPID_Service">
<part name="FNAME" type="xsd:string"/>
<part name="MNAME" type="xsd:string"/>
<part name="LNAME" type="xsd:string"/>
<part name="SNAME" type="xsd:string"/>
<part name="GENDER" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="V_CITY_NAME" type="xsd:string"/>
<part name="ST" type="xsd:string"/>
<part name="ZIP" type="xsd:string"/>
<part name="SSN" type="xsd:string"/>
<part name="CNSMR_SSN" type="xsd:string"/>
<part name="DOB" type="xsd:string"/>
<part name="CNSMR_DOB" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="LIC_STATE" type="xsd:string"/>
<part name="C_LIC_NBR" type="xsd:string"/>
<part name="TAX_ID" type="xsd:string"/>
<part name="BILLING_TAX_ID" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="VENDOR_ID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
<part name="BILLING_NPI_NUMBER" type="xsd:string"/>
<part name="UPIN" type="xsd:string"/>
<part name="DID" type="xsd:string"/>
<part name="BDID" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="SOURCE_RID" type="xsd:string"/>
<part name="RID" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="ADDR1" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="ADDRESS" type="xsd:string"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Attempt to resolve or find LNPIDs.
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>LNAME:ST:C_LIC_NBR</p>
<p>LNAME:ST</p>
<p>LNAME:ZIP:C_LIC_NBR</p>
<p>LNAME:ZIP</p>
<p>LNAME:MNAME:ST</p>
<p>PRIM_RANGE:PRIM_NAME:ZIP</p>
<p>PRIM_NAME:ZIP</p>
<p>SSN</p>
<p>CNSMR_SSN</p>
<p>DOB:FNAME:LNAME</p>
<p>CNSMR_DOB:FNAME:LNAME</p>
<p>PHONE</p>
<p>C_LIC_NBR:LIC_STATE</p>
<p>VENDOR_ID:SRC</p>
<p>TAX_ID</p>
<p>BILLING_TAX_ID</p>
<p>DEA_NUMBER</p>
<p>NPI_NUMBER</p>
<p>BILLING_NPI_NUMBER</p>
<p>UPIN</p>
<p>DID</p>
<p>BDID</p>
<p>SOURCE_RID</p>
<p>RID</p>
*/
EXPORT MEOW_xLNPID_Service := MACRO
  IMPORT SALT311,Health_Provider_Services;
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(3)));
  SALT311.StrType Input_FNAME := '' : STORED('FNAME', FORMAT(SEQUENCE(4)));
  SALT311.StrType Input_MNAME := '' : STORED('MNAME', FORMAT(SEQUENCE(5)));
  SALT311.StrType Input_LNAME := '' : STORED('LNAME', FORMAT(SEQUENCE(6)));
  SALT311.StrType Input_SNAME := '' : STORED('SNAME', FORMAT(SEQUENCE(7)));
  SALT311.StrType Input_GENDER := '' : STORED('GENDER', FORMAT(SEQUENCE(8)));
  SALT311.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE', FORMAT(SEQUENCE(9)));
  SALT311.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME', FORMAT(SEQUENCE(10)));
  SALT311.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE', FORMAT(SEQUENCE(11)));
  SALT311.StrType Input_V_CITY_NAME := '' : STORED('V_CITY_NAME', FORMAT(SEQUENCE(12)));
  SALT311.StrType Input_ST := '' : STORED('ST', FORMAT(SEQUENCE(13)));
  SALT311.StrType Input_ZIP := '' : STORED('ZIP', FORMAT(SEQUENCE(14)));
  SALT311.StrType Input_SSN := '' : STORED('SSN', FORMAT(SEQUENCE(15)));
  SALT311.StrType Input_CNSMR_SSN := '' : STORED('CNSMR_SSN', FORMAT(SEQUENCE(16)));
  SALT311.StrType Input_DOB := '' : STORED('DOB', FORMAT(SEQUENCE(17)));
  SALT311.StrType Input_CNSMR_DOB := '' : STORED('CNSMR_DOB', FORMAT(SEQUENCE(18)));
  SALT311.StrType Input_PHONE := '' : STORED('PHONE', FORMAT(SEQUENCE(19)));
  SALT311.StrType Input_LIC_STATE := '' : STORED('LIC_STATE', FORMAT(SEQUENCE(20)));
  SALT311.StrType Input_C_LIC_NBR := '' : STORED('C_LIC_NBR', FORMAT(SEQUENCE(21)));
  SALT311.StrType Input_TAX_ID := '' : STORED('TAX_ID', FORMAT(SEQUENCE(22)));
  SALT311.StrType Input_BILLING_TAX_ID := '' : STORED('BILLING_TAX_ID', FORMAT(SEQUENCE(23)));
  SALT311.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER', FORMAT(SEQUENCE(24)));
  SALT311.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID', FORMAT(SEQUENCE(25)));
  SALT311.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER', FORMAT(SEQUENCE(26)));
  SALT311.StrType Input_BILLING_NPI_NUMBER := '' : STORED('BILLING_NPI_NUMBER', FORMAT(SEQUENCE(27)));
  SALT311.StrType Input_UPIN := '' : STORED('UPIN', FORMAT(SEQUENCE(28)));
  SALT311.StrType Input_DID := '' : STORED('DID', FORMAT(SEQUENCE(29)));
  SALT311.StrType Input_BDID := '' : STORED('BDID', FORMAT(SEQUENCE(30)));
  SALT311.StrType Input_SRC := '' : STORED('SRC', FORMAT(SEQUENCE(31)));
  SALT311.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID', FORMAT(SEQUENCE(32)));
  SALT311.StrType Input_RID := '' : STORED('RID', FORMAT(SEQUENCE(33)));
  SALT311.StrType Input_MAINNAME := '' : STORED('MAINNAME', FORMAT(SEQUENCE(34)));
  SALT311.StrType Input_FULLNAME := '' : STORED('FULLNAME', FORMAT(SEQUENCE(35)));
  SALT311.StrType Input_ADDR1 := '' : STORED('ADDR1', FORMAT(SEQUENCE(36)));
  SALT311.StrType Input_LOCALE := '' : STORED('LOCALE', FORMAT(SEQUENCE(37)));
  SALT311.StrType Input_ADDRESS := '' : STORED('ADDRESS', FORMAT(SEQUENCE(38)));
  UNSIGNED e_LNPID := 0 : STORED('LNPID', FORMAT(SEQUENCE(39)));
 
  Template := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.FNAME))Health_Provider_Services.Fields.Make_FNAME((SALT311.StrType)Input_FNAME)
  ,(TYPEOF(Template.MNAME))Health_Provider_Services.Fields.Make_MNAME((SALT311.StrType)Input_MNAME)
  ,(TYPEOF(Template.LNAME))Health_Provider_Services.Fields.Make_LNAME((SALT311.StrType)Input_LNAME)
  ,(TYPEOF(Template.SNAME))Health_Provider_Services.Fields.Make_SNAME((SALT311.StrType)Input_SNAME)
  ,(TYPEOF(Template.GENDER))Health_Provider_Services.Fields.Make_GENDER((SALT311.StrType)Input_GENDER)
  ,(TYPEOF(Template.PRIM_RANGE))Health_Provider_Services.Fields.Make_PRIM_RANGE((SALT311.StrType)Input_PRIM_RANGE)
  ,(TYPEOF(Template.PRIM_NAME))Health_Provider_Services.Fields.Make_PRIM_NAME((SALT311.StrType)Input_PRIM_NAME)
  ,(TYPEOF(Template.SEC_RANGE))Health_Provider_Services.Fields.Make_SEC_RANGE((SALT311.StrType)Input_SEC_RANGE)
  ,(TYPEOF(Template.V_CITY_NAME))Health_Provider_Services.Fields.Make_V_CITY_NAME((SALT311.StrType)Input_V_CITY_NAME)
  ,(TYPEOF(Template.ST))Health_Provider_Services.Fields.Make_ST((SALT311.StrType)Input_ST)
  ,(TYPEOF(Template.ZIP))Health_Provider_Services.Fields.Make_ZIP((SALT311.StrType)Input_ZIP)
  ,(TYPEOF(Template.SSN))Health_Provider_Services.Fields.Make_SSN((SALT311.StrType)Input_SSN)
  ,(TYPEOF(Template.CNSMR_SSN))Health_Provider_Services.Fields.Make_CNSMR_SSN((SALT311.StrType)Input_CNSMR_SSN)
  ,(TYPEOF(Template.DOB))Health_Provider_Services.Fields.Make_DOB((SALT311.StrType)Input_DOB)
  ,(TYPEOF(Template.CNSMR_DOB))Health_Provider_Services.Fields.Make_CNSMR_DOB((SALT311.StrType)Input_CNSMR_DOB)
  ,(TYPEOF(Template.PHONE))Health_Provider_Services.Fields.Make_PHONE((SALT311.StrType)Input_PHONE)
  ,(TYPEOF(Template.LIC_STATE))Health_Provider_Services.Fields.Make_LIC_STATE((SALT311.StrType)Input_LIC_STATE)
  ,(TYPEOF(Template.C_LIC_NBR))Health_Provider_Services.Fields.Make_C_LIC_NBR((SALT311.StrType)Input_C_LIC_NBR)
  ,(TYPEOF(Template.TAX_ID))Health_Provider_Services.Fields.Make_TAX_ID((SALT311.StrType)Input_TAX_ID)
  ,(TYPEOF(Template.BILLING_TAX_ID))Health_Provider_Services.Fields.Make_BILLING_TAX_ID((SALT311.StrType)Input_BILLING_TAX_ID)
  ,(TYPEOF(Template.DEA_NUMBER))Health_Provider_Services.Fields.Make_DEA_NUMBER((SALT311.StrType)Input_DEA_NUMBER)
  ,(TYPEOF(Template.VENDOR_ID))Health_Provider_Services.Fields.Make_VENDOR_ID((SALT311.StrType)Input_VENDOR_ID)
  ,(TYPEOF(Template.NPI_NUMBER))Health_Provider_Services.Fields.Make_NPI_NUMBER((SALT311.StrType)Input_NPI_NUMBER)
  ,(TYPEOF(Template.BILLING_NPI_NUMBER))Health_Provider_Services.Fields.Make_BILLING_NPI_NUMBER((SALT311.StrType)Input_BILLING_NPI_NUMBER)
  ,(TYPEOF(Template.UPIN))Health_Provider_Services.Fields.Make_UPIN((SALT311.StrType)Input_UPIN)
  ,(TYPEOF(Template.DID))Health_Provider_Services.Fields.Make_DID((SALT311.StrType)Input_DID)
  ,(TYPEOF(Template.BDID))Health_Provider_Services.Fields.Make_BDID((SALT311.StrType)Input_BDID)
  ,(TYPEOF(Template.SRC))Health_Provider_Services.Fields.Make_SRC((SALT311.StrType)Input_SRC)
  ,(TYPEOF(Template.SOURCE_RID))Health_Provider_Services.Fields.Make_SOURCE_RID((SALT311.StrType)Input_SOURCE_RID)
  ,(TYPEOF(Template.RID))Health_Provider_Services.Fields.Make_RID((SALT311.StrType)Input_RID)
  ,(TYPEOF(Template.MAINNAME))Health_Provider_Services.Fields.Make_MAINNAME((SALT311.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.FULLNAME))Health_Provider_Services.Fields.Make_FULLNAME((SALT311.StrType)Input_FULLNAME)
  ,(TYPEOF(Template.ADDR1))Health_Provider_Services.Fields.Make_ADDR1((SALT311.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))Health_Provider_Services.Fields.Make_LOCALE((SALT311.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRESS))Health_Provider_Services.Fields.Make_ADDRESS((SALT311.StrType)Input_ADDRESS)
  ,false,false,0}],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
 
  pm := Health_Provider_Services.MEOW_xLNPID(Input_Data); // This module performs regular xLNPID functions
  OUTPUT(pm.Raw_Results,NAMED('Results'));
ENDMACRO;
