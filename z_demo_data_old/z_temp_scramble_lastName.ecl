
rec_lnames:=RECORD
string30 fname;
string30 mname;
string30 lname;
END;
ds_in := DATASET([
{'Robert', 'H', 'VanHeusen'},
{'Jayant', 'D', 'Sardeshmukh'},
{'Kim', 'Mary', 'Hester'},
{'Armando', 'S', 'Escalante'},
{'Tony', 'M', 'Kirk'},
{'ROGER', 'A', 'SMITH'},
{'Tammy', 'A', 'GIBSON'}



],rec_lnames);

rec_seq := RECORD
integer5 seq;
string30 fname;
string30 mname;
string30 lname
END;

rec_seq hashit(ds_in l):= transform
self.seq := hash(l.lname)%1300;
self:=l;
END;

ds_seq:=sort(PROJECT(ds_in,hashit(left)),seq);
ds_scramble:=sort(gen_lastNames,seq);
//
rec_seq scrambleit(ds_seq l, ds_scramble r) := TRANSFORM
self.lname := r.lname;
self := l;
END;

export _temp_scramble_lastName := JOIN(ds_seq,ds_scramble,left.seq= right.seq,scrambleit(LEFT,RIGHT), LEFT OUTER, LOOKUP);
//export scramble_lastName := 'todo';