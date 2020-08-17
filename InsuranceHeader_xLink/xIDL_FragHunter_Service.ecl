/*--SOAP--
<message name="xIDL_FragHunter_Service">
<part name="SNAME" type="xsd:string"/>
<part name="FNAME" type="xsd:string"/>
<part name="MNAME" type="xsd:string"/>
<part name="LNAME" type="xsd:string"/>
<part name="DERIVED_GENDER" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="CITY" type="xsd:string"/>
<part name="ST" type="xsd:string"/>
<part name="ZIP_cases" type="tns:XmlDataSet"/>
<part name="SSN5" type="xsd:string"/>
<part name="SSN4" type="xsd:string"/>
<part name="DOB" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="DL_STATE" type="xsd:string"/>
<part name="DL_NBR" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="SOURCE_RID" type="xsd:string"/>
<part name="DT_FIRST_SEEN" type="xsd:string"/>
<part name="DT_LAST_SEEN" type="xsd:string"/>
<part name="DT_EFFECTIVE_FIRST" type="xsd:string"/>
<part name="DT_EFFECTIVE_LAST" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="ADDR1" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="ADDRESS" type="xsd:string"/>
<part name="fname2" type="xsd:string"/>
<part name="lname2" type="xsd:string"/>
<part name="VIN" type="xsd:string"/>
<part name="DID" type="unsignedInt"/>
<part name="RID" type="unsignedInt"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="disableForce" type="xsd:boolean"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Return all available data for DID with similar fields to the one provided</p>
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>FNAME:LNAME:ST</p>
<p>PRIM_RANGE:PRIM_NAME:ZIP</p>
<p>SSN5:SSN4</p>
<p>SSN4:FNAME:LNAME(NOFUZZY)</p>
<p>DOB:LNAME</p>
<p>DOB:FNAME</p>
<p>ZIP:PRIM_RANGE</p>
<p>SRC:SOURCE_RID</p>
<p>DL_NBR:DL_STATE</p>
<p>PHONE</p>
<p>LNAME:FNAME:ZIP</p>
<p>fname2:lname2</p>
<p>VIN</p>
*/
EXPORT xIDL_FragHunter_Service := MACRO
  IMPORT SALT311,InsuranceHeader_xLink;
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(3)));
  SALT311.StrType Input_SNAME := '' : STORED('SNAME', FORMAT(SEQUENCE(4)));
  SALT311.StrType Input_FNAME := '' : STORED('FNAME', FORMAT(SEQUENCE(5)));
  SALT311.StrType Input_MNAME := '' : STORED('MNAME', FORMAT(SEQUENCE(6)));
  SALT311.StrType Input_LNAME := '' : STORED('LNAME', FORMAT(SEQUENCE(7)));
  SALT311.StrType Input_DERIVED_GENDER := '' : STORED('DERIVED_GENDER', FORMAT(SEQUENCE(8)));
  SALT311.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE', FORMAT(SEQUENCE(9)));
  SALT311.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME', FORMAT(SEQUENCE(10)));
  SALT311.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE', FORMAT(SEQUENCE(11)));
  SALT311.StrType Input_CITY := '' : STORED('CITY', FORMAT(SEQUENCE(12)));
  SALT311.StrType Input_ST := '' : STORED('ST', FORMAT(SEQUENCE(13)));
 
  DATASET(InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases) Input_ZIP := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases)  : STORED('ZIP_cases', FORMAT(SEQUENCE(14)));
  SALT311.StrType Input_SSN5 := '' : STORED('SSN5', FORMAT(SEQUENCE(15)));
  SALT311.StrType Input_SSN4 := '' : STORED('SSN4', FORMAT(SEQUENCE(16)));
  SALT311.StrType Input_DOB := '' : STORED('DOB', FORMAT(SEQUENCE(17)));
  SALT311.StrType Input_PHONE := '' : STORED('PHONE', FORMAT(SEQUENCE(18)));
  SALT311.StrType Input_DL_STATE := '' : STORED('DL_STATE', FORMAT(SEQUENCE(19)));
  SALT311.StrType Input_DL_NBR := '' : STORED('DL_NBR', FORMAT(SEQUENCE(20)));
  SALT311.StrType Input_SRC := '' : STORED('SRC', FORMAT(SEQUENCE(21)));
  SALT311.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID', FORMAT(SEQUENCE(22)));
  SALT311.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN', FORMAT(SEQUENCE(23)));
  SALT311.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN', FORMAT(SEQUENCE(24)));
  SALT311.StrType Input_DT_EFFECTIVE_FIRST := '' : STORED('DT_EFFECTIVE_FIRST', FORMAT(SEQUENCE(25)));
  SALT311.StrType Input_DT_EFFECTIVE_LAST := '' : STORED('DT_EFFECTIVE_LAST', FORMAT(SEQUENCE(26)));
  SALT311.StrType Input_MAINNAME := '' : STORED('MAINNAME', FORMAT(SEQUENCE(27)));
  SALT311.StrType Input_FULLNAME := '' : STORED('FULLNAME', FORMAT(SEQUENCE(28)));
  SALT311.StrType Input_ADDR1 := '' : STORED('ADDR1', FORMAT(SEQUENCE(29)));
  SALT311.StrType Input_LOCALE := '' : STORED('LOCALE', FORMAT(SEQUENCE(30)));
  SALT311.StrType Input_ADDRESS := '' : STORED('ADDRESS', FORMAT(SEQUENCE(31)));
  SALT311.StrType Input_fname2 := '' : STORED('fname2', FORMAT(SEQUENCE(32)));
  SALT311.StrType Input_lname2 := '' : STORED('lname2', FORMAT(SEQUENCE(33)));
  SALT311.StrType Input_VIN := '' : STORED('VIN', FORMAT(SEQUENCE(34)));
  UNSIGNED e_DID := 0 : STORED('DID', FORMAT(SEQUENCE(35)));
  UNSIGNED e_RID := 0 : STORED('RID', FORMAT(SEQUENCE(36)));
  BOOLEAN Input_disableForce := FALSE : STORED('disableForce', FORMAT(SEQUENCE(37)));
 
  Template := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,Input_disableForce
  ,(TYPEOF(Template.SNAME))InsuranceHeader_xLink.Fields.Make_SNAME((SALT311.StrType)Input_SNAME)
  ,(TYPEOF(Template.FNAME))InsuranceHeader_xLink.Fields.Make_FNAME((SALT311.StrType)Input_FNAME)
  ,(TYPEOF(Template.MNAME))InsuranceHeader_xLink.Fields.Make_MNAME((SALT311.StrType)Input_MNAME)
  ,(TYPEOF(Template.LNAME))InsuranceHeader_xLink.Fields.Make_LNAME((SALT311.StrType)Input_LNAME)
  ,(TYPEOF(Template.DERIVED_GENDER))InsuranceHeader_xLink.Fields.Make_DERIVED_GENDER((SALT311.StrType)Input_DERIVED_GENDER)
  ,(TYPEOF(Template.PRIM_RANGE))InsuranceHeader_xLink.Fields.Make_PRIM_RANGE((SALT311.StrType)Input_PRIM_RANGE)
  ,(TYPEOF(Template.PRIM_NAME))InsuranceHeader_xLink.Fields.Make_PRIM_NAME((SALT311.StrType)Input_PRIM_NAME)
  ,(TYPEOF(Template.SEC_RANGE))InsuranceHeader_xLink.Fields.Make_SEC_RANGE((SALT311.StrType)Input_SEC_RANGE)
  ,(TYPEOF(Template.CITY))InsuranceHeader_xLink.Fields.Make_CITY((SALT311.StrType)Input_CITY)
  ,(TYPEOF(Template.ST))InsuranceHeader_xLink.Fields.Make_ST((SALT311.StrType)Input_ST)
  ,Input_ZIP
  ,(TYPEOF(Template.SSN5))InsuranceHeader_xLink.Fields.Make_SSN5((SALT311.StrType)Input_SSN5)
  ,(TYPEOF(Template.SSN4))InsuranceHeader_xLink.Fields.Make_SSN4((SALT311.StrType)Input_SSN4)
  ,(TYPEOF(Template.DOB))InsuranceHeader_xLink.Fields.Make_DOB((SALT311.StrType)Input_DOB)
  ,(TYPEOF(Template.PHONE))Input_PHONE
  ,(TYPEOF(Template.DL_STATE))InsuranceHeader_xLink.Fields.Make_DL_STATE((SALT311.StrType)Input_DL_STATE)
  ,(TYPEOF(Template.DL_NBR))InsuranceHeader_xLink.Fields.Make_DL_NBR((SALT311.StrType)Input_DL_NBR)
  ,(TYPEOF(Template.SRC))InsuranceHeader_xLink.Fields.Make_SRC((SALT311.StrType)Input_SRC)
  ,(TYPEOF(Template.SOURCE_RID))InsuranceHeader_xLink.Fields.Make_SOURCE_RID((SALT311.StrType)Input_SOURCE_RID)
  ,(TYPEOF(Template.DT_FIRST_SEEN))InsuranceHeader_xLink.Fields.Make_DT_FIRST_SEEN((SALT311.StrType)Input_DT_FIRST_SEEN)
  ,(TYPEOF(Template.DT_LAST_SEEN))InsuranceHeader_xLink.Fields.Make_DT_LAST_SEEN((SALT311.StrType)Input_DT_LAST_SEEN)
  ,(TYPEOF(Template.DT_EFFECTIVE_FIRST))InsuranceHeader_xLink.Fields.Make_DT_EFFECTIVE_FIRST((SALT311.StrType)Input_DT_EFFECTIVE_FIRST)
  ,(TYPEOF(Template.DT_EFFECTIVE_LAST))InsuranceHeader_xLink.Fields.Make_DT_EFFECTIVE_LAST((SALT311.StrType)Input_DT_EFFECTIVE_LAST)
  ,(TYPEOF(Template.MAINNAME))InsuranceHeader_xLink.Fields.Make_MAINNAME((SALT311.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.FULLNAME))InsuranceHeader_xLink.Fields.Make_FULLNAME((SALT311.StrType)Input_FULLNAME)
  ,(TYPEOF(Template.ADDR1))InsuranceHeader_xLink.Fields.Make_ADDR1((SALT311.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))InsuranceHeader_xLink.Fields.Make_LOCALE((SALT311.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRESS))InsuranceHeader_xLink.Fields.Make_ADDRESS((SALT311.StrType)Input_ADDRESS)
  ,(TYPEOF(Template.fname2))Input_fname2
  ,(TYPEOF(Template.lname2))Input_lname2
  ,(TYPEOF(Template.VIN))Input_VIN
  ,false,false,e_RID,e_DID}],InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout);
 
  pm := InsuranceHeader_xLink.MEOW_xIDL(Input_Data); // This module performs regular xDID functions
  ds := pm.DataToSearch;
  fids := SET(pm.Uid_Results,DID);
  odm := InsuranceHeader_xLink.MEOW_xIDL(ds, true, fids);
  OUTPUT(odm.Raw_Results,NAMED('PossibleFragments'));
  OUTPUT(odm.Raw_Data,NAMED('FragmentData'));
  OUTPUT(pm.Raw_Data,NAMED('OriginalData'));
ENDMACRO;
