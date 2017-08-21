adds    := distribute(Gong_v2.file_DailyAdditions,hash(recordid));
deletes := distribute(Gong_v2.file_DailyDeletions,hash(recordid));

r1 := record
 string11 del_dt;
 string11 original_add_dt;
 recordof(adds);
end;

r1 t_get_orig_add(adds le, deletes ri) := transform
 self.del_dt          := ri.filedate;
 self.original_add_dt := le.filedate;
 self                 := le;
end;

j1 := join(adds,deletes,left.recordid=right.recordid,t_get_orig_add(left,right),local);

export getDeletesOrigAddRec := j1 : persist('~thor400_84::persist::gong_deletes_original_add_record');