import FLAccidents, ut;

w_aid := aid_files.flcrash9;

Layout_FLCrash9_Base precs(w_aid L) := transform
self := L;
end;

wo_aid := project(w_aid,precs(left));

export BaseFile_FLCrash9 := wo_aid;