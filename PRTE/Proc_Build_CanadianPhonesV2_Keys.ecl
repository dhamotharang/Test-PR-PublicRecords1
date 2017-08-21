IMPORT	_control, PRTE_CSV,CanadianPhones_V2;

EXPORT Proc_Build_CanadianPhonesV2_Keys(string pIndexVersion) := FUNCTION
	
	rKeyCanadianPhonesV2__fdids__key	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__fdids;
	END;
	
	rKeyCanadianPhonesV2__autokey__address	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__address;
	END;
	
	rKeyCanadianPhonesV2__autokey__addressb2	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__addressb2;
	END;
	
	rKeyCanadianPhonesV2__autokey__citystname	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__citystname;
	END;

	rKeyCanadianPhonesV2__autokey__citystnameb2	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__citystnameb2;
	END;

	rKeyCanadianPhonesV2__autokey__name	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__name;
	END;

	rKeyCanadianPhonesV2__autokey__nameb2	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__nameb2;
	END;

	rKeyCanadianPhonesV2__autokey__namewords2	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__namewords2;
	END;

	rKeyCanadianPhonesV2__autokey__phone2	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__phone2;
	END;

	rKeyCanadianPhonesV2__autokey__phoneb2	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__phoneb2;
	END;

	rKeyCanadianPhonesV2__autokey__stname	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__stname;
	END;

	rKeyCanadianPhonesV2__autokey__stnameb2	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__stnameb2;
	END;

	rKeyCanadianPhonesV2__autokey__zip	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__zip;
	END;

	rKeyCanadianPhonesV2__autokey__zipb2	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__zipb2;
	END;

	rKeyCanadianPhonesV2__autokey__zipprlname	:=
	RECORD
		PRTE_CSV.CanadianPhonesV2.rthor_data400__key__canadianphonesv2__autokey__zipprlname;
	END;



	dKeyCanadianPhonesV2__fdids__key						:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__fdids, rKeyCanadianPhonesV2__fdids__key);
	dKeyCanadianPhonesV2__autokey__address			:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__address, rKeyCanadianPhonesV2__autokey__address);
	dKeyCanadianPhonesV2__autokey__addressb2		:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__addressb2, rKeyCanadianPhonesV2__autokey__addressb2);
	dKeyCanadianPhonesV2__autokey__citystname		:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__citystname, rKeyCanadianPhonesV2__autokey__citystname);
	dKeyCanadianPhonesV2__autokey__citystnameb2	:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__citystnameb2, rKeyCanadianPhonesV2__autokey__citystnameb2);
	dKeyCanadianPhonesV2__autokey__name					:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__name, rKeyCanadianPhonesV2__autokey__name);
	dKeyCanadianPhonesV2__autokey__nameb2				:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__nameb2, rKeyCanadianPhonesV2__autokey__nameb2);
	dKeyCanadianPhonesV2__autokey__namewords2		:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__namewords2, rKeyCanadianPhonesV2__autokey__namewords2);
	dKeyCanadianPhonesV2__autokey__phone2				:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__phone2, rKeyCanadianPhonesV2__autokey__phone2);
	dKeyCanadianPhonesV2__autokey__phoneb2			:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__phoneb2, rKeyCanadianPhonesV2__autokey__phoneb2);
	dKeyCanadianPhonesV2__autokey__stname				:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__stname, rKeyCanadianPhonesV2__autokey__stname);
	dKeyCanadianPhonesV2__autokey__stnameb2			:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__stnameb2, rKeyCanadianPhonesV2__autokey__stnameb2);
	dKeyCanadianPhonesV2__autokey__zip					:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__zip, rKeyCanadianPhonesV2__autokey__zip);
	dKeyCanadianPhonesV2__autokey__zipb2				:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__zipb2, rKeyCanadianPhonesV2__autokey__zipb2);
	dKeyCanadianPhonesV2__autokey__zipprlname		:= 	project(PRTE_CSV.CanadianPhonesV2.dthor_data400__key__canadianphonesv2__autokey__zipprlname, rKeyCanadianPhonesV2__autokey__zipprlname);
	
	kKeyCanadianPhonesV2__fdids__key						:=	index(dKeyCanadianPhonesV2__fdids__key, {fdid}, {dKeyCanadianPhonesV2__fdids__key}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::fdids');
	kKeyCanadianPhonesV2__autokey__address			:=	index(dKeyCanadianPhonesV2__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,lookups}, {dKeyCanadianPhonesV2__autokey__address}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::address');
	kKeyCanadianPhonesV2__autokey__addressb2		:=	index(dKeyCanadianPhonesV2__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyCanadianPhonesV2__autokey__addressb2}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::addressb2');
	kKeyCanadianPhonesV2__autokey__citystname	:=	index(dKeyCanadianPhonesV2__autokey__citystname, {city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {dKeyCanadianPhonesV2__autokey__citystname}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::citystname');
	kKeyCanadianPhonesV2__autokey__citystnameb2:=	index(dKeyCanadianPhonesV2__autokey__citystnameb2, {city_code, st, cname_indic,cname_sec, bdid}, {dKeyCanadianPhonesV2__autokey__citystnameb2}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::citystnameb2');
	kKeyCanadianPhonesV2__autokey__name				:=	index(dKeyCanadianPhonesV2__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCanadianPhonesV2__autokey__name}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::name');
	kKeyCanadianPhonesV2__autokey__nameb2			:=	index(dKeyCanadianPhonesV2__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyCanadianPhonesV2__autokey__nameb2}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::nameb2');
	kKeyCanadianPhonesV2__autokey__namewords2	:=	index(dKeyCanadianPhonesV2__autokey__namewords2, {word,state,seq,bdid}, {dKeyCanadianPhonesV2__autokey__namewords2}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::namewords2');
	kKeyCanadianPhonesV2__autokey__phone2			:=	index(dKeyCanadianPhonesV2__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyCanadianPhonesV2__autokey__phone2}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::phone2');
	kKeyCanadianPhonesV2__autokey__phoneb2			:=	index(dKeyCanadianPhonesV2__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyCanadianPhonesV2__autokey__phoneb2}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::phoneb2');
	kKeyCanadianPhonesV2__autokey__stname			:=	index(dKeyCanadianPhonesV2__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCanadianPhonesV2__autokey__stname}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::stname');
	kKeyCanadianPhonesV2__autokey__stnameb2		:=	index(dKeyCanadianPhonesV2__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyCanadianPhonesV2__autokey__stnameb2}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::stnameb2');
	kKeyCanadianPhonesV2__autokey__zip					:=	index(dKeyCanadianPhonesV2__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,did}, {dKeyCanadianPhonesV2__autokey__zip}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::zip');
	kKeyCanadianPhonesV2__autokey__zipb2				:=	index(dKeyCanadianPhonesV2__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyCanadianPhonesV2__autokey__zipb2}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::zipb2');
	kKeyCanadianPhonesV2__autokey__zipprlname	:=	index(dKeyCanadianPhonesV2__autokey__zipprlname, {zip,prim_range,lname,lookups}, {dKeyCanadianPhonesV2__autokey__zipprlname}, '~prte::key::canadianwp_v2::' + pIndexVersion + '::autokey::zipprlname');

	return	sequential(
											parallel(																
																build(kKeyCanadianPhonesV2__fdids__key, update),
																build(kKeyCanadianPhonesV2__autokey__address, update),
																build(kKeyCanadianPhonesV2__autokey__addressb2, update),
																build(kKeyCanadianPhonesV2__autokey__citystname, update),
																build(kKeyCanadianPhonesV2__autokey__citystnameb2, update),
																build(kKeyCanadianPhonesV2__autokey__name, update),
																build(kKeyCanadianPhonesV2__autokey__nameb2, update),
																build(kKeyCanadianPhonesV2__autokey__namewords2, update),
																build(kKeyCanadianPhonesV2__autokey__phone2, update),
																build(kKeyCanadianPhonesV2__autokey__phoneb2, update),
																build(kKeyCanadianPhonesV2__autokey__stname, update),
																build(kKeyCanadianPhonesV2__autokey__stnameb2, update),
																build(kKeyCanadianPhonesV2__autokey__zip, update),
																build(kKeyCanadianPhonesV2__autokey__zipb2, update),
																build(kKeyCanadianPhonesV2__autokey__zipprlname, update)
															 )//,
											// PRTE.UpdateVersion('Corp2Keys',										//	Package name
																				 // pIndexVersion,												//	Package version
																				 // _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 // 'B',																	//	B = Boca, A = Alpharetta
																				 // 'N',																	//	N = Non-FCRA, F = FCRA
																				 // 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				// )
										 );

end;
