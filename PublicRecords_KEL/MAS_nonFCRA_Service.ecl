/*--SOAP--
<message name="MAS_nonFCRA_Service">
  <part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
  <part name="ScoreThreshold" type="xsd:integer"/> 
</message>
*/

IMPORT Std, PublicRecords_KEL;

EXPORT MAS_nonFCRA_Service() := MACRO
  #WEBSERVICE(FIELDS(
    'input',
    'ScoreThreshold'
  ));

  // Read interface params
  ds_input := DATASET([],PublicRecords_KEL.ECL_Functions.Input_Layout) : STORED('input');
  INTEGER Score_threshold := 80 : STORED('ScoreThreshold');

	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN IsFCRA := FALSE;
		
		// Override Include* Entity/Association options here if certain entities can be turned off to speed up processing.
		// This will bypass uneccesary key JOINS in PublicRecords_KEL.Fn_MAS_FCRA_FDC if the keys don't contribute to any 
		// ENTITIES/ASSOCIATIONS being used by the query.
		
	END;	
	
  ResultSet:= PublicRecords_KEL.FnRoxie_GetAttrs(ds_input, Options);		
		
  OUTPUT( ResultSet, NAMED('Results') );

ENDMACRO;


