/*--SOAP--
<message name="xIDL_Header_Service">
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
<part name="ZIP" type="xsd:string"/>
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
<part name="DID" type="unsignedInt"/>
<part name="RID" type="unsignedInt"/>
<part name="SortBy" type="xsd:string"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="disableForce" type="xsd:boolean"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--RESULT-- InsuranceHeader_xLink.Format_Header_Service */ 
EXPORT xIDL_Header_Service := MACRO
  #WEBSERVICE(FIELDS(
	'SNAME', 'FNAME', 'MNAME', 'LNAME', 'NAME', 'DERIVED_GENDER',
	'ADDRESS1', 'ADDRESS2', 'PRIM_RANGE', 'PRIM_NAME', 'SEC_RANGE', 'CITY',
	'ST', 'ZIP', 'SSN', 'DOB', 'PHONE', 'DL_STATE', 'DL_NBR', 'fname2', 'lname2', 'RID', 'DID', 'SortBy',
	'disableForce', 'MatchAllInOneRecord', 'RecordsOnly', 'MaxIds', 'LeadThreshold', 'UniqueID'
	),
	HELP('<p>NAME:full name to be cleaned (for ex: John A Smith)</p>' +
	'<p>DOB format: YYYYMMDD (for ex: 19710101)</p>'+
	'<p>ADDRESS1:first part of address to be cleaned (for ex: 123 Main Street)</p>'+
	'<p>ADDRESS2:second part of address to be cleaned (for ex: Miami, FL, 12345)</p>'+
	'<p>SortBy:RID|Source|FirstSeenDate|LastSeenDate|ADRIndicator|DLNIndicator|DOBIndicator|SSNIndicator|LastName|City</p>' + 
	'<p>Minimum Requirements:<ul style="list-style-type:none">'+
	'<li>FNAME,LNAME,ST</li><li>PRIM_RANGE,PRIM_NAME,ZIP</li><li>SSN</li><li>SSN4,FNAME,LNAME</li>'+ 
	'<li>DOB,LNAME</li><li>ZIP,PRIM_RANGE</li><li>DL_NBR,DL_STATE</li><li>PHONE</li><li>LNAME,FNAME,ZIP</li>'+
	'<li>RID<br/><li>SRC,SOURCE_RID,FNAME,DOB,CITY,DERIVED_GENDER,SNAME</li></ul>'),
	DESCRIPTION('<p>SALT V3.7</p>' + 
	'<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>'));/*FIELDS HACK*/	
  IMPORT SALT37,InsuranceHeader_xLink;
	
	STRING Input_NAME := '' : STORED('NAME');
	clean_n := address.CleanPersonFML73(Input_NAME);
	clean_n_parsed := Address.CleanNameFields(clean_n);
	nameLine := Input_name != '';
	STRING sSname := '' : STORED('SNAME');
	SALT37.StrType Input_SNAME := IF(nameLine, clean_n_parsed.name_suffix, sSname);
	STRING sFname := '' : STORED('FNAME');
	SALT37.StrType Input_FNAME := IF(nameLine, clean_n_parsed.fname, sFname);
	STRING sMname := '' : STORED('MNAME');
	SALT37.StrType Input_MNAME := IF(nameLine, clean_n_parsed.mname, sMname);
	STRING sLname := '' : STORED('LNAME');
	SALT37.StrType Input_LNAME := IF(nameLine, clean_n_parsed.lname, sLname); /*CLEAN NAME HACK*/
	SALT37.StrType Input_DERIVED_GENDER := '' : STORED('DERIVED_GENDER');
	
	STRING addressLine1 := '' : STORED('ADDRESS1');
	STRING addressLine2 := '' : STORED('ADDRESS2');
	CleanedAddress		:= Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;
	addressLine 			:= addressLine1 != '' and addressLine2 != '';
	STRING sPrim_range := '' : STORED('PRIM_RANGE');
	SALT37.StrType Input_PRIM_RANGE := IF(addressLine,  CleanedAddress.prim_range, sPrim_range);
	STRING sPrim_name :=  '' : STORED('PRIM_NAME');
	SALT37.StrType Input_PRIM_NAME := IF(addressLine,  CleanedAddress.prim_name, sPrim_name);
	STRING sSec_range :=  '' : STORED('SEC_RANGE');
	SALT37.StrType Input_SEC_RANGE := IF(addressLine,  CleanedAddress.sec_range, sSec_range);
	STRING sCity :=  '' : STORED('CITY');
	SALT37.StrType Input_CITY := IF(addressLine,  CleanedAddress.v_city_name, sCity);
	STRING sSt :=  '' : STORED('ST');
	SALT37.StrType Input_ST := IF(addressLine,  CleanedAddress.st, sSt);
	STRING sZip :=  '' : STORED('ZIP');
	SALT37.StrType Input_ZIP := IF(addressLine,  CleanedAddress.zip, sZip); /*CLEAN ADDRESS HACK*/
	SALT37.StrType Input_SSN := '' : STORED('SSN');
	INTEGER ssnInt := (INTEGER)Input_SSN;
	SALT37.StrType Input_SSN5 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN5, '');/* HACK SSN5 */
  SALT37.StrType Input_SSN4 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN4, ''); /* HACK SSN4 */
	SALT37.StrType Input_DOB := '' : STORED('DOB');
  SALT37.StrType Input_PHONE := '' : STORED('PHONE');
  SALT37.StrType Input_DL_STATE := '' : STORED('DL_STATE');
  SALT37.StrType Input_DL_NBR := '' : STORED('DL_NBR');
  SALT37.StrType Input_SRC := '' : STORED('SRC');
  SALT37.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID');	
	UNSIGNED e_RID := 0 : STORED('RID');
	SALT37.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN');
  SALT37.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN');
  SALT37.StrType Input_DT_EFFECTIVE_FIRST := '' : STORED('DT_EFFECTIVE_FIRST');
  SALT37.StrType Input_DT_EFFECTIVE_LAST := '' : STORED('DT_EFFECTIVE_LAST');
  SALT37.StrType Input_MAINNAME := '' : STORED('MAINNAME');
  SALT37.StrType Input_FULLNAME := '' : STORED('FULLNAME');
  SALT37.StrType Input_ADDR1 := '' : STORED('ADDR1');
  SALT37.StrType Input_LOCALE := '' : STORED('LOCALE');
  SALT37.StrType Input_ADDRESS := '' : STORED('ADDRESS');
  SALT37.StrType Input_fname2 := '' : STORED('fname2');
  SALT37.StrType Input_lname2 := '' : STORED('lname2');	
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold');
  UNSIGNED e_DID := 0 : STORED('DID');  
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord');
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly');
  SALT37.StrType Input_SortBy := '' : STORED('SortBy');  
  BOOLEAN Input_disableForce := InsuranceHeader_xLink.Config.DOB_NotUseForce : STORED('disableForce');
 
  Template := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout);
	ToUpperCase(STRING aString) := STD.Str.ToUpperCase(aString);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,Input_disableForce
  ,(TYPEOF(Template.SNAME))InsuranceHeader_xLink.Fields.Make_SNAME(ToUpperCase((SALT37.StrType)Input_SNAME))
  ,(TYPEOF(Template.FNAME))InsuranceHeader_xLink.Fields.Make_FNAME(ToUpperCase((SALT37.StrType)Input_FNAME))
  ,(TYPEOF(Template.MNAME))InsuranceHeader_xLink.Fields.Make_MNAME(ToUpperCase((SALT37.StrType)Input_MNAME))
  ,(TYPEOF(Template.LNAME))InsuranceHeader_xLink.Fields.Make_LNAME(ToUpperCase((SALT37.StrType)Input_LNAME))
  ,(TYPEOF(Template.DERIVED_GENDER))InsuranceHeader_xLink.Fields.Make_DERIVED_GENDER(ToUpperCase((SALT37.StrType)Input_DERIVED_GENDER))
  ,(TYPEOF(Template.PRIM_RANGE))InsuranceHeader_xLink.Fields.Make_PRIM_RANGE(ToUpperCase((SALT37.StrType)Input_PRIM_RANGE))
  ,(TYPEOF(Template.PRIM_NAME))InsuranceHeader_xLink.Fields.Make_PRIM_NAME(ToUpperCase((SALT37.StrType)Input_PRIM_NAME))
  ,(TYPEOF(Template.SEC_RANGE))InsuranceHeader_xLink.Fields.Make_SEC_RANGE(ToUpperCase((SALT37.StrType)Input_SEC_RANGE))
  ,(TYPEOF(Template.CITY))InsuranceHeader_xLink.Fields.Make_CITY(ToUpperCase((SALT37.StrType)Input_CITY))
  ,(TYPEOF(Template.ST))InsuranceHeader_xLink.Fields.Make_ST(ToUpperCase((SALT37.StrType)Input_ST))
  ,(TYPEOF(Template.ZIP))Input_ZIP
  ,(TYPEOF(Template.SSN5))InsuranceHeader_xLink.Fields.Make_SSN5((SALT37.StrType)Input_SSN5)
  ,(TYPEOF(Template.SSN4))InsuranceHeader_xLink.Fields.Make_SSN4((SALT37.StrType)Input_SSN4)
  ,(TYPEOF(Template.DOB))InsuranceHeader_xLink.Fields.Make_DOB((SALT37.StrType)Input_DOB)
  ,(TYPEOF(Template.PHONE))Input_PHONE
  ,(TYPEOF(Template.DL_STATE))InsuranceHeader_xLink.Fields.Make_DL_STATE(ToUpperCase((SALT37.StrType)Input_DL_STATE))
  ,(TYPEOF(Template.DL_NBR))InsuranceHeader_xLink.Fields.Make_DL_NBR(ToUpperCase((SALT37.StrType)Input_DL_NBR))
  ,(TYPEOF(Template.SRC))InsuranceHeader_xLink.Fields.Make_SRC((SALT37.StrType)Input_SRC)
  ,(TYPEOF(Template.SOURCE_RID))InsuranceHeader_xLink.Fields.Make_SOURCE_RID((SALT37.StrType)Input_SOURCE_RID)
  ,(TYPEOF(Template.DT_FIRST_SEEN))InsuranceHeader_xLink.Fields.Make_DT_FIRST_SEEN((SALT37.StrType)Input_DT_FIRST_SEEN)
  ,(TYPEOF(Template.DT_LAST_SEEN))InsuranceHeader_xLink.Fields.Make_DT_LAST_SEEN((SALT37.StrType)Input_DT_LAST_SEEN)
  ,(TYPEOF(Template.DT_EFFECTIVE_FIRST))InsuranceHeader_xLink.Fields.Make_DT_EFFECTIVE_FIRST((SALT37.StrType)Input_DT_EFFECTIVE_FIRST)
  ,(TYPEOF(Template.DT_EFFECTIVE_LAST))InsuranceHeader_xLink.Fields.Make_DT_EFFECTIVE_LAST((SALT37.StrType)Input_DT_EFFECTIVE_LAST)
  ,(TYPEOF(Template.MAINNAME))InsuranceHeader_xLink.Fields.Make_MAINNAME((SALT37.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.FULLNAME))InsuranceHeader_xLink.Fields.Make_FULLNAME((SALT37.StrType)Input_FULLNAME)
  ,(TYPEOF(Template.ADDR1))InsuranceHeader_xLink.Fields.Make_ADDR1((SALT37.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))InsuranceHeader_xLink.Fields.Make_LOCALE((SALT37.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRESS))InsuranceHeader_xLink.Fields.Make_ADDRESS((SALT37.StrType)Input_ADDRESS)
  ,(TYPEOF(Template.fname2))ToUpperCase(Input_fname2)
  ,(TYPEOF(Template.lname2))ToUpperCase(Input_lname2)
  ,RecordsOnly,FullMatch,e_RID,e_DID}],InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout);
 
  pm := InsuranceHeader_xLink.MEOW_xIDL(Input_Data); // This module performs regular xDID functions
	ds1 := pm.Data_; 
	outputLayout := RECORDOF(ds1);
	outputNewLayout := RECORD
		InsuranceHeader_xLink.Process_xIDL_Layouts().id_stream_layout;
		STRING Segmentation;
		STRING KeysUsedDesc;
		STRING KeysFailedDesc;
		outputLayout -InsuranceHeader_xLink.Process_xIDL_Layouts().id_stream_layout;
	END;
	segKey := InsuranceHeader_PostProcess.segmentation_keys.key_did;
	newOutputRes := project(ds1, 
			TRANSFORM(outputNewLayout, 
			self.KeysUsedDesc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.KeysUsed);
			self.KeysFailedDesc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.KeysFailed);
			self.Segmentation := segKey(DID=left.did)[1].ind;
			self := LEFT));	
  ds := newOutputRes;
	
  FieldNumber(SALT37.StrType fn) := CASE(fn,'SNAME' => 1,'FNAME' => 2,'MNAME' => 3,'LNAME' => 4,'DERIVED_GENDER' => 5,'PRIM_RANGE' => 6,'PRIM_NAME' => 7,'SEC_RANGE' => 8,'CITY' => 9,'ST' => 10,'ZIP' => 11,'SSN5' => 12,'SSN4' => 13,'DOB' => 14,'PHONE' => 15,'DL_STATE' => 16,'DL_NBR' => 17,'SRC' => 18,'SOURCE_RID' => 19,'DT_FIRST_SEEN' => 20,'DT_LAST_SEEN' => 21,'DT_EFFECTIVE_FIRST' => 22,'DT_EFFECTIVE_LAST' => 23,31);
  result := CHOOSE(FieldNumber(Input_SortBy),SORT(ds,-weight,DID,SNAME,RECORD),SORT(ds,-weight,DID,FNAME,RECORD),SORT(ds,-weight,DID,MNAME,RECORD),SORT(ds,-weight,DID,LNAME,RECORD),SORT(ds,-weight,DID,DERIVED_GENDER,RECORD),SORT(ds,-weight,DID,PRIM_RANGE,RECORD),SORT(ds,-weight,DID,PRIM_NAME,RECORD),SORT(ds,-weight,DID,SEC_RANGE,RECORD),SORT(ds,-weight,DID,CITY,RECORD),SORT(ds,-weight,DID,ST,RECORD),SORT(ds,-weight,DID,ZIP,RECORD),SORT(ds,-weight,DID,SSN5,RECORD),SORT(ds,-weight,DID,SSN4,RECORD),SORT(ds,-weight,DID,DOB,RECORD),SORT(ds,-weight,DID,PHONE,RECORD),SORT(ds,-weight,DID,DL_STATE,RECORD),SORT(ds,-weight,DID,DL_NBR,RECORD),SORT(ds,-weight,DID,SRC,RECORD),SORT(ds,-weight,DID,SOURCE_RID,RECORD),SORT(ds,-weight,DID,DT_FIRST_SEEN,RECORD),SORT(ds,-weight,DID,DT_LAST_SEEN,RECORD),SORT(ds,-weight,DID,DT_EFFECTIVE_FIRST,RECORD),SORT(ds,-weight,DID,DT_EFFECTIVE_LAST,RECORD),SORT(ds,-weight,DID,RECORD));
	recCount := {integer Total_Records};
	output(DATASET([{count(result)}], recCount),named('RecordCount'));
  OUTPUT(result,NAMED('Header_Data'));
  // OUTPUT(pm.Data_0,NAMED('Attribute0'));
ENDMACRO;

