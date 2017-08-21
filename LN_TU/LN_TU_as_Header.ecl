/*2005-06-28T14:01:48Z (pallavi_p garg)
date fixes
*/
import header,address,ut,LN_TU;

header.Layout_New_Records Header_Build(File_In_LN_TU_Normalized le) := Transform
self.did := 0;
self.rid := 0;
self.pflag1 := '';
self.pflag2 := '';
self.pflag3 := '';
self.src := le.src;
//self.dt_first_seen :=(integer)(le.file_date);
//self.dt_last_seen := (integer)(le.file_date);
//self.dt_vendor_first_reported := (unsigned3)(le.orig_date_reported_mmddccyy[1..6]);
//self.dt_vendor_last_reported := (unsigned3)(le.orig_date_reported_mmddccyy[1..6]);
//self.dt_nonglb_last_seen := if(le.file_date='199312' or le.file_date='199612',self.dt_first_seen,0);

self.dt_first_seen :=if(trim(le.orig_date_reported_mmddccyy,left,right)!='',
                      (unsigned3)(le.orig_date_reported_mmddccyy[5..8]+le.orig_date_reported_mmddccyy[1..2]),
					  (unsigned3)(le.orig_file_date_mmddccyy[5..8]+le.orig_file_date_mmddccyy[1..2]));
self.dt_last_seen := if(trim(le.orig_date_reported_mmddccyy,left,right)!='',
                      (unsigned3)(le.orig_date_reported_mmddccyy[5..8]+le.orig_date_reported_mmddccyy[1..2]),
					  (unsigned3)(le.orig_file_date_mmddccyy[5..8]+le.orig_file_date_mmddccyy[1..2]));
self.dt_vendor_first_reported := (integer)(le.file_date);
self.dt_vendor_last_reported := (integer)(le.file_date);
self.dt_nonglb_last_seen := self.dt_last_seen;


self.rec_type :=le.orig_record_type;
self.vendor_id := le.orig_perm_id;
self.ssn := le.orig_ssn;
self.phone := '';
integer dob1 := (integer)(trim(le.orig_birthdate_ccyymm));
self.dob := map(dob1=0 => 0,
			 dob1<10000 => (integer)(trim(le.orig_birthdate_ccyymm) + '0000'),
			 (integer)(trim(le.orig_birthdate_ccyymm) + '00'));
self.title := le.clean_name[1..5];
self.fname := le.clean_name[6..25];
self.mname := le.clean_name[26..45];
self.lname := le.clean_name[46..65];
self.name_suffix := le.clean_name[66..70];
self.prim_range := le.clean[1..10];
self.predir := le.clean[11..12];
self.prim_name := le.clean[13..40];
self.suffix := le.clean[41..44];			
self.postdir := le.clean[45..46];
self.unit_desig := le.clean[47..56];
self.sec_range := le.clean[57..64];
self.city_name := le.clean[90..114];
self.st := le.clean[115..116];
self.zip := le.clean[117..121];
self.zip4 := le.clean[122..125];
self.county := le.clean[143..145];
self.geo_blk := le.clean[171..177];
self.cbsa := le.clean[167..170] + '0';
self.tnt := ' ';
self.valid_SSN := '';
self.jflag1 := '';
self.jflag2 := '';
self.jflag3 := '';
self.uid := le.uid;
end;

export LN_TU_as_Header := PROJECT(File_In_LN_TU_Normalized, Header_Build(LEFT));




