import	_control, PRTE_CSV,header,ut,doxie,NID;

export	Proc_Build_Header_keys(string pIndexVersion)	:=
function

	
	rKeyHeader__hhid__did_ver	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__hhid__did_ver;
	end;

	rKeyHeader__hhid__hhid_ver	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__hhid__hhid_ver;
	end;

	rKeyHeader__rid_srid	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__rid_srid;
	end;

	rKeyHeader__adl_infutor_knowx	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__adl_infutor_knowx;
	end;

	rKeyHeader__lookups_v2	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__lookups_v2;
	end;

	rKeyHeader__address	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__address;
	end;

	rKeyHeader__apt_bldgs	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__apt_bldgs;
	end;

	rKeyHeader__da	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__da;
	end;

	rKeyHeader__data	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__data;
	end;
	
	rKeyHeader__data_new	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__data__new;
	end;

	rKeyHeader__did_ssn_date	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__did_ssn_date;
	end;

	rKeyHeader__dob	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__dob;
	end;

	rKeyHeader__dobname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__dobname;
	end;

	rKeyHeader__fname_ngram	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__fname_ngram;
	end;

	rKeyHeader__fname_small	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__fname_small;
	end;

	rKeyHeader__lname_fname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__lname_fname;
	end;

	rKeyHeader__lname_fname_alt	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__lname_fname_alt;
	end;

	rKeyHeader__lname_ngram	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__lname_ngram;
	end;

	rKeyHeader__minors	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__minors;
	end;

	rKeyHeader__nbr	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__nbr;
	end;

	rKeyHeader__nbr_address	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__nbr_address;
	end;

	rKeyHeader__nbr_uid	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__nbr_uid;
	end;

	rKeyHeader__phone	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__phone;
	end;

	rKeyHeader__phonetic_fname_top10	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__phonetic_fname_top10;
	end;

	rKeyHeader__phonetic_lname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__phonetic_lname;
	end;

	rKeyHeader__phonetic_lname_top10	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__phonetic_lname_top10;
	end;

	rKeyHeader__pname_prange_st_city_sec_range_lname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__pname_prange_st_city_sec_range_lname;
	end;

	rKeyHeader__pname_zip_name_range	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__pname_zip_name_range;
	end;

	rKeyHeader__relatives	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__relatives;
	end;

	rKeyHeader__rid	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__rid;
	end;

	rKeyHeader__rid_did2	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__rid_did2;
	end;

	rKeyHeader__ssn_did	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__ssn_did;
	end;

	rKeyHeader__ssn4_did	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__ssn4_did;
	end;

	rKeyHeader__ssn5_did	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__ssn5_did;
	end;

	rKeyHeader__ssn_address	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__ssn_address;
	end;

	rKeyHeader__st_city_fname_lname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__st_city_fname_lname;
	end;

	rKeyHeader__st_fname_lname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__st_fname_lname;
	end;

	rKeyHeader__zip_lname_fname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__zip_lname_fname;
	end;

	rKeyHeader__zipprlname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__zipprlname;
	end;

	// ge data
	
	header_proj_out :=
						PRTE.Get_Header_Base.GE
					+ 	PRTE.Get_Header_Base.Excelon
					+ 	PRTE.Get_Header_Base.Santander
					;

	dKeyHeader__hhid__did_ver				:= 	project(PRTE_CSV.Header.dthor_data400__key__header__hhid__did_ver, rKeyHeader__hhid__did_ver);
	Prte.header_ds_macro(prKeyHeader__hhid__did_ver,rKeyHeader__hhid__did_ver,header_proj_out,dKeyHeader__hhid__did_ver1);
	dKeyHeader__hhid__hhid_ver			:= 	project(PRTE_CSV.Header.dthor_data400__key__header__hhid__hhid_ver, rKeyHeader__hhid__hhid_ver);
	Prte.header_ds_macro(prKeyHeader__hhid__hhid_ver,rKeyHeader__hhid__hhid_ver,header_proj_out,dKeyHeader__hhid__hhid_ver1);
	dKeyHeader__rid_srid := project(PRTE_CSV.Header.dthor_data400__key__header__rid_srid, rKeyHeader__rid_srid);
	prte.header_ds_macro(prKeyHeader__rid_srid,rKeyHeader__rid_srid,header_proj_out,dKeyHeader__rid_srid1);
	dKeyHeader__adl_infutor_knowx := project(PRTE_CSV.Header.dthor_data400__key__header__adl_infutor_knowx, rKeyHeader__adl_infutor_knowx);
	prte.header_ds_macro(prKeyHeader__adl_infutor_knowx,rKeyHeader__adl_infutor_knowx,header_proj_out,dKeyHeader__adl_infutor_knowx1);
	dKeyHeader__lookups_v2 := project(PRTE_CSV.Header.dthor_data400__key__header__lookups_v2, rKeyHeader__lookups_v2);
	prte.header_ds_macro(prKeyHeader__lookups_v2,rKeyHeader__lookups_v2,header_proj_out,dKeyHeader__lookups_v21);
	dKeyHeader__address := project(PRTE_CSV.Header.dthor_data400__key__header__address, rKeyHeader__address);
	prte.header_ds_macro(prKeyHeader__address,rKeyHeader__address,header_proj_out,dKeyHeader__address1);
	dKeyHeader__apt_bldgs := project(PRTE_CSV.Header.dthor_data400__key__header__apt_bldgs, rKeyHeader__apt_bldgs);
	prte.header_ds_macro(prKeyHeader__apt_bldgs,rKeyHeader__apt_bldgs,header_proj_out,dKeyHeader__apt_bldgs1);
	dKeyHeader__da := project(PRTE_CSV.Header.dthor_data400__key__header__da, rKeyHeader__da);
	prte.header_ds_macro(prKeyHeader__da,rKeyHeader__da,header_proj_out,dKeyHeader__da1);
	dKeyHeader__data := project(PRTE_CSV.Header.dthor_data400__key__header__data, rKeyHeader__data_new);
	prte.header_ds_macro(prKeyHeader__data,rKeyHeader__data_new,header_proj_out,dKeyHeader__data1);
	dKeyHeader__did_ssn_date := project(PRTE_CSV.Header.dthor_data400__key__header__did_ssn_date, rKeyHeader__did_ssn_date);
	prte.header_ds_macro(prKeyHeader__did_ssn_date,rKeyHeader__did_ssn_date,header_proj_out,dKeyHeader__did_ssn_date1);
	dKeyHeader__dob := project(PRTE_CSV.Header.dthor_data400__key__header__dob, rKeyHeader__dob);
	prte.header_ds_macro(prKeyHeader__dob,rKeyHeader__dob,header_proj_out,dKeyHeader__dob1);
	dKeyHeader__dobname := project(PRTE_CSV.Header.dthor_data400__key__header__dobname, rKeyHeader__dobname);
	prte.header_ds_macro(prKeyHeader__dobname,rKeyHeader__dobname,header_proj_out,dKeyHeader__dobname1);
	dKeyHeader__fname_ngram := project(PRTE_CSV.Header.dthor_data400__key__header__fname_ngram, rKeyHeader__fname_ngram);
	prte.header_ds_macro(prKeyHeader__fname_ngram,rKeyHeader__fname_ngram,header_proj_out,dKeyHeader__fname_ngram1);
	///////////
	dKeyHeader__fname_small := project(PRTE_CSV.Header.dthor_data400__key__header__fname_small, rKeyHeader__fname_small);

	rKeyHeader__fname_small prKeyHeader__fname_small(header_proj_out l) := transform
		self.zip := (integer4)l.zip;
		self := l;
		self := [];
	end;

	dKeyHeader__fname_small1 := project(header_proj_out,prKeyHeader__fname_small(left));
	///////////
	dKeyHeader__lname_fname := project(PRTE_CSV.Header.dthor_data400__key__header__lname_fname, rKeyHeader__lname_fname);

	rKeyHeader__lname_fname prKeyHeader__lname_fname(header_proj_out l) := transform
		self.s4 := (unsigned2)l.s4;
		self := l;
		self := [];
	end;

	dKeyHeader__lname_fname1 := project(header_proj_out,prKeyHeader__lname_fname(left));

	dKeyHeader__lname_fname_alt := project(PRTE_CSV.Header.dthor_data400__key__header__lname_fname_alt, rKeyHeader__lname_fname_alt);

	rKeyHeader__lname_fname_alt prKeyHeader__lname_fname_alt(header_proj_out l) := transform
		self.s4 := (unsigned2)l.s4;
		self := l;
		self := [];
	end;

	dKeyHeader__lname_fname_alt1 := project(header_proj_out,prKeyHeader__lname_fname_alt(left));

	dKeyHeader__lname_ngram := project(PRTE_CSV.Header.dthor_data400__key__header__lname_ngram, rKeyHeader__lname_ngram);
	prte.header_ds_macro(prKeyHeader__lname_ngram,rKeyHeader__lname_ngram,header_proj_out,dKeyHeader__lname_ngram1);
	dKeyHeader__minors := project(PRTE_CSV.Header.dthor_data400__key__header__minors, rKeyHeader__minors);
	prte.header_ds_macro(prKeyHeader__minors,rKeyHeader__minors,header_proj_out,dKeyHeader__minors1);
	dKeyHeader__nbr := project(PRTE_CSV.Header.dthor_data400__key__header__nbr, rKeyHeader__nbr);
	prte.header_ds_macro(prKeyHeader__nbr,rKeyHeader__nbr,header_proj_out,dKeyHeader__nbr1);
	dKeyHeader__nbr_address := project(PRTE_CSV.Header.dthor_data400__key__header__nbr_address, rKeyHeader__nbr_address);
	prte.header_ds_macro(prKeyHeader__nbr_address,rKeyHeader__nbr_address,header_proj_out,dKeyHeader__nbr_address1);
	dKeyHeader__nbr_uid := project(PRTE_CSV.Header.dthor_data400__key__header__nbr_uid, rKeyHeader__nbr_uid);
	prte.header_ds_macro(prKeyHeader__nbr_uid,rKeyHeader__nbr_uid,header_proj_out,dKeyHeader__nbr_uid1);
	dKeyHeader__phone := project(PRTE_CSV.Header.dthor_data400__key__header__phone, rKeyHeader__phone);
	prte.header_ds_macro(prKeyHeader__phone,rKeyHeader__phone,header_proj_out,dKeyHeader__phone1);
	dKeyHeader__phonetic_fname_top10 := project(PRTE_CSV.Header.dthor_data400__key__header__phonetic_fname_top10, rKeyHeader__phonetic_fname_top10);
	prte.header_ds_macro(prKeyHeader__phonetic_fname_top10,rKeyHeader__phonetic_fname_top10,header_proj_out,dKeyHeader__phonetic_fname_top101);
	dKeyHeader__phonetic_lname := project(PRTE_CSV.Header.dthor_data400__key__header__phonetic_lname, rKeyHeader__phonetic_lname);
	prte.header_ds_macro(prKeyHeader__phonetic_lname,rKeyHeader__phonetic_lname,header_proj_out,dKeyHeader__phonetic_lname1);
	dKeyHeader__phonetic_lname_top10 := project(PRTE_CSV.Header.dthor_data400__key__header__phonetic_lname_top10, rKeyHeader__phonetic_lname_top10);
	prte.header_ds_macro(prKeyHeader__phonetic_lname_top10,rKeyHeader__phonetic_lname_top10,header_proj_out,dKeyHeader__phonetic_lname_top101);
	dKeyHeader__pname_prange_st_city_sec_range_lname := project(PRTE_CSV.Header.dthor_data400__key__header__pname_prange_st_city_sec_range_lname, rKeyHeader__pname_prange_st_city_sec_range_lname);
	prte.header_ds_macro(prKeyHeader__pname_prange_st_city_sec_range_lname,rKeyHeader__pname_prange_st_city_sec_range_lname,header_proj_out,dKeyHeader__pname_prange_st_city_sec_range_lname1);
	dKeyHeader__pname_zip_name_range := project(PRTE_CSV.Header.dthor_data400__key__header__pname_zip_name_range, rKeyHeader__pname_zip_name_range);

	rKeyHeader__pname_zip_name_range prKeyHeader__pname_zip_name_range(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self := l;
	self := [];
	end;
	dKeyHeader__pname_zip_name_range1 := project(header_proj_out,prKeyHeader__pname_zip_name_range(left));



	dKeyHeader__relatives := project(PRTE_CSV.Header.dthor_data400__key__header__relatives, rKeyHeader__relatives);

	rKeyHeader__relatives prKeyHeader__relatives(header_proj_out l) := transform
	self.prim_range := (integer2)l.prim_range;
	self := l;
	self := [];
	end;
	dKeyHeader__relatives1 := project(header_proj_out,prKeyHeader__relatives(left));

	dKeyHeader__rid := project(PRTE_CSV.Header.dthor_data400__key__header__rid, rKeyHeader__rid);
	prte.header_ds_macro(prKeyHeader__rid,rKeyHeader__rid,header_proj_out,dKeyHeader__rid1);
	dKeyHeader__rid_did2 := project(PRTE_CSV.Header.dthor_data400__key__header__rid_did2, rKeyHeader__rid_did2);
	prte.header_ds_macro(prKeyHeader__rid_did2,rKeyHeader__rid_did2,header_proj_out,dKeyHeader__rid_did21);
	dKeyHeader__ssn_did := project(PRTE_CSV.Header.dthor_data400__key__header__ssn_did, rKeyHeader__ssn_did);
	prte.header_ds_macro(prKeyHeader__ssn_did,rKeyHeader__ssn_did,header_proj_out,dKeyHeader__ssn_did1);
	dKeyHeader__ssn4_did := project(PRTE_CSV.Header.dthor_data400__key__header__ssn4_did, rKeyHeader__ssn4_did);
	prte.header_ds_macro(prKeyHeader__ssn4_did,rKeyHeader__ssn4_did,header_proj_out,dKeyHeader__ssn4_did1);
	dKeyHeader__ssn5_did := project(PRTE_CSV.Header.dthor_data400__key__header__ssn5_did, rKeyHeader__ssn5_did);
	prte.header_ds_macro(prKeyHeader__ssn5_did,rKeyHeader__ssn5_did,header_proj_out,dKeyHeader__ssn5_did1);
	dKeyHeader__ssn_address := project(PRTE_CSV.Header.dthor_data400__key__header__ssn_address, rKeyHeader__ssn_address);
	prte.header_ds_macro(prKeyHeader__ssn_address,rKeyHeader__ssn_address,header_proj_out,dKeyHeader__ssn_address1);
	dKeyHeader__st_city_fname_lname := project(PRTE_CSV.Header.dthor_data400__key__header__st_city_fname_lname, rKeyHeader__st_city_fname_lname);
	prte.header_ds_macro(prKeyHeader__st_city_fname_lname,rKeyHeader__st_city_fname_lname,header_proj_out,dKeyHeader__st_city_fname_lname1);
	dKeyHeader__st_fname_lname := project(PRTE_CSV.Header.dthor_data400__key__header__st_fname_lname, rKeyHeader__st_fname_lname);

	rKeyHeader__st_fname_lname prKeyHeader__st_fname_lname(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self.s4 := (unsigned2)l.s4;
	self := l;
	self := [];
	end;
	dKeyHeader__st_fname_lname1 := project(header_proj_out,prKeyHeader__st_fname_lname(left));


	dKeyHeader__zip_lname_fname := project(PRTE_CSV.Header.dthor_data400__key__header__zip_lname_fname, rKeyHeader__zip_lname_fname);
	rKeyHeader__zip_lname_fname prKeyHeader__zip_lname_fname(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self.s4 := (unsigned2)l.s4;
	self := l;
	self := [];
	end;
	dKeyHeader__zip_lname_fname1 := project(header_proj_out,prKeyHeader__zip_lname_fname(left));



	dKeyHeader__zipprlname := project(PRTE_CSV.Header.dthor_data400__key__header__zipprlname, rKeyHeader__zipprlname);
	rKeyHeader__zipprlname prKeyHeader__zipprlname(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self := l;
	self := [];
	end;
	dKeyHeader__zipprlname1 := project(header_proj_out,prKeyHeader__zipprlname(left));

	fulldKeyHeader__hhid__did_ver := dKeyHeader__hhid__did_ver + dKeyHeader__hhid__did_ver1;
	kKeyHeader__hhid__did_ver := index(fulldKeyHeader__hhid__did_ver, {did,ver}, {fulldKeyHeader__hhid__did_ver}, '~prte::key::header::hhid::' + pIndexVersion + '::did.ver');
	fulldKeyHeader__hhid__hhid_ver := dKeyHeader__hhid__hhid_ver + dKeyHeader__hhid__hhid_ver1;
	kKeyHeader__hhid__hhid_ver := index(fulldKeyHeader__hhid__hhid_ver, {hhid_relat,ver}, {fulldKeyHeader__hhid__hhid_ver}, '~prte::key::header::hhid::' + pIndexVersion + '::hhid.ver');
	fulldKeyHeader__rid_srid := dKeyHeader__rid_srid + dKeyHeader__rid_srid1;
	kKeyHeader__rid_srid := index(fulldKeyHeader__rid_srid, {rid}, {fulldKeyHeader__rid_srid}, '~prte::key::header::' + pIndexVersion + '::rid_srid');
	fulldKeyHeader__adl_infutor_knowx := dKeyHeader__adl_infutor_knowx + dKeyHeader__adl_infutor_knowx1;
	kKeyHeader__adl_infutor_knowx := index(fulldKeyHeader__adl_infutor_knowx, {s_did}, {fulldKeyHeader__adl_infutor_knowx}, '~prte::key::header::' + pIndexVersion + '::adl.infutor.knowx');
	fulldKeyHeader__lookups_v2 := dKeyHeader__lookups_v2 + dKeyHeader__lookups_v21;
	kKeyHeader__lookups_v2 := index(fulldKeyHeader__lookups_v2, {did}, {fulldKeyHeader__lookups_v2}, '~prte::key::header::' + pIndexVersion + '::lookups_v2');
	fulldKeyHeader__address := dKeyHeader__address + dKeyHeader__address1;
	kKeyHeader__address := index(fulldKeyHeader__address, {prim_name,zip,prim_range,sec_range}, {fulldKeyHeader__address}, '~prte::key::header::' + pIndexVersion + '::address');
	fulldKeyHeader__apt_bldgs := dKeyHeader__apt_bldgs + dKeyHeader__apt_bldgs1;
	kKeyHeader__apt_bldgs := index(fulldKeyHeader__apt_bldgs, {prim_range,prim_name,zip,suffix,predir}, {fulldKeyHeader__apt_bldgs}, '~prte::key::header::' + pIndexVersion + '::apt_bldgs');
	fulldKeyHeader__da := dKeyHeader__da + dKeyHeader__da1;
	kKeyHeader__da := index(fulldKeyHeader__da, {l4,st,city_code,f3,lname,fname,yob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__da}, '~prte::key::header::' + pIndexVersion + '::da');
	fulldKeyHeader__data := dKeyHeader__data + dKeyHeader__data1;
	kKeyHeader__data := index(fulldKeyHeader__data, {s_did}, {fulldKeyHeader__data}, '~prte::key::header::' + pIndexVersion + '::data');
	fulldKeyHeader__did_ssn_date := dKeyHeader__did_ssn_date + dKeyHeader__did_ssn_date1;
	kKeyHeader__did_ssn_date := index(fulldKeyHeader__did_ssn_date, {did,ssn}, {fulldKeyHeader__did_ssn_date}, '~prte::key::header::' + pIndexVersion + '::did.ssn.date');
	fulldKeyHeader__dob := dKeyHeader__dob + dKeyHeader__dob1;
	kKeyHeader__dob := index(fulldKeyHeader__dob, {dob,fname,pfname,st,zip}, {fulldKeyHeader__dob}, '~prte::key::header::' + pIndexVersion + '::dob');
	fulldKeyHeader__dobname := dKeyHeader__dobname + dKeyHeader__dobname1;
	kKeyHeader__dobname := index(fulldKeyHeader__dobname, {yob,dph_lname,lname,pfname,fname,mob,day,st,zip,dob}, {fulldKeyHeader__dobname}, '~prte::key::header::' + pIndexVersion + '::dobname');
	fulldKeyHeader__fname_ngram := dKeyHeader__fname_ngram + dKeyHeader__fname_ngram1;
	kKeyHeader__fname_ngram := index(fulldKeyHeader__fname_ngram, {ngram}, {fulldKeyHeader__fname_ngram}, '~prte::key::header::' + pIndexVersion + '::fname_ngram');
	fulldKeyHeader__fname_small := dKeyHeader__fname_small + dKeyHeader__fname_small1;
	kKeyHeader__fname_small := index(fulldKeyHeader__fname_small, {pfname,st,zip,prim_name,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {fulldKeyHeader__fname_small}, '~prte::key::header::' + pIndexVersion + '::fname_small');
	fulldKeyHeader__lname_fname := dKeyHeader__lname_fname + dKeyHeader__lname_fname1;
	kKeyHeader__lname_fname := index(fulldKeyHeader__lname_fname, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__lname_fname}, '~prte::key::header::' + pIndexVersion + '::lname.fname');
	fulldKeyHeader__lname_fname_alt := dKeyHeader__lname_fname_alt + dKeyHeader__lname_fname_alt1;
	kKeyHeader__lname_fname_alt := index(fulldKeyHeader__lname_fname_alt, {dph_lname,pfname,fname,lname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__lname_fname_alt}, '~prte::key::header::' + pIndexVersion + '::lname.fname_alt');
	fulldKeyHeader__lname_ngram := dKeyHeader__lname_ngram + dKeyHeader__lname_ngram1;
	kKeyHeader__lname_ngram := index(fulldKeyHeader__lname_ngram, {ngram}, {fulldKeyHeader__lname_ngram}, '~prte::key::header::' + pIndexVersion + '::lname_ngram');
	fulldKeyHeader__minors := dKeyHeader__minors + dKeyHeader__minors1;
	kKeyHeader__minors := index(fulldKeyHeader__minors, {did}, {fulldKeyHeader__minors}, '~prte::key::header::' + pIndexVersion + '::minors');
	fulldKeyHeader__nbr := dKeyHeader__nbr + dKeyHeader__nbr1;
	kKeyHeader__nbr := index(fulldKeyHeader__nbr, {zip,prim_name,suffix,predir,postdir,prim_range,sec_range}, {fulldKeyHeader__nbr}, '~prte::key::header::' + pIndexVersion + '::nbr');
	fulldKeyHeader__nbr_address := dKeyHeader__nbr_address + dKeyHeader__nbr_address1;
	kKeyHeader__nbr_address := index(fulldKeyHeader__nbr_address, {prim_name,zip,z2,suffix,prim_range}, {fulldKeyHeader__nbr_address}, '~prte::key::header::' + pIndexVersion + '::nbr_address');
	fulldKeyHeader__nbr_uid := dKeyHeader__nbr_uid + dKeyHeader__nbr_uid1;
	kKeyHeader__nbr_uid := index(fulldKeyHeader__nbr_uid, {zip,prim_name,suffix,predir,postdir,uid}, {fulldKeyHeader__nbr_uid}, '~prte::key::header::' + pIndexVersion + '::nbr_uid');
	fulldKeyHeader__phone := dKeyHeader__phone + dKeyHeader__phone1;
	kKeyHeader__phone := index(fulldKeyHeader__phone, {p7,p3,dph_lname,pfname,st}, {fulldKeyHeader__phone}, '~prte::key::header::' + pIndexVersion + '::phone');
	fulldKeyHeader__phonetic_fname_top10 := dKeyHeader__phonetic_fname_top10 + dKeyHeader__phonetic_fname_top101;
	kKeyHeader__phonetic_fname_top10 := index(fulldKeyHeader__phonetic_fname_top10, {ph_fname}, {fulldKeyHeader__phonetic_fname_top10}, '~prte::key::header::' + pIndexVersion + '::phonetic_fname_top10');
	fulldKeyHeader__phonetic_lname := dKeyHeader__phonetic_lname + dKeyHeader__phonetic_lname1;
	kKeyHeader__phonetic_lname := index(fulldKeyHeader__phonetic_lname, {dph_lname}, {fulldKeyHeader__phonetic_lname}, '~prte::key::header::' + pIndexVersion + '::phonetic_lname');
	fulldKeyHeader__phonetic_lname_top10 := dKeyHeader__phonetic_lname_top10 + dKeyHeader__phonetic_lname_top101;
	kKeyHeader__phonetic_lname_top10 := index(fulldKeyHeader__phonetic_lname_top10, {ph_lname}, {fulldKeyHeader__phonetic_lname_top10}, '~prte::key::header::' + pIndexVersion + '::phonetic_lname_top10');
	fulldKeyHeader__pname_prange_st_city_sec_range_lname := dKeyHeader__pname_prange_st_city_sec_range_lname + dKeyHeader__pname_prange_st_city_sec_range_lname1;
	kKeyHeader__pname_prange_st_city_sec_range_lname := index(fulldKeyHeader__pname_prange_st_city_sec_range_lname, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {fulldKeyHeader__pname_prange_st_city_sec_range_lname}, '~prte::key::header::' + pIndexVersion + '::pname.prange.st.city.sec_range.lname');
	fulldKeyHeader__pname_zip_name_range := dKeyHeader__pname_zip_name_range + dKeyHeader__pname_zip_name_range1;
	kKeyHeader__pname_zip_name_range := index(fulldKeyHeader__pname_zip_name_range, {prim_name,zip,dph_lname,pfname,prim_range,lname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__pname_zip_name_range}, '~prte::key::header::' + pIndexVersion + '::pname.zip.name.range');
	fulldKeyHeader__relatives := dKeyHeader__relatives + dKeyHeader__relatives1;
	kKeyHeader__relatives := index(fulldKeyHeader__relatives, {person1,same_lname,number_cohabits,recent_cohabit,person2}, {fulldKeyHeader__relatives}, '~prte::key::header::' + pIndexVersion + '::relatives');
	fulldKeyHeader__rid := dKeyHeader__rid + dKeyHeader__rid1;
	kKeyHeader__rid := index(fulldKeyHeader__rid, {rid}, {fulldKeyHeader__rid}, '~prte::key::header::' + pIndexVersion + '::rid');
	fulldKeyHeader__rid_did2 := dKeyHeader__rid_did2 + dKeyHeader__rid_did21;
	kKeyHeader__rid_did2 := index(fulldKeyHeader__rid_did2, {rid}, {fulldKeyHeader__rid_did2}, '~prte::key::header::' + pIndexVersion + '::rid_did2');
	fulldKeyHeader__ssn_did := dKeyHeader__ssn_did + dKeyHeader__ssn_did1;
	kKeyHeader__ssn_did := index(fulldKeyHeader__ssn_did, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname}, {fulldKeyHeader__ssn_did}, '~prte::key::header::' + pIndexVersion + '::ssn.did');
	fulldKeyHeader__ssn4_did := dKeyHeader__ssn4_did + dKeyHeader__ssn4_did1;
	kKeyHeader__ssn4_did := index(fulldKeyHeader__ssn4_did, {ssn4,lname,fname}, {fulldKeyHeader__ssn4_did}, '~prte::key::header::' + pIndexVersion + '::ssn4.did');
	fulldKeyHeader__ssn5_did := dKeyHeader__ssn5_did + dKeyHeader__ssn5_did1;
	kKeyHeader__ssn5_did := index(fulldKeyHeader__ssn5_did, {ssn5,lname,fname}, {fulldKeyHeader__ssn5_did}, '~prte::key::header::' + pIndexVersion + '::ssn5.did');
	fulldKeyHeader__ssn_address := dKeyHeader__ssn_address + dKeyHeader__ssn_address1;
	kKeyHeader__ssn_address := index(fulldKeyHeader__ssn_address, {ssn,prim_name}, {fulldKeyHeader__ssn_address}, '~prte::key::header::' + pIndexVersion + '::ssn_address');
	fulldKeyHeader__st_city_fname_lname := dKeyHeader__st_city_fname_lname + dKeyHeader__st_city_fname_lname1;
	kKeyHeader__st_city_fname_lname := index(fulldKeyHeader__st_city_fname_lname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__st_city_fname_lname}, '~prte::key::header::' + pIndexVersion + '::st.city.fname.lname');
	fulldKeyHeader__st_fname_lname := dKeyHeader__st_fname_lname + dKeyHeader__st_fname_lname1;
	kKeyHeader__st_fname_lname := index(fulldKeyHeader__st_fname_lname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__st_fname_lname}, '~prte::key::header::' + pIndexVersion + '::st.fname.lname');
	fulldKeyHeader__zip_lname_fname := dKeyHeader__zip_lname_fname + dKeyHeader__zip_lname_fname1;
	kKeyHeader__zip_lname_fname := index(fulldKeyHeader__zip_lname_fname, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__zip_lname_fname}, '~prte::key::header::' + pIndexVersion + '::zip.lname.fname');
	fulldKeyHeader__zipprlname := dKeyHeader__zipprlname + dKeyHeader__zipprlname1;
	kKeyHeader__zipprlname := index(fulldKeyHeader__zipprlname, {zip,prim_range,lname,lookups}, {fulldKeyHeader__zipprlname}, '~prte::key::header::' + pIndexVersion + '::zipprlname');

	arecord1 :=
	RECORD
	  unsigned6 rid;
	  unsigned6 did;
	  string2 src;
	  integer4 dob;
	  unsigned3 dt_first_seen;
	  unsigned3 dt_last_seen;
	 END;


	kKeyHeader__tuch_dob := buildindex(index(dataset([],arecord1),{rid},{dataset([],arecord1)},'keyname'),'~prte::key::header::' + pIndexVersion + '::tuch_dob',update);

	arecord2 :=
	RECORD
	  qstring9 ssn;
	  unsigned6 did;

	 END;


	kKeyHeader__legacy_ssn := buildindex(index(dataset([],arecord2),{ssn},{dataset([],arecord2)},'keyname'),'~prte::key::header::' + pIndexVersion + '::legacy_ssn',update);

	arecord3 :={ unsigned8 rid, unsigned8 did };

	kKeyHeader__did_rid := buildindex(index(dataset([],arecord3),{rid},{dataset([],arecord3)},'keyname'),'~prte::key::lab::' + pIndexVersion + '::did_rid',update);


	rKeyheader_dts__fname_small:={PRTE_CSV.Header_dts.rthor_data400__key__header__dts__fname_small;};
	rKeyheader_dts__fname_small_redefine:={PRTE_CSV.Header_dts.rthor_data400__key__header__dts__fname_small_redefine};
	rKeyheader_dts__pname_prange_st_city_sec_range_lname:={PRTE_CSV.Header_dts.rthor_data400__key__header__dts__pname_prange_st_city_sec_range_lname;};
	rKeyheader_dts__pname_zip_name_range:={PRTE_CSV.Header_dts.rthor_data400__key__header__dts__pname_zip_name_range;};
	rKeyheader_dts__pname_zip_name_range_redefine:={PRTE_CSV.Header_dts.rthor_data400__key__header__dts__pname_zip_name_range_redefine};


	dKeyheader_dts__fname_small:=PROJECT(PRTE_CSV.Header_dts.dthor_data400__key__header__dts__fname_small,rKeyheader_dts__fname_small);
	Prte.header_ds_macro(prKeyheader_dts__fname_small,rKeyheader_dts__fname_small_redefine,header_proj_out,dKeyheader_dts__fname_small1);

	dKeyheader_dts__pname_prange_st_city_sec_range_lname:=PROJECT(PRTE_CSV.Header_dts.dthor_data400__key__header__dts__pname_prange_st_city_sec_range_lname,rKeyheader_dts__pname_prange_st_city_sec_range_lname);
	Prte.header_ds_macro(prKeyheader_dts__pname_prange_st_city_sec_range_lname,rKeyheader_dts__pname_prange_st_city_sec_range_lname,header_proj_out,dKeyheader_dts__pname_prange_st_city_sec_range_lname1);

	dKeyheader_dts__pname_zip_name_range:=PROJECT(PRTE_CSV.Header_dts.dthor_data400__key__header__dts__pname_zip_name_range,rKeyheader_dts__pname_zip_name_range);
	Prte.header_ds_macro(prKeyheader_dts__pname_zip_name_range,rKeyheader_dts__pname_zip_name_range_redefine,header_proj_out,dKeyheader_dts__pname_zip_name_range1);


	fulldKeyHeader__dts__fname_small := dKeyHeader_dts__fname_small + project(dKeyHeader_dts__fname_small1,transform(rKeyheader_dts__fname_small,self.zip:=(integer4)left.zip,self:=left));
	kKeyheader_dts__fname_small:=INDEX(fulldKeyHeader__dts__fname_small,{fulldKeyHeader__dts__fname_small},'~prte::key::header::dts::'+pIndexVersion+'::fname_small');

	fulldKeyHeader__dts__pname_prange_st_city_sec_range_lname := dKeyHeader_dts__pname_prange_st_city_sec_range_lname + dKeyHeader_dts__pname_prange_st_city_sec_range_lname1;
	kKeyheader_dts__pname_prange_st_city_sec_range_lname:=INDEX(fulldKeyHeader__dts__pname_prange_st_city_sec_range_lname,{fulldKeyHeader__dts__pname_prange_st_city_sec_range_lname},'~prte::key::header::dts::'+pIndexVersion+'::pname.prange.st.city.sec_range.lname');

	fulldKeyHeader__dts__pname_zip_name_range := dKeyHeader_dts__pname_zip_name_range + project(dKeyHeader_dts__pname_zip_name_range1,transform(rKeyheader_dts__pname_zip_name_range,self.zip:=(integer4)left.zip,self:=left));
	kKeyheader_dts__pname_zip_name_range:=INDEX(fulldKeyHeader__dts__pname_zip_name_range,{fulldKeyHeader__dts__pname_zip_name_range},'~prte::key::header::dts::'+pIndexVersion+'::pname.zip.name.range');



	rKeyheader_wild__fname_small:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__fname_small;};
	
	rKeyheader_wild__lname_fname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__lname_fname;};
	rKeyheader_wild__phone:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__phone;};
	rKeyheader_wild__pname_prange_st_city_sec_range_lname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__pname_prange_st_city_sec_range_lname;};
	rKeyheader_wild__pname_zip_name_range:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__pname_zip_name_range;};
	rKeyheader_wild__ssn_did:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__ssn_did;};
	rKeyheader_wild__st_city_fname_lname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__st_city_fname_lname;};
	rKeyheader_wild__st_fname_lname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__st_fname_lname;};
	rKeyheader_wild__zip_lname_fname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__zip_lname_fname;};

	dKeyheader_wild__fname_small:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__fname_small,rKeyheader_wild__fname_small);
	rKeyheader_wild__fname_small prKeyheader_wild__fname_small(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self := l;
	self := [];

	end;
	
	dKeyheader_wild__fname_small1 := project(header_proj_out,prKeyheader_wild__fname_small(left));
	
	dKeyheader_wild__lname_fname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__lname_fname,rKeyheader_wild__lname_fname);
	
	rKeyheader_wild__lname_fname prKeyheader_wild__lname_fname(header_proj_out l) := transform
	self.s4 := (unsigned2)l.ssn4;
	self := l;
	self := [];

	end;
	
	dKeyheader_wild__lname_fname1 := project(header_proj_out,prKeyheader_wild__lname_fname(left));
	
	dKeyheader_wild__phone:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__phone,rKeyheader_wild__phone);
	prte.header_ds_macro(prKeyheader_wild__phone,rKeyheader_wild__phone,header_proj_out,dKeyheader_wild__phone1);

	dKeyheader_wild__pname_prange_st_city_sec_range_lname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__pname_prange_st_city_sec_range_lname,rKeyheader_wild__pname_prange_st_city_sec_range_lname);
	prte.header_ds_macro(prKeyheader_wild__pname_prange_st_city_sec_range_lname,rKeyheader_wild__pname_prange_st_city_sec_range_lname,header_proj_out,dKeyheader_wild__pname_prange_st_city_sec_range_lname1);
	dKeyheader_wild__pname_zip_name_range:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__pname_zip_name_range,rKeyheader_wild__pname_zip_name_range);
	rKeyheader_wild__pname_zip_name_range prKeyheader_wild__pname_zip_name_range(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self := l;
	self := [];
	end;
	
	dKeyheader_wild__pname_zip_name_range1 := project(header_proj_out,prKeyheader_wild__pname_zip_name_range(left));
	dKeyheader_wild__ssn_did:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__ssn_did,rKeyheader_wild__ssn_did);
	prte.header_ds_macro(prKeyheader_wild__ssn_did,rKeyheader_wild__ssn_did,header_proj_out,dKeyheader_wild__ssn_did1);
	dKeyheader_wild__st_city_fname_lname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__st_city_fname_lname,rKeyheader_wild__st_city_fname_lname);
	prte.header_ds_macro(prKeyheader_wild__st_city_fname_lname,rKeyheader_wild__st_city_fname_lname,header_proj_out,dKeyheader_wild__st_city_fname_lname1);
	dKeyheader_wild__st_fname_lname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__st_fname_lname,rKeyheader_wild__st_fname_lname);
	rKeyheader_wild__st_fname_lname prKeyheader_wild__st_fname_lname(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self.s4 := (unsigned2)l.ssn4;
	self := l;
	self := [];
	end;
	dKeyheader_wild__st_fname_lname1 := project(header_proj_out,prKeyheader_wild__st_fname_lname(left));
	
	dKeyheader_wild__zip_lname_fname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__zip_lname_fname,rKeyheader_wild__zip_lname_fname);
	rKeyheader_wild__zip_lname_fname prKeyheader_wild__zip_lname_fname(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self.s4 := (unsigned2)l.ssn4;
	self := l;
	self := [];
	end;
	dKeyheader_wild__zip_lname_fname1 := project(header_proj_out,prKeyheader_wild__zip_lname_fname(left));
	
	fulldKeyheader_wild__fname_small := dKeyheader_wild__fname_small + dKeyheader_wild__fname_small1;
	kKeyheader_wild__fname_small:=INDEX(fulldKeyheader_wild__fname_small,{fulldKeyheader_wild__fname_small},'~prte::key::header_wild::'+pIndexVersion+'::fname_small');
	fulldKeyheader_wild__lname_fname := dKeyheader_wild__lname_fname + dKeyheader_wild__lname_fname1;
	kKeyheader_wild__lname_fname:=INDEX(fulldKeyheader_wild__lname_fname,{fulldKeyheader_wild__lname_fname},'~prte::key::header_wild::'+pIndexVersion+'::lname.fname');
	fulldKeyheader_wild__phone := dKeyheader_wild__phone + dKeyheader_wild__phone1;
	kKeyheader_wild__phone:=INDEX(fulldKeyheader_wild__phone,{fulldKeyheader_wild__phone},'~prte::key::header_wild::'+pIndexVersion+'::phone');
	fulldKeyheader_wild__pname_prange_st_city_sec_range_lname := dKeyheader_wild__pname_prange_st_city_sec_range_lname + dKeyheader_wild__pname_prange_st_city_sec_range_lname1;
	kKeyheader_wild__pname_prange_st_city_sec_range_lname:=INDEX(fulldKeyheader_wild__pname_prange_st_city_sec_range_lname,{fulldKeyheader_wild__pname_prange_st_city_sec_range_lname},'~prte::key::header_wild::'+pIndexVersion+'::pname.prange.st.city.sec_range.lname');
	fulldKeyheader_wild__pname_zip_name_range := dKeyheader_wild__pname_zip_name_range + dKeyheader_wild__pname_zip_name_range1;
	kKeyheader_wild__pname_zip_name_range:=INDEX(fulldKeyheader_wild__pname_zip_name_range,{fulldKeyheader_wild__pname_zip_name_range},'~prte::key::header_wild::'+pIndexVersion+'::pname.zip.name.range');
	fulldKeyheader_wild__ssn_did := dKeyheader_wild__ssn_did + dKeyheader_wild__ssn_did1;
	kKeyheader_wild__ssn_did:=INDEX(fulldKeyheader_wild__ssn_did,{fulldKeyheader_wild__ssn_did},'~prte::key::header_wild::'+pIndexVersion+'::ssn.did');
	fulldKeyheader_wild__st_city_fname_lname := dKeyheader_wild__st_city_fname_lname + dKeyheader_wild__st_city_fname_lname1;
	kKeyheader_wild__st_city_fname_lname:=INDEX(fulldKeyheader_wild__st_city_fname_lname,{fulldKeyheader_wild__st_city_fname_lname},'~prte::key::header_wild::'+pIndexVersion+'::st.city.fname.lname');
	fulldKeyheader_wild__st_fname_lname := dKeyheader_wild__st_fname_lname + dKeyheader_wild__st_fname_lname1;
	kKeyheader_wild__st_fname_lname:=INDEX(fulldKeyheader_wild__st_fname_lname,{fulldKeyheader_wild__st_fname_lname},'~prte::key::header_wild::'+pIndexVersion+'::st.fname.lname');
	fulldKeyheader_wild__zip_lname_fname := dKeyheader_wild__zip_lname_fname + dKeyheader_wild__zip_lname_fname1;
	kKeyheader_wild__zip_lname_fname:=INDEX(fulldKeyheader_wild__zip_lname_fname,{fulldKeyheader_wild__zip_lname_fname},'~prte::key::header_wild::'+pIndexVersion+'::zip.lname.fname');



	return	sequential(
					parallel(
						build(kKeyHeader__hhid__did_ver			, update)
						,build(kKeyHeader__hhid__hhid_ver			, update)
						,build(kKeyHeader__rid_srid			, update)
						,build(kKeyHeader__adl_infutor_knowx			, update)
						,build(kKeyHeader__lookups_v2			, update)
						,build(kKeyHeader__address			, update)
						,build(kKeyHeader__apt_bldgs			, update)
						,build(kKeyHeader__da			, update)
						,build(kKeyHeader__data			, update)
						,build(kKeyHeader__did_ssn_date			, update)
						,build(kKeyHeader__dob			, update)
						,build(kKeyHeader__dobname			, update)
						,build(kKeyHeader__fname_ngram			, update)
						,build(kKeyHeader__fname_small			, update)
						,build(kKeyHeader__lname_fname			, update)
						,build(kKeyHeader__lname_fname_alt			, update)
						,build(kKeyHeader__lname_ngram			, update)
						,build(kKeyHeader__minors			, update)
						,build(kKeyHeader__nbr			, update)
						,build(kKeyHeader__nbr_address			, update)
						,build(kKeyHeader__nbr_uid			, update)
						,build(kKeyHeader__phone			, update)
						,build(kKeyHeader__phonetic_fname_top10			, update)
						,build(kKeyHeader__phonetic_lname			, update)
						,build(kKeyHeader__phonetic_lname_top10			, update)
						,build(kKeyHeader__pname_prange_st_city_sec_range_lname			, update)
						,build(kKeyHeader__pname_zip_name_range			, update)
						,build(kKeyHeader__relatives			, update)
						,build(kKeyHeader__rid			, update)
						,build(kKeyHeader__rid_did2			, update)
						,build(kKeyHeader__ssn_did			, update)
						,build(kKeyHeader__ssn4_did			, update)
						,build(kKeyHeader__ssn5_did			, update)
						,build(kKeyHeader__ssn_address			, update)
						,build(kKeyHeader__st_city_fname_lname			, update)
						,build(kKeyHeader__st_fname_lname			, update)
						,build(kKeyHeader__zip_lname_fname			, update)
						,build(kKeyHeader__zipprlname			, update)

						,kKeyHeader__tuch_dob
						,kKeyHeader__legacy_ssn
						,kKeyHeader__did_rid

						,build(kKeyheader_dts__fname_small,UPDATE)
						,build(kKeyheader_dts__pname_prange_st_city_sec_range_lname,UPDATE)
						,build(kKeyheader_dts__pname_zip_name_range,UPDATE)

						,build(kKeyheader_wild__fname_small,UPDATE)
						,build(kKeyheader_wild__lname_fname,UPDATE)
						,build(kKeyheader_wild__phone,UPDATE)
						,build(kKeyheader_wild__pname_prange_st_city_sec_range_lname,UPDATE)
						,build(kKeyheader_wild__pname_zip_name_range,UPDATE)
						,build(kKeyheader_wild__ssn_did,UPDATE)
						,build(kKeyheader_wild__st_city_fname_lname,UPDATE)
						,build(kKeyheader_wild__st_fname_lname,UPDATE)
						,build(kKeyheader_wild__zip_lname_fname,UPDATE)

					 )
					,PRTE.UpdateVersion( 'PersonHeaderKeys', pIndexVersion, _control.MyInfo.EmailAddressNormal, 'B', 'N', 'N')
 );


end;
