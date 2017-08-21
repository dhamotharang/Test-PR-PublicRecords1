//current_record logic today likely is not flagging the original deed record
//in those instances of a subsequent transaction (i.e. home equity line)
//this is intended to bring in all records where the current_owner & aid pair
//ever hold true

curr_people := dedup(sort(distribute(ixi.get_people_current,hash(aid)),aid,did,local),aid,did,local);
all_deeds   := distribute(ixi.get_deed,hash(aid));

recordof(all_deeds) t1(all_deeds le, curr_people ri) := transform
 self := le;
end;

j1 := join(all_deeds,curr_people,left.aid=right.aid and left.did=right.did,t1(left,right),local);

export get_deed_current := j1 : persist('persist::ixi_get_deed_current'+variables.pst_suffix);