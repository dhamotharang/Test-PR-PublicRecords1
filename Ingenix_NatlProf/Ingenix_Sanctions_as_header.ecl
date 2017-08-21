import header,ut;
main_file := Ingenix_NatlProf.Ingenix_Sanctions_as_source;

h := header.Layout_New_Records;

h trans(main_file l) := transform
  self.did := (unsigned6)l.did;
  self.rid := 0;
  self.dt_first_seen := (unsigned3)(l.date_first_seen[1..6]);
  self.dt_last_seen  := (unsigned3)(l.date_last_seen[1..6]);
  self.dt_vendor_first_reported := (unsigned3)(l.date_first_reported[1..6]);
  self.dt_vendor_last_reported  := (unsigned3)(l.date_last_reported[1..6]);
  self.dt_nonglb_last_seen  := (unsigned3)(self.dt_last_seen);
  self.rec_type := '1';
  self.vendor_id := l.sanc_id;
  self.dob := (integer4)l.sanc_dob;
  self.ssn := if ((integer)l.sanc_tin=0,'',l.sanc_tin);
	//###########################mapping need to be done for below###############
   self.phone := '';
   self.title 			 := l.Prov_Clean_title;
   self.fname 			 := l.Prov_Clean_fname;
   self.mname 			 := l.Prov_Clean_mname;
   self.lname 			 := l.Prov_Clean_lname;
   self.name_suffix  := l.Prov_Clean_name_suffix;
   self.city_name    := l.ProvCo_Address_Clean_v_city_name;
   self.zip          := l.ProvCo_Address_Clean_zip;
   self.county       := l.ProvCo_Address_Clean_fipscounty;
   self.cbsa         := if(l.ProvCo_Address_Clean_msa!='',l.ProvCo_Address_Clean_msa+'0','');
   //######################################################
 	 self.prim_range   := l.ProvCo_Address_Clean_prim_range;
	 self.predir			 := l.ProvCo_Address_Clean_predir;
	 self.prim_name    := l.ProvCo_Address_Clean_prim_name;
	 self.suffix       := l.ProvCo_Address_Clean_addr_suffix;
	 self.postdir      := l.ProvCo_Address_Clean_postdir;
	 self.unit_desig   := l.ProvCo_Address_Clean_unit_desig;
	 self.sec_range    := l.ProvCo_Address_Clean_sec_range;
	 self.st           := l.ProvCo_Address_Clean_st;
	 self.zip4         := l.ProvCo_Address_Clean_zip4;
	 self.geo_blk      := l.ProvCo_Address_Clean_geo_match;
	 self := l;
	 end;

from_sanc := project(main_file,trans(left));

ded := from_sanc(prim_name <> '', 
				lname <> '',
				length(trim(fname)) > 1,
				length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' ')));

export Ingenix_Sanctions_as_header := ded;

