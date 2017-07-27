/*2005-03-02T15:05:23Z (Jill Goforth)
for show sources
*/
import header,ut,mdr;
v := vehicles_as_source;
h := header.Layout_New_Records;

hp := record
  h;
  unsigned8 vid := 0;
  string1 customer_type := '';
  end;

hp trans(v le,integer cnt) := transform
  self.did := 0;
  self.rid := 0;
  self.dt_first_seen := le.dt_first_seen;
  self.dt_last_seen := le.dt_last_seen;
  self.dt_vendor_last_reported := le.dt_vendor_last_reported;
  self.dt_vendor_first_reported := le.dt_vendor_first_reported;
  self.dt_nonglb_last_seen  := le.dt_last_seen;
  self.rec_type := IF(le.history='','1','2');
  self.vendor_id := le.orig_vin;
  SELF.ssn := CHOOSE(Cnt,le.own_1_feid_ssn,le.own_2_feid_ssn,le.reg_1_feid_ssn,le.reg_2_feid_ssn,'');
  self.dob := (integer)choose(cnt,le.own_1_dob,le.own_2_dob,le.reg_1_dob,le.reg_2_dob);
  self.title := choose(cnt,le.own_1_title,le.own_2_title,le.reg_1_title,le.reg_2_title);
self.fname := choose(cnt,le.own_1_fname,le.own_2_fname,le.reg_1_fname,le.reg_2_fname);
self.mname := choose(cnt,le.own_1_mname,le.own_2_mname,le.reg_1_mname,le.reg_2_mname);
self.lname := choose(cnt,le.own_1_lname,le.own_2_lname,le.reg_1_lname,le.reg_2_lname);
self.name_suffix := choose(cnt,le.own_1_name_suffix,le.own_2_name_suffix,le.reg_1_name_suffix,le.reg_2_name_suffix);
self.prim_range := choose(cnt,le.own_1_prim_range,le.own_2_prim_range,le.reg_1_prim_range,le.reg_2_prim_range);
self.predir := choose(cnt,le.own_1_predir,le.own_2_predir,le.reg_1_predir,le.reg_2_predir);
self.prim_name := choose(cnt,le.own_1_prim_name,le.own_2_prim_name,le.reg_1_prim_name,le.reg_2_prim_name);
self.suffix := choose(cnt,le.own_1_suffix,le.own_2_suffix,le.reg_1_suffix,le.reg_2_suffix);
self.postdir := choose(cnt,le.own_1_postdir,le.own_2_postdir,le.reg_1_postdir,le.reg_2_postdir);
self.unit_desig := choose(cnt,le.own_1_unit_desig,le.own_2_unit_desig,le.reg_1_unit_desig,le.reg_2_unit_desig);
self.sec_range := choose(cnt,le.own_1_sec_range,le.own_2_sec_range,le.reg_1_sec_range,le.reg_2_sec_range);
self.city_name := choose(cnt,le.own_1_v_city_name,le.own_2_v_city_name,le.reg_1_v_city_name,le.reg_2_v_city_name);
self.st := choose(cnt,le.own_1_state_2,le.own_2_state_2,le.reg_1_state_2,le.reg_2_state_2);
self.zip := choose(cnt,le.own_1_zip5,le.own_2_zip5,le.reg_1_zip5,le.reg_2_zip5);
self.zip4 := choose(cnt,le.own_1_zip4,le.own_2_zip4,le.reg_1_zip4,le.reg_2_zip4);
self.county := choose(cnt,le.own_1_county,le.own_2_county,le.reg_1_county,le.reg_2_county);
self.cbsa := '';
self.geo_blk := '';
self.phone := '';
self.customer_type := choose(cnt, le.OWNER_1_CUSTOMER_TYPExBG3, le.OWNER_2_CUSTOMER_TYPE,
							      le.REGISTRANT_1_CUSTOMER_TYPExBG5, le.REGISTRANT_2_CUSTOMER_TYPE);
self := le;
  end;

from_vr := normalize(v,4,trans(left,counter));

// we don't really have to dedup as the RIDing technology does that
ded := dedup(from_vr(fname<>'',lname<>'', customer_type <> 'B'),fname,ssn,lname,vendor_id,prim_name,prim_range,all);

ut.MAC_Sequence_Records(ded,vid,oded)

h ven_a_ssn(hp le) := transform
  self.ssn := if ((integer)le.ssn=0,'',le.ssn);
  self.vendor_id := IF( le.vendor_id<>'',le.vendor_id,'FVREG '+(string10)le.vid );
  self := le;
  end;
// This is a 'double check' that only correct records are allowed through
res := project(oded(mdr.Source_is_DPPA(src)),ven_a_ssn(left));

export Vehicles_as_header := res;