import PromoteSupers;

curr_wa_residents := header_quick.file_header_quick(st='WA' and rec_type='1' and did>0);

r1 := record
 curr_wa_residents.did;
end;

r1 t1(curr_wa_residents le) := transform
 self := le;
end;

p1      := project(curr_wa_residents,t1(left));
p1_dist := distribute(p1,hash(did));
p1_dupd := dedup(p1_dist,did,all,local);

PromoteSupers.mac_sf_buildprocess(p1_dupd,'~thor_data400::base::current_wa_residents',build_wa_residents,2);

export proc_build_current_wa_residents_file := build_wa_residents;