DID_Stat := DATASET('TMTEMP::Equifax_DID_Stat', Equifax.Layout_DID_Test_Match, THOR);
CID_Stat := DATASET('TMTEMP::Equifax_CID_Stat', Equifax.Layout_DID_Test_Match, THOR);

output(choosen(DID_Stat,0));
output(choosen(CID_Stat,0));