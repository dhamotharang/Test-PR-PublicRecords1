IMPORT SALT24,BIPV2_ProxID_dev4,ut,tools;

string iteration      := '5' : stored('iter');
string version        := BIPV2.KeySuffix + 'b';
STRING50 Proxidonestr := '1381258000'  : STORED('ProxidOne');
STRING20 Proxidtwostr := '5170474'  : STORED('Proxidtwo');

both := version + '_' + iteration;

UNSIGNED8 Proxidone0 := (UNSIGNED8)ut.Word(Proxidonestr,1); // Allow for two token on a line input
UNSIGNED8 Proxidtwo0 := (UNSIGNED8)(IF(Proxidtwostr='*',ut.Word(Proxidonestr,2),Proxidtwostr));
UNSIGNED8 Proxidone := IF( Proxidone0>Proxidtwo0, Proxidone0, Proxidtwo0 );
UNSIGNED8 Proxidtwo := IF( Proxidone0>Proxidtwo0, Proxidtwo0, Proxidone0 );
BFile := BIPV2_ProxID_dev4.In_DOT_Base;
odl := PROJECT(CHOOSEN(BIPV2_ProxID_dev4.Keys(BFile,both).Candidates(Proxid=Proxidone),100000),BIPV2_ProxID_dev4.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_ProxID_dev4.Keys(BFile,both).Candidates(Proxid=ProxidTwo),100000),BIPV2_ProxID_dev4.match_candidates(BFile).layout_candidates);
k := BIPV2_ProxID_dev4.Keys(BFile,both).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_ProxID_dev4.Layout_Specificities.R)[1]);
odlv := BIPV2_ProxID_dev4.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_ProxID_dev4.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_ProxID_dev4.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],BIPV2_ProxID_dev4.match_candidates(BFile).layout_matches));
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
