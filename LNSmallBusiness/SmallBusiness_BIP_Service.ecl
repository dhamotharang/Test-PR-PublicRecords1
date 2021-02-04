/*--SOAP--
<message name="SmallBusiness_BIP_Service" wuTimeout="300000">
	<part name="SmallBusinessAnalyticsRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
 <part name="CorteraRetrotestRecords" type="tns:XmlDataSet" cols="110" rows="75"/>
  <!-- Option Fields -->
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
  <part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="HistoryDate" type="xsd:integer"/>
  <part name="Watchlists_Requested" type="tns:XmlDataSet" cols="100" rows="8"/>
  <part name="OFAC_Version" type="xsd:integer"/>
  <part name="LinkSearchLevel" type="xsd:integer"/>
  <part name="MarketingMode" type="xsd:integer"/>
  <part name="AllowedSources" type="xsd:string"/>
  <part name="Global_Watchlist_Threshold" type="xsd:real"/>
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
	<part name="IncludeTargusGateway" type="xsd:boolean"/>
	<part name="RunTargusGatewayAnywayForTesting" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Small Business XML Service - This service returns Small Business Attributes and Scores */
#option('expandSelectCreateRow', true);
#option('embeddedWarningsAsErrors', 0);
// #option('optimizelevel', 0);  // NEVER RELEASE THIS LINE OF CODE TO PROD
                                    // this is for deploying to a 100-way as
                                    // the service is large.
                                    // This service won't run on a 1-way.

IMPORT Address, Business_Risk_BIP, Cortera, Gateway, IESP, MDR, OFAC_XG5, Phones, Risk_Reporting,
			 Royalty, Models, Inquiry_AccLogs, STD, LNSmallBusiness;

EXPORT SmallBusiness_BIP_Service() := FUNCTION
  /* ************************************************************************
   *                      Force the order on the WsECL page                 *
   ************************************************************************ */
  #WEBSERVICE(FIELDS(
  'SmallBusinessAnalyticsRequest',
  'CorteraRetrotestRecords',
  'DPPAPurpose',
  'GLBPurpose',
  'DataRestrictionMask',
  'DataPermissionMask',
  'IndustryClass',
  'Gateways',
  'ReturnDetailedRoyalties',
  'HistoryDateYYYYMM',
  'HistoryDate',
  'Watchlists_Requested',
  'OFAC_Version',
  'LinkSearchLevel',
  'MarketingMode',
  'AllowedSources',
  'Global_Watchlist_Threshold',
  'OutcomeTrackingOptOut',
  'IncludeTargusGateway',
  'RunTargusGatewayAnywayForTesting',
  'LexIdSourceOptout',
  '_TransactionId',
  '_BatchUID',
  '_GCID'
  ));

	/* ************************************************************************
	 *                          Grab service inputs                           *
	 ************************************************************************ */

	// Can't have duplicate definitions of Stored with different default values,
	// so add the default to #stored to eliminate the assignment of a default value.
	// Fixes "Duplicate definition of STORED('datarestrictionmask') with different type
	// (use #stored to override default value)" error.
	#STORED('DataRestrictionMask',Business_Risk_BIP.Constants.Default_DataRestrictionMask);
	#STORED('DataPermissionMask' ,Business_Risk_BIP.Constants.Default_DataPermissionMask);
	#STORED('DPPAPurpose'        ,Business_Risk_BIP.Constants.Default_DPPA);
	#STORED('GLBPurpose'         ,Business_Risk_BIP.Constants.Default_GLBA);
	#STORED('IndustryClass'      ,Business_Risk_BIP.Constants.Default_IndustryClass);
	#STORED('SSNMask'            ,Business_Risk_BIP.Constants.Default_SSNMask);

	requestIn := DATASET([], iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsRequest) : STORED('SmallBusinessAnalyticsRequest', FEW);
  firstRow  := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	search    := GLOBAL(firstRow.SearchBy);
	option    := GLOBAL(firstRow.Options);
	users     := GLOBAL(firstRow.User);

  BOOLEAN CorteraRetrotest := FALSE : STORED('CorteraRetrotest');
  ds_CorteraRetrotestRecsRaw := DATASET([], Cortera.layout_Retrotest_raw) : STORED('CorteraRetrotestRecords', FEW);

  /* ********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := IF(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	string6 outofbandssnmask        := 'NONE' : STORED('SSNMask'); //same as in "global module"
	string10 SSN_Mask               := IF(users.SSNMask != '', users.SSNMask, outofbandssnmask);
	string6 outofbanddobmask        := 'NONE' : STORED('DOBMask'); //same as in "global module"
	string10 DOB_Mask               := IF(users.DOBMask != '', users.DOBMask, outofbanddobmask);
	BOOLEAN DL_Mask                 := users.DLMask;
	BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
	BOOLEAN ArchiveOptIn            := FALSE : STORED('instantidarchivingoptin');
	BOOLEAN DisableIntermediateShellLoggingOutOfBand := FALSE : STORED('OutcomeTrackingOptOut');
	DisableOutcomeTracking := DisableIntermediateShellLoggingOutOfBand OR users.OutcomeTrackingOptOut;

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID AND s_product_id = (STRING)Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_BIP_Service);
/* ************* End Scout Fields **************/

	UNSIGNED1 DPPAPurpose_stored      := Business_Risk_BIP.Constants.Default_DPPA                : STORED('DPPAPurpose');
	UNSIGNED1 GLBPurpose_stored       := Business_Risk_BIP.Constants.Default_GLBA                : STORED('GLBPurpose');
	STRING DataRestrictionMask_stored := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('DataRestrictionMask');
	STRING DataPermissionMask_stored  := Business_Risk_BIP.Constants.Default_DataPermissionMask  : STORED('DataPermissionMask');
	STRING5 IndustryClass_stored      := Business_Risk_BIP.Constants.Default_IndustryClass       : STORED('IndustryClass');

	//CCPA fields
	UNSIGNED1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
	STRING TransactionID := '' : STORED('_TransactionId');
	STRING BatchUID := '' : STORED('_BatchUID');
	UNSIGNED6 GlobalCompanyId := 0 : STORED('_GCID');

	// Below we'll prefer users.DataRestrictionMask, users.DataPermissionMask, users.industryclass, etc., over
	// DataRestrictionMask_stored, DataPermissionMask_stored, etc., since they are "internal" or overridden values
	// populated for Development/QA purposes, etc.

	STRING30 AcctNo := users.AccountNumber;
	// Business Input Information
	UNSIGNED6 PowID := search.Company.BusinessIds.PowID;
	UNSIGNED6 ProxID := search.Company.BusinessIds.ProxID;
	UNSIGNED6 SeleID := search.Company.BusinessIds.SeleID;
	UNSIGNED6 OrgID := search.Company.BusinessIds.OrgID;
	UNSIGNED6 UltID := search.Company.BusinessIds.UltID;

	STRING120 Bus_Company_Name := search.Company.CompanyName;
	STRING120 Bus_Doing_Business_As := search.Company.AlternateCompanyName;
	STRING120 Bus_Street_Address1 := IF(search.Company.Address.StreetAddress1 = '', Address.Addr1FromComponents(search.Company.Address.StreetNumber, search.Company.Address.StreetPreDirection, search.Company.Address.StreetName, search.Company.Address.StreetSuffix, search.Company.Address.StreetPostDirection, search.Company.Address.UnitDesignation, search.Company.Address.UnitNumber),
																																									search.Company.Address.StreetAddress1);
	STRING120 Bus_Street_Address2 := search.Company.Address.StreetAddress2;
	STRING25 Bus_City := search.Company.Address.City;
	STRING2 Bus_State := search.Company.Address.State;
	STRING9 Bus_Zip := search.Company.Address.Zip5;
	STRING9 Bus_FEIN := search.Company.FEIN;
	STRING10 Bus_Phone10 := search.Company.Phone;
	STRING8 Bus_SIC_Code := search.Company.SICCode;
	STRING8 Bus_NAIC_Code := search.Company.NAICCode;
	STRING32 Bus_Structure := search.Company.BusinessStructure;
	STRING3 Bus_Years_in_Business := search.Company.YearsInBusiness;
	STRING8 Bus_Start_Date := iesp.ECL2ESP.t_DateToString8(search.Company.BusinessStartDate);
	STRING12 Bus_Yearly_Revenue := search.Company.YearlyRevenue;
	STRING10 Bus_Fax_Number := search.Company.FaxNumber;
	// Authorized Representative 1 Input Information
	STRING120 Rep_1_Full_Name := search.AuthorizedRep1.Name.Full;
	STRING20 Rep_1_First_Name := search.AuthorizedRep1.Name.First;
	STRING20 Rep_1_Middle_Name := search.AuthorizedRep1.Name.Middle;
	STRING20 Rep_1_Last_Name := search.AuthorizedRep1.Name.Last;
	STRING20 Rep_1_Former_Last_Name := search.AuthorizedRep1.FormerLastName;
	STRING5 Rep_1_Suffix := search.AuthorizedRep1.Name.Suffix;
	STRING8 Rep_1_DOB := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep1.DOB);
	STRING9 Rep_1_SSN := search.AuthorizedRep1.SSN;
	STRING120 Rep_1_Street_Address1 := IF(search.AuthorizedRep1.Address.StreetAddress1 = '', Address.Addr1FromComponents(search.AuthorizedRep1.Address.StreetNumber, search.AuthorizedRep1.Address.StreetPreDirection, search.AuthorizedRep1.Address.StreetName, search.AuthorizedRep1.Address.StreetSuffix, search.AuthorizedRep1.Address.StreetPostDirection, search.AuthorizedRep1.Address.UnitDesignation, search.AuthorizedRep1.Address.UnitNumber),
																																														search.AuthorizedRep1.Address.StreetAddress1);
	STRING120 Rep_1_Street_Address2 := search.AuthorizedRep1.Address.StreetAddress2;
	STRING25 Rep_1_City := search.AuthorizedRep1.Address.City;
	STRING2 Rep_1_State := search.AuthorizedRep1.Address.State;
	STRING9 Rep_1_Zip := search.AuthorizedRep1.Address.Zip5;
	STRING10 Rep_1_Phone10 := search.AuthorizedRep1.Phone;
	STRING3 Rep_1_Age := search.AuthorizedRep1.Age;
	STRING25 Rep_1_DL_Number := search.AuthorizedRep1.DriverLicenseNumber;
	STRING2 Rep_1_DL_State := search.AuthorizedRep1.DriverLicenseState;
	STRING Rep_1_Business_Title := search.AuthorizedRep1.BusinessTitle;
	STRING12 Rep_1_LexID := search.AuthorizedRep1.UniqueId;
	// Authorized Representative 2 Input Information
	STRING120 Rep_2_Full_Name := search.AuthorizedRep2.Name.Full;
	STRING20 Rep_2_First_Name := search.AuthorizedRep2.Name.First;
	STRING20 Rep_2_Middle_Name := search.AuthorizedRep2.Name.Middle;
	STRING20 Rep_2_Last_Name := search.AuthorizedRep2.Name.Last;
	STRING20 Rep_2_Former_Last_Name := search.AuthorizedRep2.FormerLastName;
	STRING5 Rep_2_Suffix := search.AuthorizedRep2.Name.Suffix;
	STRING8 Rep_2_DOB := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep2.DOB);
	STRING9 Rep_2_SSN := search.AuthorizedRep2.SSN;
	STRING120 Rep_2_Street_Address1 := IF(search.AuthorizedRep2.Address.StreetAddress1 = '', Address.Addr1FromComponents(search.AuthorizedRep2.Address.StreetNumber, search.AuthorizedRep2.Address.StreetPreDirection, search.AuthorizedRep2.Address.StreetName, search.AuthorizedRep2.Address.StreetSuffix, search.AuthorizedRep2.Address.StreetPostDirection, search.AuthorizedRep2.Address.UnitDesignation, search.AuthorizedRep2.Address.UnitNumber),
																																														search.AuthorizedRep2.Address.StreetAddress1);
	STRING120 Rep_2_Street_Address2 := search.AuthorizedRep2.Address.StreetAddress2;
	STRING25 Rep_2_City := search.AuthorizedRep2.Address.City;
	STRING2 Rep_2_State := search.AuthorizedRep2.Address.State;
	STRING9 Rep_2_Zip := search.AuthorizedRep2.Address.Zip5;
	STRING10 Rep_2_Phone10 := search.AuthorizedRep2.Phone;
	STRING3 Rep_2_Age := search.AuthorizedRep2.Age;
	STRING25 Rep_2_DL_Number := search.AuthorizedRep2.DriverLicenseNumber;
	STRING2 Rep_2_DL_State := search.AuthorizedRep2.DriverLicenseState;
	STRING Rep_2_Business_Title := search.AuthorizedRep2.BusinessTitle;
	STRING12 Rep_2_LexID := search.AuthorizedRep2.UniqueId;

	// Authorized Representative 3 Input Information
	STRING120 Rep_3_Full_Name := search.AuthorizedRep3.Name.Full;
	STRING20 Rep_3_First_Name := search.AuthorizedRep3.Name.First;
	STRING20 Rep_3_Middle_Name := search.AuthorizedRep3.Name.Middle;
	STRING20 Rep_3_Last_Name := search.AuthorizedRep3.Name.Last;
	STRING20 Rep_3_Former_Last_Name := search.AuthorizedRep3.FormerLastName;
	STRING5 Rep_3_Suffix := search.AuthorizedRep3.Name.Suffix;
	STRING8 Rep_3_DOB := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep3.DOB);
	STRING9 Rep_3_SSN := search.AuthorizedRep3.SSN;
	STRING120 Rep_3_Street_Address1 := IF(search.AuthorizedRep3.Address.StreetAddress1 = '', Address.Addr1FromComponents(search.AuthorizedRep3.Address.StreetNumber, search.AuthorizedRep3.Address.StreetPreDirection, search.AuthorizedRep3.Address.StreetName, search.AuthorizedRep3.Address.StreetSuffix, search.AuthorizedRep3.Address.StreetPostDirection, search.AuthorizedRep3.Address.UnitDesignation, search.AuthorizedRep3.Address.UnitNumber),
																																														search.AuthorizedRep3.Address.StreetAddress1);
	STRING120 Rep_3_Street_Address2 := search.AuthorizedRep3.Address.StreetAddress2;
	STRING25 Rep_3_City := search.AuthorizedRep3.Address.City;
	STRING2 Rep_3_State := search.AuthorizedRep3.Address.State;
	STRING9 Rep_3_Zip := search.AuthorizedRep3.Address.Zip5;
	STRING10 Rep_3_Phone10 := search.AuthorizedRep3.Phone;
	STRING3 Rep_3_Age := search.AuthorizedRep3.Age;
	STRING25 Rep_3_DL_Number := search.AuthorizedRep3.DriverLicenseNumber;
	STRING2 Rep_3_DL_State := search.AuthorizedRep3.DriverLicenseState;
	STRING Rep_3_Business_Title := search.AuthorizedRep3.BusinessTitle;
	STRING12 Rep_3_LexID := search.AuthorizedRep3.UniqueId;

	// Option Fields
	UNSIGNED3 HistoryDateYYYYMM		 := 0 : STORED('HistoryDateYYYYMM');
	UNSIGNED6 HistoryDate          := 0 : STORED('HistoryDate');

	/* In band history date. Request for insurance  */
	STRING4 inBandYear := INTFORMAT(option.HistoryDate.Year, 4, 1);
	STRING2 inBandMonth := INTFORMAT(option.HistoryDate.Month, 2, 1);
	STRING tempInBandDateYYYYMM := inBandYear + inBandMonth;
	UNSIGNED3 inBandDateYYYYMM := (UNSIGNED3)tempInBandDateYYYYMM;

	UNSIGNED1	DPPA_Purpose         := IF(TRIM(users.DLPurpose) <> '', (INTEGER)users.DLPurpose, DPPAPurpose_stored);
	UNSIGNED1	GLBA_Purpose         := IF(TRIM(users.GLBPurpose) <> '', (INTEGER)users.GLBPurpose, GLBPurpose_stored);
	STRING  DataRestrictionMask    := IF(TRIM(users.DataRestrictionMask) <> '', users.DataRestrictionMask, DataRestrictionMask_stored);
	STRING  DataPermissionMask		 := IF(TRIM(users.DataPermissionMask) <> '', users.DataPermissionMask, DataPermissionMask_stored);
	STRING5	IndustryClass		   		 := STD.Str.ToUpperCase(TRIM( IF( users.industryclass <> '', users.industryclass, IndustryClass_stored ) , LEFT, RIGHT ));
	UNSIGNED1	LinkSearchLevel      := Business_Risk_BIP.Constants.LinkSearch.Default : STORED('LinkSearchLevel');
	UNSIGNED1	MarketingMode        := Business_Risk_BIP.Constants.Default_MarketingMode : STORED('MarketingMode');
	STRING50	AllowedSources       := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
	UNSIGNED1 OFAC_Version		     := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	REAL Global_Watchlist_Threshold	:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');
	DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Business_Risk_BIP.Constants.Default_Watchlists_Requested : STORED('Watchlists_Requested');
	BOOLEAN TestDataEnabled				 := users.TestDataEnabled;
	STRING32 TestDataTableName		 := users.TestDataTableName;
	BOOLEAN IncludeTargusGateway   := FALSE : STORED('IncludeTargusGateway');
	BOOLEAN RunTargusGateway       := FALSE : STORED('RunTargusGatewayAnywayForTesting');

	IF( OFAC_Version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(Watchlists_Requested, value),
		FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

	// SmallBusinessAttrV1 (etc) is a valid input
	AttributesRequested := PROJECT(option.AttributesVersionRequest, TRANSFORM(LNSmallBusiness.Layouts.AttributeGroupRec, SELF.AttributeGroup := STD.Str.ToUpperCase(LEFT.Value)));
	ModelsRequested := PROJECT(option.IncludeModels.Names, TRANSFORM(LNSmallBusiness.Layouts.ModelNameRec, SELF.ModelName := STD.Str.ToUpperCase(LEFT.Value)));
	ModelOptions := PROJECT(option.IncludeModels.ModelOptions, TRANSFORM(LNSmallBusiness.Layouts.ModelOptionsRec, SELF.OptionName := STD.Str.ToUpperCase(TRIM(LEFT.OptionName, LEFT, RIGHT));
																																																								SELF.OptionValue := LEFT.OptionValue));

	Gateways := Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus

	emptyRecord := DATASET([{1}], {unsigned a});

	LNSmallBusiness.BIP_Layouts.Input intoInputLayout(emptyRecord le) := TRANSFORM
		SELF.AcctNo := AcctNo;
		SELF.UltID := UltID;
		SELF.OrgID := OrgID;
		SELF.SeleID := SeleID;
		SELF.ProxID := ProxID;
		SELF.PowID := PowID;
		SELF.HistoryDateYYYYMM := IF(inBandDateYYYYMM > 0, inBandDateYYYYMM, HistoryDateYYYYMM);
		SELF.HistoryDate := HistoryDate;
		SELF.Bus_Company_Name := Bus_Company_Name;
		SELF.Bus_Doing_Business_As := Bus_Doing_Business_As;
		SELF.Bus_Street_Address1 := Bus_Street_Address1;
		SELF.Bus_Street_Address2 := Bus_Street_Address2;
		SELF.Bus_City := Bus_City;
		SELF.Bus_State := Bus_State;
		SELF.Bus_Zip := Bus_Zip;
		SELF.Bus_FEIN := Bus_FEIN;
		SELF.Bus_Phone10 := Bus_Phone10;
		SELF.Bus_SIC_Code := Bus_SIC_Code;
		SELF.Bus_NAIC_Code := Bus_NAIC_Code;
		SELF.Bus_Structure := Bus_Structure;
		SELF.Bus_Years_in_Business := Bus_Years_in_Business;
		SELF.Bus_Start_Date := Bus_Start_Date;
		SELF.Bus_Yearly_Revenue := Bus_Yearly_Revenue;
		SELF.Bus_Fax_Number := Bus_Fax_Number;
		SELF.Rep_1_Full_Name := Rep_1_Full_Name;
		SELF.Rep_1_First_Name := Rep_1_First_Name;
		SELF.Rep_1_Middle_Name := Rep_1_Middle_Name;
		SELF.Rep_1_Last_Name := Rep_1_Last_Name;
		SELF.Rep_1_Former_Last_Name := Rep_1_Former_Last_Name;
		SELF.Rep_1_Suffix := Rep_1_Suffix;
		SELF.Rep_1_DOB := Rep_1_DOB;
		SELF.Rep_1_SSN := Rep_1_SSN;
		SELF.Rep_1_Street_Address1 := Rep_1_Street_Address1;
		SELF.Rep_1_Street_Address2 := Rep_1_Street_Address2;
		SELF.Rep_1_City := Rep_1_City;
		SELF.Rep_1_State := Rep_1_State;
		SELF.Rep_1_Zip := Rep_1_Zip;
		SELF.Rep_1_Phone10 := Rep_1_Phone10;
		SELF.Rep_1_Age := Rep_1_Age;
		SELF.Rep_1_DL_Number := Rep_1_DL_Number;
		SELF.Rep_1_DL_State := Rep_1_DL_State;
		SELF.Rep_1_Business_Title := Rep_1_Business_Title;
		SELF.Rep_1_LexID := (UNSIGNED)Rep_1_Lexid;
		SELF.Rep_2_Full_Name := Rep_2_Full_Name;
		SELF.Rep_2_First_Name := Rep_2_First_Name;
		SELF.Rep_2_Middle_Name := Rep_2_Middle_Name;
		SELF.Rep_2_Last_Name := Rep_2_Last_Name;
		SELF.Rep_2_Former_Last_Name := Rep_2_Former_Last_Name;
		SELF.Rep_2_Suffix := Rep_2_Suffix;
		SELF.Rep_2_DOB := Rep_2_DOB;
		SELF.Rep_2_SSN := Rep_2_SSN;
		SELF.Rep_2_Street_Address1 := Rep_2_Street_Address1;
		SELF.Rep_2_Street_Address2 := Rep_2_Street_Address2;
		SELF.Rep_2_City := Rep_2_City;
		SELF.Rep_2_State := Rep_2_State;
		SELF.Rep_2_Zip := Rep_2_Zip;
		SELF.Rep_2_Phone10 := Rep_2_Phone10;
		SELF.Rep_2_Age := Rep_2_Age;
		SELF.Rep_2_DL_Number := Rep_2_DL_Number;
		SELF.Rep_2_DL_State := Rep_2_DL_State;
		SELF.Rep_2_Business_Title := Rep_2_Business_Title;
		SELF.Rep_2_LexID := (UNSIGNED)Rep_2_LexID;
		SELF.Rep_3_Full_Name := Rep_3_Full_Name;
		SELF.Rep_3_First_Name := Rep_3_First_Name;
		SELF.Rep_3_Middle_Name := Rep_3_Middle_Name;
		SELF.Rep_3_Last_Name := Rep_3_Last_Name;
		SELF.Rep_3_Former_Last_Name := Rep_3_Former_Last_Name;
		SELF.Rep_3_Suffix := Rep_3_Suffix;
		SELF.Rep_3_DOB := Rep_3_DOB;
		SELF.Rep_3_SSN := Rep_3_SSN;
		SELF.Rep_3_Street_Address1 := Rep_3_Street_Address1;
		SELF.Rep_3_Street_Address2 := Rep_3_Street_Address2;
		SELF.Rep_3_City := Rep_3_City;
		SELF.Rep_3_State := Rep_3_State;
		SELF.Rep_3_Zip := Rep_3_Zip;
		SELF.Rep_3_Phone10 := Rep_3_Phone10;
		SELF.Rep_3_Age := Rep_3_Age;
		SELF.Rep_3_DL_Number := Rep_3_DL_Number;
		SELF.Rep_3_DL_State := Rep_3_DL_State;
		SELF.Rep_3_Business_Title := Rep_3_Business_Title;
		SELF.Rep_3_LexID := (UNSIGNED)Rep_3_LexID;
		SELF := [];
	END;

	Input := PROJECT(DATASET([{1}], {unsigned a}), intoInputLayout(LEFT));

  SBA_20_Request := (UNSIGNED)AttributesRequested(AttributeGroup[1..18] = 'SMALLBUSINESSATTRV')[1].AttributeGroup[19..] >= 2; // Any new models/attribute groups running business shell 3.0 or higher should be added here.
	/* *************************************
	 *            Validate Input:          *
   *************************************** */
	MinimumInputMetForOption1 := TRIM(Bus_Company_Name) <> '' AND TRIM(Bus_Street_Address1) <> '' AND TRIM(Bus_Zip) <> '';
	MinimumInputMetForOption2 := TRIM(Bus_Company_Name) <> '' AND TRIM(Bus_Street_Address1) <> '' AND TRIM(Bus_City) <> '' AND TRIM(Bus_State) <> '';
  MinimumInputMetForOption3 := SeleID <> 0 AND SBA_20_Request; // SeleID only is a valid input in SBA 2.0 and above.
	// Authorized Rep information is not required on input, however if provided at a minimum First and Last Name must be populated
	MinimumInputMetForAuthorizedRep := (TRIM(Rep_1_Full_Name) <> '' OR TRIM(Rep_2_Full_Name) <> '' OR TRIM(Rep_3_Full_Name) <> '') OR // The full name was populated for one of the Auth Rep fields
																		 (TRIM(Rep_1_First_Name) <> '' AND TRIM(Rep_1_Last_Name) <> '') OR // Both First and Last were populated
																		 (TRIM(Rep_2_First_Name) <> '' AND TRIM(Rep_2_Last_Name) <> '') OR
																		 (TRIM(Rep_3_First_Name) <> '' AND TRIM(Rep_3_Last_Name) <> '') OR
                   (SBA_20_Request AND ((UNSIGNED)Rep_1_LexID > 0 OR (UNSIGNED)Rep_2_LexID > 0 OR (UNSIGNED)Rep_3_LexID > 0)) OR
																		  // No Auth rep information was passed in
																		 (TRIM(Rep_1_Full_Name) = '' AND TRIM(Rep_1_First_Name) = '' AND TRIM(Rep_1_Last_Name) = '' AND
																		  TRIM(Rep_2_Full_Name) = '' AND TRIM(Rep_2_First_Name) = '' AND TRIM(Rep_2_Last_Name) = '' AND
																			TRIM(Rep_3_Full_Name) = '' AND TRIM(Rep_3_First_Name) = '' AND TRIM(Rep_3_Last_Name) = '' AND
																			TRIM(Rep_1_SSN) = '' AND TRIM(Rep_1_DOB) = '' AND TRIM(Rep_1_Street_Address1) = '' AND TRIM(Rep_1_City) = '' AND TRIM(Rep_1_State) = '' AND TRIM(Rep_1_Zip) = '' AND TRIM(Rep_1_Phone10) = '' AND TRIM(Rep_1_DL_Number) = '' AND
																			TRIM(Rep_2_SSN) = '' AND TRIM(Rep_2_DOB) = '' AND TRIM(Rep_2_Street_Address1) = '' AND TRIM(Rep_2_City) = '' AND TRIM(Rep_2_State) = '' AND TRIM(Rep_2_Zip) = '' AND TRIM(Rep_2_Phone10) = '' AND TRIM(Rep_2_DL_Number) = '' AND
																			TRIM(Rep_3_SSN) = '' AND TRIM(Rep_3_DOB) = '' AND TRIM(Rep_3_Street_Address1) = '' AND TRIM(Rep_3_City) = '' AND TRIM(Rep_3_State) = '' AND TRIM(Rep_3_Zip) = '' AND TRIM(Rep_3_Phone10) = '' AND TRIM(Rep_3_DL_Number) = ''
																		 );

	// If blended model is requested, then one of the three minimum input options for the authorized rep must be met:
  //    a. Authorized Rep Last Name, Authorized Rep First Name, Authorized Rep Street Address, Authorized Rep Zip
  //    b. Authorized Rep Last Name, Authorized Rep First Name and SSN
  //    c. Authorized Rep Last Name, Authorized Rep First Name, Authorized Rep Street Address, Authorized Rep City, Authorized Rep State
  MinimumInputMetForAuthorizedRep_ScoreOption1 := (TRIM(Rep_1_Full_Name) <> '' OR (TRIM(Rep_1_First_Name) <> '' AND TRIM(Rep_1_Last_Name) <> '')) AND
                                      TRIM(Rep_1_Street_Address1) <> '' AND TRIM(Rep_1_Zip) <> '';
  MinimumInputMetForAuthorizedRep_ScoreOption2 := (TRIM(Rep_1_Full_Name) <> '' OR (TRIM(Rep_1_First_Name) <> '' AND TRIM(Rep_1_Last_Name) <> '')) AND
                                      TRIM(Rep_1_SSN) <> '';
  MinimumInputMetForAuthorizedRep_ScoreOption3 := (TRIM(Rep_1_Full_Name) <> '' OR (TRIM(Rep_1_First_Name) <> '' AND TRIM(Rep_1_Last_Name) <> '')) AND
                                      TRIM(Rep_1_Street_Address1) <> '' AND TRIM(Rep_1_City) <> '' AND TRIM(Rep_1_State) <> '';

  // If the customer requests the Business Blended score and provides no Authorized Rep input, then populate the Business Blended score with a '0' value.
  AuthorizedRepNotInput := TRIM(Rep_1_Full_Name) = '' AND TRIM(Rep_1_First_Name) = '' AND TRIM(Rep_1_Last_Name) = '' AND
                 TRIM(Rep_1_SSN) = '' AND TRIM(Rep_1_DOB) = '' AND TRIM(Rep_1_Street_Address1) = '' AND TRIM(Rep_1_City) = '' AND TRIM(Rep_1_State) = '' AND TRIM(Rep_1_Zip) = '' AND TRIM(Rep_1_Phone10) = '' AND TRIM(Rep_1_DL_Number) = '';

  BlendedModelRequested := EXISTS(ModelsRequested(ModelName IN SET(LNSmallBusiness.Constants.DATASET_MODELS.BLENDED_ALL, ModelName)));

	IF((MinimumInputMetForOption1 = FALSE AND MinimumInputMetForOption2 = FALSE AND MinimumInputMetForOption3=FALSE) OR // Minimum Business Inputs not met
		 ((MinimumInputMetForOption1 = TRUE OR MinimumInputMetForOption2 = TRUE OR MinimumInputMetForOption3=TRUE) AND MinimumInputMetForAuthorizedRep = FALSE) OR // Minimum Business Inputs met, but minimum Authorized Rep Inputs not met
		 (BlendedModelRequested AND AuthorizedRepNotInput = FALSE AND MinimumInputMetForAuthorizedRep_ScoreOption1 = FALSE AND MinimumInputMetForAuthorizedRep_ScoreOption2 = FALSE AND MinimumInputMetForAuthorizedRep_ScoreOption3 = FALSE),
		FAIL('Please input the minimum required fields:\nOption 1: Company Name, Street Address, Zip\nOR\nOption 2: Company Name, Street Address, City, State'));

	/* ************************************************************************
	 *         Get the Small Business Attributes and Scores Results           *
	 ************************************************************************ */
	 SBA_Results_Temp_with_PhoneSources := LNSmallBusiness.SmallBusiness_BIP_Function(Input,
																														DPPA_Purpose,
																														GLBA_Purpose,
																														DataRestrictionMask,
																														DataPermissionMask,
																														IndustryClass,
																														LinkSearchLevel,
																														MarketingMode,
																														AllowedSources,
																														OFAC_Version,
																														Global_Watchlist_Threshold,
																														Watchlists_Requested,
																														Gateways,
																														AttributesRequested,
																														ModelsRequested,
																														ModelOptions,
																														DisableOutcomeTracking,
																														IncludeTargusGateway,
																														RunTargusGateway, /* for testing purposes only */
																														LNSmallBusiness.Constants.BIPID_WEIGHT_THRESHOLD.FOR_SmallBusiness_BIP_Service,
																														CorteraRetrotest,
																														ds_CorteraRetrotestRecsRaw,
																														AppendBestsFromLexIDs := SBA_20_Request,
																														LexIdSourceOptout := LexIdSourceOptout,
																														TransactionID := TransactionID,
																														BatchUID := BatchUID,
																														GlobalCompanyID := GlobalCompanyID
																														);

	 SBA_Results_Temp := PROJECT( SBA_Results_Temp_with_PhoneSources, LNSmallBusiness.BIP_Layouts.IntermediateLayout );


	 #IF(Models.LIB_BusinessRisk_Models().TurnOnValidation) // If TRUE, output the model results directly

	  RETURN OUTPUT(SBA_Results_Temp, NAMED('Results'));
	 // RETURN OUTPUT(SBA_Results_Temp_with_PhoneSources, NAMED('Results')); //used for model validation

	 #ELSE
	 SBA_Results := IF(TestDataEnabled = FALSE, SBA_Results_Temp,
                                   /* else */ LNSmallBusiness.SmallBusiness_BIP_Testseed_Function(Input,
                                              TestDataTableName,
                                              DataPermissionMask,
                                              ModelsRequested,
                                              AttributesRequested));

	/* ************************************************************************
	 * Transform the Small Business Attributes and Scores Results into IESP   *
	 ************************************************************************ */
	// Merge the Name/Value pairs together
	iesp.share.t_NameValuePair createRecord(STRING Name, STRING Value) := TRANSFORM
		SELF.Name := Name;
		SELF.Value := Value;
	END;

	// Create Version 1 Name/Value Pair Attributes
	NameValuePairsVersion1 := NORMALIZE(SBA_Results, 200, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion1(LEFT, COUNTER));

	iesp.smallbusinessanalytics.t_SBAAttributesGroup Version1(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V1_NAME;
		SELF.Attributes := NameValuePairsVersion1;
	END;

  // Create Version 101 Name/Value Pair Attributes no felonies
	NameValuePairsVersion101 := NORMALIZE(SBA_Results, 197, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion101(LEFT, COUNTER));

	iesp.smallbusinessanalytics.t_SBAAttributesGroup Version101(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_NOFEL;
		SELF.Attributes := NameValuePairsVersion101;
	END;

	// Create Version 2 Name/Value Pair Attributes
	NameValuePairsVersion2 := NORMALIZE(SBA_Results, 316, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion2(LEFT, COUNTER));

	iesp.smallbusinessanalytics.t_SBAAttributesGroup Version2(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V2_NAME;
		SELF.Attributes := NameValuePairsVersion2;
	END;

	// Create Version 21 Name/Value Pair Attributes
	NameValuePairsVersion21 := NORMALIZE(SBA_Results, 373, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion21(LEFT, COUNTER));

	iesp.smallbusinessanalytics.t_SBAAttributesGroup Version21(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V21_NAME;
		SELF.Attributes := NameValuePairsVersion21;
	END;

	// Create SBFE Name/Value Pair Attributes
	NameValuePairsSBFE := NORMALIZE(SBA_Results, 1841, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoSBFE(LEFT, COUNTER));


	iesp.smallbusinessanalytics.t_SBAAttributesGroup SBFEVersion1(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR_NAME;
		SELF.Attributes := NameValuePairsSBFE;
	END;

	// Create SBFE Insurance Name/Value Pair Attributes
	NameValuePairsSBFEIns := NORMALIZE(SBA_Results, 1844, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoSBFEIns(LEFT, COUNTER));

	iesp.smallbusinessanalytics.t_SBAAttributesGroup SBFEInsVersion(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_SBFEINS_ATTR_NAME;
		SELF.Attributes := NameValuePairsSBFEIns;
	END;

	// Create the final ESDL Layout
	iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsResponse intoESDL(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Result.InputEcho := search; // Grab the exact input from the "search" ESDL near the top
		SELF.Result.BillingHit := (UNSIGNED1)le.BillingHit;
		SELF.Result.BusinessID.PowID := le.PowID;
		SELF.Result.BusinessID.ProxID := le.ProxID;
		SELF.Result.BusinessID.SeleID := le.SeleID;
		SELF.Result.BusinessID.OrgID := le.OrgID;
		SELF.Result.BusinessID.UltID := le.UltID;
		SELF.Result.Models := le.ModelResults;
		SELF.Result.AttributeGroups :=
					IF(EXISTS(AttributesRequested(TRIM(AttributeGroup) = 'SMALLBUSINESSATTRV1')), PROJECT(le, Version1(LEFT))) +
					IF(EXISTS(AttributesRequested(TRIM(AttributeGroup) = 'SMALLBUSINESSATTRV101')), PROJECT(le, Version101(LEFT))) +
					IF(EXISTS(AttributesRequested(TRIM(AttributeGroup) = 'SMALLBUSINESSATTRV2')), PROJECT(le, Version2(LEFT))) +
					IF(EXISTS(AttributesRequested(TRIM(AttributeGroup) = 'SMALLBUSINESSATTRV21')), PROJECT(le, Version21(LEFT))) +
					IF(EXISTS(AttributesRequested(TRIM(AttributeGroup) = 'SBFEATTRV1')), PROJECT(le, SBFEVersion1(LEFT))) +
					IF(EXISTS(AttributesRequested(TRIM(AttributeGroup) = 'SBFEATTRV1INS')), PROJECT(le, SBFEInsVersion(LEFT))) +
					DATASET([], iesp.smallbusinessanalytics.t_SBAAttributesGroup);
		SELF._Header := [];
		SELF := [];
	END;

	Final_Results := PROJECT(SBA_Results, intoESDL(LEFT));


	intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Business_Shell) : STORED('Intermediate_Log');
	// Note: All intermediate logs must have the following name schema:
	// Starts with 'LOG_' (Upper case is important!!)
	// Middle part is the database name, in this case: 'log__mbs'
	// Must end with '_intermediate__log'
	IF(~DisableOutcomeTracking AND ~TestDataEnabled, OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log')) );

	// Calculate royalties. For SBFE...:
	SBFE_royalties := IF( TestDataEnabled, Royalty.RoyaltySBFE.GetNoRoyalties(), Royalty.RoyaltySBFE.GetOnlineRoyalties(SBA_Results) );

	// ...and for Targus Gateway:
	Business_Risk_BIP.Layouts.LayoutSources xfm_normPhoneSources(Business_Risk_BIP.Layouts.LayoutSources ri) :=
		TRANSFORM
			SELF := ri;
		END;

	PhoneSources :=
		NORMALIZE(
			UNGROUP(SBA_Results_Temp_with_PhoneSources),
			LEFT.PhoneSources,
			xfm_normPhoneSources(RIGHT)
		);

	Targus_hit := COUNT(PhoneSources(source = MDR.sourceTools.src_Targus_Gateway)) > 0;
	TargusType := IF( Targus_hit, Phones.Constants.TargusType.WirelessConnectionSearch + Phones.Constants.TargusType.PhoneDataExpress, '' );
	Targus_PhoneSource := PhoneSources(source = MDR.sourceTools.src_Targus_Gateway);
	Targus_royalties := Royalty.RoyaltyTargus.GetOnlineRoyalties(Targus_PhoneSource, source, TargusType, TRUE, TRUE, FALSE, FALSE);

	/* ************************************************************************
	**                    Tracking Cortera Royalties                          *
	***************************************************************************/
	isTrackingCorteraFromSBA21 := EXISTS(AttributesRequested(AttributeGroup = Std.Str.ToUpperCase(LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V21_NAME)));
	Cortera_royalties := IF(TestDataEnabled, Royalty.RoyaltyCortera.InHouse.GetNoRoyalties(), Royalty.RoyaltyCortera.InHouse.GetOnlineRoyalties(SBA_Results, isTrackingCorteraFromSBA21));

	// Accumulate all Royalties:
	total_royalties := SBFE_royalties + Targus_royalties + Cortera_royalties;

	OUTPUT(total_royalties, NAMED('RoyaltySet'));

	//Log to Deltabase
	Deltabase_Logging_prep := PROJECT(Final_Results, TRANSFORM(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
                                    SELF.company_id := (INTEGER)CompanyID,
                                    SELF.login_id := _LoginID,
                                    SELF.product_id := Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_BIP_Service,
                                    SELF.function_name := FunctionName,
                                    SELF.esp_method := ESPMethod,
                                    SELF.interface_version := InterfaceVersion,
                                    SELF.delivery_method := DeliveryMethod,
                                    SELF.date_added := (STRING8)Std.Date.Today(),
                                    SELF.death_master_purpose := DeathMasterPurpose,
                                    SELF.ssn_mask := IF(SSN_Mask = 'NONE', '', SSN_Mask),
                                    SELF.dob_mask := IF(DOB_Mask = 'NONE', '', DOB_Mask),
                                    SELF.dl_mask := (STRING)(INTEGER)DL_Mask,
                                    SELF.exclude_dmv_pii := (STRING)(INTEGER)ExcludeDMVPII,
                                    SELF.scout_opt_out := (STRING)(INTEGER)DisableOutcomeTracking,
                                    SELF.archive_opt_in := (STRING)(INTEGER)ArchiveOptIn,
                                    SELF.glb := GLBA_Purpose,
                                    SELF.dppa := DPPA_Purpose,
                                    SELF.data_restriction_mask := DataRestrictionMask,
                                    SELF.data_permission_mask := DataPermissionMask,
                                    SELF.industry := Industry_Search[1].Industry,
                                    SELF.i_attributes_name := AttributesRequested[1].AttributeGroup,
                                    SELF.i_ssn := search.AuthorizedRep1.SSN,
                                    SELF.i_dob := Rep_1_DOB,
                                    SELF.i_name_full := search.AuthorizedRep1.Name.Full,
                                    SELF.i_name_first := search.AuthorizedRep1.Name.First,
                                    SELF.i_name_last := search.AuthorizedRep1.Name.Last,
                                    SELF.i_lexid := (Integer)search.AuthorizedRep1.UniqueId,
                                    SELF.i_address := IF(TRIM(search.AuthorizedRep1.address.streetaddress1)!='', search.AuthorizedRep1.address.streetaddress1,
                                                             Address.Addr1FromComponents(search.AuthorizedRep1.address.streetnumber,
                                                             search.AuthorizedRep1.address.streetpredirection, search.AuthorizedRep1.address.streetname,
                                                             search.AuthorizedRep1.address.streetsuffix, search.AuthorizedRep1.address.streetpostdirection,
                                                             search.AuthorizedRep1.address.unitdesignation, search.AuthorizedRep1.address.unitnumber)),
                                    SELF.i_city := search.AuthorizedRep1.address.City,
                                    SELF.i_state := search.AuthorizedRep1.address.State,
                                    SELF.i_zip := search.AuthorizedRep1.address.Zip5,
                                    SELF.i_dl := search.AuthorizedRep1.DriverLicenseNumber,
                                    SELF.i_dl_state := search.AuthorizedRep1.DriverLicenseState,
                                    SELF.i_home_phone := Rep_1_Phone10,
                                    SELF.i_tin := search.Company.FEIN,
                                    SELF.i_name_first_2 := search.AuthorizedRep2.Name.First,
                                    SELF.i_name_last_2 := search.AuthorizedRep2.Name.Last,
                                    SELF.i_name_first_3 := search.AuthorizedRep3.Name.First,
                                    SELF.i_name_last_3 := search.AuthorizedRep3.Name.Last,
                                    SELF.i_bus_name := search.Company.CompanyName,
                                    SELF.i_alt_bus_name := search.Company.AlternateCompanyName,
                                    SELF.i_bus_address := IF(TRIM(search.Company.address.streetaddress1)!='', search.Company.address.streetaddress1,
                                                                 Address.Addr1FromComponents(search.Company.address.streetnumber,
                                                                 search.Company.address.streetpredirection, search.Company.address.streetname,
                                                                 search.Company.address.streetsuffix, search.Company.address.streetpostdirection,
                                                                 search.Company.address.unitdesignation, search.Company.address.unitnumber)),
                                    SELF.i_bus_city := search.Company.address.City,
                                    SELF.i_bus_state := search.Company.address.State,
                                    SELF.i_bus_zip := search.Company.address.Zip5,
                                    SELF.i_bus_phone := search.Company.Phone,
                                    SELF.i_model_name_1 := ModelsRequested[1].ModelName,
                                    SELF.i_model_name_2 := ModelsRequested[2].ModelName,
                                    SELF.o_score_1    := IF(ModelsRequested[1].ModelName != '', (STRING)LEFT.Result.Models[1].Scores[1].Value, ''),
                                    SELF.o_reason_1_1 := LEFT.Result.Models[1].Scores[1].ScoreReasons[1].ReasonCode,
                                    SELF.o_reason_1_2 := LEFT.Result.Models[1].Scores[1].ScoreReasons[2].ReasonCode,
                                    SELF.o_reason_1_3 := LEFT.Result.Models[1].Scores[1].ScoreReasons[3].ReasonCode,
                                    SELF.o_reason_1_4 := LEFT.Result.Models[1].Scores[1].ScoreReasons[4].ReasonCode,
                                    SELF.o_reason_1_5 := LEFT.Result.Models[1].Scores[1].ScoreReasons[5].ReasonCode,
                                    SELF.o_reason_1_6 := LEFT.Result.Models[1].Scores[1].ScoreReasons[6].ReasonCode,
                                    SELF.o_score_2    := IF(ModelsRequested[2].ModelName != '', (STRING)LEFT.Result.Models[2].Scores[1].Value, '');
                                    SELF.o_reason_2_1 := LEFT.Result.Models[2].Scores[1].ScoreReasons[1].ReasonCode,
                                    SELF.o_reason_2_2 := LEFT.Result.Models[2].Scores[1].ScoreReasons[2].ReasonCode,
                                    SELF.o_reason_2_3 := LEFT.Result.Models[2].Scores[1].ScoreReasons[3].ReasonCode,
                                    SELF.o_reason_2_4 := LEFT.Result.Models[2].Scores[1].ScoreReasons[4].ReasonCode,
                                    SELF.o_reason_2_5 := LEFT.Result.Models[2].Scores[1].ScoreReasons[5].ReasonCode,
                                    SELF.o_reason_2_6 := LEFT.Result.Models[2].Scores[1].ScoreReasons[6].ReasonCode,
                                    SELF.o_lexid := SBA_Results[1].Rep_LexID,
                                    SELF.o_seleid := LEFT.Result.BusinessID.SeleID,
                                    SELF := LEFT,
                                    SELF := [] ));

	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);

	//Improved Scout Logging
	IF(~DisableOutcomeTracking AND ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

	// DEBUGs:
	// OUTPUT(inBandDateYYYYMM, NAMED('inBandDateYYYYMM'));
	// OUTPUT(HistoryDateYYYYMM, NAMED('HistoryDateYYYYMM'));
	// OUTPUT(SBA_20_Request, NAMED('SBA_20_Request'));
	// OUTPUT(SBA_Results_Temp_with_PhoneSources, NAMED('SBA_Results_Temp_with_PhoneSources'));
	// OUTPUT(SBA_Results_Temp, NAMED('SBA_Results_Temp'));
	// OUTPUT(NameValuePairsSBFEIns, NAMED('NameValuePairsSBFEIns'));
	// OUTPUT(AttributesRequested, NAMED('AttributesRequested'));
	// OUTPUT( PhoneSources, NAMED('PhoneSources') );
	// OUTPUT( SBA_Results_Temp_with_PhoneSources, NAMED('IntLayoutWithPhones') );
	// OUTPUT( 'DPPA_Purpose: ' + DPPA_Purpose );
	// OUTPUT( 'GLBA_Purpose: ' + GLBA_Purpose );
	// OUTPUT( 'DataRestrictionMask: ' + DataRestrictionMask );
	// OUTPUT( 'DataPermissionMask: ' + DataPermissionMask );
	// OUTPUT( 'IndustryClass: ' + IndustryClass );

	RETURN OUTPUT(Final_Results, NAMED('Results'));

	#END
END;
