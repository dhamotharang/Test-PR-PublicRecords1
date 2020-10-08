/*--SOAP--
	<message name = 'Neutral Lexid Service'>
		<part name = 'In_Layout'			type = 'tns:XmlDataSet' cols="70" rows="10"/>
		<part name = 'Score_threshold'		type = 'xsd:integer'/>
		<part name = 'Retain_Input_Lexid'		type = 'xsd:boolean'/>
	</message>
*/
/*--INFO-- The FCRA-Neutral part that appends the Lexid */ 

IMPORT PublicRecords_KEL;

EXPORT Neutral_Lexid_Service() := MACRO
	//Score_threshold := 80 : stored('Score_threshold');
	indata := dataset([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) : stored('In_Layout', FEW);
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := 80 : STORED('Score_threshold');
		EXPORT BOOLEAN RetainInputLexid := FALSE : STORED('Retain_Input_Lexid');
	END;
	
	
	LexidAppended := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( indata, Options );

	output(LexidAppended, NAMED('LexidAppended'));
	
ENDMACRO;