import Gong,Gong_v2,header_services;

//infile := Gong_v2.File_GongMaster;
infile:= Gong.File_History;

Gong_v2.Layout_bscurrent_raw tr(infile L ) := transform
self.seisintid :='';
self.sequence_number := (unsigned integer8)L.sequence_number;
self.privacy_flag := L.cr_sort_sz;
self := L;
end;

p_infile := project(infile,tr(left));

Gong_v2.mac_apply_legal(p_infile,outlegal);
outfile:= outlegal: persist(Gong_v2.thor_cluster+'persist::gong_v2::hist_mac_apply_legal')
;

export proc_roxie_keybuild_prep := outfile;