/*--SOAP--
	<message name = 'Neutral Lexid Service'>
		<part name = 'In_Layout'			type = 'tns:XmlDataSet' cols="70" rows="10"/>
		<part name = 'Score_threshold'		type = 'xsd:integer'/>
		<part name = 'Retain_Input_Lexid'		type = 'xsd:boolean'/>
	</message>
*/
/*--INFO-- The FCRA-Neutral part that appends the Lexid */ 

IMPORT Header, PublicRecords_KEL;

EXPORT Neutral_Lexid_Service() := MACRO
	//Score_threshold := 80 : stored('Score_threshold');
	indata := dataset([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) : stored('In_Layout', FEW);
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := 80 : STORED('Score_threshold');
		EXPORT BOOLEAN RetainInputLexid := FALSE : STORED('Retain_Input_Lexid');
	END;
	
	
	LexidAppended := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( indata, Options );

	getLexIDCategory := JOIN(LexidAppended, Header.key_ADL_segmentation, 
		LEFT.P_LexID > 0 AND
		KEYED(LEFT.P_LexID = RIGHT.did),
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
			SELF.LexIDSegment := RIGHT.ind1,
			SELF.LexIDSegment2 := RIGHT.ind2,
			SELF := LEFT), 
		LEFT OUTER, ATMOST(100), KEEP(1));
		
	output(getLexIDCategory, NAMED('LexidAppended'));
	
ENDMACRO;