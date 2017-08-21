
util_file := utilfile.file_util_in;

r1 := record
 string6 connect_date_ym;
 boolean is_z_record;
 boolean has_phone;
 boolean has_work_phone;
 boolean z_rec_has_phone;
 boolean z_rec_has_work_phone;
end;

r1 t1(util_file le) := transform
 self.connect_date_ym      := le.connect_date[1..6];
 self.is_z_record          := trim(le.util_type)='Z';
 self.has_phone            := (integer)le.phone>0;
 self.has_work_phone       := (integer)le.work_phone>0;
 self.z_rec_has_phone      := self.is_z_record=true and self.has_phone=true;
 self.z_rec_has_work_phone := self.is_z_record=true and self.has_work_phone=true;
 self                      := le;
end;

shared p1 := project(util_file,t1(left));

r3 := record
 p1.connect_date_ym;
 is_z_rec             := count(group,p1.is_z_record=true); 
 has_phone2           := count(group,p1.has_phone=true);
 has_work_phone2      := count(group,p1.has_work_phone=true);
 has_z_rec_phone      := count(group,p1.z_rec_has_phone=true);
 has_z_rec_work_phone := count(group,p1.z_rec_has_work_phone=true);
 count_               := count(group);
end;

ta2      := sort(table(p1,r3,connect_date_ym,few),-connect_date_ym);
ta2_filt := ta2(count_>500);

export coverage_misc := output(ta2_filt,all);