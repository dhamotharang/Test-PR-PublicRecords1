/*--SOAP--
<message name="MFINDTextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	<part name="Run_Search" type="xsd:boolean"/>
	<part name="Count_Only" type="xsd:boolean"/>
	<part name="Score" type="xsd:boolean"/>
	<part name="Max_Docs" type="xsd:integer"/>
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>

 </message>
*/
/*--INFO-- Text Search.
*/
export MFindTextSearchService := MACRO

// boolean-specific parameters
STRING srchString := '' : STORED('Search');
BOOLEAN runSearch := TRUE : STORED('Run_Search'); // Used only for debugging
BOOLEAN countOnly := FALSE : STORED('Count_Only');
BOOLEAN scoreSearch := FALSE : STORED('Score');
INTEGER maxDocs := 100 : STORED('Max_Docs');

// general-use parameters
STRING6 ssn_mask_value := 'NONE' : stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

// boolean search
STRING stem		:= '~thor_data400::base';
STRING srcType:= 'Mfind';
STRING qual		:= 'test';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);

theScoreSearch := IF(countOnly, false, scoreSearch);
theMaxDocs := IF(countOnly, 0, maxDocs);

s := Text_Search.Text_Search_Module(info, srchString, theScoreSearch,,,theMaxDocs, runSearch);

errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

// Check for bad input
IF(~noErr, ut.outputMessage(errCode, errMsg));

// count output
if(runSearch, OUTPUT(s.TotalCount, NAMED('RecordsAvailable')));


// output results
j := JOIN(s.answers,MFind.key_boolean_tmsid,keyed(LEFT.docref.src=RIGHT.src) AND keyed(LEFT.docref.doc=RIGHT.doc), KEEP(1));

// Take the best scoring per natural key, and then sort by best score
best_vids := SORT(j,-score,doc);
// Show first page
doxie.MAC_Marshall_Results_NoCount(best_vids,best_vids_paged);
vids := PROJECT(best_vids_paged,transform(MFindV2_Services.layout_search_IDs,self.vid := (string) left.doc2) );

//output(join(vids,mfind.Key_MFind_VID, left.vid=right.trim_vid));

rpen := MFindV2_Services.MFind_raw.report_view.by_vid(vids);

// patch score sort order
max_score := (UNSIGNED)(MAX(best_vids,score*100));

rpenplus :=
RECORD
	MFindV2_Services.Layout_MFind_Report;
	unsigned2 output_seq_no;
END;

rpenplus patch_scores(rpen le, best_vids_paged ri) :=
TRANSFORM
	SELF.penalt := max_score-(100*ri.score);
	SELF.output_seq_no := ri.output_seq_no;
	SELF := le;
END;
score_patched := JOIN(rpen, best_vids_paged, LEFT.trim_vid=(string) RIGHT.doc2, patch_scores(LEFT,RIGHT), LOOKUP);
score_sorted := SORT(score_patched, output_seq_no);
IF(runSearch AND ~countOnly, OUTPUT(score_sorted, NAMED('Results')));

ENDMACRO;