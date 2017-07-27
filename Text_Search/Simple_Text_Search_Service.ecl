/*--SOAP--
<message name="Simple_Text_Search_Service">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	<part name="Score" type="xsd:boolean"/>
	<part name="Show_Search" type="xsd:boolean">
		<html>
			<td width="20%"><font face="Verdana" size="2">Show Search:</font></td>
			<td><input type="checkbox" name="Show_Search" checked="true"/></td>
		</html>
	</part>
	<part name="Run_Search" type="xsd:boolean">
		<html>
			<td width="20%"><font face="Verdana" size="2">Run Search:</font></td>
			<td><input type="checkbox" name="Run_Search" checked="true"/></td>
		</html>
	</part>
	<part name="ExpEqv" type="xsd:boolean">
		<html>
			<td width="20%"><font face="Verdana" size="2">Expand Equivalences:</font></td>
			<td><input type="checkbox" name="ExpEqv" checked="true"/></td>
		</html>
	</part>
	<part name="DrctExp" type="xsd:boolean">
		<html>
			<td width="20%"><font face="Verdana" size="2">Expand Directionals:</font></td>
			<td><input type="checkbox" name="DrctExp" checked="false"/></td>
		</html>
	</part>
	<part name="Show_Hits" type="xsd:boolean"/>
	<part name="Count_Only" type="xsd:boolean"/>	
	<part name="Retrieve_Docs" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Simple Text Search.
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--HELP-- Accepts a search.  Will use phrase, AND, AND NOT, and OR.
Segment restrictions are currently working.<p/> 
The text collection is the regression set.<p/>
*/

export Simple_Text_Search_Service := MACRO
STRING srchString := '' : STORED('Search');
BOOLEAN score := FALSE : STORED('Score');
BOOLEAN showSearch := FALSE : STORED('Show_Search');
BOOLEAN runSearch := FALSE : STORED('Run_Search');
BOOLEAN countOnly := FALSE : STORED('Count_Only');
BOOLEAN showHits	:= FALSE : STORED('Show_Hits');
BOOLEAN getDocs		:= FALSE : STORED('Retrieve_Docs');
BOOLEAN expEqv		:= FALSE : STORED('ExpEqv');
BOOLEAN drctExp		:= FALSE : STORED('DrctExp');


STRING stem		:= '~THOR::REGRESSION';
STRING srcType := 'SIMPLE';
STRING qual := 'SMALL_TEST';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);


m := Text_Search.Text_Search_Module(info,srchString,score,showHits,,,
																		runSearch, expEqv, drctExp);
IF(runSearch, OUTPUT(m.totalCount, NAMED('Result_Count')));
IF(runSearch AND ~countOnly, OUTPUT(m.answers, NAMED('RESULTS_Hits')));

IF(showSearch, OUTPUT(m.rpn_srch, NAMED('RESULTS_RPN')));

OUTPUT(m.error_code, NAMED('RESULTS_Error_Code'));
OUTPUT(m.error_msg, NAMED('RESULTS_Error_Msg'));
OUTPUT(m.ndx_name, NAMED('RESULTS_Index_Name'));
OUTPUT(m.dct_name, NAMED('RESULTS_Dictionary_Name'));
OUTPUT(m.Dictversion, NAMED('RESULTS_Dictionary_Ver'));

docs := Text_Search.RetrieveDocSeg(m.answers, info, TRUE);
IF(getDocs, OUTPUT(docs, NAMED('RESULTS_Docs')));

ENDMACRO;