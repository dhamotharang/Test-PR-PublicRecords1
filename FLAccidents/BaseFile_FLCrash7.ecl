import ut;

w_aid := FLAccidents.aid_files.flcrash7;

Layout_FLCrash7_Base precs(w_aid L) := transform
self := L;
end;

wo_aid := project(w_aid,precs(left));
 
export BaseFile_FLCrash7 := wo_aid;