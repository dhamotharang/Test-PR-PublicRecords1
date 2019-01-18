/*--SOAP--
<message name="MAS_FCRA_Service">
	<part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ScoreThreshold" type="xsd:integer"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="OutputMasterResults" type="xsd:boolean"/>
</message>
*/

IMPORT Std, PublicRecords_KEL, Gateway;

EXPORT MAS_FCRA_Service() := MACRO
  #WEBSERVICE(FIELDS(
    'input',
    'ScoreThreshold',
		'Gateways',
		'OutputMasterResults'
  ));

  // Read interface params
  ds_input := DATASET([],PublicRecords_KEL.ECL_Functions.Input_Layout) : STORED('input');
  INTEGER Score_threshold := 80 : STORED('ScoreThreshold');
  BOOLEAN Output_Master_Results := FALSE : STORED('OutputMasterResults');
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN isFCRA := TRUE;
		EXPORT BOOLEAN OutputMasterResults := Output_Master_Results;

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


