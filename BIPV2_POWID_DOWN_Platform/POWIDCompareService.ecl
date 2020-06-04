/*--SOAP--
<message name="POWIDCompareService">
<part name="POWIDOne" type="xsd:string"/>
<part name="POWIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT POWIDCompareService := MACRO
  IMPORT SALT27,BIPV2_POWID_DOWN_Platform,ut;
STRING50 POWIDonestr := ''  : STORED('POWIDOne');
STRING20 POWIDtwostr := '*'  : STORED('POWIDtwo');
UNSIGNED8 POWIDone0 := (UNSIGNED8)ut.Word(POWIDonestr,1); // Allow for two token on a line input
UNSIGNED8 POWIDtwo0 := (UNSIGNED8)(IF(POWIDtwostr='*',ut.Word(POWIDonestr,2),POWIDtwostr));
UNSIGNED8 POWIDone := IF( POWIDone0>POWIDtwo0, POWIDone0, POWIDtwo0 );
UNSIGNED8 POWIDtwo := IF( POWIDone0>POWIDtwo0, POWIDtwo0, POWIDone0 );
BFile := BIPV2_POWID_DOWN_Platform.In_POWID_Down;
odl := PROJECT(CHOOSEN(BIPV2_POWID_DOWN_Platform.Keys(BFile).Candidates(POWID=POWIDone),100000),BIPV2_POWID_DOWN_Platform.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_POWID_DOWN_Platform.Keys(BFile).Candidates(POWID=POWIDTwo),100000),BIPV2_POWID_DOWN_Platform.match_candidates(BFile).layout_candidates);
k := BIPV2_POWID_DOWN_Platform.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_POWID_DOWN_Platform.Layout_Specificities.R)[1]);
odlv := BIPV2_POWID_DOWN_Platform.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_POWID_DOWN_Platform.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_POWID_DOWN_Platform.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,POWIDone,POWIDtwo,0,0}],BIPV2_POWID_DOWN_Platform.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 5092096 data
OUTPUT( odlv,NAMED('POWIDOneFieldValues'));
OUTPUT( odrv,NAMED('POWIDTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('POWIDOneRecords'));
OUTPUT( odr,NAMED('POWIDTwoRecords'));
ENDMACRO;
 
