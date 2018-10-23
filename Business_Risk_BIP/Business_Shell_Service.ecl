/*--SOAP--
<message name="Business_Shell_Service" wuTimeout="300000">
	<part name="Seq" type="xsd:integer"/>
	<part name="AcctNo" type="xsd:string"/>
	<!-- Company SearchBy Fields --> 
	<part name="CompanyName" type="xsd:string"/>
	<part name="AltCompanyName" type="xsd:string"/>
	<part name="StreetAddress1" type="xsd:string"/>
	<part name="StreetAddress2" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip9" type="xsd:string"/>
	<part name="Prim_Range" type="xsd:string"/>
	<part name="PreDir" type="xsd:string"/>
	<part name="Prim_Name" type="xsd:string"/>
	<part name="Addr_Suffix" type="xsd:string"/>
	<part name="PostDir" type="xsd:string"/>
	<part name="Unit_Desig" type="xsd:string"/>
	<part name="Sec_Range" type="xsd:string"/>
	<part name="Zip5" type="xsd:string"/>
	<part name="Zip4" type="xsd:string"/>
	<part name="Lat" type="xsd:string"/>
	<part name="Long" type="xsd:string"/>
	<part name="Addr_Type" type="xsd:string"/> 
	<part name="Addr_Status" type="xsd:string"/>
	<part name="County" type="xsd:string"/>
	<part name="Geo_Block" type="xsd:string"/>
	<part name="FEIN" type="xsd:string"/>
	<part name="Phone10" type="xsd:string"/>
	<part name="IPAddr" type="xsd:string"/>
	<part name="CompanyURL" type="xsd:string"/>

	<part name="SIC_Code" type="xsd:string"/>
	<part name="NAIC_Code" type="xsd:string"/>
	<part name="Bus_LexID" type="xsd:integer"/>
	<part name="Bus_Structure" type="xsd:string"/>
	<part name="Years_in_Business" type="xsd:string"/>
	<part name="Bus_Start_Date" type="xsd:string"/>
	<part name="Yearly_Revenue" type="xsd:string"/>
	<part name="Fax_Number" type="xsd:string"/>

	<!-- Authorized Representative SearchBy Fields --> 
	<part name="Rep_FullName" type="xsd:string"/>
	<part name="Rep_NameTitle" type="xsd:string"/>
	<part name="Rep_FirstName" type="xsd:string"/>
	<part name="Rep_MiddleName" type="xsd:string"/>
	<part name="Rep_LastName" type="xsd:string"/>
	<part name="Rep_NameSuffix" type="xsd:string"/>
	<part name="Rep_FormerLastName" type="xsd:string"/>
	<part name="Rep_StreetAddress1" type="xsd:string"/>
	<part name="Rep_StreetAddress2" type="xsd:string"/>
	<part name="Rep_City" type="xsd:string"/>
	<part name="Rep_State" type="xsd:string"/>
	<part name="Rep_Zip" type="xsd:string"/>
	<part name="Rep_Prim_Range" type="xsd:string"/>
	<part name="Rep_PreDir" type="xsd:string"/>
	<part name="Rep_Prim_Name" type="xsd:string"/>
	<part name="Rep_Addr_Suffix" type="xsd:string"/>
	<part name="Rep_PostDir" type="xsd:string"/>
	<part name="Rep_Unit_Desig" type="xsd:string"/>
	<part name="Rep_Sec_Range" type="xsd:string"/>
	<part name="Rep_Zip5" type="xsd:string"/>
	<part name="Rep_Zip4" type="xsd:string"/>
	<part name="Rep_Lat" type="xsd:string"/>
	<part name="Rep_Long" type="xsd:string"/>
	<part name="Rep_Addr_Type" type="xsd:string"/>
	<part name="Rep_Addr_Status" type="xsd:string"/>
	<part name="Rep_County" type="xsd:string"/>
	<part name="Rep_Geo_Block" type="xsd:string"/>
	<part name="Rep_SSN" type="xsd:string"/>
	<part name="Rep_DateOfBirth" type="xsd:string"/>
	<part name="Rep_Phone10" type="xsd:string"/>
	<part name="Rep_Age" type="xsd:string"/>
	<part name="Rep_DLNumber" type="xsd:string"/>
	<part name="Rep_DLState" type="xsd:string"/>
	<part name="Rep_Email" type="xsd:string"/>
	<part name="Rep_LexID" type="xsd:integer"/>
	<part name="Rep_BusinessTitle" type="xsd:string"/>
  	<!-- Authorized Representative 2 SearchBy Fields --> 
	<part name="Rep2_FullName" type="xsd:string"/>
	<part name="Rep2_NameTitle" type="xsd:string"/>
	<part name="Rep2_FirstName" type="xsd:string"/>
	<part name="Rep2_MiddleName" type="xsd:string"/>
	<part name="Rep2_LastName" type="xsd:string"/>
	<part name="Rep2_NameSuffix" type="xsd:string"/>
	<part name="Rep2_FormerLastName" type="xsd:string"/>
	<part name="Rep2_StreetAddress1" type="xsd:string"/>
	<part name="Rep2_StreetAddress2" type="xsd:string"/>
	<part name="Rep2_City" type="xsd:string"/>
	<part name="Rep2_State" type="xsd:string"/>
	<part name="Rep2_Zip" type="xsd:string"/>
	<part name="Rep2_Prim_Range" type="xsd:string"/>
	<part name="Rep2_PreDir" type="xsd:string"/>
	<part name="Rep2_Prim_Name" type="xsd:string"/>
	<part name="Rep2_Addr_Suffix" type="xsd:string"/>
	<part name="Rep2_PostDir" type="xsd:string"/>
	<part name="Rep2_Unit_Desig" type="xsd:string"/>
	<part name="Rep2_Sec_Range" type="xsd:string"/>
	<part name="Rep2_Zip5" type="xsd:string"/>
	<part name="Rep2_Zip4" type="xsd:string"/>
	<part name="Rep2_Lat" type="xsd:string"/>
	<part name="Rep2_Long" type="xsd:string"/>
	<part name="Rep2_Addr_Type" type="xsd:string"/>
	<part name="Rep2_Addr_Status" type="xsd:string"/>
	<part name="Rep2_County" type="xsd:string"/>
	<part name="Rep2_Geo_Block" type="xsd:string"/>
	<part name="Rep2_SSN" type="xsd:string"/>
	<part name="Rep2_DateOfBirth" type="xsd:string"/>
	<part name="Rep2_Phone10" type="xsd:string"/>
	<part name="Rep2_Age" type="xsd:string"/>
	<part name="Rep2_DLNumber" type="xsd:string"/>
	<part name="Rep2_DLState" type="xsd:string"/>
	<part name="Rep2_Email" type="xsd:string"/>
	<part name="Rep2_LexID" type="xsd:integer"/>
  <part name="Rep2_BusinessTitle" type="xsd:string"/>
  	<!-- Authorized Representative 3 SearchBy Fields --> 
	<part name="Rep3_FullName" type="xsd:string"/>
	<part name="Rep3_NameTitle" type="xsd:string"/>
	<part name="Rep3_FirstName" type="xsd:string"/>
	<part name="Rep3_MiddleName" type="xsd:string"/>
	<part name="Rep3_LastName" type="xsd:string"/>
	<part name="Rep3_NameSuffix" type="xsd:string"/>
	<part name="Rep3_FormerLastName" type="xsd:string"/>
	<part name="Rep3_StreetAddress1" type="xsd:string"/>
	<part name="Rep3_StreetAddress2" type="xsd:string"/>
	<part name="Rep3_City" type="xsd:string"/>
	<part name="Rep3_State" type="xsd:string"/>
	<part name="Rep3_Zip" type="xsd:string"/>
	<part name="Rep3_Prim_Range" type="xsd:string"/>
	<part name="Rep3_PreDir" type="xsd:string"/>
	<part name="Rep3_Prim_Name" type="xsd:string"/>
	<part name="Rep3_Addr_Suffix" type="xsd:string"/>
	<part name="Rep3_PostDir" type="xsd:string"/>
	<part name="Rep3_Unit_Desig" type="xsd:string"/>
	<part name="Rep3_Sec_Range" type="xsd:string"/>
	<part name="Rep3_Zip5" type="xsd:string"/>
	<part name="Rep3_Zip4" type="xsd:string"/>
	<part name="Rep3_Lat" type="xsd:string"/>
	<part name="Rep3_Long" type="xsd:string"/>
	<part name="Rep3_Addr_Type" type="xsd:string"/>
	<part name="Rep3_Addr_Status" type="xsd:string"/>
	<part name="Rep3_County" type="xsd:string"/>
	<part name="Rep3_Geo_Block" type="xsd:string"/>
	<part name="Rep3_SSN" type="xsd:string"/>
	<part name="Rep3_DateOfBirth" type="xsd:string"/>
	<part name="Rep3_Phone10" type="xsd:string"/>
	<part name="Rep3_Age" type="xsd:string"/>
	<part name="Rep3_DLNumber" type="xsd:string"/>
	<part name="Rep3_DLState" type="xsd:string"/>
	<part name="Rep3_Email" type="xsd:string"/>
	<part name="Rep3_LexID" type="xsd:integer"/>
  <part name="Rep3_BusinessTitle" type="xsd:string"/>
<!-- Authorized Representative 4 SearchBy Fields --> 
	<part name="Rep4_FullName" type="xsd:string"/>
	<part name="Rep4_NameTitle" type="xsd:string"/>
	<part name="Rep4_FirstName" type="xsd:string"/>
	<part name="Rep4_MiddleName" type="xsd:string"/>
	<part name="Rep4_LastName" type="xsd:string"/>
	<part name="Rep4_NameSuffix" type="xsd:string"/>
	<part name="Rep4_FormerLastName" type="xsd:string"/>
	<part name="Rep4_StreetAddress1" type="xsd:string"/>
	<part name="Rep4_StreetAddress2" type="xsd:string"/>
	<part name="Rep4_City" type="xsd:string"/>
	<part name="Rep4_State" type="xsd:string"/>
	<part name="Rep4_Zip" type="xsd:string"/>
	<part name="Rep4_Prim_Range" type="xsd:string"/>
	<part name="Rep4_PreDir" type="xsd:string"/>
	<part name="Rep4_Prim_Name" type="xsd:string"/>
	<part name="Rep4_Addr_Suffix" type="xsd:string"/>
	<part name="Rep4_PostDir" type="xsd:string"/>
	<part name="Rep4_Unit_Desig" type="xsd:string"/>
	<part name="Rep4_Sec_Range" type="xsd:string"/>
	<part name="Rep4_Zip5" type="xsd:string"/>
	<part name="Rep4_Zip4" type="xsd:string"/>
	<part name="Rep4_Lat" type="xsd:string"/>
	<part name="Rep4_Long" type="xsd:string"/>
	<part name="Rep4_Addr_Type" type="xsd:string"/>
	<part name="Rep4_Addr_Status" type="xsd:string"/>
	<part name="Rep4_County" type="xsd:string"/>
	<part name="Rep4_Geo_Block" type="xsd:string"/>
	<part name="Rep4_SSN" type="xsd:string"/>
	<part name="Rep4_DateOfBirth" type="xsd:string"/>
	<part name="Rep4_Phone10" type="xsd:string"/>
	<part name="Rep4_Age" type="xsd:string"/>
	<part name="Rep4_DLNumber" type="xsd:string"/>
	<part name="Rep4_DLState" type="xsd:string"/>
	<part name="Rep4_Email" type="xsd:string"/>
	<part name="Rep4_LexID" type="xsd:integer"/>
  <part name="Rep4_BusinessTitle" type="xsd:string"/>
	<!-- Authorized Representative 5 SearchBy Fields --> 
	<part name="Rep5_FullName" type="xsd:string"/>
	<part name="Rep5_NameTitle" type="xsd:string"/>
	<part name="Rep5_FirstName" type="xsd:string"/>
	<part name="Rep5_MiddleName" type="xsd:string"/>
	<part name="Rep5_LastName" type="xsd:string"/>
	<part name="Rep5_NameSuffix" type="xsd:string"/>
	<part name="Rep5_FormerLastName" type="xsd:string"/>
	<part name="Rep5_StreetAddress1" type="xsd:string"/>
	<part name="Rep5_StreetAddress2" type="xsd:string"/>
	<part name="Rep5_City" type="xsd:string"/>
	<part name="Rep5_State" type="xsd:string"/>
	<part name="Rep5_Zip" type="xsd:string"/>
	<part name="Rep5_Prim_Range" type="xsd:string"/>
	<part name="Rep5_PreDir" type="xsd:string"/>
	<part name="Rep5_Prim_Name" type="xsd:string"/>
	<part name="Rep5_Addr_Suffix" type="xsd:string"/>
	<part name="Rep5_PostDir" type="xsd:string"/>
	<part name="Rep5_Unit_Desig" type="xsd:string"/>
	<part name="Rep5_Sec_Range" type="xsd:string"/>
	<part name="Rep5_Zip5" type="xsd:string"/>
	<part name="Rep5_Zip4" type="xsd:string"/>
	<part name="Rep5_Lat" type="xsd:string"/>
	<part name="Rep5_Long" type="xsd:string"/>
	<part name="Rep5_Addr_Type" type="xsd:string"/>
	<part name="Rep5_Addr_Status" type="xsd:string"/>
	<part name="Rep5_County" type="xsd:string"/>
	<part name="Rep5_Geo_Block" type="xsd:string"/>
	<part name="Rep5_SSN" type="xsd:string"/>
	<part name="Rep5_DateOfBirth" type="xsd:string"/>
	<part name="Rep5_Phone10" type="xsd:string"/>
	<part name="Rep5_Age" type="xsd:string"/>
	<part name="Rep5_DLNumber" type="xsd:string"/>
	<part name="Rep5_DLState" type="xsd:string"/>
	<part name="Rep5_Email" type="xsd:string"/>
	<part name="Rep5_LexID" type="xsd:integer"/>
  <part name="Rep5_BusinessTitle" type="xsd:string"/>

 <part name="CorteraRetrotestRecords" type="tns:XmlDataSet" cols="110" rows="75"/>
	
	<!-- Option Fields --> 
	<part name="DPPA_Purpose" type="xsd:integer"/>
	<part name="GLBA_Purpose" type="xsd:integer"/>
	<part name="Data_Restriction_Mask" type="xsd:string"/>
	<part name="Data_Permission_Mask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDate" type="xsd:integer"/>
	<part name="LinkSearchLevel" type="xsd:integer"/>
	<part name="MarketingMode" type="xsd:integer"/>
	<part name="BusShellVersion" type="xsd:integer"/>
	<part name="PowID" type="xsd:integer"/>
	<part name="ProxID" type="xsd:integer"/>
	<part name="SeleID" type="xsd:integer"/>
	<part name="OrgID" type="xsd:integer"/>
	<part name="UltID" type="xsd:integer"/>
	<part name="AllowedSources" type="xsd:string"/>
	<part name="BIPBestAppend" type="xsd:integer"/>
  <part name="OFAC_Version" type="xsd:integer"/>
  <part name="Global_Watchlist_Threshold" type="xsd:real"/>
  <part name="Watchlists_Requested" type="tns:XmlDataSet" cols="90" rows="10"/>
  <part name="KeepLargeBusinesses" type="xsd:integer"/>
	<part name="IncludeTargusGateway" type="xsd:boolean"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="RunTargusGatewayAnywayForTesting" type="xsd:boolean"/>
	<part name="OverrideExperianRestriction" type="xsd:boolean"/>
	<part name="IncludeAuthRepInBIPAppend" type="xsd:boolean"/>
	<part name="CorteraRetrotest" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Business Shell Service - This is the XML Service utilizing BIP linking. */

#option('expandSelectCreateRow', true);
IMPORT Business_Risk_BIP, Cortera, Gateway, iesp, UT, Risk_Indicators, OFAC_XG5;

EXPORT Business_Shell_Service() := FUNCTION
	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'Seq',
	'AcctNo',
	'CompanyName',
	'AltCompanyName',
	'StreetAddress1',
	'StreetAddress2',
	'City',
	'State',
	'Zip9',
	'Prim_Range',
	'PreDir',
	'Prim_Name',
	'Addr_Suffix',
	'PostDir',
	'Unit_Desig',
	'Sec_Range',
	'Zip5',
	'Zip4',
	'Lat',
	'Long',
	'Addr_Type' ,
	'Addr_Status',
	'County',
	'Geo_Block',
	'FEIN',
	'Phone10',
	'IPAddr',
	'CompanyURL',
	'SIC_Code',
	'NAIC_Code',
	'Bus_LexID',
	'Bus_Structure',
	'Years_in_Business',
	'Bus_Start_Date',
	'Yearly_Revenue',
	'Fax_Number',
	'Rep_FullName',
	'Rep_NameTitle',
	'Rep_FirstName',
	'Rep_MiddleName',
	'Rep_LastName',
	'Rep_NameSuffix',
	'Rep_FormerLastName',
	'Rep_StreetAddress1',
	'Rep_StreetAddress2',
	'Rep_City',
	'Rep_State',
	'Rep_Zip',
	'Rep_Prim_Range',
	'Rep_PreDir',
	'Rep_Prim_Name',
	'Rep_Addr_Suffix',
	'Rep_PostDir',
	'Rep_Unit_Desig',
	'Rep_Sec_Range',
	'Rep_Zip5',
	'Rep_Zip4',
	'Rep_Lat',
	'Rep_Long',
	'Rep_Addr_Type',
	'Rep_Addr_Status',
	'Rep_County',
	'Rep_Geo_Block',
	'Rep_SSN',
	'Rep_DateOfBirth',
	'Rep_Phone10',
	'Rep_Age',
	'Rep_DLNumber',
	'Rep_DLState',
	'Rep_Email',
	'Rep_LexID',
	'Rep_BusinessTitle',
	'Rep2_FullName',
	'Rep2_NameTitle',
	'Rep2_FirstName',
	'Rep2_MiddleName',
	'Rep2_LastName',
	'Rep2_NameSuffix',
	'Rep2_FormerLastName',
	'Rep2_StreetAddress1',
	'Rep2_StreetAddress2',
	'Rep2_City',
	'Rep2_State',
	'Rep2_Zip',
	'Rep2_Prim_Range',
	'Rep2_PreDir',
	'Rep2_Prim_Name',
	'Rep2_Addr_Suffix',
	'Rep2_PostDir',
	'Rep2_Unit_Desig',
	'Rep2_Sec_Range',
	'Rep2_Zip5',
	'Rep2_Zip4',
	'Rep2_Lat',
	'Rep2_Long',
	'Rep2_Addr_Type',
	'Rep2_Addr_Status',
	'Rep2_County',
	'Rep2_Geo_Block',
	'Rep2_SSN',
	'Rep2_DateOfBirth',
	'Rep2_Phone10',
	'Rep2_Age',
	'Rep2_DLNumber',
	'Rep2_DLState',
	'Rep2_Email',
	'Rep2_LexID',
	'Rep2_BusinessTitle',
	'Rep3_FullName',
	'Rep3_NameTitle',
	'Rep3_FirstName',
	'Rep3_MiddleName',
	'Rep3_LastName',
	'Rep3_NameSuffix',
	'Rep3_FormerLastName',
	'Rep3_StreetAddress1',
	'Rep3_StreetAddress2',
	'Rep3_City',
	'Rep3_State',
	'Rep3_Zip',
	'Rep3_Prim_Range',
	'Rep3_PreDir',
	'Rep3_Prim_Name',
	'Rep3_Addr_Suffix',
	'Rep3_PostDir',
	'Rep3_Unit_Desig',
	'Rep3_Sec_Range',
	'Rep3_Zip5',
	'Rep3_Zip4',
	'Rep3_Lat',
	'Rep3_Long',
	'Rep3_Addr_Type',
	'Rep3_Addr_Status',
	'Rep3_County',
	'Rep3_Geo_Block',
	'Rep3_SSN',
	'Rep3_DateOfBirth',
	'Rep3_Phone10',
	'Rep3_Age',
	'Rep3_DLNumber',
	'Rep3_DLState',
	'Rep3_Email',
	'Rep3_LexID',
	'Rep3_BusinessTitle',
	'Rep4_FullName',
	'Rep4_NameTitle',
	'Rep4_FirstName',
	'Rep4_MiddleName',
	'Rep4_LastName',
	'Rep4_NameSuffix',
	'Rep4_FormerLastName',
	'Rep4_StreetAddress1',
	'Rep4_StreetAddress2',
	'Rep4_City',
	'Rep4_State',
	'Rep4_Zip',
	'Rep4_Prim_Range',
	'Rep4_PreDir',
	'Rep4_Prim_Name',
	'Rep4_Addr_Suffix',
	'Rep4_PostDir',
	'Rep4_Unit_Desig',
	'Rep4_Sec_Range',
	'Rep4_Zip5',
	'Rep4_Zip4',
	'Rep4_Lat',
	'Rep4_Long',
	'Rep4_Addr_Type',
	'Rep4_Addr_Status',
	'Rep4_County',
	'Rep4_Geo_Block',
	'Rep4_SSN',
	'Rep4_DateOfBirth',
	'Rep4_Phone10',
	'Rep4_Age',
	'Rep4_DLNumber',
	'Rep4_DLState',
	'Rep4_Email',
	'Rep4_LexID',
	'Rep4_BusinessTitle',
	'Rep5_FullName',
	'Rep5_NameTitle',
	'Rep5_FirstName',
	'Rep5_MiddleName',
	'Rep5_LastName',
	'Rep5_NameSuffix',
	'Rep5_FormerLastName',
	'Rep5_StreetAddress1',
	'Rep5_StreetAddress2',
	'Rep5_City',
	'Rep5_State',
	'Rep5_Zip',
	'Rep5_Prim_Range',
	'Rep5_PreDir',
	'Rep5_Prim_Name',
	'Rep5_Addr_Suffix',
	'Rep5_PostDir',
	'Rep5_Unit_Desig',
	'Rep5_Sec_Range',
	'Rep5_Zip5',
	'Rep5_Zip4',
	'Rep5_Lat',
	'Rep5_Long',
	'Rep5_Addr_Type',
	'Rep5_Addr_Status',
	'Rep5_County',
	'Rep5_Geo_Block',
	'Rep5_SSN',
	'Rep5_DateOfBirth',
	'Rep5_Phone10',
	'Rep5_Age',
	'Rep5_DLNumber',
	'Rep5_DLState',
	'Rep5_Email',
	'Rep5_LexID',
	'Rep5_BusinessTitle',
	'DPPA_Purpose',
	'GLBA_Purpose',
	'Data_Restriction_Mask',
	'Data_Permission_Mask',
	'IndustryClass',
	'HistoryDate',
	'LinkSearchLevel',
	'MarketingMode',
	'BusShellVersion',
	'PowID',
	'ProxID',
	'SeleID',
	'OrgID',
	'UltID',
	'AllowedSources',
	'BIPBestAppend',
	'OFAC_Version',
	'Global_Watchlist_Threshold',
	'Watchlists_Requested',
	'KeepLargeBusinesses',
	'IncludeTargusGateway',
	'Gateways',
	'RunTargusGatewayAnywayForTesting',
	'OverrideExperianRestriction',
	'IncludeAuthRepInBIPAppend'
	));
	
	/* ************************************************************************
	 *                          Grab service inputs                           *
	 ************************************************************************ */
	UNSIGNED4	Seq                  := 0  : STORED('Seq');
	STRING30	AcctNo               := '' : STORED('AcctNo');
	// Company Fields
	STRING120	CompanyName          := '' : STORED('CompanyName');
	STRING120	AltCompanyName       := '' : STORED('AltCompanyName');
	STRING120	StreetAddress1       := '' : STORED('StreetAddress1');
	STRING120	StreetAddress2       := '' : STORED('StreetAddress2');
	STRING25	City                 := '' : STORED('City');
	STRING2		State                := '' : STORED('State');
	STRING9		Zip9                 := '' : STORED('Zip9');
	STRING10	Prim_Range           := '' : STORED('Prim_Range');
	STRING2		PreDir               := '' : STORED('PreDir');
	STRING28	Prim_Name            := '' : STORED('Prim_Name');
	STRING4		Addr_Suffix          := '' : STORED('Addr_Suffix');
	STRING2		PostDir              := '' : STORED('PostDir');
	STRING10	Unit_Desig           := '' : STORED('Unit_Desig');
	STRING8		Sec_Range            := '' : STORED('Sec_Range');
	STRING5		Zip5                 := '' : STORED('Zip5');
	STRING4		Zip4                 := '' : STORED('Zip4');
	STRING10	Lat                  := '' : STORED('Lat');
	STRING11	Long                 := '' : STORED('Long');
	STRING1		Addr_Type            := '' : STORED('Addr_Type');
	STRING4		Addr_Status          := '' : STORED('Addr_Status');
	STRING30	County               := '' : STORED('County');
	STRING7		Geo_Block            := '' : STORED('Geo_Block');
	STRING11	FEIN                 := '' : STORED('FEIN'); // Need to keep this at 11 to match AutoStandardI.GlobalModule and avoid compile errors even though we only allow 9
	STRING10	Phone10              := '' : STORED('Phone10');
	STRING45	IPAddr               := '' : STORED('IPAddr');
	STRING120	CompanyURL           := '' : STORED('CompanyURL');
	STRING10   SIC_Code              := '' : STORED('SIC_Code');
	STRING10   NAIC_Code              := '' : STORED('NAIC_Code');
	UNSIGNED6  Bus_LexID             := 0 : STORED('Bus_LexID');
	STRING60   Bus_Structure         := '' : STORED('Bus_Structure');
	STRING5   	Years_in_Business     := '' : STORED('Years_in_Business');
	STRING8    Bus_Start_Date        := '' : STORED('Bus_Start_Date');
	STRING9    Yearly_Revenue         := '' : STORED('Yearly_Revenue');
	STRING10   Fax_Number            := '' : STORED('Fax_Number');
	// Authorized Representative Fields
	STRING120	Rep_FullName         := '' : STORED('Rep_FullName');
	STRING5		Rep_NameTitle        := '' : STORED('Rep_NameTitle');
	STRING20	Rep_FirstName        := '' : STORED('Rep_FirstName');
	STRING20	Rep_MiddleName       := '' : STORED('Rep_MiddleName');
	STRING20	Rep_LastName         := '' : STORED('Rep_LastName');
	STRING5		Rep_NameSuffix       := '' : STORED('Rep_NameSuffix');
	STRING20	Rep_FormerLastName   := '' : STORED('Rep_FormerLastName');
	STRING120	Rep_StreetAddress1   := '' : STORED('Rep_StreetAddress1');
	STRING120	Rep_StreetAddress2   := '' : STORED('Rep_StreetAddress2');
	STRING25	Rep_City             := '' : STORED('Rep_City');
	STRING2		Rep_State            := '' : STORED('Rep_State');
	STRING9		Rep_Zip              := '' : STORED('Rep_Zip');
	STRING10	Rep_Prim_Range       := '' : STORED('Rep_Prim_Range');
	STRING2		Rep_PreDir           := '' : STORED('Rep_PreDir');
	STRING28	Rep_Prim_Name        := '' : STORED('Rep_Prim_Name');
	STRING4		Rep_Addr_Suffix      := '' : STORED('Rep_Addr_Suffix');
	STRING2		Rep_PostDir          := '' : STORED('Rep_PostDir');
	STRING10	Rep_Unit_Desig       := '' : STORED('Rep_Unit_Desig');
	STRING8		Rep_Sec_Range        := '' : STORED('Rep_Sec_Range');
	STRING5		Rep_Zip5             := '' : STORED('Rep_Zip5');
	STRING4		Rep_Zip4             := '' : STORED('Rep_Zip4');
	STRING10	Rep_Lat              := '' : STORED('Rep_Lat');
	STRING11	Rep_Long             := '' : STORED('Rep_Long');
	STRING1		Rep_Addr_Type        := '' : STORED('Rep_Addr_Type');
	STRING4		Rep_Addr_Status      := '' : STORED('Rep_Addr_Status');
	STRING3		Rep_County           := '' : STORED('Rep_County');
	STRING7		Rep_Geo_Block        := '' : STORED('Rep_Geo_Block');
	STRING9		Rep_SSN              := '' : STORED('Rep_SSN');
	STRING8		Rep_DateOfBirth      := '' : STORED('Rep_DateOfBirth');
	STRING10	Rep_Phone10          := '' : STORED('Rep_Phone10');
	STRING3		Rep_Age              := '' : STORED('Rep_Age');
	STRING25	Rep_DLNumber         := '' : STORED('Rep_DLNumber');
	STRING2		Rep_DLState          := '' : STORED('Rep_DLState');
	STRING100	Rep_Email            := '' : STORED('Rep_Email');
	UNSIGNED6	Rep_LexID            := 0  : STORED('Rep_LexID');
	STRING50			Rep_BusinessTitle  := ''  : STORED('Rep_BusinessTitle');
	// Authorized Representative 2 Fields
	STRING120	Rep2_FullName         := '' : STORED('Rep2_FullName');
	STRING5		Rep2_NameTitle        := '' : STORED('Rep2_NameTitle');
	STRING20	Rep2_FirstName        := '' : STORED('Rep2_FirstName');
	STRING20	Rep2_MiddleName       := '' : STORED('Rep2_MiddleName');
	STRING20	Rep2_LastName         := '' : STORED('Rep2_LastName');
	STRING5		Rep2_NameSuffix       := '' : STORED('Rep2_NameSuffix');
	STRING20	Rep2_FormerLastName   := '' : STORED('Rep2_FormerLastName');
	STRING120	Rep2_StreetAddress1   := '' : STORED('Rep2_StreetAddress1');
	STRING120	Rep2_StreetAddress2   := '' : STORED('Rep2_StreetAddress2');
	STRING25	Rep2_City             := '' : STORED('Rep2_City');
	STRING2		Rep2_State            := '' : STORED('Rep2_State');
	STRING9		Rep2_Zip              := '' : STORED('Rep2_Zip');
	STRING10	Rep2_Prim_Range       := '' : STORED('Rep2_Prim_Range');
	STRING2		Rep2_PreDir           := '' : STORED('Rep2_PreDir');
	STRING28	Rep2_Prim_Name        := '' : STORED('Rep2_Prim_Name');
	STRING4		Rep2_Addr_Suffix      := '' : STORED('Rep2_Addr_Suffix');
	STRING2		Rep2_PostDir          := '' : STORED('Rep2_PostDir');
	STRING10	Rep2_Unit_Desig       := '' : STORED('Rep2_Unit_Desig');
	STRING8		Rep2_Sec_Range        := '' : STORED('Rep2_Sec_Range');
	STRING5		Rep2_Zip5             := '' : STORED('Rep2_Zip5');
	STRING4		Rep2_Zip4             := '' : STORED('Rep2_Zip4');
	STRING10	Rep2_Lat              := '' : STORED('Rep2_Lat');
	STRING11	Rep2_Long             := '' : STORED('Rep2_Long');
	STRING1		Rep2_Addr_Type        := '' : STORED('Rep2_Addr_Type');
	STRING4		Rep2_Addr_Status      := '' : STORED('Rep2_Addr_Status');
	STRING3		Rep2_County           := '' : STORED('Rep2_County');
	STRING7		Rep2_Geo_Block        := '' : STORED('Rep2_Geo_Block');
	STRING9		Rep2_SSN              := '' : STORED('Rep2_SSN');
	STRING8		Rep2_DateOfBirth      := '' : STORED('Rep2_DateOfBirth');
	STRING10	Rep2_Phone10          := '' : STORED('Rep2_Phone10');
	STRING3		Rep2_Age              := '' : STORED('Rep2_Age');
	STRING25	Rep2_DLNumber         := '' : STORED('Rep2_DLNumber');
	STRING2		Rep2_DLState          := '' : STORED('Rep2_DLState');
	STRING100	Rep2_Email            := '' : STORED('Rep2_Email');
	UNSIGNED6	Rep2_LexID            := 0  : STORED('Rep2_LexID');
	STRING50			Rep2_BusinessTitle  := ''  : STORED('Rep2_BusinessTitle');
	// Authorized Representative 3 Fields
	STRING120	Rep3_FullName         := '' : STORED('Rep3_FullName');
	STRING5		Rep3_NameTitle        := '' : STORED('Rep3_NameTitle');
	STRING20	Rep3_FirstName        := '' : STORED('Rep3_FirstName');
	STRING20	Rep3_MiddleName       := '' : STORED('Rep3_MiddleName');
	STRING20	Rep3_LastName         := '' : STORED('Rep3_LastName');
	STRING5		Rep3_NameSuffix       := '' : STORED('Rep3_NameSuffix');
	STRING20	Rep3_FormerLastName   := '' : STORED('Rep3_FormerLastName');
	STRING120	Rep3_StreetAddress1   := '' : STORED('Rep3_StreetAddress1');
	STRING120	Rep3_StreetAddress2   := '' : STORED('Rep3_StreetAddress2');
	STRING25	Rep3_City             := '' : STORED('Rep3_City');
	STRING2		Rep3_State            := '' : STORED('Rep3_State');
	STRING9		Rep3_Zip              := '' : STORED('Rep3_Zip');
	STRING10	Rep3_Prim_Range       := '' : STORED('Rep3_Prim_Range');
	STRING2		Rep3_PreDir           := '' : STORED('Rep3_PreDir');
	STRING28	Rep3_Prim_Name        := '' : STORED('Rep3_Prim_Name');
	STRING4		Rep3_Addr_Suffix      := '' : STORED('Rep3_Addr_Suffix');
	STRING2		Rep3_PostDir          := '' : STORED('Rep3_PostDir');
	STRING10	Rep3_Unit_Desig       := '' : STORED('Rep3_Unit_Desig');
	STRING8		Rep3_Sec_Range        := '' : STORED('Rep3_Sec_Range');
	STRING5		Rep3_Zip5             := '' : STORED('Rep3_Zip5');
	STRING4		Rep3_Zip4             := '' : STORED('Rep3_Zip4');
	STRING10	Rep3_Lat              := '' : STORED('Rep3_Lat');
	STRING11	Rep3_Long             := '' : STORED('Rep3_Long');
	STRING1		Rep3_Addr_Type        := '' : STORED('Rep3_Addr_Type');
	STRING4		Rep3_Addr_Status      := '' : STORED('Rep3_Addr_Status');
	STRING3		Rep3_County           := '' : STORED('Rep3_County');
	STRING7		Rep3_Geo_Block        := '' : STORED('Rep3_Geo_Block');
	STRING9		Rep3_SSN              := '' : STORED('Rep3_SSN');
	STRING8		Rep3_DateOfBirth      := '' : STORED('Rep3_DateOfBirth');
	STRING10	Rep3_Phone10          := '' : STORED('Rep3_Phone10');
	STRING3		Rep3_Age              := '' : STORED('Rep3_Age');
	STRING25	Rep3_DLNumber         := '' : STORED('Rep3_DLNumber');
	STRING2		Rep3_DLState          := '' : STORED('Rep3_DLState');
	STRING100	Rep3_Email            := '' : STORED('Rep3_Email');
	UNSIGNED6	Rep3_LexID            := 0  : STORED('Rep3_LexID');
	STRING50			Rep3_BusinessTitle  := ''  : STORED('Rep3_BusinessTitle');
	// Authorized Representative 4 Fields
	STRING120	Rep4_FullName         := '' : STORED('Rep4_FullName');
	STRING5		Rep4_NameTitle        := '' : STORED('Rep4_NameTitle');
	STRING20	Rep4_FirstName        := '' : STORED('Rep4_FirstName');
	STRING20	Rep4_MiddleName       := '' : STORED('Rep4_MiddleName');
	STRING20	Rep4_LastName         := '' : STORED('Rep4_LastName');
	STRING5		Rep4_NameSuffix       := '' : STORED('Rep4_NameSuffix');
	STRING20	Rep4_FormerLastName   := '' : STORED('Rep4_FormerLastName');
	STRING120	Rep4_StreetAddress1   := '' : STORED('Rep4_StreetAddress1');
	STRING120	Rep4_StreetAddress2   := '' : STORED('Rep4_StreetAddress2');
	STRING25	Rep4_City             := '' : STORED('Rep4_City');
	STRING2		Rep4_State            := '' : STORED('Rep4_State');
	STRING9		Rep4_Zip              := '' : STORED('Rep4_Zip');
	STRING10	Rep4_Prim_Range       := '' : STORED('Rep4_Prim_Range');
	STRING2		Rep4_PreDir           := '' : STORED('Rep4_PreDir');
	STRING28	Rep4_Prim_Name        := '' : STORED('Rep4_Prim_Name');
	STRING4		Rep4_Addr_Suffix      := '' : STORED('Rep4_Addr_Suffix');
	STRING2		Rep4_PostDir          := '' : STORED('Rep4_PostDir');
	STRING10	Rep4_Unit_Desig       := '' : STORED('Rep4_Unit_Desig');
	STRING8		Rep4_Sec_Range        := '' : STORED('Rep4_Sec_Range');
	STRING5		Rep4_Zip5             := '' : STORED('Rep4_Zip5');
	STRING4		Rep4_Zip4             := '' : STORED('Rep4_Zip4');
	STRING10	Rep4_Lat              := '' : STORED('Rep4_Lat');
	STRING11	Rep4_Long             := '' : STORED('Rep4_Long');
	STRING1		Rep4_Addr_Type        := '' : STORED('Rep4_Addr_Type');
	STRING4		Rep4_Addr_Status      := '' : STORED('Rep4_Addr_Status');
	STRING3		Rep4_County           := '' : STORED('Rep4_County');
	STRING7		Rep4_Geo_Block        := '' : STORED('Rep4_Geo_Block');
	STRING9		Rep4_SSN              := '' : STORED('Rep4_SSN');
	STRING8		Rep4_DateOfBirth      := '' : STORED('Rep4_DateOfBirth');
	STRING10	Rep4_Phone10          := '' : STORED('Rep4_Phone10');
	STRING3		Rep4_Age              := '' : STORED('Rep4_Age');
	STRING25	Rep4_DLNumber         := '' : STORED('Rep4_DLNumber');
	STRING2		Rep4_DLState          := '' : STORED('Rep4_DLState');
	STRING100	Rep4_Email            := '' : STORED('Rep4_Email');
	UNSIGNED6	Rep4_LexID            := 0  : STORED('Rep4_LexID');
	STRING50			Rep4_BusinessTitle  := ''  : STORED('Rep4_BusinessTitle');
	// Authorized Representative 5 Fields
	STRING120	Rep5_FullName         := '' : STORED('Rep5_FullName');
	STRING5		Rep5_NameTitle        := '' : STORED('Rep5_NameTitle');
	STRING20	Rep5_FirstName        := '' : STORED('Rep5_FirstName');
	STRING20	Rep5_MiddleName       := '' : STORED('Rep5_MiddleName');
	STRING20	Rep5_LastName         := '' : STORED('Rep5_LastName');
	STRING5		Rep5_NameSuffix       := '' : STORED('Rep5_NameSuffix');
	STRING20	Rep5_FormerLastName   := '' : STORED('Rep5_FormerLastName');
	STRING120	Rep5_StreetAddress1   := '' : STORED('Rep5_StreetAddress1');
	STRING120	Rep5_StreetAddress2   := '' : STORED('Rep5_StreetAddress2');
	STRING25	Rep5_City             := '' : STORED('Rep5_City');
	STRING2		Rep5_State            := '' : STORED('Rep5_State');
	STRING9		Rep5_Zip              := '' : STORED('Rep5_Zip');
	STRING10	Rep5_Prim_Range       := '' : STORED('Rep5_Prim_Range');
	STRING2		Rep5_PreDir           := '' : STORED('Rep5_PreDir');
	STRING28	Rep5_Prim_Name        := '' : STORED('Rep5_Prim_Name');
	STRING4		Rep5_Addr_Suffix      := '' : STORED('Rep5_Addr_Suffix');
	STRING2		Rep5_PostDir          := '' : STORED('Rep5_PostDir');
	STRING10	Rep5_Unit_Desig       := '' : STORED('Rep5_Unit_Desig');
	STRING8		Rep5_Sec_Range        := '' : STORED('Rep5_Sec_Range');
	STRING5		Rep5_Zip5             := '' : STORED('Rep5_Zip5');
	STRING4		Rep5_Zip4             := '' : STORED('Rep5_Zip4');
	STRING10	Rep5_Lat              := '' : STORED('Rep5_Lat');
	STRING11	Rep5_Long             := '' : STORED('Rep5_Long');
	STRING1		Rep5_Addr_Type        := '' : STORED('Rep5_Addr_Type');
	STRING4		Rep5_Addr_Status      := '' : STORED('Rep5_Addr_Status');
	STRING3		Rep5_County           := '' : STORED('Rep5_County');
	STRING7		Rep5_Geo_Block        := '' : STORED('Rep5_Geo_Block');
	STRING9		Rep5_SSN              := '' : STORED('Rep5_SSN');
	STRING8		Rep5_DateOfBirth      := '' : STORED('Rep5_DateOfBirth');
	STRING10	Rep5_Phone10          := '' : STORED('Rep5_Phone10');
	STRING3		Rep5_Age              := '' : STORED('Rep5_Age');
	STRING25	Rep5_DLNumber         := '' : STORED('Rep5_DLNumber');
	STRING2		Rep5_DLState          := '' : STORED('Rep5_DLState');
	STRING100	Rep5_Email            := '' : STORED('Rep5_Email');
	UNSIGNED6	Rep5_LexID            := 0  : STORED('Rep5_LexID');
	STRING50			Rep5_BusinessTitle  := ''  : STORED('Rep5_BusinessTitle');
  
 ds_CorteraRetrotestRecsRaw := DATASET([], Cortera.layout_Retrotest_raw) : STORED('CorteraRetrotestRecords', FEW);

	// Option Fields
	UNSIGNED1	DPPA_Purpose         := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPA_Purpose');
	UNSIGNED1	GLBA_Purpose         := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBA_Purpose');
	STRING5	IndustryClass_In       := Business_Risk_BIP.Constants.Default_IndustryClass : STORED('IndustryClass');
	IndustryClass := StringLib.StringToUpperCase(TRIM(IndustryClass_In, LEFT, RIGHT));
	STRING50	DataRestrictionMask  := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('Data_Restriction_Mask');
	STRING50	DataPermissionMask   := Business_Risk_BIP.Constants.Default_DataPermissionMask : STORED('Data_Permission_Mask');
	UNSIGNED6	HistoryDate          := 0  : STORED('HistoryDate');
	UNSIGNED1	LinkSearchLevel      := Business_Risk_BIP.Constants.LinkSearch.Default : STORED('LinkSearchLevel');
	UNSIGNED1	MarketingMode        := Business_Risk_BIP.Constants.Default_MarketingMode : STORED('MarketingMode');
	UNSIGNED1	BusShellVersion      := Business_Risk_BIP.Constants.Default_BusShellVersion : STORED('BusShellVersion');
	UNSIGNED6	PowID                := 0  : STORED('PowID');
	UNSIGNED6	ProxID               := 0  : STORED('ProxID');
	UNSIGNED6	SeleID               := 0  : STORED('SeleID');
	UNSIGNED6	OrgID                := 0  : STORED('OrgID');
	UNSIGNED6	UltID                := 0  : STORED('UltID');
	STRING50	AllowedSources       := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
	UNSIGNED1 BIPBestAppend				 := Business_Risk_BIP.Constants.BIPBestAppend.Default : STORED('BIPBestAppend');
  UNSIGNED1 OFAC_Version		     := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	REAL Global_Watchlist_Threshold	:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');
	UNSIGNED1 KeepLargeBusinesses  := Business_Risk_BIP.Constants.DefaultJoinType : STORED('KeepLargeBusinesses');
	BOOLEAN IncludeTargusGateway   := FALSE : STORED('IncludeTargusGateway');
	BOOLEAN RunTargusGateway       := FALSE : STORED('RunTargusGatewayAnywayForTesting');
	BOOLEAN OverrideExperianRestriction := FALSE : STORED('OverrideExperianRestriction');
	BOOLEAN IncludeAuthRepInBIPAppend := FALSE : STORED('IncludeAuthRepInBIPAppend');
	BOOLEAN CorteraRetrotest := FALSE : STORED('CorteraRetrotest');
	
	Gateways := Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus
 
  layout_watchlists_temp := record
    dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
  end;

  watchlist_options := dataset([],layout_watchlists_temp) : stored('Watchlists_Requested', few);
  Watchlists_Requested := watchlist_options[1].WatchList;

	/* ************************************************************************
	 *              Create the Appropriate Library Interface                  *
	 ************************************************************************ */
	// NOTE: If you change this you MUST redeploy the Library as the interface has changed.
	Business_Risk_BIP.Layouts.Input grabInput() := TRANSFORM
		SELF.Seq := Seq;
		SELF.AcctNo := AcctNo;
		SELF.CompanyName := CompanyName;
		SELF.AltCompanyName := AltCompanyName;
		SELF.StreetAddress1 := StreetAddress1;
		SELF.StreetAddress2 := StreetAddress2;
		SELF.City := City;
		SELF.State := State;
		SELF.Zip := IF(TRIM(Zip9) <> '', Zip9, TRIM(Zip5 + Zip4, LEFT, RIGHT));
		SELF.Prim_Range := Prim_Range;
		SELF.PreDir := PreDir;
		SELF.Prim_Name := Prim_Name;
		SELF.Addr_Suffix := Addr_Suffix;
		SELF.PostDir := PostDir;
		SELF.Unit_Desig := Unit_Desig;
		SELF.Sec_Range := Sec_Range;
		SELF.Zip5 := Zip5;
		SELF.Zip4 := Zip4;
		SELF.Lat := Lat;
		SELF.Long := Long;
		SELF.Addr_Type := Addr_Type; 
		SELF.Addr_Status := Addr_Status;
		SELF.County := County;
		SELF.Geo_Block := Geo_Block;
		SELF.FEIN := FEIN[1..9];
		SELF.Phone10 := Phone10;
		SELF.IPAddr := IPAddr;
		SELF.CompanyURL := CompanyURL;
		SELF.SIC := SIC_Code;
		SELF.NAIC := NAIC_Code;
		SELF.Bus_LexID := Bus_LexID;
		SELF.Bus_Structure := Bus_Structure;
		SELF.Years_in_Business := Years_in_Business;
		SELF.Bus_Start_Date := Bus_Start_Date;
		SELF.Yearly_Revenue := Yearly_Revenue;
		SELF.Fax_Number := Fax_Number;
		// Authorized Rep Fields
		SELF.Rep_FullName := Rep_FullName;
		SELF.Rep_NameTitle := Rep_NameTitle;
		SELF.Rep_FirstName := Rep_FirstName;
		SELF.Rep_MiddleName := Rep_MiddleName;
		SELF.Rep_LastName := Rep_LastName;
		SELF.Rep_NameSuffix := Rep_NameSuffix;
		SELF.Rep_FormerLastName := Rep_FormerLastName;
		SELF.Rep_StreetAddress1 := Rep_StreetAddress1;
		SELF.Rep_StreetAddress2 := Rep_StreetAddress2;
		SELF.Rep_City := Rep_City;
		SELF.Rep_State := Rep_State;
		SELF.Rep_Zip := Rep_Zip;
		SELF.Rep_Prim_Range := Rep_Prim_Range;
		SELF.Rep_PreDir := Rep_PreDir;
		SELF.Rep_Prim_Name := Rep_Prim_Name;
		SELF.Rep_Addr_Suffix := Rep_Addr_Suffix;
		SELF.Rep_PostDir := Rep_PostDir;
		SELF.Rep_Unit_Desig := Rep_Unit_Desig;
		SELF.Rep_Sec_Range := Rep_Sec_Range;
		SELF.Rep_Zip5 := Rep_Zip5;
		SELF.Rep_Zip4 := Rep_Zip4;
		SELF.Rep_Lat := Rep_Lat;
		SELF.Rep_Long := Rep_Long;
		SELF.Rep_Addr_Type := Rep_Addr_Type;
		SELF.Rep_Addr_Status := Rep_Addr_Status;
		SELF.Rep_County := Rep_County;
		SELF.Rep_Geo_Block := Rep_Geo_Block;
		SELF.Rep_SSN := Rep_SSN;
		SELF.Rep_DateOfBirth := Rep_DateOfBirth;
		SELF.Rep_Phone10 := Rep_Phone10;
		SELF.Rep_Age := Rep_Age;
		SELF.Rep_DLNumber := Rep_DLNumber;
		SELF.Rep_DLState := Rep_DLState;
		SELF.Rep_Email := Rep_Email;
		SELF.Rep_LexID := Rep_LexID;
		// Authorized Rep 2 Fields
		SELF.Rep2_FullName := Rep2_FullName;
		SELF.Rep2_NameTitle := Rep2_NameTitle;
		SELF.Rep2_FirstName := Rep2_FirstName;
		SELF.Rep2_MiddleName := Rep2_MiddleName;
		SELF.Rep2_LastName := Rep2_LastName;
		SELF.Rep2_NameSuffix := Rep2_NameSuffix;
		SELF.Rep2_FormerLastName := Rep2_FormerLastName;
		SELF.Rep2_StreetAddress1 := Rep2_StreetAddress1;
		SELF.Rep2_StreetAddress2 := Rep2_StreetAddress2;
		SELF.Rep2_City := Rep2_City;
		SELF.Rep2_State := Rep2_State;
		SELF.Rep2_Zip := Rep2_Zip;
		SELF.Rep2_Prim_Range := Rep2_Prim_Range;
		SELF.Rep2_PreDir := Rep2_PreDir;
		SELF.Rep2_Prim_Name := Rep2_Prim_Name;
		SELF.Rep2_Addr_Suffix := Rep2_Addr_Suffix;
		SELF.Rep2_PostDir := Rep2_PostDir;
		SELF.Rep2_Unit_Desig := Rep2_Unit_Desig;
		SELF.Rep2_Sec_Range := Rep2_Sec_Range;
		SELF.Rep2_Zip5 := Rep2_Zip5;
		SELF.Rep2_Zip4 := Rep2_Zip4;
		SELF.Rep2_Lat := Rep2_Lat;
		SELF.Rep2_Long := Rep2_Long;
		SELF.Rep2_Addr_Type := Rep2_Addr_Type;
		SELF.Rep2_Addr_Status := Rep2_Addr_Status;
		SELF.Rep2_County := Rep2_County;
		SELF.Rep2_Geo_Block := Rep2_Geo_Block;
		SELF.Rep2_SSN := Rep2_SSN;
		SELF.Rep2_DateOfBirth := Rep2_DateOfBirth;
		SELF.Rep2_Phone10 := Rep2_Phone10;
		SELF.Rep2_Age := Rep2_Age;
		SELF.Rep2_DLNumber := Rep2_DLNumber;
		SELF.Rep2_DLState := Rep2_DLState;
		SELF.Rep2_Email := Rep2_Email;
		SELF.Rep2_LexID := Rep2_LexID;
		// Authorized Rep 3 Fields
		SELF.Rep3_FullName := Rep3_FullName;
		SELF.Rep3_NameTitle := Rep3_NameTitle;
		SELF.Rep3_FirstName := Rep3_FirstName;
		SELF.Rep3_MiddleName := Rep3_MiddleName;
		SELF.Rep3_LastName := Rep3_LastName;
		SELF.Rep3_NameSuffix := Rep3_NameSuffix;
		SELF.Rep3_FormerLastName := Rep3_FormerLastName;
		SELF.Rep3_StreetAddress1 := Rep3_StreetAddress1;
		SELF.Rep3_StreetAddress2 := Rep3_StreetAddress2;
		SELF.Rep3_City := Rep3_City;
		SELF.Rep3_State := Rep3_State;
		SELF.Rep3_Zip := Rep3_Zip;
		SELF.Rep3_Prim_Range := Rep3_Prim_Range;
		SELF.Rep3_PreDir := Rep3_PreDir;
		SELF.Rep3_Prim_Name := Rep3_Prim_Name;
		SELF.Rep3_Addr_Suffix := Rep3_Addr_Suffix;
		SELF.Rep3_PostDir := Rep3_PostDir;
		SELF.Rep3_Unit_Desig := Rep3_Unit_Desig;
		SELF.Rep3_Sec_Range := Rep3_Sec_Range;
		SELF.Rep3_Zip5 := Rep3_Zip5;
		SELF.Rep3_Zip4 := Rep3_Zip4;
		SELF.Rep3_Lat := Rep3_Lat;
		SELF.Rep3_Long := Rep3_Long;
		SELF.Rep3_Addr_Type := Rep3_Addr_Type;
		SELF.Rep3_Addr_Status := Rep3_Addr_Status;
		SELF.Rep3_County := Rep3_County;
		SELF.Rep3_Geo_Block := Rep3_Geo_Block;
		SELF.Rep3_SSN := Rep3_SSN;
		SELF.Rep3_DateOfBirth := Rep3_DateOfBirth;
		SELF.Rep3_Phone10 := Rep3_Phone10;
		SELF.Rep3_Age := Rep3_Age;
		SELF.Rep3_DLNumber := Rep3_DLNumber;
		SELF.Rep3_DLState := Rep3_DLState;
		SELF.Rep3_Email := Rep3_Email;
		SELF.Rep3_LexID := Rep3_LexID;
		// Authorized Rep 4 Fields
		SELF.Rep4_FullName := Rep4_FullName;
		SELF.Rep4_NameTitle := Rep4_NameTitle;
		SELF.Rep4_FirstName := Rep4_FirstName;
		SELF.Rep4_MiddleName := Rep4_MiddleName;
		SELF.Rep4_LastName := Rep4_LastName;
		SELF.Rep4_NameSuffix := Rep4_NameSuffix;
		SELF.Rep4_FormerLastName := Rep4_FormerLastName;
		SELF.Rep4_StreetAddress1 := Rep4_StreetAddress1;
		SELF.Rep4_StreetAddress2 := Rep4_StreetAddress2;
		SELF.Rep4_City := Rep4_City;
		SELF.Rep4_State := Rep4_State;
		SELF.Rep4_Zip := Rep4_Zip;
		SELF.Rep4_Prim_Range := Rep4_Prim_Range;
		SELF.Rep4_PreDir := Rep4_PreDir;
		SELF.Rep4_Prim_Name := Rep4_Prim_Name;
		SELF.Rep4_Addr_Suffix := Rep4_Addr_Suffix;
		SELF.Rep4_PostDir := Rep4_PostDir;
		SELF.Rep4_Unit_Desig := Rep4_Unit_Desig;
		SELF.Rep4_Sec_Range := Rep4_Sec_Range;
		SELF.Rep4_Zip5 := Rep4_Zip5;
		SELF.Rep4_Zip4 := Rep4_Zip4;
		SELF.Rep4_Lat := Rep4_Lat;
		SELF.Rep4_Long := Rep4_Long;
		SELF.Rep4_Addr_Type := Rep4_Addr_Type;
		SELF.Rep4_Addr_Status := Rep4_Addr_Status;
		SELF.Rep4_County := Rep4_County;
		SELF.Rep4_Geo_Block := Rep4_Geo_Block;
		SELF.Rep4_SSN := Rep4_SSN;
		SELF.Rep4_DateOfBirth := Rep4_DateOfBirth;
		SELF.Rep4_Phone10 := Rep4_Phone10;
		SELF.Rep4_Age := Rep4_Age;
		SELF.Rep4_DLNumber := Rep4_DLNumber;
		SELF.Rep4_DLState := Rep4_DLState;
		SELF.Rep4_Email := Rep4_Email;
		SELF.Rep4_LexID := Rep4_LexID;
		// Authorized Rep 5 Fields
		SELF.Rep5_FullName := Rep5_FullName;
		SELF.Rep5_NameTitle := Rep5_NameTitle;
		SELF.Rep5_FirstName := Rep5_FirstName;
		SELF.Rep5_MiddleName := Rep5_MiddleName;
		SELF.Rep5_LastName := Rep5_LastName;
		SELF.Rep5_NameSuffix := Rep5_NameSuffix;
		SELF.Rep5_FormerLastName := Rep5_FormerLastName;
		SELF.Rep5_StreetAddress1 := Rep5_StreetAddress1;
		SELF.Rep5_StreetAddress2 := Rep5_StreetAddress2;
		SELF.Rep5_City := Rep5_City;
		SELF.Rep5_State := Rep5_State;
		SELF.Rep5_Zip := Rep5_Zip;
		SELF.Rep5_Prim_Range := Rep5_Prim_Range;
		SELF.Rep5_PreDir := Rep5_PreDir;
		SELF.Rep5_Prim_Name := Rep5_Prim_Name;
		SELF.Rep5_Addr_Suffix := Rep5_Addr_Suffix;
		SELF.Rep5_PostDir := Rep5_PostDir;
		SELF.Rep5_Unit_Desig := Rep5_Unit_Desig;
		SELF.Rep5_Sec_Range := Rep5_Sec_Range;
		SELF.Rep5_Zip5 := Rep5_Zip5;
		SELF.Rep5_Zip4 := Rep5_Zip4;
		SELF.Rep5_Lat := Rep5_Lat;
		SELF.Rep5_Long := Rep5_Long;
		SELF.Rep5_Addr_Type := Rep5_Addr_Type;
		SELF.Rep5_Addr_Status := Rep5_Addr_Status;
		SELF.Rep5_County := Rep5_County;
		SELF.Rep5_Geo_Block := Rep5_Geo_Block;
		SELF.Rep5_SSN := Rep5_SSN;
		SELF.Rep5_DateOfBirth := Rep5_DateOfBirth;
		SELF.Rep5_Phone10 := Rep5_Phone10;
		SELF.Rep5_Age := Rep5_Age;
		SELF.Rep5_DLNumber := Rep5_DLNumber;
		SELF.Rep5_DLState := Rep5_DLState;
		SELF.Rep5_Email := Rep5_Email;
		SELF.Rep5_LexID := Rep5_LexID;
		
		SELF.HistoryDate := (UNSIGNED3)(((STRING12)HistoryDate)[1..6]);
		SELF.HistoryDateTime := HistoryDate;
		SELF.PowID := PowID;
		SELF.ProxID := ProxID;
		SELF.SeleID := SeleID;
		SELF.OrgID := OrgID;
		SELF.UltID := UltID;
		
		SELF := [];
	END;
	
	Input := DATASET([grabInput()]);
  
  if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));
  
  IF( OFAC_version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(Watchlists_Requested, value),
    FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );
	
	/* ************************************************************************
	 *                   Get the Business Shell Results                       *
	 ************************************************************************ */
	Shell_Results := Business_Risk_BIP.LIB_Business_Shell_Function(Input,
																																 DPPA_Purpose,
																																 GLBA_Purpose,
																																 DataRestrictionMask,
																																 DataPermissionMask,
																																 IndustryClass,
																																 LinkSearchLevel,
																																 BusShellVersion,
																																 MarketingMode,
																																 AllowedSources,
																																 BIPBestAppend,
																																 OFAC_Version,
																																 Global_Watchlist_Threshold,
																																 Watchlists_Requested,
																																 KeepLargeBusinesses, 
																																 IncludeTargusGateway,
																																 Gateways,
																																 RunTargusGateway, /* for testing purposes only */
																																 OverrideExperianRestriction,
																																 IncludeAuthRepInBIPAppend,
																																 FALSE,
                                                                 CorteraRetrotest,
																																 ds_CorteraRetrotestRecsRaw);
	
	Final_Results := PROJECT(Shell_Results, TRANSFORM(Business_Risk_BIP.Layouts.OutputLayout, SELF := LEFT));

 //output(input,NAMED('myinput'));	

	RETURN OUTPUT(Final_Results, NAMED('Results'));

END;