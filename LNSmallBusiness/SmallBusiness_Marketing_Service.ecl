/*--SOAP--
<message name="SmallBusiness_Marketing_Service" wuTimeout="300000">
	<part name="SmallBusinessMarketingRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
  <!-- Option Fields --> 
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
  <part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="HistoryDate" type="xsd:integer"/>
  <part name="Watchlists_Requested" type="tns:XmlDataSet" cols="100" rows="8"/>
  <part name="OFAC_Version" type="xsd:integer"/>
  <part name="LinkSearchLevel" type="xsd:integer"/>
  <part name="AllowedSources" type="xsd:string"/>
  <part name="Global_Watchlist_Threshold" type="xsd:real"/>
</message>
*/
/*--INFO-- Small Business XML Service - This service returns Small Business Attributes and Scores */
/*--HELP--
<pre>
SmallBusinessMarketingRequest XML:
&lt;lnsmallbusiness.SmallBusiness_Marketing_ServiceRequest&gt;
&lt;SmallBusinessMarketingRequest&gt;
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
&lt;/SmallBusinessMarketingRequest&gt;
&lt;Watchlists_Requested&gt;
  &lt;Row&gt;&lt;/Row&gt;
&lt;/Watchlists_Requested&gt;
&lt;/lnsmallbusiness.SmallBusiness_Marketing_ServiceRequest&gt;
</pre>
*/

#option('expandSelectCreateRow', true);
#option('embeddedWarningsAsErrors', 0);

IMPORT Address, Business_Risk_BIP, Gateway, IESP, Risk_Reporting, UT, Models, Inquiry_AccLogs, STD, OFAC_XG5;

EXPORT SmallBusiness_Marketing_Service() := FUNCTION
	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'SmallBusinessMarketingRequest',
	'DPPAPurpose',
	'GLBPurpose',
	'DataRestrictionMask',
	'DataPermissionMask',
	'IndustryClass',
	'HistoryDateYYYYMM',
	'HistoryDate',
	'Watchlists_Requested',
	'OFAC_Version',
	'LinkSearchLevel',
	'AllowedSources',
	'Global_Watchlist_Threshold',
	'OutcomeTrackingOptOut'
	));
	
	//localized constants
	UNSIGNED1 NUMBER_OF_ATTRIBUTES := 200;
	
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

	requestIn := DATASET([], iesp.smallbusinessmarketingattributes.t_SmallBusinessMarketingRequest) : STORED('SmallBusinessMarketingRequest', FEW);
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
		Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_Marketing_Service);
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
	
	UNSIGNED6 SeleID := (INTEGER)search.Company.BusinessIDs.seleid;
	
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
	UNSIGNED1	MarketingMode        := 1;
	STRING50	AllowedSources       := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
	UNSIGNED1 OFAC_Version		     := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	REAL Global_Watchlist_Threshold	:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');
	DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Business_Risk_BIP.Constants.Default_Watchlists_Requested : STORED('Watchlists_Requested');
	BOOLEAN TestDataEnabled				 := users.TestDataEnabled;
	STRING32 TestDataTableName		 := users.TestDataTableName;
	BOOLEAN IncludeTargusGateway   := FALSE;
	BOOLEAN RunTargusGateway       := FALSE;

	IF( OFAC_Version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(Watchlists_Requested, value),
		FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );
	
	// SmallBusinessAttrV1 (etc) is a valid input
	AttributesRequested := PROJECT(option.AttributesVersionRequest, TRANSFORM(LNSmallBusiness.Layouts.AttributeGroupRec, SELF.AttributeGroup := StringLib.StringToUpperCase(LEFT.Value)));
	ModelsRequested := PROJECT(option.IncludeModels.Names, TRANSFORM(LNSmallBusiness.Layouts.ModelNameRec, SELF.ModelName := StringLib.StringToUpperCase(LEFT.Value)));
	ModelOptions := PROJECT(option.IncludeModels.ModelOptions, TRANSFORM(LNSmallBusiness.Layouts.ModelOptionsRec, SELF.OptionName := StringLib.StringToUpperCase(TRIM(LEFT.OptionName, LEFT, RIGHT));
																																																								SELF.OptionValue := LEFT.OptionValue));
	
	
	LNSmallBusiness.BIP_Layouts.Input intoInputLayout() := TRANSFORM
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
		
		SELF.SELEID := SeleID;
		
		SELF := [];
	END;

	Input := DATASET([intoInputLayout()]);
	
	/* *************************************
	 *            Validate Input:          *
   ***************************************/
	MinimumInputMetForOption1 := TRIM(Bus_Company_Name) <> '' AND TRIM(Bus_Street_Address1) <> '' AND TRIM(Bus_Zip) <> '';
	MinimumInputMetForOption2 := TRIM(Bus_Company_Name) <> '' AND TRIM(Bus_Street_Address1) <> '' AND TRIM(Bus_City) <> '' AND TRIM(Bus_State) <> '';
	MinimumInputMetForOption3 := SeleID != 0;
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

																		 
	IF((MinimumInputMetForOption1 = FALSE AND MinimumInputMetForOption2 = FALSE AND MinimumInputMetForOption3 = FALSE) OR // Minimum Business Inputs not met
		 ((MinimumInputMetForOption1 = TRUE OR MinimumInputMetForOption2 = TRUE OR MinimumInputMetForOption3 = TRUE) AND MinimumInputMetForAuthorizedRep = FALSE), // Minimum Business Inputs met, but minimum Authorized Rep Inputs not met
		FAIL('Please input the minimum required fields:\nOption 1: Company Name, Street Address, Zip\nOR\nOption 2: Company Name, Street Address, City, State\nOR\nOption 3:Business LexID (SELEID)'));
		
		
	//This will need to change if we want to search by anything other than SeleID (currently only coded for)	
	searchInputById := LNSmallBusiness.fn_search_business_ids(input, DPPA_Purpose, GLBA_Purpose, DataRestrictionMask, DataPermissionMask, LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.SELEID);
	

	/* ************************************************************************
	 *         Get the Small Business Attributes and Scores Results           *
	 ************************************************************************ */
	 SBA_Results_Temp_with_PhoneSources := LNSmallBusiness.SmallBusiness_BIP_Function(searchInputById,
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
																														/*Gateways*/,
																														AttributesRequested,
																														ModelsRequested,
																														ModelOptions,
																														DisableOutcomeTracking,
																														IncludeTargusGateway,
																														RunTargusGateway, /* for testing purposes only */
																														LNSmallBusiness.Constants.BIPID_WEIGHT_THRESHOLD.FOR_SmallBusiness_Marketing_Service
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
		
		NameValuePairsVersion1 := NORMALIZE(SBA_Results, NUMBER_OF_ATTRIBUTES, intoVersion1(LEFT, COUNTER));
		
		iesp.smallbusinessmarketingattributes.t_SBMAttributesGroup Version1(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
			SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_MKT_ATTR_V1_NAME;
			SELF.Attributes := NameValuePairsVersion1;
		END;

		// Create the final ESDL Layout
		iesp.smallbusinessmarketingattributes.t_SmallBusinessMarketingResponse intoESDL(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
			SELF.Result.HitOnBusinessInputName := IF(NameValuePairsVersion1[58].Value = '-1', '0', '1');//'0' if Attribute VerificationBusInputName has value '-1' else '1'
			SELF.Result.InputEcho := search; // Grab the exact input from the "search" ESDL near the top
			SELF.Result.BusinessID.PowID := le.PowID;
			SELF.Result.BusinessID.ProxID := le.ProxID;
			SELF.Result.BusinessID.SeleID := le.SeleID;
			SELF.Result.BusinessID.OrgID := le.OrgID;
			SELF.Result.BusinessID.UltID := le.UltID;
			SELF.Result.Models := PROJECT(le.ModelResults, TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMModelHRI, 
																		SELF.Name := LEFT.Name; 
																		SELF.Scores := PROJECT(le.ModelResults.Scores, TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMScoreHRI, 
																													SELF._Type := LEFT._Type,
																													SELF.Value := LEFT.Value,
																													SELF.ScoreReasons := PROJECT(choosen(le.ModelResults.Scores.ScoreReasons, iesp.constants.SBAnalytics.MaxHRICount),
                                                                                      TRANSFORM(iesp.smallbusinessmarketingattributes.t_SBMRiskIndicator,
																																											SELF.Sequence := LEFT.Sequence,
																																											SELF.ReasonCode := LEFT.ReasonCode,
																																											SELF.Description := LEFT.Description))))));
			

			//If the first 13 characters in dataset AttributesRequested = 'SMBUSMKTATTRV' grab the 14th character to see which version we will use (1/11/17 currently only 1 version)
			SELF.Result.AttributeGroups := IF((UNSIGNED)AttributesRequested(AttributeGroup[1..13] = LNSmallBusiness.Constants.SMALL_BIZ_MKT_ATTR)[1].AttributeGroup[14..] = 1, PROJECT(le, Version1(LEFT))) + 
																		 DATASET([], iesp.smallbusinessmarketingattributes.t_SBMAttributesGroup);																															
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

		//Log to Deltabase
		Deltabase_Logging_prep := project(Final_Results, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																										 self.company_id := (Integer)CompanyID,
																										 self.login_id := _LoginID,
																										 self.product_id := Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_Marketing_Service,
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
																										 //No models are available to the product yet
																										 //If any get added will need to add section here to log
                                                     self.o_lexid := SBA_Results[1].Rep_LexID,
                                                     self.o_seleid := left.Result.BusinessID.SeleID,
																										 self := left,
																										 self := [] ));
		Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
		// #stored('Deltabase_Log', Deltabase_Logging);

		//Improved Scout Logging
		IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
		
		// DEBUGs:
		//OUTPUT(Input, NAMED('Input'));
		// OUTPUT( SBA_Results_Temp_with_PhoneSources, NAMED('IntLayoutWithPhones') );
		// OUTPUT( 'DPPA_Purpose: ' + DPPA_Purpose );
		// OUTPUT( 'GLBA_Purpose: ' + GLBA_Purpose );
		// OUTPUT( 'DataRestrictionMask: ' + DataRestrictionMask );
		// OUTPUT( 'DataPermissionMask: ' + DataPermissionMask );
		// OUTPUT( 'IndustryClass: ' + IndustryClass );

		
		RETURN OUTPUT(Final_Results, NAMED('Results'));
	#end
	
END;