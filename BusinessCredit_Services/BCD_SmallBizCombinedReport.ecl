/*--SOAP--
<message name="BCD_SmallBizCombinedReport" wuTimeout="300000">
	<part name="SmallBizCombinedReportRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
  <!-- Option Fields --> 
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="DOBMask" type="xsd:string"/>
	<part name="DLMask" type="xsd:boolean"/>
  <part name="ApplicationType" type="xsd:string"/>
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
  <part name="TestDataEnabled" type="xsd:boolean"/> 
  <part name="TestDataTableName" type="xsd:string"/> 
</message>
*/
/*--INFO-- BCD Small Business Combined Report Service - This service returns 
           combinations of the Small Business Scores and the SBFE 
           Credit Report for Capital One's Business Credit Disclosure (BCD) service*/

// #OPTION('expandSelectCreateRow', TRUE);
IMPORT Address, AutoStandardI, BIPV2, Business_Risk_BIP, BusinessCredit_Services, 
       Gateway, IESP, Inquiry_AccLogs, MDR, Phones, Risk_Reporting, Royalty, STD, 
       UT, WSInput;

// This service was created for Capital One who has requested a new service they 
// will have the ability to specialize to their specific needs. At the time of creating the 
// service it was replica of the LNSmallBusiness.SmallBusiness_BIP_Combined_Service, with only
// the top level records created for the new service. Subject to change depending upon the 
// changes requested by Capital One.
// Capital One has committed to 60,000 transactions per month by 2019. 
// For performance and the ability to quickly make unforeseeable major changes this new service
// shares all underlying code.

EXPORT BCD_SmallBizCombinedReport := 
  MACRO 
	#OPTION('embeddedWarningsAsErrors', 0);
	
  // #option ('optimizelevel', 0);  // NEVER RELEASE THIS LINE OF CODE TO PROD
                                    // this is for deploying to a 100-way as 
                                    // the service is large.
                                    // This service won't run on a 1-way.
    /* ************************************************************************
     * The following macro defines the field sequence on WsECL page of query. *
     ************************************************************************ */
    WSInput.MAC_BusinessCredit_Services_BCD_SmallBizCombinedReport();
      
    /* ************************************************************************
     *                          Grab service inputs                           *
     ************************************************************************ */
                                                                 
    requestIn := DATASET([], iesp.bcdsmallbusinesscombinedreport.t_BcdSmallBusinessCombinedReportRequest) : STORED('BcdSmallBusinessCombinedReportRequest', FEW);
    firstRow  := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
    search    := GLOBAL(firstRow.SearchBy);
    option    := GLOBAL(firstRow.Options);
    users     := GLOBAL(firstRow.User); 
    
    // Some of the top business code is using the global mod instead 
    // of using the interface module
    iesp.ECL2ESP.SetInputBaseRequest (firstRow);
    global_mod := AutoStandardI.GlobalModule();
		
		/* **********************************************
			 *  Fields needed for improved Scout Logging  *
			 **********************************************/
			STRING32 _LoginID               := ''	: STORED('_LoginID');
			outofbandCompanyID							:= '' : STORED('_CompanyID');
			STRING20 CompanyID              := IF(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
			STRING20 FunctionName           := '' : STORED('_LogFunctionName');
			STRING50 ESPMethod              := '' : STORED('_ESPMethodName');
			STRING10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
			STRING5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
			STRING5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
			outofbandssnmask                := '' : STORED('SSNMask');
			STRING10 SSN_Mask               := IF(users.SSNMask != '', users.SSNMask, outofbandssnmask);
			outofbanddobmask                := '' : STORED('DOBMask');
			STRING10 DOB_Mask               := IF(users.DOBMask != '', users.DOBMask, outofbanddobmask);
			BOOLEAN DL_Mask                 := users.DLMask;
			BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
			BOOLEAN ArchiveOptIn            := FALSE : STORED('instantidarchivingoptin');
			BOOLEAN DisableIntermediateShellLoggingOutOfBand := FALSE    : STORED('OutcomeTrackingOptOut');
			DisableOutcomeTracking  := DisableIntermediateShellLoggingOutOfBand OR users.OutcomeTrackingOptOut;

			//Look up the industry by the company ID.
			Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID AND s_product_id = (STRING)Risk_Reporting.ProductID.BusinessCredit_Services__BCD_SmallBizCombinedReport);
		/* ************* End Scout Fields **************/
   
    // Below we'll prefer users.DataRestrictionMask, users.DataPermissionMask, users.industryclass, etc., over
    // DataRestrictionMask_stored, DataPermissionMask_stored, etc., since they are "internal" or overridden values
    // populated for Development/QA purposes, etc.
    STRING120 Bus_Street_Address1 := IF(search.Company.Address.StreetAddress1 = '', 
                                        Address.Addr1FromComponents(search.Company.Address.StreetNumber, 
                                                                    search.Company.Address.StreetPreDirection, 
                                                                    search.Company.Address.StreetName, 
                                                                    search.Company.Address.StreetSuffix, 
                                                                    search.Company.Address.StreetPostDirection, 
                                                                    search.Company.Address.UnitDesignation, 
                                                                    search.Company.Address.UnitNumber),
                                        search.Company.Address.StreetAddress1);
    // Authorized Representative 1 Input Information
    STRING8   Rep_1_DOB := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep1.DOB);
    STRING120 Rep_1_Street_Address1 := IF(search.AuthorizedRep1.Address.StreetAddress1 = '', 
                                          Address.Addr1FromComponents(search.AuthorizedRep1.Address.StreetNumber, 
                                                                      search.AuthorizedRep1.Address.StreetPreDirection, 
                                                                      search.AuthorizedRep1.Address.StreetName, 
                                                                      search.AuthorizedRep1.Address.StreetSuffix, 
                                                                      search.AuthorizedRep1.Address.StreetPostDirection, 
                                                                      search.AuthorizedRep1.Address.UnitDesignation, 
                                                                      search.AuthorizedRep1.Address.UnitNumber),
                                          search.AuthorizedRep1.Address.StreetAddress1);
    // Authorized Representative 2 Input Information
    STRING8   Rep_2_DOB := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep2.DOB);
    STRING120 Rep_2_Street_Address1 := IF( search.AuthorizedRep2.Address.StreetAddress1 = '', 
                                           Address.Addr1FromComponents(search.AuthorizedRep2.Address.StreetNumber, 
                                                                       search.AuthorizedRep2.Address.StreetPreDirection, 
                                                                       search.AuthorizedRep2.Address.StreetName, 
                                                                       search.AuthorizedRep2.Address.StreetSuffix, 
                                                                       search.AuthorizedRep2.Address.StreetPostDirection, 
                                                                       search.AuthorizedRep2.Address.UnitDesignation, 
                                                                       search.AuthorizedRep2.Address.UnitNumber),
                                           search.AuthorizedRep2.Address.StreetAddress1 );
    // Authorized Representative 3 Input Information
    STRING8   Rep_3_DOB := iesp.ECL2ESP.t_DateToString8(search.AuthorizedRep3.DOB);
    STRING120 Rep_3_Street_Address1 := IF(search.AuthorizedRep3.Address.StreetAddress1 = '', 
                                          Address.Addr1FromComponents(search.AuthorizedRep3.Address.StreetNumber, 
                                                                      search.AuthorizedRep3.Address.StreetPreDirection, 
                                                                      search.AuthorizedRep3.Address.StreetName, 
                                                                      search.AuthorizedRep3.Address.StreetSuffix, 
                                                                      search.AuthorizedRep3.Address.StreetPostDirection, 
                                                                      search.AuthorizedRep3.Address.UnitDesignation, 
                                                                      search.AuthorizedRep3.Address.UnitNumber),
                                          search.AuthorizedRep3.Address.StreetAddress1);

    // Option Fields
    UNSIGNED3 HistoryDateYYYYMM		    := (INTEGER)Business_Risk_BIP.Constants.NinesDate     : STORED('HistoryDateYYYYMM');
    UNSIGNED6 HistoryDate             := (INTEGER)Business_Risk_BIP.Constants.NinesDateTime : STORED('HistoryDate');
    UNSIGNED1	Link_Search_Level       := Business_Risk_BIP.Constants.LinkSearch.Default     : STORED('LinkSearchLevel');
    UNSIGNED1	Marketing_Mode          := Business_Risk_BIP.Constants.Default_MarketingMode  : STORED('MarketingMode');
    STRING50	Allowed_Sources         := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
    UNSIGNED1 OFAC_Version_		        := Business_Risk_BIP.Constants.Default_OFAC_Version   : STORED('OFAC_Version');
    REAL Global_Watchlist_Threshold_	:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');
    BOOLEAN   TestData_Enabled			  := users.TestDataEnabled   : STORED('TestDataEnabled');
    STRING  	TestData_TableName	    := users.TestDataTableName : STORED('TestDataTableName');
    BOOLEAN   Include_TargusGateway   := FALSE : STORED('IncludeTargusGateway');
    BOOLEAN   Run_TargusGateway       := FALSE : STORED('RunTargusGatewayAnywayForTesting');
    DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested_ := Business_Risk_BIP.Constants.Default_Watchlists_Requested : STORED('Watchlists_Requested');

    /* ****************************************************************************
     *                        Prepare input Data                                  *
     ******************************************************************************/
     
    // SmallBusinessAttrV1 (etc) is a valid input
    // Attributes will not be part of Capital One's first cut of the service.
    Attributes_Requested := 
      PROJECT(option.AttributesVersionRequest, 
              TRANSFORM(LNSmallBusiness.Layouts.AttributeGroupRec, 
                         SELF.AttributeGroup := '')); //StringLib.StringToUpperCase(LEFT.Value)));
    Models_Requested := 
      PROJECT(option.IncludeModels.Names, 
              TRANSFORM(LNSmallBusiness.Layouts.ModelNameRec, 
                         SELF.ModelName := StringLib.StringToUpperCase(LEFT.Value)));
    Model_Options := 
      PROJECT(option.IncludeModels.ModelOptions, 
              TRANSFORM(LNSmallBusiness.Layouts.ModelOptionsRec, 
                         SELF.OptionName  := StringLib.StringToUpperCase(TRIM(LEFT.OptionName, LEFT, RIGHT));
                         SELF.OptionValue := LEFT.OptionValue));
    
    Gateways_ := Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus
    
    LNSmallBusiness.BIP_Layouts.Input xfm_intoSBA_InputLayout() := 
      TRANSFORM
        SELF.AcctNo                 := users.AccountNumber;
        SELF.HistoryDateYYYYMM      := HistoryDateYYYYMM;
        SELF.HistoryDate            := HistoryDate;
        SELF.Bus_Company_Name       := search.Company.CompanyName;
        SELF.Bus_Doing_Business_As  := search.Company.AlternateCompanyName;
        SELF.PowID                  := search.Company.BusinessIds.PowID;
        SELF.ProxID                 := search.Company.BusinessIds.ProxID;
        SELF.SeleID                 := search.Company.BusinessIds.SeleID;
        SELF.OrgID                  := search.Company.BusinessIds.OrgID;
        SELF.UltID                  := search.Company.BusinessIds.UltID;
        SELF.Bus_Street_Address1    := Bus_Street_Address1;
        SELF.Bus_Street_Address2    := search.Company.Address.StreetAddress2;
        SELF.Bus_City               := search.Company.Address.City;
        SELF.Bus_State              := search.Company.Address.State;
        SELF.Bus_Zip                := search.Company.Address.Zip5;
        SELF.Bus_FEIN               := (STRING9)search.Company.FEIN;
        SELF.Bus_Phone10            := (STRING10)search.Company.Phone;
        SELF.Bus_SIC_Code           := (STRING4)search.Company.SICCode;
        SELF.Bus_NAIC_Code          := (STRING6)search.Company.NAICCode;
        SELF.Bus_Structure          := search.Company.BusinessStructure;
        SELF.Bus_Years_in_Business  := search.Company.YearsInBusiness;
        SELF.Bus_Start_Date         := iesp.ECL2ESP.t_DateToString8(search.Company.BusinessStartDate);
        SELF.Bus_Yearly_Revenue     := (STRING10)search.Company.YearlyRevenue;
        SELF.Bus_Fax_Number         := (STRING10)search.Company.FaxNumber;
        SELF.Rep_1_LexID            := (UNSIGNED6)search.AuthorizedRep1.UniqueID;
        SELF.Rep_1_Full_Name        := search.AuthorizedRep1.Name.Full;
        SELF.Rep_1_First_Name       := search.AuthorizedRep1.Name.First;
        SELF.Rep_1_Middle_Name      := search.AuthorizedRep1.Name.Middle;
        SELF.Rep_1_Last_Name        := search.AuthorizedRep1.Name.Last;
        SELF.Rep_1_Former_Last_Name := search.AuthorizedRep1.FormerLastName;
        SELF.Rep_1_Suffix           := search.AuthorizedRep1.Name.Suffix;
        SELF.Rep_1_DOB              := Rep_1_DOB;
        SELF.Rep_1_SSN              := (STRING9)search.AuthorizedRep1.SSN;
        SELF.Rep_1_Street_Address1  := Rep_1_Street_Address1;
        SELF.Rep_1_Street_Address2  := search.AuthorizedRep1.Address.StreetAddress2;
        SELF.Rep_1_City             := search.AuthorizedRep1.Address.City;
        SELF.Rep_1_State            := search.AuthorizedRep1.Address.State;
        SELF.Rep_1_Zip              := search.AuthorizedRep1.Address.Zip5;
        SELF.Rep_1_Phone10          := search.AuthorizedRep1.Phone;
        SELF.Rep_1_Age              := search.AuthorizedRep1.Age;
        SELF.Rep_1_DL_Number        := (STRING25)search.AuthorizedRep1.DriverLicenseNumber;
        SELF.Rep_1_DL_State         := search.AuthorizedRep1.DriverLicenseState;
        SELF.Rep_1_Business_Title   := search.AuthorizedRep1.BusinessTitle;
        SELF.Rep_2_LexID            := (UNSIGNED6)search.AuthorizedRep2.UniqueID;
        SELF.Rep_2_Full_Name        := search.AuthorizedRep2.Name.Full;
        SELF.Rep_2_First_Name       := search.AuthorizedRep2.Name.First;
        SELF.Rep_2_Middle_Name      := search.AuthorizedRep2.Name.Middle;
        SELF.Rep_2_Last_Name        := search.AuthorizedRep2.Name.Last;
        SELF.Rep_2_Former_Last_Name := search.AuthorizedRep2.FormerLastName;
        SELF.Rep_2_Suffix           := search.AuthorizedRep2.Name.Suffix;
        SELF.Rep_2_DOB              := Rep_2_DOB;
        SELF.Rep_2_SSN              := (STRING9)search.AuthorizedRep2.SSN;
        SELF.Rep_2_Street_Address1  := Rep_2_Street_Address1;
        SELF.Rep_2_Street_Address2  := search.AuthorizedRep2.Address.StreetAddress2;
        SELF.Rep_2_City             := search.AuthorizedRep2.Address.City;
        SELF.Rep_2_State            := search.AuthorizedRep2.Address.State;
        SELF.Rep_2_Zip              := search.AuthorizedRep2.Address.Zip5;
        SELF.Rep_2_Phone10          := search.AuthorizedRep2.Phone;
        SELF.Rep_2_Age              := search.AuthorizedRep2.Age;
        SELF.Rep_2_DL_Number        := (STRING25)search.AuthorizedRep2.DriverLicenseNumber;
        SELF.Rep_2_DL_State         := search.AuthorizedRep2.DriverLicenseState;
        SELF.Rep_2_Business_Title   := search.AuthorizedRep2.BusinessTitle;
        SELF.Rep_3_LexID            := (UNSIGNED6)search.AuthorizedRep3.UniqueID;
        SELF.Rep_3_Full_Name        := search.AuthorizedRep3.Name.Full;
        SELF.Rep_3_First_Name       := search.AuthorizedRep3.Name.First;
        SELF.Rep_3_Middle_Name      := search.AuthorizedRep3.Name.Middle;
        SELF.Rep_3_Last_Name        := search.AuthorizedRep3.Name.Last;
        SELF.Rep_3_Former_Last_Name := search.AuthorizedRep3.FormerLastName;
        SELF.Rep_3_Suffix           := search.AuthorizedRep3.Name.Suffix;
        SELF.Rep_3_DOB              := Rep_3_DOB;
        SELF.Rep_3_SSN              := (STRING9)search.AuthorizedRep3.SSN;
        SELF.Rep_3_Street_Address1  := Rep_3_Street_Address1;
        SELF.Rep_3_Street_Address2  := search.AuthorizedRep3.Address.StreetAddress2;
        SELF.Rep_3_City             := search.AuthorizedRep3.Address.City;
        SELF.Rep_3_State            := search.AuthorizedRep3.Address.State;
        SELF.Rep_3_Zip              := search.AuthorizedRep3.Address.Zip5;
        SELF.Rep_3_Phone10          := search.AuthorizedRep3.Phone;
        SELF.Rep_3_Age              := search.AuthorizedRep3.Age;
        SELF.Rep_3_DL_Number        := (STRING25)search.AuthorizedRep3.DriverLicenseNumber;
        SELF.Rep_3_DL_State         := (STRING25)search.AuthorizedRep3.DriverLicenseState;
        SELF.Rep_3_Business_Title   := search.AuthorizedRep3.BusinessTitle;
        SELF                        := [];
      END;
    SBA_Input := DATASET([xfm_intoSBA_InputLayout()]);


    /* ****************************************************************************
     *         Validate minimum SBA Combined Service Input:                       *
     ******************************************************************************/
     
    MinimumInputMetForOption1 := search.Company.CompanyName != '' AND Bus_Street_Address1 != '' AND search.Company.Address.Zip5 != '';
    MinimumInputMetForOption2 := search.Company.CompanyName != '' AND Bus_Street_Address1 != '' AND search.Company.Address.City != '' AND search.Company.Address.State != '';
    MinimumInputMetForOption3 := search.Company.BusinessIds.seleID != 0;
    
    MinimumInputMetForAuthorizedRepPopulated := LNSmallBusiness.fn_isSmallBiz_Combined_MinAuthRepInput_Met( search.AuthorizedRep1,
                                                                                                            search.AuthorizedRep2,
                                                                                                            search.AuthorizedRep3 );
    // Authorized Rep information is not required on input, 
    // however if any information is provided: 
    // at a MINIMUM First and Last Name PLUS one of the following MUST also be populated
    //   - Auth Rep, Street Address and Zip
    //   - Auth Rep SSN
    //   - Auth Rep Street Address, City and State
    AuthorizedRepNotPopulated := search.AuthorizedRep1.Name.Full = '' AND search.AuthorizedRep1.Name.First = '' AND search.AuthorizedRep1.Name.Last = '' AND
                                 search.AuthorizedRep2.Name.Full = '' AND search.AuthorizedRep2.Name.First = '' AND search.AuthorizedRep2.Name.Last = '' AND
                                 search.AuthorizedRep3.Name.Full = '' AND search.AuthorizedRep3.Name.First = '' AND search.AuthorizedRep3.Name.Last = '' AND
                                 search.AuthorizedRep1.SSN = '' AND Rep_1_DOB = '' AND Rep_1_Street_Address1 = '' AND search.AuthorizedRep1.Address.City = '' AND search.AuthorizedRep1.Address.State = '' AND search.AuthorizedRep1.Address.Zip5 = '' AND search.AuthorizedRep1.Phone = '' AND (STRING25)search.AuthorizedRep1.DriverLicenseNumber = '' AND
                                 search.AuthorizedRep2.SSN = '' AND Rep_2_DOB = '' AND Rep_2_Street_Address1 = '' AND search.AuthorizedRep2.Address.City = '' AND search.AuthorizedRep2.Address.State = '' AND search.AuthorizedRep2.Address.Zip5 = '' AND search.AuthorizedRep2.Phone = '' AND (STRING25)search.AuthorizedRep2.DriverLicenseNumber = '' AND
                                 search.AuthorizedRep3.SSN = '' AND Rep_3_DOB = '' AND Rep_3_Street_Address1 = '' AND search.AuthorizedRep3.Address.City = '' AND search.AuthorizedRep3.Address.State = '' AND search.AuthorizedRep3.Address.Zip5 = '' AND search.AuthorizedRep3.Phone = '' AND (STRING25)search.AuthorizedRep3.DriverLicenseNumber = '' ;

    AuthorizedRepValidOrBlank := MinimumInputMetForAuthorizedRepPopulated OR AuthorizedRepNotPopulated;
    
    IF((MinimumInputMetForOption1 = FALSE AND MinimumInputMetForOption2 = FALSE AND MinimumInputMetForOption3 = FALSE) OR // Minimum Business Inputs not met
       ((MinimumInputMetForOption1 OR MinimumInputMetForOption2 OR MinimumInputMetForOption3 ) AND AuthorizedRepValidOrBlank = FALSE), // Minimum Business Inputs met, but minimum Authorized Rep Inputs not met
      FAIL('Please input the minimum required fields:\nOption 1: Company Name, Street Address, Zip\nOR\nOption 2: Company Name, Street Address, City, State. \n If Authorized Rep data is entered: The First and Last name must be entered plus one of the following: \n1) SSN \n2) Street Address and zip \n3) Street Address, City and State.'));
	 /* ************************************************************************
	  *                 Create Input module                                    *
	  **************************************************************************/
    
   SmallBizCombined_inmod := 
     MODULE (PROJECT(global_mod ,LNSmallBusiness.IParam.LNSmallBiz_BIP_CombinedReport_IParams, OPT));
       EXPORT DATASET(LNSmallBusiness.BIP_Layouts.Input) ds_SBA_Input := SBA_Input;
       EXPORT UNSIGNED1 DPPAPurpose         := global_mod.DPPApurpose; 
       EXPORT UNSIGNED1 GLBAPurpose         := global_mod.GLBPurpose;
       EXPORT STRING    DataRestrictionMask := global_mod.DataRestrictionMask;
       EXPORT STRING    DataPermissionMask	:= global_mod.DataPermissionMask;
       EXPORT STRING5 	IndustryClass				:= global_mod.IndustryClass;
       EXPORT BOOLEAN   allowall            := global_mod.allowall;
       EXPORT BOOLEAN   allowdppa           := global_mod.allowdppa;
       EXPORT BOOLEAN   allowglb            := global_mod.allowglb;
       EXPORT UNSIGNED1 glbpurpose          := global_mod.GLBPurpose;
       EXPORT BOOLEAN   ignorefares         := global_mod.ignorefares;
       EXPORT BOOLEAN   ignorefidelity      := global_mod.ignorefidelity;
       EXPORT BOOLEAN   includeminors       := global_mod.includeminors;
       EXPORT BOOLEAN   lnbranded           := global_mod.lnbranded;
       EXPORT UNSIGNED1	LinkSearchLevel			:= Link_Search_Level;
       EXPORT UNSIGNED1	MarketingMode				:= Marketing_Mode;
       EXPORT STRING50	AllowedSources			:= Allowed_Sources;
       EXPORT UNSIGNED1	OFAC_Version				:= OFAC_Version_;
       EXPORT REAL			Global_Watchlist_Threshold      := Global_Watchlist_Threshold_;
       EXPORT BOOLEAN   DisableIntermediateShellLogging := DisableOutcomeTracking;
       EXPORT BOOLEAN   IncludeTargusGateway            := Include_TargusGateway;
       EXPORT BOOLEAN   RunTargusGateway                := Run_TargusGateway;
       EXPORT BOOLEAN   TestDataEnabled			            := TestData_Enabled;
	     EXPORT STRING    TestDataTableName	              := TestData_TableName;
       EXPORT STRING6   DOBMask                         := global_mod.DOBMask;
       EXPORT STRING32  ApplicationType                 := global_mod.ApplicationType;
       EXPORT STRING1   FetchLevel 					            := BIPV2.IDconstants.Fetch_Level_SELEID;
       EXPORT BOOLEAN   IncludeCreditReport             := option.IncludeCreditReport;  
       EXPORT BOOLEAN   MinInputMetForAuthRepPopulated  := MinimumInputMetForAuthorizedRepPopulated;
       EXPORT DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Watchlists_Requested_;
       EXPORT DATASET(Gateway.Layouts.Config) Gateways  := Gateways_;
       EXPORT DATASET(LNSmallBusiness.Layouts.AttributeGroupRec) AttributesRequested := Attributes_Requested;
       EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) ModelsRequested := Models_Requested;
       EXPORT DATASET(LNSmallBusiness.Layouts.ModelOptionsRec) ModelOptions := Model_Options;
			 EXPORT BOOLEAN   UseInputDataAsIs                := TRUE;
      END;
    
  ds_Results_withSmBizSBFEroyalty := LNSmallBusiness.SmallBusiness_BIP_Combined_Service_Records(SmallBizCombined_inmod);
  ds_Results := 
    PROJECT(ds_Results_withSmBizSBFEroyalty,
      TRANSFORM(iesp.bcdsmallbusinesscombinedreport.t_BcdSmallBusinessCombinedReportResponse, 
        SELF.InputEcho := search; // Grab the exact input from the "search" ESDL near the top
        SELF           := LEFT;
      ));

   /* ************************************************************************
    *                  Calculate Royalties                                   *
    **************************************************************************
    *                    SBFE Royalties                                      *
    **************************************************************************/   
    // determine if there are any SBFE data returned in the LN Small Biz Analytics or Credit Report
	  SBFE_RoyalCount := IF(ds_Results[1].CreditReportRecords[1].BestInformation.BusinessCreditIndicator = BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BUSINESS_CREDIT_ONLY OR 
                          ds_Results[1].CreditReportRecords[1].BestInformation.BusinessCreditIndicator = BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BOTH OR
                          ds_Results_withSmBizSBFEroyalty[1].SmallBiz_SBFE_Royalty, 1, 0);
                          
    ds_SBFE_CountRoyalLayout := DATASET([{SBFE_RoyalCount}], {INTEGER SBFEAccountCount});                                           
    ds_combinedSBFE_royalties := IF( TestData_Enabled, Royalty.RoyaltySBFE.GetNoRoyalties(), Royalty.RoyaltySBFE.GetOnlineRoyalties(ds_SBFE_CountRoyalLayout) );

   /* ************************************************************************
    *                    Targus Royalties                                    *
    **************************************************************************/
    // Determine if there is any Targus data returned
    Targus_hit := COUNT(ds_Results[1].CreditReportRecords[1].PhoneSources(source = MDR.sourceTools.src_Targus_Gateway)) > 0;
    TargusType := IF( Targus_hit, Phones.Constants.TargusType.WirelessConnectionSearch + Phones.Constants.TargusType.PhoneDataExpress, '' );
    Targus_PhoneSource  := ds_Results[1].CreditReportRecords[1].PhoneSources(source = MDR.sourceTools.src_Targus_Gateway);
    ds_Targus_royalties := Royalty.RoyaltyTargus.GetOnlineRoyalties(Targus_PhoneSource, source, TargusType, TRUE, TRUE, FALSE, FALSE);

   /* ************************************************************************
    *                    Cortera Royalties                                    *
    **************************************************************************/
    ds_Cortera_royalties := IF( TestData_Enabled, Royalty.RoyaltyCortera.InHouse.GetNoRoyalties(), Royalty.RoyaltyCortera.InHouse.GetCombinedServiceRoyalties(ds_Results) );
    
    // Combine Royalties  
    ds_Royalties := DATASET([], Royalty.Layouts.Royalty) + 
                    ds_combinedSBFE_royalties + 
                    ds_Targus_royalties +
                    ds_Cortera_royalties;
    
		//Log to Deltabase
		Deltabase_Logging_prep := PROJECT(ds_Results, TRANSFORM(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																										 SELF.company_id := (INTEGER)CompanyID,
																										 SELF.login_id := _LoginID,
																										 SELF.product_id := Risk_Reporting.ProductID.BusinessCredit_Services__BCD_SmallBizCombinedReport,
																										 SELF.function_name := FunctionName,
																										 SELF.esp_method := ESPMethod,
																										 SELF.interface_version := InterfaceVersion,
																										 SELF.delivery_method := DeliveryMethod,
																										 SELF.date_added := (STRING8)Std.Date.Today(),
																										 SELF.death_master_purpose := DeathMasterPurpose,
																										 SELF.ssn_mask := SSN_Mask,
																										 SELF.dob_mask := DOB_Mask,
																										 SELF.dl_mask := (STRING)(INTEGER)DL_Mask,
																										 SELF.exclude_dmv_pii := (STRING)(INTEGER)ExcludeDMVPII,
																										 SELF.scout_opt_out := (STRING)(INTEGER)DisableOutcomeTracking,
																										 SELF.archive_opt_in := (STRING)(INTEGER)ArchiveOptIn,
                                                     SELF.glb := SmallBizCombined_inmod.GLBAPurpose,
                                                     SELF.dppa := SmallBizCombined_inmod.DPPAPurpose,
																										 SELF.data_restriction_mask := users.DataRestrictionMask,
																										 SELF.data_permission_mask := users.DataPermissionMask,
																										 SELF.industry := Industry_Search[1].Industry,
																										 SELF.i_attributes_name := Attributes_Requested[1].AttributeGroup,
																										 SELF.i_ssn := search.AuthorizedRep1.SSN,
                                                     SELF.i_dob := Rep_1_DOB,
                                                     SELF.i_name_full := search.AuthorizedRep1.Name.Full,
																										 SELF.i_name_first := search.AuthorizedRep1.Name.First,
																										 SELF.i_name_last := search.AuthorizedRep1.Name.Last,
																										 SELF.i_lexid := (INTEGER)search.AuthorizedRep1.UniqueId,
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
                                                     SELF.i_home_phone := search.AuthorizedRep1.Phone,
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
																										 model_count := COUNT(Models_Requested);
																										 SELF.i_model_name_1 := Models_Requested[1].ModelName,
																										 //Check to see if there was more than one model requested
																										 extra_score := model_count > 1;
																										 SELF.i_model_name_2 := IF(extra_score, Models_Requested[2].ModelName, ''),
																										 SELF.o_score_1    := (INTEGER)LEFT.SmallBusinessAnalyticsResults.Models[1].Scores[1].Value,
																										 SELF.o_reason_1_1 := LEFT.SmallBusinessAnalyticsResults.Models[1].Scores[1].ScoreReasons[1].ReasonCode,
																										 SELF.o_reason_1_2 := LEFT.SmallBusinessAnalyticsResults.Models[1].Scores[1].ScoreReasons[2].ReasonCode,
																										 SELF.o_reason_1_3 := LEFT.SmallBusinessAnalyticsResults.Models[1].Scores[1].ScoreReasons[3].ReasonCode,
																										 SELF.o_reason_1_4 := LEFT.SmallBusinessAnalyticsResults.Models[1].Scores[1].ScoreReasons[4].ReasonCode,
																										 SELF.o_reason_1_5 := LEFT.SmallBusinessAnalyticsResults.Models[1].Scores[1].ScoreReasons[5].ReasonCode,
																										 SELF.o_reason_1_6 := LEFT.SmallBusinessAnalyticsResults.Models[1].Scores[1].ScoreReasons[6].ReasonCode,
																										 SELF.o_score_2    := IF(extra_score, (INTEGER)LEFT.SmallBusinessAnalyticsResults.Models[2].Scores[1].Value, 0),
																										 SELF.o_reason_2_1 := IF(extra_score, LEFT.SmallBusinessAnalyticsResults.Models[2].Scores[1].ScoreReasons[1].ReasonCode, ''),
																										 SELF.o_reason_2_2 := IF(extra_score, LEFT.SmallBusinessAnalyticsResults.Models[2].Scores[1].ScoreReasons[2].ReasonCode, ''),
																										 SELF.o_reason_2_3 := IF(extra_score, LEFT.SmallBusinessAnalyticsResults.Models[2].Scores[1].ScoreReasons[3].ReasonCode, ''),
																										 SELF.o_reason_2_4 := IF(extra_score, LEFT.SmallBusinessAnalyticsResults.Models[2].Scores[1].ScoreReasons[4].ReasonCode, ''),
																										 SELF.o_reason_2_5 := IF(extra_score, LEFT.SmallBusinessAnalyticsResults.Models[2].Scores[1].ScoreReasons[5].ReasonCode, ''),
																										 SELF.o_reason_2_6 := IF(extra_score, LEFT.SmallBusinessAnalyticsResults.Models[2].Scores[1].ScoreReasons[6].ReasonCode, ''),
																										 SELF.o_lexid := ds_Results_withSmBizSBFEroyalty[1].Rep_LexID,
                                                     SELF.o_seleid := LEFT.SmallBusinessAnalyticsResults.BusinessIds.SeleID,
                                                     SELF := LEFT,
																										 SELF := [] ));
		Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
		// #stored('Deltabase_Log', Deltabase_Logging);

		//Improved Scout Logging
		IF(~DisableOutcomeTracking and ~TestData_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
		
    // OUTPUT(SmallBizCombined_inmod);   
    // OUTPUT(DPPAPurpose_stored, NAMED('DPPAPurpose_stored'));
    // OUTPUT(GLBPurpose_stored, NAMED('GLBPurpose_stored'));
    // OUTPUT(DataRestrictionMask_stored, NAMED('DataRestrictionMask_stored'));
    // OUTPUT(DataPermissionMask_stored, NAMED('DataPermissionMask_stored'));
    // OUTPUT(IndustryClass_stored, NAMED('IndustryClass_stored'));
    // OUTPUT(SBA_Input, NAMED('SBA_Input'));
    // OUTPUT(ds_Results.CreditReportRecords[1].PhoneSources, NAMED('Cred_Rpt_PhoneSources'));
    // OUTPUT(ds_Results.CreditReportRecords[1].TopBusinessRecord, NAMED('TopBiz'));
    // OUTPUT(ds_Results.CreditReportRecords[1].TopBusinessRecord.MotorVehicleSection,   NAMED('MotorVehicleSection'));
    // OUTPUT(ds_Results.CreditReportRecords[1].TopBusinessRecord.AircraftSection,     NAMED('AircraftSection'));
    // OUTPUT(ds_Results.CreditReportRecords[1].AdditionalInfo.CompanyNameVariations,  NAMED('CompanyNameVariations'));

    OUTPUT(ds_Results,   NAMED('Results')); 
    OUTPUT(ds_Royalties, NAMED('ds_Royalties'));
    
ENDMACRO;