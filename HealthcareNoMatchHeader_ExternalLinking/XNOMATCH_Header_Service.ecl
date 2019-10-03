﻿/*--SOAP--
<message name="XNOMATCH_Header_Service">
<part name="SRC" type="xsd:string"/>
<part name="SSN" type="xsd:string"/>
<part name="DOB" type="xsd:string"/>
<part name="LEXID" type="xsd:string"/>
<part name="SUFFIX" type="xsd:string"/>
<part name="FNAME" type="xsd:string"/>
<part name="MNAME" type="xsd:string"/>
<part name="LNAME" type="xsd:string"/>
<part name="GENDER" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="CITY_NAME" type="xsd:string"/>
<part name="ST" type="xsd:string"/>
<part name="ZIP" type="xsd:string"/>
<part name="DT_FIRST_SEEN" type="xsd:string"/>
<part name="DT_LAST_SEEN" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="ADDR1" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="ADDRESS" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="nomatch_id" type="unsignedInt"/>
<part name="RID" type="unsignedInt"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="SortBy" type="xsd:string"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="disableForce" type="xsd:boolean"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Find those entities having records matching the input criteria.
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>DOB:FNAME</p>
<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT XNOMATCH_Header_Service := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader_ExternalLinking;
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(3)));
  SALT311.StrType Input_SRC := '' : STORED('SRC', FORMAT(SEQUENCE(4)));
  SALT311.StrType Input_SSN := '' : STORED('SSN', FORMAT(SEQUENCE(5)));
  SALT311.StrType Input_DOB := '' : STORED('DOB', FORMAT(SEQUENCE(6)));
  SALT311.StrType Input_LEXID := '' : STORED('LEXID', FORMAT(SEQUENCE(7)));
  SALT311.StrType Input_SUFFIX := '' : STORED('SUFFIX', FORMAT(SEQUENCE(8)));
  SALT311.StrType Input_FNAME := '' : STORED('FNAME', FORMAT(SEQUENCE(9)));
  SALT311.StrType Input_MNAME := '' : STORED('MNAME', FORMAT(SEQUENCE(10)));
  SALT311.StrType Input_LNAME := '' : STORED('LNAME', FORMAT(SEQUENCE(11)));
  SALT311.StrType Input_GENDER := '' : STORED('GENDER', FORMAT(SEQUENCE(12)));
  SALT311.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME', FORMAT(SEQUENCE(13)));
  SALT311.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE', FORMAT(SEQUENCE(14)));
  SALT311.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE', FORMAT(SEQUENCE(15)));
  SALT311.StrType Input_CITY_NAME := '' : STORED('CITY_NAME', FORMAT(SEQUENCE(16)));
  SALT311.StrType Input_ST := '' : STORED('ST', FORMAT(SEQUENCE(17)));
  SALT311.StrType Input_ZIP := '' : STORED('ZIP', FORMAT(SEQUENCE(18)));
  SALT311.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN', FORMAT(SEQUENCE(19)));
  SALT311.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN', FORMAT(SEQUENCE(20)));
  SALT311.StrType Input_MAINNAME := '' : STORED('MAINNAME', FORMAT(SEQUENCE(21)));
  SALT311.StrType Input_ADDR1 := '' : STORED('ADDR1', FORMAT(SEQUENCE(22)));
  SALT311.StrType Input_LOCALE := '' : STORED('LOCALE', FORMAT(SEQUENCE(23)));
  SALT311.StrType Input_ADDRESS := '' : STORED('ADDRESS', FORMAT(SEQUENCE(24)));
  SALT311.StrType Input_FULLNAME := '' : STORED('FULLNAME', FORMAT(SEQUENCE(25)));
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord', FORMAT(SEQUENCE(26)));
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly', FORMAT(SEQUENCE(27)));
  SALT311.StrType Input_SortBy := '' : STORED('SortBy', FORMAT(SEQUENCE(28)));
  UNSIGNED e_nomatch_id := 0 : STORED('nomatch_id', FORMAT(SEQUENCE(29)));
  UNSIGNED e_RID := 0 : STORED('RID', FORMAT(SEQUENCE(30)));
  BOOLEAN Input_disableForce := FALSE : STORED('disableForce', FORMAT(SEQUENCE(31)));
 
  Template := DATASET([],HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,Input_disableForce
  ,(TYPEOF(Template.SRC))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_SRC((SALT311.StrType)Input_SRC)
  ,(TYPEOF(Template.SSN))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_SSN((SALT311.StrType)Input_SSN)
  ,(TYPEOF(Template.DOB))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_DOB((SALT311.StrType)Input_DOB)
  ,(TYPEOF(Template.LEXID))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_LEXID((SALT311.StrType)Input_LEXID)
  ,(TYPEOF(Template.SUFFIX))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_SUFFIX((SALT311.StrType)Input_SUFFIX)
  ,(TYPEOF(Template.FNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_FNAME((SALT311.StrType)Input_FNAME)
  ,(TYPEOF(Template.MNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_MNAME((SALT311.StrType)Input_MNAME)
  ,(TYPEOF(Template.LNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_LNAME((SALT311.StrType)Input_LNAME)
  ,(TYPEOF(Template.GENDER))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_GENDER((SALT311.StrType)Input_GENDER)
  ,(TYPEOF(Template.PRIM_NAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_PRIM_NAME((SALT311.StrType)Input_PRIM_NAME)
  ,(TYPEOF(Template.PRIM_RANGE))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_PRIM_RANGE((SALT311.StrType)Input_PRIM_RANGE)
  ,(TYPEOF(Template.SEC_RANGE))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_SEC_RANGE((SALT311.StrType)Input_SEC_RANGE)
  ,(TYPEOF(Template.CITY_NAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_CITY_NAME((SALT311.StrType)Input_CITY_NAME)
  ,(TYPEOF(Template.ST))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_ST((SALT311.StrType)Input_ST)
  ,(TYPEOF(Template.ZIP))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_ZIP((SALT311.StrType)Input_ZIP)
  ,(TYPEOF(Template.DT_FIRST_SEEN))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_DT_FIRST_SEEN((SALT311.StrType)Input_DT_FIRST_SEEN)
  ,(TYPEOF(Template.DT_LAST_SEEN))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_DT_LAST_SEEN((SALT311.StrType)Input_DT_LAST_SEEN)
  ,(TYPEOF(Template.MAINNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_MAINNAME((SALT311.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.ADDR1))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_ADDR1((SALT311.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_LOCALE((SALT311.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRESS))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_ADDRESS((SALT311.StrType)Input_ADDRESS)
  ,(TYPEOF(Template.FULLNAME))HealthcareNoMatchHeader_ExternalLinking.Fields.Make_FULLNAME((SALT311.StrType)Input_FULLNAME)
  ,RecordsOnly,FullMatch,e_RID,e_nomatch_id}],HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts.InputLayout);
 
  pm := HealthcareNoMatchHeader_ExternalLinking.MEOW_XNOMATCH(Input_Data); // This module performs regular xnomatch_id functions
  ds := pm.Data_;
  FieldNumber(SALT311.StrType fn) := CASE(fn,'SRC' => 1,'SSN' => 2,'DOB' => 3,'LEXID' => 4,'SUFFIX' => 5,'FNAME' => 6,'MNAME' => 7,'LNAME' => 8,'GENDER' => 9,'PRIM_NAME' => 10,'PRIM_RANGE' => 11,'SEC_RANGE' => 12,'CITY_NAME' => 13,'ST' => 14,'ZIP' => 15,'DT_FIRST_SEEN' => 16,'DT_LAST_SEEN' => 17,23);
  result := CHOOSE(FieldNumber(Input_SortBy),SORT(ds,-weight,nomatch_id,SRC,RECORD),SORT(ds,-weight,nomatch_id,SSN,RECORD),SORT(ds,-weight,nomatch_id,DOB,RECORD),SORT(ds,-weight,nomatch_id,LEXID,RECORD),SORT(ds,-weight,nomatch_id,SUFFIX,RECORD),SORT(ds,-weight,nomatch_id,FNAME,RECORD),SORT(ds,-weight,nomatch_id,MNAME,RECORD),SORT(ds,-weight,nomatch_id,LNAME,RECORD),SORT(ds,-weight,nomatch_id,GENDER,RECORD),SORT(ds,-weight,nomatch_id,PRIM_NAME,RECORD),SORT(ds,-weight,nomatch_id,PRIM_RANGE,RECORD),SORT(ds,-weight,nomatch_id,SEC_RANGE,RECORD),SORT(ds,-weight,nomatch_id,CITY_NAME,RECORD),SORT(ds,-weight,nomatch_id,ST,RECORD),SORT(ds,-weight,nomatch_id,ZIP,RECORD),SORT(ds,-weight,nomatch_id,DT_FIRST_SEEN,RECORD),SORT(ds,-weight,nomatch_id,DT_LAST_SEEN,RECORD),SORT(ds,-weight,nomatch_id,RECORD));
  OUTPUT(result,NAMED('Header_Data'));
ENDMACRO;
