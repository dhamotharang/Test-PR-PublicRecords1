import ut;

w_aid := FLAccidents.aid_files.flcrash4;

Layout_FLCrash4_Base precs(w_aid L) := transform
self := L;
end;

wo_aid := project(w_aid,precs(left));
 
export BaseFile_FLCrash4 := wo_aid;