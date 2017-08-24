﻿/*--SOAP--
<message name="PS_FragHunter_Service">
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
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="disableForce" type="xsd:boolean"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Return all available data for EID_HASH with similar fields to the one provided</p>
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>FNAME:LNAME:ST</p>
<p>PRIM_RANGE:PRIM_NAME:ZIP</p>
<p>DOB:LNAME</p>
<p>ZIP:PRIM_RANGE</p>
<p>DL:DL_ST</p>
<p>PHONE</p>
<p>LNAME:FNAME</p>
<p>VIN</p>
<p>LEXID</p>
<p>POSSIBLE_SSN</p>
<p>LATITUDE:LONGITUDE</p>
<p>PLATE</p>
<p>CLEAN_COMPANY_NAME</p>
*/
EXPORT PS_FragHunter_Service := MACRO
  IMPORT SALT37,Bair_ExternalLinkKeys_V2;
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(3)));
  SALT37.StrType Input_NAME_SUFFIX := '' : STORED('NAME_SUFFIX', FORMAT(SEQUENCE(4)));
  SALT37.StrType Input_FNAME := '' : STORED('FNAME', FORMAT(SEQUENCE(5)));
  SALT37.StrType Input_MNAME := '' : STORED('MNAME', FORMAT(SEQUENCE(6)));
  SALT37.StrType Input_LNAME := '' : STORED('LNAME', FORMAT(SEQUENCE(7)));
  SALT37.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE', FORMAT(SEQUENCE(8)));
  SALT37.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME', FORMAT(SEQUENCE(9)));
  SALT37.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE', FORMAT(SEQUENCE(10)));
  SALT37.StrType Input_P_CITY_NAME := '' : STORED('P_CITY_NAME', FORMAT(SEQUENCE(11)));
  SALT37.StrType Input_ST := '' : STORED('ST', FORMAT(SEQUENCE(12)));
  SALT37.StrType Input_ZIP := '' : STORED('ZIP', FORMAT(SEQUENCE(13)));
  SALT37.StrType Input_DOB := '' : STORED('DOB', FORMAT(SEQUENCE(14)));
  SALT37.StrType Input_PHONE := '' : STORED('PHONE', FORMAT(SEQUENCE(15)));
  SALT37.StrType Input_DL_ST := '' : STORED('DL_ST', FORMAT(SEQUENCE(16)));
  SALT37.StrType Input_DL := '' : STORED('DL', FORMAT(SEQUENCE(17)));
  SALT37.StrType Input_LEXID := '' : STORED('LEXID', FORMAT(SEQUENCE(18)));
  SALT37.StrType Input_POSSIBLE_SSN := '' : STORED('POSSIBLE_SSN', FORMAT(SEQUENCE(19)));
  SALT37.StrType Input_CRIME := '' : STORED('CRIME', FORMAT(SEQUENCE(20)));
  SALT37.StrType Input_NAME_TYPE := '' : STORED('NAME_TYPE', FORMAT(SEQUENCE(21)));
  SALT37.StrType Input_CLEAN_GENDER := '' : STORED('CLEAN_GENDER', FORMAT(SEQUENCE(22)));
  SALT37.StrType Input_CLASS_CODE := '' : STORED('CLASS_CODE', FORMAT(SEQUENCE(23)));
  SALT37.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN', FORMAT(SEQUENCE(24)));
  SALT37.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN', FORMAT(SEQUENCE(25)));
  SALT37.StrType Input_DATA_PROVIDER_ORI := '' : STORED('DATA_PROVIDER_ORI', FORMAT(SEQUENCE(26)));
  SALT37.StrType Input_VIN := '' : STORED('VIN', FORMAT(SEQUENCE(27)));
  SALT37.StrType Input_PLATE := '' : STORED('PLATE', FORMAT(SEQUENCE(28)));
  SALT37.StrType Input_LATITUDE := '' : STORED('LATITUDE', FORMAT(SEQUENCE(29)));
  SALT37.StrType Input_LONGITUDE := '' : STORED('LONGITUDE', FORMAT(SEQUENCE(30)));
  SALT37.StrType Input_SEARCH_ADDR1 := '' : STORED('SEARCH_ADDR1', FORMAT(SEQUENCE(31)));
  SALT37.StrType Input_SEARCH_ADDR2 := '' : STORED('SEARCH_ADDR2', FORMAT(SEQUENCE(32)));
  SALT37.StrType Input_CLEAN_COMPANY_NAME := '' : STORED('CLEAN_COMPANY_NAME', FORMAT(SEQUENCE(33)));
  SALT37.StrType Input_MAINNAME := '' : STORED('MAINNAME', FORMAT(SEQUENCE(34)));
  SALT37.StrType Input_FULLNAME := '' : STORED('FULLNAME', FORMAT(SEQUENCE(35)));
  UNSIGNED e_EID_HASH := 0 : STORED('EID_HASH', FORMAT(SEQUENCE(36)));
  BOOLEAN Input_disableForce := FALSE : STORED('disableForce', FORMAT(SEQUENCE(37)));
 
  Template := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,Input_disableForce
  ,(TYPEOF(Template.NAME_SUFFIX))Bair_ExternalLinkKeys_V2.Fields.Make_NAME_SUFFIX((SALT37.StrType)Input_NAME_SUFFIX)
  ,(TYPEOF(Template.FNAME))Bair_ExternalLinkKeys_V2.Fields.Make_FNAME((SALT37.StrType)Input_FNAME)
  ,(TYPEOF(Template.MNAME))Bair_ExternalLinkKeys_V2.Fields.Make_MNAME((SALT37.StrType)Input_MNAME)
  ,(TYPEOF(Template.LNAME))Bair_ExternalLinkKeys_V2.Fields.Make_LNAME((SALT37.StrType)Input_LNAME)
  ,(TYPEOF(Template.PRIM_RANGE))Bair_ExternalLinkKeys_V2.Fields.Make_PRIM_RANGE((SALT37.StrType)Input_PRIM_RANGE)
  ,(TYPEOF(Template.PRIM_NAME))Bair_ExternalLinkKeys_V2.Fields.Make_PRIM_NAME((SALT37.StrType)Input_PRIM_NAME)
  ,(TYPEOF(Template.SEC_RANGE))Bair_ExternalLinkKeys_V2.Fields.Make_SEC_RANGE((SALT37.StrType)Input_SEC_RANGE)
  ,(TYPEOF(Template.P_CITY_NAME))Bair_ExternalLinkKeys_V2.Fields.Make_P_CITY_NAME((SALT37.StrType)Input_P_CITY_NAME)
  ,(TYPEOF(Template.ST))Bair_ExternalLinkKeys_V2.Fields.Make_ST((SALT37.StrType)Input_ST)
  ,(TYPEOF(Template.ZIP))Input_ZIP
  ,(TYPEOF(Template.DOB))Bair_ExternalLinkKeys_V2.Fields.Make_DOB((SALT37.StrType)Input_DOB)
  ,(TYPEOF(Template.PHONE))Input_PHONE
  ,(TYPEOF(Template.DL_ST))Bair_ExternalLinkKeys_V2.Fields.Make_DL_ST((SALT37.StrType)Input_DL_ST)
  ,(TYPEOF(Template.DL))Bair_ExternalLinkKeys_V2.Fields.Make_DL((SALT37.StrType)Input_DL)
  ,(TYPEOF(Template.LEXID))Bair_ExternalLinkKeys_V2.Fields.Make_LEXID((SALT37.StrType)Input_LEXID)
  ,(TYPEOF(Template.POSSIBLE_SSN))Bair_ExternalLinkKeys_V2.Fields.Make_POSSIBLE_SSN((SALT37.StrType)Input_POSSIBLE_SSN)
  ,(TYPEOF(Template.CRIME))Bair_ExternalLinkKeys_V2.Fields.Make_CRIME((SALT37.StrType)Input_CRIME)
  ,(TYPEOF(Template.NAME_TYPE))Bair_ExternalLinkKeys_V2.Fields.Make_NAME_TYPE((SALT37.StrType)Input_NAME_TYPE)
  ,(TYPEOF(Template.CLEAN_GENDER))Bair_ExternalLinkKeys_V2.Fields.Make_CLEAN_GENDER((SALT37.StrType)Input_CLEAN_GENDER)
  ,(TYPEOF(Template.CLASS_CODE))Bair_ExternalLinkKeys_V2.Fields.Make_CLASS_CODE((SALT37.StrType)Input_CLASS_CODE)
  ,(TYPEOF(Template.DT_FIRST_SEEN))Bair_ExternalLinkKeys_V2.Fields.Make_DT_FIRST_SEEN((SALT37.StrType)Input_DT_FIRST_SEEN)
  ,(TYPEOF(Template.DT_LAST_SEEN))Bair_ExternalLinkKeys_V2.Fields.Make_DT_LAST_SEEN((SALT37.StrType)Input_DT_LAST_SEEN)
  ,(TYPEOF(Template.DATA_PROVIDER_ORI))Bair_ExternalLinkKeys_V2.Fields.Make_DATA_PROVIDER_ORI((SALT37.StrType)Input_DATA_PROVIDER_ORI)
  ,(TYPEOF(Template.VIN))Bair_ExternalLinkKeys_V2.Fields.Make_VIN((SALT37.StrType)Input_VIN)
  ,(TYPEOF(Template.PLATE))Bair_ExternalLinkKeys_V2.Fields.Make_PLATE((SALT37.StrType)Input_PLATE)
  ,(TYPEOF(Template.LATITUDE))Bair_ExternalLinkKeys_V2.Fields.Make_LATITUDE((SALT37.StrType)Input_LATITUDE)
  ,(TYPEOF(Template.LONGITUDE))Bair_ExternalLinkKeys_V2.Fields.Make_LONGITUDE((SALT37.StrType)Input_LONGITUDE)
  ,(TYPEOF(Template.SEARCH_ADDR1))Bair_ExternalLinkKeys_V2.Fields.Make_SEARCH_ADDR1((SALT37.StrType)Input_SEARCH_ADDR1)
  ,(TYPEOF(Template.SEARCH_ADDR2))Bair_ExternalLinkKeys_V2.Fields.Make_SEARCH_ADDR2((SALT37.StrType)Input_SEARCH_ADDR2)
  ,(TYPEOF(Template.CLEAN_COMPANY_NAME))Bair_ExternalLinkKeys_V2.Fields.Make_CLEAN_COMPANY_NAME((SALT37.StrType)Input_CLEAN_COMPANY_NAME)
  ,(TYPEOF(Template.MAINNAME))Bair_ExternalLinkKeys_V2.Fields.Make_MAINNAME((SALT37.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.FULLNAME))Bair_ExternalLinkKeys_V2.Fields.Make_FULLNAME((SALT37.StrType)Input_FULLNAME)
  ,false,false,e_EID_HASH}],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.InputLayout);
 
  pm := Bair_ExternalLinkKeys_V2.MEOW_PS(Input_Data); // This module performs regular xEID_HASH functions
  ds := pm.DataToSearch;
  fids := SET(pm.Uid_Results,EID_HASH);
  odm := Bair_ExternalLinkKeys_V2.MEOW_PS(ds,true,fids);
  OUTPUT(odm.Raw_Results,NAMED('PossibleFragments'));
  OUTPUT(odm.Raw_Data,NAMED('FragmentData'));
  OUTPUT(pm.Raw_Data,NAMED('OriginalData'));
ENDMACRO;
