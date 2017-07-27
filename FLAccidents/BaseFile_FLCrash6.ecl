import ut;

w_aid := FLAccidents.aid_files.flcrash6;

Layout_FLCrash6_Base precs(w_aid L) := transform
self := L;
end;

wo_aid := project(w_aid,precs(left));
 
export BaseFile_FLCrash6 := wo_aid;