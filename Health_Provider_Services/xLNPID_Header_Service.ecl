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
<part name="DOB" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="LIC_STATE" type="xsd:string"/>
<part name="C_LIC_NBR" type="xsd:string"/>
<part name="TAX_ID" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="VENDOR_ID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
<part name="UPIN" type="xsd:string"/>
<part name="DID" type="xsd:string"/>
<part name="BDID" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="SOURCE_RID" type="xsd:string"/>
<part name="RID" type="xsd:string"/>
<part name="LNPID" type="unsignedInt"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
<part name="SortBy" type="xsd:string">
	<html>
	<td width="10%" valign="top"><font face="Verdana" size="2">SortBy:</font></td><td><font face="Verdana" size="2">
	<select name="SortBy">
		<option value="RID">RID</option>
		<option value="Source">Source</option>
		<option value="FirstSeenDate">FirstSeenDate</option>
		<option value="LastSeenDate">LastSeenDate</option>
		<option value="ADDRIndicator">ADDRIndicator</option>
		<option value="LICIndicator">LICIndicator</option>
		<option value="DOBIndicator">DOBIndicator</option>
		<option value="NPIIndicator">NPIIndicator</option>
		<option value="DEAIndicator">DEAIndicator</option>
		<option value="UPINIndicator">UPINIndicator</option>
		<option value="DID">DID</option>
		<option value="LastName">LastName</option>
		<option value="City">City</option>
		<option value="SSN">SSN</option>
		<option value="Gender">Gender</option>
	</select>
	</font></td>
	</html>
</part>
</message>
*/
/*--INFO-- Find those entities having records matching the input criteria.<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
</p><p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT xLNPID_Header_Service  := MACRO
  IMPORT SALT29,Health_Provider_Services,HealthCareProvider,Address;
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
  SALT29.StrType Input_CNSMR_SSN := '' : STORED('SSN');
  SALT29.StrType Input_DOB := '' : STORED('DOB');
  SALT29.StrType Input_CNSMR_DOB := '' : STORED('DOB');
  SALT29.StrType Input_PHONE := '' : STORED('PHONE');
  SALT29.StrType Input_LIC_STATE := '' : STORED('LIC_STATE');
  SALT29.StrType Input_C_LIC_NBR := '' : STORED('C_LIC_NBR');
  SALT29.StrType Input_TAX_ID := '' : STORED('TAX_ID');
  SALT29.StrType Input_BILLING_TAX_ID := '' : STORED('TAX_ID');
  SALT29.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER');
  SALT29.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID');
  SALT29.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER');
  SALT29.StrType Input_BILLING_NPI_NUMBER := '' : STORED('NPI_NUMBER');
  SALT29.StrType Input_UPIN := '' : STORED('UPIN');
  SALT29.StrType Input_DID := '' : STORED('DID');
  SALT29.StrType Input_BDID := '' : STORED('BDID');
  SALT29.StrType Input_SRC := '' : STORED('SRC');
  SALT29.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID');
  SALT29.StrType Input_RID := '' : STORED('RID');
  SALT29.StrType Input_MAINNAME := '';
  SALT29.StrType Input_FULLNAME := '';
  SALT29.StrType Input_ADDR1 := '';
  SALT29.StrType Input_LOCALE := '';
  SALT29.StrType Input_ADDRESS := '';
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,5,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0;
  UNSIGNED e_LNPID := 0 : STORED('LNPID');
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord');
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly');
	BOOLEAN ParseInput := FALSE: STORED('parseInput');
	STRING Input_sortBy := '' : stored('SortBy');
	
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

	Prim_Range 	:= IF (parseInput,cleanA[1..10],C_Prim_Range);
	Prim_Name  	:= IF (parseInput,cleanA[13..40],C_Prim_Name);
	Sec_Range  	:= IF (parseInput,cleanA[57..64],C_Sec_Range);
	V_City_Name := IF (parseInput,cleanA[90..114],C_V_City_Name);
	ST				 	:= IF (parseInput,cleanA[115..116],C_ST);
	ZIP				 	:= IF (parseInput,cleanA[117..121],C_Zip);
	
	Name		:=	address.CleanNameFields (address.CleanPersonFML73(C_FNAME + ' ' + C_MNAME + ' ' + C_LNAME + ' ' + C_SNAME));
  FNAME 	:= 	IF (parseInput,Name.FNAME,C_FNAME);
  MNAME 	:=	IF (parseInput,Name.MNAME,C_MNAME);
  LNAME 	:= 	IF (parseInput,Name.LNAME,C_LNAME);
  SNAME 	:= 	IF (parseInput,Name.NAME_SUFFIX,C_SNAME);
	
	IDOB 	:= Input_DOB;
	DOB 	:= IF(HealthCareProvider.isValidDOB (IDOB),IDOB,'');
	
	Phone		:= HealthCareProvider.Clean_Phone (Input_PHONE);
  Lic_NBR :=	HealthCareProvider.Clean_License (Input_C_LIC_NBR);
	
  Template := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
  
	Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.FNAME))Health_Provider_Services.Fields.Make_FNAME																										((SALT29.StrType)FNAME)
  ,(TYPEOF(Template.MNAME))Health_Provider_Services.Fields.Make_MNAME																										((SALT29.StrType)MNAME)
  ,(TYPEOF(Template.LNAME))Health_Provider_Services.Fields.Make_LNAME																										((SALT29.StrType)LNAME)
  ,(TYPEOF(Template.SNAME))Health_Provider_Services.Fields.Make_SNAME																										((SALT29.StrType)SNAME)
  ,(TYPEOF(Template.GENDER))Health_Provider_Services.Fields.Make_GENDER																									(cleanData((SALT29.StrType)Input_GENDER))
  ,(TYPEOF(Template.PRIM_RANGE))Health_Provider_Services.Fields.Make_PRIM_RANGE																					((SALT29.StrType)PRIM_RANGE)
  ,(TYPEOF(Template.PRIM_NAME))Health_Provider_Services.Fields.Make_PRIM_NAME																						((SALT29.StrType)PRIM_NAME)
  ,(TYPEOF(Template.SEC_RANGE))Health_Provider_Services.Fields.Make_SEC_RANGE																						((SALT29.StrType)SEC_RANGE)
  ,(TYPEOF(Template.V_CITY_NAME))Health_Provider_Services.Fields.Make_V_CITY_NAME																				((SALT29.StrType)V_CITY_NAME)
  ,(TYPEOF(Template.ST))Health_Provider_Services.Fields.Make_ST																													((SALT29.StrType)ST)
  ,(TYPEOF(Template.ZIP))Health_Provider_Services.Fields.Make_ZIP																												((SALT29.StrType)ZIP)
  ,(TYPEOF(Template.SSN))Health_Provider_Services.Fields.Make_SSN																												((SALT29.StrType)Input_SSN)
  ,(TYPEOF(Template.CNSMR_SSN))Health_Provider_Services.Fields.Make_CNSMR_SSN																						((SALT29.StrType)Input_CNSMR_SSN)
  ,(TYPEOF(Template.DOB))Health_Provider_Services.Fields.Make_DOB																												((SALT29.StrType)DOB)
  ,(TYPEOF(Template.CNSMR_DOB))Health_Provider_Services.Fields.Make_CNSMR_DOB																						((SALT29.StrType)DOB)
  ,(TYPEOF(Template.PHONE))Health_Provider_Services.Fields.Make_PHONE																										((SALT29.StrType)PHONE)
  ,(TYPEOF(Template.LIC_STATE))Health_Provider_Services.Fields.Make_LIC_STATE																						(cleanData((SALT29.StrType)Input_LIC_STATE))
  ,(TYPEOF(Template.C_LIC_NBR))Health_Provider_Services.Fields.Make_C_LIC_NBR																						(cleanLIC((SALT29.StrType)LIC_NBR))
  ,(TYPEOF(Template.TAX_ID))Health_Provider_Services.Fields.Make_TAX_ID																									((SALT29.StrType)Input_TAX_ID)
  ,(TYPEOF(Template.BILLING_TAX_ID))Health_Provider_Services.Fields.Make_BILLING_TAX_ID																	((SALT29.StrType)Input_BILLING_TAX_ID)
  ,(TYPEOF(Template.DEA_NUMBER))Health_Provider_Services.Fields.Make_DEA_NUMBER																					(cleanData((SALT29.StrType)Input_DEA_NUMBER))
  ,(TYPEOF(Template.VENDOR_ID))Health_Provider_Services.Fields.Make_VENDOR_ID																						((SALT29.StrType)Input_VENDOR_ID)
  ,(TYPEOF(Template.NPI_NUMBER))Health_Provider_Services.Fields.Make_NPI_NUMBER																					((SALT29.StrType)Input_NPI_NUMBER)
  ,(TYPEOF(Template.BILLING_NPI_NUMBER))Health_Provider_Services.Fields.Make_BILLING_NPI_NUMBER													((SALT29.StrType)Input_BILLING_NPI_NUMBER)
  ,(TYPEOF(Template.UPIN))Health_Provider_Services.Fields.Make_UPIN																											((SALT29.StrType)Input_UPIN)
  ,(TYPEOF(Template.DID))Health_Provider_Services.Fields.Make_DID																												((SALT29.StrType)Input_DID)
  ,(TYPEOF(Template.BDID))Health_Provider_Services.Fields.Make_BDID																											((SALT29.StrType)Input_BDID)
  ,(TYPEOF(Template.SRC))Health_Provider_Services.Fields.Make_SRC																												((SALT29.StrType)Input_SRC)
  ,(TYPEOF(Template.SOURCE_RID))Health_Provider_Services.Fields.Make_SOURCE_RID																					((SALT29.StrType)Input_SOURCE_RID)
  ,(TYPEOF(Template.RID))Health_Provider_Services.Fields.Make_RID																												((SALT29.StrType)Input_RID)
  ,(TYPEOF(Template.MAINNAME))Health_Provider_Services.Fields.Make_MAINNAME																							((SALT29.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.FULLNAME))Health_Provider_Services.Fields.Make_FULLNAME																							((SALT29.StrType)Input_FULLNAME)
  ,(TYPEOF(Template.ADDR1))Health_Provider_Services.Fields.Make_ADDR1																										((SALT29.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))Health_Provider_Services.Fields.Make_LOCALE																									((SALT29.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRESS))Health_Provider_Services.Fields.Make_ADDRESS																								((SALT29.StrType)Input_ADDRESS)
  ,RecordsOnly,FullMatch,e_LNPID}],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);
  pm := Health_Provider_Services.MEOW_xLNPID(Input_Data); // This module performs regular xLNPID functions
	ds := pm.Data_;
	
	Result := MAP(Input_SortBy = 'RID' 						=> sort(ds, -weight, LNPID, rid,record),
								Input_SortBy = 'Source'					=> sort(ds, -weight, LNPID, src,record),
								Input_SortBy = 'FirstSeenDate'	=> sort(ds, -weight, LNPID, (unsigned4)(((string)dt_first_seen)[1..6]),record),
								Input_SortBy = 'LastSeenDate' 	=> sort(ds, -weight, LNPID, (unsigned4)(((string)dt_last_seen)[1..6]),record),
								Input_SortBy = 'ADDRIndicator' 	=> sort(ds, -weight, LNPID, map(addr_flag = 'O' => 1,addr_flag = 'G' => 2,addr_flag = 'F' => 3,addr_flag = 'B' => 4,addr_flag = 'M' => 5,6),record),
								Input_SortBy = 'LICIndicator' 	=> sort(ds, -weight, LNPID, map(c_lic_nbr_flag = 'O' => 1,c_lic_nbr_flag = 'G' => 2,c_lic_nbr_flag = 'F' => 3,c_lic_nbr_flag = 'B' => 4,c_lic_nbr_flag = 'M' => 5,6),record),
								Input_SortBy = 'DOBIndicator' 	=> sort(ds, -weight, LNPID, map(dob_flag = 'O' => 1,dob_flag = 'G' => 2,dob_flag = 'F' => 3,dob_flag = 'B' => 4,dob_flag = 'M' => 5,6),record),
								Input_SortBy = 'NPIIndicator' 	=> sort(ds, -weight, LNPID, map(npi_number_flag = 'O' => 1,npi_number_flag = 'G' => 2,npi_number_flag = 'F' => 3,npi_number_flag = 'B' => 4,npi_number_flag = 'M' => 5,6),record),								
								Input_SortBy = 'DEAIndicator' 	=> sort(ds, -weight, LNPID, map(dea_number_flag = 'O' => 1,dea_number_flag = 'G' => 2,dea_number_flag = 'F' => 3,dea_number_flag = 'B' => 4,dea_number_flag = 'M' => 5,6),record),																	
								Input_SortBy = 'UPINIndicator' 	=> sort(ds, -weight, LNPID, map(upin_flag = 'O' => 1,upin_flag = 'G' => 2,upin_flag = 'F' => 3,upin_flag = 'B' => 4,upin_flag = 'M' => 5,6),record),																	
								Input_SortBy = 'DID' 						=> sort(ds, -weight, LNPID, map(did_flag = 'O' => 1,did_flag = 'G' => 2,did_flag = 'F' => 3,did_flag = 'B' => 4,did_flag = 'M' => 5,6),record),
								Input_SortBy = 'LastName'				=> sort(ds, -weight, LNPID, lname,record),
								Input_SortBy = 'City'						=> sort(ds, -weight, LNPID, v_city_name,record),
								Input_SortBy = 'SSN'						=> sort(ds, -weight, LNPID, -ssn,record),
								Input_SortBy = 'Gender'					=> sort(ds, -weight, LNPID, -Gender,record),
																									 sort(ds, -weight, LNPID,record));

	recCount := {integer Total_Records};	
	OUTPUT	(DATASET([{COUNT(Result)}], recCount),named('RecordCount'));	
	OUTPUT(Input_Data,NAMED('Input_Data'));
	Trim_Result := PROJECT (Result,Health_Provider_Services.Layouts.Trimmed_Layout);
	OUTPUT(Trim_Result,NAMED('Trim_Result'));
	OUTPUT (pm.Raw_Results,NAMED('Raw_Results'));
  OUTPUT(Result,NAMED('Header_Data'));
ENDMACRO;
