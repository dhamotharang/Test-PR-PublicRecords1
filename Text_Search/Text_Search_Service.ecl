/*--SOAP--
<message name="Text_Search_Service">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	<part name="Score" type="xsd:boolean"/>
	<part name="Show_Search" type="xsd:boolean"/>
	<part name="Run_Search" type="xsd:boolean"/>
	<part name="Show_Hits" type="xsd:boolean"/>
	<part name="Count_Only" type="xsd:boolean"/>	
	<part name="Retrieve_Docs" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Text Search.
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--HELP-- Accepts a search.  Will use phrase, AND, and OR.
Segment restrictions are currently working, but are only supported in the form 
SegmentName(SearchTerm). <p/> 
The current text collection is the sthe Jan 21st 1992 WSJ 
articles from TReC. <p/>
*/

export Text_Search_Service := MACRO
STRING srchString := '' : STORED('Search');
BOOLEAN score := FALSE : STORED('Score');
BOOLEAN showSearch := FALSE : STORED('Show_Search');
BOOLEAN runSearch := FALSE : STORED('Run_Search');
BOOLEAN countOnly := FALSE : STORED('Count_Only');
BOOLEAN showHits	:= FALSE : STORED('Show_Hits');
BOOLEAN getDocs   := FALSE : STORED('Retrieve_Docs');


STRING stem		:= '~THOR::VALIDATE';
STRING srcType := 'TREC';
STRING qual := 'WSJ0121';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);


m := Text_Search.Text_Search_Module(info,srchString,score,showHits,,,runSearch);
IF(runSearch, OUTPUT(m.totalCount, NAMED('Result_Count')));
IF(runSearch AND ~countOnly, OUTPUT(m.answers, NAMED('RESULTS_Hits')));

IF(showSearch, OUTPUT(m.rpn_srch, NAMED('RESULTS_RPN')));

OUTPUT(m.error_code, NAMED('RESULTS_Error_Code'));
OUTPUT(m.error_msg, NAMED('RESULTS_Error_Msg'));

docs := Text_Search.RetrieveDoc(m.answers, info, TRUE);
IF(getDocs, OUTPUT(docs, NAMED('RESULTS_Docs')));

ENDMACRO;