/*--SOAP--
<message name="BeneficiaryRiskScore_Service">
	<!-- Record-level or SearchBy fields --> 
	<part name="UniqueClientID"            type="xsd:string" comment="i.e. acctno"/> <!-- required -->
	<part name="DID"                       type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="FullName"                  type="xsd:string"/>                          <!-- required if customer does not provided the parsed name -->
	<part name="FirstName"                 type="xsd:string"/>                          <!-- required -->
	<part name="MiddleName"                type="xsd:string"/>                          <!-- optional -->
	<part name="LastName"                  type="xsd:string"/>                          <!-- required -->
	<part name="NameSuffix"                type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="StreetAddress1"            type="xsd:string"/>                          <!-- required -->
	<part name="StreetAddress2"            type="xsd:string"/>                          <!-- optional -->
	<part name="City"                      type="xsd:string"/>                          <!-- city optional if Zip code is provided on input -->
	<part name="State"                     type="xsd:string"/>                          <!-- state optional if Zip code is provided on input -->
	<part name="Zip5"                      type="xsd:string"/>                          <!-- required -->
	<part name="Country"                   type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="SocialSecurityNumber"      type="xsd:string"/>                          <!-- SSN required if address is not provided on input -->
	<part name="DateOfBirth"               type="xsd:string" comment="i.e. BirthDate"/> <!-- optional -->
	<part name="Age"                       type="xsd:unsignedInt" comment="bocashell"/> <!-- optional -->
	<part name="DLNumber"                  type="xsd:string"/>                          <!-- optional -->
	<part name="DLState"                   type="xsd:string"/>                          <!-- optional -->
	<part name="Email"                     type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="IPAddress"                 type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="HomePhone"                 type="xsd:string"/>                          <!-- optional -->
	<part name="WorkPhone"                 type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="EmployerName"              type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="FormerName"                type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="CaseNumber"                type="xsd:string"/>                          <!-- optional -->
	<part name="BenefitClaimAmount"        type="xsd:string"/>                          <!-- optional -->
	<part name="BenefitsIssuedState"       type="xsd:string"/>                          <!-- required - Batch/Kettle Plug-in should pass in the Agency's 2 letter State abbreviation if customer does not provide one on input -->
	<part name="DateAppliedForBenefits"    type="xsd:string"/>                          <!-- optional -->
	<part name="MVRVehicleValue"           type="xsd:string"/>                          <!-- optional - If not provided reverts to default -->
	<part name="NumberMVRsReported"        type="xsd:integer"/>                         <!-- optional - If not provided reverts to default -->
	<part name="NumberPropertiesReported"  type="xsd:integer"/>                         <!-- optional - If not provided reverts to default -->
	<part name="NumberOfAdultsInHousehold" type="xsd:integer"/>                         <!-- optional - If not provided reverts to default -->
	<part name="FillerField1"              type="xsd:string"/>                          <!-- optional -->
	
	<!-- =====[ Options: filter by date ]===== -->
	<part name="HistoryDateYYYYMM"         type="xsd:integer" comment="bocashell"/>     <!-- optional -->
	<part name="historyDateTimeStamp"      type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="LastSeenThreshold"         type="xsd:string" comment="bocashell"/>      <!-- optional -->
	<part name="SelectTimeFrame"           type="xsd:string"/>  <!-- 12,24,36,48 most recent months -->

	<!-- =====[ Options: include (or not) attributes associated with the subject]===== -->
	<part name="IncludeAllAttributeCategories"    type="xsd:boolean"/>
	<part name="IncludeRelativeAndAssociates"     type="xsd:boolean"/>
	<part name="IncludeDriversLicense"            type="xsd:boolean"/>
	<part name="IncludeProperty"                  type="xsd:boolean"/>
	<part name="IncludeInHouseMotorVehicle"       type="xsd:boolean"/>
	<part name="IncludeRealTimeMotorVehicle"      type="xsd:boolean"/>
	<part name="IncludeWatercraftAndAircraft"     type="xsd:boolean"/>
	<part name="IncludeProfessionalLicense"       type="xsd:boolean"/>
	<part name="IncludeBusinessAffiliations"      type="xsd:boolean"/>
	<part name="IncludePeopleAtWork"              type="xsd:boolean"/>
	<part name="IncludeBankruptcyLiensJudgements" type="xsd:boolean"/>
	<part name="IncludeCriminalSOFR"              type="xsd:boolean"/>
	<part name="IncludeUCCFilings"                type="xsd:boolean"/>

	<!-- =====[ Options: bocashell things ]===== -->
	<part name="ExcludeRelatives"       type="xsd:boolean" comment="bocashell"/>
	<part name="IncludeScore"           type="xsd:boolean" comment="bocashell"/>
	<part name="ADLBasedShell"          type="xsd:boolean" comment="bocashell"/>
	<part name="RemoveFares"            type="xsd:boolean" comment="bocashell"/>
	<part name="LeadIntegrityMode"      type="xsd:boolean" comment="bocashell"/>

	<!-- =====[ System ]===== -->

	<!-- =====[ Permissions ]===== -->
	<part name="DPPAPurpose"            type="xsd:byte"/>
	<part name="GLBPurpose"             type="xsd:byte"/>

	<!-- =====[ Restrictions ]===== -->
	<part name="DataRestrictionMask"    type="xsd:string"/>
	<part name="DataPermissionMask"     type="xsd:string"/>
	<part name="IndustryClass"          type="xsd:string"/>

	<!-- =====[ Query behavior ]===== -->
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="BSVersion"              type='xsd:integer'/>
	<part name="RelativeDepthLevel"     type="xsd:byte"/>    <!-- e.g. 1,2,3 -->

	<!-- =====[ Gateways ]===== -->
	<part name="RealTimePermissibleUse" type="xsd:string"/>
	<part name="Gateways"               type="tns:XmlDataSet" cols="110" rows="10" comment="bocashell"/> <!-- optional -->

</message>
*/

IMPORT Address, Gateway, Risk_Indicators, RiskWise, ut, doxie, gateway,AutoheaderV2;

#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);

EXPORT BeneficiaryRiskScore_Service() := FUNCTION
  UCase := StringLib.StringToUpperCase;
	
	// Define query restrictions and search options.
	restrictions  := Models.BeneficiaryRiskScore_Functions.get_restriction_params();
	bsSvcOptions  := Models.BeneficiaryRiskScore_Functions.get_InputSearchOptions_BocaShell();
	pbfSvcOptions := Models.BeneficiaryRiskScore_Functions.get_InputSearchOptions_PostBeneficiaryFraud();
  
  // Defining variables for OFAC 
 unsigned1 ofac_version_      := 1        : stored('OFACVersion');
           include_ofac_ := if(ofac_version_ = 1, false, true);
           global_watchlist_threshold_ := if(ofac_version_ in [1, 2, 3], 0.84, 0.85);
	
	// Define the search subject and the gateways for MVR.
	search_subject := Models.BeneficiaryRiskScore_Functions.get_search_subject_params();
	gateways      := Models.BeneficiaryRiskScore_Functions.get_gateways(bsSvcOptions, ofac_version_);
  
  if( ofac_version_ = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

	// Redefine the search_subject module as a 1-record dataset.
	ds_searchsubject :=
			Models.BeneficiaryRiskScore_Functions.convert_search_subject_to_datarow(search_subject);
			
	// Instantiate _Records module...
	records := 
			Models.BeneficiaryRiskScore_Records(ds_searchsubject, gateways, bsSvcOptions, pbfSvcOptions, restrictions, ofac_version_, include_ofac_, global_watchlist_threshold_);
	
	// ...and assign result datasets.
	bocashell_results := records.bocashell_Edina_v50_results;
	pbf_fraud_results := records.postbeneficiaryfraud_results;
	results           := records.final_results;
	
	// DEBUGs
	// OUTPUT( bocashell_results, NAMED('bocashell_results') );
	// OUTPUT( pbf_fraud_results, NAMED('pbf_fraud_results') );
	
	RETURN OUTPUT( results, NAMED('Results') );
END;
