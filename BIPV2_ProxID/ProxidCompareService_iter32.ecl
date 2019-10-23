/*--SOAP--
<message name="ProxidCompareService">
<part name="ProxidOne" type="xsd:string"/>
<part name="ProxidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT ProxidCompareService_iter32 := MACRO
IMPORT SALT24,BIPV2_ProxID,ut,tools,BIPV2;
STRING50 Proxidonestr := ''   : STORED('ProxidOne');
STRING20 Proxidtwostr := '*'  : STORED('Proxidtwo');
string   iteration    := '32'  ;
string version        := BIPV2.KeySuffix;
string both := version + '_' + iteration;
UNSIGNED8 Proxidone0 := (UNSIGNED8)ut.Word(Proxidonestr,1); // Allow for two token on a line input
UNSIGNED8 Proxidtwo0 := (UNSIGNED8)(IF(Proxidtwostr='*',ut.Word(Proxidonestr,2),Proxidtwostr));
UNSIGNED8 Proxidone := IF( Proxidone0>Proxidtwo0, Proxidone0, Proxidtwo0 );
UNSIGNED8 Proxidtwo := IF( Proxidone0>Proxidtwo0, Proxidtwo0, Proxidone0 );
BFile := BIPV2_ProxID.In_DOT_Base;
odl := PROJECT(CHOOSEN(BIPV2_ProxID.Keys(BFile,both).Candidates(Proxid=Proxidone),100000),BIPV2_ProxID.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_ProxID.Keys(BFile,both).Candidates(Proxid=ProxidTwo),100000),BIPV2_ProxID.match_candidates(BFile).layout_candidates);
k := BIPV2_ProxID.Keys(BFile,both).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_ProxID.Layout_Specificities.R)[1]);
odlv := BIPV2_ProxID.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_ProxID.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_ProxID.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],BIPV2_ProxID.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 4944704 data
tools.mac_LayoutTools(recordof(mtch),layouttools,false,false,'^(?!.*?(left|right|skipped).*).*$',true);
mtch_score := project(mtch,layouttools.layout_record);
OUTPUT( odlv,NAMED('ProxidOneFieldValues'));
OUTPUT( odrv,NAMED('ProxidTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
//output(layouttools);
OUTPUT( SORT(mtch_score,-Conf),NAMED('RecordMatchesScoreOnly'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('ProxidOneRecords'));
OUTPUT( odr,NAMED('ProxidTwoRecords'));
ENDMACRO;
