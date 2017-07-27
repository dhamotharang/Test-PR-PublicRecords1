export
header.Layout_New_Records tra_denormalize_header(Layout_In_Header l, integer c) := transform
    self.fname := choose(c, l.fname_1, l.fname_2, l.fname_3, l.fname_4);
    self.mname := choose(c, l.minit_1, l.minit_2, l.minit_3, l.minit_4);
    self.lname := choose(c, l.lname_1, l.lname_2, l.lname_3, l.lname_4);
    self.name_suffix := choose(c, l.name_suffix_1, l.name_suffix_2,
                                  l.name_suffix_3, l.name_suffix_4);
    self.title := l.title_1;
    self.dt_first_seen := (integer)l.dt_first_seen;
    self.dt_last_seen := (integer)l.dt_last_seen;
    self.dt_vendor_last_reported := (integer)l.dt_vendor_last_reported;
    self.dt_vendor_first_reported := (integer)l.dt_vendor_first_reported;
    self.dt_nonglb_last_seen := 0;	
    self.dob := 0;					
	self.phone := '';				
    self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';
    self.did := 0;
    self.rid := 0;
    self := l;
end;