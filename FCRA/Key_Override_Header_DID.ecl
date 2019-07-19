import fcra, ut, data_services, vault, _control;

kf := File_Header_Correct ((unsigned)head.did<>0);



typeof(kf) rollup_recs(kf l, kf r) := transform
	self.head.pflag1 := if (r.date_created >= l.date_created and l.head.pflag1 <> r.head.pflag1 and r.head.pflag1 <> '', r.head.pflag1,l.head.pflag1);
self.head.pflag2 := if (r.date_created >= l.date_created and l.head.pflag2 <> r.head.pflag2 and r.head.pflag2 <> '', r.head.pflag2,l.head.pflag2);
self.head.pflag3 := if (r.date_created >= l.date_created and l.head.pflag3 <> r.head.pflag3 and r.head.pflag3 <> '', r.head.pflag3,l.head.pflag3);
self.head.src := if (r.date_created >= l.date_created and l.head.src <> r.head.src and r.head.src <> '', r.head.src,l.head.src);
self.head.dt_first_seen := if (r.date_created >= l.date_created and l.head.dt_first_seen <> r.head.dt_first_seen and r.head.dt_first_seen <> 0, r.head.dt_first_seen,l.head.dt_first_seen);
self.head.dt_last_seen := if (r.date_created >= l.date_created and l.head.dt_last_seen <> r.head.dt_last_seen and r.head.dt_last_seen <> 0, r.head.dt_last_seen,l.head.dt_last_seen);
self.head.dt_vendor_last_reported := if (r.date_created >= l.date_created and l.head.dt_vendor_last_reported <> r.head.dt_vendor_last_reported and r.head.dt_vendor_last_reported <> 0, r.head.dt_vendor_last_reported,l.head.dt_vendor_last_reported);
self.head.dt_vendor_first_reported := if (r.date_created >= l.date_created and l.head.dt_vendor_first_reported <> r.head.dt_vendor_first_reported and r.head.dt_vendor_first_reported <> 0, r.head.dt_vendor_first_reported,l.head.dt_vendor_first_reported);
self.head.dt_nonglb_last_seen := if (r.date_created >= l.date_created and l.head.dt_nonglb_last_seen <> r.head.dt_nonglb_last_seen and r.head.dt_nonglb_last_seen <> 0, r.head.dt_nonglb_last_seen,l.head.dt_nonglb_last_seen);
self.head.rec_type := if (r.date_created >= l.date_created and l.head.rec_type <> r.head.rec_type and r.head.rec_type <> '', r.head.rec_type,l.head.rec_type);
self.head.vendor_id := if (r.date_created >= l.date_created and l.head.vendor_id <> r.head.vendor_id and r.head.vendor_id <> '', r.head.vendor_id,l.head.vendor_id);
self.head.phone := if (r.date_created >= l.date_created and l.head.phone <> r.head.phone and r.head.phone <> '', r.head.phone,l.head.phone);
self.head.ssn := if (r.date_created >= l.date_created and l.head.ssn <> r.head.ssn and r.head.ssn <> '', r.head.ssn,l.head.ssn);
self.head.dob := if (r.date_created >= l.date_created and l.head.dob <> r.head.dob and r.head.dob <> 0, r.head.dob,l.head.dob);
self.head.title := if (r.date_created >= l.date_created and l.head.title <> r.head.title and r.head.title <> '', r.head.title,l.head.title);
self.head.fname := if (r.date_created >= l.date_created and l.head.fname <> r.head.fname and r.head.fname <> '', r.head.fname,l.head.fname);
self.head.mname := if (r.date_created >= l.date_created and l.head.mname <> r.head.mname and r.head.mname <> '', r.head.mname,l.head.mname);
self.head.lname := if (r.date_created >= l.date_created and l.head.lname <> r.head.lname and r.head.lname <> '', r.head.lname,l.head.lname);
self.head.name_suffix := if (r.date_created >= l.date_created and l.head.name_suffix <> r.head.name_suffix and r.head.name_suffix <> '', r.head.name_suffix,l.head.name_suffix);
self.head.prim_range := if (r.date_created >= l.date_created and l.head.prim_range <> r.head.prim_range and r.head.prim_range <> '', r.head.prim_range,l.head.prim_range);
self.head.predir := if (r.date_created >= l.date_created and l.head.predir <> r.head.predir and r.head.predir <> '', r.head.predir,l.head.predir);
self.head.prim_name := if (r.date_created >= l.date_created and l.head.prim_name <> r.head.prim_name and r.head.prim_name <> '', r.head.prim_name,l.head.prim_name);
self.head.suffix := if (r.date_created >= l.date_created and l.head.suffix <> r.head.suffix and r.head.suffix <> '', r.head.suffix,l.head.suffix);
self.head.postdir := if (r.date_created >= l.date_created and l.head.postdir <> r.head.postdir and r.head.postdir <> '', r.head.postdir,l.head.postdir);
self.head.unit_desig := if (r.date_created >= l.date_created and l.head.unit_desig <> r.head.unit_desig and r.head.unit_desig <> '', r.head.unit_desig,l.head.unit_desig);
self.head.sec_range := if (r.date_created >= l.date_created and l.head.sec_range <> r.head.sec_range and r.head.sec_range <> '', r.head.sec_range,l.head.sec_range);
self.head.city_name := if (r.date_created >= l.date_created and l.head.city_name <> r.head.city_name and r.head.city_name <> '', r.head.city_name,l.head.city_name);
self.head.st := if (r.date_created >= l.date_created and l.head.st <> r.head.st and r.head.st <> '', r.head.st,l.head.st);
self.head.zip := if (r.date_created >= l.date_created and l.head.zip <> r.head.zip and r.head.zip <> '', r.head.zip,l.head.zip);
self.head.zip4 := if (r.date_created >= l.date_created and l.head.zip4 <> r.head.zip4 and r.head.zip4 <> '', r.head.zip4,l.head.zip4);
self.head.county := if (r.date_created >= l.date_created and l.head.county <> r.head.county and r.head.county <> '', r.head.county,l.head.county);
self.head.geo_blk := if (r.date_created >= l.date_created and l.head.geo_blk <> r.head.geo_blk and r.head.geo_blk <> '', r.head.geo_blk,l.head.geo_blk);
self.head.cbsa := if (r.date_created >= l.date_created and l.head.cbsa <> r.head.cbsa and r.head.cbsa <> '', r.head.cbsa,l.head.cbsa);
self.head.tnt := if (r.date_created >= l.date_created and l.head.tnt <> r.head.tnt and r.head.tnt <> '', r.head.tnt,l.head.tnt);
self.head.valid_ssn := if (r.date_created >= l.date_created and l.head.valid_ssn <> r.head.valid_ssn and r.head.valid_ssn <> '', r.head.valid_ssn,l.head.valid_ssn);
self.head.jflag1 := if (r.date_created >= l.date_created and l.head.jflag1 <> r.head.jflag1 and r.head.jflag1 <> '', r.head.jflag1,l.head.jflag1);
self.head.jflag2 := if (r.date_created >= l.date_created and l.head.jflag2 <> r.head.jflag2 and r.head.jflag2 <> '', r.head.jflag2,l.head.jflag2);
self.head.jflag3 := if (r.date_created >= l.date_created and l.head.jflag3 <> r.head.jflag3 and r.head.jflag3 <> '', r.head.jflag3,l.head.jflag3);
self.head.rawaid := if (r.date_created >= l.date_created and l.head.rawaid <> r.head.rawaid and (string)r.head.rawaid <> '', r.head.rawaid,l.head.rawaid);
self.head.valid_dob := if (r.date_created >= l.date_created and l.head.valid_dob <> r.head.valid_dob and r.head.valid_dob <> '', r.head.valid_dob,l.head.valid_dob);
self.head.hhid := if (r.date_created >= l.date_created and l.head.hhid <> r.head.hhid and r.head.hhid <> 0, r.head.hhid,l.head.hhid);
self.head.county_name := if (r.date_created >= l.date_created and l.head.county_name <> r.head.county_name and r.head.county_name <> '', r.head.county_name,l.head.county_name);
self.head.listed_name := if (r.date_created >= l.date_created and l.head.listed_name <> r.head.listed_name and r.head.listed_name <> '', r.head.listed_name,l.head.listed_name);
self.head.listed_phone := if (r.date_created >= l.date_created and l.head.listed_phone <> r.head.listed_phone and r.head.listed_phone <> '', r.head.listed_phone,l.head.listed_phone);
self.head.dod := if (r.date_created >= l.date_created and l.head.dod <> r.head.dod and r.head.dod <> 0, r.head.dod,l.head.dod);
self.head.death_code := if (r.date_created >= l.date_created and l.head.death_code <> r.head.death_code and r.head.death_code <> '', r.head.death_code,l.head.death_code);
self.head.lookup_did := if (r.date_created >= l.date_created and l.head.lookup_did <> r.head.lookup_did and r.head.lookup_did <> 0, r.head.lookup_did,l.head.lookup_did);
self.addr_flags.dwelltype := if (r.date_created >= l.date_created and l.addr_flags.dwelltype <> r.addr_flags.dwelltype and r.addr_flags.dwelltype <> '', r.addr_flags.dwelltype,l.addr_flags.dwelltype);
self.addr_flags.valid := if (r.date_created >= l.date_created and l.addr_flags.valid <> r.addr_flags.valid and r.addr_flags.valid <> '', r.addr_flags.valid,l.addr_flags.valid);
self.addr_flags.prisonaddr := if (r.date_created >= l.date_created and l.addr_flags.prisonaddr <> r.addr_flags.prisonaddr and r.addr_flags.prisonaddr <> '', r.addr_flags.prisonaddr,l.addr_flags.prisonaddr);
self.addr_flags.highrisk := if (r.date_created >= l.date_created and l.addr_flags.highrisk <> r.addr_flags.highrisk and r.addr_flags.highrisk <> '', r.addr_flags.highrisk,l.addr_flags.highrisk);
self.addr_flags.corpmil := if (r.date_created >= l.date_created and l.addr_flags.corpmil <> r.addr_flags.corpmil and r.addr_flags.corpmil <> '', r.addr_flags.corpmil,l.addr_flags.corpmil);
self.addr_flags.donotdeliver := if (r.date_created >= l.date_created and l.addr_flags.donotdeliver <> r.addr_flags.donotdeliver and r.addr_flags.donotdeliver <> '', r.addr_flags.donotdeliver,l.addr_flags.donotdeliver);
self.addr_flags.deliverystatus := if (r.date_created >= l.date_created and l.addr_flags.deliverystatus <> r.addr_flags.deliverystatus and r.addr_flags.deliverystatus <> '', r.addr_flags.deliverystatus,l.addr_flags.deliverystatus);
self.addr_flags.addresstype := if (r.date_created >= l.date_created and l.addr_flags.addresstype <> r.addr_flags.addresstype and r.addr_flags.addresstype <> '', r.addr_flags.addresstype,l.addr_flags.addresstype);
self.addr_flags.dropindicator := if (r.date_created >= l.date_created and l.addr_flags.dropindicator <> r.addr_flags.dropindicator and r.addr_flags.dropindicator <> '', r.addr_flags.dropindicator,l.addr_flags.dropindicator);
self.addr_flags.unit_count := if (r.date_created >= l.date_created and l.addr_flags.unit_count <> r.addr_flags.unit_count and r.addr_flags.unit_count <> 0, r.addr_flags.unit_count,l.addr_flags.unit_count);
self.addr_flags.mail_usage := if (r.date_created >= l.date_created and l.addr_flags.mail_usage <> r.addr_flags.mail_usage and r.addr_flags.mail_usage <> '', r.addr_flags.mail_usage,l.addr_flags.mail_usage);
self.blankout := if (r.date_created >= l.date_created , r.blankout,l.blankout);
self := l;
end;

rolledupdata := rollup(sort(kf,head.did,head.persistent_record_id,date_created),head.DID+head.persistent_record_id,rollup_recs(left,right));

fcra.Layout_Override_Header proj_recs(rolledupdata l) := transform
	self := l;
end;

withoutcd := project(rolledupdata,proj_recs(left));


#IF(_Control.Environment.onVault) 
export Key_Override_Header_DID := vault.FCRA.Key_Override_Header_DID;
#ELSE
export Key_Override_Header_DID := 
index(withoutcd,
			{unsigned6 did := (unsigned)head.did}, {withoutcd}, 
 data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::header::qa::did');
#END;