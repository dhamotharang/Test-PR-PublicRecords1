/*--SOAP--
<message name="MAS_Business_nonFCRA_Service">
	<part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ScoreThreshold" type="xsd:integer"/> 
	<part name="ExcludeConsumerAttributes" type="xsd:boolean"/>
	<part name="OutputMasterResults" type="xsd:boolean"/>
	<part name="BIPAppendScoreThreshold" type="xsd:integer"/>
	<part name="BIPAppendWeightThreshold" type="xsd:integer"/>
	<part name="BIPAppendPrimForce" type="xsd:boolean"/>
	<part name="BIPAppendIncludeAuthRep" type="xsd:boolean"/>
	<part name="BIPAppendNoReAppend" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="IsMarketing" type="xsd:boolean"/>
	<part name="TurnOffHouseHolds" type="xsd:boolean"/>
	<part name="TurnOffRelatives" type="xsd:boolean"/>
	<part name="UseIngestDate" type="xsd:boolean"/>
	<part name="AllowedSources" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="AllowedSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ExcludeSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="LexIdSourceOptout" type="xsd:integer"/>
	<part name="_TransactionId" type="xsd:string"/>
	<part name="_BatchUID" type="xsd:string"/>
	<part name="_GCID" type="xsd:integer"/>
</message>
*/

IMPORT Std, PublicRecords_KEL, PublicRecords_KEL.ECL_Functions, Business_Risk_BIP, Gateway;

EXPORT MAS_Business_nonFCRA_Service() := MACRO

#OPTION('expandSelectCreateRow', TRUE);

  #WEBSERVICE(FIELDS(
        'input',
        'ScoreThreshold',
        'Gateways',
        'ExcludeConsumerAttributes',
        'OutputMasterResults',
        'BIPAppendScoreThreshold',
        'BIPAppendWeightThreshold',
        'BIPAppendPrimForce',
        'BIPAppendIncludeAuthRep',
        'BIPAppendNoReAppend',
        'DataRestrictionMask',
        'DataPermissionMask',
        'GLBPurpose',
        'DPPAPurpose',
        'IndustryClass',
        'IsMarketing',
        'TurnOffHouseHolds',
        'TurnOffRelatives',
        'UseIngestDate',
        'IncludeMinors',
        'AllowedSources',
        'OverrideExperianRestriction',
        'AllowedSourcesDataset',
        'ExcludeSourcesDataset',
        'LexIdSourceOptout',
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
UNSIGNED1 Default_GLB_Purpose := 0;
#STORED('GLBPurpose', Default_GLB_Purpose);
STRING100 Default_Data_Restriction_Mask := '';
#STORED('DataRestrictionMask',Default_Data_Restriction_Mask);

BOOLEAN Default_IncludeMinors := TRUE;
#STORED('IncludeMinors',Default_IncludeMinors);

	// Read interface params
	ds_input := DATASET([],PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) : STORED('input');
	INTEGER Score_threshold := 80 : STORED('ScoreThreshold');
	BOOLEAN Exclude_Consumer_Attributes := FALSE : STORED('ExcludeConsumerAttributes');
	BOOLEAN Output_Master_Results := FALSE : STORED('OutputMasterResults');
	STRING100 DataRestrictionMask := '' : STORED('DataRestrictionMask');
	STRING100 DataPermissionMask := Default_data_permission_mask : STORED('DataPermissionMask');
	UNSIGNED1 GLBA := 0 : STORED('GLBPurpose');
	UNSIGNED1 DPPA := 0 : STORED('DPPAPurpose');
	UNSIGNED BIPAppend_Score_Threshold := 75 : STORED('BIPAppendScoreThreshold');
	UNSIGNED BIPAppend_Weight_Threshold := 0 : STORED('BIPAppendWeightThreshold');
	BOOLEAN BIPAppend_PrimForce := FALSE : STORED('BIPAppendPrimForce');
	BOOLEAN BIPAppend_Include_AuthRep := FALSE : STORED('BIPAppendIncludeAuthRep');
	BOOLEAN BIPAppend_No_ReAppend := FALSE : STORED('BIPAppendNoReAppend');
	BOOLEAN Is_Marketing := FALSE : STORED('IsMarketing');
	BOOLEAN Turn_Off_HouseHolds := FALSE : STORED('TurnOffHouseHolds');
	BOOLEAN Turn_Off_Relatives := FALSE : STORED('TurnOffRelatives');
	BOOLEAN Use_Ingest_Date := FALSE : STORED('UseIngestDate');
	// BOOLEAN Include_Minors := TRUE : STORED('IncludeMinors');
	BOOLEAN Include_Minors := Default_IncludeMinors : STORED('IncludeMinors');
	BOOLEAN OverrideExperianRestriction := FALSE : STORED('OverrideExperianRestriction');
	STRING100 AllowedSources := '' : STORED('AllowedSources');
	AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('AllowedSourcesDataset');
	ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('ExcludeSourcesDataset');
	STRING5 Industry_Class := Default_Industry_Class : STORED('IndustryClass');
	//CCPA fields
	UNSIGNED1 _LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
	STRING _TransactionId := '' : STORED ('_TransactionId');
	STRING100 _BatchUID := '' : STORED('_BatchUID');
	UNSIGNED6 _GCID := 0 : STORED('_GCID');
	
	
	BOOLEAN Allow_DNBDMI := STD.Str.Find( AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1 ) > 0; // When TRUE this will unmask DNB DMI data - NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY
	#STORED('AllowAll', Allow_DNBDMI); // If DNBDMI is allowed, set AllowAll to TRUE for Business Best test
	
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
	#STORED('IsFCRAValue', FALSE);
	#CONSTANT('IsFCRA', FALSE);

	// If allowed sources aren't passed in, use default list of allowed sources
	SetAllowedSources := IF(COUNT(AllowedSourcesDataset) = 0, PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_ALLOWED_SOURCES_NONFCRA, AllowedSourcesDataset);
	// If a source is on the Exclude list, remove it from the allowed sources list. 
	FinalAllowedSources := JOIN(SetAllowedSources, ExcludeSourcesDataset, LEFT=RIGHT, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY);
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT STRING100 Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING100 Data_Permission_Mask := DataPermissionMask;
		EXPORT STRING5 IndustryClass := Industry_Class;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT BOOLEAN IsFCRA := FALSE;
		EXPORT BOOLEAN ExcludeConsumerAttributes := Exclude_Consumer_Attributes;
		EXPORT BOOLEAN OutputMasterResults := Output_Master_Results;
		EXPORT BOOLEAN isMarketing := Is_Marketing; // When TRUE enables Marketing Restrictions
		EXPORT BOOLEAN TurnOffRelatives := Turn_Off_Relatives; 
		EXPORT BOOLEAN TurnOffHouseHolds := Turn_Off_HouseHolds; 
		EXPORT BOOLEAN UseIngestDate := Use_Ingest_Date; 
		EXPORT BOOLEAN IncludeMinors := Include_Minors; 
		EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction;
		EXPORT STRING100 Allowed_Sources := AllowedSources;
		EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := FinalAllowedSources;

		EXPORT DATA57 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			DataRestrictionMask, 
			DataPermissionMask, 
			GLBA, 
			DPPA, 
			FALSE, /* IsFCRA */
			Is_Marketing, 
			Allow_DNBDMI, 
			OverrideExperianRestriction,
			'', /* IntendedPurpose - For FCRA Products Only */
			Industry_Class,
			PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile,
			FALSE, /*IsInsuranceProduct*/
			FinalAllowedSources);
		
		// BIP Append Options
		EXPORT UNSIGNED BIPAppendScoreThreshold := MAP(BIPAppend_No_ReAppend => 0, 
														BIPAppend_Score_Threshold = 0 => 75, MIN(MAX(51,BIPAppend_Score_Threshold), 100)); // Score threshold must be between 51 and 100 -- default is 75.
		EXPORT UNSIGNED BIPAppendWeightThreshold := BIPAppend_Weight_Threshold;
		EXPORT BOOLEAN BIPAppendPrimForce := BIPAppend_PrimForce;
		EXPORT BOOLEAN BIPAppendReAppend := NOT BIPAppend_No_ReAppend;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep := BIPAppend_Include_AuthRep;
		// CCPA Options
		EXPORT UNSIGNED1 LexIdSourceOptout := _LexIdSourceOptout;
		EXPORT STRING100 TransactionID := _TransactionId;
		EXPORT STRING100 BatchUID := _BatchUID;
		EXPORT UNSIGNED6 GlobalCompanyId := _GCID;
		EXPORT DATASET(Gateway.Layouts.Config) Gateways := GatewaysClean;
		// The inquiry delta base which feeds the 1 day inq attrs is not needed for the input rep 1 at this point. for now we only run this delta base code in the nonFCRA service 

		// Override Include* Entity/Association options here if certain entities can be turned off to speed up processing.
		// This will bypass uneccesary key JOINS in PublicRecords_KEL.Fn_MAS_FCRA_FDC if the keys don't contribute to any 
		// ENTITIES/ASSOCIATIONS being used by the query.


	END;	
	
	JoinFlags := PublicRecords_KEL.Internal_Join_Interface_Options_Business_Only(PublicRecords_KEL.Join_Interface_Options);	//turn off ecl
	
  ResultSet := PublicRecords_KEL.FnRoxie_GetBusAttrs(ds_input, Options, JoinFlags);		
	
	
	FinalResults := PROJECT(ResultSet, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA,
			SELF := LEFT));
	
	OUTPUT( FinalResults, NAMED('Results') );

ENDMACRO;
