import header, watchdog, ut, data_services;

h := header.prepped_for_keys;

r := record
  unsigned4 zip;
  string1   gender;
  unsigned6 did;
  unsigned6 first_seen;
  unsigned6 last_seen;
  unsigned1 age;
  unsigned8 states;
  end;
  

r into(h le) := transform
  self.gender := datalib.gender(le.fname);
  self.zip := (unsigned4)le.zip;
  self.age := 0;
  self := le;
  end;

t := distribute(project(h,into(left)),hash(did));

r rollit(r le,r ri) := transform
  self.first_seen := if ( le.first_seen < ri.first_seen and le.first_seen<>0, le.first_seen, ri.first_seen );
  self.last_seen := if ( le.last_seen > ri.last_seen, le.last_seen, ri.last_seen );
  self := le;
  end;

st := rollup(sort(t,did,zip,local),left.did=right.did and left.zip=right.zip,rollit(left,right),local);

r get_age(r le, watchdog.file_best ri) := transform
	self.age := IF(ri.dob = 0, 0, ut.getage((STRING)ri.dob));
	self := le;
	end;

ag := JOIN(st, watchdog.File_Best, LEFT.did = RIGHT.did, get_age(LEFT, RIGHT), LOCAL);

r correct_reversals(r le) := transform
  self.first_seen := IF ( le.last_seen<le.first_seen, le.last_seen, le.first_seen );
  self.last_seen := IF ( le.last_seen>=le.first_seen, le.last_seen, le.first_seen );
  self := le;
  end;

p:= project(ag,correct_reversals(left));

export Key_Troy_Prep := INDEX(p,{p}, data_services.data_location.prefix() + 'thor_data400::key::troy' + thorlib.WUID());