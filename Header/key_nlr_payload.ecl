import doxie,Data_Services,header;

d:=header.fn_suppress_ccpa(Header.Prep_NLR_key,true);

layout:=record
	d.pflag1;
	d.pflag2;
	d.pflag3;
	d.src;
	d.dt_first_seen;
	d.dt_last_seen;
	d.dt_vendor_last_reported;
	d.dt_vendor_first_reported;
	d.dt_nonglb_last_seen;
	d.rec_type;
	d.vendor_id;
	d.phone;
	d.ssn;
	d.dob;
	d.title;
	d.fname;
	d.mname;
	d.lname;
	d.name_suffix;
	d.prim_range;
	d.predir;
	d.prim_name;
	d.suffix;
	d.postdir;
	d.unit_desig;
	d.sec_range;
	d.city_name;
	d.st;
	d.zip;
	d.zip4;
	d.county;
	d.geo_blk;
	d.cbsa;
	d.tnt;
	d.valid_ssn;
	d.jflag1;
	d.jflag2;
	d.jflag3;
	d.rawaid;
	d.dodgy_tracking;
	d.persistent_record_id;
	d.not_in_bureau;
	d.global_sid;
	d.record_sid;
 END;

export key_NLR_payload := INDEX (d, {did,rid}, layout,
		Data_Services.Data_Location.Prefix('person_header')+'thor_data400::key::header_nlr::did.rid_'+doxie.version_superkey);