﻿﻿/*--SOAP--
<message name="MAS_nonFCRA_Service">
	<part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ScoreThreshold" type="xsd:integer"/> 
	<part name="OutputMasterResults" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="IsMarketing" type="xsd:boolean"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="LexIdSourceOptout" type="xsd:integer"/>
	<part name="_TransactionId" type="xsd:string"/>
	<part name="_BatchUID" type="xsd:string"/>
	<part name="_GCID" type="xsd:integer"/>
</message>
*/

IMPORT Std, PublicRecords_KEL;

EXPORT MAS_nonFCRA_Service() := MACRO
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
    'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'
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
	STRING Industry_Class := '' : STORED('IndustryClass');
	//CCPA fields
	UNSIGNED1 _LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
	STRING _TransactionId := '' : STORED ('_TransactionId');
	STRING _BatchUID := '' : STORED('_BatchUID');
	UNSIGNED6 _GCID := 0 : STORED('_GCID');
	
	gateways_in := Gateway.Configuration.Get();
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := le.url; 
		SELF := le;
	END;

	DATASET(Gateway.Layouts.Config) GatewaysClean := PROJECT(gateways_in, gw_switch(LEFT));
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN IsFCRA := FALSE;
		EXPORT BOOLEAN OutputMasterResults := Output_Master_Results;
		EXPORT STRING100 Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING100 Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT BOOLEAN isMarketing := Is_Marketing; // When TRUE enables Marketing Restrictions
		EXPORT UNSIGNED8 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			DataRestrictionMask, 
			DataPermissionMask, 
			GLBA, 
			DPPA, 
			FALSE, /* IsFCRA */ 
			Is_Marketing, 
			'' /* Allowed_Sources */ = Business_Risk_BIP.Constants.AllowDNBDMI, 
			FALSE, /*OverrideExperianRestriction*/
			'', /* PermissiblePurpose - For FCRA Products Only */
			Industry_Class,
			PublicRecords_KEL.CFG_Compile);
		EXPORT UNSIGNED1 LexIdSourceOptout := _LexIdSourceOptout;
		EXPORT STRING100 TransactionID := _TransactionId;
		EXPORT STRING100 BatchUID := _BatchUID;
		EXPORT UNSIGNED6 GlobalCompanyId := _GCID;
		
		EXPORT DATASET(Gateway.Layouts.Config) Gateways := GatewaysClean;
		
		// Override Include* Entity/Association options here if certain entities can be turned off to speed up processing.
		// This will bypass uneccesary key JOINS in PublicRecords_KEL.Fn_MAS_FCRA_FDC if the keys don't contribute to any 
		// ENTITIES/ASSOCIATIONS being used by the query.
		
	END;	
	
	ResultSet := PublicRecords_KEL.FnRoxie_GetAttrs(ds_input, Options);		
		
	FinalResults := PROJECT(ResultSet, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layout_Person_NonFCRA,
			SELF := LEFT));
	
  OUTPUT( FinalResults, NAMED('Results') );

ENDMACRO;
