UNSIGNED1 threshhold := 75;

count(Equifax.File_DID_Test_Match(TRUE));                                            // 1,425,756
count(Equifax.File_DID_Test_Match(did<>0 AND did_score >= threshhold));              // 1,091,119
count(Equifax.File_DID_Test_Match(did=0 OR (did <> 0 AND did_score < threshhold)));  //   334,647
count(Equifax.File_DID_Test_Match(cid<>''));                                         //   607,348
count(Equifax.File_DID_Test_Match(cid=''));                                          //   818,408
count(Equifax.File_DID_Test_Match(did<>0 AND did_score >= threshhold, cid<>''));     //   604,596
count(Equifax.File_DID_Test_Match(did<>0 AND did_score >= threshhold, cid=''));      //   486,523
count(Equifax.File_DID_Test_Match(did=0 OR (did <> 0 AND did_score < threshhold), cid<>''));    //     2,752
count(Equifax.File_DID_Test_Match(did=0 OR (did <> 0 AND did_score < threshhold), cid=''));     //   331,885