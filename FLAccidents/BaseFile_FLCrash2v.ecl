import ut;

w_aid := FLAccidents.aid_files.flcrash2v;

Layout_FLCrash2v_Base precs(w_aid L) := transform
self := L;
end;

wo_aid := project(w_aid,precs(left));
 
export BaseFile_FLCrash2v := wo_aid;