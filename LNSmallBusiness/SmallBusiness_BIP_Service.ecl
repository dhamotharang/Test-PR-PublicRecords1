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
IMPORT Address, Business_Risk_BIP, Cortera, Gateway, IESP, MDR, OFAC_XG5, Phones, Risk_Indicators, Risk_Reporting, RiskWise,
			 Royalty, Suspicious_Fraud_LN, UT, Royalty, Models, Inquiry_AccLogs, STD;

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
	#STORED('IndustryClass'      ,Business_Risk_BIP.Constants.Default_IndustryClass);
	#STORED('SSNMask'            ,Business_Risk_BIP.Constants.Default_SSNMask);
  
	requestIn := DATASET([], iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsRequest) : STORED('SmallBusinessAnalyticsRequest', FEW);
 firstRow  := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	search    := GLOBAL(firstRow.SearchBy);
	option    := GLOBAL(firstRow.Options);
	users     := GLOBAL(firstRow.User); 
	
  BOOLEAN CorteraRetrotest := FALSE : STORED('CorteraRetrotest');
 ds_CorteraRetrotestRecsRaw := DATASET([], Cortera.layout_Retrotest_raw) : STORED('CorteraRetrotestRecords', FEW);
 
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
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_BIP_Service);
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

	IF( OFAC_Version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(Watchlists_Requested, value),
		FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

	// SmallBusinessAttrV1 (etc) is a valid input
	AttributesRequested := PROJECT(option.AttributesVersionRequest, TRANSFORM(LNSmallBusiness.Layouts.AttributeGroupRec, SELF.AttributeGroup := StringLib.StringToUpperCase(LEFT.Value)));
	ModelsRequested := PROJECT(option.IncludeModels.Names, TRANSFORM(LNSmallBusiness.Layouts.ModelNameRec, SELF.ModelName := StringLib.StringToUpperCase(LEFT.Value)));
	ModelOptions := PROJECT(option.IncludeModels.ModelOptions, TRANSFORM(LNSmallBusiness.Layouts.ModelOptionsRec, SELF.OptionName := StringLib.StringToUpperCase(TRIM(LEFT.OptionName, LEFT, RIGHT));
																																																								SELF.OptionValue := LEFT.OptionValue));
	
	Gateways 											 := Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus

	emptyRecord := dataset([{1}], {unsigned a});
	
	LNSmallBusiness.BIP_Layouts.Input intoInputLayout(emptyRecord le) := TRANSFORM
		SELF.AcctNo := AcctNo;
  SELF.UltID := UltID;
  SELF.OrgID := OrgID;
  SELF.SeleID := SeleID;
  SELF.ProxID := ProxID;
  SELF.PowID := PowID;
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
	Input := PROJECT(dataset([{1}], {unsigned a}), intoInputLayout(LEFT));
	
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
                              AppendBestsFromLexIDs := SBA_20_Request
																														);

	SBA_Results_Temp := PROJECT( SBA_Results_Temp_with_PhoneSources, LNSmallBusiness.BIP_Layouts.IntermediateLayout );
	
	#if(Models.LIB_BusinessRisk_Models().TurnOnValidation) // If TRUE, output the model results directly
		
	RETURN OUTPUT(SBA_Results_Temp, NAMED('Results'));
	// RETURN OUTPUT(SBA_Results_Temp_with_PhoneSources, NAMED('Results')); //used for model validation 
		
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
  
  
	// Create SBFE Name/Value Pair Attributes
	NameValuePairsSBFE := NORMALIZE(SBA_Results, 1841, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoSBFE(LEFT, COUNTER));
	
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
																	 IF((UNSIGNED)AttributesRequested(AttributeGroup[1..18] = LNSmallBusiness.Constants.SMALL_BIZ_ATTR)[1].AttributeGroup[19..] = 101, PROJECT(le, Version101(LEFT))) +
																	 IF((UNSIGNED)AttributesRequested(AttributeGroup[1..18] = LNSmallBusiness.Constants.SMALL_BIZ_ATTR)[1].AttributeGroup[19..] = 2, PROJECT(le, Version2(LEFT))) +
																	 IF((UNSIGNED)AttributesRequested(AttributeGroup[1..9] = LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR)[1].AttributeGroup[10..] = 1, PROJECT(le, SBFEVersion1(LEFT))) +
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
	IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log')) );

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
	
	// ...and for Cortera:
	allow_SBA20_attrs := AttributesRequested(AttributeGroup[1..18] = LNSmallBusiness.Constants.SMALL_BIZ_ATTR)[1].AttributeGroup[19..] = '2';
	Cortera_royalties := IF( TestDataEnabled, Royalty.RoyaltyCortera.InHouse.GetNoRoyalties(), Royalty.RoyaltyCortera.InHouse.GetOnlineRoyalties(SBA_Results,allow_SBA20_attrs) );
 
	// Accumulate all Royalties: 
	total_royalties := SBFE_royalties + Targus_royalties + Cortera_royalties;
	
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
                                               self.glb := GLBA_Purpose,
                                               self.dppa := DPPA_Purpose,
																							 self.data_restriction_mask := DataRestrictionMask,
																							 self.data_permission_mask := DataPermissionMask,
																							 self.industry := Industry_Search[1].Industry,
																							 self.i_attributes_name := AttributesRequested[1].AttributeGroup,
																							 self.i_ssn := search.AuthorizedRep1.SSN,
                                               self.i_dob := Rep_1_DOB,
                                               self.i_name_full := search.AuthorizedRep1.Name.Full,
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
                                               self.i_home_phone := Rep_1_Phone10,
																							 self.i_tin := search.Company.FEIN,
																							 self.i_name_first_2 := search.AuthorizedRep2.Name.First,
																							 self.i_name_last_2 := search.AuthorizedRep2.Name.Last,
																							 self.i_name_first_3 := search.AuthorizedRep3.Name.First,
																							 self.i_name_last_3 := search.AuthorizedRep3.Name.Last,
																							 self.i_bus_name := search.Company.CompanyName,
                                               self.i_alt_bus_name := search.Company.AlternateCompanyName,
																							 self.i_bus_address := If(trim(search.Company.address.streetaddress1)!='', search.Company.address.streetaddress1,
																																						 Address.Addr1FromComponents(search.Company.address.streetnumber,
																																						 search.Company.address.streetpredirection, search.Company.address.streetname,
																																						 search.Company.address.streetsuffix, search.Company.address.streetpostdirection,
																																						 search.Company.address.unitdesignation, search.Company.address.unitnumber)),
																							 self.i_bus_city := search.Company.address.City,
																							 self.i_bus_state := search.Company.address.State,
																							 self.i_bus_zip := search.Company.address.Zip5,
                                               self.i_bus_phone := search.Company.Phone,
																							 self.i_model_name_1 := ModelsRequested[1].ModelName,
																							 self.i_model_name_2 := ModelsRequested[2].ModelName,
																							 self.o_score_1    := left.Result.Models[1].Scores[1].Value,
																							 self.o_reason_1_1 := left.Result.Models[1].Scores[1].ScoreReasons[1].ReasonCode,
																							 self.o_reason_1_2 := left.Result.Models[1].Scores[1].ScoreReasons[2].ReasonCode,
																							 self.o_reason_1_3 := left.Result.Models[1].Scores[1].ScoreReasons[3].ReasonCode,
																							 self.o_reason_1_4 := left.Result.Models[1].Scores[1].ScoreReasons[4].ReasonCode,
																							 self.o_reason_1_5 := left.Result.Models[1].Scores[1].ScoreReasons[5].ReasonCode,
																							 self.o_reason_1_6 := left.Result.Models[1].Scores[1].ScoreReasons[6].ReasonCode,
																							 self.o_score_2    := left.Result.Models[2].Scores[1].Value,
																							 self.o_reason_2_1 := left.Result.Models[2].Scores[1].ScoreReasons[1].ReasonCode,
																							 self.o_reason_2_2 := left.Result.Models[2].Scores[1].ScoreReasons[2].ReasonCode,
																							 self.o_reason_2_3 := left.Result.Models[2].Scores[1].ScoreReasons[3].ReasonCode,
																							 self.o_reason_2_4 := left.Result.Models[2].Scores[1].ScoreReasons[4].ReasonCode,
																							 self.o_reason_2_5 := left.Result.Models[2].Scores[1].ScoreReasons[5].ReasonCode,
																							 self.o_reason_2_6 := left.Result.Models[2].Scores[1].ScoreReasons[6].ReasonCode,
                                               self.o_lexid := SBA_Results[1].Rep_LexID,
                                               self.o_seleid := left.Result.BusinessID.SeleID,
																							 self := left,
																							 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);
	
	//Improved Scout Logging
	IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));	
	
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