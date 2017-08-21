import ut;

ixi.layouts.l_raw t1(ixi.ixi_clean le) := transform
 self.ixid          := le.orig_Ixid;
 self.firstname     := le.orig_Firstname;
 self.middleinitial := le.orig_Middleinitial;
 self.lastname      := le.orig_Lastname;
 self.address       := le.orig_Address;
 self.city          := le.orig_City;
 self.state         := le.orig_State;
 self.zip           := le.orig_Zip;
 self.zip4          := le.orig_zip4;
 self.dob           := le.orig_dob;
 self.aid           := le.aid;
 self.pid           := le.pid;
 self               := le;
end;

p1      := project(ixi.ixi_clean,t1(left));
p1_dupd := dedup(p1,record,all);

ut.mac_sf_buildprocess(p1_dupd,'~thor_data400::base::ixi_raw',ixi_raw,2,,true);
 
export return_ixi_data := ixi_raw;