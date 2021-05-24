﻿﻿/*--SOAP--
<message name="MAS_nonFCRA_Service">
	<part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ScoreThreshold" type="xsd:integer"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="OutputMasterResults" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="IsMarketing" type="xsd:boolean"/>
	<part name="TurnOffHouseHolds" type="xsd:boolean"/>
	<part name="TurnOffRelatives" type="xsd:boolean"/>
	<part name="RetainInputLexid" type="xsd:boolean"/>
	<part name="UseIngestDate" type="xsd:boolean"/>
	<part name="AppendPII" type="xsd:boolean"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="AllowedSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ExcludeSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="LexIdSourceOptout" type="xsd:integer"/>
	<part name="_TransactionId" type="xsd:string"/>
	<part name="_BatchUID" type="xsd:string"/>
	<part name="_GCID" type="xsd:integer"/>
</message>
*/

IMPORT Std, PublicRecords_KEL, RiskWise, Royalty;

EXPORT MAS_nonFCRA_Service() := MACRO

#OPTION('expandSelectCreateRow', TRUE);

  #WEBSERVICE(FIELDS(
		'input',
		'ScoreThreshold',
		'Gateways',
		'OutputMasterResults',
		'DataRestrictionMask',
		'DataPermissionMask',
		'GLBPurpose',
		'DPPAPurpose',
		'IndustryClass',
		'IsMarketing',
		'TurnOffHouseHolds',
		'TurnOffRelatives',
		'IncludeMinors',
		'AllowedSourcesDataset',
		'ExcludeSourcesDataset',
		'LexIdSourceOptout',
		'RetainInputLexid',
		'UseIngestDate',
		'AppendPII',
		'_TransactionId',
		'_BatchUID',
		'_GCID',
		'Watchlists_Requested',
		'IncludeOfac',
		'IncludeAdditionalWatchLists',
		'Global_Watchlist_Threshold'
  ));

STRING5 Default_Industry_Class := '';	
#stored('IndustryClass',Default_Industry_Class);
STRING100 Default_data_permission_mask := '';	
#stored('DataPermissionMask',Default_data_permission_mask);

	// Read interface params
	ds_input := DATASET([],PublicRecords_KEL.ECL_Functions.Input_Layout) : STORED('input');
	INTEGER Score_threshold := 80 : STORED('ScoreThreshold');
	BOOLEAN Output_Master_Results := FALSE : STORED('OutputMasterResults');
	STRING DataRestrictionMask := '' : STORED('DataRestrictionMask');
	STRING100 DataPermissionMask := Default_data_permission_mask : STORED('DataPermissionMask');
	UNSIGNED1 GLBA := 0 : STORED('GLBPurpose');
	#STORED('GLBPurposeValue', GLBA);
	UNSIGNED1 DPPA := 0 : STORED('DPPAPurpose');
	#STORED('DPPAPurposeValue', DPPA);
	BOOLEAN Is_Marketing := FALSE : STORED('IsMarketing');
	BOOLEAN Turn_Off_HouseHolds := FALSE : STORED('TurnOffHouseHolds');
	BOOLEAN Turn_Off_Relatives := FALSE : STORED('TurnOffRelatives');
	BOOLEAN Include_Minors := TRUE : STORED('IncludeMinors');
	BOOLEAN Use_Ingest_Date := FALSE : STORED('UseIngestDate');
	STRING5 Industry_Class := Default_Industry_Class : STORED('IndustryClass');
	AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('AllowedSourcesDataset');
	ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('ExcludeSourcesDataset');
	//CCPA fields
	UNSIGNED1 _LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
	STRING _TransactionId := '' : STORED ('_TransactionId');
	STRING _BatchUID := '' : STORED('_BatchUID');
	UNSIGNED6 _GCID := 0 : STORED('_GCID');
	
	BOOLEAN Retain_Input_Lexid := FALSE : STORED('RetainInputLexid');//keep what we have on input
	BOOLEAN Append_PII := FALSE : STORED('AppendPII');//keep what we have on input	
	
	gateways_in := Gateway.Configuration.Get();
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := le.url; 
		SELF := le;
	END;

	DATASET(Gateway.Layouts.Config) GatewaysClean := PROJECT(gateways_in, gw_switch(LEFT));
	
	// OFAC parameters
    BOOLEAN   include_ofac := FALSE : STORED('IncludeOfac');
    BOOLEAN   include_additional_watchlists  := FALSE  : STORED('IncludeAdditionalWatchLists');
    REAL Global_Watchlist_Threshold := Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');
    STRING watchlists := '' : STORED('Watchlists_Requested');
    
    OFACGW := GatewaysClean(STD.Str.ToLowerCase(servicename) = 'bridgerwlc')[1];
	#STORED('OFACURL', OFACGW.url);
    #STORED('IncludeOfacValue', include_ofac);
    #STORED('IncludeAdditionalWatchListsValue', include_additional_watchlists);
    #STORED('Watchlists_RequestedValue', watchlists);
    #STORED('Global_Watchlist_ThresholdValue', Global_Watchlist_Threshold);
		#CONSTANT('IsFCRA', FALSE);
 
    // NetAcuity parameters
	NetAcuityGW := GatewaysClean(STD.Str.ToLowerCase(servicename) = 'netacuity')[1];
	#STORED('NetAcuityURL', NetAcuityGW.url);
	#STORED('IsFCRAValue', FALSE);
	
	TargusGW := GatewaysClean(STD.Str.ToLowerCase(servicename) = 'targus')[1];
	#STORED('TargusURL', TargusGW.url);
	
	InsurancePhoneGW := GatewaysClean(STD.Str.ToLowerCase(servicename) = 'insurancephoneheader')[1];
	#STORED('InsurancePhoneURL', InsurancePhoneGW.url);

	// If allowed sources aren't passed in, use default list of allowed sources
	SetAllowedSources := IF(COUNT(AllowedSourcesDataset) = 0, PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_ALLOWED_SOURCES_NONFCRA, AllowedSourcesDataset);
	// If a source is on the Exclude list, remove it from the allowed sources list. 
	FinalAllowedSources := JOIN(SetAllowedSources, ExcludeSourcesDataset, LEFT=RIGHT, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY);
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN IsFCRA := FALSE;
		EXPORT BOOLEAN OutputMasterResults := Output_Master_Results;
		EXPORT STRING100 Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING100 Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT BOOLEAN isMarketing := Is_Marketing; // When TRUE enables Marketing Restrictions
		EXPORT BOOLEAN TurnOffRelatives := Turn_Off_Relatives; 
		EXPORT BOOLEAN TurnOffHouseHolds := Turn_Off_HouseHolds;
		EXPORT BOOLEAN IncludeMinors := Include_Minors;
		EXPORT BOOLEAN UseIngestDate := Use_Ingest_Date;
		EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := FinalAllowedSources;
		EXPORT DATA57 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			DataRestrictionMask, 
			DataPermissionMask, 
			GLBA, 
			DPPA, 
			FALSE, /* IsFCRA */ 
			Is_Marketing, 
			'' /* Allowed_Sources */ = Business_Risk_BIP.Constants.AllowDNBDMI, 
			FALSE, /*OverrideExperianRestriction*/
			'', /* IntendedPurpose - For FCRA Products Only */
			Industry_Class,
			PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile,
			FALSE, /*IsInsuranceProduct*/
			FinalAllowedSources);
		EXPORT UNSIGNED1 LexIdSourceOptout := _LexIdSourceOptout;
		EXPORT STRING100 TransactionID := _TransactionId;
		EXPORT STRING100 BatchUID := _BatchUID;
		EXPORT UNSIGNED6 GlobalCompanyId := _GCID;
		
		EXPORT DATASET(Gateway.Layouts.Config) Gateways := GatewaysClean;
		
		EXPORT BOOLEAN RetainInputLexid := Retain_Input_Lexid;
		EXPORT BOOLEAN BestPIIAppend := Append_PII; //do not append best pii for running		
		
		// Override Include* Entity/Association options here if certain entities can be turned off to speed up processing.
		// This will bypass uneccesary key JOINS in PublicRecords_KEL.Fn_MAS_FCRA_FDC if the keys don't contribute to any 
		// ENTITIES/ASSOCIATIONS being used by the query.
	
	END;	
	
	IF(options.RetainInputLexid = FALSE AND options.BestPIIAppend = TRUE, FAIL('Insufficient Input'));

	JoinFlags := PublicRecords_KEL.Internal_Join_Interface_Options(PublicRecords_KEL.Join_Interface_Options);

	ResultSet := PublicRecords_KEL.FnRoxie_GetAttrsNonFCRA(ds_input, Options, JoinFlags);		
	//calls  LIB_nonFCRAPersonAttributes
		
	FinalResults := PROJECT(ResultSet, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layout_Person_NonFCRA,
			SELF := LEFT));
	

	TargusRoyaltyCount := COUNT(ResultSet(TargusRoyalty <> 0));

	TargusRoyaltyDS := DATASET([transform(Royalty.Layouts.Royalty,
							SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.TARGUS_PDE,
							SELF.royalty_type := Royalty.Constants.RoyaltyType.TARGUS_PDE;
							SELF.royalty_count := TargusRoyaltyCount; 
							SELF := [];)]);
							
	NetAcuityRoyaltyCount := COUNT(ResultSet(NetAcuityRoyalty <> 0));

	NetAcuityRoyaltyDS := DATASET([transform(Royalty.Layouts.Royalty,
							SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.NETACUITY,
							SELF.royalty_type := Royalty.Constants.RoyaltyType.NETACUITY;
							SELF.royalty_count := NetAcuityRoyaltyCount; 
							SELF := [];)]);

	RoyaltySet := TargusRoyaltyDS + NetAcuityRoyaltyDS;
					
	OUTPUT(RoyaltySet, NAMED('RoyaltySet'));
	
  OUTPUT( FinalResults, NAMED('Results') );

ENDMACRO;
