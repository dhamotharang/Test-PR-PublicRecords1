Sample1 := DATASET('TMTEMP::Equifax_Sample1', Equifax.Layout_DID_Test_Match, THOR);
Sample2 := DATASET('TMTEMP::Equifax_Sample2', Equifax.Layout_DID_Test_Match, THOR);
Sample3 := DATASET('TMTEMP::Equifax_Sample3', Equifax.Layout_DID_Test_Match, THOR);
Sample4 := DATASET('TMTEMP::Equifax_Sample4', Equifax.Layout_DID_Test_Match, THOR);

output(choosen(Sample1,0));
output(choosen(Sample2,0));
output(choosen(Sample3,0));
output(choosen(Sample4,0));