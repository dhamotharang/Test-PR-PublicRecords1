import DID_Add,Header_SlimSort,ut,crim,header;

appendClean := distribute(CRIM.File_FL_Append,hash(DLE_number));
identClean := distribute(CRIM.File_FL_Identity,hash(DLE));

//Get latest process date per SID
one_date := dedup(sort(appendClean,DLE_number,-file_date,local),DLE_number,local);

typeof(appendClean) getDatesAP(appendClean L, one_date R) := transform
 self := l;
end;

latestAP := join(appendClean,one_date,left.DLE_number=right.DLE_number and left.file_date=right.file_date,
					getDatesAP(left,right),local);

typeof(identClean) getDatesID(identClean L, latestAP R) := transform
 self := l;
end;

dupID := join(identClean,latestAP,left.DLE=right.DLE_number and left.file_date=right.file_date,
					getDatesID(left,right),local);

latestID := dedup(sort(dupID,record,local),local);

//Put into common layout
minibuild.Layout_FL_Crim_Common getAppend(latestAP L) := transform
 self.SID := l.DLE_number;
 self.src := 'FC';
 self.fname := l.fname;
 self.mname := l.mname;
 self.lname := l.lname;
 self.name_suffix := l.suffix;
 self.ssn := l.ssn;
 self.dob := (integer)l.dob;
 self.process_date := l.file_date;
 self.place_birth := '';
 self.occupation := '';
 self.race := '';
 self.sex := '';
 self.hair_color := '';
 self.eye_color := '';
 self.weight := 0;
 self.height := 0;
 self.prim_range := '';
 self.predir := '';
 self.prim_name := '';
 self.suffix := '';
 self.postdir := '';
 self.unit_desig := '';
 self.sec_range := '';
 self.v_city := '';
 self.st := '';
 self.zip := '';
 self.zip4 := '';
 self.smt := trim(l.SMT);
end;
append := project(latestAP,getAppend(left));

minibuild.Layout_FL_Crim_Common getIdent(latestID L) := transform
 self.SID := l.DLE;
 self.src := 'FC';
 self.fname := '';
 self.mname := '';
 self.lname := '';
 self.name_suffix := '';
 self.ssn := '';
 self.process_date := l.file_date;
 self.place_birth := l.POB;
 self.occupation := l.OCCUPATION;
 self.dob := (integer)l.MASTER_DOB;
 self.race := crim.Race_2Standard('FL',l.RACE1);
 self.sex := crim.Sex_2Standard('FL', l.SEX);
 self.hair_color := crim.Hair_2Standard('FL',l.HAIR);
 self.eye_color := crim.Eye_2Standard('FL',l.EYE);
 self.weight := (INTEGER)l.WEIGHT;
 self.height := (INTEGER)l.HEIGHT;
 self.prim_range := l.prim_range;
 self.predir := l.predir;
 self.prim_name := l.prim_name;
 self.suffix := l.addr_suffix;
 self.postdir := l.postdir;
 self.unit_desig := l.unit_desig;
 self.sec_range := l.sec_range;
 self.v_city := l.city_name;
 self.st := l.st;
 self.zip := l.zip;
 self.zip4 := l.zip4;
 self.smt := '';
end;

ident := project(latestID,getIdent(left));

dob_rec := record
 string8 sid;
 integer4 dob;
end;

dob_rec idDOB(ident L) := transform
 self := l;
end;

dob_rec appDOB(append L) := transform
 self := l;
end;
 
id_dob := project(ident,idDOB(left))(dob>0);
app_dob := project(append,appDOB(left))(dob>0);

all_dobs := dedup(sort(id_dob+app_dob,sid,local),local);

minibuild.Layout_FL_Crim_Common fillIn(minibuild.Layout_FL_Crim_Common L, minibuild.Layout_FL_Crim_Common R) := transform
 self.process_date := r.process_date;
 self.place_birth := r.place_birth;
 self.occupation := r.occupation;
 self.dob := r.DOB;
 self.race := r.RACE;
 self.sex := r.SEX;
 self.hair_color := r.hair_color;
 self.eye_color := r.eye_color;
 self.weight := r.WEIGHT;
 self.height := r.HEIGHT;
 self.prim_range := r.prim_range;
 self.predir := r.predir;
 self.prim_name := r.prim_name;
 self.suffix := r.suffix;
 self.postdir := r.postdir;
 self.unit_desig := r.unit_desig;
 self.sec_range := r.sec_range;
 self.v_city := r.v_city;
 self.st := r.st;
 self.zip := r.zip;
 self.zip4 := r.zip4;
 self := l;
end;

allInfo := join(append,ident,left.sid=right.sid,fillIn(left,right),local);

minibuild.Layout_FL_Crim_Common getDOBs(minibuild.Layout_FL_Crim_Common L, dob_rec R) := transform
 self.dob := r.dob;
 self := l;
end;

sec_dob := join(allInfo,all_dobs,left.sid=right.sid,getDOBs(left,right),local);

export FL_Crim_Person := dedup(allInfo+sec_dob,all) : persist('persist::fl_crim_person');