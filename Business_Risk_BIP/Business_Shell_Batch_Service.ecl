/*--SOAP--
<message name="Business_Shell_Batch_Service" wuTimeout="300000">
	<part name="Batch_In" type="tns:XmlDataSet" cols="100" rows="25"/>
	<!-- Option Fields --> 
	<part name="DPPA_Purpose" type="xsd:integer"/>
	<part name="GLBA_Purpose" type="xsd:integer"/>
	<part name="Data_Restriction_Mask" type="xsd:string"/>
	<part name="Data_Permission_Mask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="LinkSearchLevel" type="xsd:integer"/>
	<part name="MarketingMode" type="xsd:integer"/>
	<part name="BusShellVersion" type="xsd:integer"/>
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
</message>
*/
/*--INFO-- Business Shell Batch Service - This is the Batch Service utilizing BIP linking. */

#option('expandSelectCreateRow', true);
IMPORT Business_Risk_BIP, Gateway, iesp, UT;

EXPORT Business_Shell_Batch_Service() := FUNCTION
	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'Batch_In',
	'DPPA_Purpose',
	'GLBA_Purpose',
	'Data_Restriction_Mask',
	'Data_Permission_Mask',
	'IndustryClass',
	'LinkSearchLevel',
	'MarketingMode',
	'BusShellVersion',
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
	// NOTE: If you change this you MUST redeploy the Library as the interface has changed.
	DATASET(Business_Risk_BIP.Layouts.Input) Input_pre := DATASET([], Business_Risk_BIP.Layouts.Input) : STORED('Batch_In');
	
	// Allow for a longer HistoryDate format (e.g. YYYYMMDD, YYYYMMDDTTTT), which are preserved in full in historydatetime.
	Input := PROJECT(Input_pre, TRANSFORM(Business_Risk_BIP.Layouts.Input, SELF.HistoryDate := (UNSIGNED3)(((STRING12)LEFT.HistoryDate)[1..6]), SELF.HistoryDateTime := LEFT.HistoryDate, SELF := LEFT));

	// Option Fields
	UNSIGNED1	DPPA_Purpose         := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPA_Purpose');
	UNSIGNED1	GLBA_Purpose         := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBA_Purpose');
	STRING50	DataRestrictionMask  := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('Data_Restriction_Mask');
	STRING50	DataPermissionMask   := Business_Risk_BIP.Constants.Default_DataPermissionMask : STORED('Data_Permission_Mask');
	STRING5	IndustryClass_In		   := Business_Risk_BIP.Constants.Default_IndustryClass : STORED('IndustryClass');
	IndustryClass := StringLib.StringToUpperCase(TRIM(IndustryClass_In, LEFT, RIGHT));
	UNSIGNED1	LinkSearchLevel      := Business_Risk_BIP.Constants.LinkSearch.Default : STORED('LinkSearchLevel');
	UNSIGNED1	MarketingMode        := Business_Risk_BIP.Constants.Default_MarketingMode : STORED('MarketingMode');
	UNSIGNED1	BusShellVersion      := Business_Risk_BIP.Constants.Default_BusShellVersion : STORED('BusShellVersion');
	STRING50	AllowedSources       := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
	UNSIGNED1	BIPBestAppend				 := Business_Risk_BIP.Constants.BIPBestAppend.Default : STORED('BIPBestAppend');
	UNSIGNED1 OFAC_Version		     := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	REAL Global_Watchlist_Threshold	:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');
	DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Business_Risk_BIP.Constants.Default_Watchlists_Requested : STORED('Watchlists_Requested');
	UNSIGNED1 KeepLargeBusinesses  := Business_Risk_BIP.Constants.DefaultJoinType : STORED('KeepLargeBusinesses');
	BOOLEAN IncludeTargusGateway   := FALSE : STORED('IncludeTargusGateway');
	BOOLEAN RunTargusGateway       := FALSE : STORED('RunTargusGatewayAnywayForTesting');
	BOOLEAN OverrideExperianRestriction := FALSE : STORED('OverrideExperianRestriction');
	BOOLEAN IncludeAuthRepInBIPAppend := FALSE : STORED('IncludeAuthRepInBIPAppend');
	
	Gateways := Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus
	
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
																																 IncludeAuthRepInBIPAppend);
	
	Final_Results := PROJECT(Shell_Results, TRANSFORM(Business_Risk_BIP.Layouts.OutputLayout, SELF := LEFT));
	
	RETURN OUTPUT(Final_Results, NAMED('Results'));
END;