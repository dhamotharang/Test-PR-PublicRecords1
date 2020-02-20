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
	<part name="IndustryClass" type="xsd:string"/>
	<part name="PermissiblePurpose" type="xsd:string"/>
</message>
*/

IMPORT Std, PublicRecords_KEL, Gateway;

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
		'PermissiblePurpose'
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
	STRING Permissible_Purpose := '' : STORED('PermissiblePurpose'); // Can be set to 'PRESCREENING' for FCRA Pre-Screen applications
	
	gateways_in := Gateway.Configuration.Get();
	Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := le.url; 
		SELF := le;
	END;

	DATASET(Gateway.Layouts.Config) GatewaysClean := PROJECT(gateways_in, gw_switch(LEFT));
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN isFCRA := TRUE;
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
			TRUE, /* IsFCRA */
			Is_Marketing, 
			'' /* Allowed_Sources */ = Business_Risk_BIP.Constants.AllowDNBDMI, 
			FALSE, /*OverrideExperianRestriction*/
			Permissible_Purpose,
			Industry_Class,
			PublicRecords_KEL.CFG_Compile);
		
		EXPORT DATASET(Gateway.Layouts.Config) Gateways := GatewaysClean;
		
		// Override Include* Entity/Association options here if certain entities can be turned off to speed up processing.
		// This will bypass uneccesary key JOINS in PublicRecords_KEL.Fn_MAS_FDC if the keys don't contribute to any 
		// ENTITIES/ASSOCIATIONS being used by the query.	

	END;
	
  ResultSet := PublicRecords_KEL.FnRoxie_GetAttrs(ds_input, Options);

	FinalResults := PROJECT(ResultSet, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA,
			SELF := LEFT));
			
  OUTPUT( FinalResults, NAMED('Results') );

ENDMACRO;


