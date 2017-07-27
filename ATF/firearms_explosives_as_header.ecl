import header,ut;
fire_in := atf.file_firearms_explosives_in;

header.Layout_New_Records faslim(fire_in Le, integer cnt) := transform
  self.did := 0;
  //self.preGLB_DID := 0;
  self.rid := 0;
  self.src := if(le.record_type='F','FF','FE');
  self.dt_first_seen := (integer)le.date_first_seen div 100;
  self.dt_last_seen := (integer)le.date_last_seen div 100;
  self.dt_vendor_last_reported := (integer)le.date_last_seen div 100;
  self.dt_vendor_first_reported := (integer)le.date_first_seen div 100;
  self.dt_nonglb_last_seen  := (integer)le.date_last_seen div 100;
  self.rec_type := '';
  self.vendor_id := le.license_number;
  SELF.ssn := '';
  self.dob := 0;
  self.title := choose(cnt,le.license1_title,le.license2_title,le.license1_title,le.license2_title);
  self.fname := choose(cnt,le.license1_fname,le.license2_fname,le.license1_fname,le.license2_fname);
  self.mname := choose(cnt,le.license1_mname,le.license2_mname,le.license1_mname,le.license2_mname);
  self.lname := choose(cnt,le.license1_lname,le.license2_lname,le.license1_lname,le.license2_lname);
  self.name_suffix := choose(cnt,le.license1_name_suffix,le.license2_name_suffix,le.license1_name_suffix,le.license2_name_suffix);
  self.prim_range := choose(cnt,le.premise_prim_range,le.premise_prim_range,le.mail_prim_range,le.mail_prim_range);
  self.predir := choose(cnt,le.premise_predir,le.premise_predir,le.mail_predir,le.mail_predir);
  self.prim_name := choose(cnt,le.premise_prim_name,le.premise_prim_name,le.mail_prim_name,le.mail_prim_name);
  self.suffix := choose(cnt,le.premise_suffix,le.premise_suffix,le.mail_suffix,le.mail_suffix); 
  self.postdir := choose(cnt,le.premise_postdir,le.premise_postdir,le.mail_postdir,le.mail_postdir);
  self.unit_desig := choose(cnt,le.premise_unit_desig,le.premise_unit_desig,le.mail_unit_desig,le.mail_unit_desig);
  self.sec_range := choose(cnt,le.premise_sec_range,le.premise_sec_range,le.mail_sec_range,le.mail_sec_range);
  self.city_name := choose(cnt,le.premise_v_city_name,le.premise_v_city_name,le.mail_v_city_name,le.mail_v_city_name);
  self.st := choose(cnt,le.premise_st,le.premise_st,le.mail_st,le.mail_st);
  self.zip := choose(cnt,le.premise_zip,le.premise_zip,le.mail_zip,le.mail_zip);
  self.zip4 := choose(cnt,le.premise_zip4,le.premise_zip4,le.mail_zip4,le.mail_zip4);
  self.county := choose(cnt,le.premise_fips_county,le.premise_fips_county,le.mail_fips_county,le.mail_fips_county); 
  self.cbsa := '';
  self.geo_blk := choose(cnt,le.premise_geo_blk,le.premise_geo_blk,le.mail_geo_blk,le.mail_geo_blk);
  self.phone := le.Voice_Phone;
  self.uid := 0;
end;

from_vr := normalize(fire_in,4,faslim(left,counter));

ded := dedup(from_vr(prim_name <> '', 
		lname <> '',
		fname <> '',
		zip4 <> ''),fname,lname,vendor_id,prim_name,prim_range,all);

ut.MAC_Sequence_Records(ded,uid,outfile)

export firearms_explosives_as_header := outfile : persist('persist::atf_as_header');