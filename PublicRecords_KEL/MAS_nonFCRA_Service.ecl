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
  INTEGER Score_threshold := 90 : STORED('ScoreThreshold');

  ResultSet:= PublicRecords_KEL.FnRoxie_GetAttrs(ds_input, Score_threshold);
    
  OUTPUT( ResultSet, NAMED('Results') );

ENDMACRO;


