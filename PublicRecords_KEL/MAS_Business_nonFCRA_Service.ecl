/*--SOAP--
<message name="MAS_Business_nonFCRA_Service">
	<part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ScoreThreshold" type="xsd:integer"/> 
	<part name="ExcludeConsumerShell" type="xsd:boolean"/>
	<part name="OutputMasterResults" type="xsd:boolean"/>
</message>
*/

IMPORT Std, PublicRecords_KEL;

EXPORT MAS_Business_nonFCRA_Service() := MACRO
  #WEBSERVICE(FIELDS(
		'input',
		'ScoreThreshold',
		'ExcludeConsumerShell',
		'OutputMasterResults',
		'BIPAppendScoreThreshold',
		'BIPAppendWeightThreshold',
		'BIPAppendPrimForce',
		'BIPAppendIncludeAuthRep',
		'BIPAppendNoReAppend',
		'DataRestrictionMask',
		'DataPermissionMask',
		'GLBA_Purpose',
		'DPPA_Purpose',
		'IsMarketing'
  ));

  // Read interface params
  ds_input := DATASET([],PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) : STORED('input');
  INTEGER Score_threshold := 80 : STORED('ScoreThreshold');
	BOOLEAN Exclude_Consumer_Shell := FALSE : STORED('ExcludeConsumerShell');
	BOOLEAN Output_Master_Results := FALSE : STORED('OutputMasterResults');
	STRING DataRestrictionMask := '' : STORED('DataRestrictionMask');
	STRING DataPermissionMask := '' : STORED('DataPermissionMask');
	UNSIGNED1 GLBA := 0 : STORED('GLBA_Purpose');
	UNSIGNED1 DPPA := 0 : STORED('DPPA_Purpose');
	UNSIGNED BIPAppend_Score_Threshold := 75 : STORED('BIPAppendScoreThreshold');
	UNSIGNED BIPAppend_Weight_Threshold := 0 : STORED('BIPAppendWeightThreshold');
	BOOLEAN BIPAppend_PrimForce := FALSE : STORED('BIPAppendPrimForce');
	BOOLEAN BIPAppend_Include_AuthRep := FALSE : STORED('BIPAppendIncludeAuthRep');
	BOOLEAN BIPAppend_No_ReAppend := FALSE : STORED('BIPAppendNoReAppend');
	BOOLEAN Is_Marketing := FALSE : STORED('IsMarketing');
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT BOOLEAN IsFCRA := FALSE;
		EXPORT BOOLEAN ExcludeConsumerShell := Exclude_Consumer_Shell;
		EXPORT BOOLEAN OutputMasterResults := Output_Master_Results;
		EXPORT BOOLEAN isMarketing := Is_Marketing; // When TRUE enables Marketing Restrictions
		EXPORT UNSIGNED8 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			DataRestrictionMask, 
			DataPermissionMask, 
			GLBA, 
			DPPA, 
			FALSE, /* IsFCRA */ 
			Is_Marketing, 
			'' /* Allowed_Sources */ = Business_Risk_BIP.Constants.AllowDNBDMI, 
			PublicRecords_KEL.CFG_Compile);
		
		// BIP Append Options
		EXPORT UNSIGNED BIPAppendScoreThreshold := IF(BIPAppend_Score_Threshold = 0, 75, MIN(MAX(51,BIPAppend_Score_Threshold), 100)); // Score threshold must be between 51 and 100 -- default is 75.
		EXPORT UNSIGNED BIPAppendWeightThreshold := BIPAppend_Weight_Threshold;
		EXPORT BOOLEAN BIPAppendPrimForce := BIPAppend_PrimForce;
		EXPORT BOOLEAN BIPAppendReAppend := NOT BIPAppend_No_ReAppend;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep := BIPAppend_Include_AuthRep;
		
		// Override Include* Entity/Association options here if certain entities can be turned off to speed up processing.
		// This will bypass uneccesary key JOINS in PublicRecords_KEL.Fn_MAS_FCRA_FDC if the keys don't contribute to any 
		// ENTITIES/ASSOCIATIONS being used by the query.
		
	END;	
	
  ResultSet := PublicRecords_KEL.FnRoxie_GetBusAttrs(ds_input, Options);		
	
	FinalResults := PROJECT(ResultSet, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA,
			SELF := LEFT));

  OUTPUT( FinalResults, NAMED('Results') );

ENDMACRO;
