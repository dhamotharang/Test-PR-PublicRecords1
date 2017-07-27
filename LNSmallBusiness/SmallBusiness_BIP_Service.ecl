/*--SOAP--
<message name="SmallBusiness_BIP_Service" wuTimeout="300000">
	<part name="SmallBusinessAnalyticsRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
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
/*--HELP--
<pre>
SmallBusinessAnalyticsRequest XML:
&lt;lnsmallbusiness.smallbusiness_bip_serviceRequest&gt;
&lt;SmallBusinessAnalyticsRequest&gt;
  &lt;Row&gt;
    &lt;User&gt;
      &lt;GLBPurpose&gt;1&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;1&lt;/DLPurpose&gt;
      &lt;IndustryClass&gt;&lt;/IndustryClass&gt;
      &lt;DataRestrictionMask&gt;00000000000000000000&lt;/DataRestrictionMask&gt;
      &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
      &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt;
      &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt;
      &lt;OutcomeTrackingOptOut&gt;0&lt;/OutcomeTrackingOptOut&gt;
    &lt;/User&gt;
    &lt;Options&gt;
      &lt;AttributesVersionRequest&gt;
        &lt;Name&gt;SmallBusinessAttrV1&lt;/Name&gt;
      &lt;/AttributesVersionRequest&gt;
      &lt;IncludeModels&gt;
        &lt;Names&gt;
          &lt;Name&gt;&lt;/Name&gt;
        &lt;/Names&gt;
        &lt;ModelOptions&gt;
          &lt;ModelOption&gt;
           &lt;OptionName&gt;&lt;/OptionName&gt;
           &lt;OptionValue&gt;&lt;/OptionValue&gt;
          &lt;/ModelOption&gt;
        &lt;/ModelOptions&gt;
      &lt;/IncludeModels&gt;
    &lt;/Options&gt;
    &lt;SearchBy&gt;
      &lt;Company&gt;
        &lt;CompanyName&gt;&lt;/CompanyName&gt;
        &lt;AlternateCompanyName&gt;&lt;/AlternateCompanyName&gt;
        &lt;Address&gt;
          &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
          &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
          &lt;StreetName&gt;&lt;/StreetName&gt;
          &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
          &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
          &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
          &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
          &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
          &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
          &lt;City&gt;&lt;/City&gt;
          &lt;State&gt;&lt;/State&gt;
          &lt;Zip5&gt;&lt;/Zip5&gt;
          &lt;Zip4&gt;&lt;/Zip4&gt;
        &lt;/Address&gt;
        &lt;Phone&gt;&lt;/Phone&gt;
        &lt;FaxNumber&gt;&lt;/FaxNumber&gt;
        &lt;FEIN&gt;&lt;/FEIN&gt;
        &lt;SICCode&gt;&lt;/SICCode&gt;
        &lt;NAICCode&gt;&lt;/NAICCode&gt;
        &lt;BusinessStructure&gt;&lt;/BusinessStructure&gt;
        &lt;YearsInBusiness&gt;&lt;/YearsInBusiness&gt;
        &lt;BusinessStartDate&gt;
          &lt;Year&gt;&lt;/Year&gt;
          &lt;Month&gt;&lt;/Month&gt;
          &lt;Day&gt;&lt;/Day&gt;
        &lt;/BusinessStartDate&gt;
        &lt;YearlyRevenue&gt;&lt;/YearlyRevenue&gt;
      &lt;/Company&gt;
      &lt;AuthorizedRep1&gt;
        &lt;Name&gt;
          &lt;Full&gt;&lt;/Full&gt;
          &lt;First&gt;&lt;/First&gt;
          &lt;Middle&gt;&lt;/Middle&gt;
          &lt;Last&gt;&lt;/Last&gt;
          &lt;Suffix&gt;&lt;/Suffix&gt;
          &lt;Prefix&gt;&lt;/Prefix&gt;
        &lt;/Name&gt;
        &lt;FormerLastName&gt;&lt;/FormerLastName&gt;
        &lt;Address&gt;
          &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
          &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
          &lt;StreetName&gt;&lt;/StreetName&gt;
          &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
          &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
          &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
          &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
          &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
          &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
          &lt;City&gt;&lt;/City&gt;
          &lt;State&gt;&lt;/State&gt;
          &lt;Zip5&gt;&lt;/Zip5&gt;
          &lt;Zip4&gt;&lt;/Zip4&gt;
        &lt;/Address&gt;
        &lt;DOB&gt;
          &lt;Year&gt;&lt;/Year&gt;
          &lt;Month&gt;&lt;/Month&gt;
          &lt;Day&gt;&lt;/Day&gt;
        &lt;/DOB&gt;
        &lt;Age&gt;&lt;/Age&gt;
        &lt;SSN&gt;&lt;/SSN&gt;
        &lt;Phone&gt;&lt;/Phone&gt;
        &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
        &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
        &lt;BusinessTitle&gt;&lt;/BusinessTitle&gt;
      &lt;/AuthorizedRep1&gt;
      &lt;AuthorizedRep2&gt;
        &lt;Name&gt;
          &lt;Full&gt;&lt;/Full&gt;
          &lt;First&gt;&lt;/First&gt;
          &lt;Middle&gt;&lt;/Middle&gt;
          &lt;Last&gt;&lt;/Last&gt;
          &lt;Suffix&gt;&lt;/Suffix&gt;
          &lt;Prefix&gt;&lt;/Prefix&gt;
        &lt;/Name&gt;
        &lt;FormerLastName&gt;&lt;/FormerLastName&gt;
        &lt;Address&gt;
          &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
          &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
          &lt;StreetName&gt;&lt;/StreetName&gt;
          &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
          &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
          &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
          &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
          &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
          &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
          &lt;City&gt;&lt;/City&gt;
          &lt;State&gt;&lt;/State&gt;
          &lt;Zip5&gt;&lt;/Zip5&gt;
          &lt;Zip4&gt;&lt;/Zip4&gt;
        &lt;/Address&gt;
        &lt;DOB&gt;
          &lt;Year&gt;&lt;/Year&gt;
          &lt;Month&gt;&lt;/Month&gt;
          &lt;Day&gt;&lt;/Day&gt;
        &lt;/DOB&gt;
        &lt;Age&gt;&lt;/Age&gt;
        &lt;SSN&gt;&lt;/SSN&gt;
        &lt;Phone&gt;&lt;/Phone&gt;
        &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
        &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
        &lt;BusinessTitle&gt;&lt;/BusinessTitle&gt;
      &lt;/AuthorizedRep2&gt;
      &lt;AuthorizedRep3&gt;
        &lt;Name&gt;
          &lt;Full&gt;&lt;/Full&gt;
          &lt;First&gt;&lt;/First&gt;
          &lt;Middle&gt;&lt;/Middle&gt;
          &lt;Last&gt;&lt;/Last&gt;
          &lt;Suffix&gt;&lt;/Suffix&gt;
          &lt;Prefix&gt;&lt;/Prefix&gt;
        &lt;/Name&gt;
        &lt;FormerLastName&gt;&lt;/FormerLastName&gt;
        &lt;Address&gt;
          &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
          &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
          &lt;StreetName&gt;&lt;/StreetName&gt;
          &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
          &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
          &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
          &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
          &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
          &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
          &lt;City&gt;&lt;/City&gt;
          &lt;State&gt;&lt;/State&gt;
          &lt;Zip5&gt;&lt;/Zip5&gt;
          &lt;Zip4&gt;&lt;/Zip4&gt;
        &lt;/Address&gt;
        &lt;DOB&gt;
          &lt;Year&gt;&lt;/Year&gt;
          &lt;Month&gt;&lt;/Month&gt;
          &lt;Day&gt;&lt;/Day&gt;
        &lt;/DOB&gt;
        &lt;Age&gt;&lt;/Age&gt;
        &lt;SSN&gt;&lt;/SSN&gt;
        &lt;Phone&gt;&lt;/Phone&gt;
        &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
        &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
        &lt;BusinessTitle&gt;&lt;/BusinessTitle&gt;
      &lt;/AuthorizedRep3&gt;
    &lt;/SearchBy&gt;
  &lt;/Row&gt;
&lt;/SmallBusinessAnalyticsRequest&gt;
&lt;Watchlists_Requested&gt;
  &lt;Row&gt;&lt;/Row&gt;
&lt;/Watchlists_Requested&gt;
&lt;/lnsmallbusiness.smallbusiness_bip_serviceRequest&gt;
</pre>
*/
#option('expandSelectCreateRow', true);
#option('embeddedWarningsAsErrors', 0);
IMPORT Address, Business_Risk_BIP, Gateway, IESP, MDR, Phones, Risk_Indicators, Risk_Reporting, RiskWise,
			 Royalty, Suspicious_Fraud_LN, UT, Royalty, Models, Inquiry_AccLogs, STD;

EXPORT SmallBusiness_BIP_Service() := FUNCTION
	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'SmallBusinessAnalyticsRequest',
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
	'RunTargusGatewayAnywayForTesting'
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
	#STORED('IndustryClass'      ,Business_Risk_BIP.Constants.Default_IndustryClass)

	requestIn := DATASET([], iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsRequest) : STORED('SmallBusinessAnalyticsRequest', FEW);
  firstRow  := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	search    := GLOBAL(firstRow.SearchBy);
	option    := GLOBAL(firstRow.Options);
	users     := GLOBAL(firstRow.User); 
	
/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := if(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	outofbandssnmask                := '' : STORED('SSNMask');
	string10 SSN_Mask               := if(users.SSNMask != '', users.SSNMask, outofbandssnmask);
	outofbanddobmask                := '' : STORED('DOBMask');
	string10 DOB_Mask               := if(users.DOBMask != '', users.DOBMask, outofbanddobmask);
	BOOLEAN DL_Mask                 := users.DLMask;
	BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');
	BOOLEAN DisableIntermediateShellLoggingOutOfBand := FALSE : STORED('OutcomeTrackingOptOut');
	DisableOutcomeTracking := DisableIntermediateShellLoggingOutOfBand OR users.OutcomeTrackingOptOut;

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_BIP_Service);
/* ************* End Scout Fields **************/

	UNSIGNED1 DPPAPurpose_stored      := Business_Risk_BIP.Constants.Default_DPPA                : STORED('DPPAPurpose');
	UNSIGNED1 GLBPurpose_stored       := Business_Risk_BIP.Constants.Default_GLBA                : STORED('GLBPurpose');
	STRING DataRestrictionMask_stored := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('DataRestrictionMask');
	STRING DataPermissionMask_stored  := Business_Risk_BIP.Constants.Default_DataPermissionMask  : STORED('DataPermissionMask');
	STRING5 IndustryClass_stored      := Business_Risk_BIP.Constants.Default_IndustryClass       : STORED('IndustryClass');

	// Below we'll prefer users.DataRestrictionMask, users.DataPermissionMask, users.industryclass, etc., over
	// DataRestrictionMask_stored, DataPermissionMask_stored, etc., since they are "internal" or overridden values
	// populated for Development/QA purposes, etc.
	
	STRING30 AcctNo := users.AccountNumber;
	// Business Input Information
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
	// Option Fields
	UNSIGNED3 HistoryDateYYYYMM		 := 0 : STORED('HistoryDateYYYYMM');
	UNSIGNED6 HistoryDate          := 0 : STORED('HistoryDate');
	UNSIGNED1	DPPA_Purpose         := IF(TRIM(users.DLPurpose) <> '', (INTEGER)users.DLPurpose, DPPAPurpose_stored);
	UNSIGNED1	GLBA_Purpose         := IF(TRIM(users.GLBPurpose) <> '', (INTEGER)users.GLBPurpose, GLBPurpose_stored);
	STRING  DataRestrictionMask    := IF(TRIM(users.DataRestrictionMask) <> '', users.DataRestrictionMask, DataRestrictionMask_stored);
	STRING  DataPermissionMask		 := IF(TRIM(users.DataPermissionMask) <> '', users.DataPermissionMask, DataPermissionMask_stored);
	STRING5	IndustryClass		   		 := StringLib.StringToUpperCase(TRIM( IF( users.industryclass <> '', users.industryclass, IndustryClass_stored ) , LEFT, RIGHT ));
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
	
	// SmallBusinessAttrV1 (etc) is a valid input
	AttributesRequested := PROJECT(option.AttributesVersionRequest, TRANSFORM(LNSmallBusiness.Layouts.AttributeGroupRec, SELF.AttributeGroup := StringLib.StringToUpperCase(LEFT.Value)));
	ModelsRequested := PROJECT(option.IncludeModels.Names, TRANSFORM(LNSmallBusiness.Layouts.ModelNameRec, SELF.ModelName := StringLib.StringToUpperCase(LEFT.Value)));
	ModelOptions := PROJECT(option.IncludeModels.ModelOptions, TRANSFORM(LNSmallBusiness.Layouts.ModelOptionsRec, SELF.OptionName := StringLib.StringToUpperCase(TRIM(LEFT.OptionName, LEFT, RIGHT));
																																																								SELF.OptionValue := LEFT.OptionValue));
	
	Gateways 											 := Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus
	
	LNSmallBusiness.BIP_Layouts.Input intoInputLayout(ut.ds_oneRecord le) := TRANSFORM
		SELF.AcctNo := AcctNo;
		SELF.HistoryDateYYYYMM := HistoryDateYYYYMM;
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
		
		SELF := [];
	END;
	Input := PROJECT(ut.ds_oneRecord, intoInputLayout(LEFT));
	
	/* *************************************
	 *            Validate Input:          *
   *************************************** */
	MinimumInputMetForOption1 := TRIM(Bus_Company_Name) <> '' AND TRIM(Bus_Street_Address1) <> '' AND TRIM(Bus_Zip) <> '';
	MinimumInputMetForOption2 := TRIM(Bus_Company_Name) <> '' AND TRIM(Bus_Street_Address1) <> '' AND TRIM(Bus_City) <> '' AND TRIM(Bus_State) <> '';
	// Authorized Rep information is not required on input, however if provided at a minimum First and Last Name must be populated
	MinimumInputMetForAuthorizedRep := (TRIM(Rep_1_Full_Name) <> '' OR TRIM(Rep_2_Full_Name) <> '' OR TRIM(Rep_3_Full_Name) <> '') OR // The full name was populated for one of the Auth Rep fields
																		 (TRIM(Rep_1_First_Name) <> '' AND TRIM(Rep_1_Last_Name) <> '') OR // Both First and Last were populated
																		 (TRIM(Rep_2_First_Name) <> '' AND TRIM(Rep_2_Last_Name) <> '') OR
																		 (TRIM(Rep_3_First_Name) <> '' AND TRIM(Rep_3_Last_Name) <> '') OR
																		  // No Auth rep information was passed in
																		 (TRIM(Rep_1_Full_Name) = '' AND TRIM(Rep_1_First_Name) = '' AND TRIM(Rep_1_Last_Name) = '' AND
																		  TRIM(Rep_2_Full_Name) = '' AND TRIM(Rep_2_First_Name) = '' AND TRIM(Rep_2_Last_Name) = '' AND
																			TRIM(Rep_3_Full_Name) = '' AND TRIM(Rep_3_First_Name) = '' AND TRIM(Rep_3_Last_Name) = '' AND
																			TRIM(Rep_1_SSN) = '' AND TRIM(Rep_1_DOB) = '' AND TRIM(Rep_1_Street_Address1) = '' AND TRIM(Rep_1_City) = '' AND TRIM(Rep_1_State) = '' AND TRIM(Rep_1_Zip) = '' AND TRIM(Rep_1_Phone10) = '' AND TRIM(Rep_1_DL_Number) = '' AND
																			TRIM(Rep_2_SSN) = '' AND TRIM(Rep_2_DOB) = '' AND TRIM(Rep_2_Street_Address1) = '' AND TRIM(Rep_2_City) = '' AND TRIM(Rep_2_State) = '' AND TRIM(Rep_2_Zip) = '' AND TRIM(Rep_2_Phone10) = '' AND TRIM(Rep_2_DL_Number) = '' AND
																			TRIM(Rep_3_SSN) = '' AND TRIM(Rep_3_DOB) = '' AND TRIM(Rep_3_Street_Address1) = '' AND TRIM(Rep_3_City) = '' AND TRIM(Rep_3_State) = '' AND TRIM(Rep_3_Zip) = '' AND TRIM(Rep_3_Phone10) = '' AND TRIM(Rep_3_DL_Number) = ''
																		 );
																		 
	IF((MinimumInputMetForOption1 = FALSE AND MinimumInputMetForOption2 = FALSE) OR // Minimum Business Inputs not met
		 ((MinimumInputMetForOption1 = TRUE OR MinimumInputMetForOption2 = TRUE) AND MinimumInputMetForAuthorizedRep = FALSE), // Minimum Business Inputs met, but minimum Authorized Rep Inputs not met
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
																														LNSmallBusiness.Constants.BIPID_WEIGHT_THRESHOLD.FOR_SmallBusiness_BIP_Service
																														);

	SBA_Results_Temp := PROJECT( SBA_Results_Temp_with_PhoneSources, LNSmallBusiness.BIP_Layouts.IntermediateLayout );
	
	#if(Models.LIB_BusinessRisk_Models().TurnOnValidation) // If TRUE, output the model results directly
		
	RETURN OUTPUT(SBA_Results_Temp, NAMED('Results'));
		
	#else	
	SBA_Results := IF(TestDataEnabled = FALSE, SBA_Results_Temp,
																	/* else */ LNSmallBusiness.SmallBusiness_BIP_Testseed_Function(Input,
																						 TestDataTableName,
																						 DataPermissionMask,
																						 ModelsRequested));
	
	/* ************************************************************************
	 * Transform the Small Business Attributes and Scores Results into IESP   *
	 ************************************************************************ */
	// Merge the Name/Value pairs together
	iesp.share.t_NameValuePair createRecord(STRING Name, STRING Value) := TRANSFORM
		SELF.Name := Name;
		SELF.Value := Value;
	END;
	
	// Create Version 1 Name/Value Pair Attributes
	iesp.share.t_NameValuePair intoVersion1(LNSmallBusiness.BIP_Layouts.IntermediateLayout le, UNSIGNED AttributeNumber) := TRANSFORM
		SELF := CASE(AttributeNumber, 
				1	=> ROW(createRecord('InputCheckBusName',	le.InputCheckBusName)),
				2	=> ROW(createRecord('InputCheckBusAltName',	le.InputCheckBusAltName)),
				3	=> ROW(createRecord('InputCheckBusAddr',	le.InputCheckBusAddr)),
				4	=> ROW(createRecord('InputCheckBusCity',	le.InputCheckBusCity)),
				5	=> ROW(createRecord('InputCheckBusState',	le.InputCheckBusState)),
				6	=> ROW(createRecord('InputCheckBusZip',	le.InputCheckBusZip)),
				7	=> ROW(createRecord('InputCheckBusFEIN',	le.InputCheckBusFEIN)),
				8	=> ROW(createRecord('InputCheckBusPhone',	le.InputCheckBusPhone)),
				9	=> ROW(createRecord('InputCheckBusSIC',	le.InputCheckBusSIC)),
				10	=> ROW(createRecord('InputCheckBusNAICS',	le.InputCheckBusNAICS)),
				11	=> ROW(createRecord('InputCheckBusStructure',	le.InputCheckBusStructure)),
				12	=> ROW(createRecord('InputCheckBusAge',	le.InputCheckBusAge)),
				13	=> ROW(createRecord('InputCheckBusStartDate',	le.InputCheckBusStartDate)),
				14	=> ROW(createRecord('InputCheckBusAnnualRevenue',	le.InputCheckBusAnnualRevenue)),
				15	=> ROW(createRecord('InputCheckBusFax',	le.InputCheckBusFax)),
				16	=> ROW(createRecord('InputCheckAuthRepFirstName',	le.InputCheckAuthRepFirstName)),
				17	=> ROW(createRecord('InputCheckAuthRepLastName',	le.InputCheckAuthRepLastName)),
				18	=> ROW(createRecord('InputCheckAuthRepMiddleName',	le.InputCheckAuthRepMiddleName)),
				19	=> ROW(createRecord('InputCheckAuthRepAddr',	le.InputCheckAuthRepAddr)),
				20	=> ROW(createRecord('InputCheckAuthRepCity',	le.InputCheckAuthRepCity)),
				21	=> ROW(createRecord('InputCheckAuthRepState',	le.InputCheckAuthRepState)),
				22	=> ROW(createRecord('InputCheckAuthRepZip',	le.InputCheckAuthRepZip)),
				23	=> ROW(createRecord('InputCheckAuthRepSSN',	le.InputCheckAuthRepSSN)),
				24	=> ROW(createRecord('InputCheckAuthRepPhone',	le.InputCheckAuthRepPhone)),
				25	=> ROW(createRecord('InputCheckAuthRepDOB',	le.InputCheckAuthRepDOB)),
				26	=> ROW(createRecord('InputCheckAuthRepAge',	le.InputCheckAuthRepAge)),
				27	=> ROW(createRecord('InputCheckAuthRepTitle',	le.InputCheckAuthRepTitle)),
				28	=> ROW(createRecord('InputCheckAuthRepDL',	le.InputCheckAuthRepDL)),
				29	=> ROW(createRecord('InputCheckAuthRepDLState',	le.InputCheckAuthRepDLState)),
				30	=> ROW(createRecord('InputCheckAuthRep2FirstName',	le.InputCheckAuthRep2FirstName)),
				31	=> ROW(createRecord('InputCheckAuthRep2LastName',	le.InputCheckAuthRep2LastName)),
				32	=> ROW(createRecord('InputCheckAuthRep2MiddleName',	le.InputCheckAuthRep2MiddleName)),
				33	=> ROW(createRecord('InputCheckAuthRep2Addr',	le.InputCheckAuthRep2Addr)),
				34	=> ROW(createRecord('InputCheckAuthRep2City',	le.InputCheckAuthRep2City)),
				35	=> ROW(createRecord('InputCheckAuthRep2State',	le.InputCheckAuthRep2State)),
				36	=> ROW(createRecord('InputCheckAuthRep2Zip',	le.InputCheckAuthRep2Zip)),
				37	=> ROW(createRecord('InputCheckAuthRep2SSN',	le.InputCheckAuthRep2SSN)),
				38	=> ROW(createRecord('InputCheckAuthRep2Phone',	le.InputCheckAuthRep2Phone)),
				39	=> ROW(createRecord('InputCheckAuthRep2DOB',	le.InputCheckAuthRep2DOB)),
				40	=> ROW(createRecord('InputCheckAuthRep2Age',	le.InputCheckAuthRep2Age)),
				41	=> ROW(createRecord('InputCheckAuthRep2Title',	le.InputCheckAuthRep2Title)),
				42	=> ROW(createRecord('InputCheckAuthRep2DL',	le.InputCheckAuthRep2DL)),
				43	=> ROW(createRecord('InputCheckAuthRep2DLState',	le.InputCheckAuthRep2DLState)),
				44	=> ROW(createRecord('InputCheckAuthRep3FirstName',	le.InputCheckAuthRep3FirstName)),
				45	=> ROW(createRecord('InputCheckAuthRep3LastName',	le.InputCheckAuthRep3LastName)),
				46	=> ROW(createRecord('InputCheckAuthRep3MiddleName',	le.InputCheckAuthRep3MiddleName)),
				47	=> ROW(createRecord('InputCheckAuthRep3Addr',	le.InputCheckAuthRep3Addr)),
				48	=> ROW(createRecord('InputCheckAuthRep3City',	le.InputCheckAuthRep3City)),
				49	=> ROW(createRecord('InputCheckAuthRep3State',	le.InputCheckAuthRep3State)),
				50	=> ROW(createRecord('InputCheckAuthRep3Zip',	le.InputCheckAuthRep3Zip)),
				51	=> ROW(createRecord('InputCheckAuthRep3SSN',	le.InputCheckAuthRep3SSN)),
				52	=> ROW(createRecord('InputCheckAuthRep3Phone',	le.InputCheckAuthRep3Phone)),
				53	=> ROW(createRecord('InputCheckAuthRep3DOB',	le.InputCheckAuthRep3DOB)),
				54	=> ROW(createRecord('InputCheckAuthRep3Age',	le.InputCheckAuthRep3Age)),
				55	=> ROW(createRecord('InputCheckAuthRep3Title',	le.InputCheckAuthRep3Title)),
				56	=> ROW(createRecord('InputCheckAuthRep3DL',	le.InputCheckAuthRep3DL)),
				57	=> ROW(createRecord('InputCheckAuthRep3DLState',	le.InputCheckAuthRep3DLState)),
				58	=> ROW(createRecord('VerificationBusInputName',	le.VerificationBusInputName)),
				59	=> ROW(createRecord('VerificationBusInputAddr',	le.VerificationBusInputAddr)),
				60	=> ROW(createRecord('VerificationBusInputPhone',	le.VerificationBusInputPhone)),
				61	=> ROW(createRecord('VerificationBusInputFEIN',	le.VerificationBusInputFEIN)),
				62	=> ROW(createRecord('VerificationBusInputIndustry',	le.VerificationBusInputIndustry)),
				63	=> ROW(createRecord('BusinessRecordTimeOldest',	le.BusinessRecordTimeOldest)),
				64	=> ROW(createRecord('BusinessRecordTimeNewest',	le.BusinessRecordTimeNewest)),
				65	=> ROW(createRecord('BusinessRecordUpdated12Month',	le.BusinessRecordUpdated12Month)),
				66	=> ROW(createRecord('BusinessActivity03Month',	le.BusinessActivity03Month)),
				67	=> ROW(createRecord('BusinessActivity06Month',	le.BusinessActivity06Month)),
				68	=> ROW(createRecord('BusinessActivity12Month',	le.BusinessActivity12Month)),
				69	=> ROW(createRecord('BusinessAddrCount',	le.BusinessAddrCount)),
				70	=> ROW(createRecord('FirmAgeEstablished',	le.FirmAgeEstablished)),
				71	=> ROW(createRecord('FirmSICCode',	le.FirmSICCode)),
				72	=> ROW(createRecord('FirmNAICSCode',	le.FirmNAICSCode)),
				73	=> ROW(createRecord('FirmEmployeeCount',	le.FirmEmployeeCount)),
				74	=> ROW(createRecord('FirmReportedSales',	le.FirmReportedSales)),
				75	=> ROW(createRecord('FirmReportedEarnings',	le.FirmReportedEarnings)),
				76	=> ROW(createRecord('FirmIRSRetirementPlan',	le.FirmIRSRetirementPlan)),
				77	=> ROW(createRecord('FirmNonProfit',	le.FirmNonProfit)),
				78	=> ROW(createRecord('OrgLocationCount',	le.OrgLocationCount)),
				79	=> ROW(createRecord('OrgRelatedCount',	le.OrgRelatedCount)),
				80	=> ROW(createRecord('OrgParentCompany',	le.OrgParentCompany)),
				81	=> ROW(createRecord('OrgLegalEntityCount',	le.OrgLegalEntityCount)),
				82	=> ROW(createRecord('OrgAddrLegalEntityCount',	le.OrgAddrLegalEntityCount)),
				83	=> ROW(createRecord('OrgSingleLocation',	le.OrgSingleLocation)),
				84	=> ROW(createRecord('SOSTimeIncorporation',	le.SOSTimeIncorporation)),
				85	=> ROW(createRecord('SOSTimeAgentChange',	le.SOSTimeAgentChange)),
				86	=> ROW(createRecord('SOSEverDefunct',	le.SOSEverDefunct)),
				87	=> ROW(createRecord('SOSStateCount',	le.SOSStateCount)),
				88	=> ROW(createRecord('SOSForeignStateFlag',	le.SOSForeignStateFlag)),
				89	=> ROW(createRecord('BankruptcyCount',	le.BankruptcyCount)),
				90	=> ROW(createRecord('BankruptcyCount12Month',	le.BankruptcyCount12Month)),
				91	=> ROW(createRecord('BankruptcyCount24Month',	le.BankruptcyCount24Month)),
				92	=> ROW(createRecord('BankruptcyChapter',	le.BankruptcyChapter)),
				93	=> ROW(createRecord('BankruptcyTimeNewest',	le.BankruptcyTimeNewest)),
				94	=> ROW(createRecord('LienCount',	le.LienCount)),
				95	=> ROW(createRecord('LienCount12Month',	le.LienCount12Month)),
				96	=> ROW(createRecord('LienCount24Month',	le.LienCount24Month)),
				97	=> ROW(createRecord('LienType',	le.LienType)),
				98	=> ROW(createRecord('LienTimeNewest',	le.LienTimeNewest)),
				99	=> ROW(createRecord('LienTimeOldest',	le.LienTimeOldest)),
				100	=> ROW(createRecord('LienDollarTotal',	le.LienDollarTotal)),
				101	=> ROW(createRecord('JudgmentCount',	le.JudgmentCount)),
				102	=> ROW(createRecord('JudgmentCount12Month',	le.JudgmentCount12Month)),
				103	=> ROW(createRecord('JudgmentCount24Month',	le.JudgmentCount24Month)),
				104	=> ROW(createRecord('JudgmentType',	le.JudgmentType)),
				105	=> ROW(createRecord('JudgmentTimeNewest',	le.JudgmentTimeNewest)),
				106	=> ROW(createRecord('JudgmentTimeOldest',	le.JudgmentTimeOldest)),
				107	=> ROW(createRecord('JudgmentDollarTotal',	le.JudgmentDollarTotal)),
				108	=> ROW(createRecord('LienJudgmentDollarTotal',	le.LienJudgmentDollarTotal)),
				109	=> ROW(createRecord('AssetPropertyCount',	le.AssetPropertyCount)),
				110	=> ROW(createRecord('AssetPropertyStateCount',	le.AssetPropertyStateCount)),
				111	=> ROW(createRecord('AssetPropertyLotSizeTotal',	le.AssetPropertyLotSizeTotal)),
				112	=> ROW(createRecord('AssetPropertyAssessedTotal',	le.AssetPropertyAssessedTotal)),
				113	=> ROW(createRecord('AssetPropertySqFootageTotal',	le.AssetPropertySqFootageTotal)),
				114	=> ROW(createRecord('AssetAircraftCount',	le.AssetAircraftCount)),
				115	=> ROW(createRecord('AssetWatercraftCount',	le.AssetWatercraftCount)),
				116	=> ROW(createRecord('UCCCount',	le.UCCCount)),
				117	=> ROW(createRecord('UCCTimeNewest',	le.UCCTimeNewest)),
				118	=> ROW(createRecord('UCCTimeOldest',	le.UCCTimeOldest)),
				119	=> ROW(createRecord('GovernmentDebarred',	le.GovernmentDebarred)),
				120	=> ROW(createRecord('InquiryHighRisk12Month',	le.InquiryHighRisk12Month)),
				121	=> ROW(createRecord('InquiryHighRisk03Month',	le.InquiryHighRisk03Month)),
				122	=> ROW(createRecord('InquiryCredit12Month',	le.InquiryCredit12Month)),
				123	=> ROW(createRecord('InquiryCredit03Month',	le.InquiryCredit03Month)),
				124	=> ROW(createRecord('Inquiry12Month',	le.Inquiry12Month)),
				125	=> ROW(createRecord('Inquiry03Month',	le.Inquiry03Month)),
				126	=> ROW(createRecord('InquiryConsumerAddress',	le.InquiryConsumerAddress)),
				127	=> ROW(createRecord('InquiryConsumerPhone',	le.InquiryConsumerPhone)),
				128	=> ROW(createRecord('InquiryConsumerAddressSSN',	le.InquiryConsumerAddressSSN)),
				129	=> ROW(createRecord('BusExecLinkAuthRepNameOnFile',	le.BusExecLinkAuthRepNameOnFile)),
				130	=> ROW(createRecord('BusExecLinkAuthRepAddrOnFile',	le.BusExecLinkAuthRepAddrOnFile)),
				131	=> ROW(createRecord('BusExecLinkAuthRepSSNOnFile',	le.BusExecLinkAuthRepSSNOnFile)),
				132	=> ROW(createRecord('BusExecLinkAuthRepPhoneOnFile',	le.BusExecLinkAuthRepPhoneOnFile)),
				133	=> ROW(createRecord('BusExecLinkBusNameAuthRepFirst',	le.BusExecLinkBusNameAuthRepFirst)),
				134	=> ROW(createRecord('BusExecLinkBusNameAuthRepLast',	le.BusExecLinkBusNameAuthRepLast)),
				135	=> ROW(createRecord('BusExecLinkBusNameAuthRepFull',	le.BusExecLinkBusNameAuthRepFull)),
				136	=> ROW(createRecord('BusExecLinkAuthRepSSNBusFEIN',	le.BusExecLinkAuthRepSSNBusFEIN)),
				137	=> ROW(createRecord('BusExecLinkPropertyOverlapCount',	le.BusExecLinkPropertyOverlapCount)),
				138	=> ROW(createRecord('BusExecLinkBusAddrAuthRepOwned',	le.BusExecLinkBusAddrAuthRepOwned)),
				139	=> ROW(createRecord('BusExecLinkUtilityOverlapCount',	le.BusExecLinkUtilityOverlapCount)),
				140	=> ROW(createRecord('BusExecLinkInquiryOverlapCount',	le.BusExecLinkInquiryOverlapCount)),
				141	=> ROW(createRecord('BusExecLinkAuthRepAddrBusAddr',	le.BusExecLinkAuthRepAddrBusAddr)),
				142	=> ROW(createRecord('BusExecLinkAuthRepPhoneBusPhone',	le.BusExecLinkAuthRepPhoneBusPhone)),
				143	=> ROW(createRecord('BusExecLinkAuthRep2NameOnFile',	le.BusExecLinkAuthRep2NameOnFile)),
				144	=> ROW(createRecord('BusExecLinkAuthRep2AddrOnFile',	le.BusExecLinkAuthRep2AddrOnFile)),
				145	=> ROW(createRecord('BusExecLinkAuthRep2PhoneOnFile',	le.BusExecLinkAuthRep2PhoneOnFile)),
				146	=> ROW(createRecord('BusExecLinkAuthRep2SSNOnFile',	le.BusExecLinkAuthRep2SSNOnFile)),
				147	=> ROW(createRecord('BusExecLinkBusNameAuthRep2First',	le.BusExecLinkBusNameAuthRep2First)),
				148	=> ROW(createRecord('BusExecLinkBusNameAuthRep2Last',	le.BusExecLinkBusNameAuthRep2Last)),
				149	=> ROW(createRecord('BusExecLinkBusNameAuthRep2Full',	le.BusExecLinkBusNameAuthRep2Full)),
				150	=> ROW(createRecord('BusExecLinkAuthRep2SSNBusFEIN',	le.BusExecLinkAuthRep2SSNBusFEIN)),
				151	=> ROW(createRecord('BusExecLinkPropertyOverlapCount2',	le.BusExecLinkPropertyOverlapCount2)),
				152	=> ROW(createRecord('BusExecLinkBusAddrAuthRep2Owned',	le.BusExecLinkBusAddrAuthRep2Owned)),
				153	=> ROW(createRecord('BusExecLinkUtilityOverlapCount2',	le.BusExecLinkUtilityOverlapCount2)),
				154	=> ROW(createRecord('BusExecLinkInquiryOverlapCount2',	le.BusExecLinkInquiryOverlapCount2)),
				155	=> ROW(createRecord('BusExecLinkAuthRep2AddrBusAddr',	le.BusExecLinkAuthRep2AddrBusAddr)),
				156	=> ROW(createRecord('BusExecLinkAuthRep2PhoneBusPhone',	le.BusExecLinkAuthRep2PhoneBusPhone)),
				157	=> ROW(createRecord('BusExecLinkAuthRep3NameOnFile',	le.BusExecLinkAuthRep3NameOnFile)),
				158	=> ROW(createRecord('BusExecLinkAuthRep3AddrOnFile',	le.BusExecLinkAuthRep3AddrOnFile)),
				159	=> ROW(createRecord('BusExecLinkAuthRep3PhoneOnFile',	le.BusExecLinkAuthRep3PhoneOnFile)),
				160	=> ROW(createRecord('BusExecLinkAuthRep3SSNOnFile',	le.BusExecLinkAuthRep3SSNOnFile)),
				161	=> ROW(createRecord('BusExecLinkBusNameAuthRep3First',	le.BusExecLinkBusNameAuthRep3First)),
				162	=> ROW(createRecord('BusExecLinkBusNameAuthRep3Last',	le.BusExecLinkBusNameAuthRep3Last)),
				163	=> ROW(createRecord('BusExecLinkBusNameAuthRep3Full',	le.BusExecLinkBusNameAuthRep3Full)),
				164	=> ROW(createRecord('BusExecLinkAuthRep3SSNBusFein',	le.BusExecLinkAuthRep3SSNBusFein)),
				165	=> ROW(createRecord('BusExecLinkPropertyOverlapCount3',	le.BusExecLinkPropertyOverlapCount3)),
				166	=> ROW(createRecord('BusExecLinkBusAddrAuthRep3Owned',	le.BusExecLinkBusAddrAuthRep3Owned)),
				167	=> ROW(createRecord('BusExecLinkUtilityOverlapCount3',	le.BusExecLinkUtilityOverlapCount3)),
				168	=> ROW(createRecord('BusExecLinkInquiryOverlapCount3',	le.BusExecLinkInquiryOverlapCount3)),
				169	=> ROW(createRecord('BusExecLinkAuthRep3AddrBusAddr',	le.BusExecLinkAuthRep3AddrBusAddr)),
				170	=> ROW(createRecord('BusExecLinkAuthRep3PhoneBusPhone',	le.BusExecLinkAuthRep3PhoneBusPhone)),
				171	=> ROW(createRecord('BusFEINPersonOverlap',	le.BusFEINPersonOverlap)),
				172	=> ROW(createRecord('BusFEINPersonAddrOverlap',	le.BusFEINPersonAddrOverlap)),
				173	=> ROW(createRecord('BusFEINPersonPhoneOverlap',	le.BusFEINPersonPhoneOverlap)),
				174	=> ROW(createRecord('BusAddrPersonNameOverlap',	le.BusAddrPersonNameOverlap)),
				175	=> ROW(createRecord('InputAddrConsumerCount',	le.InputAddrConsumerCount)),
				176	=> ROW(createRecord('InputAddrSourceCount',	le.InputAddrSourceCount)),
				177	=> ROW(createRecord('InputAddrType',	le.InputAddrType)),
				178	=> ROW(createRecord('InputAddrBusinessOwned',	le.InputAddrBusinessOwned)),
				179	=> ROW(createRecord('InputAddrLotSize',	le.InputAddrLotSize)),
				180	=> ROW(createRecord('InputAddrAssessedTotal',	le.InputAddrAssessedTotal)),
				181	=> ROW(createRecord('InputAddrSqFootage',	le.InputAddrSqFootage)),
				182	=> ROW(createRecord('InputPhoneProblems',	le.InputPhoneProblems)),
				183	=> ROW(createRecord('InputPhoneEntityCount',	le.InputPhoneEntityCount)),
				184	=> ROW(createRecord('InputPhoneMobile',	le.InputPhoneMobile)),
				185	=> ROW(createRecord('AssociateCount',	le.AssociateCount)),
				186	=> ROW(createRecord('AssociateHighCrimeAddrCount',	le.AssociateHighCrimeAddrCount)),
				187	=> ROW(createRecord('AssociateFelonyCount',	le.AssociateFelonyCount)),
				188	=> ROW(createRecord('AssociateCountWithFelony',	le.AssociateCountWithFelony)),
				189	=> ROW(createRecord('AssociateBankruptCount',	le.AssociateBankruptCount)),
				190	=> ROW(createRecord('AssociateCountWithBankruptcy',	le.AssociateCountWithBankruptcy)),
				191	=> ROW(createRecord('AssociateBankrupt1YearCount',	le.AssociateBankrupt1YearCount)),
				192	=> ROW(createRecord('AssociateLienCount',	le.AssociateLienCount)),
				193	=> ROW(createRecord('AssociateCountWithLien',	le.AssociateCountWithLien)),
				194	=> ROW(createRecord('AssociateJudgmentCount',	le.AssociateJudgmentCount)),
				195	=> ROW(createRecord('AssociateCountWithJudgment',	le.AssociateCountWithJudgment)),
				196	=> ROW(createRecord('AssociateHighRiskAddrCount',	le.AssociateHighRiskAddrCount)),
				197	=> ROW(createRecord('AssociateWatchlistCount',	le.AssociateWatchlistCount)),
				198	=> ROW(createRecord('AssociateBusinessCount',	le.AssociateBusinessCount)),
				199	=> ROW(createRecord('AssociateCityCount',	le.AssociateCityCount)),
				200	=> ROW(createRecord('AssociateCountyCount',	le.AssociateCountyCount)),
							 ROW(createRecord('Invalid',	'Invalid')));
	END;
	
	NameValuePairsVersion1 := NORMALIZE(SBA_Results, 200, intoVersion1(LEFT, COUNTER));
	
	iesp.smallbusinessanalytics.t_SBAAttributesGroup Version1(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V1_NAME;
		SELF.Attributes := NameValuePairsVersion1;
	END;

	// Create SBFE Name/Value Pair Attributes
	iesp.share.t_NameValuePair intoSBFE(LNSmallBusiness.BIP_Layouts.IntermediateLayout le, UNSIGNED AttributeNumber) := TRANSFORM
		SELF := CASE(AttributeNumber, 
				1 => ROW(createRecord('SBFEHitIndex', le.SBFEHitIndex)),
				2 => ROW(createRecord('SBFEVerBusName', le.SBFEVerBusName)),
				3 => ROW(createRecord('SBFEVerBusAddr', le.SBFEVerBusAddr)),
				4 => ROW(createRecord('SBFEVerBusPhone', le.SBFEVerBusPhone)),
				5 => ROW(createRecord('SBFEVerBusFEIN', le.SBFEVerBusFEIN)),
				6 => ROW(createRecord('SBFEVerBusIndustryCode', le.SBFEVerBusIndustryCode)),
				7 => ROW(createRecord('SBFEBusExecLinkRep1Name', le.SBFEBusExecLinkRep1Name)),
				8 => ROW(createRecord('SBFEBusExecLinkRep1Addr', le.SBFEBusExecLinkRep1Addr)),
				9 => ROW(createRecord('SBFEBusExecLinkRep1Phone', le.SBFEBusExecLinkRep1Phone)),
				10 => ROW(createRecord('SBFEBusExecLinkRep1SSN', le.SBFEBusExecLinkRep1SSN)),
				11 => ROW(createRecord('SBFEBusExecLinkRep2Name', le.SBFEBusExecLinkRep2Name)),
				12 => ROW(createRecord('SBFEBusExecLinkRep2Addr', le.SBFEBusExecLinkRep2Addr)),
				13 => ROW(createRecord('SBFEBusExecLinkRep2Phone', le.SBFEBusExecLinkRep2Phone)),
				14 => ROW(createRecord('SBFEBusExecLinkRep2SSN', le.SBFEBusExecLinkRep2SSN)),
				15 => ROW(createRecord('SBFEBusExecLinkRep3Name', le.SBFEBusExecLinkRep3Name)),
				16 => ROW(createRecord('SBFEBusExecLinkRep3Addr', le.SBFEBusExecLinkRep3Addr)),
				17 => ROW(createRecord('SBFEBusExecLinkRep3Phone', le.SBFEBusExecLinkRep3Phone)),
				18 => ROW(createRecord('SBFEBusExecLinkRep3SSN', le.SBFEBusExecLinkRep3SSN)),
				19 => ROW(createRecord('SBFETimeOldestCycle', le.SBFETimeOldestCycle)),
				20 => ROW(createRecord('SBFETimeNewestCycle', le.SBFETimeNewestCycle)),
				21 => ROW(createRecord('SBFEAccountCount', le.SBFEAccountCount)),
				22 => ROW(createRecord('SBFEAccountCount12M', le.SBFEAccountCount12M)),
				23 => ROW(createRecord('SBFEOpenCount03M', le.SBFEOpenCount03M)),
				24 => ROW(createRecord('SBFEOpenCount06M', le.SBFEOpenCount06M)),
				25 => ROW(createRecord('SBFEOpenCount12M', le.SBFEOpenCount12M)),
				26 => ROW(createRecord('SBFEOpenCount24M', le.SBFEOpenCount24M)),
				27 => ROW(createRecord('SBFEOpenCount36M', le.SBFEOpenCount36M)),
				28 => ROW(createRecord('SBFEOpenCount60M', le.SBFEOpenCount60M)),
				29 => ROW(createRecord('SBFEOpenCount84M', le.SBFEOpenCount84M)),
				30 => ROW(createRecord('SBFETimeOldest', le.SBFETimeOldest)),
				31 => ROW(createRecord('SBFETimeNewest', le.SBFETimeNewest)),
				32 => ROW(createRecord('SBFETimeNewestClosed', le.SBFETimeNewestClosed)),
				33 => ROW(createRecord('SBFELoanCount', le.SBFELoanCount)),
				34 => ROW(createRecord('SBFETimeOldestLoan', le.SBFETimeOldestLoan)),
				35 => ROW(createRecord('SBFETimeNewestLoan', le.SBFETimeNewestLoan)),
				36 => ROW(createRecord('SBFETimeNewestClosedLoan', le.SBFETimeNewestClosedLoan)),
				37 => ROW(createRecord('SBFELineCount', le.SBFELineCount)),
				38 => ROW(createRecord('SBFETimeOldestLine', le.SBFETimeOldestLine)),
				39 => ROW(createRecord('SBFETimeNewestLine', le.SBFETimeNewestLine)),
				40 => ROW(createRecord('SBFETimeNewestClosedLine', le.SBFETimeNewestClosedLine)),
				41 => ROW(createRecord('SBFECardCount', le.SBFECardCount)),
				42 => ROW(createRecord('SBFETimeOldestCard', le.SBFETimeOldestCard)),
				43 => ROW(createRecord('SBFETimeNewestCard', le.SBFETimeNewestCard)),
				44 => ROW(createRecord('SBFETimeNewestClosedCard', le.SBFETimeNewestClosedCard)),
				45 => ROW(createRecord('SBFELeaseCount', le.SBFELeaseCount)),
				46 => ROW(createRecord('SBFETimeOldestLease', le.SBFETimeOldestLease)),
				47 => ROW(createRecord('SBFETimeNewestLease', le.SBFETimeNewestLease)),
				48 => ROW(createRecord('SBFETimeNewestClosedLease', le.SBFETimeNewestClosedLease)),
				49 => ROW(createRecord('SBFELetterCount', le.SBFELetterCount)),
				50 => ROW(createRecord('SBFETimeOldestLetter', le.SBFETimeOldestLetter)),
				51 => ROW(createRecord('SBFETimeNewestLetter', le.SBFETimeNewestLetter)),
				52 => ROW(createRecord('SBFETimeNewestClosedLetter', le.SBFETimeNewestClosedLetter)),
				53 => ROW(createRecord('SBFEOELineCount', le.SBFEOELineCount)),
				54 => ROW(createRecord('SBFETimeOldestOELine', le.SBFETimeOldestOELine)),
				55 => ROW(createRecord('SBFETimeNewestOELine', le.SBFETimeNewestOELine)),
				56 => ROW(createRecord('SBFETimeNewestClosedOELine', le.SBFETimeNewestClosedOELine)),
				57 => ROW(createRecord('SBFEOtherCount', le.SBFEOtherCount)),
				58 => ROW(createRecord('SBFETimeOldestOther', le.SBFETimeOldestOther)),
				59 => ROW(createRecord('SBFETimeNewestOther', le.SBFETimeNewestOther)),
				60 => ROW(createRecord('SBFETimeNewestClosedOther', le.SBFETimeNewestClosedOther)),
				61 => ROW(createRecord('SBFEOpenCount', le.SBFEOpenCount)),
				62 => ROW(createRecord('SBFEOpenCountHist03M', le.SBFEOpenCountHist03M)),
				63 => ROW(createRecord('SBFEOpenCountHist06M', le.SBFEOpenCountHist06M)),
				64 => ROW(createRecord('SBFEOpenCountHist12M', le.SBFEOpenCountHist12M)),
				65 => ROW(createRecord('SBFEOpenCountHist24M', le.SBFEOpenCountHist24M)),
				66 => ROW(createRecord('SBFEOpenCountHist36M', le.SBFEOpenCountHist36M)),
				67 => ROW(createRecord('SBFEOpenCountHist60M', le.SBFEOpenCountHist60M)),
				68 => ROW(createRecord('SBFEOpenCountHist84M', le.SBFEOpenCountHist84M)),
				69 => ROW(createRecord('SBFEOpenLoanCount', le.SBFEOpenLoanCount)),
				70 => ROW(createRecord('SBFEOpenLoanCount03M', le.SBFEOpenLoanCount03M)),
				71 => ROW(createRecord('SBFEOpenLoanCount06M', le.SBFEOpenLoanCount06M)),
				72 => ROW(createRecord('SBFEOpenLoanCount12M', le.SBFEOpenLoanCount12M)),
				73 => ROW(createRecord('SBFEOpenLoanCount24M', le.SBFEOpenLoanCount24M)),
				74 => ROW(createRecord('SBFEOpenLoanCount36M', le.SBFEOpenLoanCount36M)),
				75 => ROW(createRecord('SBFEOpenLoanCount60M', le.SBFEOpenLoanCount60M)),
				76 => ROW(createRecord('SBFEOpenLoanCount84M', le.SBFEOpenLoanCount84M)),
				77 => ROW(createRecord('SBFEOpenLineCount', le.SBFEOpenLineCount)),
				78 => ROW(createRecord('SBFEOpenLineCount03M', le.SBFEOpenLineCount03M)),
				79 => ROW(createRecord('SBFEOpenLineCount06M', le.SBFEOpenLineCount06M)),
				80 => ROW(createRecord('SBFEOpenLineCount12M', le.SBFEOpenLineCount12M)),
				81 => ROW(createRecord('SBFEOpenLineCount24M', le.SBFEOpenLineCount24M)),
				82 => ROW(createRecord('SBFEOpenLineCount36M', le.SBFEOpenLineCount36M)),
				83 => ROW(createRecord('SBFEOpenLineCount60M', le.SBFEOpenLineCount60M)),
				84 => ROW(createRecord('SBFEOpenLineCount84M', le.SBFEOpenLineCount84M)),
				85 => ROW(createRecord('SBFEOpenCardCount', le.SBFEOpenCardCount)),
				86 => ROW(createRecord('SBFEOpenCardCount03M', le.SBFEOpenCardCount03M)),
				87 => ROW(createRecord('SBFEOpenCardCount06M', le.SBFEOpenCardCount06M)),
				88 => ROW(createRecord('SBFEOpenCardCount12M', le.SBFEOpenCardCount12M)),
				89 => ROW(createRecord('SBFEOpenCardCount24M', le.SBFEOpenCardCount24M)),
				90 => ROW(createRecord('SBFEOpenCardCount36M', le.SBFEOpenCardCount36M)),
				91 => ROW(createRecord('SBFEOpenCardCount60M', le.SBFEOpenCardCount60M)),
				92 => ROW(createRecord('SBFEOpenCardCount84M', le.SBFEOpenCardCount84M)),
				93 => ROW(createRecord('SBFEOpenLeaseCount', le.SBFEOpenLeaseCount)),
				94 => ROW(createRecord('SBFEOpenLeaseCount03M', le.SBFEOpenLeaseCount03M)),
				95 => ROW(createRecord('SBFEOpenLeaseCount06M', le.SBFEOpenLeaseCount06M)),
				96 => ROW(createRecord('SBFEOpenLeaseCount12M', le.SBFEOpenLeaseCount12M)),
				97 => ROW(createRecord('SBFEOpenLeaseCount24M', le.SBFEOpenLeaseCount24M)),
				98 => ROW(createRecord('SBFEOpenLeaseCount36M', le.SBFEOpenLeaseCount36M)),
				99 => ROW(createRecord('SBFEOpenLeaseCount60M', le.SBFEOpenLeaseCount60M)),
				100 => ROW(createRecord('SBFEOpenLeaseCount84M', le.SBFEOpenLeaseCount84M)),
				101 => ROW(createRecord('SBFEOpenLetterCount', le.SBFEOpenLetterCount)),
				102 => ROW(createRecord('SBFEOpenLetterCount03M', le.SBFEOpenLetterCount03M)),
				103 => ROW(createRecord('SBFEOpenLetterCount06M', le.SBFEOpenLetterCount06M)),
				104 => ROW(createRecord('SBFEOpenLetterCount12M', le.SBFEOpenLetterCount12M)),
				105 => ROW(createRecord('SBFEOpenLetterCount24M', le.SBFEOpenLetterCount24M)),
				106 => ROW(createRecord('SBFEOpenLetterCount36M', le.SBFEOpenLetterCount36M)),
				107 => ROW(createRecord('SBFEOpenLetterCount60M', le.SBFEOpenLetterCount60M)),
				108 => ROW(createRecord('SBFEOpenLetterCount84M', le.SBFEOpenLetterCount84M)),
				109 => ROW(createRecord('SBFEOpenOELineCount', le.SBFEOpenOELineCount)),
				110 => ROW(createRecord('SBFEOpenOELineCount03M', le.SBFEOpenOELineCount03M)),
				111 => ROW(createRecord('SBFEOpenOELineCount06M', le.SBFEOpenOELineCount06M)),
				112 => ROW(createRecord('SBFEOpenOELineCount12M', le.SBFEOpenOELineCount12M)),
				113 => ROW(createRecord('SBFEOpenOELineCount24M', le.SBFEOpenOELineCount24M)),
				114 => ROW(createRecord('SBFEOpenOELineCount36M', le.SBFEOpenOELineCount36M)),
				115 => ROW(createRecord('SBFEOpenOELineCount60M', le.SBFEOpenOELineCount60M)),
				116 => ROW(createRecord('SBFEOpenOELineCount84M', le.SBFEOpenOELineCount84M)),
				117 => ROW(createRecord('SBFEOpenOtherCount', le.SBFEOpenOtherCount)),
				118 => ROW(createRecord('SBFEOpenOtherCount03M', le.SBFEOpenOtherCount03M)),
				119 => ROW(createRecord('SBFEOpenOtherCount06M', le.SBFEOpenOtherCount06M)),
				120 => ROW(createRecord('SBFEOpenOtherCount12M', le.SBFEOpenOtherCount12M)),
				121 => ROW(createRecord('SBFEOpenOtherCount24M', le.SBFEOpenOtherCount24M)),
				122 => ROW(createRecord('SBFEOpenOtherCount36M', le.SBFEOpenOtherCount36M)),
				123 => ROW(createRecord('SBFEOpenOtherCount60M', le.SBFEOpenOtherCount60M)),
				124 => ROW(createRecord('SBFEOpenOtherCount84M', le.SBFEOpenOtherCount84M)),
				125 => ROW(createRecord('SBFEOpenTypeCount', le.SBFEOpenTypeCount)),
				126 => ROW(createRecord('SBFEOpenCardOnly', le.SBFEOpenCardOnly)),
				127 => ROW(createRecord('SBFEActiveCount', le.SBFEActiveCount)),
				128 => ROW(createRecord('SBFEActiveLoanCount', le.SBFEActiveLoanCount)),
				129 => ROW(createRecord('SBFEActiveLineCount', le.SBFEActiveLineCount)),
				130 => ROW(createRecord('SBFEActiveCardCount', le.SBFEActiveCardCount)),
				131 => ROW(createRecord('SBFEActiveLeaseCount', le.SBFEActiveLeaseCount)),
				132 => ROW(createRecord('SBFEActiveLetterCount', le.SBFEActiveLetterCount)),
				133 => ROW(createRecord('SBFEActiveOELineCount', le.SBFEActiveOELineCount)),
				134 => ROW(createRecord('SBFEActiveOtherCount', le.SBFEActiveOtherCount)),
				135 => ROW(createRecord('SBFEClosedCount', le.SBFEClosedCount)),
				136 => ROW(createRecord('SBFEClosedLoanCount', le.SBFEClosedLoanCount)),
				137 => ROW(createRecord('SBFEClosedLineCount', le.SBFEClosedLineCount)),
				138 => ROW(createRecord('SBFEClosedCardCount', le.SBFEClosedCardCount)),
				139 => ROW(createRecord('SBFEClosedLeaseCount', le.SBFEClosedLeaseCount)),
				140 => ROW(createRecord('SBFEClosedLetterCount', le.SBFEClosedLetterCount)),
				141 => ROW(createRecord('SBFEClosedOELineCount', le.SBFEClosedOELineCount)),
				142 => ROW(createRecord('SBFEClosedOtherCount', le.SBFEClosedOtherCount)),
				143 => ROW(createRecord('SBFEClosedInvoluntaryCount', le.SBFEClosedInvoluntaryCount)),
				144 => ROW(createRecord('SBFEClosedVoluntaryCount', le.SBFEClosedVoluntaryCount)),
				145 => ROW(createRecord('SBFEStaleClosedCount', le.SBFEStaleClosedCount)),
				146 => ROW(createRecord('SBFEStaleClosedLoanCount', le.SBFEStaleClosedLoanCount)),
				147 => ROW(createRecord('SBFEStaleClosedLineCount', le.SBFEStaleClosedLineCount)),
				148 => ROW(createRecord('SBFEStaleClosedCardCount', le.SBFEStaleClosedCardCount)),
				149 => ROW(createRecord('SBFEStaleClosedLeaseCount', le.SBFEStaleClosedLeaseCount)),
				150 => ROW(createRecord('SBFEStaleClosedLetterCount', le.SBFEStaleClosedLetterCount)),
				151 => ROW(createRecord('SBFEStaleClosedOELineCount', le.SBFEStaleClosedOELineCount)),
				152 => ROW(createRecord('SBFEStaleClosedOtherCount', le.SBFEStaleClosedOtherCount)),
				153 => ROW(createRecord('SBFEInactiveCount', le.SBFEInactiveCount)),
				154 => ROW(createRecord('SBFEInactiveLoanCount', le.SBFEInactiveLoanCount)),
				155 => ROW(createRecord('SBFEInactiveLineCount', le.SBFEInactiveLineCount)),
				156 => ROW(createRecord('SBFEInactiveCardCount', le.SBFEInactiveCardCount)),
				157 => ROW(createRecord('SBFEInactiveLeaseCount', le.SBFEInactiveLeaseCount)),
				158 => ROW(createRecord('SBFEInactiveLetterCount', le.SBFEInactiveLetterCount)),
				159 => ROW(createRecord('SBFEInactiveOELineCount', le.SBFEInactiveOELineCount)),
				160 => ROW(createRecord('SBFEInactiveOtherCount', le.SBFEInactiveOtherCount)),
				161 => ROW(createRecord('SBFERecentBalanceAmt', le.SBFERecentBalanceAmt)),
				162 => ROW(createRecord('SBFERecentBalanceLoanAmt', le.SBFERecentBalanceLoanAmt)),
				163 => ROW(createRecord('SBFERecentBalanceLineAmt', le.SBFERecentBalanceLineAmt)),
				164 => ROW(createRecord('SBFERecentBalanceCardAmt', le.SBFERecentBalanceCardAmt)),
				165 => ROW(createRecord('SBFERecentBalanceLeaseAmt', le.SBFERecentBalanceLeaseAmt)),
				166 => ROW(createRecord('SBFERecentBalanceLetterAmt', le.SBFERecentBalanceLetterAmt)),
				167 => ROW(createRecord('SBFERecentBalanceOELineAmt', le.SBFERecentBalanceOELineAmt)),
				168 => ROW(createRecord('SBFERecentBalanceOtherAmt', le.SBFERecentBalanceOtherAmt)),
				169 => ROW(createRecord('SBFERecentBalanceRevAmt', le.SBFERecentBalanceRevAmt)),
				170 => ROW(createRecord('SBFERecentBalanceInstAmt', le.SBFERecentBalanceInstAmt)),
				171 => ROW(createRecord('SBFEBalanceAmt03M', le.SBFEBalanceAmt03M)),
				172 => ROW(createRecord('SBFEBalanceAmt06M', le.SBFEBalanceAmt06M)),
				173 => ROW(createRecord('SBFEBalanceAmt12M', le.SBFEBalanceAmt12M)),
				174 => ROW(createRecord('SBFEBalanceAmt24M', le.SBFEBalanceAmt24M)),
				175 => ROW(createRecord('SBFEBalanceAmt36M', le.SBFEBalanceAmt36M)),
				176 => ROW(createRecord('SBFEBalanceAmt60M', le.SBFEBalanceAmt60M)),
				177 => ROW(createRecord('SBFEBalanceAmt84M', le.SBFEBalanceAmt84M)),
				178 => ROW(createRecord('SBFEBalanceAmtLoan03M', le.SBFEBalanceAmtLoan03M)),
				179 => ROW(createRecord('SBFEBalanceAmtLoan06M', le.SBFEBalanceAmtLoan06M)),
				180 => ROW(createRecord('SBFEBalanceAmtLoan12M', le.SBFEBalanceAmtLoan12M)),
				181 => ROW(createRecord('SBFEBalanceAmtLoan24M', le.SBFEBalanceAmtLoan24M)),
				182 => ROW(createRecord('SBFEBalanceAmtLoan36M', le.SBFEBalanceAmtLoan36M)),
				183 => ROW(createRecord('SBFEBalanceAmtLoan60M', le.SBFEBalanceAmtLoan60M)),
				184 => ROW(createRecord('SBFEBalanceAmtLoan84M', le.SBFEBalanceAmtLoan84M)),
				185 => ROW(createRecord('SBFEBalanceAmtLine03M', le.SBFEBalanceAmtLine03M)),
				186 => ROW(createRecord('SBFEBalanceAmtLine06M', le.SBFEBalanceAmtLine06M)),
				187 => ROW(createRecord('SBFEBalanceAmtLine12M', le.SBFEBalanceAmtLine12M)),
				188 => ROW(createRecord('SBFEBalanceAmtLine24M', le.SBFEBalanceAmtLine24M)),
				189 => ROW(createRecord('SBFEBalanceAmtLine36M', le.SBFEBalanceAmtLine36M)),
				190 => ROW(createRecord('SBFEBalanceAmtLine60M', le.SBFEBalanceAmtLine60M)),
				191 => ROW(createRecord('SBFEBalanceAmtLine84M', le.SBFEBalanceAmtLine84M)),
				192 => ROW(createRecord('SBFEBalanceAmtCard03M', le.SBFEBalanceAmtCard03M)),
				193 => ROW(createRecord('SBFEBalanceAmtCard06M', le.SBFEBalanceAmtCard06M)),
				194 => ROW(createRecord('SBFEBalanceAmtCard12M', le.SBFEBalanceAmtCard12M)),
				195 => ROW(createRecord('SBFEBalanceAmtCard24M', le.SBFEBalanceAmtCard24M)),
				196 => ROW(createRecord('SBFEBalanceAmtCard36M', le.SBFEBalanceAmtCard36M)),
				197 => ROW(createRecord('SBFEBalanceAmtCard60M', le.SBFEBalanceAmtCard60M)),
				198 => ROW(createRecord('SBFEBalanceAmtCard84M', le.SBFEBalanceAmtCard84M)),
				199 => ROW(createRecord('SBFEBalanceAmtLease03M', le.SBFEBalanceAmtLease03M)),
				200 => ROW(createRecord('SBFEBalanceAmtLease06M', le.SBFEBalanceAmtLease06M)),
				201 => ROW(createRecord('SBFEBalanceAmtLease12M', le.SBFEBalanceAmtLease12M)),
				202 => ROW(createRecord('SBFEBalanceAmtLease24M', le.SBFEBalanceAmtLease24M)),
				203 => ROW(createRecord('SBFEBalanceAmtLease36M', le.SBFEBalanceAmtLease36M)),
				204 => ROW(createRecord('SBFEBalanceAmtLease60M', le.SBFEBalanceAmtLease60M)),
				205 => ROW(createRecord('SBFEBalanceAmtLease84M', le.SBFEBalanceAmtLease84M)),
				206 => ROW(createRecord('SBFEBalanceAmtLetter03M', le.SBFEBalanceAmtLetter03M)),
				207 => ROW(createRecord('SBFEBalanceAmtLetter06M', le.SBFEBalanceAmtLetter06M)),
				208 => ROW(createRecord('SBFEBalanceAmtLetter12M', le.SBFEBalanceAmtLetter12M)),
				209 => ROW(createRecord('SBFEBalanceAmtLetter24M', le.SBFEBalanceAmtLetter24M)),
				210 => ROW(createRecord('SBFEBalanceAmtLetter36M', le.SBFEBalanceAmtLetter36M)),
				211 => ROW(createRecord('SBFEBalanceAmtLetter60M', le.SBFEBalanceAmtLetter60M)),
				212 => ROW(createRecord('SBFEBalanceAmtLetter84M', le.SBFEBalanceAmtLetter84M)),
				213 => ROW(createRecord('SBFEBalanceAmtOELine03M', le.SBFEBalanceAmtOELine03M)),
				214 => ROW(createRecord('SBFEBalanceAmtOELine06M', le.SBFEBalanceAmtOELine06M)),
				215 => ROW(createRecord('SBFEBalanceAmtOELine12M', le.SBFEBalanceAmtOELine12M)),
				216 => ROW(createRecord('SBFEBalanceAmtOELine24M', le.SBFEBalanceAmtOELine24M)),
				217 => ROW(createRecord('SBFEBalanceAmtOELine36M', le.SBFEBalanceAmtOELine36M)),
				218 => ROW(createRecord('SBFEBalanceAmtOELine60M', le.SBFEBalanceAmtOELine60M)),
				219 => ROW(createRecord('SBFEBalanceAmtOELine84M', le.SBFEBalanceAmtOELine84M)),
				220 => ROW(createRecord('SBFEBalanceAmtOther03M', le.SBFEBalanceAmtOther03M)),
				221 => ROW(createRecord('SBFEBalanceAmtOther06M', le.SBFEBalanceAmtOther06M)),
				222 => ROW(createRecord('SBFEBalanceAmtOther12M', le.SBFEBalanceAmtOther12M)),
				223 => ROW(createRecord('SBFEBalanceAmtOther24M', le.SBFEBalanceAmtOther24M)),
				224 => ROW(createRecord('SBFEBalanceAmtOther36M', le.SBFEBalanceAmtOther36M)),
				225 => ROW(createRecord('SBFEBalanceAmtOther60M', le.SBFEBalanceAmtOther60M)),
				226 => ROW(createRecord('SBFEBalanceAmtOther84M', le.SBFEBalanceAmtOther84M)),
				227 => ROW(createRecord('SBFEAvgBalance03M', le.SBFEAvgBalance03M)),
				228 => ROW(createRecord('SBFEAvgBalance06M', le.SBFEAvgBalance06M)),
				229 => ROW(createRecord('SBFEAvgBalance12M', le.SBFEAvgBalance12M)),
				230 => ROW(createRecord('SBFEAvgBalance24M', le.SBFEAvgBalance24M)),
				231 => ROW(createRecord('SBFEAvgBalance36M', le.SBFEAvgBalance36M)),
				232 => ROW(createRecord('SBFEAvgBalance60M', le.SBFEAvgBalance60M)),
				233 => ROW(createRecord('SBFEAvgBalance84M', le.SBFEAvgBalance84M)),
				234 => ROW(createRecord('SBFEAvgBalanceEver', le.SBFEAvgBalanceEver)),
				235 => ROW(createRecord('SBFEAvgBalanceLoan03M', le.SBFEAvgBalanceLoan03M)),
				236 => ROW(createRecord('SBFEAvgBalanceLoan06M', le.SBFEAvgBalanceLoan06M)),
				237 => ROW(createRecord('SBFEAvgBalanceLoan12M', le.SBFEAvgBalanceLoan12M)),
				238 => ROW(createRecord('SBFEAvgBalanceLoan24M', le.SBFEAvgBalanceLoan24M)),
				239 => ROW(createRecord('SBFEAvgBalanceLoan36M', le.SBFEAvgBalanceLoan36M)),
				240 => ROW(createRecord('SBFEAvgBalanceLoan60M', le.SBFEAvgBalanceLoan60M)),
				241 => ROW(createRecord('SBFEAvgBalanceLoan84M', le.SBFEAvgBalanceLoan84M)),
				242 => ROW(createRecord('SBFEAvgBalanceLoanEver', le.SBFEAvgBalanceLoanEver)),
				243 => ROW(createRecord('SBFEAvgBalanceLine03M', le.SBFEAvgBalanceLine03M)),
				244 => ROW(createRecord('SBFEAvgBalanceLine06M', le.SBFEAvgBalanceLine06M)),
				245 => ROW(createRecord('SBFEAvgBalanceLine12M', le.SBFEAvgBalanceLine12M)),
				246 => ROW(createRecord('SBFEAvgBalanceLine24M', le.SBFEAvgBalanceLine24M)),
				247 => ROW(createRecord('SBFEAvgBalanceLine36M', le.SBFEAvgBalanceLine36M)),
				248 => ROW(createRecord('SBFEAvgBalanceLine60M', le.SBFEAvgBalanceLine60M)),
				249 => ROW(createRecord('SBFEAvgBalanceLine84M', le.SBFEAvgBalanceLine84M)),
				250 => ROW(createRecord('SBFEAvgBalanceLineEver', le.SBFEAvgBalanceLineEver)),
				251 => ROW(createRecord('SBFEAvgBalanceCard03M', le.SBFEAvgBalanceCard03M)),
				252 => ROW(createRecord('SBFEAvgBalanceCard06M', le.SBFEAvgBalanceCard06M)),
				253 => ROW(createRecord('SBFEAvgBalanceCard12M', le.SBFEAvgBalanceCard12M)),
				254 => ROW(createRecord('SBFEAvgBalanceCard24M', le.SBFEAvgBalanceCard24M)),
				255 => ROW(createRecord('SBFEAvgBalanceCard36M', le.SBFEAvgBalanceCard36M)),
				256 => ROW(createRecord('SBFEAvgBalanceCard60M', le.SBFEAvgBalanceCard60M)),
				257 => ROW(createRecord('SBFEAvgBalanceCard84M', le.SBFEAvgBalanceCard84M)),
				258 => ROW(createRecord('SBFEAvgBalanceCardEver', le.SBFEAvgBalanceCardEver)),
				259 => ROW(createRecord('SBFEAvgBalanceLease03M', le.SBFEAvgBalanceLease03M)),
				260 => ROW(createRecord('SBFEAvgBalanceLease06M', le.SBFEAvgBalanceLease06M)),
				261 => ROW(createRecord('SBFEAvgBalanceLease12M', le.SBFEAvgBalanceLease12M)),
				262 => ROW(createRecord('SBFEAvgBalanceLease24M', le.SBFEAvgBalanceLease24M)),
				263 => ROW(createRecord('SBFEAvgBalanceLease36M', le.SBFEAvgBalanceLease36M)),
				264 => ROW(createRecord('SBFEAvgBalanceLease60M', le.SBFEAvgBalanceLease60M)),
				265 => ROW(createRecord('SBFEAvgBalanceLease84M', le.SBFEAvgBalanceLease84M)),
				266 => ROW(createRecord('SBFEAvgBalanceLeaseEver', le.SBFEAvgBalanceLeaseEver)),
				267 => ROW(createRecord('SBFEAvgBalanceLetter03M', le.SBFEAvgBalanceLetter03M)),
				268 => ROW(createRecord('SBFEAvgBalanceLetter06M', le.SBFEAvgBalanceLetter06M)),
				269 => ROW(createRecord('SBFEAvgBalanceLetter12M', le.SBFEAvgBalanceLetter12M)),
				270 => ROW(createRecord('SBFEAvgBalanceLetter24M', le.SBFEAvgBalanceLetter24M)),
				271 => ROW(createRecord('SBFEAvgBalanceLetter36M', le.SBFEAvgBalanceLetter36M)),
				272 => ROW(createRecord('SBFEAvgBalanceLetter60M', le.SBFEAvgBalanceLetter60M)),
				273 => ROW(createRecord('SBFEAvgBalanceLetter84M', le.SBFEAvgBalanceLetter84M)),
				274 => ROW(createRecord('SBFEAvgBalanceLetterEver', le.SBFEAvgBalanceLetterEver)),
				275 => ROW(createRecord('SBFEAvgBalanceOELine03M', le.SBFEAvgBalanceOELine03M)),
				276 => ROW(createRecord('SBFEAvgBalanceOELine06M', le.SBFEAvgBalanceOELine06M)),
				277 => ROW(createRecord('SBFEAvgBalanceOELine12M', le.SBFEAvgBalanceOELine12M)),
				278 => ROW(createRecord('SBFEAvgBalanceOELine24M', le.SBFEAvgBalanceOELine24M)),
				279 => ROW(createRecord('SBFEAvgBalanceOELine36M', le.SBFEAvgBalanceOELine36M)),
				280 => ROW(createRecord('SBFEAvgBalanceOELine60M', le.SBFEAvgBalanceOELine60M)),
				281 => ROW(createRecord('SBFEAvgBalanceOELine84M', le.SBFEAvgBalanceOELine84M)),
				282 => ROW(createRecord('SBFEAvgBalanceOELineEver', le.SBFEAvgBalanceOELineEver)),
				283 => ROW(createRecord('SBFEAvgBalanceOther03M', le.SBFEAvgBalanceOther03M)),
				284 => ROW(createRecord('SBFEAvgBalanceOther06M', le.SBFEAvgBalanceOther06M)),
				285 => ROW(createRecord('SBFEAvgBalanceOther12M', le.SBFEAvgBalanceOther12M)),
				286 => ROW(createRecord('SBFEAvgBalanceOther24M', le.SBFEAvgBalanceOther24M)),
				287 => ROW(createRecord('SBFEAvgBalanceOther36M', le.SBFEAvgBalanceOther36M)),
				288 => ROW(createRecord('SBFEAvgBalanceOther60M', le.SBFEAvgBalanceOther60M)),
				289 => ROW(createRecord('SBFEAvgBalanceOther84M', le.SBFEAvgBalanceOther84M)),
				290 => ROW(createRecord('SBFEAvgBalanceOtherEver', le.SBFEAvgBalanceOtherEver)),
				291 => ROW(createRecord('SBFEHighBalance03M', le.SBFEHighBalance03M)),
				292 => ROW(createRecord('SBFEHighBalance06M', le.SBFEHighBalance06M)),
				293 => ROW(createRecord('SBFEHighBalance12M', le.SBFEHighBalance12M)),
				294 => ROW(createRecord('SBFEHighBalance24M', le.SBFEHighBalance24M)),
				295 => ROW(createRecord('SBFEHighBalance36M', le.SBFEHighBalance36M)),
				296 => ROW(createRecord('SBFEHighBalance60M', le.SBFEHighBalance60M)),
				297 => ROW(createRecord('SBFEHighBalance84M', le.SBFEHighBalance84M)),
				298 => ROW(createRecord('SBFEHighBalanceEver', le.SBFEHighBalanceEver)),
				299 => ROW(createRecord('SBFEHighBalanceLoan03M', le.SBFEHighBalanceLoan03M)),
				300 => ROW(createRecord('SBFEHighBalanceLoan06M', le.SBFEHighBalanceLoan06M)),
				301 => ROW(createRecord('SBFEHighBalanceLoan12M', le.SBFEHighBalanceLoan12M)),
				302 => ROW(createRecord('SBFEHighBalanceLoan24M', le.SBFEHighBalanceLoan24M)),
				303 => ROW(createRecord('SBFEHighBalanceLoan36M', le.SBFEHighBalanceLoan36M)),
				304 => ROW(createRecord('SBFEHighBalanceLoan60M', le.SBFEHighBalanceLoan60M)),
				305 => ROW(createRecord('SBFEHighBalanceLoan84M', le.SBFEHighBalanceLoan84M)),
				306 => ROW(createRecord('SBFEHighBalanceLoanEver', le.SBFEHighBalanceLoanEver)),
				307 => ROW(createRecord('SBFEHighBalanceLine03M', le.SBFEHighBalanceLine03M)),
				308 => ROW(createRecord('SBFEHighBalanceLine06M', le.SBFEHighBalanceLine06M)),
				309 => ROW(createRecord('SBFEHighBalanceLine12M', le.SBFEHighBalanceLine12M)),
				310 => ROW(createRecord('SBFEHighBalanceLine24M', le.SBFEHighBalanceLine24M)),
				311 => ROW(createRecord('SBFEHighBalanceLine36M', le.SBFEHighBalanceLine36M)),
				312 => ROW(createRecord('SBFEHighBalanceLine60M', le.SBFEHighBalanceLine60M)),
				313 => ROW(createRecord('SBFEHighBalanceLine84M', le.SBFEHighBalanceLine84M)),
				314 => ROW(createRecord('SBFEHighBalanceLineEver', le.SBFEHighBalanceLineEver)),
				315 => ROW(createRecord('SBFEHighBalanceCard03M', le.SBFEHighBalanceCard03M)),
				316 => ROW(createRecord('SBFEHighBalanceCard06M', le.SBFEHighBalanceCard06M)),
				317 => ROW(createRecord('SBFEHighBalanceCard12M', le.SBFEHighBalanceCard12M)),
				318 => ROW(createRecord('SBFEHighBalanceCard24M', le.SBFEHighBalanceCard24M)),
				319 => ROW(createRecord('SBFEHighBalanceCard36M', le.SBFEHighBalanceCard36M)),
				320 => ROW(createRecord('SBFEHighBalanceCard60M', le.SBFEHighBalanceCard60M)),
				321 => ROW(createRecord('SBFEHighBalanceCard84M', le.SBFEHighBalanceCard84M)),
				322 => ROW(createRecord('SBFEHighBalanceCardEver', le.SBFEHighBalanceCardEver)),
				323 => ROW(createRecord('SBFEHighBalanceLease03M', le.SBFEHighBalanceLease03M)),
				324 => ROW(createRecord('SBFEHighBalanceLease06M', le.SBFEHighBalanceLease06M)),
				325 => ROW(createRecord('SBFEHighBalanceLease12M', le.SBFEHighBalanceLease12M)),
				326 => ROW(createRecord('SBFEHighBalanceLease24M', le.SBFEHighBalanceLease24M)),
				327 => ROW(createRecord('SBFEHighBalanceLease36M', le.SBFEHighBalanceLease36M)),
				328 => ROW(createRecord('SBFEHighBalanceLease60M', le.SBFEHighBalanceLease60M)),
				329 => ROW(createRecord('SBFEHighBalanceLease84M', le.SBFEHighBalanceLease84M)),
				330 => ROW(createRecord('SBFEHighBalanceLeaseEver', le.SBFEHighBalanceLeaseEver)),
				331 => ROW(createRecord('SBFEHighBalanceLetter03M', le.SBFEHighBalanceLetter03M)),
				332 => ROW(createRecord('SBFEHighBalanceLetter06M', le.SBFEHighBalanceLetter06M)),
				333 => ROW(createRecord('SBFEHighBalanceLetter12M', le.SBFEHighBalanceLetter12M)),
				334 => ROW(createRecord('SBFEHighBalanceLetter24M', le.SBFEHighBalanceLetter24M)),
				335 => ROW(createRecord('SBFEHighBalanceLetter36M', le.SBFEHighBalanceLetter36M)),
				336 => ROW(createRecord('SBFEHighBalanceLetter60M', le.SBFEHighBalanceLetter60M)),
				337 => ROW(createRecord('SBFEHighBalanceLetter84M', le.SBFEHighBalanceLetter84M)),
				338 => ROW(createRecord('SBFEHighBalanceLetterEver', le.SBFEHighBalanceLetterEver)),
				339 => ROW(createRecord('SBFEHighBalanceOELine03M', le.SBFEHighBalanceOELine03M)),
				340 => ROW(createRecord('SBFEHighBalanceOELine06M', le.SBFEHighBalanceOELine06M)),
				341 => ROW(createRecord('SBFEHighBalanceOELine12M', le.SBFEHighBalanceOELine12M)),
				342 => ROW(createRecord('SBFEHighBalanceOELine24M', le.SBFEHighBalanceOELine24M)),
				343 => ROW(createRecord('SBFEHighBalanceOELine36M', le.SBFEHighBalanceOELine36M)),
				344 => ROW(createRecord('SBFEHighBalanceOELine60M', le.SBFEHighBalanceOELine60M)),
				345 => ROW(createRecord('SBFEHighBalanceOELine84M', le.SBFEHighBalanceOELine84M)),
				346 => ROW(createRecord('SBFEHighBalanceOELineEver', le.SBFEHighBalanceOELineEver)),
				347 => ROW(createRecord('SBFEHighBalanceOther03M', le.SBFEHighBalanceOther03M)),
				348 => ROW(createRecord('SBFEHighBalanceOther06M', le.SBFEHighBalanceOther06M)),
				349 => ROW(createRecord('SBFEHighBalanceOther12M', le.SBFEHighBalanceOther12M)),
				350 => ROW(createRecord('SBFEHighBalanceOther24M', le.SBFEHighBalanceOther24M)),
				351 => ROW(createRecord('SBFEHighBalanceOther36M', le.SBFEHighBalanceOther36M)),
				352 => ROW(createRecord('SBFEHighBalanceOther60M', le.SBFEHighBalanceOther60M)),
				353 => ROW(createRecord('SBFEHighBalanceOther84M', le.SBFEHighBalanceOther84M)),
				354 => ROW(createRecord('SBFEHighBalanceOtherEver', le.SBFEHighBalanceOtherEver)),
				355 => ROW(createRecord('SBFEBalanceCount', le.SBFEBalanceCount)),
				356 => ROW(createRecord('SBFEBalanceCount03M', le.SBFEBalanceCount03M)),
				357 => ROW(createRecord('SBFEBalanceCount06M', le.SBFEBalanceCount06M)),
				358 => ROW(createRecord('SBFEBalanceCount12M', le.SBFEBalanceCount12M)),
				359 => ROW(createRecord('SBFEBalanceCount24M', le.SBFEBalanceCount24M)),
				360 => ROW(createRecord('SBFEBalanceCount36M', le.SBFEBalanceCount36M)),
				361 => ROW(createRecord('SBFEBalanceCount60M', le.SBFEBalanceCount60M)),
				362 => ROW(createRecord('SBFEBalanceCount84M', le.SBFEBalanceCount84M)),
				363 => ROW(createRecord('SBFEBalanceCountEver', le.SBFEBalanceCountEver)),
				364 => ROW(createRecord('SBFEBalanceLoanCount', le.SBFEBalanceLoanCount)),
				365 => ROW(createRecord('SBFEBalanceLoanCount03M', le.SBFEBalanceLoanCount03M)),
				366 => ROW(createRecord('SBFEBalanceLoanCount06M', le.SBFEBalanceLoanCount06M)),
				367 => ROW(createRecord('SBFEBalanceLoanCount12M', le.SBFEBalanceLoanCount12M)),
				368 => ROW(createRecord('SBFEBalanceLoanCount24M', le.SBFEBalanceLoanCount24M)),
				369 => ROW(createRecord('SBFEBalanceLoanCount36M', le.SBFEBalanceLoanCount36M)),
				370 => ROW(createRecord('SBFEBalanceLoanCount60M', le.SBFEBalanceLoanCount60M)),
				371 => ROW(createRecord('SBFEBalanceLoanCount84M', le.SBFEBalanceLoanCount84M)),
				372 => ROW(createRecord('SBFEBalanceLoanCountEver', le.SBFEBalanceLoanCountEver)),
				373 => ROW(createRecord('SBFEBalanceLineCount', le.SBFEBalanceLineCount)),
				374 => ROW(createRecord('SBFEBalanceLineCount03M', le.SBFEBalanceLineCount03M)),
				375 => ROW(createRecord('SBFEBalanceLineCount06M', le.SBFEBalanceLineCount06M)),
				376 => ROW(createRecord('SBFEBalanceLineCount12M', le.SBFEBalanceLineCount12M)),
				377 => ROW(createRecord('SBFEBalanceLineCount24M', le.SBFEBalanceLineCount24M)),
				378 => ROW(createRecord('SBFEBalanceLineCount36M', le.SBFEBalanceLineCount36M)),
				379 => ROW(createRecord('SBFEBalanceLineCount60M', le.SBFEBalanceLineCount60M)),
				380 => ROW(createRecord('SBFEBalanceLineCount84M', le.SBFEBalanceLineCount84M)),
				381 => ROW(createRecord('SBFEBalanceLineCountEver', le.SBFEBalanceLineCountEver)),
				382 => ROW(createRecord('SBFEBalanceCardCount', le.SBFEBalanceCardCount)),
				383 => ROW(createRecord('SBFEBalanceCardCount03M', le.SBFEBalanceCardCount03M)),
				384 => ROW(createRecord('SBFEBalanceCardCount06M', le.SBFEBalanceCardCount06M)),
				385 => ROW(createRecord('SBFEBalanceCardCount12M', le.SBFEBalanceCardCount12M)),
				386 => ROW(createRecord('SBFEBalanceCardCount24M', le.SBFEBalanceCardCount24M)),
				387 => ROW(createRecord('SBFEBalanceCardCount36M', le.SBFEBalanceCardCount36M)),
				388 => ROW(createRecord('SBFEBalanceCardCount60M', le.SBFEBalanceCardCount60M)),
				389 => ROW(createRecord('SBFEBalanceCardCount84M', le.SBFEBalanceCardCount84M)),
				390 => ROW(createRecord('SBFEBalanceCardCountEver', le.SBFEBalanceCardCountEver)),
				391 => ROW(createRecord('SBFEBalanceLeaseCount', le.SBFEBalanceLeaseCount)),
				392 => ROW(createRecord('SBFEBalanceLeaseCount03M', le.SBFEBalanceLeaseCount03M)),
				393 => ROW(createRecord('SBFEBalanceLeaseCount06M', le.SBFEBalanceLeaseCount06M)),
				394 => ROW(createRecord('SBFEBalanceLeaseCount12M', le.SBFEBalanceLeaseCount12M)),
				395 => ROW(createRecord('SBFEBalanceLeaseCount24M', le.SBFEBalanceLeaseCount24M)),
				396 => ROW(createRecord('SBFEBalanceLeaseCount36M', le.SBFEBalanceLeaseCount36M)),
				397 => ROW(createRecord('SBFEBalanceLeaseCount60M', le.SBFEBalanceLeaseCount60M)),
				398 => ROW(createRecord('SBFEBalanceLeaseCount84M', le.SBFEBalanceLeaseCount84M)),
				399 => ROW(createRecord('SBFEBalanceLeaseCountEver', le.SBFEBalanceLeaseCountEver)),
				400 => ROW(createRecord('SBFEBalanceLetterCount', le.SBFEBalanceLetterCount)),
				401 => ROW(createRecord('SBFEBalanceLetterCount03M', le.SBFEBalanceLetterCount03M)),
				402 => ROW(createRecord('SBFEBalanceLetterCount06M', le.SBFEBalanceLetterCount06M)),
				403 => ROW(createRecord('SBFEBalanceLetterCount12M', le.SBFEBalanceLetterCount12M)),
				404 => ROW(createRecord('SBFEBalanceLetterCount24M', le.SBFEBalanceLetterCount24M)),
				405 => ROW(createRecord('SBFEBalanceLetterCount36M', le.SBFEBalanceLetterCount36M)),
				406 => ROW(createRecord('SBFEBalanceLetterCount60M', le.SBFEBalanceLetterCount60M)),
				407 => ROW(createRecord('SBFEBalanceLetterCount84M', le.SBFEBalanceLetterCount84M)),
				408 => ROW(createRecord('SBFEBalanceLetterCountEver', le.SBFEBalanceLetterCountEver)),
				409 => ROW(createRecord('SBFEBalanceOELineCount', le.SBFEBalanceOELineCount)),
				410 => ROW(createRecord('SBFEBalanceOELineCount03M', le.SBFEBalanceOELineCount03M)),
				411 => ROW(createRecord('SBFEBalanceOELineCount06M', le.SBFEBalanceOELineCount06M)),
				412 => ROW(createRecord('SBFEBalanceOELineCount12M', le.SBFEBalanceOELineCount12M)),
				413 => ROW(createRecord('SBFEBalanceOELineCount24M', le.SBFEBalanceOELineCount24M)),
				414 => ROW(createRecord('SBFEBalanceOELineCount36M', le.SBFEBalanceOELineCount36M)),
				415 => ROW(createRecord('SBFEBalanceOELineCount60M', le.SBFEBalanceOELineCount60M)),
				416 => ROW(createRecord('SBFEBalanceOELineCount84M', le.SBFEBalanceOELineCount84M)),
				417 => ROW(createRecord('SBFEBalanceOELineCountEver', le.SBFEBalanceOELineCountEver)),
				418 => ROW(createRecord('SBFEBalanceOtherCount', le.SBFEBalanceOtherCount)),
				419 => ROW(createRecord('SBFEBalanceOtherCount03M', le.SBFEBalanceOtherCount03M)),
				420 => ROW(createRecord('SBFEBalanceOtherCount06M', le.SBFEBalanceOtherCount06M)),
				421 => ROW(createRecord('SBFEBalanceOtherCount12M', le.SBFEBalanceOtherCount12M)),
				422 => ROW(createRecord('SBFEBalanceOtherCount24M', le.SBFEBalanceOtherCount24M)),
				423 => ROW(createRecord('SBFEBalanceOtherCount36M', le.SBFEBalanceOtherCount36M)),
				424 => ROW(createRecord('SBFEBalanceOtherCount60M', le.SBFEBalanceOtherCount60M)),
				425 => ROW(createRecord('SBFEBalanceOtherCount84M', le.SBFEBalanceOtherCount84M)),
				426 => ROW(createRecord('SBFEBalanceOtherCountEver', le.SBFEBalanceOtherCountEver)),
				427 => ROW(createRecord('SBFEBalanceClosedCount', le.SBFEBalanceClosedCount)),
				428 => ROW(createRecord('SBFEBalanceClosedCount03M', le.SBFEBalanceClosedCount03M)),
				429 => ROW(createRecord('SBFEBalanceClosedCount06M', le.SBFEBalanceClosedCount06M)),
				430 => ROW(createRecord('SBFEBalanceClosedCount12M', le.SBFEBalanceClosedCount12M)),
				431 => ROW(createRecord('SBFEBalanceClosedCount24M', le.SBFEBalanceClosedCount24M)),
				432 => ROW(createRecord('SBFEOriginalLimitInstallmentAmt', le.SBFEOriginalLimitInstallmentAmt)),
				433 => ROW(createRecord('SBFEOriginalLimitLoanAmt', le.SBFEOriginalLimitLoanAmt)),
				434 => ROW(createRecord('SBFEOriginalLimitLeaseAmt', le.SBFEOriginalLimitLeaseAmt)),
				435 => ROW(createRecord('SBFECurrentLimitRevolvingAmt', le.SBFECurrentLimitRevolvingAmt)),
				436 => ROW(createRecord('SBFELimitRevAmt03M', le.SBFELimitRevAmt03M)),
				437 => ROW(createRecord('SBFELimitRevAmt06M', le.SBFELimitRevAmt06M)),
				438 => ROW(createRecord('SBFELimitRevAmt12M', le.SBFELimitRevAmt12M)),
				439 => ROW(createRecord('SBFELimitRevAmt24M', le.SBFELimitRevAmt24M)),
				440 => ROW(createRecord('SBFELimitRevAmt36M', le.SBFELimitRevAmt36M)),
				441 => ROW(createRecord('SBFELimitRevAmt60M', le.SBFELimitRevAmt60M)),
				442 => ROW(createRecord('SBFELimitRevAmt84M', le.SBFELimitRevAmt84M)),
				443 => ROW(createRecord('SBFECurrentLimitLineAmt', le.SBFECurrentLimitLineAmt)),
				444 => ROW(createRecord('SBFELimitLineAmt03M', le.SBFELimitLineAmt03M)),
				445 => ROW(createRecord('SBFELimitLineAmt06M', le.SBFELimitLineAmt06M)),
				446 => ROW(createRecord('SBFELimitLineAmt12M', le.SBFELimitLineAmt12M)),
				447 => ROW(createRecord('SBFELimitLineAmt24M', le.SBFELimitLineAmt24M)),
				448 => ROW(createRecord('SBFELimitLineAmt36M', le.SBFELimitLineAmt36M)),
				449 => ROW(createRecord('SBFELimitLineAmt60M', le.SBFELimitLineAmt60M)),
				450 => ROW(createRecord('SBFELimitLineAmt84M', le.SBFELimitLineAmt84M)),
				451 => ROW(createRecord('SBFECurrentLimitCardAmt', le.SBFECurrentLimitCardAmt)),
				452 => ROW(createRecord('SBFELimitCardAmt03M', le.SBFELimitCardAmt03M)),
				453 => ROW(createRecord('SBFELimitCardAmt06M', le.SBFELimitCardAmt06M)),
				454 => ROW(createRecord('SBFELimitCardAmt12M', le.SBFELimitCardAmt12M)),
				455 => ROW(createRecord('SBFELimitCardAmt24M', le.SBFELimitCardAmt24M)),
				456 => ROW(createRecord('SBFELimitCardAmt36M', le.SBFELimitCardAmt36M)),
				457 => ROW(createRecord('SBFELimitCardAmt60M', le.SBFELimitCardAmt60M)),
				458 => ROW(createRecord('SBFELimitCardAmt84M', le.SBFELimitCardAmt84M)),
				459 => ROW(createRecord('SBFECurrentLimitOELineAmt', le.SBFECurrentLimitOELineAmt)),
				460 => ROW(createRecord('SBFELimitOELineAmt03M', le.SBFELimitOELineAmt03M)),
				461 => ROW(createRecord('SBFELimitOELineAmt06M', le.SBFELimitOELineAmt06M)),
				462 => ROW(createRecord('SBFELimitOELineAmt12M', le.SBFELimitOELineAmt12M)),
				463 => ROW(createRecord('SBFELimitOELineAmt24M', le.SBFELimitOELineAmt24M)),
				464 => ROW(createRecord('SBFELimitOELineAmt36M', le.SBFELimitOELineAmt36M)),
				465 => ROW(createRecord('SBFELimitOELineAmt60M', le.SBFELimitOELineAmt60M)),
				466 => ROW(createRecord('SBFELimitOELineAmt84M', le.SBFELimitOELineAmt84M)),
				467 => ROW(createRecord('SBFEPaymentDueAmt', le.SBFEPaymentDueAmt)),
				468 => ROW(createRecord('SBFEPaymentDueLoanAmt', le.SBFEPaymentDueLoanAmt)),
				469 => ROW(createRecord('SBFEPaymentDueLineAmt', le.SBFEPaymentDueLineAmt)),
				470 => ROW(createRecord('SBFEPaymentDueCardAmt', le.SBFEPaymentDueCardAmt)),
				471 => ROW(createRecord('SBFEPaymentDueLeaseAmt', le.SBFEPaymentDueLeaseAmt)),
				472 => ROW(createRecord('SBFEPaymentDueLetterAmt', le.SBFEPaymentDueLetterAmt)),
				473 => ROW(createRecord('SBFEPaymentDueOELineAmt', le.SBFEPaymentDueOELineAmt)),
				474 => ROW(createRecord('SBFEPaymentDueOtherAmt', le.SBFEPaymentDueOtherAmt)),
				475 => ROW(createRecord('SBFELastPaymentAmt', le.SBFELastPaymentAmt)),
				476 => ROW(createRecord('SBFELastPaymentLoanAmt', le.SBFELastPaymentLoanAmt)),
				477 => ROW(createRecord('SBFELastPaymentLineAmt', le.SBFELastPaymentLineAmt)),
				478 => ROW(createRecord('SBFELastPaymentCardAmt', le.SBFELastPaymentCardAmt)),
				479 => ROW(createRecord('SBFELastPaymentLeaseAmt', le.SBFELastPaymentLeaseAmt)),
				480 => ROW(createRecord('SBFELastPaymentLetterAmt', le.SBFELastPaymentLetterAmt)),
				481 => ROW(createRecord('SBFELastPaymentOELineAmt', le.SBFELastPaymentOELineAmt)),
				482 => ROW(createRecord('SBFELastPaymentOtherAmt', le.SBFELastPaymentOtherAmt)),
				483 => ROW(createRecord('SBFEUtilCurrentRevolving', le.SBFEUtilCurrentRevolving)),
				484 => ROW(createRecord('SBFEAvailableCurrentRevolving', le.SBFEAvailableCurrentRevolving)),
				485 => ROW(createRecord('SBFEUtilRevolving03M', le.SBFEUtilRevolving03M)),
				486 => ROW(createRecord('SBFEUtilRevolving06M', le.SBFEUtilRevolving06M)),
				487 => ROW(createRecord('SBFEUtilRevolving12M', le.SBFEUtilRevolving12M)),
				488 => ROW(createRecord('SBFEUtilRevolving24M', le.SBFEUtilRevolving24M)),
				489 => ROW(createRecord('SBFEUtilRevolving36M', le.SBFEUtilRevolving36M)),
				490 => ROW(createRecord('SBFEUtilRevolving60M', le.SBFEUtilRevolving60M)),
				491 => ROW(createRecord('SBFEUtilRevolving84M', le.SBFEUtilRevolving84M)),
				492 => ROW(createRecord('SBFEUtilCurrentLine', le.SBFEUtilCurrentLine)),
				493 => ROW(createRecord('SBFEAvailableCurrentLine', le.SBFEAvailableCurrentLine)),
				494 => ROW(createRecord('SBFEUtilLine03M', le.SBFEUtilLine03M)),
				495 => ROW(createRecord('SBFEUtilLine06M', le.SBFEUtilLine06M)),
				496 => ROW(createRecord('SBFEUtilLine12M', le.SBFEUtilLine12M)),
				497 => ROW(createRecord('SBFEUtilLine24M', le.SBFEUtilLine24M)),
				498 => ROW(createRecord('SBFEUtilLine36M', le.SBFEUtilLine36M)),
				499 => ROW(createRecord('SBFEUtilLine60M', le.SBFEUtilLine60M)),
				500 => ROW(createRecord('SBFEUtilLine84M', le.SBFEUtilLine84M)),
				501 => ROW(createRecord('SBFEUtilCurrentCard', le.SBFEUtilCurrentCard)),
				502 => ROW(createRecord('SBFEAvailableCurrentCard', le.SBFEAvailableCurrentCard)),
				503 => ROW(createRecord('SBFEUtilCard03M', le.SBFEUtilCard03M)),
				504 => ROW(createRecord('SBFEUtilCard06M', le.SBFEUtilCard06M)),
				505 => ROW(createRecord('SBFEUtilCard12M', le.SBFEUtilCard12M)),
				506 => ROW(createRecord('SBFEUtilCard24M', le.SBFEUtilCard24M)),
				507 => ROW(createRecord('SBFEUtilCard36M', le.SBFEUtilCard36M)),
				508 => ROW(createRecord('SBFEUtilCard60M', le.SBFEUtilCard60M)),
				509 => ROW(createRecord('SBFEUtilCard84M', le.SBFEUtilCard84M)),
				510 => ROW(createRecord('SBFEUtilCurrentOELine', le.SBFEUtilCurrentOELine)),
				511 => ROW(createRecord('SBFEAvailableCurrentOELine', le.SBFEAvailableCurrentOELine)),
				512 => ROW(createRecord('SBFEUtilOELine03M', le.SBFEUtilOELine03M)),
				513 => ROW(createRecord('SBFEUtilOELine06M', le.SBFEUtilOELine06M)),
				514 => ROW(createRecord('SBFEUtilOELine12M', le.SBFEUtilOELine12M)),
				515 => ROW(createRecord('SBFEUtilOELine24M', le.SBFEUtilOELine24M)),
				516 => ROW(createRecord('SBFEUtilOELine36M', le.SBFEUtilOELine36M)),
				517 => ROW(createRecord('SBFEUtilOELine60M', le.SBFEUtilOELine60M)),
				518 => ROW(createRecord('SBFEUtilOELine84M', le.SBFEUtilOELine84M)),
				519 => ROW(createRecord('SBFEUtil75RevolvingCount', le.SBFEUtil75RevolvingCount)),
				520 => ROW(createRecord('SBFEUtil75LineCount', le.SBFEUtil75LineCount)),
				521 => ROW(createRecord('SBFEUtil75CardCount', le.SBFEUtil75CardCount)),
				522 => ROW(createRecord('SBFEUtil75OELineCount', le.SBFEUtil75OELineCount)),
				523 => ROW(createRecord('SBFEUtil30RevolvingCount', le.SBFEUtil30RevolvingCount)),
				524 => ROW(createRecord('SBFEUtil30LineCount', le.SBFEUtil30LineCount)),
				525 => ROW(createRecord('SBFEUtil30CardCount', le.SBFEUtil30CardCount)),
				526 => ROW(createRecord('SBFEUtil30OELineCount', le.SBFEUtil30OELineCount)),
				527 => ROW(createRecord('SBFEAvgUtil03M', le.SBFEAvgUtil03M)),
				528 => ROW(createRecord('SBFEAvgUtil06M', le.SBFEAvgUtil06M)),
				529 => ROW(createRecord('SBFEAvgUtil12M', le.SBFEAvgUtil12M)),
				530 => ROW(createRecord('SBFEAvgUtil24M', le.SBFEAvgUtil24M)),
				531 => ROW(createRecord('SBFEAvgUtil36M', le.SBFEAvgUtil36M)),
				532 => ROW(createRecord('SBFEAvgUtil60M', le.SBFEAvgUtil60M)),
				533 => ROW(createRecord('SBFEAvgUtil84M', le.SBFEAvgUtil84M)),
				534 => ROW(createRecord('SBFEAvgUtilEver', le.SBFEAvgUtilEver)),
				535 => ROW(createRecord('SBFEAvgUtilLine03M', le.SBFEAvgUtilLine03M)),
				536 => ROW(createRecord('SBFEAvgUtilLine06M', le.SBFEAvgUtilLine06M)),
				537 => ROW(createRecord('SBFEAvgUtilLine12M', le.SBFEAvgUtilLine12M)),
				538 => ROW(createRecord('SBFEAvgUtilLine24M', le.SBFEAvgUtilLine24M)),
				539 => ROW(createRecord('SBFEAvgUtilLine36M', le.SBFEAvgUtilLine36M)),
				540 => ROW(createRecord('SBFEAvgUtilLine60M', le.SBFEAvgUtilLine60M)),
				541 => ROW(createRecord('SBFEAvgUtilLine84M', le.SBFEAvgUtilLine84M)),
				542 => ROW(createRecord('SBFEAvgUtilLineEver', le.SBFEAvgUtilLineEver)),
				543 => ROW(createRecord('SBFEAvgUtilCard03M', le.SBFEAvgUtilCard03M)),
				544 => ROW(createRecord('SBFEAvgUtilCard06M', le.SBFEAvgUtilCard06M)),
				545 => ROW(createRecord('SBFEAvgUtilCard12M', le.SBFEAvgUtilCard12M)),
				546 => ROW(createRecord('SBFEAvgUtilCard24M', le.SBFEAvgUtilCard24M)),
				547 => ROW(createRecord('SBFEAvgUtilCard36M', le.SBFEAvgUtilCard36M)),
				548 => ROW(createRecord('SBFEAvgUtilCard60M', le.SBFEAvgUtilCard60M)),
				549 => ROW(createRecord('SBFEAvgUtilCard84M', le.SBFEAvgUtilCard84M)),
				550 => ROW(createRecord('SBFEAvgUtilCardEver', le.SBFEAvgUtilCardEver)),
				551 => ROW(createRecord('SBFEAvgUtilOELine03M', le.SBFEAvgUtilOELine03M)),
				552 => ROW(createRecord('SBFEAvgUtilOELine06M', le.SBFEAvgUtilOELine06M)),
				553 => ROW(createRecord('SBFEAvgUtilOELine12M', le.SBFEAvgUtilOELine12M)),
				554 => ROW(createRecord('SBFEAvgUtilOELine24M', le.SBFEAvgUtilOELine24M)),
				555 => ROW(createRecord('SBFEAvgUtilOELine36M', le.SBFEAvgUtilOELine36M)),
				556 => ROW(createRecord('SBFEAvgUtilOELine60M', le.SBFEAvgUtilOELine60M)),
				557 => ROW(createRecord('SBFEAvgUtilOELine84M', le.SBFEAvgUtilOELine84M)),
				558 => ROW(createRecord('SBFEAvgUtilOELineEver', le.SBFEAvgUtilOELineEver)),
				559 => ROW(createRecord('SBFEHighUtilRevolvingAmt', le.SBFEHighUtilRevolvingAmt)),
				560 => ROW(createRecord('SBFEHighUtilLineAmt', le.SBFEHighUtilLineAmt)),
				561 => ROW(createRecord('SBFEHighUtilCardAmt', le.SBFEHighUtilCardAmt)),
				562 => ROW(createRecord('SBFEHighUtiliztionOELineAmt', le.SBFEHighUtiliztionOELineAmt)),
				563 => ROW(createRecord('SBFEHighDelqOpen', le.SBFEHighDelqOpen)),
				564 => ROW(createRecord('SBFEHighDelq03M', le.SBFEHighDelq03M)),
				565 => ROW(createRecord('SBFEHighDelq06M', le.SBFEHighDelq06M)),
				566 => ROW(createRecord('SBFEHighDelq12M', le.SBFEHighDelq12M)),
				567 => ROW(createRecord('SBFEHighDelq24M', le.SBFEHighDelq24M)),
				568 => ROW(createRecord('SBFEHighDelq36M', le.SBFEHighDelq36M)),
				569 => ROW(createRecord('SBFEHighDelq60M', le.SBFEHighDelq60M)),
				570 => ROW(createRecord('SBFEHighDelq84M', le.SBFEHighDelq84M)),
				571 => ROW(createRecord('SBFEHighDelqEver', le.SBFEHighDelqEver)),
				572 => ROW(createRecord('SBFEDelqLoan', le.SBFEDelqLoan)),
				573 => ROW(createRecord('SBFEHighDelqLoan03M', le.SBFEHighDelqLoan03M)),
				574 => ROW(createRecord('SBFEHighDelqLoan06M', le.SBFEHighDelqLoan06M)),
				575 => ROW(createRecord('SBFEHighDelqLoan12M', le.SBFEHighDelqLoan12M)),
				576 => ROW(createRecord('SBFEHighDelqLoan24M', le.SBFEHighDelqLoan24M)),
				577 => ROW(createRecord('SBFEHighDelqLoan36M', le.SBFEHighDelqLoan36M)),
				578 => ROW(createRecord('SBFEHighDelqLoan60M', le.SBFEHighDelqLoan60M)),
				579 => ROW(createRecord('SBFEHighDelqLoan84M', le.SBFEHighDelqLoan84M)),
				580 => ROW(createRecord('SBFEHighDelqLoanEver', le.SBFEHighDelqLoanEver)),
				581 => ROW(createRecord('SBFEHighDelqLine', le.SBFEHighDelqLine)),
				582 => ROW(createRecord('SBFEHighDelqLine03M', le.SBFEHighDelqLine03M)),
				583 => ROW(createRecord('SBFEHighDelqLine06M', le.SBFEHighDelqLine06M)),
				584 => ROW(createRecord('SBFEHighDelqLine12M', le.SBFEHighDelqLine12M)),
				585 => ROW(createRecord('SBFEHighDelqLine24M', le.SBFEHighDelqLine24M)),
				586 => ROW(createRecord('SBFEHighDelqLine36M', le.SBFEHighDelqLine36M)),
				587 => ROW(createRecord('SBFEHighDelqLine60M', le.SBFEHighDelqLine60M)),
				588 => ROW(createRecord('SBFEHighDelqLine84M', le.SBFEHighDelqLine84M)),
				589 => ROW(createRecord('SBFEHighDelqLineEver', le.SBFEHighDelqLineEver)),
				590 => ROW(createRecord('SBFEHighDelqCard', le.SBFEHighDelqCard)),
				591 => ROW(createRecord('SBFEHighDelqCard03M', le.SBFEHighDelqCard03M)),
				592 => ROW(createRecord('SBFEHighDelqCard06M', le.SBFEHighDelqCard06M)),
				593 => ROW(createRecord('SBFEHighDelqCard12M', le.SBFEHighDelqCard12M)),
				594 => ROW(createRecord('SBFEHighDelqCard24M', le.SBFEHighDelqCard24M)),
				595 => ROW(createRecord('SBFEHighDelqCard36M', le.SBFEHighDelqCard36M)),
				596 => ROW(createRecord('SBFEHighDelqCard60M', le.SBFEHighDelqCard60M)),
				597 => ROW(createRecord('SBFEHighDelqCard84M', le.SBFEHighDelqCard84M)),
				598 => ROW(createRecord('SBFEHighDelqCardEver', le.SBFEHighDelqCardEver)),
				599 => ROW(createRecord('SBFEHighDelqLease', le.SBFEHighDelqLease)),
				600 => ROW(createRecord('SBFEHighDelqLease03M', le.SBFEHighDelqLease03M)),
				601 => ROW(createRecord('SBFEHighDelqLease06M', le.SBFEHighDelqLease06M)),
				602 => ROW(createRecord('SBFEHighDelqLease12', le.SBFEHighDelqLease12)),
				603 => ROW(createRecord('SBFEHighDelqLease24M', le.SBFEHighDelqLease24M)),
				604 => ROW(createRecord('SBFEHighDelqLease36M', le.SBFEHighDelqLease36M)),
				605 => ROW(createRecord('SBFEHighDelqLease60M', le.SBFEHighDelqLease60M)),
				606 => ROW(createRecord('SBFEHighDelqLease84M', le.SBFEHighDelqLease84M)),
				607 => ROW(createRecord('SBFEHighDelqLeaseEver', le.SBFEHighDelqLeaseEver)),
				608 => ROW(createRecord('SBFEHighDelqLetter', le.SBFEHighDelqLetter)),
				609 => ROW(createRecord('SBFEHighDelqLetter03M', le.SBFEHighDelqLetter03M)),
				610 => ROW(createRecord('SBFEHighDelqLetter06M', le.SBFEHighDelqLetter06M)),
				611 => ROW(createRecord('SBFEHighDelqLetter12M', le.SBFEHighDelqLetter12M)),
				612 => ROW(createRecord('SBFEHighDelqLetter24M', le.SBFEHighDelqLetter24M)),
				613 => ROW(createRecord('SBFEHighDelqLetter36M', le.SBFEHighDelqLetter36M)),
				614 => ROW(createRecord('SBFEHighDelqLetter60M', le.SBFEHighDelqLetter60M)),
				615 => ROW(createRecord('SBFEHighDelqLetter84M', le.SBFEHighDelqLetter84M)),
				616 => ROW(createRecord('SBFEHighDelqLetterEver', le.SBFEHighDelqLetterEver)),
				617 => ROW(createRecord('SBFEHighDelqOELine', le.SBFEHighDelqOELine)),
				618 => ROW(createRecord('SBFEHighDelqOELine03M', le.SBFEHighDelqOELine03M)),
				619 => ROW(createRecord('SBFEHighDelqOELine06M', le.SBFEHighDelqOELine06M)),
				620 => ROW(createRecord('SBFEHighDelqOELine12M', le.SBFEHighDelqOELine12M)),
				621 => ROW(createRecord('SBFEHighDelqOELine24M', le.SBFEHighDelqOELine24M)),
				622 => ROW(createRecord('SBFEHighDelqOELine36M', le.SBFEHighDelqOELine36M)),
				623 => ROW(createRecord('SBFEHighDelqOELine60M', le.SBFEHighDelqOELine60M)),
				624 => ROW(createRecord('SBFEHighDelqOELine84M', le.SBFEHighDelqOELine84M)),
				625 => ROW(createRecord('SBFEHighDelqOELineEver', le.SBFEHighDelqOELineEver)),
				626 => ROW(createRecord('SBFEHighDelqOther', le.SBFEHighDelqOther)),
				627 => ROW(createRecord('SBFEHighDelqOther03M', le.SBFEHighDelqOther03M)),
				628 => ROW(createRecord('SBFEHighDelqOther06M', le.SBFEHighDelqOther06M)),
				629 => ROW(createRecord('SBFEHighDelqOther12M', le.SBFEHighDelqOther12M)),
				630 => ROW(createRecord('SBFEHighDelqOther24M', le.SBFEHighDelqOther24M)),
				631 => ROW(createRecord('SBFEHighDelqOther36M', le.SBFEHighDelqOther36M)),
				632 => ROW(createRecord('SBFEHighDelqOther60M', le.SBFEHighDelqOther60M)),
				633 => ROW(createRecord('SBFEHighDelqOther84M', le.SBFEHighDelqOther84M)),
				634 => ROW(createRecord('SBFEHighDelqOtherEver', le.SBFEHighDelqOtherEver)),
				635 => ROW(createRecord('SBFEHighDelqRevOpen', le.SBFEHighDelqRevOpen)),
				636 => ROW(createRecord('SBFEHighDelqRev03M', le.SBFEHighDelqRev03M)),
				637 => ROW(createRecord('SBFEHighDelqRev06M', le.SBFEHighDelqRev06M)),
				638 => ROW(createRecord('SBFEHighDelqRev12M', le.SBFEHighDelqRev12M)),
				639 => ROW(createRecord('SBFEHighDelqRev24M', le.SBFEHighDelqRev24M)),
				640 => ROW(createRecord('SBFEHighDelqRev36M', le.SBFEHighDelqRev36M)),
				641 => ROW(createRecord('SBFEHighDelqRev60M', le.SBFEHighDelqRev60M)),
				642 => ROW(createRecord('SBFEHighDelqRev84M', le.SBFEHighDelqRev84M)),
				643 => ROW(createRecord('SBFEHighDelqRevEver', le.SBFEHighDelqRevEver)),
				644 => ROW(createRecord('SBFEHighDelqInstOpen', le.SBFEHighDelqInstOpen)),
				645 => ROW(createRecord('SBFEHighDelqInst03M', le.SBFEHighDelqInst03M)),
				646 => ROW(createRecord('SBFEHighDelqInst06M', le.SBFEHighDelqInst06M)),
				647 => ROW(createRecord('SBFEHighDelqInst12M', le.SBFEHighDelqInst12M)),
				648 => ROW(createRecord('SBFEHighDelqInst24M', le.SBFEHighDelqInst24M)),
				649 => ROW(createRecord('SBFEHighDelqInst36M', le.SBFEHighDelqInst36M)),
				650 => ROW(createRecord('SBFEHighDelqInst60M', le.SBFEHighDelqInst60M)),
				651 => ROW(createRecord('SBFEHighDelqInst84M', le.SBFEHighDelqInst84M)),
				652 => ROW(createRecord('SBFEHighDelqInstEver', le.SBFEHighDelqInstEver)),
				653 => ROW(createRecord('SBFESatisfactoryCount', le.SBFESatisfactoryCount)),
				654 => ROW(createRecord('SBFESatisfactoryLoanCount', le.SBFESatisfactoryLoanCount)),
				655 => ROW(createRecord('SBFESatisfactoryLineCount', le.SBFESatisfactoryLineCount)),
				656 => ROW(createRecord('SBFESatisfactoryCardCount', le.SBFESatisfactoryCardCount)),
				657 => ROW(createRecord('SBFESatisfactoryleaseCount', le.SBFESatisfactoryleaseCount)),
				658 => ROW(createRecord('SBFESatisfactoryLetterCount', le.SBFESatisfactoryLetterCount)),
				659 => ROW(createRecord('SBFESatisfactoryOELineCount', le.SBFESatisfactoryOELineCount)),
				660 => ROW(createRecord('SBFESatisfactoryOtherCount', le.SBFESatisfactoryOtherCount)),
				661 => ROW(createRecord('SBFETimeNewestDelq', le.SBFETimeNewestDelq)),
				662 => ROW(createRecord('SBFEDelq1CountTtl', le.SBFEDelq1CountTtl)),
				663 => ROW(createRecord('SBFEDelq1CountTtlChargeoff', le.SBFEDelq1CountTtlChargeoff)),
				664 => ROW(createRecord('SBFEDelq1Count', le.SBFEDelq1Count)),
				665 => ROW(createRecord('SBFEDelq1Count03M', le.SBFEDelq1Count03M)),
				666 => ROW(createRecord('SBFEDelq1Count06M', le.SBFEDelq1Count06M)),
				667 => ROW(createRecord('SBFEDelq1Count12M', le.SBFEDelq1Count12M)),
				668 => ROW(createRecord('SBFEDelq1Count24M', le.SBFEDelq1Count24M)),
				669 => ROW(createRecord('SBFEDelq1Count36', le.SBFEDelq1Count36)),
				670 => ROW(createRecord('SBFEDelq1Count60', le.SBFEDelq1Count60)),
				671 => ROW(createRecord('SBFEDelq1Count84M', le.SBFEDelq1Count84M)),
				672 => ROW(createRecord('SBFEDelq1CountEver', le.SBFEDelq1CountEver)),
				673 => ROW(createRecord('SBFEDelq1CountEverTtl', le.SBFEDelq1CountEverTtl)),
				674 => ROW(createRecord('SBFEDelq1LoanCount', le.SBFEDelq1LoanCount)),
				675 => ROW(createRecord('SBFEDelq1LoanCount03M', le.SBFEDelq1LoanCount03M)),
				676 => ROW(createRecord('SBFEDelq1LoanCount06M', le.SBFEDelq1LoanCount06M)),
				677 => ROW(createRecord('SBFEDelq1LoanCount12M', le.SBFEDelq1LoanCount12M)),
				678 => ROW(createRecord('SBFEDelq1LoanCount24M', le.SBFEDelq1LoanCount24M)),
				679 => ROW(createRecord('SBFEDelq1LoanCount36M', le.SBFEDelq1LoanCount36M)),
				680 => ROW(createRecord('SBFEDelq1LoanCount60M', le.SBFEDelq1LoanCount60M)),
				681 => ROW(createRecord('SBFEDelq1LoanCount84M', le.SBFEDelq1LoanCount84M)),
				682 => ROW(createRecord('SBFEDelq1LoanCountEver', le.SBFEDelq1LoanCountEver)),
				683 => ROW(createRecord('SBFEDelq1LineCount', le.SBFEDelq1LineCount)),
				684 => ROW(createRecord('SBFEDelq1LineCount03M', le.SBFEDelq1LineCount03M)),
				685 => ROW(createRecord('SBFEDelq1LineCount06M', le.SBFEDelq1LineCount06M)),
				686 => ROW(createRecord('SBFEDelq1LineCount12M', le.SBFEDelq1LineCount12M)),
				687 => ROW(createRecord('SBFEDelq1LineCount24M', le.SBFEDelq1LineCount24M)),
				688 => ROW(createRecord('SBFEDelq1LineCount36M', le.SBFEDelq1LineCount36M)),
				689 => ROW(createRecord('SBFEDelq1LineCount60M', le.SBFEDelq1LineCount60M)),
				690 => ROW(createRecord('SBFEDelq1LineCount84M', le.SBFEDelq1LineCount84M)),
				691 => ROW(createRecord('SBFEDelq1LineCountEver', le.SBFEDelq1LineCountEver)),
				692 => ROW(createRecord('SBFEDelq1CardCount', le.SBFEDelq1CardCount)),
				693 => ROW(createRecord('SBFEDelq1CardCount03M', le.SBFEDelq1CardCount03M)),
				694 => ROW(createRecord('SBFEDelq1CardCount06M', le.SBFEDelq1CardCount06M)),
				695 => ROW(createRecord('SBFEDelq1CardCount12M', le.SBFEDelq1CardCount12M)),
				696 => ROW(createRecord('SBFEDelq1CardCount24M', le.SBFEDelq1CardCount24M)),
				697 => ROW(createRecord('SBFEDelq1CardCount36M', le.SBFEDelq1CardCount36M)),
				698 => ROW(createRecord('SBFEDelq1CardCount60M', le.SBFEDelq1CardCount60M)),
				699 => ROW(createRecord('SBFEDelq1CardCount84M', le.SBFEDelq1CardCount84M)),
				700 => ROW(createRecord('SBFEDelq1CardCountEver', le.SBFEDelq1CardCountEver)),
				701 => ROW(createRecord('SBFEDelq1LeaseCount', le.SBFEDelq1LeaseCount)),
				702 => ROW(createRecord('SBFEDelq1LeaseCount03M', le.SBFEDelq1LeaseCount03M)),
				703 => ROW(createRecord('SBFEDelq1LeaseCount06M', le.SBFEDelq1LeaseCount06M)),
				704 => ROW(createRecord('SBFEDelq1LeaseCount12M', le.SBFEDelq1LeaseCount12M)),
				705 => ROW(createRecord('SBFEDelq1LeaseCount24M', le.SBFEDelq1LeaseCount24M)),
				706 => ROW(createRecord('SBFEDelq1LeaseCount36M', le.SBFEDelq1LeaseCount36M)),
				707 => ROW(createRecord('SBFEDelq1LeaseCount60M', le.SBFEDelq1LeaseCount60M)),
				708 => ROW(createRecord('SBFEDelq1LeaseCount84M', le.SBFEDelq1LeaseCount84M)),
				709 => ROW(createRecord('SBFEDelq1LeaseCountEver', le.SBFEDelq1LeaseCountEver)),
				710 => ROW(createRecord('SBFEDelq1LetterCount', le.SBFEDelq1LetterCount)),
				711 => ROW(createRecord('SBFEDelq1LetterCount03M', le.SBFEDelq1LetterCount03M)),
				712 => ROW(createRecord('SBFEDelq1LetterCount06M', le.SBFEDelq1LetterCount06M)),
				713 => ROW(createRecord('SBFEDelq1LetterCount12M', le.SBFEDelq1LetterCount12M)),
				714 => ROW(createRecord('SBFEDelq1LetterCount24M', le.SBFEDelq1LetterCount24M)),
				715 => ROW(createRecord('SBFEDelq1LetterCount36M', le.SBFEDelq1LetterCount36M)),
				716 => ROW(createRecord('SBFEDelq1LetterCount60M', le.SBFEDelq1LetterCount60M)),
				717 => ROW(createRecord('SBFEDelq1LetterCount84M', le.SBFEDelq1LetterCount84M)),
				718 => ROW(createRecord('SBFEDelq1LetterCountEver', le.SBFEDelq1LetterCountEver)),
				719 => ROW(createRecord('SBFEDelq1OELineCount', le.SBFEDelq1OELineCount)),
				720 => ROW(createRecord('SBFEDelq1OELineCount03M', le.SBFEDelq1OELineCount03M)),
				721 => ROW(createRecord('SBFEDelq1OELineCount06M', le.SBFEDelq1OELineCount06M)),
				722 => ROW(createRecord('SBFEDelq1OELineCount12M', le.SBFEDelq1OELineCount12M)),
				723 => ROW(createRecord('SBFEDelq1OELineCount24M', le.SBFEDelq1OELineCount24M)),
				724 => ROW(createRecord('SBFEDelq1OELineCount36M', le.SBFEDelq1OELineCount36M)),
				725 => ROW(createRecord('SBFEDelq1OELineCount60M', le.SBFEDelq1OELineCount60M)),
				726 => ROW(createRecord('SBFEDelq1OELineCount84M', le.SBFEDelq1OELineCount84M)),
				727 => ROW(createRecord('SBFEDelq1OELineCountEver', le.SBFEDelq1OELineCountEver)),
				728 => ROW(createRecord('SBFEDelq1OtherCount', le.SBFEDelq1OtherCount)),
				729 => ROW(createRecord('SBFEDelq1OtherCount03M', le.SBFEDelq1OtherCount03M)),
				730 => ROW(createRecord('SBFEDelq1OtherCount06M', le.SBFEDelq1OtherCount06M)),
				731 => ROW(createRecord('SBFEDelq1OtherCount12M', le.SBFEDelq1OtherCount12M)),
				732 => ROW(createRecord('SBFEDelq1OtherCount24M', le.SBFEDelq1OtherCount24M)),
				733 => ROW(createRecord('SBFEDelq1OtherCount36M', le.SBFEDelq1OtherCount36M)),
				734 => ROW(createRecord('SBFEDelq1OtherCount60M', le.SBFEDelq1OtherCount60M)),
				735 => ROW(createRecord('SBFEDelq1OtherCount84M', le.SBFEDelq1OtherCount84M)),
				736 => ROW(createRecord('SBFEDelq1OtherCountEver', le.SBFEDelq1OtherCountEver)),
				737 => ROW(createRecord('SBFEDelq1LeaseCountEverTtl', le.SBFEDelq1LeaseCountEverTtl)),
				738 => ROW(createRecord('SBFEDelq1LoanCountEverTtl', le.SBFEDelq1LoanCountEverTtl)),
				739 => ROW(createRecord('SBFEDelqLetterCountEverTtl', le.SBFEDelqLetterCountEverTtl)),
				740 => ROW(createRecord('SBFEDelq1InstCountEverTtl', le.SBFEDelq1InstCountEverTtl)),
				741 => ROW(createRecord('SBFEDelq1InstCountEver', le.SBFEDelq1InstCountEver)),
				742 => ROW(createRecord('SBFEDelq1InstCountTtl', le.SBFEDelq1InstCountTtl)),
				743 => ROW(createRecord('SBFEDelq1InstCountTtlChargeoff', le.SBFEDelq1InstCountTtlChargeoff)),
				744 => ROW(createRecord('SBFEDelq1RevCountEverTtl', le.SBFEDelq1RevCountEverTtl)),
				745 => ROW(createRecord('SBFEDelq1RevCountEver', le.SBFEDelq1RevCountEver)),
				746 => ROW(createRecord('SBFEDelq1RevCountTtl', le.SBFEDelq1RevCountTtl)),
				747 => ROW(createRecord('SBFEDelq1RevCountTtlChargeoff', le.SBFEDelq1RevCountTtlChargeoff)),
				748 => ROW(createRecord('SBFEDelq31CountTtl', le.SBFEDelq31CountTtl)),
				749 => ROW(createRecord('SBFEDelq31CountTtlChargeoff', le.SBFEDelq31CountTtlChargeoff)),
				750 => ROW(createRecord('SBFEDelq31Count', le.SBFEDelq31Count)),
				751 => ROW(createRecord('SBFEDelq31Count03M', le.SBFEDelq31Count03M)),
				752 => ROW(createRecord('SBFEDelq31Count06M', le.SBFEDelq31Count06M)),
				753 => ROW(createRecord('SBFEDelq31Count12M', le.SBFEDelq31Count12M)),
				754 => ROW(createRecord('SBFEDelq31Count24M', le.SBFEDelq31Count24M)),
				755 => ROW(createRecord('SBFEDelq31Count36M', le.SBFEDelq31Count36M)),
				756 => ROW(createRecord('SBFEDelq31Count60M', le.SBFEDelq31Count60M)),
				757 => ROW(createRecord('SBFEDelq31Count84M', le.SBFEDelq31Count84M)),
				758 => ROW(createRecord('SBFEDelq31CountEver', le.SBFEDelq31CountEver)),
				759 => ROW(createRecord('SBFEDelq31CountEverTtl', le.SBFEDelq31CountEverTtl)),
				760 => ROW(createRecord('SBFEDelq31LoanCount', le.SBFEDelq31LoanCount)),
				761 => ROW(createRecord('SBFEDelq31LoanCount03M', le.SBFEDelq31LoanCount03M)),
				762 => ROW(createRecord('SBFEDelq31LoanCount06M', le.SBFEDelq31LoanCount06M)),
				763 => ROW(createRecord('SBFEDelq31LoanCount12M', le.SBFEDelq31LoanCount12M)),
				764 => ROW(createRecord('SBFEDelq31LoanCount24M', le.SBFEDelq31LoanCount24M)),
				765 => ROW(createRecord('SBFEDelq31LoanCount36M', le.SBFEDelq31LoanCount36M)),
				766 => ROW(createRecord('SBFEDelq31LoanCount60M', le.SBFEDelq31LoanCount60M)),
				767 => ROW(createRecord('SBFEDelq31LoanCount84M', le.SBFEDelq31LoanCount84M)),
				768 => ROW(createRecord('SBFEDelq31LoanCountEver', le.SBFEDelq31LoanCountEver)),
				769 => ROW(createRecord('SBFEDelq31LineCount', le.SBFEDelq31LineCount)),
				770 => ROW(createRecord('SBFEDelq31LineCount03M', le.SBFEDelq31LineCount03M)),
				771 => ROW(createRecord('SBFEDelq31LineCount06M', le.SBFEDelq31LineCount06M)),
				772 => ROW(createRecord('SBFEDelq31LineCount12M', le.SBFEDelq31LineCount12M)),
				773 => ROW(createRecord('SBFEDelq31LineCount24M', le.SBFEDelq31LineCount24M)),
				774 => ROW(createRecord('SBFEDelq31LineCount36M', le.SBFEDelq31LineCount36M)),
				775 => ROW(createRecord('SBFEDelq31LineCount60M', le.SBFEDelq31LineCount60M)),
				776 => ROW(createRecord('SBFEDelq31LineCount84M', le.SBFEDelq31LineCount84M)),
				777 => ROW(createRecord('SBFEDelq31LineCountEver', le.SBFEDelq31LineCountEver)),
				778 => ROW(createRecord('SBFEDelq31CardCount', le.SBFEDelq31CardCount)),
				779 => ROW(createRecord('SBFEDelq31CardCount03M', le.SBFEDelq31CardCount03M)),
				780 => ROW(createRecord('SBFEDelq31CardCount06M', le.SBFEDelq31CardCount06M)),
				781 => ROW(createRecord('SBFEDelq31CardCount12M', le.SBFEDelq31CardCount12M)),
				782 => ROW(createRecord('SBFEDelq31CardCount24M', le.SBFEDelq31CardCount24M)),
				783 => ROW(createRecord('SBFEDelq31CardCount36M', le.SBFEDelq31CardCount36M)),
				784 => ROW(createRecord('SBFEDelq31CardCount60M', le.SBFEDelq31CardCount60M)),
				785 => ROW(createRecord('SBFEDelq31CardCount84M', le.SBFEDelq31CardCount84M)),
				786 => ROW(createRecord('SBFEDelq31CardCountEver', le.SBFEDelq31CardCountEver)),
				787 => ROW(createRecord('SBFEDelq31LeaseCount', le.SBFEDelq31LeaseCount)),
				788 => ROW(createRecord('SBFEDelq31LeaseCount03M', le.SBFEDelq31LeaseCount03M)),
				789 => ROW(createRecord('SBFEDelq31LeaseCount06M', le.SBFEDelq31LeaseCount06M)),
				790 => ROW(createRecord('SBFEDelq31LeaseCount12M', le.SBFEDelq31LeaseCount12M)),
				791 => ROW(createRecord('SBFEDelq31LeaseCount24M', le.SBFEDelq31LeaseCount24M)),
				792 => ROW(createRecord('SBFEDelq31LeaseCount36M', le.SBFEDelq31LeaseCount36M)),
				793 => ROW(createRecord('SBFEDelq31LeaseCount60M', le.SBFEDelq31LeaseCount60M)),
				794 => ROW(createRecord('SBFEDelq31LeaseCount84M', le.SBFEDelq31LeaseCount84M)),
				795 => ROW(createRecord('SBFEDelq31LeaseCountEver', le.SBFEDelq31LeaseCountEver)),
				796 => ROW(createRecord('SBFEDelq31LetterCount', le.SBFEDelq31LetterCount)),
				797 => ROW(createRecord('SBFEDelq31LetterCount03M', le.SBFEDelq31LetterCount03M)),
				798 => ROW(createRecord('SBFEDelq31LetterCount06M', le.SBFEDelq31LetterCount06M)),
				799 => ROW(createRecord('SBFEDelq31LetterCount12M', le.SBFEDelq31LetterCount12M)),
				800 => ROW(createRecord('SBFEDelq31LetterCount24M', le.SBFEDelq31LetterCount24M)),
				801 => ROW(createRecord('SBFEDelq31LetterCount36M', le.SBFEDelq31LetterCount36M)),
				802 => ROW(createRecord('SBFEDelq31LetterCount60M', le.SBFEDelq31LetterCount60M)),
				803 => ROW(createRecord('SBFEDelq31LetterCount84M', le.SBFEDelq31LetterCount84M)),
				804 => ROW(createRecord('SBFEDelq31LetterCountEver', le.SBFEDelq31LetterCountEver)),
				805 => ROW(createRecord('SBFEDelq31OELineCount', le.SBFEDelq31OELineCount)),
				806 => ROW(createRecord('SBFEDelq31OELineCount03M', le.SBFEDelq31OELineCount03M)),
				807 => ROW(createRecord('SBFEDelq31OELineCount06M', le.SBFEDelq31OELineCount06M)),
				808 => ROW(createRecord('SBFEDelq31OELineCount12M', le.SBFEDelq31OELineCount12M)),
				809 => ROW(createRecord('SBFEDelq31OELineCount24M', le.SBFEDelq31OELineCount24M)),
				810 => ROW(createRecord('SBFEDelq31OELineCount36M', le.SBFEDelq31OELineCount36M)),
				811 => ROW(createRecord('SBFEDelq31OELineCount60M', le.SBFEDelq31OELineCount60M)),
				812 => ROW(createRecord('SBFEDelq31OELineCount84M', le.SBFEDelq31OELineCount84M)),
				813 => ROW(createRecord('SBFEDelq31OELineCountEver', le.SBFEDelq31OELineCountEver)),
				814 => ROW(createRecord('SBFEDelq31OtherCount', le.SBFEDelq31OtherCount)),
				815 => ROW(createRecord('SBFEDelq31OtherCount03M', le.SBFEDelq31OtherCount03M)),
				816 => ROW(createRecord('SBFEDelq31OtherCount06M', le.SBFEDelq31OtherCount06M)),
				817 => ROW(createRecord('SBFEDelq31OtherCount12M', le.SBFEDelq31OtherCount12M)),
				818 => ROW(createRecord('SBFEDelq31OtherCount24M', le.SBFEDelq31OtherCount24M)),
				819 => ROW(createRecord('SBFEDelq31OtherCount36M', le.SBFEDelq31OtherCount36M)),
				820 => ROW(createRecord('SBFEDelq31OtherCount60M', le.SBFEDelq31OtherCount60M)),
				821 => ROW(createRecord('SBFEDelq31OtherCount84M', le.SBFEDelq31OtherCount84M)),
				822 => ROW(createRecord('SBFEDelq31OtherCountEver', le.SBFEDelq31OtherCountEver)),
				823 => ROW(createRecord('SBFEDelq31InstCountTtl', le.SBFEDelq31InstCountTtl)),
				824 => ROW(createRecord('SBFEDelq31InstCountEver', le.SBFEDelq31InstCountEver)),
				825 => ROW(createRecord('SBFEDelq31InstCountTtlChargeoff', le.SBFEDelq31InstCountTtlChargeoff)),
				826 => ROW(createRecord('SBFEDelq31RevCountEverTtl', le.SBFEDelq31RevCountEverTtl)),
				827 => ROW(createRecord('SBFEDelq31RevCountEver', le.SBFEDelq31RevCountEver)),
				828 => ROW(createRecord('SBFEDelq31RevCountTtl', le.SBFEDelq31RevCountTtl)),
				829 => ROW(createRecord('SBFEDelq31RevCountTtlChargeoff', le.SBFEDelq31RevCountTtlChargeoff)),
				830 => ROW(createRecord('SBFEDelq61CountTtl', le.SBFEDelq61CountTtl)),
				831 => ROW(createRecord('SBFEDelq61CountTtlChargeoff', le.SBFEDelq61CountTtlChargeoff)),
				832 => ROW(createRecord('SBFEDelq61Count', le.SBFEDelq61Count)),
				833 => ROW(createRecord('SBFEDelq61Count03M', le.SBFEDelq61Count03M)),
				834 => ROW(createRecord('SBFEDelq61Count06M', le.SBFEDelq61Count06M)),
				835 => ROW(createRecord('SBFEDelq61Count12M', le.SBFEDelq61Count12M)),
				836 => ROW(createRecord('SBFEDelq61Count24M', le.SBFEDelq61Count24M)),
				837 => ROW(createRecord('SBFEDelq61Count36M', le.SBFEDelq61Count36M)),
				838 => ROW(createRecord('SBFEDelq61Count60M', le.SBFEDelq61Count60M)),
				839 => ROW(createRecord('SBFEDelq61Count84M', le.SBFEDelq61Count84M)),
				840 => ROW(createRecord('SBFEDelq61CountEver', le.SBFEDelq61CountEver)),
				841 => ROW(createRecord('SBFEDelq61CountEverTtl', le.SBFEDelq61CountEverTtl)),
				842 => ROW(createRecord('SBFEDelq61LoanCount', le.SBFEDelq61LoanCount)),
				843 => ROW(createRecord('SBFEDelq61LoanCount03M', le.SBFEDelq61LoanCount03M)),
				844 => ROW(createRecord('SBFEDelq61LoanCount06M', le.SBFEDelq61LoanCount06M)),
				845 => ROW(createRecord('SBFEDelq61LoanCount12M', le.SBFEDelq61LoanCount12M)),
				846 => ROW(createRecord('SBFEDelq61LoanCount24M', le.SBFEDelq61LoanCount24M)),
				847 => ROW(createRecord('SBFEDelq61LoanCount36M', le.SBFEDelq61LoanCount36M)),
				848 => ROW(createRecord('SBFEDelq61LoanCount60M', le.SBFEDelq61LoanCount60M)),
				849 => ROW(createRecord('SBFEDelq61LoanCount84M', le.SBFEDelq61LoanCount84M)),
				850 => ROW(createRecord('SBFEDelq61LoanCountEver', le.SBFEDelq61LoanCountEver)),
				851 => ROW(createRecord('SBFEDelq61LineCount', le.SBFEDelq61LineCount)),
				852 => ROW(createRecord('SBFEDelq61LineCount03M', le.SBFEDelq61LineCount03M)),
				853 => ROW(createRecord('SBFEDelq61LineCount06M', le.SBFEDelq61LineCount06M)),
				854 => ROW(createRecord('SBFEDelq61LineCount12M', le.SBFEDelq61LineCount12M)),
				855 => ROW(createRecord('SBFEDelq61LineCount24M', le.SBFEDelq61LineCount24M)),
				856 => ROW(createRecord('SBFEDelq61LineCount36M', le.SBFEDelq61LineCount36M)),
				857 => ROW(createRecord('SBFEDelq61LineCount60M', le.SBFEDelq61LineCount60M)),
				858 => ROW(createRecord('SBFEDelq61LineCount84M', le.SBFEDelq61LineCount84M)),
				859 => ROW(createRecord('SBFEDelq61LineCountEver', le.SBFEDelq61LineCountEver)),
				860 => ROW(createRecord('SBFEDelq61CardCount', le.SBFEDelq61CardCount)),
				861 => ROW(createRecord('SBFEDelq61CardCount03M', le.SBFEDelq61CardCount03M)),
				862 => ROW(createRecord('SBFEDelq61CardCount06M', le.SBFEDelq61CardCount06M)),
				863 => ROW(createRecord('SBFEDelq61CardCount12M', le.SBFEDelq61CardCount12M)),
				864 => ROW(createRecord('SBFEDelq61CardCount24M', le.SBFEDelq61CardCount24M)),
				865 => ROW(createRecord('SBFEDelq61CardCount36M', le.SBFEDelq61CardCount36M)),
				866 => ROW(createRecord('SBFEDelq61CardCount60M', le.SBFEDelq61CardCount60M)),
				867 => ROW(createRecord('SBFEDelq61CardCount84M', le.SBFEDelq61CardCount84M)),
				868 => ROW(createRecord('SBFEDelq61CardCountEver', le.SBFEDelq61CardCountEver)),
				869 => ROW(createRecord('SBFEDelq61LeaseCount', le.SBFEDelq61LeaseCount)),
				870 => ROW(createRecord('SBFEDelq61LeaseCount03M', le.SBFEDelq61LeaseCount03M)),
				871 => ROW(createRecord('SBFEDelq61LeaseCount06M', le.SBFEDelq61LeaseCount06M)),
				872 => ROW(createRecord('SBFEDelq61LeaseCount12M', le.SBFEDelq61LeaseCount12M)),
				873 => ROW(createRecord('SBFEDelq61LeaseCount24M', le.SBFEDelq61LeaseCount24M)),
				874 => ROW(createRecord('SBFEDelq61LeaseCount36M', le.SBFEDelq61LeaseCount36M)),
				875 => ROW(createRecord('SBFEDelq61LeaseCount60M', le.SBFEDelq61LeaseCount60M)),
				876 => ROW(createRecord('SBFEDelq61LeaseCount84M', le.SBFEDelq61LeaseCount84M)),
				877 => ROW(createRecord('SBFEDelq61LeaseCountEver', le.SBFEDelq61LeaseCountEver)),
				878 => ROW(createRecord('SBFEDelq61LetterCount', le.SBFEDelq61LetterCount)),
				879 => ROW(createRecord('SBFEDelq61LetterCount03M', le.SBFEDelq61LetterCount03M)),
				880 => ROW(createRecord('SBFEDelq61LetterCount06M', le.SBFEDelq61LetterCount06M)),
				881 => ROW(createRecord('SBFEDelq61LetterCount12M', le.SBFEDelq61LetterCount12M)),
				882 => ROW(createRecord('SBFEDelq61LetterCount24M', le.SBFEDelq61LetterCount24M)),
				883 => ROW(createRecord('SBFEDelq61LetterCount36M', le.SBFEDelq61LetterCount36M)),
				884 => ROW(createRecord('SBFEDelq61LetterCount60M', le.SBFEDelq61LetterCount60M)),
				885 => ROW(createRecord('SBFEDelq61LetterCount84M', le.SBFEDelq61LetterCount84M)),
				886 => ROW(createRecord('SBFEDelq61LetterCountEver', le.SBFEDelq61LetterCountEver)),
				887 => ROW(createRecord('SBFEDelq61OELineCount', le.SBFEDelq61OELineCount)),
				888 => ROW(createRecord('SBFEDelq61OELineCount03M', le.SBFEDelq61OELineCount03M)),
				889 => ROW(createRecord('SBFEDelq61OELineCount06M', le.SBFEDelq61OELineCount06M)),
				890 => ROW(createRecord('SBFEDelq61OELineCount12M', le.SBFEDelq61OELineCount12M)),
				891 => ROW(createRecord('SBFEDelq61OELineCount24M', le.SBFEDelq61OELineCount24M)),
				892 => ROW(createRecord('SBFEDelq61OELineCount36M', le.SBFEDelq61OELineCount36M)),
				893 => ROW(createRecord('SBFEDelq61OELineCount60M', le.SBFEDelq61OELineCount60M)),
				894 => ROW(createRecord('SBFEDelq61OELineCount84M', le.SBFEDelq61OELineCount84M)),
				895 => ROW(createRecord('SBFEDelq61OELineCountEver', le.SBFEDelq61OELineCountEver)),
				896 => ROW(createRecord('SBFEDelq61OtherCount', le.SBFEDelq61OtherCount)),
				897 => ROW(createRecord('SBFEDelq61OtherCount03M', le.SBFEDelq61OtherCount03M)),
				898 => ROW(createRecord('SBFEDelq61OtherCount06M', le.SBFEDelq61OtherCount06M)),
				899 => ROW(createRecord('SBFEDelq61OtherCount12M', le.SBFEDelq61OtherCount12M)),
				900 => ROW(createRecord('SBFEDelq61OtherCount24M', le.SBFEDelq61OtherCount24M)),
				901 => ROW(createRecord('SBFEDelq61OtherCount36M', le.SBFEDelq61OtherCount36M)),
				902 => ROW(createRecord('SBFEDelq61OtherCount60M', le.SBFEDelq61OtherCount60M)),
				903 => ROW(createRecord('SBFEDelq61OtherCount84M', le.SBFEDelq61OtherCount84M)),
				904 => ROW(createRecord('SBFEDelq61OtherCountEver', le.SBFEDelq61OtherCountEver)),
				905 => ROW(createRecord('SBFEDelq61InstCountTtl', le.SBFEDelq61InstCountTtl)),
				906 => ROW(createRecord('SBFEDelq61InstCountEver', le.SBFEDelq61InstCountEver)),
				907 => ROW(createRecord('SBFEDelq61InstCountTtlChargeoff', le.SBFEDelq61InstCountTtlChargeoff)),
				908 => ROW(createRecord('SBFEDelq61RevCountEverTtl', le.SBFEDelq61RevCountEverTtl)),
				909 => ROW(createRecord('SBFEDelq61RevCountEver', le.SBFEDelq61RevCountEver)),
				910 => ROW(createRecord('SBFEDelq61RevCountTtl', le.SBFEDelq61RevCountTtl)),
				911 => ROW(createRecord('SBFEDelq61RevCountTtlChargeoff', le.SBFEDelq61RevCountTtlChargeoff)),
				912 => ROW(createRecord('SBFEDelq91CountTtl', le.SBFEDelq91CountTtl)),
				913 => ROW(createRecord('SBFEDelq91CountTtlChargeoff', le.SBFEDelq91CountTtlChargeoff)),
				914 => ROW(createRecord('SBFEDelq91Count', le.SBFEDelq91Count)),
				915 => ROW(createRecord('SBFEDelq91Count03M', le.SBFEDelq91Count03M)),
				916 => ROW(createRecord('SBFEDelq91Count06M', le.SBFEDelq91Count06M)),
				917 => ROW(createRecord('SBFEDelq91Count12M', le.SBFEDelq91Count12M)),
				918 => ROW(createRecord('SBFEDelq91Count24M', le.SBFEDelq91Count24M)),
				919 => ROW(createRecord('SBFEDelq91Count36M', le.SBFEDelq91Count36M)),
				920 => ROW(createRecord('SBFEDelq91Count60M', le.SBFEDelq91Count60M)),
				921 => ROW(createRecord('SBFEDelq91Count84M', le.SBFEDelq91Count84M)),
				922 => ROW(createRecord('SBFEDelq91CountEver', le.SBFEDelq91CountEver)),
				923 => ROW(createRecord('SBFEDelq91LoanCount', le.SBFEDelq91LoanCount)),
				924 => ROW(createRecord('SBFEDelq91LoanCount03M', le.SBFEDelq91LoanCount03M)),
				925 => ROW(createRecord('SBFEDelq91LoanCount06M', le.SBFEDelq91LoanCount06M)),
				926 => ROW(createRecord('SBFEDelq91LoanCount12M', le.SBFEDelq91LoanCount12M)),
				927 => ROW(createRecord('SBFEDelq91LoanCount24M', le.SBFEDelq91LoanCount24M)),
				928 => ROW(createRecord('SBFEDelq91LoanCount36M', le.SBFEDelq91LoanCount36M)),
				929 => ROW(createRecord('SBFEDelq91LoanCount60M', le.SBFEDelq91LoanCount60M)),
				930 => ROW(createRecord('SBFEDelq91LoanCount84M', le.SBFEDelq91LoanCount84M)),
				931 => ROW(createRecord('SBFEDelq91LoanCountEver', le.SBFEDelq91LoanCountEver)),
				932 => ROW(createRecord('SBFEDelq91LineCount', le.SBFEDelq91LineCount)),
				933 => ROW(createRecord('SBFEDelq91LineCount03M', le.SBFEDelq91LineCount03M)),
				934 => ROW(createRecord('SBFEDelq91LineCount06M', le.SBFEDelq91LineCount06M)),
				935 => ROW(createRecord('SBFEDelq91LineCount12M', le.SBFEDelq91LineCount12M)),
				936 => ROW(createRecord('SBFEDelq91LineCount24M', le.SBFEDelq91LineCount24M)),
				937 => ROW(createRecord('SBFEDelq91LineCount36M', le.SBFEDelq91LineCount36M)),
				938 => ROW(createRecord('SBFEDelq91LineCount60M', le.SBFEDelq91LineCount60M)),
				939 => ROW(createRecord('SBFEDelq91LineCount84M', le.SBFEDelq91LineCount84M)),
				940 => ROW(createRecord('SBFEDelq91LineCountEver', le.SBFEDelq91LineCountEver)),
				941 => ROW(createRecord('SBFEDelq91CardCount', le.SBFEDelq91CardCount)),
				942 => ROW(createRecord('SBFEDelq91CardCount03M', le.SBFEDelq91CardCount03M)),
				943 => ROW(createRecord('SBFEDelq91CardCount06M', le.SBFEDelq91CardCount06M)),
				944 => ROW(createRecord('SBFEDelq91CardCount12M', le.SBFEDelq91CardCount12M)),
				945 => ROW(createRecord('SBFEDelq91CardCount24M', le.SBFEDelq91CardCount24M)),
				946 => ROW(createRecord('SBFEDelq91CardCount36M', le.SBFEDelq91CardCount36M)),
				947 => ROW(createRecord('SBFEDelq91CardCount60M', le.SBFEDelq91CardCount60M)),
				948 => ROW(createRecord('SBFEDelq91CardCount84M', le.SBFEDelq91CardCount84M)),
				949 => ROW(createRecord('SBFEDelq91CardCountEver', le.SBFEDelq91CardCountEver)),
				950 => ROW(createRecord('SBFEDelq91LeaseCount', le.SBFEDelq91LeaseCount)),
				951 => ROW(createRecord('SBFEDelq91LeaseCount03M', le.SBFEDelq91LeaseCount03M)),
				952 => ROW(createRecord('SBFEDelq91LeaseCount06M', le.SBFEDelq91LeaseCount06M)),
				953 => ROW(createRecord('SBFEDelq91LeaseCount12M', le.SBFEDelq91LeaseCount12M)),
				954 => ROW(createRecord('SBFEDelq91LeaseCount24M', le.SBFEDelq91LeaseCount24M)),
				955 => ROW(createRecord('SBFEDelq91LeaseCount36M', le.SBFEDelq91LeaseCount36M)),
				956 => ROW(createRecord('SBFEDelq91LeaseCount60M', le.SBFEDelq91LeaseCount60M)),
				957 => ROW(createRecord('SBFEDelq91LeaseCount84M', le.SBFEDelq91LeaseCount84M)),
				958 => ROW(createRecord('SBFEDelq91LeaseCountEver', le.SBFEDelq91LeaseCountEver)),
				959 => ROW(createRecord('SBFEDelq91LetterCount', le.SBFEDelq91LetterCount)),
				960 => ROW(createRecord('SBFEDelq91LetterCount03M', le.SBFEDelq91LetterCount03M)),
				961 => ROW(createRecord('SBFEDelq91LetterCount06M', le.SBFEDelq91LetterCount06M)),
				962 => ROW(createRecord('SBFEDelq91LetterCount12M', le.SBFEDelq91LetterCount12M)),
				963 => ROW(createRecord('SBFEDelq91LetterCount24M', le.SBFEDelq91LetterCount24M)),
				964 => ROW(createRecord('SBFEDelq91LetterCount36M', le.SBFEDelq91LetterCount36M)),
				965 => ROW(createRecord('SBFEDelq91LetterCount60M', le.SBFEDelq91LetterCount60M)),
				966 => ROW(createRecord('SBFEDelq91LetterCount84M', le.SBFEDelq91LetterCount84M)),
				967 => ROW(createRecord('SBFEDelq91LetterCountEver', le.SBFEDelq91LetterCountEver)),
				968 => ROW(createRecord('SBFEDelq91OELineCount', le.SBFEDelq91OELineCount)),
				969 => ROW(createRecord('SBFEDelq91OELineCount03M', le.SBFEDelq91OELineCount03M)),
				970 => ROW(createRecord('SBFEDelq91OELineCount06M', le.SBFEDelq91OELineCount06M)),
				971 => ROW(createRecord('SBFEDelq91OELineCount12M', le.SBFEDelq91OELineCount12M)),
				972 => ROW(createRecord('SBFEDelq91OELineCount24M', le.SBFEDelq91OELineCount24M)),
				973 => ROW(createRecord('SBFEDelq91OELineCount36M', le.SBFEDelq91OELineCount36M)),
				974 => ROW(createRecord('SBFEDelq91OELineCount60M', le.SBFEDelq91OELineCount60M)),
				975 => ROW(createRecord('SBFEDelq91OELineCount84M', le.SBFEDelq91OELineCount84M)),
				976 => ROW(createRecord('SBFEDelq91OELineCountEver', le.SBFEDelq91OELineCountEver)),
				977 => ROW(createRecord('SBFEDelq91OtherCount', le.SBFEDelq91OtherCount)),
				978 => ROW(createRecord('SBFEDelq91OtherCount03M', le.SBFEDelq91OtherCount03M)),
				979 => ROW(createRecord('SBFEDelq91OtherCount06M', le.SBFEDelq91OtherCount06M)),
				980 => ROW(createRecord('SBFEDelq91OtherCount12M', le.SBFEDelq91OtherCount12M)),
				981 => ROW(createRecord('SBFEDelq91OtherCount24M', le.SBFEDelq91OtherCount24M)),
				982 => ROW(createRecord('SBFEDelq91OtherCount36M', le.SBFEDelq91OtherCount36M)),
				983 => ROW(createRecord('SBFEDelq91OtherCount60M', le.SBFEDelq91OtherCount60M)),
				984 => ROW(createRecord('SBFEDelq91OtherCount84M', le.SBFEDelq91OtherCount84M)),
				985 => ROW(createRecord('SBFEDelq91OtherCountEver', le.SBFEDelq91OtherCountEver)),
				986 => ROW(createRecord('SBFEDelq91InstCountTtl', le.SBFEDelq91InstCountTtl)),
				987 => ROW(createRecord('SBFEDelq91InstCountEver', le.SBFEDelq91InstCountEver)),
				988 => ROW(createRecord('SBFEDelq91InstCountTtlChargeoff', le.SBFEDelq91InstCountTtlChargeoff)),
				989 => ROW(createRecord('SBFEDelq91RevCountEverTtl', le.SBFEDelq91RevCountEverTtl)),
				990 => ROW(createRecord('SBFEDelq91RevCountEver', le.SBFEDelq91RevCountEver)),
				991 => ROW(createRecord('SBFEDelq91RevCountTtl', le.SBFEDelq91RevCountTtl)),
				992 => ROW(createRecord('SBFEDelq91RevCountTtlChargeoff', le.SBFEDelq91RevCountTtlChargeoff)),
				993 => ROW(createRecord('SBFEDelq121CountTtlChargeoff', le.SBFEDelq121CountTtlChargeoff)),
				994 => ROW(createRecord('SBFEDelq121Count', le.SBFEDelq121Count)),
				995 => ROW(createRecord('SBFEDelq121Count03M', le.SBFEDelq121Count03M)),
				996 => ROW(createRecord('SBFEDelq121Count06M', le.SBFEDelq121Count06M)),
				997 => ROW(createRecord('SBFEDelq121Count12M', le.SBFEDelq121Count12M)),
				998 => ROW(createRecord('SBFEDelq121Count24M', le.SBFEDelq121Count24M)),
				999 => ROW(createRecord('SBFEDelq121Count36M', le.SBFEDelq121Count36M)),
				1000 => ROW(createRecord('SBFEDelq121Count60M', le.SBFEDelq121Count60M)),
				1001 => ROW(createRecord('SBFEDelq121Count84M', le.SBFEDelq121Count84M)),
				1002 => ROW(createRecord('SBFEDelq121CountEver', le.SBFEDelq121CountEver)),
				1003 => ROW(createRecord('SBFEDelq121LoanCount', le.SBFEDelq121LoanCount)),
				1004 => ROW(createRecord('SBFEDelq121LoanCount03M', le.SBFEDelq121LoanCount03M)),
				1005 => ROW(createRecord('SBFEDelq121LoanCount06M', le.SBFEDelq121LoanCount06M)),
				1006 => ROW(createRecord('SBFEDelq121LoanCount12M', le.SBFEDelq121LoanCount12M)),
				1007 => ROW(createRecord('SBFEDelq121LoanCount24M', le.SBFEDelq121LoanCount24M)),
				1008 => ROW(createRecord('SBFEDelq121LoanCount36M', le.SBFEDelq121LoanCount36M)),
				1009 => ROW(createRecord('SBFEDelq121LoanCount60M', le.SBFEDelq121LoanCount60M)),
				1010 => ROW(createRecord('SBFEDelq121LoanCount84M', le.SBFEDelq121LoanCount84M)),
				1011 => ROW(createRecord('SBFEDelq121LoanCountEver', le.SBFEDelq121LoanCountEver)),
				1012 => ROW(createRecord('SBFEDelq121LineCount', le.SBFEDelq121LineCount)),
				1013 => ROW(createRecord('SBFEDelq121LineCount03M', le.SBFEDelq121LineCount03M)),
				1014 => ROW(createRecord('SBFEDelq121LineCount06M', le.SBFEDelq121LineCount06M)),
				1015 => ROW(createRecord('SBFEDelq121LineCount12M', le.SBFEDelq121LineCount12M)),
				1016 => ROW(createRecord('SBFEDelq121LineCount24M', le.SBFEDelq121LineCount24M)),
				1017 => ROW(createRecord('SBFEDelq121LineCount36M', le.SBFEDelq121LineCount36M)),
				1018 => ROW(createRecord('SBFEDelq121LineCount60M', le.SBFEDelq121LineCount60M)),
				1019 => ROW(createRecord('SBFEDelq121LineCount84M', le.SBFEDelq121LineCount84M)),
				1020 => ROW(createRecord('SBFEDelq121LineCountEver', le.SBFEDelq121LineCountEver)),
				1021 => ROW(createRecord('SBFEDelq121CardCount', le.SBFEDelq121CardCount)),
				1022 => ROW(createRecord('SBFEDelq121CardCount03M', le.SBFEDelq121CardCount03M)),
				1023 => ROW(createRecord('SBFEDelq121CardCount06M', le.SBFEDelq121CardCount06M)),
				1024 => ROW(createRecord('SBFEDelq121CardCount12M', le.SBFEDelq121CardCount12M)),
				1025 => ROW(createRecord('SBFEDelq121CardCount24M', le.SBFEDelq121CardCount24M)),
				1026 => ROW(createRecord('SBFEDelq121CardCount36M', le.SBFEDelq121CardCount36M)),
				1027 => ROW(createRecord('SBFEDelq121CardCount60M', le.SBFEDelq121CardCount60M)),
				1028 => ROW(createRecord('SBFEDelq121CardCount84M', le.SBFEDelq121CardCount84M)),
				1029 => ROW(createRecord('SBFEDelq121CardCountEver', le.SBFEDelq121CardCountEver)),
				1030 => ROW(createRecord('SBFEDelq121LeaseCount', le.SBFEDelq121LeaseCount)),
				1031 => ROW(createRecord('SBFEDelq121LeaseCount03M', le.SBFEDelq121LeaseCount03M)),
				1032 => ROW(createRecord('SBFEDelq121LeaseCount06M', le.SBFEDelq121LeaseCount06M)),
				1033 => ROW(createRecord('SBFEDelq121LeaseCount12M', le.SBFEDelq121LeaseCount12M)),
				1034 => ROW(createRecord('SBFEDelq121LeaseCount24M', le.SBFEDelq121LeaseCount24M)),
				1035 => ROW(createRecord('SBFEDelq121LeaseCount36M', le.SBFEDelq121LeaseCount36M)),
				1036 => ROW(createRecord('SBFEDelq121LeaseCount60M', le.SBFEDelq121LeaseCount60M)),
				1037 => ROW(createRecord('SBFEDelq121LeaseCount84M', le.SBFEDelq121LeaseCount84M)),
				1038 => ROW(createRecord('SBFEDelq121LeaseCountEver', le.SBFEDelq121LeaseCountEver)),
				1039 => ROW(createRecord('SBFEDelq121LetterCount', le.SBFEDelq121LetterCount)),
				1040 => ROW(createRecord('SBFEDelq121LetterCount03M', le.SBFEDelq121LetterCount03M)),
				1041 => ROW(createRecord('SBFEDelq121LetterCount06M', le.SBFEDelq121LetterCount06M)),
				1042 => ROW(createRecord('SBFEDelq121LetterCount12M', le.SBFEDelq121LetterCount12M)),
				1043 => ROW(createRecord('SBFEDelq121LetterCount24M', le.SBFEDelq121LetterCount24M)),
				1044 => ROW(createRecord('SBFEDelq121LetterCount36M', le.SBFEDelq121LetterCount36M)),
				1045 => ROW(createRecord('SBFEDelq121LetterCount60M', le.SBFEDelq121LetterCount60M)),
				1046 => ROW(createRecord('SBFEDelq121LetterCount84M', le.SBFEDelq121LetterCount84M)),
				1047 => ROW(createRecord('SBFEDelq121LetterCountEver', le.SBFEDelq121LetterCountEver)),
				1048 => ROW(createRecord('SBFEDelq121OELineCount', le.SBFEDelq121OELineCount)),
				1049 => ROW(createRecord('SBFEDelq121OELineCount03M', le.SBFEDelq121OELineCount03M)),
				1050 => ROW(createRecord('SBFEDelq121OELineCount06M', le.SBFEDelq121OELineCount06M)),
				1051 => ROW(createRecord('SBFEDelq121OELineCount12M', le.SBFEDelq121OELineCount12M)),
				1052 => ROW(createRecord('SBFEDelq121OELineCount24M', le.SBFEDelq121OELineCount24M)),
				1053 => ROW(createRecord('SBFEDelq121OELineCount36M', le.SBFEDelq121OELineCount36M)),
				1054 => ROW(createRecord('SBFEDelq121OELineCount60M', le.SBFEDelq121OELineCount60M)),
				1055 => ROW(createRecord('SBFEDelq121OELineCount84M', le.SBFEDelq121OELineCount84M)),
				1056 => ROW(createRecord('SBFEDelq121OELineCountEver', le.SBFEDelq121OELineCountEver)),
				1057 => ROW(createRecord('SBFEDelq121OtherCount', le.SBFEDelq121OtherCount)),
				1058 => ROW(createRecord('SBFEDelq121OtherCount03M', le.SBFEDelq121OtherCount03M)),
				1059 => ROW(createRecord('SBFEDelq121OtherCount06M', le.SBFEDelq121OtherCount06M)),
				1060 => ROW(createRecord('SBFEDelq121OtherCount12M', le.SBFEDelq121OtherCount12M)),
				1061 => ROW(createRecord('SBFEDelq121OtherCount24M', le.SBFEDelq121OtherCount24M)),
				1062 => ROW(createRecord('SBFEDelq121OtherCount36M', le.SBFEDelq121OtherCount36M)),
				1063 => ROW(createRecord('SBFEDelq121OtherCount60M', le.SBFEDelq121OtherCount60M)),
				1064 => ROW(createRecord('SBFEDelq121OtherCount84M', le.SBFEDelq121OtherCount84M)),
				1065 => ROW(createRecord('SBFEDelq121OtherCountEver', le.SBFEDelq121OtherCountEver)),
				1066 => ROW(createRecord('SBFEDelq121InstCountEver', le.SBFEDelq121InstCountEver)),
				1067 => ROW(createRecord('SBFEDelq121InstCountTtlChargeoff', le.SBFEDelq121InstCountTtlChargeoff)),
				1068 => ROW(createRecord('SBFEDelq121RevCountEver', le.SBFEDelq121RevCountEver)),
				1069 => ROW(createRecord('SBFEDelq121RevCountTtlChargeoff', le.SBFEDelq121RevCountTtlChargeoff)),
				1070 => ROW(createRecord('SBFEDelq31Ratio', le.SBFEDelq31Ratio)),
				1071 => ROW(createRecord('SBFEDelq31LoanRatio', le.SBFEDelq31LoanRatio)),
				1072 => ROW(createRecord('SBFEDelq31LineRatio', le.SBFEDelq31LineRatio)),
				1073 => ROW(createRecord('SBFEDelq31CardRatio', le.SBFEDelq31CardRatio)),
				1074 => ROW(createRecord('SBFEDelq31LeaseRatio', le.SBFEDelq31LeaseRatio)),
				1075 => ROW(createRecord('SBFEDelq31LetterRatio', le.SBFEDelq31LetterRatio)),
				1076 => ROW(createRecord('SBFEDelq31OELineRatio', le.SBFEDelq31OELineRatio)),
				1077 => ROW(createRecord('SBFEDelq31OtherRatio', le.SBFEDelq31OtherRatio)),
				1078 => ROW(createRecord('SBFEDelq61Ratio', le.SBFEDelq61Ratio)),
				1079 => ROW(createRecord('SBFEDelq61LoanRatio', le.SBFEDelq61LoanRatio)),
				1080 => ROW(createRecord('SBFEDelq61LineRatio', le.SBFEDelq61LineRatio)),
				1081 => ROW(createRecord('SBFEDelq61CardRatio', le.SBFEDelq61CardRatio)),
				1082 => ROW(createRecord('SBFEDelq61LeaseRatio', le.SBFEDelq61LeaseRatio)),
				1083 => ROW(createRecord('SBFEDelq61LetterRatio', le.SBFEDelq61LetterRatio)),
				1084 => ROW(createRecord('SBFEDelq61OELineRatio', le.SBFEDelq61OELineRatio)),
				1085 => ROW(createRecord('SBFEDelq61OtherRatio', le.SBFEDelq61OtherRatio)),
				1086 => ROW(createRecord('SBFEDelq91Ratio', le.SBFEDelq91Ratio)),
				1087 => ROW(createRecord('SBFEDelq91LoanRatio', le.SBFEDelq91LoanRatio)),
				1088 => ROW(createRecord('SBFEDelq91LineRatio', le.SBFEDelq91LineRatio)),
				1089 => ROW(createRecord('SBFEDelq91CardRatio', le.SBFEDelq91CardRatio)),
				1090 => ROW(createRecord('SBFEDelq91LeaseRatio', le.SBFEDelq91LeaseRatio)),
				1091 => ROW(createRecord('SBFEDelq91LetterRatio', le.SBFEDelq91LetterRatio)),
				1092 => ROW(createRecord('SBFEDelq91OELineRatio', le.SBFEDelq91OELineRatio)),
				1093 => ROW(createRecord('SBFEDelq91OtherRatio', le.SBFEDelq91OtherRatio)),
				1094 => ROW(createRecord('SBFEDelq121Ratio', le.SBFEDelq121Ratio)),
				1095 => ROW(createRecord('SBFEDelq121LoanRatio', le.SBFEDelq121LoanRatio)),
				1096 => ROW(createRecord('SBFEDelq121LineRatio', le.SBFEDelq121LineRatio)),
				1097 => ROW(createRecord('SBFEDelq121CardRatio', le.SBFEDelq121CardRatio)),
				1098 => ROW(createRecord('SBFEDelq121LeaseRatio', le.SBFEDelq121LeaseRatio)),
				1099 => ROW(createRecord('SBFEDelq121LetterRatio', le.SBFEDelq121LetterRatio)),
				1100 => ROW(createRecord('SBFEDelq121OELineRatio', le.SBFEDelq121OELineRatio)),
				1101 => ROW(createRecord('SBFEDelq121OtherRatio', le.SBFEDelq121OtherRatio)),
				1102 => ROW(createRecord('SBFEDelq1OccurCount03M', le.SBFEDelq1OccurCount03M)),
				1103 => ROW(createRecord('SBFEDelq1OccurCount06M', le.SBFEDelq1OccurCount06M)),
				1104 => ROW(createRecord('SBFEDelq1OccurCount12M', le.SBFEDelq1OccurCount12M)),
				1105 => ROW(createRecord('SBFEDelq1OccurCount24M', le.SBFEDelq1OccurCount24M)),
				1106 => ROW(createRecord('SBFEDelq1OccurCount36M', le.SBFEDelq1OccurCount36M)),
				1107 => ROW(createRecord('SBFEDelq1OccurCount60M', le.SBFEDelq1OccurCount60M)),
				1108 => ROW(createRecord('SBFEDelq1OccurCount84M', le.SBFEDelq1OccurCount84M)),
				1109 => ROW(createRecord('SBFEDelq1OccurCountEver', le.SBFEDelq1OccurCountEver)),
				1110 => ROW(createRecord('SBFEDelq31OccurCount03M', le.SBFEDelq31OccurCount03M)),
				1111 => ROW(createRecord('SBFEDelq31OccurCount06M', le.SBFEDelq31OccurCount06M)),
				1112 => ROW(createRecord('SBFEDelq31OccurCount12M', le.SBFEDelq31OccurCount12M)),
				1113 => ROW(createRecord('SBFEDelq31OccurCount24M', le.SBFEDelq31OccurCount24M)),
				1114 => ROW(createRecord('SBFEDelq31OccurCount36M', le.SBFEDelq31OccurCount36M)),
				1115 => ROW(createRecord('SBFEDelq31OccurCount60M', le.SBFEDelq31OccurCount60M)),
				1116 => ROW(createRecord('SBFEDelq31OccurCount84M', le.SBFEDelq31OccurCount84M)),
				1117 => ROW(createRecord('SBFEDelq31OccurCountEver', le.SBFEDelq31OccurCountEver)),
				1118 => ROW(createRecord('SBFEDelq31OccurLoanCount03M', le.SBFEDelq31OccurLoanCount03M)),
				1119 => ROW(createRecord('SBFEDelq31OccurLoanCount06M', le.SBFEDelq31OccurLoanCount06M)),
				1120 => ROW(createRecord('SBFEDelq31OccurLoanCount12M', le.SBFEDelq31OccurLoanCount12M)),
				1121 => ROW(createRecord('SBFEDelq31OccurLoanCount24M', le.SBFEDelq31OccurLoanCount24M)),
				1122 => ROW(createRecord('SBFEDelq31OccurLoanCount36M', le.SBFEDelq31OccurLoanCount36M)),
				1123 => ROW(createRecord('SBFEDelq31OccurLoanCount60M', le.SBFEDelq31OccurLoanCount60M)),
				1124 => ROW(createRecord('SBFEDelq31OccurLoanCount84M', le.SBFEDelq31OccurLoanCount84M)),
				1125 => ROW(createRecord('SBFEDelq31OccurLoanCountEver', le.SBFEDelq31OccurLoanCountEver)),
				1126 => ROW(createRecord('SBFEDelq31OccurLineCount03M', le.SBFEDelq31OccurLineCount03M)),
				1127 => ROW(createRecord('SBFEDelq31OccurLineCount06M', le.SBFEDelq31OccurLineCount06M)),
				1128 => ROW(createRecord('SBFEDelq31OccurLineCount12M', le.SBFEDelq31OccurLineCount12M)),
				1129 => ROW(createRecord('SBFEDelq31OccurLineCount24M', le.SBFEDelq31OccurLineCount24M)),
				1130 => ROW(createRecord('SBFEDelq31OccurLineCount36M', le.SBFEDelq31OccurLineCount36M)),
				1131 => ROW(createRecord('SBFEDelq31OccurLineCount60M', le.SBFEDelq31OccurLineCount60M)),
				1132 => ROW(createRecord('SBFEDelq31OccurLineCount84M', le.SBFEDelq31OccurLineCount84M)),
				1133 => ROW(createRecord('SBFEDelq31OccurLineCountEver', le.SBFEDelq31OccurLineCountEver)),
				1134 => ROW(createRecord('SBFEDelq31OccurCardCount03M', le.SBFEDelq31OccurCardCount03M)),
				1135 => ROW(createRecord('SBFEDelq31OccurCardCount06M', le.SBFEDelq31OccurCardCount06M)),
				1136 => ROW(createRecord('SBFEDelq31OccurCardCount12M', le.SBFEDelq31OccurCardCount12M)),
				1137 => ROW(createRecord('SBFEDelq31OccurCardCount24M', le.SBFEDelq31OccurCardCount24M)),
				1138 => ROW(createRecord('SBFEDelq31OccurCardCount36M', le.SBFEDelq31OccurCardCount36M)),
				1139 => ROW(createRecord('SBFEDelq31OccurCardCount60M', le.SBFEDelq31OccurCardCount60M)),
				1140 => ROW(createRecord('SBFEDelq31OccurCardCount84M', le.SBFEDelq31OccurCardCount84M)),
				1141 => ROW(createRecord('SBFEDelq31OccurCardCountEver', le.SBFEDelq31OccurCardCountEver)),
				1142 => ROW(createRecord('SBFEDelq31OccurLeaseCount03M', le.SBFEDelq31OccurLeaseCount03M)),
				1143 => ROW(createRecord('SBFEDelq31OccurLeaseCount06M', le.SBFEDelq31OccurLeaseCount06M)),
				1144 => ROW(createRecord('SBFEDelq31OccurLeaseCount12M', le.SBFEDelq31OccurLeaseCount12M)),
				1145 => ROW(createRecord('SBFEDelq31OccurLeaseCount24M', le.SBFEDelq31OccurLeaseCount24M)),
				1146 => ROW(createRecord('SBFEDelq31OccurLeaseCount36M', le.SBFEDelq31OccurLeaseCount36M)),
				1147 => ROW(createRecord('SBFEDelq31OccurLeaseCount60M', le.SBFEDelq31OccurLeaseCount60M)),
				1148 => ROW(createRecord('SBFEDelq31OccurLeaseCount84M', le.SBFEDelq31OccurLeaseCount84M)),
				1149 => ROW(createRecord('SBFEDelq31OccurLeaseCountEver', le.SBFEDelq31OccurLeaseCountEver)),
				1150 => ROW(createRecord('SBFEDelq31OccurLetterCount03M', le.SBFEDelq31OccurLetterCount03M)),
				1151 => ROW(createRecord('SBFEDelq31OccurLetterCount06M', le.SBFEDelq31OccurLetterCount06M)),
				1152 => ROW(createRecord('SBFEDelq31OccurLetterCount12M', le.SBFEDelq31OccurLetterCount12M)),
				1153 => ROW(createRecord('SBFEDelq31OccurLetterCount24M', le.SBFEDelq31OccurLetterCount24M)),
				1154 => ROW(createRecord('SBFEDelq31OccurLetterCount36M', le.SBFEDelq31OccurLetterCount36M)),
				1155 => ROW(createRecord('SBFEDelq31OccurLetterCount60M', le.SBFEDelq31OccurLetterCount60M)),
				1156 => ROW(createRecord('SBFEDelq31OccurLetterCount84M', le.SBFEDelq31OccurLetterCount84M)),
				1157 => ROW(createRecord('SBFEDelq31OccurLetterCountEver', le.SBFEDelq31OccurLetterCountEver)),
				1158 => ROW(createRecord('SBFEDelq31OccurOELineCount03M', le.SBFEDelq31OccurOELineCount03M)),
				1159 => ROW(createRecord('SBFEDelq31OccurOELineCount06M', le.SBFEDelq31OccurOELineCount06M)),
				1160 => ROW(createRecord('SBFEDelq31OccurOELineCount12M', le.SBFEDelq31OccurOELineCount12M)),
				1161 => ROW(createRecord('SBFEDelq31OccurOELineCount24M', le.SBFEDelq31OccurOELineCount24M)),
				1162 => ROW(createRecord('SBFEDelq31OccurOELineCount36M', le.SBFEDelq31OccurOELineCount36M)),
				1163 => ROW(createRecord('SBFEDelq31OccurOELineCount60M', le.SBFEDelq31OccurOELineCount60M)),
				1164 => ROW(createRecord('SBFEDelq31OccurOELineCount84M', le.SBFEDelq31OccurOELineCount84M)),
				1165 => ROW(createRecord('SBFEDelq31OccurOELineCountEver', le.SBFEDelq31OccurOELineCountEver)),
				1166 => ROW(createRecord('SBFEDelq31OccurOtherCount03M', le.SBFEDelq31OccurOtherCount03M)),
				1167 => ROW(createRecord('SBFEDelq31OccurOtherCount06M', le.SBFEDelq31OccurOtherCount06M)),
				1168 => ROW(createRecord('SBFEDelq31OccurOtherCount12M', le.SBFEDelq31OccurOtherCount12M)),
				1169 => ROW(createRecord('SBFEDelq31OccurOtherCount24M', le.SBFEDelq31OccurOtherCount24M)),
				1170 => ROW(createRecord('SBFEDelq31OccurOtherCount36M', le.SBFEDelq31OccurOtherCount36M)),
				1171 => ROW(createRecord('SBFEDelq31OccurOtherCount60M', le.SBFEDelq31OccurOtherCount60M)),
				1172 => ROW(createRecord('SBFEDelq31OccurOtherCount84M', le.SBFEDelq31OccurOtherCount84M)),
				1173 => ROW(createRecord('SBFEDelq31OccurOtherCountEver', le.SBFEDelq31OccurOtherCountEver)),
				1174 => ROW(createRecord('SBFEDelq61OccurCount03M', le.SBFEDelq61OccurCount03M)),
				1175 => ROW(createRecord('SBFEDelq61OccurCount06M', le.SBFEDelq61OccurCount06M)),
				1176 => ROW(createRecord('SBFEDelq61OccurCount12M', le.SBFEDelq61OccurCount12M)),
				1177 => ROW(createRecord('SBFEDelq61OccurCount24M', le.SBFEDelq61OccurCount24M)),
				1178 => ROW(createRecord('SBFEDelq61OccurCount36M', le.SBFEDelq61OccurCount36M)),
				1179 => ROW(createRecord('SBFEDelq61OccurCount60M', le.SBFEDelq61OccurCount60M)),
				1180 => ROW(createRecord('SBFEDelq61OccurCount84M', le.SBFEDelq61OccurCount84M)),
				1181 => ROW(createRecord('SBFEDelq61OccurCountEver', le.SBFEDelq61OccurCountEver)),
				1182 => ROW(createRecord('SBFEDelq61OccurLoanCount03M', le.SBFEDelq61OccurLoanCount03M)),
				1183 => ROW(createRecord('SBFEDelq61OccurLoanCount06M', le.SBFEDelq61OccurLoanCount06M)),
				1184 => ROW(createRecord('SBFEDelq61OccurLoanCount12M', le.SBFEDelq61OccurLoanCount12M)),
				1185 => ROW(createRecord('SBFEDelq61OccurLoanCount24M', le.SBFEDelq61OccurLoanCount24M)),
				1186 => ROW(createRecord('SBFEDelq61OccurLoanCount36M', le.SBFEDelq61OccurLoanCount36M)),
				1187 => ROW(createRecord('SBFEDelq61OccurLoanCount60M', le.SBFEDelq61OccurLoanCount60M)),
				1188 => ROW(createRecord('SBFEDelq61OccurLoanCount84M', le.SBFEDelq61OccurLoanCount84M)),
				1189 => ROW(createRecord('SBFEDelq61OccurLoanCountEver', le.SBFEDelq61OccurLoanCountEver)),
				1190 => ROW(createRecord('SBFEDelq61OccurLineCount03M', le.SBFEDelq61OccurLineCount03M)),
				1191 => ROW(createRecord('SBFEDelq61OccurLineCount06M', le.SBFEDelq61OccurLineCount06M)),
				1192 => ROW(createRecord('SBFEDelq61OccurLineCount12M', le.SBFEDelq61OccurLineCount12M)),
				1193 => ROW(createRecord('SBFEDelq61OccurLineCount24M', le.SBFEDelq61OccurLineCount24M)),
				1194 => ROW(createRecord('SBFEDelq61OccurLineCount36M', le.SBFEDelq61OccurLineCount36M)),
				1195 => ROW(createRecord('SBFEDelq61OccurLineCount60M', le.SBFEDelq61OccurLineCount60M)),
				1196 => ROW(createRecord('SBFEDelq61OccurLineCount84M', le.SBFEDelq61OccurLineCount84M)),
				1197 => ROW(createRecord('SBFEDelq61OccurLineCountEver', le.SBFEDelq61OccurLineCountEver)),
				1198 => ROW(createRecord('SBFEDelq61OccurCardCount03M', le.SBFEDelq61OccurCardCount03M)),
				1199 => ROW(createRecord('SBFEDelq61OccurCardCount06M', le.SBFEDelq61OccurCardCount06M)),
				1200 => ROW(createRecord('SBFEDelq61OccurCardCount12M', le.SBFEDelq61OccurCardCount12M)),
				1201 => ROW(createRecord('SBFEDelq61OccurCardCount24M', le.SBFEDelq61OccurCardCount24M)),
				1202 => ROW(createRecord('SBFEDelq61OccurCardCount36M', le.SBFEDelq61OccurCardCount36M)),
				1203 => ROW(createRecord('SBFEDelq61OccurCardCount60M', le.SBFEDelq61OccurCardCount60M)),
				1204 => ROW(createRecord('SBFEDelq61OccurCardCount84M', le.SBFEDelq61OccurCardCount84M)),
				1205 => ROW(createRecord('SBFEDelq61OccurCardCountEver', le.SBFEDelq61OccurCardCountEver)),
				1206 => ROW(createRecord('SBFEDelq61OccurLeaseCount03M', le.SBFEDelq61OccurLeaseCount03M)),
				1207 => ROW(createRecord('SBFEDelq61OccurLeaseCount06M', le.SBFEDelq61OccurLeaseCount06M)),
				1208 => ROW(createRecord('SBFEDelq61OccurLeaseCount12M', le.SBFEDelq61OccurLeaseCount12M)),
				1209 => ROW(createRecord('SBFEDelq61OccurLeaseCount24M', le.SBFEDelq61OccurLeaseCount24M)),
				1210 => ROW(createRecord('SBFEDelq61OccurLeaseCount36M', le.SBFEDelq61OccurLeaseCount36M)),
				1211 => ROW(createRecord('SBFEDelq61OccurLeaseCount60M', le.SBFEDelq61OccurLeaseCount60M)),
				1212 => ROW(createRecord('SBFEDelq61OccurLeaseCount84M', le.SBFEDelq61OccurLeaseCount84M)),
				1213 => ROW(createRecord('SBFEDelq61OccurLeaseCountEver', le.SBFEDelq61OccurLeaseCountEver)),
				1214 => ROW(createRecord('SBFEDelq61OccurLetterCount03M', le.SBFEDelq61OccurLetterCount03M)),
				1215 => ROW(createRecord('SBFEDelq61OccurLetterCount06M', le.SBFEDelq61OccurLetterCount06M)),
				1216 => ROW(createRecord('SBFEDelq61OccurLetterCount12M', le.SBFEDelq61OccurLetterCount12M)),
				1217 => ROW(createRecord('SBFEDelq61OccurLetterCount24M', le.SBFEDelq61OccurLetterCount24M)),
				1218 => ROW(createRecord('SBFEDelq61OccurLetterCount36M', le.SBFEDelq61OccurLetterCount36M)),
				1219 => ROW(createRecord('SBFEDelq61OccurLetterCount60M', le.SBFEDelq61OccurLetterCount60M)),
				1220 => ROW(createRecord('SBFEDelq61OccurLetterCount84M', le.SBFEDelq61OccurLetterCount84M)),
				1221 => ROW(createRecord('SBFEDelq61OccurLetterCountEver', le.SBFEDelq61OccurLetterCountEver)),
				1222 => ROW(createRecord('SBFEDelq61OccurOELineCount03M', le.SBFEDelq61OccurOELineCount03M)),
				1223 => ROW(createRecord('SBFEDelq61OccurOELineCount06M', le.SBFEDelq61OccurOELineCount06M)),
				1224 => ROW(createRecord('SBFEDelq61OccurOELineCount12M', le.SBFEDelq61OccurOELineCount12M)),
				1225 => ROW(createRecord('SBFEDelq61OccurOELineCount24M', le.SBFEDelq61OccurOELineCount24M)),
				1226 => ROW(createRecord('SBFEDelq61OccurOELineCount36M', le.SBFEDelq61OccurOELineCount36M)),
				1227 => ROW(createRecord('SBFEDelq61OccurOELineCount60M', le.SBFEDelq61OccurOELineCount60M)),
				1228 => ROW(createRecord('SBFEDelq61OccurOELineCount84M', le.SBFEDelq61OccurOELineCount84M)),
				1229 => ROW(createRecord('SBFEDelq61OccurOELineCountEver', le.SBFEDelq61OccurOELineCountEver)),
				1230 => ROW(createRecord('SBFEDelq61OccurOtherCount03M', le.SBFEDelq61OccurOtherCount03M)),
				1231 => ROW(createRecord('SBFEDelq61OccurOtherCount06M', le.SBFEDelq61OccurOtherCount06M)),
				1232 => ROW(createRecord('SBFEDelq61OccurOtherCount12M', le.SBFEDelq61OccurOtherCount12M)),
				1233 => ROW(createRecord('SBFEDelq61OccurOtherCount24M', le.SBFEDelq61OccurOtherCount24M)),
				1234 => ROW(createRecord('SBFEDelq61OccurOtherCount36M', le.SBFEDelq61OccurOtherCount36M)),
				1235 => ROW(createRecord('SBFEDelq61OccurOtherCount60M', le.SBFEDelq61OccurOtherCount60M)),
				1236 => ROW(createRecord('SBFEDelq61OccurOtherCount84M', le.SBFEDelq61OccurOtherCount84M)),
				1237 => ROW(createRecord('SBFEDelq61OccurOtherCountEver', le.SBFEDelq61OccurOtherCountEver)),
				1238 => ROW(createRecord('SBFEDelq91OccurCount03M', le.SBFEDelq91OccurCount03M)),
				1239 => ROW(createRecord('SBFEDelq91OccurCount06M', le.SBFEDelq91OccurCount06M)),
				1240 => ROW(createRecord('SBFEDelq91OccurCount12M', le.SBFEDelq91OccurCount12M)),
				1241 => ROW(createRecord('SBFEDelq91OccurCount24M', le.SBFEDelq91OccurCount24M)),
				1242 => ROW(createRecord('SBFEDelq91OccurCount36M', le.SBFEDelq91OccurCount36M)),
				1243 => ROW(createRecord('SBFEDelq91OccurCount60M', le.SBFEDelq91OccurCount60M)),
				1244 => ROW(createRecord('SBFEDelq91OccurCount84M', le.SBFEDelq91OccurCount84M)),
				1245 => ROW(createRecord('SBFEDelq91OccurCountEver', le.SBFEDelq91OccurCountEver)),
				1246 => ROW(createRecord('SBFEDelq91OccurLoanCount03M', le.SBFEDelq91OccurLoanCount03M)),
				1247 => ROW(createRecord('SBFEDelq91OccurLoanCount06M', le.SBFEDelq91OccurLoanCount06M)),
				1248 => ROW(createRecord('SBFEDelq91OccurLoanCount12M', le.SBFEDelq91OccurLoanCount12M)),
				1249 => ROW(createRecord('SBFEDelq91OccurLoanCount24M', le.SBFEDelq91OccurLoanCount24M)),
				1250 => ROW(createRecord('SBFEDelq91OccurLoanCount36M', le.SBFEDelq91OccurLoanCount36M)),
				1251 => ROW(createRecord('SBFEDelq91OccurLoanCount60M', le.SBFEDelq91OccurLoanCount60M)),
				1252 => ROW(createRecord('SBFEDelq91OccurLoanCount84M', le.SBFEDelq91OccurLoanCount84M)),
				1253 => ROW(createRecord('SBFEDelq91OccurLoanCountEver', le.SBFEDelq91OccurLoanCountEver)),
				1254 => ROW(createRecord('SBFEDelq91OccurLineCount03M', le.SBFEDelq91OccurLineCount03M)),
				1255 => ROW(createRecord('SBFEDelq91OccurLineCount06M', le.SBFEDelq91OccurLineCount06M)),
				1256 => ROW(createRecord('SBFEDelq91OccurLineCount12M', le.SBFEDelq91OccurLineCount12M)),
				1257 => ROW(createRecord('SBFEDelq91OccurLineCount24M', le.SBFEDelq91OccurLineCount24M)),
				1258 => ROW(createRecord('SBFEDelq91OccurLineCount36M', le.SBFEDelq91OccurLineCount36M)),
				1259 => ROW(createRecord('SBFEDelq91OccurLineCount60M', le.SBFEDelq91OccurLineCount60M)),
				1260 => ROW(createRecord('SBFEDelq91OccurLineCount84M', le.SBFEDelq91OccurLineCount84M)),
				1261 => ROW(createRecord('SBFEDelq91OccurLineCountEver', le.SBFEDelq91OccurLineCountEver)),
				1262 => ROW(createRecord('SBFEDelq91OccurCardCount03M', le.SBFEDelq91OccurCardCount03M)),
				1263 => ROW(createRecord('SBFEDelq91OccurCardCount06M', le.SBFEDelq91OccurCardCount06M)),
				1264 => ROW(createRecord('SBFEDelq91OccurCardCount12M', le.SBFEDelq91OccurCardCount12M)),
				1265 => ROW(createRecord('SBFEDelq91OccurCardCount24M', le.SBFEDelq91OccurCardCount24M)),
				1266 => ROW(createRecord('SBFEDelq91OccurCardCount36M', le.SBFEDelq91OccurCardCount36M)),
				1267 => ROW(createRecord('SBFEDelq91OccurCardCount60M', le.SBFEDelq91OccurCardCount60M)),
				1268 => ROW(createRecord('SBFEDelq91OccurCardCount84M', le.SBFEDelq91OccurCardCount84M)),
				1269 => ROW(createRecord('SBFEDelq91OccurCardCountEver', le.SBFEDelq91OccurCardCountEver)),
				1270 => ROW(createRecord('SBFEDelq91OccurLeaseCount03M', le.SBFEDelq91OccurLeaseCount03M)),
				1271 => ROW(createRecord('SBFEDelq91OccurLeaseCount06M', le.SBFEDelq91OccurLeaseCount06M)),
				1272 => ROW(createRecord('SBFEDelq91OccurLeaseCount12M', le.SBFEDelq91OccurLeaseCount12M)),
				1273 => ROW(createRecord('SBFEDelq91OccurLeaseCount24M', le.SBFEDelq91OccurLeaseCount24M)),
				1274 => ROW(createRecord('SBFEDelq91OccurLeaseCount36M', le.SBFEDelq91OccurLeaseCount36M)),
				1275 => ROW(createRecord('SBFEDelq91OccurLeaseCount60M', le.SBFEDelq91OccurLeaseCount60M)),
				1276 => ROW(createRecord('SBFEDelq91OccurLeaseCount84M', le.SBFEDelq91OccurLeaseCount84M)),
				1277 => ROW(createRecord('SBFEDelq91OccurLeaseCountEver', le.SBFEDelq91OccurLeaseCountEver)),
				1278 => ROW(createRecord('SBFEDelq91OccurLetterCount03M', le.SBFEDelq91OccurLetterCount03M)),
				1279 => ROW(createRecord('SBFEDelq91OccurLetterCount06M', le.SBFEDelq91OccurLetterCount06M)),
				1280 => ROW(createRecord('SBFEDelq91OccurLetterCount12M', le.SBFEDelq91OccurLetterCount12M)),
				1281 => ROW(createRecord('SBFEDelq91OccurLetterCount24M', le.SBFEDelq91OccurLetterCount24M)),
				1282 => ROW(createRecord('SBFEDelq91OccurLetterCount36M', le.SBFEDelq91OccurLetterCount36M)),
				1283 => ROW(createRecord('SBFEDelq91OccurLetterCount60M', le.SBFEDelq91OccurLetterCount60M)),
				1284 => ROW(createRecord('SBFEDelq91OccurLetterCount84M', le.SBFEDelq91OccurLetterCount84M)),
				1285 => ROW(createRecord('SBFEDelq91OccurLetterCountEver', le.SBFEDelq91OccurLetterCountEver)),
				1286 => ROW(createRecord('SBFEDelq91OccurOELineCount03M', le.SBFEDelq91OccurOELineCount03M)),
				1287 => ROW(createRecord('SBFEDelq91OccurOELineCount06M', le.SBFEDelq91OccurOELineCount06M)),
				1288 => ROW(createRecord('SBFEDelq91OccurOELineCount12M', le.SBFEDelq91OccurOELineCount12M)),
				1289 => ROW(createRecord('SBFEDelq91OccurOELineCount24M', le.SBFEDelq91OccurOELineCount24M)),
				1290 => ROW(createRecord('SBFEDelq91OccurOELineCount36M', le.SBFEDelq91OccurOELineCount36M)),
				1291 => ROW(createRecord('SBFEDelq91OccurOELineCount60M', le.SBFEDelq91OccurOELineCount60M)),
				1292 => ROW(createRecord('SBFEDelq91OccurOELineCount84M', le.SBFEDelq91OccurOELineCount84M)),
				1293 => ROW(createRecord('SBFEDelq91OccurOELineCountEver', le.SBFEDelq91OccurOELineCountEver)),
				1294 => ROW(createRecord('SBFEDelq91OccurOtherCount03M', le.SBFEDelq91OccurOtherCount03M)),
				1295 => ROW(createRecord('SBFEDelq91OccurOtherCount06M', le.SBFEDelq91OccurOtherCount06M)),
				1296 => ROW(createRecord('SBFEDelq91OccurOtherCount12M', le.SBFEDelq91OccurOtherCount12M)),
				1297 => ROW(createRecord('SBFEDelq91OccurOtherCount24M', le.SBFEDelq91OccurOtherCount24M)),
				1298 => ROW(createRecord('SBFEDelq91OccurOtherCount36M', le.SBFEDelq91OccurOtherCount36M)),
				1299 => ROW(createRecord('SBFEDelq91OccurOtherCount60M', le.SBFEDelq91OccurOtherCount60M)),
				1300 => ROW(createRecord('SBFEDelq91OccurOtherCount84M', le.SBFEDelq91OccurOtherCount84M)),
				1301 => ROW(createRecord('SBFEDelq91OccurOtherCountEver', le.SBFEDelq91OccurOtherCountEver)),
				1302 => ROW(createRecord('SBFEDelq121OccurCount03M', le.SBFEDelq121OccurCount03M)),
				1303 => ROW(createRecord('SBFEDelq121OccurCount06M', le.SBFEDelq121OccurCount06M)),
				1304 => ROW(createRecord('SBFEDelq121OccurCount12M', le.SBFEDelq121OccurCount12M)),
				1305 => ROW(createRecord('SBFEDelq121OccurCount24M', le.SBFEDelq121OccurCount24M)),
				1306 => ROW(createRecord('SBFEDelq121OccurCount36M', le.SBFEDelq121OccurCount36M)),
				1307 => ROW(createRecord('SBFEDelq121OccurCount60M', le.SBFEDelq121OccurCount60M)),
				1308 => ROW(createRecord('SBFEDelq121OccurCount84M', le.SBFEDelq121OccurCount84M)),
				1309 => ROW(createRecord('SBFEDelq121OccurCountEver', le.SBFEDelq121OccurCountEver)),
				1310 => ROW(createRecord('SBFEDelq121OccurLoanCount03M', le.SBFEDelq121OccurLoanCount03M)),
				1311 => ROW(createRecord('SBFEDelq121OccurLoanCount06M', le.SBFEDelq121OccurLoanCount06M)),
				1312 => ROW(createRecord('SBFEDelq121OccurLoanCount12M', le.SBFEDelq121OccurLoanCount12M)),
				1313 => ROW(createRecord('SBFEDelq121OccurLoanCount24M', le.SBFEDelq121OccurLoanCount24M)),
				1314 => ROW(createRecord('SBFEDelq121OccurLoanCount36M', le.SBFEDelq121OccurLoanCount36M)),
				1315 => ROW(createRecord('SBFEDelq121OccurLoanCount60M', le.SBFEDelq121OccurLoanCount60M)),
				1316 => ROW(createRecord('SBFEDelq121OccurLoanCount84M', le.SBFEDelq121OccurLoanCount84M)),
				1317 => ROW(createRecord('SBFEDelq121OccurLoanCountEver', le.SBFEDelq121OccurLoanCountEver)),
				1318 => ROW(createRecord('SBFEDelq121OccurLineCount03M', le.SBFEDelq121OccurLineCount03M)),
				1319 => ROW(createRecord('SBFEDelq121OccurLineCount06M', le.SBFEDelq121OccurLineCount06M)),
				1320 => ROW(createRecord('SBFEDelq121OccurLineCount12M', le.SBFEDelq121OccurLineCount12M)),
				1321 => ROW(createRecord('SBFEDelq121OccurLineCount24M', le.SBFEDelq121OccurLineCount24M)),
				1322 => ROW(createRecord('SBFEDelq121OccurLineCount36M', le.SBFEDelq121OccurLineCount36M)),
				1323 => ROW(createRecord('SBFEDelq121OccurLineCount60M', le.SBFEDelq121OccurLineCount60M)),
				1324 => ROW(createRecord('SBFEDelq121OccurLineCount84M', le.SBFEDelq121OccurLineCount84M)),
				1325 => ROW(createRecord('SBFEDelq121OccurLineCountEver', le.SBFEDelq121OccurLineCountEver)),
				1326 => ROW(createRecord('SBFEDelq121OccurCardCount03M', le.SBFEDelq121OccurCardCount03M)),
				1327 => ROW(createRecord('SBFEDelq121OccurCardCount06M', le.SBFEDelq121OccurCardCount06M)),
				1328 => ROW(createRecord('SBFEDelq121OccurCardCount12M', le.SBFEDelq121OccurCardCount12M)),
				1329 => ROW(createRecord('SBFEDelq121OccurCardCount24M', le.SBFEDelq121OccurCardCount24M)),
				1330 => ROW(createRecord('SBFEDelq121OccurCardCount36M', le.SBFEDelq121OccurCardCount36M)),
				1331 => ROW(createRecord('SBFEDelq121OccurCardCount60M', le.SBFEDelq121OccurCardCount60M)),
				1332 => ROW(createRecord('SBFEDelq121OccurCardCount84M', le.SBFEDelq121OccurCardCount84M)),
				1333 => ROW(createRecord('SBFEDelq121OccurCardCountEver', le.SBFEDelq121OccurCardCountEver)),
				1334 => ROW(createRecord('SBFEDelq121OccurLeaseCount03M', le.SBFEDelq121OccurLeaseCount03M)),
				1335 => ROW(createRecord('SBFEDelq121OccurLeaseCount06M', le.SBFEDelq121OccurLeaseCount06M)),
				1336 => ROW(createRecord('SBFEDelq121OccurLeaseCount12M', le.SBFEDelq121OccurLeaseCount12M)),
				1337 => ROW(createRecord('SBFEDelq121OccurLeaseCount24M', le.SBFEDelq121OccurLeaseCount24M)),
				1338 => ROW(createRecord('SBFEDelq121OccurLeaseCount36M', le.SBFEDelq121OccurLeaseCount36M)),
				1339 => ROW(createRecord('SBFEDelq121OccurLeaseCount60M', le.SBFEDelq121OccurLeaseCount60M)),
				1340 => ROW(createRecord('SBFEDelq121OccurLeaseCount84M', le.SBFEDelq121OccurLeaseCount84M)),
				1341 => ROW(createRecord('SBFEDelq121OccurLeaseCountEver', le.SBFEDelq121OccurLeaseCountEver)),
				1342 => ROW(createRecord('SBFEDelq121OccurLetterCount03M', le.SBFEDelq121OccurLetterCount03M)),
				1343 => ROW(createRecord('SBFEDelq121OccurLetterCount06M', le.SBFEDelq121OccurLetterCount06M)),
				1344 => ROW(createRecord('SBFEDelq121OccurLetterCount12M', le.SBFEDelq121OccurLetterCount12M)),
				1345 => ROW(createRecord('SBFEDelq121OccurLetterCount24M', le.SBFEDelq121OccurLetterCount24M)),
				1346 => ROW(createRecord('SBFEDelq121OccurLetterCount36M', le.SBFEDelq121OccurLetterCount36M)),
				1347 => ROW(createRecord('SBFEDelq121OccurLetterCount60M', le.SBFEDelq121OccurLetterCount60M)),
				1348 => ROW(createRecord('SBFEDelq121OccurLetterCount84M', le.SBFEDelq121OccurLetterCount84M)),
				1349 => ROW(createRecord('SBFEDelq121OccurLetterCountEver', le.SBFEDelq121OccurLetterCountEver)),
				1350 => ROW(createRecord('SBFEDelq121OccurOELineCount03M', le.SBFEDelq121OccurOELineCount03M)),
				1351 => ROW(createRecord('SBFEDelq121OccurOELineCount06M', le.SBFEDelq121OccurOELineCount06M)),
				1352 => ROW(createRecord('SBFEDelq121OccurOELineCount12M', le.SBFEDelq121OccurOELineCount12M)),
				1353 => ROW(createRecord('SBFEDelq121OccurOELineCount24M', le.SBFEDelq121OccurOELineCount24M)),
				1354 => ROW(createRecord('SBFEDelq121OccurOELineCount36M', le.SBFEDelq121OccurOELineCount36M)),
				1355 => ROW(createRecord('SBFEDelq121OccurOELineCount60M', le.SBFEDelq121OccurOELineCount60M)),
				1356 => ROW(createRecord('SBFEDelq121OccurOELineCount84M', le.SBFEDelq121OccurOELineCount84M)),
				1357 => ROW(createRecord('SBFEDelq121OccurOELineCountEver', le.SBFEDelq121OccurOELineCountEver)),
				1358 => ROW(createRecord('SBFEDelq121OccurOtherCount03M', le.SBFEDelq121OccurOtherCount03M)),
				1359 => ROW(createRecord('SBFEDelq121OccurOtherCount06M', le.SBFEDelq121OccurOtherCount06M)),
				1360 => ROW(createRecord('SBFEDelq121OccurOtherCount12M', le.SBFEDelq121OccurOtherCount12M)),
				1361 => ROW(createRecord('SBFEDelq121OccurOtherCount24M', le.SBFEDelq121OccurOtherCount24M)),
				1362 => ROW(createRecord('SBFEDelq121OccurOtherCount36M', le.SBFEDelq121OccurOtherCount36M)),
				1363 => ROW(createRecord('SBFEDelq121OccurOtherCount60M', le.SBFEDelq121OccurOtherCount60M)),
				1364 => ROW(createRecord('SBFEDelq121OccurOtherCount84M', le.SBFEDelq121OccurOtherCount84M)),
				1365 => ROW(createRecord('SBFEDelq121OccurOtherCountEver', le.SBFEDelq121OccurOtherCountEver)),
				1366 => ROW(createRecord('SBFEDelqAmt', le.SBFEDelqAmt)),
				1367 => ROW(createRecord('SBFEDelq01Amt', le.SBFEDelq01Amt)),
				1368 => ROW(createRecord('SBFEDelq01AmtTtl', le.SBFEDelq01AmtTtl)),
				1369 => ROW(createRecord('SBFEDelq01Amt03M', le.SBFEDelq01Amt03M)),
				1370 => ROW(createRecord('SBFEDelq01Amt06M', le.SBFEDelq01Amt06M)),
				1371 => ROW(createRecord('SBFEDelq01Amt12M', le.SBFEDelq01Amt12M)),
				1372 => ROW(createRecord('SBFEDelq01Amt24M', le.SBFEDelq01Amt24M)),
				1373 => ROW(createRecord('SBFEDelq01Amt36M', le.SBFEDelq01Amt36M)),
				1374 => ROW(createRecord('SBFEDelq01Amt60M', le.SBFEDelq01Amt60M)),
				1375 => ROW(createRecord('SBFEDelq01Amt84M', le.SBFEDelq01Amt84M)),
				1376 => ROW(createRecord('SBFEDelq31Amt', le.SBFEDelq31Amt)),
				1377 => ROW(createRecord('SBFEDelq31AmtTtl', le.SBFEDelq31AmtTtl)),
				1378 => ROW(createRecord('SBFEDelq31Amt03M', le.SBFEDelq31Amt03M)),
				1379 => ROW(createRecord('SBFEDelq31Amt06M', le.SBFEDelq31Amt06M)),
				1380 => ROW(createRecord('SBFEDelq31Amt12M', le.SBFEDelq31Amt12M)),
				1381 => ROW(createRecord('SBFEDelq31Amt24M', le.SBFEDelq31Amt24M)),
				1382 => ROW(createRecord('SBFEDelq31Amt36M', le.SBFEDelq31Amt36M)),
				1383 => ROW(createRecord('SBFEDelq31Amt60M', le.SBFEDelq31Amt60M)),
				1384 => ROW(createRecord('SBFEDelq31Amt84M', le.SBFEDelq31Amt84M)),
				1385 => ROW(createRecord('SBFEDelq61Amt', le.SBFEDelq61Amt)),
				1386 => ROW(createRecord('SBFEDelq61AmtTtl', le.SBFEDelq61AmtTtl)),
				1387 => ROW(createRecord('SBFEDelq61Amt03M', le.SBFEDelq61Amt03M)),
				1388 => ROW(createRecord('SBFEDelq61Amt06M', le.SBFEDelq61Amt06M)),
				1389 => ROW(createRecord('SBFEDelq61Amt12M', le.SBFEDelq61Amt12M)),
				1390 => ROW(createRecord('SBFEDelq61Amt24M', le.SBFEDelq61Amt24M)),
				1391 => ROW(createRecord('SBFEDelq61Amt36M', le.SBFEDelq61Amt36M)),
				1392 => ROW(createRecord('SBFEDelq61Amt60M', le.SBFEDelq61Amt60M)),
				1393 => ROW(createRecord('SBFEDelq61Amt84M', le.SBFEDelq61Amt84M)),
				1394 => ROW(createRecord('SBFEDelq91Amt', le.SBFEDelq91Amt)),
				1395 => ROW(createRecord('SBFEDelq91AmtTtl', le.SBFEDelq91AmtTtl)),
				1396 => ROW(createRecord('SBFEDelq91Amt03M', le.SBFEDelq91Amt03M)),
				1397 => ROW(createRecord('SBFEDelq91Amt06M', le.SBFEDelq91Amt06M)),
				1398 => ROW(createRecord('SBFEDelq91Amt12M', le.SBFEDelq91Amt12M)),
				1399 => ROW(createRecord('SBFEDelq91Amt24M', le.SBFEDelq91Amt24M)),
				1400 => ROW(createRecord('SBFEDelq91Amt36M', le.SBFEDelq91Amt36M)),
				1401 => ROW(createRecord('SBFEDelq91Amt60M', le.SBFEDelq91Amt60M)),
				1402 => ROW(createRecord('SBFEDelq91Amt84M', le.SBFEDelq91Amt84M)),
				1403 => ROW(createRecord('SBFEDelq121Amt', le.SBFEDelq121Amt)),
				1404 => ROW(createRecord('SBFEDelq121Amt03M', le.SBFEDelq121Amt03M)),
				1405 => ROW(createRecord('SBFEDelq121Amt06M', le.SBFEDelq121Amt06M)),
				1406 => ROW(createRecord('SBFEDelq121Amt12M', le.SBFEDelq121Amt12M)),
				1407 => ROW(createRecord('SBFEDelq121Amt24M', le.SBFEDelq121Amt24M)),
				1408 => ROW(createRecord('SBFEDelq121Amt36M', le.SBFEDelq121Amt36M)),
				1409 => ROW(createRecord('SBFEDelq121Amt60M', le.SBFEDelq121Amt60M)),
				1410 => ROW(createRecord('SBFEDelq121Amt84M', le.SBFEDelq121Amt84M)),
				1411 => ROW(createRecord('SBFEDelqLoanAmt', le.SBFEDelqLoanAmt)),
				1412 => ROW(createRecord('SBFEDelq01LoanAmt', le.SBFEDelq01LoanAmt)),
				1413 => ROW(createRecord('SBFEDelq01LoanAmt03M', le.SBFEDelq01LoanAmt03M)),
				1414 => ROW(createRecord('SBFEDelq01LoanAmt06M', le.SBFEDelq01LoanAmt06M)),
				1415 => ROW(createRecord('SBFEDelq01LoanAmt12M', le.SBFEDelq01LoanAmt12M)),
				1416 => ROW(createRecord('SBFEDelq01LoanAmt24M', le.SBFEDelq01LoanAmt24M)),
				1417 => ROW(createRecord('SBFEDelq01LoanAmt36M', le.SBFEDelq01LoanAmt36M)),
				1418 => ROW(createRecord('SBFEDelq01LoanAmt60M', le.SBFEDelq01LoanAmt60M)),
				1419 => ROW(createRecord('SBFEDelq01LoanAmt84M', le.SBFEDelq01LoanAmt84M)),
				1420 => ROW(createRecord('SBFEDelq31LoanAmt', le.SBFEDelq31LoanAmt)),
				1421 => ROW(createRecord('SBFEDelq31LoanAmt03M', le.SBFEDelq31LoanAmt03M)),
				1422 => ROW(createRecord('SBFEDelq31LoanAmt06M', le.SBFEDelq31LoanAmt06M)),
				1423 => ROW(createRecord('SBFEDelq31LoanAmt12M', le.SBFEDelq31LoanAmt12M)),
				1424 => ROW(createRecord('SBFEDelq31LoanAmt24M', le.SBFEDelq31LoanAmt24M)),
				1425 => ROW(createRecord('SBFEDelq31LoanAmt36M', le.SBFEDelq31LoanAmt36M)),
				1426 => ROW(createRecord('SBFEDelq31LoanAmt60M', le.SBFEDelq31LoanAmt60M)),
				1427 => ROW(createRecord('SBFEDelq31LoanAmt84M', le.SBFEDelq31LoanAmt84M)),
				1428 => ROW(createRecord('SBFEDelq61LoanAmt', le.SBFEDelq61LoanAmt)),
				1429 => ROW(createRecord('SBFEDelq61LoanAmt03M', le.SBFEDelq61LoanAmt03M)),
				1430 => ROW(createRecord('SBFEDelq61LoanAmt06M', le.SBFEDelq61LoanAmt06M)),
				1431 => ROW(createRecord('SBFEDelq61LoanAmt12M', le.SBFEDelq61LoanAmt12M)),
				1432 => ROW(createRecord('SBFEDelq61LoanAmt24M', le.SBFEDelq61LoanAmt24M)),
				1433 => ROW(createRecord('SBFEDelq61LoanAmt36M', le.SBFEDelq61LoanAmt36M)),
				1434 => ROW(createRecord('SBFEDelq61LoanAmt60M', le.SBFEDelq61LoanAmt60M)),
				1435 => ROW(createRecord('SBFEDelq61LoanAmt84M', le.SBFEDelq61LoanAmt84M)),
				1436 => ROW(createRecord('SBFEDelq91LoanAmt', le.SBFEDelq91LoanAmt)),
				1437 => ROW(createRecord('SBFEDelq91LoanAmt03M', le.SBFEDelq91LoanAmt03M)),
				1438 => ROW(createRecord('SBFEDelq91LoanAmt06M', le.SBFEDelq91LoanAmt06M)),
				1439 => ROW(createRecord('SBFEDelq91LoanAmt12M', le.SBFEDelq91LoanAmt12M)),
				1440 => ROW(createRecord('SBFEDelq91LoanAmt24M', le.SBFEDelq91LoanAmt24M)),
				1441 => ROW(createRecord('SBFEDelq91LoanAmt36M', le.SBFEDelq91LoanAmt36M)),
				1442 => ROW(createRecord('SBFEDelq91LoanAmt60M', le.SBFEDelq91LoanAmt60M)),
				1443 => ROW(createRecord('SBFEDelq91LoanAmt84M', le.SBFEDelq91LoanAmt84M)),
				1444 => ROW(createRecord('SBFEDelq121LoanAmt', le.SBFEDelq121LoanAmt)),
				1445 => ROW(createRecord('SBFEDelq121LoanAmt03M', le.SBFEDelq121LoanAmt03M)),
				1446 => ROW(createRecord('SBFEDelq121LoanAmt06M', le.SBFEDelq121LoanAmt06M)),
				1447 => ROW(createRecord('SBFEDelq121LoanAmt12M', le.SBFEDelq121LoanAmt12M)),
				1448 => ROW(createRecord('SBFEDelq121LoanAmt24M', le.SBFEDelq121LoanAmt24M)),
				1449 => ROW(createRecord('SBFEDelq121LoanAmt36M', le.SBFEDelq121LoanAmt36M)),
				1450 => ROW(createRecord('SBFEDelq121LoanAmt60M', le.SBFEDelq121LoanAmt60M)),
				1451 => ROW(createRecord('SBFEDelq121LoanAmt84M', le.SBFEDelq121LoanAmt84M)),
				1452 => ROW(createRecord('SBFEDelqLineAmt', le.SBFEDelqLineAmt)),
				1453 => ROW(createRecord('SBFEDelq01LineAmt', le.SBFEDelq01LineAmt)),
				1454 => ROW(createRecord('SBFEDelq01LineAmt03M', le.SBFEDelq01LineAmt03M)),
				1455 => ROW(createRecord('SBFEDelq01LineAmt06M', le.SBFEDelq01LineAmt06M)),
				1456 => ROW(createRecord('SBFEDelq01LineAmt12M', le.SBFEDelq01LineAmt12M)),
				1457 => ROW(createRecord('SBFEDelq01LineAmt24M', le.SBFEDelq01LineAmt24M)),
				1458 => ROW(createRecord('SBFEDelq01LineAmt36M', le.SBFEDelq01LineAmt36M)),
				1459 => ROW(createRecord('SBFEDelq01LineAmt60M', le.SBFEDelq01LineAmt60M)),
				1460 => ROW(createRecord('SBFEDelq01LineAmt84M', le.SBFEDelq01LineAmt84M)),
				1461 => ROW(createRecord('SBFEDelq31LineAmt', le.SBFEDelq31LineAmt)),
				1462 => ROW(createRecord('SBFEDelq31LineAmt03M', le.SBFEDelq31LineAmt03M)),
				1463 => ROW(createRecord('SBFEDelq31LineAmt06M', le.SBFEDelq31LineAmt06M)),
				1464 => ROW(createRecord('SBFEDelq31LineAmt12M', le.SBFEDelq31LineAmt12M)),
				1465 => ROW(createRecord('SBFEDelq31LineAmt24M', le.SBFEDelq31LineAmt24M)),
				1466 => ROW(createRecord('SBFEDelq31LineAmt36M', le.SBFEDelq31LineAmt36M)),
				1467 => ROW(createRecord('SBFEDelq31LineAmt60M', le.SBFEDelq31LineAmt60M)),
				1468 => ROW(createRecord('SBFEDelq31LineAmt84M', le.SBFEDelq31LineAmt84M)),
				1469 => ROW(createRecord('SBFEDelq61LineAmt', le.SBFEDelq61LineAmt)),
				1470 => ROW(createRecord('SBFEDelq61LineAmt03M', le.SBFEDelq61LineAmt03M)),
				1471 => ROW(createRecord('SBFEDelq61LineAmt06M', le.SBFEDelq61LineAmt06M)),
				1472 => ROW(createRecord('SBFEDelq61LineAmt12M', le.SBFEDelq61LineAmt12M)),
				1473 => ROW(createRecord('SBFEDelq61LineAmt24M', le.SBFEDelq61LineAmt24M)),
				1474 => ROW(createRecord('SBFEDelq61LineAmt36M', le.SBFEDelq61LineAmt36M)),
				1475 => ROW(createRecord('SBFEDelq61LineAmt60M', le.SBFEDelq61LineAmt60M)),
				1476 => ROW(createRecord('SBFEDelq61LineAmt84M', le.SBFEDelq61LineAmt84M)),
				1477 => ROW(createRecord('SBFEDelq91LineAmt', le.SBFEDelq91LineAmt)),
				1478 => ROW(createRecord('SBFEDelq91LineAmt03M', le.SBFEDelq91LineAmt03M)),
				1479 => ROW(createRecord('SBFEDelq91LineAmt06M', le.SBFEDelq91LineAmt06M)),
				1480 => ROW(createRecord('SBFEDelq91LineAmt12M', le.SBFEDelq91LineAmt12M)),
				1481 => ROW(createRecord('SBFEDelq91LineAmt24M', le.SBFEDelq91LineAmt24M)),
				1482 => ROW(createRecord('SBFEDelq91LineAmt36M', le.SBFEDelq91LineAmt36M)),
				1483 => ROW(createRecord('SBFEDelq91LineAmt60M', le.SBFEDelq91LineAmt60M)),
				1484 => ROW(createRecord('SBFEDelq91LineAmt84M', le.SBFEDelq91LineAmt84M)),
				1485 => ROW(createRecord('SBFEDelq121LineAmt', le.SBFEDelq121LineAmt)),
				1486 => ROW(createRecord('SBFEDelq121LineAmt03M', le.SBFEDelq121LineAmt03M)),
				1487 => ROW(createRecord('SBFEDelq121LineAmt06M', le.SBFEDelq121LineAmt06M)),
				1488 => ROW(createRecord('SBFEDelq121LineAmt12M', le.SBFEDelq121LineAmt12M)),
				1489 => ROW(createRecord('SBFEDelq121LineAmt24M', le.SBFEDelq121LineAmt24M)),
				1490 => ROW(createRecord('SBFEDelq121LineAmt36M', le.SBFEDelq121LineAmt36M)),
				1491 => ROW(createRecord('SBFEDelq121LineAmt60M', le.SBFEDelq121LineAmt60M)),
				1492 => ROW(createRecord('SBFEDelq121LineAmt84M', le.SBFEDelq121LineAmt84M)),
				1493 => ROW(createRecord('SBFEDelqCardAmt', le.SBFEDelqCardAmt)),
				1494 => ROW(createRecord('SBFEDelq01CardAmt', le.SBFEDelq01CardAmt)),
				1495 => ROW(createRecord('SBFEDelq01CardAmt03M', le.SBFEDelq01CardAmt03M)),
				1496 => ROW(createRecord('SBFEDelq01CardAmt06M', le.SBFEDelq01CardAmt06M)),
				1497 => ROW(createRecord('SBFEDelq01CardAmt12M', le.SBFEDelq01CardAmt12M)),
				1498 => ROW(createRecord('SBFEDelq01CardAmt24M', le.SBFEDelq01CardAmt24M)),
				1499 => ROW(createRecord('SBFEDelq01CardAmt36M', le.SBFEDelq01CardAmt36M)),
				1500 => ROW(createRecord('SBFEDelq01CardAmt60M', le.SBFEDelq01CardAmt60M)),
				1501 => ROW(createRecord('SBFEDelq01CardAmt84M', le.SBFEDelq01CardAmt84M)),
				1502 => ROW(createRecord('SBFEDelq31CardAmt', le.SBFEDelq31CardAmt)),
				1503 => ROW(createRecord('SBFEDelq31CardAmt03M', le.SBFEDelq31CardAmt03M)),
				1504 => ROW(createRecord('SBFEDelq31CardAmt06M', le.SBFEDelq31CardAmt06M)),
				1505 => ROW(createRecord('SBFEDelq31CardAmt12M', le.SBFEDelq31CardAmt12M)),
				1506 => ROW(createRecord('SBFEDelq31CardAmt24M', le.SBFEDelq31CardAmt24M)),
				1507 => ROW(createRecord('SBFEDelq31CardAmt36M', le.SBFEDelq31CardAmt36M)),
				1508 => ROW(createRecord('SBFEDelq31CardAmt60M', le.SBFEDelq31CardAmt60M)),
				1509 => ROW(createRecord('SBFEDelq31CardAmt84M', le.SBFEDelq31CardAmt84M)),
				1510 => ROW(createRecord('SBFEDelq61CardAmt', le.SBFEDelq61CardAmt)),
				1511 => ROW(createRecord('SBFEDelq61CardAmt03M', le.SBFEDelq61CardAmt03M)),
				1512 => ROW(createRecord('SBFEDelq61CardAmt06M', le.SBFEDelq61CardAmt06M)),
				1513 => ROW(createRecord('SBFEDelq61CardAmt12M', le.SBFEDelq61CardAmt12M)),
				1514 => ROW(createRecord('SBFEDelq61CardAmt24M', le.SBFEDelq61CardAmt24M)),
				1515 => ROW(createRecord('SBFEDelq61CardAmt36M', le.SBFEDelq61CardAmt36M)),
				1516 => ROW(createRecord('SBFEDelq61CardAmt60M', le.SBFEDelq61CardAmt60M)),
				1517 => ROW(createRecord('SBFEDelq61CardAmt84M', le.SBFEDelq61CardAmt84M)),
				1518 => ROW(createRecord('SBFEDelq91CardAmt', le.SBFEDelq91CardAmt)),
				1519 => ROW(createRecord('SBFEDelq91CardAmt03M', le.SBFEDelq91CardAmt03M)),
				1520 => ROW(createRecord('SBFEDelq91CardAmt06M', le.SBFEDelq91CardAmt06M)),
				1521 => ROW(createRecord('SBFEDelq91CardAmt12M', le.SBFEDelq91CardAmt12M)),
				1522 => ROW(createRecord('SBFEDelq91CardAmt24M', le.SBFEDelq91CardAmt24M)),
				1523 => ROW(createRecord('SBFEDelq91CardAmt36M', le.SBFEDelq91CardAmt36M)),
				1524 => ROW(createRecord('SBFEDelq91CardAmt60M', le.SBFEDelq91CardAmt60M)),
				1525 => ROW(createRecord('SBFEDelq91CardAmt84M', le.SBFEDelq91CardAmt84M)),
				1526 => ROW(createRecord('SBFEDelq121CardAmt', le.SBFEDelq121CardAmt)),
				1527 => ROW(createRecord('SBFEDelq121CardAmt03M', le.SBFEDelq121CardAmt03M)),
				1528 => ROW(createRecord('SBFEDelq121CardAmt06M', le.SBFEDelq121CardAmt06M)),
				1529 => ROW(createRecord('SBFEDelq121CardAmt12M', le.SBFEDelq121CardAmt12M)),
				1530 => ROW(createRecord('SBFEDelq121CardAmt24M', le.SBFEDelq121CardAmt24M)),
				1531 => ROW(createRecord('SBFEDelq121CardAmt36M', le.SBFEDelq121CardAmt36M)),
				1532 => ROW(createRecord('SBFEDelq121CardAmt60M', le.SBFEDelq121CardAmt60M)),
				1533 => ROW(createRecord('SBFEDelq121CardAmt84M', le.SBFEDelq121CardAmt84M)),
				1534 => ROW(createRecord('SBFEDelqLeaseAmt', le.SBFEDelqLeaseAmt)),
				1535 => ROW(createRecord('SBFEDelq01LeaseAmt', le.SBFEDelq01LeaseAmt)),
				1536 => ROW(createRecord('SBFEDelq01LeaseAmt03M', le.SBFEDelq01LeaseAmt03M)),
				1537 => ROW(createRecord('SBFEDelq01LeaseAmt06M', le.SBFEDelq01LeaseAmt06M)),
				1538 => ROW(createRecord('SBFEDelq01LeaseAmt12M', le.SBFEDelq01LeaseAmt12M)),
				1539 => ROW(createRecord('SBFEDelq01LeaseAmt24M', le.SBFEDelq01LeaseAmt24M)),
				1540 => ROW(createRecord('SBFEDelq01LeaseAmt36M', le.SBFEDelq01LeaseAmt36M)),
				1541 => ROW(createRecord('SBFEDelq01LeaseAmt60M', le.SBFEDelq01LeaseAmt60M)),
				1542 => ROW(createRecord('SBFEDelq01LeaseAmt84M', le.SBFEDelq01LeaseAmt84M)),
				1543 => ROW(createRecord('SBFEDelq31LeaseAmt', le.SBFEDelq31LeaseAmt)),
				1544 => ROW(createRecord('SBFEDelq31LeaseAmt03M', le.SBFEDelq31LeaseAmt03M)),
				1545 => ROW(createRecord('SBFEDelq31LeaseAmt06M', le.SBFEDelq31LeaseAmt06M)),
				1546 => ROW(createRecord('SBFEDelq31LeaseAmt12M', le.SBFEDelq31LeaseAmt12M)),
				1547 => ROW(createRecord('SBFEDelq31LeaseAmt24M', le.SBFEDelq31LeaseAmt24M)),
				1548 => ROW(createRecord('SBFEDelq31LeaseAmt36M', le.SBFEDelq31LeaseAmt36M)),
				1549 => ROW(createRecord('SBFEDelq31LeaseAmt60M', le.SBFEDelq31LeaseAmt60M)),
				1550 => ROW(createRecord('SBFEDelq31LeaseAmt84M', le.SBFEDelq31LeaseAmt84M)),
				1551 => ROW(createRecord('SBFEDelq61LeaseAmt', le.SBFEDelq61LeaseAmt)),
				1552 => ROW(createRecord('SBFEDelq61LeaseAmt03M', le.SBFEDelq61LeaseAmt03M)),
				1553 => ROW(createRecord('SBFEDelq61LeaseAmt06M', le.SBFEDelq61LeaseAmt06M)),
				1554 => ROW(createRecord('SBFEDelq61LeaseAmt12M', le.SBFEDelq61LeaseAmt12M)),
				1555 => ROW(createRecord('SBFEDelq61LeaseAmt24M', le.SBFEDelq61LeaseAmt24M)),
				1556 => ROW(createRecord('SBFEDelq61LeaseAmt36M', le.SBFEDelq61LeaseAmt36M)),
				1557 => ROW(createRecord('SBFEDelq61LeaseAmt60M', le.SBFEDelq61LeaseAmt60M)),
				1558 => ROW(createRecord('SBFEDelq61LeaseAmt84M', le.SBFEDelq61LeaseAmt84M)),
				1559 => ROW(createRecord('SBFEDelq91LeaseAmt', le.SBFEDelq91LeaseAmt)),
				1560 => ROW(createRecord('SBFEDelq91LeaseAmt03M', le.SBFEDelq91LeaseAmt03M)),
				1561 => ROW(createRecord('SBFEDelq91LeaseAmt06M', le.SBFEDelq91LeaseAmt06M)),
				1562 => ROW(createRecord('SBFEDelq91LeaseAmt12M', le.SBFEDelq91LeaseAmt12M)),
				1563 => ROW(createRecord('SBFEDelq91LeaseAmt24M', le.SBFEDelq91LeaseAmt24M)),
				1564 => ROW(createRecord('SBFEDelq91LeaseAmt36M', le.SBFEDelq91LeaseAmt36M)),
				1565 => ROW(createRecord('SBFEDelq91LeaseAmt60M', le.SBFEDelq91LeaseAmt60M)),
				1566 => ROW(createRecord('SBFEDelq91LeaseAmt84M', le.SBFEDelq91LeaseAmt84M)),
				1567 => ROW(createRecord('SBFEDelq121LeaseAmt', le.SBFEDelq121LeaseAmt)),
				1568 => ROW(createRecord('SBFEDelq121LeaseAmt03M', le.SBFEDelq121LeaseAmt03M)),
				1569 => ROW(createRecord('SBFEDelq121LeaseAmt06M', le.SBFEDelq121LeaseAmt06M)),
				1570 => ROW(createRecord('SBFEDelq121LeaseAmt12M', le.SBFEDelq121LeaseAmt12M)),
				1571 => ROW(createRecord('SBFEDelq121LeaseAmt24M', le.SBFEDelq121LeaseAmt24M)),
				1572 => ROW(createRecord('SBFEDelq121LeaseAmt36M', le.SBFEDelq121LeaseAmt36M)),
				1573 => ROW(createRecord('SBFEDelq121LeaseAmt60M', le.SBFEDelq121LeaseAmt60M)),
				1574 => ROW(createRecord('SBFEDelq121LeaseAmt84M', le.SBFEDelq121LeaseAmt84M)),
				1575 => ROW(createRecord('SBFEDelqLetterAmt', le.SBFEDelqLetterAmt)),
				1576 => ROW(createRecord('SBFEDelq01LetterAmt', le.SBFEDelq01LetterAmt)),
				1577 => ROW(createRecord('SBFEDelq01LetterAmt03M', le.SBFEDelq01LetterAmt03M)),
				1578 => ROW(createRecord('SBFEDelq01LetterAmt06M', le.SBFEDelq01LetterAmt06M)),
				1579 => ROW(createRecord('SBFEDelq01LetterAmt12M', le.SBFEDelq01LetterAmt12M)),
				1580 => ROW(createRecord('SBFEDelq01LetterAmt24M', le.SBFEDelq01LetterAmt24M)),
				1581 => ROW(createRecord('SBFEDelq01LetterAmt36M', le.SBFEDelq01LetterAmt36M)),
				1582 => ROW(createRecord('SBFEDelq01LetterAmt60M', le.SBFEDelq01LetterAmt60M)),
				1583 => ROW(createRecord('SBFEDelq01LetterAmt84M', le.SBFEDelq01LetterAmt84M)),
				1584 => ROW(createRecord('SBFEDelq31LetterAmt', le.SBFEDelq31LetterAmt)),
				1585 => ROW(createRecord('SBFEDelq31LetterAmt03M', le.SBFEDelq31LetterAmt03M)),
				1586 => ROW(createRecord('SBFEDelq31LetterAmt06M', le.SBFEDelq31LetterAmt06M)),
				1587 => ROW(createRecord('SBFEDelq31LetterAmt12M', le.SBFEDelq31LetterAmt12M)),
				1588 => ROW(createRecord('SBFEDelq31LetterAmt24M', le.SBFEDelq31LetterAmt24M)),
				1589 => ROW(createRecord('SBFEDelq31LetterAmt36M', le.SBFEDelq31LetterAmt36M)),
				1590 => ROW(createRecord('SBFEDelq31LetterAmt60M', le.SBFEDelq31LetterAmt60M)),
				1591 => ROW(createRecord('SBFEDelq31LetterAmt84M', le.SBFEDelq31LetterAmt84M)),
				1592 => ROW(createRecord('SBFEDelq61LetterAmt', le.SBFEDelq61LetterAmt)),
				1593 => ROW(createRecord('SBFEDelq61LetterAmt03M', le.SBFEDelq61LetterAmt03M)),
				1594 => ROW(createRecord('SBFEDelq61LetterAmt06M', le.SBFEDelq61LetterAmt06M)),
				1595 => ROW(createRecord('SBFEDelq61LetterAmt12M', le.SBFEDelq61LetterAmt12M)),
				1596 => ROW(createRecord('SBFEDelq61LetterAmt24M', le.SBFEDelq61LetterAmt24M)),
				1597 => ROW(createRecord('SBFEDelq61LetterAmt36M', le.SBFEDelq61LetterAmt36M)),
				1598 => ROW(createRecord('SBFEDelq61LetterAmt60M', le.SBFEDelq61LetterAmt60M)),
				1599 => ROW(createRecord('SBFEDelq61LetterAmt84M', le.SBFEDelq61LetterAmt84M)),
				1600 => ROW(createRecord('SBFEDelq91LetterAmt', le.SBFEDelq91LetterAmt)),
				1601 => ROW(createRecord('SBFEDelq91LetterAmt03M', le.SBFEDelq91LetterAmt03M)),
				1602 => ROW(createRecord('SBFEDelq91LetterAmt06M', le.SBFEDelq91LetterAmt06M)),
				1603 => ROW(createRecord('SBFEDelq91LetterAmt12M', le.SBFEDelq91LetterAmt12M)),
				1604 => ROW(createRecord('SBFEDelq91LetterAmt24M', le.SBFEDelq91LetterAmt24M)),
				1605 => ROW(createRecord('SBFEDelq91LetterAmt36M', le.SBFEDelq91LetterAmt36M)),
				1606 => ROW(createRecord('SBFEDelq91LetterAmt60M', le.SBFEDelq91LetterAmt60M)),
				1607 => ROW(createRecord('SBFEDelq91LetterAmt84M', le.SBFEDelq91LetterAmt84M)),
				1608 => ROW(createRecord('SBFEDelq121LetterAmt', le.SBFEDelq121LetterAmt)),
				1609 => ROW(createRecord('SBFEDelq121LetterAmt03M', le.SBFEDelq121LetterAmt03M)),
				1610 => ROW(createRecord('SBFEDelq121LetterAmt06M', le.SBFEDelq121LetterAmt06M)),
				1611 => ROW(createRecord('SBFEDelq121LetterAmt12M', le.SBFEDelq121LetterAmt12M)),
				1612 => ROW(createRecord('SBFEDelq121LetterAmt24M', le.SBFEDelq121LetterAmt24M)),
				1613 => ROW(createRecord('SBFEDelq121LetterAmt36M', le.SBFEDelq121LetterAmt36M)),
				1614 => ROW(createRecord('SBFEDelq121LetterAmt60M', le.SBFEDelq121LetterAmt60M)),
				1615 => ROW(createRecord('SBFEDelq121LetterAmt84M', le.SBFEDelq121LetterAmt84M)),
				1616 => ROW(createRecord('SBFEDelqOELineAmt', le.SBFEDelqOELineAmt)),
				1617 => ROW(createRecord('SBFEDelq01OELineAmt', le.SBFEDelq01OELineAmt)),
				1618 => ROW(createRecord('SBFEDelq01OELineAmt03M', le.SBFEDelq01OELineAmt03M)),
				1619 => ROW(createRecord('SBFEDelq01OELineAmt06M', le.SBFEDelq01OELineAmt06M)),
				1620 => ROW(createRecord('SBFEDelq01OELineAmt12M', le.SBFEDelq01OELineAmt12M)),
				1621 => ROW(createRecord('SBFEDelq01OELineAmt24M', le.SBFEDelq01OELineAmt24M)),
				1622 => ROW(createRecord('SBFEDelq01OELineAmt36M', le.SBFEDelq01OELineAmt36M)),
				1623 => ROW(createRecord('SBFEDelq01OELineAmt60M', le.SBFEDelq01OELineAmt60M)),
				1624 => ROW(createRecord('SBFEDelq01OELineAmt84M', le.SBFEDelq01OELineAmt84M)),
				1625 => ROW(createRecord('SBFEDelq31OELineAmt', le.SBFEDelq31OELineAmt)),
				1626 => ROW(createRecord('SBFEDelq31OELineAmt03M', le.SBFEDelq31OELineAmt03M)),
				1627 => ROW(createRecord('SBFEDelq31OELineAmt06M', le.SBFEDelq31OELineAmt06M)),
				1628 => ROW(createRecord('SBFEDelq31OELineAmt12M', le.SBFEDelq31OELineAmt12M)),
				1629 => ROW(createRecord('SBFEDelq31OELineAmt24M', le.SBFEDelq31OELineAmt24M)),
				1630 => ROW(createRecord('SBFEDelq31OELineAmt36M', le.SBFEDelq31OELineAmt36M)),
				1631 => ROW(createRecord('SBFEDelq31OELineAmt60M', le.SBFEDelq31OELineAmt60M)),
				1632 => ROW(createRecord('SBFEDelq31OELineAmt84M', le.SBFEDelq31OELineAmt84M)),
				1633 => ROW(createRecord('SBFEDelq61OELineAmt', le.SBFEDelq61OELineAmt)),
				1634 => ROW(createRecord('SBFEDelq61OELineAmt03M', le.SBFEDelq61OELineAmt03M)),
				1635 => ROW(createRecord('SBFEDelq61OELineAmt06M', le.SBFEDelq61OELineAmt06M)),
				1636 => ROW(createRecord('SBFEDelq61OELineAmt12M', le.SBFEDelq61OELineAmt12M)),
				1637 => ROW(createRecord('SBFEDelq61OELineAmt24M', le.SBFEDelq61OELineAmt24M)),
				1638 => ROW(createRecord('SBFEDelq61OELineAmt36M', le.SBFEDelq61OELineAmt36M)),
				1639 => ROW(createRecord('SBFEDelq61OELineAmt60M', le.SBFEDelq61OELineAmt60M)),
				1640 => ROW(createRecord('SBFEDelq61OELineAmt84M', le.SBFEDelq61OELineAmt84M)),
				1641 => ROW(createRecord('SBFEDelq91OELineAmt', le.SBFEDelq91OELineAmt)),
				1642 => ROW(createRecord('SBFEDelq91OELineAmt03M', le.SBFEDelq91OELineAmt03M)),
				1643 => ROW(createRecord('SBFEDelq91OELineAmt06M', le.SBFEDelq91OELineAmt06M)),
				1644 => ROW(createRecord('SBFEDelq91OELineAmt12M', le.SBFEDelq91OELineAmt12M)),
				1645 => ROW(createRecord('SBFEDelq91OELineAmt24M', le.SBFEDelq91OELineAmt24M)),
				1646 => ROW(createRecord('SBFEDelq91OELineAmt36M', le.SBFEDelq91OELineAmt36M)),
				1647 => ROW(createRecord('SBFEDelq91OELineAmt60M', le.SBFEDelq91OELineAmt60M)),
				1648 => ROW(createRecord('SBFEDelq91OELineAmt84M', le.SBFEDelq91OELineAmt84M)),
				1649 => ROW(createRecord('SBFEDelq121OELineAmt', le.SBFEDelq121OELineAmt)),
				1650 => ROW(createRecord('SBFEDelq121OELineAmt03M', le.SBFEDelq121OELineAmt03M)),
				1651 => ROW(createRecord('SBFEDelq121OELineAmt06M', le.SBFEDelq121OELineAmt06M)),
				1652 => ROW(createRecord('SBFEDelq121OELineAmt12M', le.SBFEDelq121OELineAmt12M)),
				1653 => ROW(createRecord('SBFEDelq121OELineAmt24M', le.SBFEDelq121OELineAmt24M)),
				1654 => ROW(createRecord('SBFEDelq121OELineAmt36M', le.SBFEDelq121OELineAmt36M)),
				1655 => ROW(createRecord('SBFEDelq121OELineAmt60M', le.SBFEDelq121OELineAmt60M)),
				1656 => ROW(createRecord('SBFEDelq121OELineAmt84M', le.SBFEDelq121OELineAmt84M)),
				1657 => ROW(createRecord('SBFEDelqOtherAmt', le.SBFEDelqOtherAmt)),
				1658 => ROW(createRecord('SBFEDelq01OtherAmt', le.SBFEDelq01OtherAmt)),
				1659 => ROW(createRecord('SBFEDelq01OtherAmt03M', le.SBFEDelq01OtherAmt03M)),
				1660 => ROW(createRecord('SBFEDelq01OtherAmt06M', le.SBFEDelq01OtherAmt06M)),
				1661 => ROW(createRecord('SBFEDelq01OtherAmt12M', le.SBFEDelq01OtherAmt12M)),
				1662 => ROW(createRecord('SBFEDelq01OtherAmt24M', le.SBFEDelq01OtherAmt24M)),
				1663 => ROW(createRecord('SBFEDelq01OtherAmt36M', le.SBFEDelq01OtherAmt36M)),
				1664 => ROW(createRecord('SBFEDelq01OtherAmt60M', le.SBFEDelq01OtherAmt60M)),
				1665 => ROW(createRecord('SBFEDelq01OtherAmt84M', le.SBFEDelq01OtherAmt84M)),
				1666 => ROW(createRecord('SBFEDelq31OtherAmt', le.SBFEDelq31OtherAmt)),
				1667 => ROW(createRecord('SBFEDelq31OtherAmt03M', le.SBFEDelq31OtherAmt03M)),
				1668 => ROW(createRecord('SBFEDelq31OtherAmt06M', le.SBFEDelq31OtherAmt06M)),
				1669 => ROW(createRecord('SBFEDelq31OtherAmt12M', le.SBFEDelq31OtherAmt12M)),
				1670 => ROW(createRecord('SBFEDelq31OtherAmt24M', le.SBFEDelq31OtherAmt24M)),
				1671 => ROW(createRecord('SBFEDelq31OtherAmt36M', le.SBFEDelq31OtherAmt36M)),
				1672 => ROW(createRecord('SBFEDelq31OtherAmt60M', le.SBFEDelq31OtherAmt60M)),
				1673 => ROW(createRecord('SBFEDelq31OtherAmt84M', le.SBFEDelq31OtherAmt84M)),
				1674 => ROW(createRecord('SBFEDelq61OtherAmt', le.SBFEDelq61OtherAmt)),
				1675 => ROW(createRecord('SBFEDelq61OtherAmt03M', le.SBFEDelq61OtherAmt03M)),
				1676 => ROW(createRecord('SBFEDelq61OtherAmt06M', le.SBFEDelq61OtherAmt06M)),
				1677 => ROW(createRecord('SBFEDelq61OtherAmt12M', le.SBFEDelq61OtherAmt12M)),
				1678 => ROW(createRecord('SBFEDelq61OtherAmt24M', le.SBFEDelq61OtherAmt24M)),
				1679 => ROW(createRecord('SBFEDelq61OtherAmt36M', le.SBFEDelq61OtherAmt36M)),
				1680 => ROW(createRecord('SBFEDelq61OtherAmt60M', le.SBFEDelq61OtherAmt60M)),
				1681 => ROW(createRecord('SBFEDelq61OtherAmt84M', le.SBFEDelq61OtherAmt84M)),
				1682 => ROW(createRecord('SBFEDelq91OtherAmt', le.SBFEDelq91OtherAmt)),
				1683 => ROW(createRecord('SBFEDelq91OtherAmt03M', le.SBFEDelq91OtherAmt03M)),
				1684 => ROW(createRecord('SBFEDelq91OtherAmt06M', le.SBFEDelq91OtherAmt06M)),
				1685 => ROW(createRecord('SBFEDelq91OtherAmt12M', le.SBFEDelq91OtherAmt12M)),
				1686 => ROW(createRecord('SBFEDelq91OtherAmt24M', le.SBFEDelq91OtherAmt24M)),
				1687 => ROW(createRecord('SBFEDelq91OtherAmt36M', le.SBFEDelq91OtherAmt36M)),
				1688 => ROW(createRecord('SBFEDelq91OtherAmt60M', le.SBFEDelq91OtherAmt60M)),
				1689 => ROW(createRecord('SBFEDelq91OtherAmt84M', le.SBFEDelq91OtherAmt84M)),
				1690 => ROW(createRecord('SBFEDelq121OtherAmt', le.SBFEDelq121OtherAmt)),
				1691 => ROW(createRecord('SBFEDelq121OtherAmt03M', le.SBFEDelq121OtherAmt03M)),
				1692 => ROW(createRecord('SBFEDelq121OtherAmt06M', le.SBFEDelq121OtherAmt06M)),
				1693 => ROW(createRecord('SBFEDelq121OtherAmt12M', le.SBFEDelq121OtherAmt12M)),
				1694 => ROW(createRecord('SBFEDelq121OtherAmt24M', le.SBFEDelq121OtherAmt24M)),
				1695 => ROW(createRecord('SBFEDelq121OtherAmt36M', le.SBFEDelq121OtherAmt36M)),
				1696 => ROW(createRecord('SBFEDelq121OtherAmt60M', le.SBFEDelq121OtherAmt60M)),
				1697 => ROW(createRecord('SBFEDelq121OtherAmt84M', le.SBFEDelq121OtherAmt84M)),
				1698 => ROW(createRecord('SBFEDelq1AmtPct', le.SBFEDelq1AmtPct)),
				1699 => ROW(createRecord('SBFEDelq1AmtPct03M', le.SBFEDelq1AmtPct03M)),
				1700 => ROW(createRecord('SBFEDelq1AmtPct06M', le.SBFEDelq1AmtPct06M)),
				1701 => ROW(createRecord('SBFEDelq1AmtPct12M', le.SBFEDelq1AmtPct12M)),
				1702 => ROW(createRecord('SBFEDelq1AmtPct24M', le.SBFEDelq1AmtPct24M)),
				1703 => ROW(createRecord('SBFEDelq1AmtPct36M', le.SBFEDelq1AmtPct36M)),
				1704 => ROW(createRecord('SBFEDelq1AmtPct60M', le.SBFEDelq1AmtPct60M)),
				1705 => ROW(createRecord('SBFEDelq1AmtPct84M', le.SBFEDelq1AmtPct84M)),
				1706 => ROW(createRecord('SBFEDelq1RevAmtPct', le.SBFEDelq1RevAmtPct)),
				1707 => ROW(createRecord('SBFEDelq1InstAmtPct', le.SBFEDelq1InstAmtPct)),
				1708 => ROW(createRecord('SBFEDelq31AmtPct', le.SBFEDelq31AmtPct)),
				1709 => ROW(createRecord('SBFEDelq31AmtPct03M', le.SBFEDelq31AmtPct03M)),
				1710 => ROW(createRecord('SBFEDelq31AmtPct06M', le.SBFEDelq31AmtPct06M)),
				1711 => ROW(createRecord('SBFEDelq31AmtPct12M', le.SBFEDelq31AmtPct12M)),
				1712 => ROW(createRecord('SBFEDelq31AmtPct24M', le.SBFEDelq31AmtPct24M)),
				1713 => ROW(createRecord('SBFEDelq31AmtPct36M', le.SBFEDelq31AmtPct36M)),
				1714 => ROW(createRecord('SBFEDelq31AmtPct60M', le.SBFEDelq31AmtPct60M)),
				1715 => ROW(createRecord('SBFEDelq31AmtPct84M', le.SBFEDelq31AmtPct84M)),
				1716 => ROW(createRecord('SBFEDelq31RevAmtPct', le.SBFEDelq31RevAmtPct)),
				1717 => ROW(createRecord('SBFEDelq31InstAmtPct', le.SBFEDelq31InstAmtPct)),
				1718 => ROW(createRecord('SBFEDelq61AmtPct', le.SBFEDelq61AmtPct)),
				1719 => ROW(createRecord('SBFEDelq61AmtPct03M', le.SBFEDelq61AmtPct03M)),
				1720 => ROW(createRecord('SBFEDelq61AmtPct06M', le.SBFEDelq61AmtPct06M)),
				1721 => ROW(createRecord('SBFEDelq61AmtPct12M', le.SBFEDelq61AmtPct12M)),
				1722 => ROW(createRecord('SBFEDelq61AmtPct24M', le.SBFEDelq61AmtPct24M)),
				1723 => ROW(createRecord('SBFEDelq61AmtPct36M', le.SBFEDelq61AmtPct36M)),
				1724 => ROW(createRecord('SBFEDelq61AmtPct60M', le.SBFEDelq61AmtPct60M)),
				1725 => ROW(createRecord('SBFEDelq61AmtPct84M', le.SBFEDelq61AmtPct84M)),
				1726 => ROW(createRecord('SBFEDelq61RevAmtPct', le.SBFEDelq61RevAmtPct)),
				1727 => ROW(createRecord('SBFEDelq61InstAmtPct', le.SBFEDelq61InstAmtPct)),
				1728 => ROW(createRecord('SBFEDelq91AmtPct', le.SBFEDelq91AmtPct)),
				1729 => ROW(createRecord('SBFEDelq91AmtPct03M', le.SBFEDelq91AmtPct03M)),
				1730 => ROW(createRecord('SBFEDelq91AmtPct06M', le.SBFEDelq91AmtPct06M)),
				1731 => ROW(createRecord('SBFEDelq91AmtPct12M', le.SBFEDelq91AmtPct12M)),
				1732 => ROW(createRecord('SBFEDelq91AmtPct24M', le.SBFEDelq91AmtPct24M)),
				1733 => ROW(createRecord('SBFEDelq91AmtPct36M', le.SBFEDelq91AmtPct36M)),
				1734 => ROW(createRecord('SBFEDelq91AmtPct60M', le.SBFEDelq91AmtPct60M)),
				1735 => ROW(createRecord('SBFEDelq91AmtPct84M', le.SBFEDelq91AmtPct84M)),
				1736 => ROW(createRecord('SBFEDelq91RevAmtPct', le.SBFEDelq91RevAmtPct)),
				1737 => ROW(createRecord('SBFEDelq91InstAmtPct', le.SBFEDelq91InstAmtPct)),
				1738 => ROW(createRecord('SBFEDelq121AmtPct', le.SBFEDelq121AmtPct)),
				1739 => ROW(createRecord('SBFEDelq121AmtPct03M', le.SBFEDelq121AmtPct03M)),
				1740 => ROW(createRecord('SBFEDelq121AmtPct06M', le.SBFEDelq121AmtPct06M)),
				1741 => ROW(createRecord('SBFEDelq121AmtPct12M', le.SBFEDelq121AmtPct12M)),
				1742 => ROW(createRecord('SBFEDelq121AmtPct24M', le.SBFEDelq121AmtPct24M)),
				1743 => ROW(createRecord('SBFEDelq121AmtPct36M', le.SBFEDelq121AmtPct36M)),
				1744 => ROW(createRecord('SBFEDelq121AmtPct60M', le.SBFEDelq121AmtPct60M)),
				1745 => ROW(createRecord('SBFEDelq121AmtPct84M', le.SBFEDelq121AmtPct84M)),
				1746 => ROW(createRecord('SBFEDelq121RevAmtPct', le.SBFEDelq121RevAmtPct)),
				1747 => ROW(createRecord('SBFEDelq121InstAmtPct', le.SBFEDelq121InstAmtPct)),
				1748 => ROW(createRecord('SBFEDelqAvgAmt03M', le.SBFEDelqAvgAmt03M)),
				1749 => ROW(createRecord('SBFEDelqAvg06M', le.SBFEDelqAvg06M)),
				1750 => ROW(createRecord('SBFEDelqAvgAmt12M', le.SBFEDelqAvgAmt12M)),
				1751 => ROW(createRecord('SBFEDelqAvgAmt24M', le.SBFEDelqAvgAmt24M)),
				1752 => ROW(createRecord('SBFEDelqAvgAmt36M', le.SBFEDelqAvgAmt36M)),
				1753 => ROW(createRecord('SBFEDelqAvgAmt60M', le.SBFEDelqAvgAmt60M)),
				1754 => ROW(createRecord('SBFEDelqAvgAmt84M', le.SBFEDelqAvgAmt84M)),
				1755 => ROW(createRecord('SBFEDelqAvgAmtEver', le.SBFEDelqAvgAmtEver)),
				1756 => ROW(createRecord('SBFEDelqLoanAvgAmt03M', le.SBFEDelqLoanAvgAmt03M)),
				1757 => ROW(createRecord('SBFEDelqLoanAvgAmt06M', le.SBFEDelqLoanAvgAmt06M)),
				1758 => ROW(createRecord('SBFEDelqLoanAvgAmt12M', le.SBFEDelqLoanAvgAmt12M)),
				1759 => ROW(createRecord('SBFEDelqLoanAvgAmt24M', le.SBFEDelqLoanAvgAmt24M)),
				1760 => ROW(createRecord('SBFEDelqLoanAvgAmt36M', le.SBFEDelqLoanAvgAmt36M)),
				1761 => ROW(createRecord('SBFEDelqLoanAvgAmt60M', le.SBFEDelqLoanAvgAmt60M)),
				1762 => ROW(createRecord('SBFEDelqLoanAvgAmt84M', le.SBFEDelqLoanAvgAmt84M)),
				1763 => ROW(createRecord('SBFEDelqLoanAvgAmtEver', le.SBFEDelqLoanAvgAmtEver)),
				1764 => ROW(createRecord('SBFEDelqLineAvgAmt03M', le.SBFEDelqLineAvgAmt03M)),
				1765 => ROW(createRecord('SBFEDelqLineAvgAmt06M', le.SBFEDelqLineAvgAmt06M)),
				1766 => ROW(createRecord('SBFEDelqLineAvgAmt12M', le.SBFEDelqLineAvgAmt12M)),
				1767 => ROW(createRecord('SBFEDelqLineAvgAmt24M', le.SBFEDelqLineAvgAmt24M)),
				1768 => ROW(createRecord('SBFEDelqLineAvgAmt36M', le.SBFEDelqLineAvgAmt36M)),
				1769 => ROW(createRecord('SBFEDelqLineAvgAmt60M', le.SBFEDelqLineAvgAmt60M)),
				1770 => ROW(createRecord('SBFEDelqLineAvgAmt84M', le.SBFEDelqLineAvgAmt84M)),
				1771 => ROW(createRecord('SBFEDelqLineAvgAmtEver', le.SBFEDelqLineAvgAmtEver)),
				1772 => ROW(createRecord('SBFEDelqCardAvgAmt03M', le.SBFEDelqCardAvgAmt03M)),
				1773 => ROW(createRecord('SBFEDelqCardAvgAmt06M', le.SBFEDelqCardAvgAmt06M)),
				1774 => ROW(createRecord('SBFEDelqCardAvgAmt12M', le.SBFEDelqCardAvgAmt12M)),
				1775 => ROW(createRecord('SBFEDelqCardAvgAmt24M', le.SBFEDelqCardAvgAmt24M)),
				1776 => ROW(createRecord('SBFEDelqCardAvgAmt36M', le.SBFEDelqCardAvgAmt36M)),
				1777 => ROW(createRecord('SBFEDelqCardAvgAmt60M', le.SBFEDelqCardAvgAmt60M)),
				1778 => ROW(createRecord('SBFEDelqCardAvgAmt84M', le.SBFEDelqCardAvgAmt84M)),
				1779 => ROW(createRecord('SBFEDelqCardAvgAmtEver', le.SBFEDelqCardAvgAmtEver)),
				1780 => ROW(createRecord('SBFEDelqLeaseAvgAmt03M', le.SBFEDelqLeaseAvgAmt03M)),
				1781 => ROW(createRecord('SBFEDelqLeaseAvgAmt06M', le.SBFEDelqLeaseAvgAmt06M)),
				1782 => ROW(createRecord('SBFEDelqLeaseAvgAmt12M', le.SBFEDelqLeaseAvgAmt12M)),
				1783 => ROW(createRecord('SBFEDelqLeaseAvgAmt24M', le.SBFEDelqLeaseAvgAmt24M)),
				1784 => ROW(createRecord('SBFEDelqLeaseAvgAmt36M', le.SBFEDelqLeaseAvgAmt36M)),
				1785 => ROW(createRecord('SBFEDelqLeaseAvgAmt60M', le.SBFEDelqLeaseAvgAmt60M)),
				1786 => ROW(createRecord('SBFEDelqLeaseAvgAmt84M', le.SBFEDelqLeaseAvgAmt84M)),
				1787 => ROW(createRecord('SBFEDelqLeaseAvgAmtEver', le.SBFEDelqLeaseAvgAmtEver)),
				1788 => ROW(createRecord('SBFEDelqLetterAvgAmt03M', le.SBFEDelqLetterAvgAmt03M)),
				1789 => ROW(createRecord('SBFEDelqLetterAvgAmt06M', le.SBFEDelqLetterAvgAmt06M)),
				1790 => ROW(createRecord('SBFEDelqLetterAvgAmt12M', le.SBFEDelqLetterAvgAmt12M)),
				1791 => ROW(createRecord('SBFEDelqLetterAvgAmt24M', le.SBFEDelqLetterAvgAmt24M)),
				1792 => ROW(createRecord('SBFEDelqLetterAvgAmt36M', le.SBFEDelqLetterAvgAmt36M)),
				1793 => ROW(createRecord('SBFEDelqLetterAvgAmt60M', le.SBFEDelqLetterAvgAmt60M)),
				1794 => ROW(createRecord('SBFEDelqLetterAvgAmt84M', le.SBFEDelqLetterAvgAmt84M)),
				1795 => ROW(createRecord('SBFEDelqLetterAvgAmtEver', le.SBFEDelqLetterAvgAmtEver)),
				1796 => ROW(createRecord('SBFEDelqOELineAvgAmt03M', le.SBFEDelqOELineAvgAmt03M)),
				1797 => ROW(createRecord('SBFEDelqOELineAvgAmt06M', le.SBFEDelqOELineAvgAmt06M)),
				1798 => ROW(createRecord('SBFEDelqOELineAvgAmt12M', le.SBFEDelqOELineAvgAmt12M)),
				1799 => ROW(createRecord('SBFEDelqOELineAvgAmt24M', le.SBFEDelqOELineAvgAmt24M)),
				1800 => ROW(createRecord('SBFEDelqOELineAvgAmt36M', le.SBFEDelqOELineAvgAmt36M)),
				1801 => ROW(createRecord('SBFEDelqOELineAvgAmt60M', le.SBFEDelqOELineAvgAmt60M)),
				1802 => ROW(createRecord('SBFEDelqOELineAvgAmt84M', le.SBFEDelqOELineAvgAmt84M)),
				1803 => ROW(createRecord('SBFEDelqOELineAvgAmtEver', le.SBFEDelqOELineAvgAmtEver)),
				1804 => ROW(createRecord('SBFEDelqOtherAvgAmt03M', le.SBFEDelqOtherAvgAmt03M)),
				1805 => ROW(createRecord('SBFEDelqOtherAvgAmt06M', le.SBFEDelqOtherAvgAmt06M)),
				1806 => ROW(createRecord('SBFEDelqOtherAvgAmt12M', le.SBFEDelqOtherAvgAmt12M)),
				1807 => ROW(createRecord('SBFEDelqOtherAvgAmt24M', le.SBFEDelqOtherAvgAmt24M)),
				1808 => ROW(createRecord('SBFEDelqOtherAvgAmt36M', le.SBFEDelqOtherAvgAmt36M)),
				1809 => ROW(createRecord('SBFEDelqOtherAvgAmt60M', le.SBFEDelqOtherAvgAmt60M)),
				1810 => ROW(createRecord('SBFEDelqOtherAvgAmt84M', le.SBFEDelqOtherAvgAmt84M)),
				1811 => ROW(createRecord('SBFEDelqOtherAvgAmtEver', le.SBFEDelqOtherAvgAmtEver)),
				1812 => ROW(createRecord('SBFEChargeoffCount', le.SBFEChargeoffCount)),
				1813 => ROW(createRecord('SBFEChargeoffLoanCount', le.SBFEChargeoffLoanCount)),
				1814 => ROW(createRecord('SBFEChargeoffLineCount', le.SBFEChargeoffLineCount)),
				1815 => ROW(createRecord('SBFEChargeoffCardCount', le.SBFEChargeoffCardCount)),
				1816 => ROW(createRecord('SBFEChargeoffLeaseCount', le.SBFEChargeoffLeaseCount)),
				1817 => ROW(createRecord('SBFEChargeoffLetterCount', le.SBFEChargeoffLetterCount)),
				1818 => ROW(createRecord('SBFEChargeoffOELineCount', le.SBFEChargeoffOELineCount)),
				1819 => ROW(createRecord('SBFEChargeoffOtherCount', le.SBFEChargeoffOtherCount)),
				1820 => ROW(createRecord('SBFEChargeoffAmt', le.SBFEChargeoffAmt)),
				1821 => ROW(createRecord('SBFEChargeoffLoanAmt', le.SBFEChargeoffLoanAmt)),
				1822 => ROW(createRecord('SBFEChargeoffLineAmt', le.SBFEChargeoffLineAmt)),
				1823 => ROW(createRecord('SBFEChargeoffCardAmt', le.SBFEChargeoffCardAmt)),
				1824 => ROW(createRecord('SBFEChargeoffLeaseAmt', le.SBFEChargeoffLeaseAmt)),
				1825 => ROW(createRecord('SBFEChargeoffLetterAmt', le.SBFEChargeoffLetterAmt)),
				1826 => ROW(createRecord('SBFEChargeoffOELineAmt', le.SBFEChargeoffOELineAmt)),
				1827 => ROW(createRecord('SBFEChargeoffOtherAmt', le.SBFEChargeoffOtherAmt)),
				1828 => ROW(createRecord('SBFETimeNewestChargeoff', le.SBFETimeNewestChargeoff)),
				1829 => ROW(createRecord('SBFEBalloonCount', le.SBFEBalloonCount)),
				1830 => ROW(createRecord('SBFEBalloonPaymentAmt', le.SBFEBalloonPaymentAmt)),
				1831 => ROW(createRecord('SBFEBalloonPaymentDueDate', le.SBFEBalloonPaymentDueDate)),
				1832 => ROW(createRecord('SBFELegalStructure', le.SBFELegalStructure)),
				1833 => ROW(createRecord('SBFESICCode', le.SBFESICCode)),
				1834 => ROW(createRecord('SBFENAICSCode', le.SBFENAICSCode)),
				1835 => ROW(createRecord('SBFEGovGuaranteeCount', le.SBFEGovGuaranteeCount)),
				1836 => ROW(createRecord('SBFEGuarantorAccountCount', le.SBFEGuarantorAccountCount)),
				1837 => ROW(createRecord('SBFEGuarantorMinCount', le.SBFEGuarantorMinCount)),
				1838 => ROW(createRecord('SBFEGuarantorMaxCount', le.SBFEGuarantorMaxCount)),
				1839 => ROW(createRecord('SBFEPrincipalAccountCount', le.SBFEPrincipalAccountCount)),
				1840 => ROW(createRecord('SBFEPrincipalMinCount', le.SBFEPrincipalMinCount)),
				1841 => ROW(createRecord('SBFEPrincipalMaxCount', le.SBFEPrincipalMaxCount)),
								ROW(createRecord('Invalid',	'Invalid')));
	END;
	
	NameValuePairsSBFE := NORMALIZE(SBA_Results, 1841, intoSBFE(LEFT, COUNTER));
	
	iesp.smallbusinessanalytics.t_SBAAttributesGroup SBFEVersion1(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
		SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR_NAME;
		SELF.Attributes := NameValuePairsSBFE;
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
		SELF.Result.AttributeGroups := IF((UNSIGNED)AttributesRequested(AttributeGroup[1..18] = LNSmallBusiness.Constants.SMALL_BIZ_ATTR)[1].AttributeGroup[19..] = 1, PROJECT(le, Version1(LEFT))) + 
																	 // IF((UNSIGNED)AttributesRequested(AttributeGroup[1..18] = 'SMALLBUSINESSATTRV')[1].AttributeGroup[19..] = 2, PROJECT(le, Version2(LEFT))) + // Including as an example of how to add multiple attribute groups since more than 1 can be requested at the same time
																	 IF((UNSIGNED)AttributesRequested(AttributeGroup[1..9] = LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR)[1].AttributeGroup[10..] = 1, PROJECT(le, SBFEVersion1(LEFT))) + // Including as an example of how to add multiple attribute groups since more than 1 can be requested at the same time
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
	OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log'));

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
	
	total_royalties := SBFE_royalties + Targus_royalties;
	
	OUTPUT(total_royalties, NAMED('RoyaltySet'));

	//Log to Deltabase
	Deltabase_Logging_prep := project(Final_Results, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																							 self.company_id := (Integer)CompanyID,
																							 self.login_id := _LoginID,
																							 self.product_id := Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_BIP_Service,
																							 self.function_name := FunctionName,
																							 self.esp_method := ESPMethod,
																							 self.interface_version := InterfaceVersion,
																							 self.delivery_method := DeliveryMethod,
																							 self.date_added := (STRING8)Std.Date.Today(),
																							 self.death_master_purpose := DeathMasterPurpose,
																							 self.ssn_mask := SSN_Mask,
																							 self.dob_mask := DOB_Mask,
																							 self.dl_mask := (String)(Integer)DL_Mask,
																							 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																							 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																							 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
																							 self.data_restriction_mask := DataRestrictionMask,
																							 self.data_permission_mask := DataPermissionMask,
																							 self.industry := Industry_Search[1].Industry,
																							 self.i_attributes_name := AttributesRequested[1].AttributeGroup,
																							 self.i_ssn := search.AuthorizedRep1.SSN,
																							 self.i_name_first := search.AuthorizedRep1.Name.First,
																							 self.i_name_last := search.AuthorizedRep1.Name.Last,
																							 self.i_lexid := (Integer)search.AuthorizedRep1.UniqueId, 
																							 self.i_address := If(trim(search.AuthorizedRep1.address.streetaddress1)!='', search.AuthorizedRep1.address.streetaddress1,
																																				 Address.Addr1FromComponents(search.AuthorizedRep1.address.streetnumber,
																																				 search.AuthorizedRep1.address.streetpredirection, search.AuthorizedRep1.address.streetname,
																																				 search.AuthorizedRep1.address.streetsuffix, search.AuthorizedRep1.address.streetpostdirection,
																																				 search.AuthorizedRep1.address.unitdesignation, search.AuthorizedRep1.address.unitnumber)),
																							 self.i_city := search.AuthorizedRep1.address.City,
																							 self.i_state := search.AuthorizedRep1.address.State,
																							 self.i_zip := search.AuthorizedRep1.address.Zip5,
																							 self.i_dl := search.AuthorizedRep1.DriverLicenseNumber,
																							 self.i_dl_state := search.AuthorizedRep1.DriverLicenseState,
																							 self.i_tin := search.Company.FEIN,
																							 self.i_name_first_2 := search.AuthorizedRep2.Name.First,
																							 self.i_name_last_2 := search.AuthorizedRep2.Name.Last,
																							 self.i_name_first_3 := search.AuthorizedRep3.Name.First,
																							 self.i_name_last_3 := search.AuthorizedRep3.Name.Last,
																							 self.i_bus_name := If(search.Company.CompanyName <> '', search.Company.CompanyName, search.Company.AlternateCompanyName),
																							 self.i_bus_address := If(trim(search.Company.address.streetaddress1)!='', search.Company.address.streetaddress1,
																																						 Address.Addr1FromComponents(search.Company.address.streetnumber,
																																						 search.Company.address.streetpredirection, search.Company.address.streetname,
																																						 search.Company.address.streetsuffix, search.Company.address.streetpostdirection,
																																						 search.Company.address.unitdesignation, search.Company.address.unitnumber)),
																							 self.i_bus_city := search.Company.address.City,
																							 self.i_bus_state := search.Company.address.State,
																							 self.i_bus_zip := search.Company.address.Zip5,
																							 self.i_model_name_1 := ModelsRequested[1].ModelName,
																							 self.i_model_name_2 := ModelsRequested[2].ModelName,
																							 self.o_score_1    := left.Result.Models[1].Scores[1].Value,
																							 self.o_reason_1_1 := left.Result.Models[1].Scores[1].ScoreReasons[1].ReasonCode,
																							 self.o_reason_1_2 := left.Result.Models[1].Scores[1].ScoreReasons[2].ReasonCode,
																							 self.o_reason_1_3 := left.Result.Models[1].Scores[1].ScoreReasons[3].ReasonCode,
																							 self.o_reason_1_4 := left.Result.Models[1].Scores[1].ScoreReasons[4].ReasonCode,
																							 self.o_reason_1_5 := left.Result.Models[1].Scores[1].ScoreReasons[5].ReasonCode,
																							 self.o_reason_1_6 := left.Result.Models[1].Scores[1].ScoreReasons[6].ReasonCode,
																							 self.o_score_2    := left.Result.Models[1].Scores[2].Value,
																							 self.o_reason_2_1 := left.Result.Models[1].Scores[2].ScoreReasons[1].ReasonCode,
																							 self.o_reason_2_2 := left.Result.Models[1].Scores[2].ScoreReasons[2].ReasonCode,
																							 self.o_reason_2_3 := left.Result.Models[1].Scores[2].ScoreReasons[3].ReasonCode,
																							 self.o_reason_2_4 := left.Result.Models[1].Scores[2].ScoreReasons[4].ReasonCode,
																							 self.o_reason_2_5 := left.Result.Models[1].Scores[2].ScoreReasons[5].ReasonCode,
																							 self.o_reason_2_6 := left.Result.Models[1].Scores[2].ScoreReasons[6].ReasonCode,
																							 self := left,
																							 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);
	
	//Improved Scout Logging
	IF(~DisableOutcomeTracking, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));	
	
	// DEBUGs:
	// OUTPUT( PhoneSources, NAMED('PhoneSources') );
	// OUTPUT( SBA_Results_Temp_with_PhoneSources, NAMED('IntLayoutWithPhones') );
	// OUTPUT( 'DPPA_Purpose: ' + DPPA_Purpose );
	// OUTPUT( 'GLBA_Purpose: ' + GLBA_Purpose );
	// OUTPUT( 'DataRestrictionMask: ' + DataRestrictionMask );
	// OUTPUT( 'DataPermissionMask: ' + DataPermissionMask );
	// OUTPUT( 'IndustryClass: ' + IndustryClass );
	
	RETURN OUTPUT(Final_Results, NAMED('Results'));
	#end
END;