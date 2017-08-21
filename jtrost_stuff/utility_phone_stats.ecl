ds0 := utilfile.file_util_in;

rslim := record
 ds0.connect_date;
 ds0.util_type;
 ds0.phone;
 ds0.work_phone;
end;

ds := table(ds0,rslim);

yellowpages.NPA_PhoneType_forSuppression(ds,phone,phonetype,append_phonetype)

pst1 := append_phonetype : persist('persist::jtrost_append_phonetype1');

yellowpages.NPA_PhoneType_forSuppression(append_phonetype,work_phone,work_phonetype,append_phonetype2)

util_file := append_phonetype2 : persist('persist::jtrost_append_phonetype2');

output(pst1);
output(util_file);
count(util_file);

r1 := record
 util_file.util_type;
 string6 connect_date_ym;
 boolean is_z_record;
 boolean has_phone;
 boolean has_work_phone;
 boolean phone_is_cell;
 boolean work_phone_is_cell;
 boolean z_rec_has_phone;
 boolean z_rec_has_work_phone;
 boolean z_phone_is_cell;
 boolean z_work_phone_is_cell;
end;

r1 t1(util_file le) := transform
 self.connect_date_ym      := le.connect_date[1..6];
 self.is_z_record          := trim(le.util_type)='Z';
 self.has_phone            := (integer)le.phone>0;
 self.has_work_phone       := (integer)le.work_phone>0;
 self.phone_is_cell        := self.has_phone     =true  and trim(le.phonetype)      in ['CELL','LNDLN PRTD TO CELL'];
 self.work_phone_is_cell   := self.has_work_phone=true  and trim(le.work_phonetype) in ['CELL','LNDLN PRTD TO CELL'];
 self.z_rec_has_phone      := self.is_z_record   =true  and self.has_phone     =true;
 self.z_rec_has_work_phone := self.is_z_record   =true  and self.has_work_phone=true;
 self.z_phone_is_cell      := self.z_rec_has_phone      and trim(le.phonetype)      in ['CELL','LNDLN PRTD TO CELL'];
 self.z_work_phone_is_cell := self.z_rec_has_work_phone and trim(le.work_phonetype) in ['CELL','LNDLN PRTD TO CELL'];
 self                      := le;
end;

p1 := project(util_file,t1(left));
f1 := p1(connect_date_ym between '200303' and '200808');

r3 := record
 //p1.util_type;
 //p1.connect_date_ym;
 p1.util_type;
 count_                 := count(group);
 
 has_phone2             := count(group,p1.has_phone           =true);
 has_phone2_iscell      := count(group,p1.phone_is_cell       =true);
 has_work_phone2        := count(group,p1.has_work_phone      =true);
 has_work_phone2_iscell := count(group,p1.work_phone_is_cell  =true);
 
 is_z_rec                    := count(group,p1.is_z_record         =true);
 has_z_rec_phone             := count(group,p1.z_rec_has_phone     =true);
 has_z_rec_phone_iscell      := count(group,p1.z_phone_is_cell     =true);
 has_z_rec_work_phone        := count(group,p1.z_rec_has_work_phone=true);
 has_z_rec_work_phone_iscell := count(group,p1.z_work_phone_is_cell=true);
end;

ta1 := sort(table(p1,                                               r3,util_type,few),util_type);
ta2 := sort(table(p1(connect_date_ym between '200303' and '200808'),r3,util_type,few),util_type);

output(ta1,all);
output(ta2,all);