/*--SOAP--
<message name="xLNPID_Header_Service">
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
// <part name="C_LIC_NBR" type="xsd:string"/>
<part name="TAX_ID" type="xsd:string"/>
// <part name="BILLING_TAX_ID" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="VENDOR_ID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
// <part name="BILLING_NPI_NUMBER" type="xsd:string"/>
<part name="UPIN" type="xsd:string"/>
<part name="DID" type="xsd:string"/>
<part name="BDID" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="SOURCE_RID" type="xsd:string"/>
<part name="RID" type="xsd:string"/>
// <part name="MAINNAME" type="xsd:string"/>
// <part name="FULLNAME" type="xsd:string"/>
// <part name="ADDR1" type="xsd:string"/>
// <part name="LOCALE" type="xsd:string"/>
// <part name="ADDRESS" type="xsd:string"/>
<part name="LNPID" type="unsignedInt"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="SortBy" type="xsd:string"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
<part name="parseInput" type="xsd:boolean"/>
</message>
*/
 
/*--INFO-- Find those entities having records matching the input criteria.
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT xLNPID_Header_Service := MACRO
  IMPORT SALT311,Health_Provider_Services,HealthCareProvider,Address;
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
  SALT311.StrType Input_MAINNAME := '' : STORED('MAINNAME', FORMAT(NOINPUT));
  SALT311.StrType Input_FULLNAME := '' : STORED('FULLNAME', FORMAT(NOINPUT));
  SALT311.StrType Input_ADDR1 := '' : STORED('ADDR1', FORMAT(NOINPUT));
  SALT311.StrType Input_LOCALE := '' : STORED('LOCALE', FORMAT(NOINPUT));
  SALT311.StrType Input_ADDRESS := '' : STORED('ADDRESS', FORMAT(NOINPUT));
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord', FORMAT(SEQUENCE(39)));
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly', FORMAT(SEQUENCE(40)));
  SALT311.StrType Input_SortBy := '' : STORED('SortBy', FORMAT(SEQUENCE(41)));
  UNSIGNED e_LNPID := 0 : STORED('LNPID', FORMAT(SEQUENCE(42)));
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(43)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(44)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(45)));

	BOOLEAN ParseInput := FALSE: STORED('parseInput');
	
	cleanData (string str) := TRIM(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(str)),' '),LEFT,RIGHT);
	cleanName (string name) := address.CleanNameFields (address.CleanPersonFML73(name));
	cleanLIC	(STRING25 lic) := Health_Provider_Services.fn_cleanlicense (lic);
	cleanPhone(STRING10 iphone) := Health_Provider_Services.fn_cleanphone (iPhone);

	C_FNAME	:=	cleanData(Input_FNAME);
	C_MNAME	:=	cleanData(Input_MNAME);
	C_LNAME	:=	cleanData(Input_LNAME);
	C_SNAME	:=	cleanData(Input_SNAME);
	
	C_Prim_Range 	:= HealthCareProvider.CleanData.fUpperCleanSpaces(Input_PRIM_RANGE);
	C_Prim_Name	 	:= HealthCareProvider.CleanData.fUpperCleanSpaces(Input_PRIM_Name);
	C_Sec_Range	 	:= HealthCareProvider.CleanData.fUpperCleanSpaces(Input_Sec_Range);
	C_V_City_Name := HealthCareProvider.CleanData.fUpperCleanSpaces(Input_V_City_Name);
	C_ST					:= HealthCareProvider.CleanData.fUpperCleanSpaces(Input_ST);
	C_Zip					:= HealthCareProvider.CleanData.fUpperCleanSpaces(Input_Zip);
	
	STRING100 ADDRLINE1	:= Address.Addr1FromComponents(C_Prim_Range, '', C_Prim_Name, '', '', '', C_Sec_Range,); 
	STRING100 ADDRLINE2	:= Address.Addr2FromComponents(C_V_City_Name, C_ST, C_Zip); 
	
	cleanA	:=	Address.CleanAddress182(ADDRLINE1, ADDRLINE2);
	isMinData	:=	(C_Prim_Name <> '' and C_St <> '' and C_V_City_Name <> '') or (C_Prim_Name <> '' and C_Zip <> '');
	Prim_Range 	:= IF (parseInput and isMinData,cleanA[1..10],C_Prim_Range);
	Prim_Name  	:= IF (parseInput and isMinData,cleanA[13..40],C_Prim_Name);
	Sec_Range  	:= IF (parseInput and isMinData,cleanA[57..64],C_Sec_Range);
	V_City_Name := IF (parseInput and isMinData,cleanA[90..114],C_V_City_Name);
	ST				 	:= IF (parseInput and isMinData,cleanA[115..116],C_ST);
	ZIP				 	:= IF (parseInput and isMinData,cleanA[117..121],C_Zip);
	
	Name		:=	address.CleanNameFields (address.CleanPersonFML73(C_FNAME + ' ' + C_MNAME + ' ' + C_LNAME + ' ' + C_SNAME));
  FNAME 	:= 	IF (parseInput,Name.FNAME,C_FNAME);
  MNAME 	:=	IF (parseInput,Name.MNAME,C_MNAME);
  LNAME 	:= 	IF (parseInput,Name.LNAME,C_LNAME);
  SNAME 	:= 	Health_Provider_Services.fn_clean_suffix (IF (parseInput,Name.NAME_SUFFIX,C_SNAME));
	
	IDOB 	:= Input_DOB;
	DOB 	:= IF(HealthCareProvider.isValidDOB (IDOB),IDOB,'');
	
	Phone		:= HealthCareProvider.Clean_Phone (Input_PHONE);
  Lic_NBR :=	HealthCareProvider.Clean_License (Input_C_LIC_NBR);
 
  Template := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.FNAME))Health_Provider_Services.Fields.Make_FNAME((SALT311.StrType)FNAME)
  ,(TYPEOF(Template.MNAME))Health_Provider_Services.Fields.Make_MNAME((SALT311.StrType)MNAME)
  ,(TYPEOF(Template.LNAME))Health_Provider_Services.Fields.Make_LNAME((SALT311.StrType)LNAME)
  ,(TYPEOF(Template.SNAME))Health_Provider_Services.Fields.Make_SNAME((SALT311.StrType)SNAME)
  ,(TYPEOF(Template.GENDER))Health_Provider_Services.Fields.Make_GENDER(cleanData((SALT311.StrType)Input_GENDER))
  ,(TYPEOF(Template.PRIM_RANGE))Health_Provider_Services.Fields.Make_PRIM_RANGE((SALT311.StrType)PRIM_RANGE)
  ,(TYPEOF(Template.PRIM_NAME))Health_Provider_Services.Fields.Make_PRIM_NAME((SALT311.StrType)PRIM_NAME)
  ,(TYPEOF(Template.SEC_RANGE))Health_Provider_Services.Fields.Make_SEC_RANGE((SALT311.StrType)SEC_RANGE)
  ,(TYPEOF(Template.V_CITY_NAME))Health_Provider_Services.Fields.Make_V_CITY_NAME((SALT311.StrType)V_CITY_NAME)
  ,(TYPEOF(Template.ST))Health_Provider_Services.Fields.Make_ST((SALT311.StrType)ST)
  ,(TYPEOF(Template.ZIP))Health_Provider_Services.Fields.Make_ZIP((SALT311.StrType)ZIP)
  ,(TYPEOF(Template.SSN))Health_Provider_Services.Fields.Make_SSN((SALT311.StrType)Input_SSN)
  ,(TYPEOF(Template.CNSMR_SSN))Health_Provider_Services.Fields.Make_CNSMR_SSN((SALT311.StrType)Input_CNSMR_SSN)
  ,(TYPEOF(Template.DOB))Health_Provider_Services.Fields.Make_DOB((SALT311.StrType)Input_DOB)
  ,(TYPEOF(Template.CNSMR_DOB))Health_Provider_Services.Fields.Make_CNSMR_DOB((SALT311.StrType)Input_CNSMR_DOB)
  ,(TYPEOF(Template.PHONE))Health_Provider_Services.Fields.Make_PHONE((SALT311.StrType)Input_PHONE)
  ,(TYPEOF(Template.LIC_STATE))Health_Provider_Services.Fields.Make_LIC_STATE(cleanData((SALT311.StrType)Input_LIC_STATE))
  ,(TYPEOF(Template.C_LIC_NBR))Health_Provider_Services.Fields.Make_C_LIC_NBR(cleanLIC((SALT311.StrType)Lic_NBR))
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
  ,RecordsOnly,FullMatch,e_LNPID}],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
 
  pm := Health_Provider_Services.MEOW_xLNPID(Input_Data); // This module performs regular xLNPID functions
  ds := pm.Data_;
  FieldNumber(SALT311.StrType fn) := CASE(fn,'FNAME' => 1,'MNAME' => 2,'LNAME' => 3,'SNAME' => 4,'GENDER' => 5,'PRIM_RANGE' => 6,'PRIM_NAME' => 7,'SEC_RANGE' => 8,'V_CITY_NAME' => 9,'ST' => 10,'ZIP' => 11,'SSN' => 12,'CNSMR_SSN' => 13,'DOB' => 14,'CNSMR_DOB' => 15,'PHONE' => 16,'LIC_STATE' => 17,'C_LIC_NBR' => 18,'TAX_ID' => 19,'BILLING_TAX_ID' => 20,'DEA_NUMBER' => 21,'VENDOR_ID' => 22,'NPI_NUMBER' => 23,'BILLING_NPI_NUMBER' => 24,'UPIN' => 25,'DID' => 26,'BDID' => 27,'SRC' => 28,'SOURCE_RID' => 29,'RID' => 30,36);
  result := CHOOSE(FieldNumber(Input_SortBy),SORT(ds,-weight,LNPID,FNAME,RECORD),SORT(ds,-weight,LNPID,MNAME,RECORD),SORT(ds,-weight,LNPID,LNAME,RECORD),SORT(ds,-weight,LNPID,SNAME,RECORD),SORT(ds,-weight,LNPID,GENDER,RECORD),SORT(ds,-weight,LNPID,PRIM_RANGE,RECORD),SORT(ds,-weight,LNPID,PRIM_NAME,RECORD),SORT(ds,-weight,LNPID,SEC_RANGE,RECORD),SORT(ds,-weight,LNPID,V_CITY_NAME,RECORD),SORT(ds,-weight,LNPID,ST,RECORD),SORT(ds,-weight,LNPID,ZIP,RECORD),SORT(ds,-weight,LNPID,SSN,RECORD),SORT(ds,-weight,LNPID,CNSMR_SSN,RECORD),SORT(ds,-weight,LNPID,DOB,RECORD),SORT(ds,-weight,LNPID,CNSMR_DOB,RECORD),SORT(ds,-weight,LNPID,PHONE,RECORD),SORT(ds,-weight,LNPID,LIC_STATE,RECORD),SORT(ds,-weight,LNPID,C_LIC_NBR,RECORD),SORT(ds,-weight,LNPID,TAX_ID,RECORD),SORT(ds,-weight,LNPID,BILLING_TAX_ID,RECORD),SORT(ds,-weight,LNPID,DEA_NUMBER,RECORD),SORT(ds,-weight,LNPID,VENDOR_ID,RECORD),SORT(ds,-weight,LNPID,NPI_NUMBER,RECORD),SORT(ds,-weight,LNPID,BILLING_NPI_NUMBER,RECORD),SORT(ds,-weight,LNPID,UPIN,RECORD),SORT(ds,-weight,LNPID,DID,RECORD),SORT(ds,-weight,LNPID,BDID,RECORD),SORT(ds,-weight,LNPID,SRC,RECORD),SORT(ds,-weight,LNPID,SOURCE_RID,RECORD),SORT(ds,-weight,LNPID,RID,RECORD),SORT(ds,-weight,LNPID,RECORD));

	recCount := {integer Total_Records};	
	OUTPUT	(DATASET([{COUNT(Result)}], recCount),named('RecordCount'));	
	OUTPUT(Input_Data,NAMED('Input_Data'));
	Trim_Result := PROJECT (Result,Health_Provider_Services.Layouts.Trimmed_Layout);
	Recent_Result := PROJECT (dedup(sort(Result,lic_nbr,-dt_lic_expiration),lic_nbr),Health_Provider_Services.Layouts.Trimmed_Layout);
	OUTPUT(DEDUP(SORT(Trim_Result(DID > 0),DID,SRC),DID,SRC),NAMED('DID_Result'));	
	OUTPUT(DEDUP(SORT(Trim_Result(SRC = '64' and Vendor_ID <> ''),vendor_id),vendor_id),NAMED('Enclarity_Result'));	
	OUTPUT(DEDUP(SORT(Trim_Result(SRC = 'PL' and Vendor_ID <> ''),vendor_id),vendor_id),NAMED('Prof_Lic_Result'));	
	OUTPUT(DEDUP(SORT(Trim_Result(SRC = 'S8' and Vendor_ID <> ''),vendor_id),vendor_id),NAMED('HMS_Result'));	
	OUTPUT(DEDUP(SORT(Recent_Result(LIC_NBR <> ''),LIC_NBR),LIC_NBR),NAMED('Raw_Lic_Result'));	
	OUTPUT(DEDUP(SORT(Recent_Result(C_LIC_NBR <> ''),C_LIC_NBR),C_LIC_NBR),NAMED('Clean_Lic_Result'));
	OUTPUT(SORT(Trim_Result(DEA_NUMBER <> ''),DEA_NUMBER),NAMED('DEA_Result'));
	OUTPUT(SORT(Trim_Result,SRC,VENDOR_ID),NAMED('Trim_Result'));
	OUTPUT (pm.Raw_Results,NAMED('Raw_Results'));

  OUTPUT(result,NAMED('Header_Data'));
ENDMACRO;
