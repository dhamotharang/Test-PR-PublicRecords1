/*--SOAP--
<message name="xLNPID_FragHunter_Service">
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
<part name="LNPID" type="unsignedInt"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Return all available data for LNPID with similar fields to the one provided</p><p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>FNAME:LNAME:ST:C_LIC_NBR
</p><p>FNAME:LNAME:ST
</p><p>LNAME:FNAME:ZIP:C_LIC_NBR
</p><p>LNAME:FNAME:ZIP
</p><p>PRIM_RANGE:PRIM_NAME:ZIP
</p><p>PRIM_NAME:ZIP
</p><p>SSN
</p><p>CNSMR_SSN
</p><p>DOB:FNAME:LNAME
</p><p>CNSMR_DOB:FNAME:LNAME
</p><p>PHONE
</p><p>C_LIC_NBR:LIC_STATE
</p><p>VENDOR_ID:SRC
</p><p>TAX_ID
</p><p>BILLING_TAX_ID
</p><p>DEA_NUMBER
</p><p>NPI_NUMBER
</p><p>BILLING_NPI_NUMBER
</p><p>UPIN
</p><p>DID
</p><p>BDID
</p><p>SOURCE_RID
</p><p>RID
</p>*/
EXPORT xLNPID_FragHunter_Service := MACRO
  IMPORT SALT29,Health_Provider_Services;
  SALT29.StrType Input_FNAME := '' : STORED('FNAME');
  SALT29.StrType Input_MNAME := '' : STORED('MNAME');
  SALT29.StrType Input_LNAME := '' : STORED('LNAME');
  SALT29.StrType Input_SNAME := '' : STORED('SNAME');
  SALT29.StrType Input_GENDER := '' : STORED('GENDER');
  SALT29.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE');
  SALT29.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME');
  SALT29.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE');
  SALT29.StrType Input_V_CITY_NAME := '' : STORED('V_CITY_NAME');
  SALT29.StrType Input_ST := '' : STORED('ST');
  SALT29.StrType Input_ZIP := '' : STORED('ZIP');
  SALT29.StrType Input_SSN := '' : STORED('SSN');
  SALT29.StrType Input_CNSMR_SSN := '' : STORED('CNSMR_SSN');
  SALT29.StrType Input_DOB := '' : STORED('DOB');
  SALT29.StrType Input_CNSMR_DOB := '' : STORED('CNSMR_DOB');
  SALT29.StrType Input_PHONE := '' : STORED('PHONE');
  SALT29.StrType Input_LIC_STATE := '' : STORED('LIC_STATE');
  SALT29.StrType Input_C_LIC_NBR := '' : STORED('C_LIC_NBR');
  SALT29.StrType Input_TAX_ID := '' : STORED('TAX_ID');
  SALT29.StrType Input_BILLING_TAX_ID := '' : STORED('BILLING_TAX_ID');
  SALT29.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER');
  SALT29.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID');
  SALT29.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER');
  SALT29.StrType Input_BILLING_NPI_NUMBER := '' : STORED('BILLING_NPI_NUMBER');
  SALT29.StrType Input_UPIN := '' : STORED('UPIN');
  SALT29.StrType Input_DID := '' : STORED('DID');
  SALT29.StrType Input_BDID := '' : STORED('BDID');
  SALT29.StrType Input_SRC := '' : STORED('SRC');
  SALT29.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID');
  SALT29.StrType Input_RID := '' : STORED('RID');
  SALT29.StrType Input_MAINNAME := '' : STORED('MAINNAME');
  SALT29.StrType Input_FULLNAME := '' : STORED('FULLNAME');
  SALT29.StrType Input_ADDR1 := '' : STORED('ADDR1');
  SALT29.StrType Input_LOCALE := '' : STORED('LOCALE');
  SALT29.StrType Input_ADDRESS := '' : STORED('ADDRESS');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold');
  UNSIGNED e_LNPID := 0 : STORED('LNPID');
  Template := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.FNAME))Health_Provider_Services.Fields.Make_FNAME((SALT29.StrType)Input_FNAME)
  ,(TYPEOF(Template.MNAME))Health_Provider_Services.Fields.Make_MNAME((SALT29.StrType)Input_MNAME)
  ,(TYPEOF(Template.LNAME))Health_Provider_Services.Fields.Make_LNAME((SALT29.StrType)Input_LNAME)
  ,(TYPEOF(Template.SNAME))Health_Provider_Services.Fields.Make_SNAME((SALT29.StrType)Input_SNAME)
  ,(TYPEOF(Template.GENDER))Health_Provider_Services.Fields.Make_GENDER((SALT29.StrType)Input_GENDER)
  ,(TYPEOF(Template.PRIM_RANGE))Health_Provider_Services.Fields.Make_PRIM_RANGE((SALT29.StrType)Input_PRIM_RANGE)
  ,(TYPEOF(Template.PRIM_NAME))Health_Provider_Services.Fields.Make_PRIM_NAME((SALT29.StrType)Input_PRIM_NAME)
  ,(TYPEOF(Template.SEC_RANGE))Health_Provider_Services.Fields.Make_SEC_RANGE((SALT29.StrType)Input_SEC_RANGE)
  ,(TYPEOF(Template.V_CITY_NAME))Health_Provider_Services.Fields.Make_V_CITY_NAME((SALT29.StrType)Input_V_CITY_NAME)
  ,(TYPEOF(Template.ST))Health_Provider_Services.Fields.Make_ST((SALT29.StrType)Input_ST)
  ,(TYPEOF(Template.ZIP))Health_Provider_Services.Fields.Make_ZIP((SALT29.StrType)Input_ZIP)
  ,(TYPEOF(Template.SSN))Health_Provider_Services.Fields.Make_SSN((SALT29.StrType)Input_SSN)
  ,(TYPEOF(Template.CNSMR_SSN))Health_Provider_Services.Fields.Make_CNSMR_SSN((SALT29.StrType)Input_CNSMR_SSN)
  ,(TYPEOF(Template.DOB))Health_Provider_Services.Fields.Make_DOB((SALT29.StrType)Input_DOB)
  ,(TYPEOF(Template.CNSMR_DOB))Health_Provider_Services.Fields.Make_CNSMR_DOB((SALT29.StrType)Input_CNSMR_DOB)
  ,(TYPEOF(Template.PHONE))Health_Provider_Services.Fields.Make_PHONE((SALT29.StrType)Input_PHONE)
  ,(TYPEOF(Template.LIC_STATE))Health_Provider_Services.Fields.Make_LIC_STATE((SALT29.StrType)Input_LIC_STATE)
  ,(TYPEOF(Template.C_LIC_NBR))Health_Provider_Services.Fields.Make_C_LIC_NBR((SALT29.StrType)Input_C_LIC_NBR)
  ,(TYPEOF(Template.TAX_ID))Health_Provider_Services.Fields.Make_TAX_ID((SALT29.StrType)Input_TAX_ID)
  ,(TYPEOF(Template.BILLING_TAX_ID))Health_Provider_Services.Fields.Make_BILLING_TAX_ID((SALT29.StrType)Input_BILLING_TAX_ID)
  ,(TYPEOF(Template.DEA_NUMBER))Health_Provider_Services.Fields.Make_DEA_NUMBER((SALT29.StrType)Input_DEA_NUMBER)
  ,(TYPEOF(Template.VENDOR_ID))Health_Provider_Services.Fields.Make_VENDOR_ID((SALT29.StrType)Input_VENDOR_ID)
  ,(TYPEOF(Template.NPI_NUMBER))Health_Provider_Services.Fields.Make_NPI_NUMBER((SALT29.StrType)Input_NPI_NUMBER)
  ,(TYPEOF(Template.BILLING_NPI_NUMBER))Health_Provider_Services.Fields.Make_BILLING_NPI_NUMBER((SALT29.StrType)Input_BILLING_NPI_NUMBER)
  ,(TYPEOF(Template.UPIN))Health_Provider_Services.Fields.Make_UPIN((SALT29.StrType)Input_UPIN)
  ,(TYPEOF(Template.DID))Health_Provider_Services.Fields.Make_DID((SALT29.StrType)Input_DID)
  ,(TYPEOF(Template.BDID))Health_Provider_Services.Fields.Make_BDID((SALT29.StrType)Input_BDID)
  ,(TYPEOF(Template.SRC))Health_Provider_Services.Fields.Make_SRC((SALT29.StrType)Input_SRC)
  ,(TYPEOF(Template.SOURCE_RID))Health_Provider_Services.Fields.Make_SOURCE_RID((SALT29.StrType)Input_SOURCE_RID)
  ,(TYPEOF(Template.RID))Health_Provider_Services.Fields.Make_RID((SALT29.StrType)Input_RID)
  ,(TYPEOF(Template.MAINNAME))Health_Provider_Services.Fields.Make_MAINNAME((SALT29.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.FULLNAME))Health_Provider_Services.Fields.Make_FULLNAME((SALT29.StrType)Input_FULLNAME)
  ,(TYPEOF(Template.ADDR1))Health_Provider_Services.Fields.Make_ADDR1((SALT29.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))Health_Provider_Services.Fields.Make_LOCALE((SALT29.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRESS))Health_Provider_Services.Fields.Make_ADDRESS((SALT29.StrType)Input_ADDRESS)
  ,false,false,e_LNPID}],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
  pm := Health_Provider_Services.MEOW_xLNPID(Input_Data); // This module performs regular xLNPID functions
  ds := pm.DataToSearch;
  fids := SET(pm.Uid_Results,LNPID);
  odm := Health_Provider_Services.MEOW_xLNPID(ds,true,fids);
  OUTPUT(odm.Raw_Results,NAMED('PossibleFragments'));
  OUTPUT(odm.Raw_Data,NAMED('FragmentData'));
  OUTPUT(pm.Raw_Data,NAMED('OriginalData'));
ENDMACRO;
