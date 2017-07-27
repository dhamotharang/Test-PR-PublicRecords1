import ut;
//Death Master into header layout and create source key
t := Death_as_Source;

Layout_New_Records into_fat(t le) := transform
  self.did := 0;
  self.rid := 0;
  self.dt_first_seen := ut.MOB((integer)le.dod8);
  self.dt_last_seen := ut.MOB((integer)le.dod8);
  self.dt_vendor_first_reported := ut.MOB((integer)le.dod8);
  self.dt_vendor_last_reported := ut.MOB((integer)le.dod8);
  self.dt_nonglb_last_seen := ut.MOB((integer)le.dod8);
  self.vendor_id:='';
  self.phone:='';
  self.prim_range:='';
  self.dob := (integer)le.dob8;
  self.prim_name:='DOD :'+le.dod8;
  self.unit_desig := '';
  self.title := '';
  self.predir := '';
  self.postdir := '';
  self.suffix := '';
  self.city_name:='';
  self.st := '';
  self.zip4 := '';
  self.county := '';
  self.cbsa := '';
  self.geo_blk := '';
  self.zip := if (le.zip_lastres<>'',le.zip_lastres,le.zip_lastpayment);
  self.sec_range := '';
  self := le;
  end;

death_in := project(t,into_fat(left));

export Death_as_header := death_in;