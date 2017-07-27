import ut;

w_aid := FLAccidents.aid_files.flcrashss;

layout_flcrash_srchserv precs(w_aid L) := transform
self := L;
end;

wo_aid := project(w_aid,precs(left));
 
export BaseFile_FLCrash_SS := wo_aid;