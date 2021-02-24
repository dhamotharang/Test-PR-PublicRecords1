/*--SOAP--
<message name="MAS_FCRA_Service">
	<part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ScoreThreshold" type="xsd:integer"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="OutputMasterResults" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="IsMarketing" type="xsd:boolean"/>
	<part name="RetainInputLexid" type="xsd:boolean"/>
	<part name="AppendPII" type="xsd:boolean"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="IntendedPurpose" type="xsd:string"/>
	<part name="AllowedSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ExcludeSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
</message>
*/

IMPORT Std, PublicRecords_KEL, Gateway, Business_Risk_BIP;

EXPORT MAS_FCRA_Service() := MACRO

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
		'RetainInputLexid',
		'AppendPII',
		'IncludeMinors',
		'IntendedPurpose',
		'AllowedSourcesDataset',
		'ExcludeSourcesDataset'

  ));

	// Read interface params
	ds_input := DATASET([],PublicRecords_KEL.ECL_Functions.Input_Layout) : STORED('input');
	INTEGER Score_threshold := 80 : STORED('ScoreThreshold');
	BOOLEAN Output_Master_Results := FALSE : STORED('OutputMasterResults');
	STRING DataRestrictionMask := '' : STORED('DataRestrictionMask');
	STRING DataPermissionMask := '' : STORED('DataPermissionMask');
	UNSIGNED1 GLBA := 0 : STORED('GLBPurpose');
	UNSIGNED1 DPPA := 0 : STORED('DPPAPurpose');
	BOOLEAN Is_Marketing := FALSE : STORED('IsMarketing');
	BOOLEAN Include_Minors := TRUE : STORED('IncludeMinors');
	STRING5 Industry_Class := '' : STORED('IndustryClass');
	STRING Intended_Purpose := '' : STORED('IntendedPurpose'); // Can be set to 'PRESCREENING' for FCRA Pre-Screen applications
	AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('AllowedSourcesDataset');
	ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('ExcludeSourcesDataset'); 
	
	BOOLEAN Retain_Input_Lexid := FALSE : STORED('RetainInputLexid');//keep what we have on input
	BOOLEAN Append_PII := FALSE : STORED('AppendPII');//keep what we have on input
		
	// Nulling out stored variables to not propagate to Attributes.kel
	#CONSTANT('NetAcuityURL', ''); 
	#CONSTANT('OFACURL', '');
	#CONSTANT('Watchlists_RequestedValue', '');
	#CONSTANT('IncludeOfacValue', FALSE);
	#CONSTANT('IncludeAdditionalWatchListsValue', FALSE);
	#CONSTANT('Global_Watchlist_ThresholdValue', 0);
	#CONSTANT('IsFCRA', TRUE);
	
	gateways_in := Gateway.Configuration.Get();
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := le.url; 
		SELF := le;
	END;

	DATASET(Gateway.Layouts.Config) GatewaysClean := PROJECT(gateways_in, gw_switch(LEFT));

	#STORED('GLBPurposeValue', GLBA);
	#STORED('DPPAPurposeValue', DPPA);
	#STORED('IsFCRAValue', TRUE);
	
	TargusGW := GatewaysClean(STD.Str.ToLowerCase(servicename) = 'targus')[1];
	#STORED('TargusURL', TargusGW.url);
	
	// If allowed sources aren't passed in, use default list of allowed sources
	SetAllowedSources := IF(COUNT(AllowedSourcesDataset) = 0, PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_ALLOWED_SOURCES_FCRA, AllowedSourcesDataset);
	// If a source is on the Exclude list, remove it from the allowed sources list. 
	FinalAllowedSources := JOIN(SetAllowedSources, ExcludeSourcesDataset, LEFT=RIGHT, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY);
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN isFCRA := TRUE;
		EXPORT BOOLEAN OutputMasterResults := Output_Master_Results;
		EXPORT STRING100 Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING100 Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT BOOLEAN isMarketing := Is_Marketing; // When TRUE enables Marketing Restrictions
		EXPORT BOOLEAN IncludeMinors := Include_Minors; // When TRUE enables Marketing Restrictions
		EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := FinalAllowedSources;
		EXPORT DATA57 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			DataRestrictionMask, 
			DataPermissionMask, 
			GLBA, 
			DPPA, 
			TRUE, /* IsFCRA */
			Is_Marketing, 
			'' /* Allowed_Sources */ = Business_Risk_BIP.Constants.AllowDNBDMI, 
			FALSE, /*OverrideExperianRestriction*/
			Intended_Purpose,
			Industry_Class,
			PublicRecords_KEL.CFG_Compile,
			FALSE, /*IsInsuranceProduct*/
			FinalAllowedSources);
		
		EXPORT DATASET(Gateway.Layouts.Config) Gateways := GatewaysClean;
		EXPORT BOOLEAN RetainInputLexid := Retain_Input_Lexid;
		EXPORT BOOLEAN BestPIIAppend := Append_PII; //do not append best pii for running

		
		// Override Include* Entity/Association options here if certain entities can be turned off to speed up processing.
		// This will bypass uneccesary key JOINS in PublicRecords_KEL.Fn_MAS_FDC if the keys don't contribute to any 
		// ENTITIES/ASSOCIATIONS being used by the query.	

		EXPORT BOOLEAN IncludeAccident := TRUE;
		EXPORT BOOLEAN IncludeAddress := TRUE;
		EXPORT BOOLEAN IncludeAddressSummary := TRUE;
		EXPORT BOOLEAN IncludeAircraft := TRUE;
		EXPORT BOOLEAN IncludeBankruptcy := TRUE;
		EXPORT BOOLEAN IncludeBusinessSele := TRUE;
		EXPORT BOOLEAN IncludeBusinessProx := TRUE;
		EXPORT BOOLEAN IncludeCriminalOffender := TRUE;
		EXPORT BOOLEAN IncludeCriminalOffense := TRUE;
		EXPORT BOOLEAN IncludeCriminalPunishment := TRUE;
		EXPORT BOOLEAN IncludeDriversLicense := TRUE;
		EXPORT BOOLEAN IncludeEducation := TRUE;
		EXPORT BOOLEAN IncludeEBRTradeline := TRUE;
		EXPORT BOOLEAN IncludeEmail := TRUE;
		EXPORT BOOLEAN IncludeEmployment := TRUE;
		EXPORT BOOLEAN IncludeForeclosure := TRUE;
		EXPORT BOOLEAN IncludeGeolink := TRUE;
		EXPORT BOOLEAN IncludeHousehold := TRUE;
		EXPORT BOOLEAN IncludeInquiry := TRUE;
		EXPORT BOOLEAN IncludeLienJudgment := TRUE;
		EXPORT BOOLEAN IncludeNameSummary := TRUE;
		EXPORT BOOLEAN IncludePerson := TRUE;
		EXPORT BOOLEAN IncludePhone := TRUE;
		EXPORT BOOLEAN IncludePhoneSummary := TRUE;
		EXPORT BOOLEAN IncludeProfessionalLicense := TRUE;
		EXPORT BOOLEAN IncludeProperty := TRUE;
		EXPORT BOOLEAN IncludePropertyEvent := TRUE;
		EXPORT BOOLEAN IncludeSexOffender := TRUE;
		EXPORT BOOLEAN IncludeSocialSecurityNumber := TRUE;
		EXPORT BOOLEAN IncludeSSNSummary := TRUE;
		EXPORT BOOLEAN IncludeSurname := TRUE;
		EXPORT BOOLEAN IncludeTIN := TRUE;
		EXPORT BOOLEAN IncludeTradeline := TRUE;
		EXPORT BOOLEAN IncludeUtility := TRUE;
		EXPORT BOOLEAN IncludeVehicle := TRUE;
		EXPORT BOOLEAN IncludeWatercraft := TRUE;
		EXPORT BOOLEAN IncludeZipCode := TRUE;
		EXPORT BOOLEAN IncludeUCC := TRUE;
		EXPORT BOOLEAN IncludeMini := TRUE;
		EXPORT BOOLEAN IncludeOverrides := TRUE;


	END;

	IF(options.RetainInputLexid = FALSE AND options.BestPIIAppend = TRUE, FAIL('Insufficient Input'));

  ResultSet := PublicRecords_KEL.FnRoxie_GetAttrs(ds_input, Options);

	FinalResults := PROJECT(ResultSet, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA,
			SELF := LEFT));
			
	TargusRoyaltyCount := COUNT(ResultSet(TargusRoyalty <> 0));

	TargusRoyaltyDS := DATASET([transform(Royalty.Layouts.Royalty,
							SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.TARGUS_PDE,
							SELF.royalty_type := Royalty.Constants.RoyaltyType.TARGUS_PDE;
							SELF.royalty_count := TargusRoyaltyCount; 
							SELF := [];)]);
							
	RoyaltySet := TargusRoyaltyDS;
					
	OUTPUT(RoyaltySet, NAMED('RoyaltySet'));
			
  OUTPUT( FinalResults, NAMED('Results') );

ENDMACRO;


