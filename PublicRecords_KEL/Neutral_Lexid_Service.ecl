/*--SOAP--
	<message name = 'Neutral Lexid Service'>
		<part name = 'In_Layout'			type = 'tns:XmlDataSet' cols="70" rows="10"/>
		<part name = 'Score_threshold'		type = 'xsd:integer'/>
	</message>
*/
/*--INFO-- The FCRA-Neutral part that appends the Lexid */ 

IMPORT PublicRecords_KEL;

EXPORT Neutral_Lexid_Service() := MACRO
	//Score_threshold := 80 : stored('Score_threshold');
	indata := dataset([], PublicRecords_KEL.ECL_Functions.Input_ALL_Layout) : stored('In_Layout', FEW);
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER Score_threshold := 80 : STORED('ScoreThreshold');
	END;
	LexidAppended := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( indata, Options );
	
	output(LexidAppended, NAMED('Results'));
	
ENDMACRO;