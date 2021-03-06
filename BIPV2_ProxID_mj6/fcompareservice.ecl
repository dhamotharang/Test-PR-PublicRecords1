IMPORT SALT24,BIPV2_ProxID_mj6,ut,tools;
export fcompareservice(
   string proxid1 
  ,string proxid2
  ,string pversion = 'qa'
) := 
function
string version        := pversion;
STRING50 Proxidonestr := proxid1  ;
STRING20 Proxidtwostr := proxid2 ;
both := pversion;
UNSIGNED8 Proxidone0 := (UNSIGNED8)ut.Word(Proxidonestr,1); // Allow for two token on a line input
UNSIGNED8 Proxidtwo0 := (UNSIGNED8)(IF(Proxidtwostr='*',ut.Word(Proxidonestr,2),Proxidtwostr));
UNSIGNED8 Proxidone := IF( Proxidone0>Proxidtwo0, Proxidone0, Proxidtwo0 );
UNSIGNED8 Proxidtwo := IF( Proxidone0>Proxidtwo0, Proxidtwo0, Proxidone0 );
BFile := BIPV2_ProxID_mj6.In_DOT_Base;
odl := PROJECT(CHOOSEN(BIPV2_ProxID_mj6.Keys(BFile,both).Candidates(Proxid=Proxidone),100000),BIPV2_ProxID_mj6.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_ProxID_mj6.Keys(BFile,both).Candidates(Proxid=ProxidTwo),100000),BIPV2_ProxID_mj6.match_candidates(BFile).layout_candidates);
k := BIPV2_ProxID_mj6.Keys(BFile,both).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_ProxID_mj6.Layout_Specificities.R)[1]);
odlv := BIPV2_ProxID_mj6.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_ProxID_mj6.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_ProxID_mj6.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],BIPV2_ProxID_mj6.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 4944704 data
tools.mac_LayoutTools(recordof(mtch),layouttools,false,false,'^(?!.*?(left|right|skipped).*).*$',true);
mtch_score := project(mtch,layouttools.layout_record);
ProxidOneFieldValues := OUTPUT( odlv,NAMED('ProxidOneFieldValues'));
ProxidTwoFieldValues := OUTPUT( odrv,NAMED('ProxidTwoFieldValues'));
// Put out the actually matching information
RecordMatches := OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
//output(layouttools);
RecordMatchesScoreOnly := SORT(mtch_score,-Conf);
// The raw data - for the truly psycho!
ProxidOneRecords := OUTPUT( odl,NAMED('ProxidOneRecords'));
ProxidTwoRecords := OUTPUT( odr,NAMED('ProxidTwoRecords'));
  return RecordMatchesScoreOnly;
  
end;
