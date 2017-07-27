/*--SOAP--
<message name="xLNPID_Comp_Service">
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
<part name="DOB" type="xsd:string"/>
<part name="LIC_STATE" type="xsd:string"/>
<part name="LIC_NBR" type="xsd:string"/>
<part name="TAX_ID" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="VENDOR_ID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
<part name="UPIN" type="xsd:string"/>
<part name="DID" type="xsd:string"/>
<part name="BDID" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="SOURCE_RID" type="xsd:string"/>
<part name="LNPID" type="unsignedInt"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Return all available data for a given entity set. <p>The search criteria needs to be very tight!</p><p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>FNAME:LNAME:ST
</p><p>LNAME:MNAME:ST
</p><p>FNAME:LNAME:DOB
</p><p>PRIM_RANGE:PRIM_NAME:ZIP
</p><p>SSN
</p><p>DOB:FNAME:LNAME
</p><p>ZIP:PRIM_RANGE
</p><p>LIC_NBR
</p><p>VENDOR_ID
</p><p>TAX_ID
</p><p>DEA_NUMBER
</p><p>NPI_NUMBER
</p><p>UPIN
</p><p>DID
</p><p>BDID
</p><p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT xLNPID_Comp_Service := MACRO
  IMPORT SALT25,Health_Provider_Services;
  SALT25.StrType Input_FNAME := '' : STORED('FNAME');
  SALT25.StrType Input_MNAME := '' : STORED('MNAME');
  SALT25.StrType Input_LNAME := '' : STORED('LNAME');
  SALT25.StrType Input_SNAME := '' : STORED('SNAME');
  SALT25.StrType Input_GENDER := '' : STORED('GENDER');
  SALT25.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE');
  SALT25.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME');
  SALT25.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE');
  SALT25.StrType Input_V_CITY_NAME := '' : STORED('V_CITY_NAME');
  SALT25.StrType Input_ST := '' : STORED('ST');
  SALT25.StrType Input_ZIP := '' : STORED('ZIP');
  SALT25.StrType Input_SSN := '' : STORED('SSN');
  SALT25.StrType Input_DOB := '' : STORED('DOB');
  SALT25.StrType Input_LIC_STATE := '' : STORED('LIC_STATE');
  SALT25.StrType Input_LIC_NBR := '' : STORED('LIC_NBR');
  SALT25.StrType Input_TAX_ID := '' : STORED('TAX_ID');
  SALT25.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER');
  SALT25.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID');
  SALT25.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER');
  SALT25.StrType Input_UPIN := '' : STORED('UPIN');
  SALT25.StrType Input_DID := '' : STORED('DID');
  SALT25.StrType Input_BDID := '' : STORED('BDID');
  SALT25.StrType Input_SRC := '' : STORED('SRC');
  SALT25.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED e_LNPID := 0 : STORED('LNPID');
// Options to override the data-bomb fetch
  Template := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID
  ,(typeof(Template.FNAME))Health_Provider_Services.Fields.Make_FNAME((SALT25.StrType)Input_FNAME)
  ,(typeof(Template.MNAME))Health_Provider_Services.Fields.Make_MNAME((SALT25.StrType)Input_MNAME)
  ,(typeof(Template.LNAME))Health_Provider_Services.Fields.Make_LNAME((SALT25.StrType)Input_LNAME)
  ,(typeof(Template.SNAME))Health_Provider_Services.Fields.Make_SNAME((SALT25.StrType)Input_SNAME)
  ,(typeof(Template.GENDER))Health_Provider_Services.Fields.Make_GENDER((SALT25.StrType)Input_GENDER)
  ,(typeof(Template.PRIM_RANGE))Health_Provider_Services.Fields.Make_PRIM_RANGE((SALT25.StrType)Input_PRIM_RANGE)
  ,(typeof(Template.PRIM_NAME))Health_Provider_Services.Fields.Make_PRIM_NAME((SALT25.StrType)Input_PRIM_NAME)
  ,(typeof(Template.SEC_RANGE))Health_Provider_Services.Fields.Make_SEC_RANGE((SALT25.StrType)Input_SEC_RANGE)
  ,(typeof(Template.V_CITY_NAME))Health_Provider_Services.Fields.Make_V_CITY_NAME((SALT25.StrType)Input_V_CITY_NAME)
  ,(typeof(Template.ST))Health_Provider_Services.Fields.Make_ST((SALT25.StrType)Input_ST)
  ,(typeof(Template.ZIP))Health_Provider_Services.Fields.Make_ZIP((SALT25.StrType)Input_ZIP)
  ,(typeof(Template.SSN))Health_Provider_Services.Fields.Make_SSN((SALT25.StrType)Input_SSN)
  ,(typeof(Template.DOB))Health_Provider_Services.Fields.Make_DOB((SALT25.StrType)Input_DOB)
  ,(typeof(Template.LIC_STATE))Health_Provider_Services.Fields.Make_LIC_STATE((SALT25.StrType)Input_LIC_STATE)
  ,(typeof(Template.LIC_NBR))Health_Provider_Services.Fields.Make_LIC_NBR((SALT25.StrType)Input_LIC_NBR)
  ,(typeof(Template.TAX_ID))Health_Provider_Services.Fields.Make_TAX_ID((SALT25.StrType)Input_TAX_ID)
  ,(typeof(Template.DEA_NUMBER))Health_Provider_Services.Fields.Make_DEA_NUMBER((SALT25.StrType)Input_DEA_NUMBER)
  ,(typeof(Template.VENDOR_ID))Health_Provider_Services.Fields.Make_VENDOR_ID((SALT25.StrType)Input_VENDOR_ID)
  ,(typeof(Template.NPI_NUMBER))Health_Provider_Services.Fields.Make_NPI_NUMBER((SALT25.StrType)Input_NPI_NUMBER)
  ,(typeof(Template.UPIN))Health_Provider_Services.Fields.Make_UPIN((SALT25.StrType)Input_UPIN)
  ,(typeof(Template.DID))Health_Provider_Services.Fields.Make_DID((SALT25.StrType)Input_DID)
  ,(typeof(Template.BDID))Health_Provider_Services.Fields.Make_BDID((SALT25.StrType)Input_BDID)
  ,(typeof(Template.SRC))Health_Provider_Services.Fields.Make_SRC((SALT25.StrType)Input_SRC)
  ,(typeof(Template.SOURCE_RID))Health_Provider_Services.Fields.Make_SOURCE_RID((SALT25.StrType)Input_SOURCE_RID)
  ,false,false,e_LNPID}],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
  pm := Health_Provider_Services.MEOW_xLNPID(Input_Data); // This module performs regular xLNPID functions
  Options := MODULE(Health_Provider_Services.Externals.FetchParams) // Interface to pass parameters to fetch
    EXPORT SET OF INTEGER2 ToFetch := [];
  END;
  e := Health_Provider_Services.Externals.Fetch(pm.Uid_Results,Options); // Perform data-bomb fetch
  OUTPUT(e,NAMED('DataBombs'));
ENDMACRO;
