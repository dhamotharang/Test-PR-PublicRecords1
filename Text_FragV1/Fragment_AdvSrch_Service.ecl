/*--SOAP--
<message name="Fragment_AdvSrch_Service">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	<part name="Terms_Connectors" type="xsd:boolean"/>
	<part name="Rank_Result" type="xsd:boolean"/>
	<part name="Answer_Limit" type="xsd:integer"/>
	<part name="Show_Search_Only" type="xsd:boolean"/>
	<part name="Show_Hits" type="xsd:boolean"/>
	<part name="Count_Only" type="xsd:boolean"/>	
	<part name="LAFN_Disabled" type="xsd:boolean"/>
	<part name="LAFN_Limit" type="xsd:integer"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
</message>
*/
/*--INFO-- Fragment Advanced Search.  This version searchs
complete set of data instead of sample.
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--HELP-- Accepts a search.  If Terms &amp; Connectors is
set, the search is treated as a Boolean Search.  The results 
can be ranked or left in natural sort order. 
*/

// The following are not currently available:
//	<part name="Focus_Doc_List" type="tns:EspStringArray"/>
//	<part name="Bookmark_List" type="tns:xmlDataset"/>

EXPORT Fragment_AdvSrch_Service := MACRO
// Arguments

stdInterface := AutoStandardI.GlobalModule();		
stdSearchArg := Text_Search.StandardSearchArgs;

BOOLEAN runSearch := stdSearchArg.runSearch;
BOOLEAN countOnly := stdSearchArg.countOnly;
UNSIGNED2 docLimit:= stdSearchArg.ansLimit;
BOOLEAN showHits  := stdSearchArg.showHits;

STRING stem := '~THOR_DATA400::FULL';
STRING sourceType := 'FRAGS';
STRING qual := '';

info := Text_Search.FileName_Info_Instance(stem, sourceType, qual);
ansIndxAlias:= Text_FragV1.FileName(info, Text_FragV1.Types.FileType.AnswerDocX);
ansIndx := Text_FragV1.Indx_AnsRec(ansIndxAlias);

initBookMarks := DATASET([], Text_Search.Layout_Bookmark);

m := Text_Search.Text_Search_V3(info, stdSearchArg);

IF(runSearch, OUTPUT(m.totalCount, NAMED('Result_Count')));

OUTPUT(m.error_code, NAMED('RESULTS_Error_Code'));
OUTPUT(m.error_msg, NAMED('RESULTS_Error_Msg'));

answerRecs := JOIN(m.answers, ansIndx, 
									KEYED(LEFT.docRef.src=RIGHT.src AND LEFT.docRef.doc=RIGHT.doc),
									TRANSFORM(Text_FragV1.Layout_AnswerListData, SELF:=RIGHT),
									LIMIT(0));
IF(runSearch, OUTPUT(answerRecs, NAMED('Result_AnswerRecords')));

OUTPUT(m.rpn_srch, NAMED('Result_RPN'));

IF(runSearch AND ~countOnly, OUTPUT(m.answers, NAMED('Result_Hits')));
segs := Text_Search.Segment_Display_Items(info);
IF(runSearch AND showHits, OUTPUT(segs, NAMED('Result_Segment_Map')));


ENDMACRO;