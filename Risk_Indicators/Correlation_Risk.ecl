import doxie_build, header, mdr, header_quick, doxie, gong, InfutorCID, Targus, utilfile, UT, Data_Services;

// this module specifically for counting # of sources where 2 input PII elements are found together on our database
// to be used in fraud attributes products and fraud modeling

export Correlation_Risk := module

// for each of the correlation keys now, we will have dataset of common_layout
shared common_layout := record
	string2 src;
	unsigned dt_first_seen;
	unsigned dt_last_seen;
	unsigned record_count;
end;
shared max_source_summary := 50;
shared default_max_date := 999999;
shared BSVersion	:= 50;

shared h_full := doxie_build.file_header_building(~risk_indicators.iid_constants.filtered_source(src, st, BSVersion));
shared h_quick := project(header_quick.file_header_quick(~risk_indicators.iid_constants.filtered_source(src, st, BSVersion)), transform(header.Layout_Header, self.src := IF(left.src in ['QH', 'WH'], MDR.sourceTools.src_Equifax, left.src), self := left));
shared header_base := ungroup(h_full + h_quick);
shared gh := gong.File_Gong_History_Full;
shared wp := Targus.File_targus_key_building;
shared ir := InfutorCID.File_InfutorCID_Base;
shared u := UtilFile.file_util.full_base;

// shared sample_size := 100;// for use in testing small sample only
// shared header_base := choosen(doxie.Key_Header, sample_size);  
// shared gh := choosen(gong.File_Gong_History_Full, sample_size);
// shared wp := choosen(Targus.File_targus_key_building, sample_size);
// shared ir := choosen(InfutorCID.File_InfutorCID_Base, sample_size);
// shared u := choosen(UtilFile.file_util.full_base, sample_size);

shared build_version := 'thor_data400::key::death_master::';  // this is the name in production roxie, make sure it's checked in this way

// use either one of these copies for testharness
// shared build_version := 'thor_data400::key::death_master2::';  
// shared build_version := 'thor_data400::key::death_master_test::';


/* ******************************************************************************
keys built from header base
********************************************************************************/
ssn_name_hdr := distribute(header_base(trim(ssn)<>'' and trim(lname)<>'' and trim(fname)<>''), hash(ssn, lname, fname));
shared ssn_name_src := table(ssn_name_hdr, {
		ssn, lname, fname, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, 
		ssn, lname, fname, src, local);
ssn_name_counts := table(ssn_name_src, {ssn, lname, fname, source_count := count(group)}, ssn, lname, fname, local);

export key_correlation_ssn_name := index(ssn_name_counts, {ssn, lname, fname}, {ssn_name_counts}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::ssn_name');


shared ssn_name_summary_layout := record
	ssn_name_src.ssn;
	ssn_name_src.lname;
	ssn_name_src.fname;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

ssn_name_summary_prep := project(ssn_name_src, transform(ssn_name_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

ssn_name_summary := rollup(ssn_name_summary_prep, left.ssn=right.ssn and left.lname=right.lname and left.fname=right.fname,
	transform(ssn_name_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3, will replace 'key_correlation_ssn_name' that was used in previous versions of the shell
export key_ssn_name_summary := index(ssn_name_summary, {ssn, lname, fname}, {ssn_name_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::ssn_name_summary');


ssn_addr_hdr := distribute(header_base(trim(ssn)<>'' and trim(prim_name)<>'' and trim(zip)<>''), hash(ssn, prim_name, zip));
shared ssn_addr_src := table(ssn_addr_hdr, 
	{ssn, prim_name, prim_range, zip, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, 
		ssn, prim_name, prim_range, zip, src, local);
ssn_addr_counts := table(ssn_addr_src, {ssn, prim_name, prim_range, zip, source_count := count(group)}, ssn, prim_name, prim_range, zip, local);

export key_correlation_ssn_addr := index(ssn_addr_counts, {ssn, prim_name, prim_range, zip}, {ssn_addr_counts}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::ssn_addr');

 ssn_addr_summary_layout := record
	ssn_addr_src.ssn;
	ssn_addr_src.prim_name;
	ssn_addr_src.prim_range;
	ssn_addr_src.zip;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

ssn_addr_summary_prep := project(ssn_addr_src, transform(ssn_addr_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

ssn_addr_summary := rollup(ssn_addr_summary_prep, left.ssn=right.ssn and left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.zip=right.zip,
	transform(ssn_addr_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3, will replace 'key_correlation_ssn_addr' that was used in previous versions of the shell
export key_ssn_addr_summary := index(ssn_addr_summary, {ssn, prim_name, prim_range, zip}, {ssn_addr_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::ssn_addr_summary');


ssn_dob_hdr := distribute(header_base(trim(ssn)<>'' and dob<>0), hash(ssn, dob));
ssn_dob_src := table(ssn_dob_hdr, {
		ssn, dob, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, 
		ssn, dob, src, local);

ssn_dob_summary_layout := record
	ssn_dob_src.ssn;
	ssn_dob_src.dob;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

ssn_dob_summary_prep := project(ssn_dob_src, transform(ssn_dob_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

ssn_dob_summary := rollup(ssn_dob_summary_prep, left.ssn=right.ssn and left.dob=right.dob,
	transform(ssn_dob_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );


// new for shell 5.3, will replace 'key_correlation_ssn_dob' that was used in previous versions of the shell
export key_ssn_dob_summary := index(ssn_dob_summary, {ssn, dob}, {ssn_dob_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::ssn_dob_summary');


ssn_phone_hdr := distribute(header_base(trim(ssn)<>'' and trim(phone)<>''), hash(ssn, phone));
ssn_phone_src := table(ssn_phone_hdr, 
	{ssn, phone, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, 
		ssn, phone, src, local);

ssn_phone_summary_layout := record
	ssn_phone_src.ssn;
	ssn_phone_src.phone;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

ssn_phone_summary_prep := project(ssn_phone_src, transform(ssn_phone_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

ssn_phone_summary := rollup(ssn_phone_summary_prep, left.ssn=right.ssn and left.phone=right.phone,
	transform(ssn_phone_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3, will replace 'key_correlation_ssn_phone' that was used in previous versions of the shell
export key_ssn_phone_summary := index(ssn_phone_summary, {ssn, phone}, {ssn_phone_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::ssn_phone_summary');


phone_dob_hdr := distribute(header_base(trim(phone)<>'' and dob<>0), hash(phone, dob));
phone_dob_src := table(phone_dob_hdr, 
	{phone, dob, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, 
		phone, dob, src, local);

phone_dob_summary_layout := record
	phone_dob_src.phone;
	phone_dob_src.dob;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

phone_dob_summary_prep := project(phone_dob_src, transform(phone_dob_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

phone_dob_summary := rollup(phone_dob_summary_prep, left.phone=right.phone and left.dob=right.dob,
	transform(phone_dob_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

export key_phone_dob_summary := index(phone_dob_summary, {phone, dob}, {phone_dob_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::phone_dob_summary');




addr_name_hdr := distribute(header_base(trim(prim_name)<>'' and trim(zip)<>'' and trim(lname)<>'' and trim(fname)<>''), hash(prim_name, zip, lname));
shared addr_name_src := table(addr_name_hdr,
	{prim_name, prim_range, zip, lname, fname, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, prim_name, prim_range, zip, lname, fname, src, local);
addr_name_counts := table(addr_name_src, {prim_name, prim_range, zip, lname, fname, source_count := count(group)}, prim_name, prim_range, zip, lname, fname, local);

export key_correlation_addr_name := index(addr_name_counts, {prim_name, prim_range, zip, lname, fname}, {addr_name_counts}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::addr_name');

 addr_name_summary_layout := record
	addr_name_src.prim_name;
	addr_name_src.prim_range;
	addr_name_src.zip;
	addr_name_src.lname;
	addr_name_src.fname;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

addr_name_summary_prep := project(addr_name_src, transform(addr_name_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

addr_name_summary := rollup(addr_name_summary_prep, left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.zip=right.zip and left.lname=right.lname and left.fname=right.fname,
	transform(addr_name_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3, will replace 'key_correlation_addr_name' that was used in previous versions of the shell
export key_addr_name_summary := index(addr_name_summary, {prim_name, prim_range, zip, lname, fname}, {addr_name_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::addr_name_summary');



addr_dob_hdr := distribute(header_base(trim(prim_name)<>'' and trim(zip)<>'' and dob<>0), hash(prim_name, prim_range, zip, dob));
addr_dob_src := table(addr_dob_hdr,
	{prim_name, prim_range, zip, dob, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, prim_name, prim_range, zip, dob, src, local);

addr_dob_summary_layout := record
	addr_dob_src.prim_name;
	addr_dob_src.prim_range;
	addr_dob_src.zip;
	addr_dob_src.dob;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

addr_dob_summary_prep := project(addr_dob_src, transform(addr_dob_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

addr_dob_summary := rollup(addr_dob_summary_prep, left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.zip=right.zip and left.dob=right.dob,
	transform(addr_dob_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3
export key_addr_dob_summary := index(addr_dob_summary, {prim_name, prim_range, zip, dob}, {addr_dob_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::addr_dob_summary');




name_dob_hdr := distribute(header_base(trim(lname)<>'' and trim(fname)<>'' and dob<>0), hash(lname, fname, dob));
name_dob_src := table(name_dob_hdr,
	{lname, fname, dob, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, lname, fname, dob, src, local);

name_dob_summary_layout := record
	name_dob_src.lname;
	name_dob_src.fname;
	name_dob_src.dob;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

name_dob_summary_prep := project(name_dob_src, transform(name_dob_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

name_dob_summary := rollup(name_dob_summary_prep, left.lname=right.lname and left.fname=right.fname and left.dob=right.dob,
	transform(name_dob_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3
export key_name_dob_summary := index(name_dob_summary, {lname, fname, dob}, {name_dob_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::name_dob_summary');
	
	
	
/* *********************************************************************************
keys built from phone base
***********************************************************************************/	

phones_base_layout := record
	string10 					phone10;
	string10          prim_range;
	string28          prim_name;
	string5           zip;
	string20          name_first;
	string20          name_last;
	string2 					src;
	unsigned 					dt_first_seen;
	unsigned					dt_last_seen;
end;

export phones_base := 
	project(gh(phone10<>''), 
		transform(phones_base_layout, self.src := 'GH', self.zip := left.z5, self.dt_first_seen := (unsigned)left.dt_first_seen[1..6], self.dt_last_seen := (unsigned)left.dt_last_seen[1..6], self := left)) +
	project(wp(phone_number<>''), 
		transform(phones_base_layout, self.src := 'WP', self.phone10 := left.phone_number,  self.dt_first_seen := (unsigned)left.dt_first_seen[1..6], self.dt_last_seen := (unsigned)left.dt_last_seen[1..6], 
			self.name_first := left.fname, self.name_last := left.lname, self := left)) +
	project(ir(phone<>''), 
		transform(phones_base_layout, self.src := 'IR', self.phone10 := left.phone,   self.dt_first_seen := (unsigned)left.dt_first_seen[1..6], self.dt_last_seen := (unsigned)left.dt_last_seen[1..6], 
			self.name_first := left.fname, self.name_last := left.lname, self := left)) + 
	project(u(phone<>''), 
		transform(phones_base_layout, self.src := 'UT', self.phone10 := left.phone,  self.dt_first_seen := (unsigned)left.date_first_seen[1..6], self.dt_last_seen := 0,  
			self.name_first := left.fname, self.name_last := left.lname, self := left));	
	
phone_addr_base := distribute(phones_base(trim(phone10)<>'' and trim(prim_name)<>'' and trim(zip)<>''), hash(phone10, prim_name, zip));
shared phone_addr_src := table(phone_addr_base,
	{phone10, prim_name, prim_range, zip, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, 
		phone10, prim_name, prim_range, zip, src, local);
phone_addr_counts := table(phone_addr_src, {phone10, prim_name, prim_range, zip, source_count := count(group)}, phone10, prim_name, prim_range, zip, local);

export key_correlation_phone_addr := index(phone_addr_counts, {phone10, prim_name, prim_range, zip}, {phone_addr_counts}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::phone_addr');


shared phone_addr_summary_layout := record
	phone_addr_src.phone10;
	phone_addr_src.prim_name;
	phone_addr_src.prim_range;
	phone_addr_src.zip;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

phone_addr_summary_prep := project(phone_addr_src, transform(phone_addr_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

phone_addr_summary := rollup(phone_addr_summary_prep, left.phone10=right.phone10 and left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.zip=right.zip,
	transform(phone_addr_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3, will replace 'key_correlation_phone_addr' that was used in previous versions of the shell
export key_phone_addr_summary := index(phone_addr_summary, {phone10, prim_name, prim_range, zip}, {phone_addr_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::phone_addr_summary');


// new key that's built from the header file information instead fo gong, infutor and targus
phone_addr_header_base := distribute(header_base(trim(phone)<>'' and trim(prim_name)<>'' and trim(zip)<>''), hash(phone, prim_name, zip));
shared phone_addr_header_src := table(phone_addr_header_base,
	{phone10 := phone, prim_name, prim_range, zip, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, 
		phone, prim_name, prim_range, zip, src, local);

phone_addr_header_summary_prep := project(phone_addr_header_src, transform(phone_addr_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

phone_addr_header_summary := rollup(phone_addr_header_summary_prep, left.phone10=right.phone10 and left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.zip=right.zip,
	transform(phone_addr_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3, will replace 'key_correlation_phone_addr' that was used in previous versions of the shell
export key_phone_addr_header_summary := index(phone_addr_header_summary, {phone10, prim_name, prim_range, zip}, {phone_addr_header_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::phone_addr_header_summary');
	


phone_lname_base := distribute(phones_base(trim(phone10)<>'' and trim(name_last)<>''), hash(phone10, name_last));
shared phone_lname_src := table( phone_lname_base,
	{phone10, name_last, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, phone10, name_last, src, local);
phone_lname_counts := table(phone_lname_src, {phone10, lname := name_last, source_count := count(group)}, phone10, name_last, local);

export key_correlation_phone_lname := index(phone_lname_counts, {phone10, lname}, {phone_lname_counts}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::phone_lname');	


shared phone_lname_summary_layout := record
	phone_lname_src.phone10;
	phone_lname_src.name_last;
	dataset(common_layout) summary {MAXCOUNT(max_source_summary)};
end;

phone_lname_summary_prep := project(phone_lname_src, transform(phone_lname_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));

phone_lname_summary := rollup(phone_lname_summary_prep, left.phone10=right.phone10 and left.name_last=right.name_last,
	transform(phone_lname_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );

// new for shell 5.3, will replace 'key_correlation_phone_lname' that was used in previous versions of the shell
export key_phone_lname_summary := index(phone_lname_summary, {phone10, lname := name_last}, {phone_lname_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::phone_lname_summary');


// new key that's built from the header file information instead fo gong, infutor and targus
phone_lname_header_base := distribute(header_base(trim(phone)<>'' and trim(lname)<>''), hash(phone, lname));

shared phone_lname_header_src := table( phone_lname_header_base,
	{phone10 := phone, name_last := lname, src, 
		_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,default_max_date,dt_first_seen)),  // get the real first seen date, avoid the records with dt_first_seen=0
		_dt_last_seen := MAX(GROUP,dt_last_seen),
		total := count(group)}, phone, lname, src, local);

phone_lname_header_summary_prep := project(phone_lname_header_src, transform(phone_lname_summary_layout, 
	self.summary := dataset([{left.src, 
										if(left._dt_first_seen=default_max_date, 0, left._dt_first_seen),  // for any max dates, set them back to 0
										left._dt_last_seen,
										left.total}], common_layout);
	self := left));
	
phone_lname_header_summary := rollup(phone_lname_header_summary_prep, left.phone10=right.phone10 and left.name_last=right.name_last,
	transform(phone_lname_summary_layout, 
		self.summary := choosen( (left.summary + right.summary), max_source_summary);
		self := left) );
		
export key_phone_lname_header_summary := index(phone_lname_header_summary, {phone10, lname := name_last}, {phone_lname_header_summary}, 
	Data_Services.Data_location.Prefix('correlation_risk')+ build_version +doxie.Version_SuperKey+'::phone_lname_header_summary');	
	
end;