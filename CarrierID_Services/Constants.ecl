export Constants := module

 export applicationType           := 'INS';
 export max_recs_to_process       := 1000;
 export max_involved_passengers   := 20;
 export max_involved_otherparties := 10;
 export max_recs_on_join          := 100;
 export max_recs_to_return        := 25;

 export flacc_set        := ['FA'];
 export ecrash_set       := ['EA'];
 export natl_keyed_set   := ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
 export natl_inquiry_set := ['IA','IB','IC','ID','IE','IF','IG','IH','II','IJ','IK','IL','IM','IN','IO','IP','IQ','IR','IS','IT','IU','IV','IW','IX','IY','IZ','I1','I2','I3','I4','I5','I6','I7','I8','I9'];
 export en_set           := ['EN'];
 export fs_set           := ['FS'];
 
 export str_flacc                 := 'FLAcc';
 export str_ecrash                := 'eCrash';
 export str_natlacc               := 'NatlAcc';
 export str_natlaccinq            := 'NatlAcc-Inq';
 export str_both_sources          := 'NatlAcc + NatlAcc-Inq';
 export str_en                    := 'EN';
 export str_fs                    := 'FS';
 
 export dppa_states               := ['NC'];

end;