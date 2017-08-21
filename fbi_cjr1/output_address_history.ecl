//
with_all := fbi_cjr1.prep_output;

layout_slim_address_history := record
  // unsigned4 score;
  unsigned6	did;
  // string9	best_ssn:='';
  string9	ssn;
  // unsigned1 crim_records;
  // unsigned1 sor_records;
  // string120	name;
  string120	best_name:='';
  // integer4	dob;
  integer4	best_dob:=0;
  string10	phone;
  unsigned4	first_seen;
  unsigned4	last_seen;
  string120	addr1;
  string120	addr2;
  // string10	best_phone:='';
  // unsigned4	best_first_seen:=0;
  // unsigned4	best_last_seen:=0;
  // string120	best_addr1:='';
  // string120	best_addr2:='';
  // string8	best_dod:='';
  // string2    best_dl_state:='';
  // string25   best_dl_number:='';
  // string5    best_height:='';
  // string5	best_weight:='';
  // string25	best_race:='';
  // string10	best_gender:='';
  // string25	best_eye_color:='';
  // string25	best_hair_color:='';
  end;
layout_slim_address_history to_slim_address_history(with_all l) := transform
 self := l;
end;
address_history_slimmed := project(with_all,to_slim_address_history(left));

layout_slim_address_history to_rollup_address_history(address_history_slimmed l,address_history_slimmed r) := transform
 self.first_seen := if(l.first_seen<r.first_seen and l.first_seen<>0, l.first_seen,r.first_seen);
 self.last_seen := if(l.last_seen>r.last_seen and r.last_seen<>0, l.last_seen, r.last_seen);
 self.phone := if(l.phone<>'', l.phone, r.phone);
 self.ssn := if(l.ssn<>'', l.ssn, r.ssn);
 self := l;
end;
address_history_rolledup := rollup(sort(distribute(address_history_slimmed,hash(did)),did,addr1,addr2,local),to_rollup_address_history(left,right), left.did=right.did and left.addr1=right.addr1 and left.addr2=right.addr2,local);

export output_address_history := address_history_rolledup;

// sw := sort(with_all,did,-first_seen);
// sws := dedup(sw,score,did);
// output(count(dj),named('Individuals'));
// output(choosen(sws,10000),named('IndividualList'));
