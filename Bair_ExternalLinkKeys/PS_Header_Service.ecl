/*--SOAP--
<message name="PS_Header_Service">
<part name="NAME_SUFFIX" type="xsd:string"/>
<part name="FNAME" type="xsd:string"/>
<part name="MNAME" type="xsd:string"/>
<part name="LNAME" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="P_CITY_NAME" type="xsd:string"/>
<part name="ST" type="xsd:string"/>
<part name="ZIP" type="xsd:string"/>
<part name="DOB" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="DL_ST" type="xsd:string"/>
<part name="DL" type="xsd:string"/>
<part name="LEXID" type="xsd:string"/>
<part name="POSSIBLE_SSN" type="xsd:string"/>
<part name="CRIME" type="xsd:string"/>
<part name="NAME_TYPE" type="xsd:string"/>
<part name="CLEAN_GENDER" type="xsd:string"/>
<part name="CLASS_CODE" type="xsd:string"/>
<part name="DT_FIRST_SEEN" type="xsd:string"/>
<part name="DT_LAST_SEEN" type="xsd:string"/>
<part name="DATA_PROVIDER_ORI" type="xsd:string"/>
<part name="VIN" type="xsd:string"/>
<part name="PLATE" type="xsd:string"/>
<part name="LATITUDE" type="xsd:string"/>
<part name="LONGITUDE" type="xsd:string"/>
<part name="SEARCH_ADDR1" type="xsd:string"/>
<part name="SEARCH_ADDR2" type="xsd:string"/>
<part name="CLEAN_COMPANY_NAME" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="EID_HASH" type="unsignedInt"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Find those entities having records matching the input criteria.<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>FNAME:LNAME:ST
</p><p>PRIM_RANGE:PRIM_NAME:ZIP
</p><p>PRIM_NAME:P_CITY_NAME:ST
</p><p>DOB:LNAME
</p><p>ZIP:PRIM_RANGE
</p><p>DL:DL_ST
</p><p>PHONE
</p><p>LNAME:FNAME
</p><p>VIN
</p><p>LEXID
</p><p>POSSIBLE_SSN
</p><p>LATITUDE:LONGITUDE
</p><p>PLATE
</p><p>CLEAN_COMPANY_NAME
</p><p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT PS_Header_Service := MACRO
  IMPORT SALT33,Bair_ExternalLinkKeys;
  SALT33.StrType Input_NAME_SUFFIX := '' : STORED('NAME_SUFFIX');
  SALT33.StrType Input_FNAME := '' : STORED('FNAME');
  SALT33.StrType Input_MNAME := '' : STORED('MNAME');
  SALT33.StrType Input_LNAME := '' : STORED('LNAME');
  SALT33.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE');
  SALT33.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME');
  SALT33.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE');
  SALT33.StrType Input_P_CITY_NAME := '' : STORED('P_CITY_NAME');
  SALT33.StrType Input_ST := '' : STORED('ST');
  SALT33.StrType Input_ZIP := '' : STORED('ZIP');
  SALT33.StrType Input_DOB := '' : STORED('DOB');
  SALT33.StrType Input_PHONE := '' : STORED('PHONE');
  SALT33.StrType Input_DL_ST := '' : STORED('DL_ST');
  SALT33.StrType Input_DL := '' : STORED('DL');
  SALT33.StrType Input_LEXID := '' : STORED('LEXID');
  SALT33.StrType Input_POSSIBLE_SSN := '' : STORED('POSSIBLE_SSN');
  SALT33.StrType Input_CRIME := '' : STORED('CRIME');
  SALT33.StrType Input_NAME_TYPE := '' : STORED('NAME_TYPE');
  SALT33.StrType Input_CLEAN_GENDER := '' : STORED('CLEAN_GENDER');
  SALT33.StrType Input_CLASS_CODE := '' : STORED('CLASS_CODE');
  SALT33.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN');
  SALT33.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN');
  SALT33.StrType Input_DATA_PROVIDER_ORI := '' : STORED('DATA_PROVIDER_ORI');
  SALT33.StrType Input_VIN := '' : STORED('VIN');
  SALT33.StrType Input_PLATE := '' : STORED('PLATE');
  SALT33.StrType Input_LATITUDE := '' : STORED('LATITUDE');
  SALT33.StrType Input_LONGITUDE := '' : STORED('LONGITUDE');
  SALT33.StrType Input_SEARCH_ADDR1 := '' : STORED('SEARCH_ADDR1');
  SALT33.StrType Input_SEARCH_ADDR2 := '' : STORED('SEARCH_ADDR2');
  SALT33.StrType Input_CLEAN_COMPANY_NAME := '' : STORED('CLEAN_COMPANY_NAME');
  SALT33.StrType Input_MAINNAME := '' : STORED('MAINNAME');
  SALT33.StrType Input_FULLNAME := '' : STORED('FULLNAME');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold');
  UNSIGNED e_EID_HASH := 0 : STORED('EID_HASH');
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord');
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly');
 
  Template := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.NAME_SUFFIX))Bair_ExternalLinkKeys.Fields.Make_NAME_SUFFIX((SALT33.StrType)Input_NAME_SUFFIX)
  ,(TYPEOF(Template.FNAME))Bair_ExternalLinkKeys.Fields.Make_FNAME((SALT33.StrType)Input_FNAME)
  ,(TYPEOF(Template.MNAME))Bair_ExternalLinkKeys.Fields.Make_MNAME((SALT33.StrType)Input_MNAME)
  ,(TYPEOF(Template.LNAME))Bair_ExternalLinkKeys.Fields.Make_LNAME((SALT33.StrType)Input_LNAME)
  ,(TYPEOF(Template.PRIM_RANGE))Bair_ExternalLinkKeys.Fields.Make_PRIM_RANGE((SALT33.StrType)Input_PRIM_RANGE)
  ,(TYPEOF(Template.PRIM_NAME))Bair_ExternalLinkKeys.Fields.Make_PRIM_NAME((SALT33.StrType)Input_PRIM_NAME)
  ,(TYPEOF(Template.SEC_RANGE))Bair_ExternalLinkKeys.Fields.Make_SEC_RANGE((SALT33.StrType)Input_SEC_RANGE)
  ,(TYPEOF(Template.P_CITY_NAME))Bair_ExternalLinkKeys.Fields.Make_P_CITY_NAME((SALT33.StrType)Input_P_CITY_NAME)
  ,(TYPEOF(Template.ST))Bair_ExternalLinkKeys.Fields.Make_ST((SALT33.StrType)Input_ST)
  ,(TYPEOF(Template.ZIP))Input_ZIP
  ,(TYPEOF(Template.DOB))Bair_ExternalLinkKeys.Fields.Make_DOB((SALT33.StrType)Input_DOB)
  ,(TYPEOF(Template.PHONE))Input_PHONE
  ,(TYPEOF(Template.DL_ST))Bair_ExternalLinkKeys.Fields.Make_DL_ST((SALT33.StrType)Input_DL_ST)
  ,(TYPEOF(Template.DL))Bair_ExternalLinkKeys.Fields.Make_DL((SALT33.StrType)Input_DL)
  ,(TYPEOF(Template.LEXID))Bair_ExternalLinkKeys.Fields.Make_LEXID((SALT33.StrType)Input_LEXID)
  ,(TYPEOF(Template.POSSIBLE_SSN))Bair_ExternalLinkKeys.Fields.Make_POSSIBLE_SSN((SALT33.StrType)Input_POSSIBLE_SSN)
  ,(TYPEOF(Template.CRIME))Bair_ExternalLinkKeys.Fields.Make_CRIME((SALT33.StrType)Input_CRIME)
  ,(TYPEOF(Template.NAME_TYPE))Bair_ExternalLinkKeys.Fields.Make_NAME_TYPE((SALT33.StrType)Input_NAME_TYPE)
  ,(TYPEOF(Template.CLEAN_GENDER))Bair_ExternalLinkKeys.Fields.Make_CLEAN_GENDER((SALT33.StrType)Input_CLEAN_GENDER)
  ,(TYPEOF(Template.CLASS_CODE))Bair_ExternalLinkKeys.Fields.Make_CLASS_CODE((SALT33.StrType)Input_CLASS_CODE)
  ,(TYPEOF(Template.DT_FIRST_SEEN))Bair_ExternalLinkKeys.Fields.Make_DT_FIRST_SEEN((SALT33.StrType)Input_DT_FIRST_SEEN)
  ,(TYPEOF(Template.DT_LAST_SEEN))Bair_ExternalLinkKeys.Fields.Make_DT_LAST_SEEN((SALT33.StrType)Input_DT_LAST_SEEN)
  ,(TYPEOF(Template.DATA_PROVIDER_ORI))Bair_ExternalLinkKeys.Fields.Make_DATA_PROVIDER_ORI((SALT33.StrType)Input_DATA_PROVIDER_ORI)
  ,(TYPEOF(Template.VIN))Bair_ExternalLinkKeys.Fields.Make_VIN((SALT33.StrType)Input_VIN)
  ,(TYPEOF(Template.PLATE))Bair_ExternalLinkKeys.Fields.Make_PLATE((SALT33.StrType)Input_PLATE)
  ,(TYPEOF(Template.LATITUDE))Bair_ExternalLinkKeys.Fields.Make_LATITUDE((SALT33.StrType)Input_LATITUDE)
  ,(TYPEOF(Template.LONGITUDE))Bair_ExternalLinkKeys.Fields.Make_LONGITUDE((SALT33.StrType)Input_LONGITUDE)
  ,(TYPEOF(Template.SEARCH_ADDR1))Bair_ExternalLinkKeys.Fields.Make_SEARCH_ADDR1((SALT33.StrType)Input_SEARCH_ADDR1)
  ,(TYPEOF(Template.SEARCH_ADDR2))Bair_ExternalLinkKeys.Fields.Make_SEARCH_ADDR2((SALT33.StrType)Input_SEARCH_ADDR2)
  ,(TYPEOF(Template.CLEAN_COMPANY_NAME))Bair_ExternalLinkKeys.Fields.Make_CLEAN_COMPANY_NAME((SALT33.StrType)Input_CLEAN_COMPANY_NAME)
  ,(TYPEOF(Template.MAINNAME))Bair_ExternalLinkKeys.Fields.Make_MAINNAME((SALT33.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.FULLNAME))Bair_ExternalLinkKeys.Fields.Make_FULLNAME((SALT33.StrType)Input_FULLNAME)
  ,RecordsOnly,FullMatch,e_EID_HASH}],Bair_ExternalLinkKeys.Process_PS_Layouts.InputLayout);
 
  pm := Bair_ExternalLinkKeys.MEOW_PS(Input_Data); // This module performs regular xEID_HASH functions
  OUTPUT(pm.Data_,NAMED('Header_Data'));
ENDMACRO;
