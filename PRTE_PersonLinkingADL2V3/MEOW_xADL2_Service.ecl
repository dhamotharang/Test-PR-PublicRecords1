/*--SOAP--
<message name="MEOW_xADL2_Service">
<part name="NAME_SUFFIX" type="xsd:string"/>
<part name="FNAME" type="xsd:string"/>
<part name="MNAME" type="xsd:string"/>
<part name="LNAME" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="CITY" type="xsd:string"/>
<part name="STATE" type="xsd:string"/>
<part name="ZIP" type="xsd:string"/>
<part name="ZIP4" type="xsd:string"/>
<part name="COUNTY" type="xsd:string"/>
<part name="SSN5" type="xsd:string"/>
<part name="SSN4" type="xsd:string"/>
<part name="DOB" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="ADDR1" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="ADDRS" type="xsd:string"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Attempt to resolve or find DIDs.<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>FNAME:LNAME:STATE
</p><p>LNAME:FNAME:ZIP
</p><p>PRIM_RANGE:PRIM_NAME:ZIP
</p><p>SSN5:SSN4
</p><p>SSN4:FNAME
</p><p>DOB:LNAME
</p><p>PHONE
</p><p>ZIP:PRIM_RANGE
</p><p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
export MEOW_xADL2_Service := MACRO
string Input_NAME_SUFFIX := '' : stored('NAME_SUFFIX');
string Input_FNAME := '' : stored('FNAME');
string Input_MNAME := '' : stored('MNAME');
string Input_LNAME := '' : stored('LNAME');
string Input_PRIM_RANGE := '' : stored('PRIM_RANGE');
string Input_PRIM_NAME := '' : stored('PRIM_NAME');
string Input_SEC_RANGE := '' : stored('SEC_RANGE');
string Input_CITY := '' : stored('CITY');
string Input_STATE := '' : stored('STATE');
string Input_ZIP := '' : stored('ZIP');
string Input_ZIP4 := '' : stored('ZIP4');
string Input_COUNTY := '' : stored('COUNTY');
string Input_SSN5 := '' : stored('SSN5');
string Input_SSN4 := '' : stored('SSN4');
string Input_DOB := '' : stored('DOB');
string Input_PHONE := '' : stored('PHONE');
string Input_MAINNAME := '' : stored('MAINNAME');
string Input_FULLNAME := '' : stored('FULLNAME');
string Input_ADDR1 := '' : stored('ADDR1');
string Input_LOCALE := '' : stored('LOCALE');
string Input_ADDRS := '' : stored('ADDRS');
unsigned Input_UniqueID := 0 : stored('UniqueID');
unsigned e_DID := 0 : stored('DID');
boolean FullMatch := false : stored('MatchAllInOneRecord');
boolean RecordsOnly := false: stored('RecordsOnly');
Template := dataset([],PRTE_PersonLinkingADL2V3.Process_xADL2_Layouts.InputLayout);
Input_Data := dataset([{(typeof(Template.UniqueID))Input_UniqueID
  ,(typeof(Template.NAME_SUFFIX))Input_NAME_SUFFIX
  ,(typeof(Template.FNAME))Input_FNAME
  ,(typeof(Template.MNAME))Input_MNAME
  ,(typeof(Template.LNAME))Input_LNAME
  ,(typeof(Template.PRIM_RANGE))Input_PRIM_RANGE
  ,(typeof(Template.PRIM_NAME))Input_PRIM_NAME
  ,(typeof(Template.SEC_RANGE))Input_SEC_RANGE
  ,IF ( PRTE_PersonLinkingADL2V3.Fields.Invalid_CITY((typeof(Template.CITY))Input_CITY)=0,(typeof(Template.CITY))Input_CITY,(typeof(Template.CITY))'')
  ,(typeof(Template.STATE))Input_STATE
  ,(typeof(Template.ZIP))Input_ZIP
  ,(typeof(Template.ZIP4))Input_ZIP4
  ,(typeof(Template.COUNTY))Input_COUNTY
  ,(typeof(Template.SSN5))Input_SSN5
  ,(typeof(Template.SSN4))Input_SSN4
  ,(typeof(Template.DOB))Input_DOB
  ,(typeof(Template.PHONE))Input_PHONE
  ,(typeof(Template.MAINNAME))Input_MAINNAME
  ,(typeof(Template.FULLNAME))Input_FULLNAME
  ,(typeof(Template.ADDR1))Input_ADDR1
  ,(typeof(Template.LOCALE))Input_LOCALE
  ,(typeof(Template.ADDRS))Input_ADDRS
,false,false,0}],PRTE_PersonLinkingADL2V3.Process_xADL2_Layouts.InputLayout);
results := PRTE_PersonLinkingADL2V3.MEOW_xADL2(Input_Data).Raw_Results;
output(results);
endmacro;

