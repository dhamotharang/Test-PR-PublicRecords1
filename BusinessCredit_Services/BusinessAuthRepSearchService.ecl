/*--SOAP--
<message name="BusinessAuthRepSearchService">

	<!-- XML REQUEST -->
	<part name="BusinessAuthRepSearchRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
	
</message>
*/

IMPORT Address, AutoStandardI, BIPV2, Doxie, iesp, lib_stringlib, TopBusiness_Services, WSInput;

EXPORT BusinessAuthRepSearchService := 
  MACRO
	 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	  //The following macro defines the field sequence on WsECL page of query.
		WSInput.MAC_BusinessCredit_Services_BusinessAuthRepSearchService();

    // Get XML input 
    rec_in    := iesp.BusinessAuthRepSearch.t_BusinessAuthRepSearchRequest;
    ds_in     := DATASET ([], rec_in) : STORED ('BusinessAuthRepSearchRequest', FEW);
    first_row := ds_in[1] : INDEPENDENT;

		iesp.ECL2ESP.SetInputBaseRequest (first_row);

    // Store main search criteria:
	  SearchBy := GLOBAL (first_row.SearchBy);
    Options  := GLOBAL (first_row.Options);

    // Constants for the Doxie.HeaderFileRollupService call
    #CONSTANT('DialRecordMatch',                5);
    #CONSTANT('GONG_SEARCHTYPE',               'PERSON');
    #CONSTANT('IncludeBusinessCredit',          TRUE);
    #CONSTANT('IncludeHRI',                     TRUE);
    #CONSTANT('UsingKeepSSNs',                  TRUE);
    // v-- Added for RQ-13563 to purposely force off the use of FDN keys
    #CONSTANT('IncludeFraudDefenseNetwork',     FALSE);

    STRING50 DLNumber_Value  := SearchBy.DLNumber : STORED('DLNumber');
    STRING2  DLState_Value   := SearchBy.DLState  : STORED('DLState');
    STRING   inAddress       := IF( SearchBy.GuarantorAddress.StreetAddress1 != '',
                                    SearchBy.GuarantorAddress.StreetAddress1,
                                    Address.Addr1FromComponents( SearchBy.GuarantorAddress.StreetNumber, 
                                                                 SearchBy.GuarantorAddress.StreetPreDirection, 
                                                                 SearchBy.GuarantorAddress.StreetName,
                                                                 SearchBy.GuarantorAddress.StreetSuffix,
                                                                 SearchBy.GuarantorAddress.StreetPostDirection, 
                                                                 SearchBy.GuarantorAddress.UnitDesignation,
                                                                 SearchBy.GuarantorAddress.UnitNumber ) );

    // needed because the Doxie.HeaderFileRollupService uses the global space not 
    // a passed interface
    #STORED('dl_number',          stringlib.stringtouppercase(DLNumber_Value));
    #STORED('DLState',            SearchBy.DLState);  
    #STORED('DOB',                iesp.ECL2ESP.t_DateToString8(SearchBy.DOB)); 
    #STORED('DID',                SearchBy.UniqueID);
    #STORED('Phone',              SearchBy.HomePhone);
    #STORED('SSN',                SearchBy.SSN);
    #STORED('FirstName',          SearchBy.GuarantorName.First);
    #STORED('MiddleName',         SearchBy.GuarantorName.Middle);
    #STORED('LastName',           SearchBy.GuarantorName.Last);
    #STORED('Addr',               inAddress);
    #STORED('City',               SearchBy.GuarantorAddress.City);
    #STORED('County',             SearchBy.GuarantorAddress.County);
    #STORED('State',              SearchBy.GuarantorAddress.State);
    #STORED('Zip',                SearchBy.GuarantorAddress.Zip5);
    #STORED('SeleId',             SearchBy.SeleId);

    // check to see if the address came in as StreetAddress1/2 or in the parts: prim range, prim name, etc
    STRING  BizSearchByAddress2 := IF( SearchBy.BusinessAddress.StreetAddress2 = '', 
                                       SearchBy.BusinessAddress.City + ', ' + SearchBy.BusinessAddress.State + ' ' + SearchBy.BusinessAddress.Zip5,
                                       SearchBy.BusinessAddress.StreetAddress2 );

    STRING  BizStreetAddress1 := SearchBy.BusinessAddress.StreetAddress1 : STORED('BusinessAddress1');
    STRING  BizStreetAddress2 := BizSearchByAddress2                     : STORED('BusinessAddress2');
    CleanBizAddress :=  Address.GetCleanAddress( BizStreetAddress1, 
                                                 BizStreetAddress2, 
                                                 address.Components.Country.US ).results; 

    STRING10  Phone           := SearchBy.HomePhone     : STORED('HomePhone');
    STRING10  BizPhone        := SearchBy.BusinessPhone : STORED('BusinessPhone');
    STRING120 BizName         := SearchBy.BusinessName  : STORED('BusinessName');
    STRING11  BizTIN          := SearchBy.TIN           : STORED('TIN');

    // need to use the clean address whenever available because top business uses the clean address and v_city, not p_city
    STRING    BizStreetNumber := IF(CleanBizAddress.prim_range = '', SearchBy.BusinessAddress.StreetNumber, CleanBizAddress.prim_range);
    STRING    BizStreetName   := IF(CleanBizAddress.prim_name  = '', SearchBy.BusinessAddress.StreetName,   CleanBizAddress.prim_name);
    STRING    BizSecRange     := IF(CleanBizAddress.sec_range  = '', SearchBy.BusinessAddress.UnitNumber,   CleanBizAddress.sec_range);
    STRING    BizCity         := IF(CleanBizAddress.v_city     = '', SearchBy.BusinessAddress.City,  CleanBizAddress.v_city);
    STRING    BizState        := IF(CleanBizAddress.state      = '', SearchBy.BusinessAddress.State, CleanBizAddress.state);
    STRING    BizZip          := IF(CleanBizAddress.zip        = '', SearchBy.BusinessAddress.Zip5,   CleanBizAddress.zip);

    doxie.MAC_Header_Field_Declare();
    global_mod := AutoStandardI.GlobalModule();

    // check Minimum Business Search Input requirements
    isValidBizSearch := 
      global_mod.SeleId != 0 OR
      ( BizName != '' AND  BizTIN != '') OR 
      ( BizName != '' AND  BizStreetName != '' AND BizZip != '' ) OR 
      ( BizName != '' AND  BizStreetName != '' AND BizCity != '' AND BizState != '');

    isEmptyPersonSearch :=
      global_mod.DID = '' AND global_mod.SSN = '' AND global_mod.LastName = '' AND 
      global_mod.FirstName = '' AND global_mod.MiddleName = '' AND global_mod.Addr = '' AND 
      global_mod.City  = '' AND global_mod.State = '' AND global_mod.zip = '' AND 
      global_mod.phone = '' AND global_mod.dob = 0 AND
      DLNumber_Value   = '' AND DLState_Value = '';
      
    isValidAuthRepSearch := 
      (isValidBizSearch AND isEmptyPersonSearch ) OR
      isValidBizSearch AND
      ( global_mod.DID != '' OR
      ( global_mod.LastName != '' AND global_mod.FirstName != '' AND global_mod.SSN != '' ) OR 
      ( global_mod.LastName != '' AND global_mod.FirstName != '' AND global_mod.Addr != '' AND global_mod.Zip != '' ) OR 
      ( global_mod.LastName != '' AND global_mod.FirstName != '' AND global_mod.Addr != '' AND global_mod.City != '' AND global_mod.State != ''));

    ta1_tempmod := 
      MODULE(doxie.HeaderFileRollupService_IParam.ta1_iparams);
        EXPORT BOOLEAN allow_date_seen    := FALSE;
        EXPORT BOOLEAN allow_wildcard     := FALSE;
        EXPORT INTEGER date_last_seen     := 0;
        EXPORT INTEGER date_first_seen    := 0;
        EXPORT STRING  DLNumber           := DLNumber_Value;
        EXPORT STRING  DLState            := DLState_Value;
        EXPORT STRING  pname              := pname_value;
        EXPORT BOOLEAN reduced_data       := 0;
      END;

    ta2_tempmod := 
      MODULE(PROJECT(global_mod, doxie.HeaderFileRollupService_IParam.ta2_iparams, OPT));
        EXPORT STRING32      application_type_val     := application_type_value;     // doxie.MAC_Header_Field_Declare();
        EXPORT BOOLEAN       Include_BusinessCredit   := TRUE;
        EXPORT BOOLEAN       Include_PhonesFeedback   := FALSE;
        EXPORT BOOLEAN       Include_AddressFeedback  := FALSE;
        EXPORT SET OF STRING Include_SourceList       := []; // keeping name in sync with IncludeSourceList in Doxie.HeaderSource_Service
        EXPORT BOOLEAN       Smart_Rollup             := FALSE;
      END;

    // ===================================================================================================================================
    // 
    //        BUSINESS SEARCH -- Calls: TopBusiness_Services.BusinessSearch
    //
    // ===================================================================================================================================

    BIPV2.IDFunctions.rec_SearchInput xfm_setBusinessSearchInput() := 
      TRANSFORM
         SELF.company_name     := BizName; 
         SELF.prim_range       := BizStreetNumber;
         SELF.prim_name        := BizStreetName;
         SELF.sec_range        := BizSecRange;
         SELF.city             := BizCity;
         SELF.state            := BizState;
         SELF.zip5             := BizZip;
         SELF.phone10          := BizPhone;
         SELF.fein             := BizTIN;
         SELF.Contact_fname    := global_mod.FirstName;
         SELF.Contact_mname    := global_mod.MiddleName;
         SELF.Contact_lname    := global_mod.LastName;
         SELF.zip_radius_miles := (UNSIGNED3) SearchBy.BusinessAddressRadius; 
         SELF.allow7DigitMatch := ~Options.StrictMatchBusinessPhone;
         SELF.contact_ssn      := global_mod.SSN;
         SELF.inSeleid         := SearchBy.SeleId;
         SELF.HSort            := FALSE;
         SELF                  := [];
       END;

    BusinessSearchInput := DATASET([xfm_setBusinessSearchInput()]);

    TopBusiness_Services.BusinessSearch_Layouts.OptionsLayout xfm_setBusinessSearchOptions() :=
      TRANSFORM
        SELF.lnbranded             := FALSE; 
	      SELF.internal_testing      := FALSE;
        SELF.IncludeBusinessCredit := TRUE;
      END;

    BusinessSearchOptions := ROW(xfm_setBusinessSearchOptions());  

    tempmod := MODULE(AutoStandardI.DataRestrictionI.params)  
      EXPORT BOOLEAN AllowAll           := FALSE;
      EXPORT BOOLEAN AllowDPPA          := FALSE;
      EXPORT BOOLEAN AllowGLB           := FALSE;
      EXPORT STRING DataRestrictionMask := global_mod.DataRestrictionMask;
      EXPORT UNSIGNED1 DPPAPurpose      := global_mod.DPPAPurpose;
      EXPORT UNSIGNED1 GLBPurpose       := global_mod.GLBPurpose;
      EXPORT BOOLEAN ignoreFares        := FALSE;
      EXPORT BOOLEAN ignoreFidelity     := FALSE;
      EXPORT BOOLEAN includeMinors      := FALSE;
    END;

    personRecs_raw := doxie.HeaderFileRollupService_Records.fn_get_personRecords ( ta1_tempmod, ta2_tempmod ); 
    personRecsFormatted := BusinessCredit_Services.Functions.fn_setPersonLayout( personRecs_raw );
    personRecs := IF( isValidAuthRepSearch AND NOT isEmptyPersonSearch,   
                      personRecsFormatted, 
                      DATASET([], iesp.businessauthrepsearch.t_BusinessAuthRepPersonSearchRecord) );

    BusinessRecs_Raw := TopBusiness_Services.BusinessSearch_Records.Search( BusinessSearchInput, 
                                                                            BusinessSearchOptions,
                                                                            tempmod ).recs;

    BusinessRecs := 
      PROJECT( BusinessRecs_Raw.Records, 
               TRANSFORM (iesp.businessauthrepsearch.t_BusinessAuthRepSearchRecord,
                          SELF := LEFT ));

    iesp.businessauthrepsearch.t_BusinessAuthRepSearchResponse  xfm_setFinalLayout() := 
      TRANSFORM
        SELF._Header := iesp.ECL2ESP.GetHeaderRow();
        SELF.BusinessRecordCount   := COUNT(BusinessRecs_Raw.Records);
        SELF.BusinessSearchRecords := BusinessRecs;
        SELF.PersonRecordCount     := COUNT(PersonRecs);
        SELF.PersonSearchRecords   := PersonRecs;
        SELF := [];
      END;

    RecsInFinalLayout := DATASET([xfm_setFinalLayout()]); 

    BizCredRecsOnlyCount       := COUNT(BusinessRecs_Raw.Records( BusinessCreditIndicator = BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BUSINESS_CREDIT_ONLY));
    ds_BizCredCountRoyalLayout := DATASET([{BizCredRecsOnlyCount}], {INTEGER SBFEAccountCount});
    ds_BizCredRecsRoyalties    := Royalty.RoyaltySBFE.GetOnlineRoyalties( ds_BizCredCountRoyalLayout );       
    ds_Royalties               := DATASET([], Royalty.Layouts.Royalty) + ds_BizCredRecsRoyalties;  

    IF ( NOT isValidBizSearch AND NOT isValidAuthRepSearch,
				 FAIL(301,doxie.ErrorCodes(301)),					
				 OUTPUT(RecsInFinalLayout,NAMED('Results'))
			 ); 

    IF( BizCredRecsOnlyCount > 0, OUTPUT(ds_Royalties, NAMED('RoyaltySet')));  

  ENDMACRO;  // Macro BusinessAuthRepSearchService