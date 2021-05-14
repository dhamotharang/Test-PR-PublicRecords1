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
<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
/*--RESULT-- InsuranceHeader_xLink.Format_Header_Service */
EXPORT xIDL_Header_Service := MACRO
  #WEBSERVICE(FIELDS(
	'SNAME', 'FNAME', 'MNAME', 'LNAME', 'NAME', 'DERIVED_GENDER',
	'ADDRESS1', 'ADDRESS2', 'PRIM_RANGE', 'PRIM_NAME', 'SEC_RANGE', 'CITY',
	'ST', 'ZIP', 'SSN', 'DOB', 'PHONE', 'DL_STATE', 'DL_NBR', 'fname2', 'lname2', 'RID', 'VIN', 'DID', 'SortBy',
	'disableForce', 'MatchAllInOneRecord', 'RecordsOnly', 'MaxIds', 'LeadThreshold', 'UniqueID'
	),
	HELP('<p>NAME:full name to be cleaned (for ex: John A Smith)</p>' +
	'<p>DOB format: YYYYMMDD (for ex: 19710101)</p>'+
	'<p>ADDRESS1:first part of address to be cleaned (for ex: 123 Main Street)</p>'+
	'<p>ADDRESS2:second part of address to be cleaned (for ex: Miami, FL, 12345)</p>'+
	'<p>SortBy:RID|Source|FirstSeenDate|LastSeenDate|ADRIndicator|DLNIndicator|DOBIndicator|SSNIndicator|LastName|City</p>' + 
	'<p>Minimum Requirements:<ul style="list-style-type:none">'+
	'<li>FNAME,LNAME,ST</li><li>PRIM_RANGE,PRIM_NAME,ZIP</li><li>SSN</li><li>SSN4,FNAME,LNAME</li>'+ 
	'<li>DOB,LNAME</li><li>DOB,FNAME</li><li>ZIP,PRIM_RANGE</li><li>DL_NBR,DL_STATE</li><li>PHONE</li><li>LNAME,FNAME,ZIP</li>'+
	'<li>RID<br/><li>fname2:lname2</li><li>VIN</li></ul>'),
	DESCRIPTION('<p>SALT V3.11</p>' + 
	'<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>'));/*FIELDS HACK*/	/*HACK19*/
  IMPORT SALT311,InsuranceHeader_xLink;
  STRING Input_NAME := '' : STORED('NAME'); /*HACK20*/ 
	clean_n := address.CleanPersonFML73(Input_NAME);
	clean_n_parsed := Address.CleanNameFields(clean_n);
	nameLine := Input_name != '';
	STRING sSname := '' : STORED('SNAME');
	SALT311.StrType Input_SNAME := IF(nameLine, clean_n_parsed.name_suffix, sSname);
	STRING sFname := '' : STORED('FNAME');
	SALT311.StrType Input_FNAME := IF(nameLine, clean_n_parsed.fname, sFname);
	STRING sMname := '' : STORED('MNAME');
	SALT311.StrType Input_MNAME := IF(nameLine, clean_n_parsed.mname, sMname);
	STRING sLname := '' : STORED('LNAME');
	SALT311.StrType Input_LNAME := IF(nameLine, clean_n_parsed.lname, sLname); /*CLEAN NAME HACK*/
  SALT311.StrType Input_DERIVED_GENDER := '' : STORED('DERIVED_GENDER');
  STRING addressLine1 := '' : STORED('ADDRESS1');
	STRING addressLine2 := '' : STORED('ADDRESS2');
	CleanedAddress		:= Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;
	addressLine 		:= addressLine1 != '' and addressLine2 != '';
	STRING sPrim_range := '' : STORED('PRIM_RANGE');
	SALT311.StrType Input_PRIM_RANGE := IF(addressLine,  CleanedAddress.prim_range, sPrim_range);
	STRING sPrim_name :=  '' : STORED('PRIM_NAME');
	SALT311.StrType Input_PRIM_NAME := IF(addressLine,  CleanedAddress.prim_name, sPrim_name);
	STRING sSec_range :=  '' : STORED('SEC_RANGE');
	SALT311.StrType Input_SEC_RANGE := IF(addressLine,  CleanedAddress.sec_range, sSec_range);
	STRING sCity :=  '' : STORED('CITY');
	SALT311.StrType Input_CITY := IF(addressLine,  CleanedAddress.v_city_name, sCity);
	STRING sSt :=  '' : STORED('ST');
	SALT311.StrType Input_ST := IF(addressLine,  CleanedAddress.st, sSt);
	STRING sZip :=  '' : STORED('ZIP');
	SALT311.StrType Input_ZIP := IF(addressLine,  CleanedAddress.zip, sZip); /*CLEAN ADDRESS HACK*/
	SALT311.StrType Input_SSN := '' : STORED('SSN');
	INTEGER ssnInt := (INTEGER)Input_SSN;
	SALT311.StrType Input_SSN5 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN5, '');/* HACK SSN5 */
  SALT311.StrType Input_SSN4 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN4, ''); /* HACK SSN4 */
	SALT311.StrType Input_DOB := '' : STORED('DOB');
  SALT311.StrType Input_PHONE := '' : STORED('PHONE');
  SALT311.StrType Input_DL_STATE := '' : STORED('DL_STATE');
  SALT311.StrType Input_DL_NBR := '' : STORED('DL_NBR');
  SALT311.StrType Input_SRC := '' : STORED('SRC');
  SALT311.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID');
  UNSIGNED e_RID := 0 : STORED('RID');
  SALT311.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN');
  SALT311.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN');
  SALT311.StrType Input_DT_EFFECTIVE_FIRST := '' : STORED('DT_EFFECTIVE_FIRST');
  SALT311.StrType Input_DT_EFFECTIVE_LAST := '' : STORED('DT_EFFECTIVE_LAST');
  SALT311.StrType Input_MAINNAME := '' : STORED('MAINNAME');
  SALT311.StrType Input_FULLNAME := '' : STORED('FULLNAME');
  SALT311.StrType Input_ADDRESS := '' : STORED('ADDRESS');
  SALT311.StrType Input_ADDR1 := '' : STORED('ADDR1');
  SALT311.StrType Input_LOCALE := '' : STORED('LOCALE');
  SALT311.StrType Input_fname2 := '' : STORED('fname2');
  SALT311.StrType Input_lname2 := '' : STORED('lname2');	
  SALT311.StrType Input_VIN := '' : STORED('VIN');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold');	
  UNSIGNED e_DID := 0 : STORED('DID');
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord');
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly');
  SALT311.StrType Input_SortBy := '' : STORED('SortBy');
  BOOLEAN Input_disableForce := InsuranceHeader_xLink.Config.DOB_NotUseForce : STORED('disableForce');/*HACK18*/
 
  Template := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout);
	ToUpperCase(STRING aString) := STD.Str.ToUpperCase(aString); /*HACK21a*/
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,Input_disableForce
  ,(TYPEOF(Template.SNAME))InsuranceHeader_xLink.Fields.Make_SNAME(ToUpperCase((SALT311.StrType)Input_SNAME)) /*HACK21b*/
  ,(TYPEOF(Template.FNAME))InsuranceHeader_xLink.Fields.Make_FNAME(ToUpperCase((SALT311.StrType)Input_FNAME)) /*HACK21b*/
  ,(TYPEOF(Template.MNAME))InsuranceHeader_xLink.Fields.Make_MNAME(ToUpperCase((SALT311.StrType)Input_MNAME)) /*HACK21b*/
  ,(TYPEOF(Template.LNAME))InsuranceHeader_xLink.Fields.Make_LNAME(ToUpperCase((SALT311.StrType)Input_LNAME)) /*HACK21b*/
  ,(TYPEOF(Template.DERIVED_GENDER))InsuranceHeader_xLink.Fields.Make_DERIVED_GENDER(ToUpperCase((SALT311.StrType)Input_DERIVED_GENDER)) /*HACK21b*/
  ,(TYPEOF(Template.PRIM_RANGE))InsuranceHeader_xLink.Fields.Make_PRIM_RANGE(ToUpperCase((SALT311.StrType)Input_PRIM_RANGE)) /*HACK21b*/
  ,(TYPEOF(Template.PRIM_NAME))InsuranceHeader_xLink.Fields.Make_PRIM_NAME(ToUpperCase((SALT311.StrType)Input_PRIM_NAME)) /*HACK21b*/
  ,(TYPEOF(Template.SEC_RANGE))InsuranceHeader_xLink.Fields.Make_SEC_RANGE(ToUpperCase((SALT311.StrType)Input_SEC_RANGE)) /*HACK21b*/
  ,(TYPEOF(Template.CITY))InsuranceHeader_xLink.Fields.Make_CITY(ToUpperCase((SALT311.StrType)Input_CITY)) /*HACK21b*/
  ,(TYPEOF(Template.ST))InsuranceHeader_xLink.Fields.Make_ST(ToUpperCase((SALT311.StrType)Input_ST)) /*HACK21b*/
  ,DATASET([{Input_ZIP, 100}],InsuranceHeader_xLink.process_xIDL_layouts().layout_ZIP_cases) /*HACK27*/
  ,(TYPEOF(Template.SSN5))InsuranceHeader_xLink.Fields.Make_SSN5((SALT311.StrType)Input_SSN5)
  ,(TYPEOF(Template.SSN4))InsuranceHeader_xLink.Fields.Make_SSN4((SALT311.StrType)Input_SSN4)
  ,(TYPEOF(Template.DOB))InsuranceHeader_xLink.Fields.Make_DOB((SALT311.StrType)Input_DOB)
  ,(TYPEOF(Template.PHONE))Input_PHONE
  ,(TYPEOF(Template.DL_STATE))InsuranceHeader_xLink.Fields.Make_DL_STATE(ToUpperCase((SALT311.StrType)Input_DL_STATE)) /*HACK21b*/
  ,(TYPEOF(Template.DL_NBR))InsuranceHeader_xLink.Fields.Make_DL_NBR(ToUpperCase((SALT311.StrType)Input_DL_NBR)) /*HACK21b*/
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
  ,(TYPEOF(Template.fname2))ToUpperCase(Input_fname2)/*HACK21c*/
  ,(TYPEOF(Template.lname2))ToUpperCase(Input_lname2)/*HACK21c*/
  ,(TYPEOF(Template.VIN))Input_VIN
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
  ds := IDLExternalLinking.xIDL_getDeltaBestRecs(newOutputRes, rid);/*XIDLHACK01*/
  FieldNumber(SALT311.StrType fn) := CASE(fn,'SNAME' => 1,'FNAME' => 2,'MNAME' => 3,'LNAME' => 4,'DERIVED_GENDER' => 5,'PRIM_RANGE' => 6,'PRIM_NAME' => 7,'SEC_RANGE' => 8,'CITY' => 9,'ST' => 10,'ZIP' => 11,'SSN5' => 12,'SSN4' => 13,'DOB' => 14,'PHONE' => 15,'DL_STATE' => 16,'DL_NBR' => 17,'SRC' => 18, 'Source' =>18, 'SOURCE_RID' => 19,
                /*Begin XIDLHACK02*/
                'DT_FIRST_SEEN' => 20, 'FirstSeenDate' => 20,
                'DT_LAST_SEEN' => 21, 'LastSeenDate' => 21, 
                'DT_EFFECTIVE_FIRST' => 22,'DT_EFFECTIVE_LAST' => 23, 
                'SSN_IND' => 24, 'SSNIndicator' => 24,
                'DLNO_IND' => 25, 'DLNIndicator' => 25, 
                'DOB_IND' => 26, 'DOBIndicator' => 26, 
                'ADDR_IND' => 27, 'ADRIndicator' => 27,
                'RID'=>28, 31); /*End XIDLHACK02*/
  result := CHOOSE(FieldNumber(Input_SortBy),SORT(ds,-weight,DID,SNAME,RECORD),SORT(ds,-weight,DID,FNAME,RECORD),SORT(ds,-weight,DID,MNAME,RECORD),SORT(ds,-weight,DID,LNAME,RECORD),SORT(ds,-weight,DID,DERIVED_GENDER,RECORD),SORT(ds,-weight,DID,PRIM_RANGE,RECORD),SORT(ds,-weight,DID,PRIM_NAME,RECORD),SORT(ds,-weight,DID,SEC_RANGE,RECORD),SORT(ds,-weight,DID,CITY,RECORD),SORT(ds,-weight,DID,ST,RECORD),SORT(ds,-weight,DID,ZIP,RECORD),SORT(ds,-weight,DID,SSN5,RECORD),SORT(ds,-weight,DID,SSN4,RECORD),SORT(ds,-weight,DID,DOB,RECORD),SORT(ds,-weight,DID,PHONE,RECORD),SORT(ds,-weight,DID,DL_STATE,RECORD),SORT(ds,-weight,DID,DL_NBR,RECORD),SORT(ds,-weight,DID,SRC,RECORD),SORT(ds,-weight,DID,SOURCE_RID,RECORD),SORT(ds,-weight,DID,DT_FIRST_SEEN,RECORD),SORT(ds,-weight,DID,DT_LAST_SEEN,RECORD),SORT(ds,-weight,DID,DT_EFFECTIVE_FIRST,RECORD),SORT(ds,-weight,DID,DT_EFFECTIVE_LAST,RECORD),SORT(ds,-weight,DID,SSN_IND,RECORD),SORT(ds,-weight,DID,(UNSIGNED)DLNO_IND,RECORD),SORT(ds,-weight,DID,DOB_IND,RECORD),SORT(ds,-weight,DID,(UNSIGNED)ADDR_IND,RECORD), SORT(ds,-weight,DID,RID,RECORD), SORT(ds,-weight,DID,RECORD));
	recCount := {integer Total_Records}; 
 output(DATASET([{count(result)}], recCount),named('RecordCount')); /*XIDLHACK03*/ 

  OUTPUT(result,NAMED('Header_Data'));
  OUTPUT(pm.Data_0,NAMED('Relatives'));/*XIDLHACK04a*/
  OUTPUT(pm.Data_1,NAMED('VIN'));/*XIDLHACK04b*/
ENDMACRO;
