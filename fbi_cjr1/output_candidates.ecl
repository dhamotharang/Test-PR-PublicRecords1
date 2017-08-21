//
with_all := fbi_cjr1.prep_output;

layout_slim_person := record
  // unsigned4 score;
  unsigned6	did;
  string9	best_ssn:='';
  unsigned1 crim_records;
  unsigned1 sor_records;
  // unsigned4	first_seen;
  // unsigned4	last_seen;
  // string10	phone;
  // string9	ssn;
  // integer4	dob;
  // string120	name;
  // string120	addr1;
  // string120	addr2;
  string120	best_name:='';
  integer4	best_dob:=0;
  string10	best_phone:='';
  // unsigned4	best_first_seen:=0;
  // unsigned4	best_last_seen:=0;
  // string120	best_addr1:='';
  // string120	best_addr2:='';
  string8	best_dod:='';
  string2   best_dl_state:='';
  string25  best_dl_number:='';
  string5   best_height:='';
  string5	best_weight:='';
  string25	best_race:='';
  string10	best_gender:='';
  string25	best_eye_color:='';
  string25	best_hair_color:='';
  end;
layout_slim_person to_person(with_all l) := transform
self.best_gender := if(l.best_gender<>'',l.best_gender,datalib.gender(l.best_fname));

self := l;
end;

persons := dedup(sort(distribute(project(with_all, to_person(left)),hash(did)),record,local),record,local);

export output_candidates := persons;

// sw := sort(with_all,did,-first_seen);
// sws := dedup(sw,score,did);
// output(count(dj),named('Individuals'));
// output(choosen(sws,10000),named('IndividualList'));
