import	_control, PRTE_CSV;

export	Proc_Build_Headerquick_Keys(string pIndexVersion)	:=
function

	rKeyHeaderquick__autokey__address	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_address;
	end;

	rKeyHeaderquick__autokey__citystname	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_citystname;
	end;

	rKeyHeaderquick__autokey__name	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_name;
	end;

	rKeyHeaderquick__autokey__payload	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_payload;
	end;

	rKeyHeaderquick__autokey__phone	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_phone;
	end;

	rKeyHeaderquick__autokey__ssn	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_ssn;
	end;

	rKeyHeaderquick__autokey__stname	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_stname;
	end;

	rKeyHeaderquick__autokey__zip	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_zip;
	end;

	rKeyHeaderquick__autokey__zipprlname	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__autokey_zipprlname;
	end;

	rKeyHeaderquick__did	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__did;
	end;
rKeyHeaderquick__ssn_validity	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__ssn_validity;
	end;
rKeyHeaderquick__nlr_rid	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__nlr_rid;
	end;
rKeyHeaderquick__ssn_suppression	:=
	record
		PRTE_CSV.Headerquick.rthor_data400__key__headerquick__ssn_suppression;
	end;



	dKeyHeaderquick__autokey__address			:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_address, rKeyHeaderquick__autokey__address);
	dKeyHeaderquick__autokey__citystname	:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_citystname, rKeyHeaderquick__autokey__citystname);
	dKeyHeaderquick__autokey__name				:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_name, rKeyHeaderquick__autokey__name);
	dKeyHeaderquick__autokey__payload			:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_payload, rKeyHeaderquick__autokey__payload);
	dKeyHeaderquick__autokey__phone				:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_phone, rKeyHeaderquick__autokey__phone);
	dKeyHeaderquick__autokey__ssn					:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_ssn, rKeyHeaderquick__autokey__ssn);
	dKeyHeaderquick__autokey__stname			:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_stname, rKeyHeaderquick__autokey__stname);
	dKeyHeaderquick__autokey__zip					:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_zip, rKeyHeaderquick__autokey__zip);
	dKeyHeaderquick__autokey__zipprlname	:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__autokey_zipprlname, rKeyHeaderquick__autokey__zipprlname);
	dKeyHeaderquick__did									:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__did, rKeyHeaderquick__did);
	
		dKeyHeaderquick__ssn_validity									:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__ssn_validity, rKeyHeaderquick__ssn_validity);
	dKeyHeaderquick__nlr_rid									:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__nlr_rid, rKeyHeaderquick__nlr_rid);
	dKeyHeaderquick__ssn_suppression									:= 	project(PRTE_CSV.Headerquick.dthor_data400__key__headerquick__ssn_suppression, rKeyHeaderquick__ssn_suppression);

	
	kKeyHeaderquick__autokey__address			:=	index(dKeyHeaderquick__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyHeaderquick__autokey__address}, '~prte::key::headerquick::' + pIndexVersion + '::autokey_address');
	kKeyHeaderquick__autokey__citystname	:=	index(dKeyHeaderquick__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHeaderquick__autokey__citystname}, '~prte::key::headerquick::' + pIndexVersion + '::autokey_citystname');
	kKeyHeaderquick__autokey__name				:=	index(dKeyHeaderquick__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHeaderquick__autokey__name}, '~prte::key::headerquick::' + pIndexVersion + '::autokey_name');
	kKeyHeaderquick__autokey__payload			:=	index(dKeyHeaderquick__autokey__payload, {fakeid}, {dKeyHeaderquick__autokey__payload}, '~prte::key::headerquick::' + pIndexVersion + '::autokey_payload');
	kKeyHeaderquick__autokey__phone				:=	index(dKeyHeaderquick__autokey__phone, {p7,p3,dph_lname,pfname,st,did}, {dKeyHeaderquick__autokey__phone}, '~prte::key::headerquick::' + pIndexVersion + '::autokey_phone');
	kKeyHeaderquick__autokey__ssn					:=	index(dKeyHeaderquick__autokey__ssn, {s1, s2, s3, s4, s5, s6, s7, s8, s9, dph_lname, pfname, did}, {dKeyHeaderquick__autokey__ssn}, '~prte::key::headerquick::' + pIndexVersion + '::autokey_ssn');
	kKeyHeaderquick__autokey__stname			:=	index(dKeyHeaderquick__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHeaderquick__autokey__stname} ,'~prte::key::headerquick::' + pIndexVersion + '::autokey_stname');
	kKeyHeaderquick__autokey__zip					:=	index(dKeyHeaderquick__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHeaderquick__autokey__zip}, '~prte::key::headerquick::' + pIndexVersion + '::autokey_zip');
	kKeyHeaderquick__autokey__zipprlname	:=	index(dKeyHeaderquick__autokey__zipprlname, {zip,prim_range,lname,lookups,did}, {dKeyHeaderquick__autokey__zipprlname}, '~prte::key::headerquick::' + pIndexVersion + '::autokey_zipprlname');
	kKeyHeaderquick__did									:=	index(dKeyHeaderquick__did, {did}, {dKeyHeaderquick__did}, '~prte::key::headerquick::' + pIndexVersion + '::did');

	kKeyHeaderquick__ssn_validity									:=	index(dKeyHeaderquick__ssn_validity, {ssn},  {ssn, ssn_flags_bitmap}, '~prte::key::headerquick::' + pIndexVersion + '::ssn_validity');
	kKeyHeaderquick__nlr_rid									:=	index(dKeyHeaderquick__nlr_rid, {did, rid}, {dKeyHeaderquick__nlr_rid}, '~prte::key::header_nlr::' + pIndexVersion + '::did.rid');
	kKeyHeaderquick__ssn_suppression									:=	index(dKeyHeaderquick__ssn_suppression, {ssn}, {dKeyHeaderquick__ssn_suppression}, '~prte::key::' + pIndexVersion + '::ssn_suppression');

	return	sequential(
											parallel(
																build(kKeyHeaderquick__autokey__address			, update),
																build(kKeyHeaderquick__autokey__citystname		, update),
																build(kKeyHeaderquick__autokey__name, update),
																build(kKeyHeaderquick__autokey__payload, update),
																build(kKeyHeaderquick__autokey__phone				, update),
																build(kKeyHeaderquick__autokey__ssn				, update),
																build(kKeyHeaderquick__autokey__stname			, update),
																build(kKeyHeaderquick__autokey__zip	, update),
																build(kKeyHeaderquick__autokey__zipprlname			, update),
																build(kKeyHeaderquick__did			, update),
															    build(kKeyHeaderquick__ssn_validity			, update),
															     build(kKeyHeaderquick__nlr_rid			, update),
																build(kKeyHeaderquick__ssn_suppression			, update)



															 ),
											PRTE.UpdateVersion('QuickHeaderKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;