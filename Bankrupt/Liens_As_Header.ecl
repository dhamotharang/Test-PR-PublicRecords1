import header,ut;
liens_file := Liens_as_Source;

header.Layout_New_Records intoHeader(liens_file L) := transform
  self.did := 0;
  self.rid := 0;
  self.dt_first_seen := ut.mob((integer)l.filing_date);
  self.dt_last_seen := ut.mob((integer)l.filing_date);
  self.dt_vendor_last_reported := ut.mob((integer)l.uploaddate);
  self.dt_vendor_first_reported := ut.mob((integer)l.uploaddate);
  self.dt_nonglb_last_seen := ut.mob((integer)l.filing_date);
  self.rec_type := '1';
  self.vendor_id := l.rmsid;
  self.dob := 0;
  self.ssn := l.orig_ssn;
  self.city_name := l.v_city_name;
  self.phone := '';
  self.title := l.def_title;
  self.fname := l.def_fname;
  self.mname := l.def_mname;
  self.lname := l.def_lname;
  self.name_suffix := l.def_name_suffix;
  self.st := l.state;
  self.county := l.county[3..5];
  self.cbsa := if(l.msa!='',l.msa+'0','');
  self := l;
  end;


export Liens_As_Header := project(liens_file,intoHeader(left))(lname!='' and prim_name!='');