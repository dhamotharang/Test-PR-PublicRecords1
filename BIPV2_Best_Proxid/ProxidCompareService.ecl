/*--SOAP--
<message name="ProxidCompareService">
<part name="ProxidOne" type="xsd:string"/>
<part name="ProxidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT ProxidCompareService := MACRO
  IMPORT SALT30,BIPV2_Best_Proxid,ut;
STRING50 Proxidonestr := ''  : STORED('ProxidOne');
STRING20 Proxidtwostr := '*'  : STORED('Proxidtwo');
UNSIGNED8 Proxidone0 := (UNSIGNED8)ut.Word(Proxidonestr,1); // Allow for two token on a line input
UNSIGNED8 Proxidtwo0 := (UNSIGNED8)(IF(Proxidtwostr='*',ut.Word(Proxidonestr,2),Proxidtwostr));
UNSIGNED8 Proxidone := IF( Proxidone0>Proxidtwo0, Proxidone0, Proxidtwo0 );
UNSIGNED8 Proxidtwo := IF( Proxidone0>Proxidtwo0, Proxidtwo0, Proxidone0 );
BFile := BIPV2_Best_Proxid.In_Base;
odl := PROJECT(CHOOSEN(BIPV2_Best_Proxid.Keys(BFile).Candidates(Proxid=Proxidone),100000),BIPV2_Best_Proxid.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_Best_Proxid.Keys(BFile).Candidates(Proxid=ProxidTwo),100000),BIPV2_Best_Proxid.match_candidates(BFile).layout_candidates);
k := BIPV2_Best_Proxid.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_Best_Proxid.Layout_Specificities.R)[1]);
odlv := BIPV2_Best_Proxid.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_Best_Proxid.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_Best_Proxid.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],BIPV2_Best_Proxid.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 5195232 data
OUTPUT( odlv,NAMED('ProxidOneFieldValues'));
OUTPUT( odrv,NAMED('ProxidTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('ProxidOneRecords'));
OUTPUT( odr,NAMED('ProxidTwoRecords'));
ENDMACRO;
 
