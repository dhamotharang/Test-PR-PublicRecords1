UNSIGNED1 threshhold := 75;

output(choosen(Equifax.File_DID_Test_Match(did<>0  AND did_score >= threshhold, cid<>''),2000),,'TMTEMP::Equifax_Sample1',OVERWRITE);
output(choosen(Equifax.File_DID_Test_Match(did<>0 AND did_score >= threshhold, cid=''),2000),,'TMTEMP::Equifax_Sample2',OVERWRITE);
output(choosen(Equifax.File_DID_Test_Match(did=0 OR (did <> 0 AND did_score < threshhold), cid<>''),2000),,'TMTEMP::Equifax_Sample3',OVERWRITE);
output(choosen(Equifax.File_DID_Test_Match(did=0 OR (did <> 0 AND did_score < threshhold), cid=''),2000),,'TMTEMP::Equifax_Sample4',OVERWRITE);