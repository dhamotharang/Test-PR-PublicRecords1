/*--SOAP--
<message name="SeleidCompareService">
<part name="SeleidOne" type="xsd:string"/>
<part name="SeleidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT SeleidCompareService := MACRO
  IMPORT SALT30,BIPV2_Best_Seleid,ut;
STRING50 Seleidonestr := ''  : STORED('SeleidOne');
STRING20 Seleidtwostr := '*'  : STORED('Seleidtwo');
UNSIGNED8 Seleidone0 := (UNSIGNED8)ut.Word(Seleidonestr,1); // Allow for two token on a line input
UNSIGNED8 Seleidtwo0 := (UNSIGNED8)(IF(Seleidtwostr='*',ut.Word(Seleidonestr,2),Seleidtwostr));
UNSIGNED8 Seleidone := IF( Seleidone0>Seleidtwo0, Seleidone0, Seleidtwo0 );
UNSIGNED8 Seleidtwo := IF( Seleidone0>Seleidtwo0, Seleidtwo0, Seleidone0 );
BFile := BIPV2_Best_Seleid.In_Base;
odl := PROJECT(CHOOSEN(BIPV2_Best_Seleid.Keys(BFile).Candidates(Seleid=Seleidone),100000),BIPV2_Best_Seleid.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_Best_Seleid.Keys(BFile).Candidates(Seleid=SeleidTwo),100000),BIPV2_Best_Seleid.match_candidates(BFile).layout_candidates);
k := BIPV2_Best_Seleid.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_Best_Seleid.Layout_Specificities.R)[1]);
odlv := BIPV2_Best_Seleid.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_Best_Seleid.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_Best_Seleid.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Seleidone,Seleidtwo,0,0}],BIPV2_Best_Seleid.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 5195232 data
OUTPUT( odlv,NAMED('SeleidOneFieldValues'));
OUTPUT( odrv,NAMED('SeleidTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('SeleidOneRecords'));
OUTPUT( odr,NAMED('SeleidTwoRecords'));
ENDMACRO;
 
