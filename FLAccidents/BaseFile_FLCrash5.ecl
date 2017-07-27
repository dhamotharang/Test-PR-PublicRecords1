import ut;

w_aid := FLAccidents.aid_files.flcrash5;

Layout_FLCrash5_Base precs(w_aid L) := transform
self := L;
end;

wo_aid := project(w_aid,precs(left));
 
export BaseFile_FLCrash5 := wo_aid;