import ut;
//  State Death Master into header layout

t := State_Death_as_Source;

Layout_New_Records into_fat(t le) := transform
  self.did                      := 0;
  self.rid                      := 0;
  self.dt_first_seen            := ut.MOB((integer)le.dod);
  self.dt_last_seen             := ut.MOB((integer)le.dod);
  self.dt_vendor_first_reported := ut.MOB((integer)le.dod);
  self.dt_vendor_last_reported  := ut.MOB((integer)le.dod);
  self.dt_nonglb_last_seen      := ut.MOB((integer)le.dod);
  self.vendor_id                := le.vdi;
  self.phone                    := '';
  self.dob                      := (integer)le.dob;
	self.city_name                := le.v_city_name;
	self.st                       := le.state;
	self.prim_name                := 'DOD :' + le.dod;
  self                          := le;
	self                          := [];
end;

death_in := project(t, into_fat(left));

export State_Death_as_header := death_in;