/*--SOAP--
<message name="headerFileRollupRequest">
  <part name="IndustryCLASS" type="xsd:string"/>
  <part name="SSN" type="xsd:string"/>
  <part name="SSNTypos" type="xsd:boolean"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="PhoneticDistanceMatch" type="xsd:boolean"/>
  <part name="DistanceThreshold" type="xsd:unsignedInt"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
	<part name="FuzzySecRange" type="xsd:integer"/>
  <part name="City" type="xsd:string"/>
  <part name="OtherCity1" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="OtherState1" type="xsd:string"/>
  <part name="OtherState2" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="CurrentResidentsOnly" type="xsd:boolean"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="AllowDateSeen" type="xsd:boolean"/>
  <part name="DateFirstSeen" type="xsd:integer"/>
  <part name="DateLastSeen" type="xsd:integer"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="Household" type="xsd:boolean"/> 
  <part name="LookupType" type="xsd:string"/>
  <part name="RID" type="xsd:string"/>
  <part name="IncludeAllDIDRecords" type="xsd:boolean"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType" type="xsd:string"/>
  <part name="NoLookupSearch" type="xsd:boolean"/>
  <part name="BestOnly" type="xsd:boolean"/>
	<part name="CurrentOnly" type="xsd:boolean"/>
  <part name="DoNotFillBlanks" type="xsd:boolean"/> 
  <part name="Raw" type="xsd:boolean"/> 
	<part name="GroupByDID" type="xsd:boolean"/> 
  <part name="DIDOnly" type="xsd:boolean"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="AddressLimit" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="IncludeZeroDIDRefs" type="xsd:boolean"/>
  <part name="IncludeHRI" type="xsd:boolean"/>
  <part name="MaxHriPer" type="xsd:unsignedInt"/> 
  <part name="ProbationOverride" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="KeepOldSsns" type="xsd:boolean"/>
	<part name="DialRecordMatch" type="xsd:unsignedInt"/>
	<part name="DialContactPrecision" type="xsd:unsignedInt"/>
	<part name="DialBounceDistance" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="DidTypeMask" type="xsd:string"/>
  <part name="AllowWildcard" type="xsd:boolean"/>
  <part name="AllowHeaderQuick" type="xsd:boolean"/>
	<part name="IncludeRelativeNames" type="xsd:boolean"/>
	<part name="IncludePhonesFeedback" type="xsd:boolean"/>
	<part name="IncludeAddressFeedback" type="xsd:boolean"/>
	<part name="NonExclusion" type="xsd:boolean"/>
	<part name="ReducedData" type="xsd:boolean"/>
	<part name="StrictMatch" type="xsd:boolean"/>
	<part name="IncludeAddressCDSDetails" type="xsd:boolean"/>
	<part name="IncludeDLInfo" type="xsd:boolean"/>
	<part name="IncludeNonDMVSources"	type="xsd:boolean"/>
	<part name="IncludePhonesPlus" type="xsd:boolean"/>
	<part name="IncludePeopleAtWork" type = "xsd:boolean"/>
	<part name="ReturnAlsoFound" type = "xsd:boolean"/> // utilize same name as in ESP
	<part name="ECL_NegateTrueDefaults" type = "xsd:boolean"/>
	<part name="IncludeBankruptcyCount" type = "xsd:boolean"/>
	<part name="BatchFriendly" type = "xsd:boolean"/>
  <part name="BatchAccount" type="xsd:string"/>
	<part name="DLNumber" type="xsd:string"/>
	<part name="DLState" type="xsd:string"/>
  <part name="SmartRollup" type = "xsd:boolean"/>
	<part name="IncludeSourceList" type="tns:EspStringArray"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
	<part name="IncludeCriminalImageIndicators" type="xsd:boolean"/>
	<part name="ExcludeDMVPII" type="xsd:boolean"/>
	<part name="IncludeExpandedPhonePlusSearch" type="xsd:boolean"/>
	<part name="IncludeHouseHoldOnly" type="xsd:boolean"/>
	<part name="IncludeLastResort" type="xsd:boolean"/>

	<!-- Business Credit (SBFE) only option/fields -->
  <part name="IncludeBusinessCredit" type="xsd:boolean"/>
  <part name="SeleId" type="xsd:unsignedInt"/>
  <part name="OrgId"  type="xsd:unsignedInt"/>
  <part name="UltId"  type="xsd:unsignedInt"/>

	<!-- FDN only option/fields -->
	<part name="IncludeFraudDefenseNetwork" type="xsd:boolean"/>
	<part name="GlobalCompanyId"				    type="xsd:unsignedInt"/>
	<part name="IndustryType"	    			    type="xsd:unsignedInt"/>
	<part name="ProductCode"		  		      type="xsd:unsignedInt"/>

	<!-- Progressive/waterfall Phone options -->
	<part name="IncludeProgessivePhone" type="xsd:boolean"/>
	<part name="ScoreModel" 						type="xsd:string"/>
  <part name="MaxNumAssociate"  			type="xsd:unsignedInt"/>
  <part name="MaxNumAssociateOther"  	type="xsd:unsignedInt"/>
  <part name="MaxNumFamilyOther"  		type="xsd:unsignedInt"/>
  <part name="MaxNumFamilyClose"  		type="xsd:unsignedInt"/>
  <part name="MaxNumParent"  					type="xsd:unsignedInt"/>
  <part name="MaxNumSpouse"  					type="xsd:unsignedInt"/>
  <part name="MaxNumSubject"  				type="xsd:unsignedInt"/>
  <part name="MaxNumNeighbor"  				type="xsd:unsignedInt"/>
	<part name="ReturnPhoneScore" 			type="xsd:boolean"/>
	<part name="IncludePhonesFeedback" 	type="xsd:boolean"/>

	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- This service searches the header file w/ Tsunami tweaks with results rolled up.*/

/*
<message name="headerFileRollupRequest" wuTimeout="300000">

*/

IMPORT Gong_Services,WSInput;
EXPORT HeaderFileRollupService := MACRO

		//The following macro defines the field sequence on WsECL page of query. 
		WSInput.MAC_HeaderFileRollupService();
		
    #CONSTANT('UsingKeepSSNs',TRUE);
    #CONSTANT('GONG_SEARCHTYPE','PERSON');

    STRING20  BatchAccount            := ''    : STORED('BatchAccount');
    BOOLEAN   BatchFriendly           := FALSE : STORED('BatchFriendly');
    STRING    DLNumber_Value          := ''    : STORED('DLNumber');
    STRING    DLState_Value           := ''    : STORED('DLState');
		BOOLEAN   IncProgessivePhone			:= FALSE : STORED('IncludeProgessivePhone');
    #STORED('dl_number',stringlib.stringtouppercase(DLNumber_Value));
        
    doxie.MAC_Header_Field_Declare();
    /*  The Business Credit (SBFE) project includes a person & business searches as well  
        as a wrapper service (BusinessCredit_Services.BusinessAuthRepSearch) which calls 
        both the person search (doxie.headerFileRollupService) and the business search 
        (TopBusiness_Services.BusinessSearch). Doxie.HFRS did not have a mechanism to 
        return the records. A change with the 3/8 release to prod moved the meat of the 
        existing service to a records attribute (doxie.HeaderFileRollupService_Records) 
        to allow for a direct call from the wrapper service to get retrieve the records.
    */
    
    // the call to the records attribute is done in two parts to allow for the various output to 
    // remain in tact and not break existing services.
    ta1_tempmod := 
      MODULE(doxie.HeaderFileRollupService_IParam.ta1_iparams);
        EXPORT BOOLEAN allow_date_seen    := allow_date_seen_value;
        EXPORT BOOLEAN allow_wildcard     := allow_wildcard_val;
        EXPORT INTEGER date_last_seen     := date_last_seen_value;
        EXPORT INTEGER date_first_seen    := date_first_seen_value;
        EXPORT STRING  DLNumber           := DLNumber_Value;
        EXPORT STRING  DLState            := DLState_Value;
        EXPORT STRING  pname              := pname_value;
        EXPORT BOOLEAN reduced_data       := reduced_data_value;
    END;

		// Set progressive phone params
		ProgPhone_mod := doxie.iParam.getProgressivePhoneParams();
		
    ta1_tmp := doxie.HeaderFileRollupService_Records.fn_get_ta1_temp(ta1_tempmod);

    ta1_tmp_results := ta1_tmp.Results;
    royalties := ta1_tmp.Royalty;
    householdAvailableCount := ta1_tmp.householdRecordsAvailable;
    
    global_mod := AutoStandardI.GlobalModule();
    ta2_tempmod := 
      MODULE(PROJECT(global_mod, doxie.HeaderFileRollupService_IParam.ta2_iparams, OPT));
        EXPORT STRING32      application_type_val     := application_type_value;     // doxie.MAC_Header_Field_Declare();
        EXPORT BOOLEAN       Include_BusinessCredit   := FALSE : STORED('IncludeBusinessCredit');
        EXPORT BOOLEAN       Include_PhonesFeedback   := FALSE : STORED('IncludePhonesFeedback');
        EXPORT BOOLEAN       Include_AddressFeedback  := FALSE : STORED('IncludeAddressFeedback');
				EXPORT SET OF STRING Include_SourceList       := []    : STORED('IncludeSourceList'); // keeping name in sync with IncludeSourceList in Doxie.HeaderSource_Service
        EXPORT BOOLEAN       Smart_Rollup             := FALSE : STORED('SmartRollup');
      END;

    ta2 := doxie.HeaderFileRollupService_Records.fn_get_ta2(ta1_tmp_results, ta2_tempmod);

	  ta_phones := doxie.HeaderFileRollupService_Records.get_progressive_phone(ta2,ProgPhone_mod);
		
		ta_final := IF(IncProgessivePhone,ta_phones,ta2);
		
    //create flat version specifically designed for batch
    ta1_batch := doxie.fn_flatten_rollup(ta_final, BatchAccount);
		
    OUTPUT(if (~BatchFriendly, ta_final),  NAMED('Results'));
    OUTPUT(if ( BatchFriendly, ta1_batch), NAMED('BatchResults'));
    OUTPUT(householdAvailableCount,        NAMED('HouseholdRecordsCount'));
    OUTPUT(royalties,                      NAMED('RoyaltySet'));

    // output the telecordia info any time a 10 digit phone is part of the search criteria
    OUTPUT(IF(~reduced_data_value, Gong_Services.Fetch_Telcordia_for_Gong_History), NAMED('TelcordiaRecs'));
ENDMACRO;
//HeaderFileRollupService()