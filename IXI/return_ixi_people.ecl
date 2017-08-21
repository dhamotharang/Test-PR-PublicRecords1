import ut;

ixi.layouts.l_people t1(ixi.get_people_current le) := transform
 self.aid         := le.aid;
 self.pid         := le.did;
 self.fname       := le.fname;
 self.mname       := le.mname;
 self.lname       := le.lname;
 self.name_suffix := le.name_suffix;
 self.on_ixi_rec  := false;
end;

p1      := project(ixi.get_people_current,t1(left));
p1_dupd := dedup(p1,record,all);

ut.mac_sf_buildprocess(p1_dupd,'~thor_data400::base::ixi_people',ixi_people,2,,true);

export return_ixi_people := ixi_people;