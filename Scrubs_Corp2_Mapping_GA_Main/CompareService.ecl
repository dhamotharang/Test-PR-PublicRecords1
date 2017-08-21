/*--SOAP--
<message name="CompareService">
<part name="One" type="xsd:string"/>
<part name="Two" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT CompareService := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_GA_Main,ut;
STRING50 onestr := ''  : STORED('One');
STRING20 twostr := '*'  : STORED('two');
UNSIGNED8 one0 := (UNSIGNED8)ut.Word(onestr,1); // Allow for two token on a line input
UNSIGNED8 two0 := (UNSIGNED8)(IF(twostr='*',ut.Word(onestr,2),twostr));
UNSIGNED8 one := IF( one0>two0, one0, two0 );
UNSIGNED8 two := IF( one0>two0, two0, one0 );
BFile := Scrubs_Corp2_Mapping_GA_Main.In_in_file;
odl := PROJECT(CHOOSEN(Scrubs_Corp2_Mapping_GA_Main.Keys(BFile).Candidates(=one),100000),Scrubs_Corp2_Mapping_GA_Main.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(Scrubs_Corp2_Mapping_GA_Main.Keys(BFile).Candidates(=Two),100000),Scrubs_Corp2_Mapping_GA_Main.match_candidates(BFile).layout_candidates);
k := Scrubs_Corp2_Mapping_GA_Main.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,Scrubs_Corp2_Mapping_GA_Main.Layout_Specificities.R)[1]);
odlv := Scrubs_Corp2_Mapping_GA_Main.Debug(BFile,s).RolledEntities(odl);
odrv := Scrubs_Corp2_Mapping_GA_Main.Debug(BFile,s).RolledEntities(odr);
mtch := Scrubs_Corp2_Mapping_GA_Main.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,one,two,0,0}],Scrubs_Corp2_Mapping_GA_Main.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the  data
OUTPUT( odlv,NAMED('OneFieldValues'));
OUTPUT( odrv,NAMED('TwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('OneRecords'));
OUTPUT( odr,NAMED('TwoRecords'));
ENDMACRO;
 
