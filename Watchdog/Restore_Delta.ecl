#option ('thorKeys', '1');
a := watchdog.File_Moxie((integer)name_date < 20030829 and (integer)name_date > 20030503);

watchdog.Layout_Delta addName(a L) := transform
 self.did := (integer)l.did;
 self.fname := l.fname;
 self.mname := l.mname;
 self.lname := l.lname;
 self.name_suffix := l.name_suffix;
 self.run_date := (integer)l.name_date;
end;

with_name := project(a,addName(left));

b := watchdog.File_Moxie((integer)address_date < 20030829 and (integer)address_date > 20030503);

watchdog.Layout_Delta addAddr(a L) := transform
 self.did := (integer)l.did;
 self.prim_range := l.prim_range;
 self.predir := l.predir;
 self.prim_name := l.prim_name;
 self.suffix := l.suffix;
 self.postdir := l.postdir;
 self.unit_desig := l.unit_desig;
 self.sec_range := l.sec_range;
 self.city_name := l.city_name;
 self.st := l.st;
 self.zip := l.zip;
 self.zip4 := l.zip4;
 self.run_date := (integer)l.address_date;
end;

with_addr := project(b,addAddr(left));

c := watchdog.File_Moxie((integer)dob_date < 20030829 and (integer)dob_date > 20030503);

watchdog.Layout_Delta addDob(a L) := transform
 self.did := (integer)l.did;
 self.dob := (integer)l.dob;
 self.run_date := (integer)l.dob_date;
end;

with_dob := project(c,adddob(left));

d := watchdog.File_Moxie((integer)ssn_date < 20030829 and (integer)ssn_date > 20030503);

watchdog.Layout_Delta addSSN(a L) := transform
 self.did := (integer)l.did;
 self.SSN := l.SSN;
 self.run_date := (integer)l.SSN_date;
end;

with_SSN := project(d,addSSN(left));

e := watchdog.File_Moxie((integer)phone_date < 20030829 and (integer)phone_date > 20030503);

watchdog.Layout_Delta addphone(a L) := transform
 self.did := (integer)l.did;
 self.phone := l.phone;
 self.run_date := (integer)l.phone_date;
end;

with_Phone := project(e,addPhone(left));

f := watchdog.File_Moxie((integer)death_date < 20030829 and (integer)death_date > 20030503);

watchdog.Layout_Delta addDeath(a L) := transform
 self.did := (integer)l.did;
 self.dod := l.dod;
 self.run_date := (integer)l.death_date;
end;

with_death := project(f,addDeath(left));

g := watchdog.File_Moxie((integer)vehicle_date < 20030829 and (integer)vehicle_date > 20030503);

watchdog.Layout_Delta addVeh(a L) := transform
 self.did := (integer)l.did;
 self.Vehicle_vehnum := l.Vehicle_vehnum;
 self.run_date := (integer)l.vehicle_date;
end;

with_Vehicle := project(g,addVeh(left));

h := watchdog.File_Moxie((integer)property_date < 20030829 and (integer)property_date > 20030503);

watchdog.Layout_Delta addProperty(a L) := transform
 self.did := (integer)l.did;
 self.Prpty_deed_id := l.Prpty_deed_id;
 self.run_date := (integer)l.property_date;
end;

with_Property := project(h,addProperty(left));

i := watchdog.File_Moxie((integer)bankruptcy_date < 20030829 and (integer)bankruptcy_date > 20030503);

watchdog.Layout_Delta addBankruptcy(a L) := transform
 self.did := (integer)l.did;
 self.Bkrupt_CrtCode_CaseNo := l.Bkrupt_CrtCode_CaseNo;
 self.run_date := (integer)l.bankruptcy_date;
end;

with_bank := project(i,addBankruptcy(left));

string_rec := record
   string12 old_did;
   string12 new_did;
end;

file_pos := record
 string_rec;
   unsigned integer8 __filepos { virtual(fileposition)};
end;

j := index(dataset('jgtemp::watchdog_did_list',file_pos,flat),file_pos,'key::watchdog_moxie_old_did.did');

watchdog.Layout_Delta OldNew(j L) := transform
 self.assigned_did := if((integer)l.new_did = 0,2,(integer)l.new_did);
 self.did := (integer)l.old_did;
 self.run_date := watchdog.RunDate;
end;

with_old := project(j,OldNew(left));

delta_file := with_name + with_addr + with_phone + with_death + with_ssn +
               with_bank + with_Property + with_vehicle + with_dob + with_old;

dist := distribute(delta_file,hash(did));

srt := sort(dist,did,-fname,-lname,
				-prim_range,-prim_name,-st,-zip,
				-ssn,-dob,-dod,-phone,-Bkrupt_CrtCode_CaseNo,
				-Vehicle_vehnum,-Prpty_deed_id,local);

watchdog.layout_delta rollData(srt L, srt R) := transform
self.prim_range := if(r.prim_range='',l.prim_range,r.prim_range);
self.predir := if(r.predir='',l.predir,r.predir);
self.prim_name := if(r.prim_name='',l.prim_name,r.prim_name);
self.suffix := if(r.suffix='',l.suffix,r.suffix);
self.postdir := if(r.postdir='',l.postdir,r.postdir);
self.unit_desig := if(r.unit_desig='',l.unit_desig,r.unit_desig);
self.sec_range := if(r.sec_range='',l.sec_range,r.sec_range);
self.city_name := if(r.city_name='',l.city_name,r.city_name);
self.st := if(r.st='',l.st,r.st);
self.zip := if(r.zip='',l.zip,r.zip);
self.zip4 := if(r.zip4='',l.zip4,r.zip4);
self.dob := if(r.dob=0,l.dob,r.dob);
self.SSN := if(r.SSN='',l.SSN,r.SSN);
self.phone := if(r.phone='',l.phone,r.phone);
self.dod := if(r.dod='',l.dod,r.dod);
self.Vehicle_vehnum := if(r.Vehicle_vehnum='',l.Vehicle_vehnum,r.Vehicle_vehnum);
self.Prpty_deed_id := if(r.Prpty_deed_id='',l.Prpty_deed_id,r.Prpty_deed_id);
self.Bkrupt_CrtCode_CaseNo := if(r.Bkrupt_CrtCode_CaseNo='',l.Bkrupt_CrtCode_CaseNo,r.Bkrupt_CrtCode_CaseNo);
self := l; 
end;

final_delta := rollup(srt,left.did=right.did and left.run_date=right.run_date,
						rollData(left,right),local);


output(final_delta,,'base::watchdog_delta20030905');