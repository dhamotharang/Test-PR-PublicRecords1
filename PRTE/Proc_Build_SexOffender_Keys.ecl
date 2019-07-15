import	_control, PRTE_CSV, hygenics_search;

export	Proc_Build_SexOffender_Keys(string pIndexVersion)	:=
function

	rKeySexOffender__autokey__address	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__autokey__address;
	end;

	rKeySexOffender__autokey__citystname	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__autokey__citystname;
	end;

  rKeySexOffender__autokey__latlong	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__autokey__latlong;
	end;	
	
	rKeySexOffender__autokey__name	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__autokey__name;
	end;

	rKeySexOffender__autokey__payload	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__autokey__payload;
	end;

	rKeySexOffender__autokey__ssn2	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__autokey__ssn2;
	end;

	rKeySexOffender__autokey__stname	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__autokey__stname;
	end;

	rKeySexOffender__autokey__zip	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__autokey__zip;
	end;

	rKeySexOffender__didpublic	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__didpublic;
	end;

	rKeySexOffender__enhpublic	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__enhpublic;
	end;

	rKeySexOffender__enhpublicaddress	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__enhpublicaddress;
	end;
		
	rKeySexOffender__enhpubliccitystname	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__enhpubliccitystname;
	end;

	rKeySexOffender__enhpublicname	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__enhpublicname;
	end;

	rKeySexOffender__enhpublicphone	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__enhpublicphone;
	end;

	rKeySexOffender__enhpublicssn	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__enhpublicssn;
	end;

	rKeySexOffender__enhpublicstname	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__enhpublicstname;
	end;

	rKeySexOffender__enhpubliczip	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__enhpubliczip;
	end;

	rKeySexOffender__fdid_public	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__fdid_public;
	end;

	rKeySexOffender__offenses_public	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__offenses_public;
	end;

	rKeySexOffender__publicaddress	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__publicaddress;
	end;

	rKeySexOffender__publiccitystname	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__publiccitystname;
	end;

	rKeySexOffender__publicname	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__publicname;
	end;

	rKeySexOffender__publicphone	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__publicphone;
	end;

	rKeySexOffender__publicssn	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__publicssn;
	end;
	
	rKeySexOffender__publicstname	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__publicstname;
	end;
	
	rKeySexOffender__publiczip	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__publiczip;
	end;
	
	rKeySexOffender__spkpublic	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__spkpublic;
	end;
	
	rKeySexOffender__zip_type_public	:=
	record
		PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__zip_type_public;
	end;
	
	dKeySexOffender__autokey__address			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__autokey__address, rKeySexOffender__autokey__address);
	dKeySexOffender__autokey__citystname	:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__autokey__citystname, rKeySexOffender__autokey__citystname);
	dKeySexOffender__autokey__latlong			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__autokey__latlong, rKeySexOffender__autokey__latlong);
	dKeySexOffender__autokey__name				:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__autokey__name, rKeySexOffender__autokey__name);
	dKeySexOffender__autokey__payload			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__autokey__payload, rKeySexOffender__autokey__payload);
	dKeySexOffender__autokey__ssn2				:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__autokey__ssn2, rKeySexOffender__autokey__ssn2);
	dKeySexOffender__autokey__stname			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__autokey__stname, rKeySexOffender__autokey__stname);
	dKeySexOffender__autokey__zip					:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__autokey__zip, rKeySexOffender__autokey__zip);
	dKeySexOffender__didpublic						:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__didpublic, rKeySexOffender__didpublic);
	dKeySexOffender__enhpublic						:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__enhpublic, rKeySexOffender__enhpublic);
	dKeySexOffender__enhpublicaddress			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__enhpublicaddress, rKeySexOffender__enhpublicaddress);
	dKeySexOffender__enhpubliccitystname	:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__enhpubliccitystname, rKeySexOffender__enhpubliccitystname);
	dKeySexOffender__enhpublicname				:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__enhpublicname, rKeySexOffender__enhpublicname);
	dKeySexOffender__enhpublicphone				:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__enhpublicphone, rKeySexOffender__enhpublicphone);
	dKeySexOffender__enhpublicssn					:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__enhpublicssn, rKeySexOffender__enhpublicssn);
	dKeySexOffender__enhpublicstname			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__enhpublicstname, rKeySexOffender__enhpublicstname);
	dKeySexOffender__enhpubliczip					:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__enhpubliczip, rKeySexOffender__enhpubliczip);
	dKeySexOffender__fdid_public					:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__fdid_public, rKeySexOffender__fdid_public);
	dKeySexOffender__offenses_public			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__offenses_public, rKeySexOffender__offenses_public);
	dKeySexOffender__publicaddress				:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__publicaddress, rKeySexOffender__publicaddress);
	dKeySexOffender__publiccitystname			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__publiccitystname, rKeySexOffender__publiccitystname);
	dKeySexOffender__publicname						:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__publicname, rKeySexOffender__publicname);
	dKeySexOffender__publicphone					:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__publicphone, rKeySexOffender__publicphone);
	dKeySexOffender__publicssn						:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__publicssn, rKeySexOffender__publicssn);
	dKeySexOffender__publicstname					:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__publicstname, rKeySexOffender__publicstname);
	dKeySexOffender__publiczip						:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__publiczip, rKeySexOffender__publiczip);
	dKeySexOffender__spkpublic						:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__spkpublic, rKeySexOffender__spkpublic);
	dKeySexOffender__zip_type_public			:= 	project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__zip_type_public, rKeySexOffender__zip_type_public);

	dKeySexOffender__didpublic_fcra				:= project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__didpublic(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key), rKeySexOffender__didpublic);
	dKeySexOffender__offenses_public_fcra	:= project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__offenses_public(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key), rKeySexOffender__offenses_public);
	dKeySexOffender__spkpublic_fcra				:= project(PRTE_CSV.SexOffender.dthor_data400__key__sexoffender__spkpublic(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key), rKeySexOffender__spkpublic);

	kKeySexOffender__autokey__address			:=	index(dKeySexOffender__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeySexOffender__autokey__address}, '~prte::key::SexOffender::' + pIndexVersion + '::autokey::address');
	kKeySexOffender__autokey__citystname	:=	index(dKeySexOffender__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__autokey__citystname}, '~prte::key::SexOffender::' + pIndexVersion + '::autokey::citystname');
  kKeySexOffender__autokey__latlong			:=	index(dKeySexOffender__autokey__latlong, {lat,long,dph_lname,lname,pfname,fname,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {dKeySexOffender__autokey__latlong}, '~prte::key::SexOffender::' + pIndexVersion + '::autokey::latlong');	
	kKeySexOffender__autokey__name				:=	index(dKeySexOffender__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__autokey__name}, '~prte::key::SexOffender::' + pIndexVersion + '::autokey::name');
	kKeySexOffender__autokey__payload			:=	index(dKeySexOffender__autokey__payload, {fakeid}, {dKeySexOffender__autokey__payload}, '~prte::key::SexOffender::' + pIndexVersion + '::autokey::payload');
	kKeySexOffender__autokey__ssn2				:=	index(dKeySexOffender__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeySexOffender__autokey__ssn2}, '~prte::key::SexOffender::' + pIndexVersion + '::autokey::ssn2');
	kKeySexOffender__autokey__stname			:=	index(dKeySexOffender__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__autokey__stname}, '~prte::key::SexOffender::' + pIndexVersion + '::autokey::stname');
	kKeySexOffender__autokey__zip					:=	index(dKeySexOffender__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__autokey__zip}, '~prte::key::SexOffender::' + pIndexVersion + '::autokey::zip');
	kKeySexOffender__didpublic						:=	index(dKeySexOffender__didpublic, {did}, {dKeySexOffender__didpublic}, '~prte::key::SexOffender::' + pIndexVersion + '::didpublic');
	kKeySexOffender__enhpublic						:=	index(dKeySexOffender__enhpublic, {sspk}, {dKeySexOffender__enhpublic}, '~prte::key::SexOffender::' + pIndexVersion + '::enhpublic');
	kKeySexOffender__enhpublicaddress			:=	index(dKeySexOffender__enhpublicaddress, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeySexOffender__enhpublicaddress}, '~prte::key::SexOffender::' + pIndexVersion + '::enhpublicaddress');
	kKeySexOffender__enhpubliccitystname	:=	index(dKeySexOffender__enhpubliccitystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__enhpubliccitystname}, '~prte::key::SexOffender::' + pIndexVersion + '::enhpubliccitystname');
	kKeySexOffender__enhpublicname				:=	index(dKeySexOffender__enhpublicname, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__enhpublicname}, '~prte::key::SexOffender::' + pIndexVersion + '::enhpublicname');
	kKeySexOffender__enhpublicphone				:=	index(dKeySexOffender__enhpublicphone, {p7,p3,dph_lname,pfname,st}, {dKeySexOffender__enhpublicphone}, '~prte::key::SexOffender::' + pIndexVersion + '::enhpublicphone');
	kKeySexOffender__enhpublicssn					:=	index(dKeySexOffender__enhpublicssn, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname}, {dKeySexOffender__enhpublicssn}, '~prte::key::SexOffender::' + pIndexVersion + '::enhpublicssn');
	kKeySexOffender__enhpublicstname			:=	index(dKeySexOffender__enhpublicstname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__enhpublicstname}, '~prte::key::SexOffender::' + pIndexVersion + '::enhpublicstname');
	kKeySexOffender__enhpubliczip					:=	index(dKeySexOffender__enhpubliczip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__enhpubliczip}, '~prte::key::SexOffender::' + pIndexVersion + '::enhpubliczip');
	kKeySexOffender__fdid_public					:=	index(dKeySexOffender__fdid_public, {did}, {dKeySexOffender__fdid_public}, '~prte::key::SexOffender::' + pIndexVersion + '::fdid_public');
	kKeySexOffender__offenses_public			:=	index(dKeySexOffender__offenses_public, {sspk}, {dKeySexOffender__offenses_public}, '~prte::key::SexOffender::' + pIndexVersion + '::offenses_public');
	kKeySexOffender__publicaddress				:=	index(dKeySexOffender__publicaddress, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeySexOffender__publicaddress}, '~prte::key::SexOffender::' + pIndexVersion + '::publicaddress');
	kKeySexOffender__publiccitystname			:=	index(dKeySexOffender__publiccitystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__publiccitystname}, '~prte::key::SexOffender::' + pIndexVersion + '::publiccitystname');
	kKeySexOffender__publicname						:=	index(dKeySexOffender__publicname, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__publicname}, '~prte::key::SexOffender::' + pIndexVersion + '::publicname');
	kKeySexOffender__publicphone					:=	index(dKeySexOffender__publicphone, {p7,p3,dph_lname,pfname,st}, {dKeySexOffender__publicphone}, '~prte::key::SexOffender::' + pIndexVersion + '::publicphone');
	kKeySexOffender__publicssn						:=	index(dKeySexOffender__publicssn, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname}, {dKeySexOffender__publicssn}, '~prte::key::SexOffender::' + pIndexVersion + '::publicssn');
	kKeySexOffender__publicstname					:=	index(dKeySexOffender__publicstname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__publicstname}, '~prte::key::SexOffender::' + pIndexVersion + '::publicstname');
	kKeySexOffender__publiczip						:=	index(dKeySexOffender__publiczip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySexOffender__publiczip}, '~prte::key::SexOffender::' + pIndexVersion + '::publiczip');
	kKeySexOffender__spkpublic						:=	index(dKeySexOffender__spkpublic, {sspk}, {dKeySexOffender__spkpublic}, '~prte::key::SexOffender::' + pIndexVersion + '::spkpublic');
	kKeySexOffender__zip_type_public			:=	index(dKeySexOffender__zip_type_public, {alt_zip,alt_type,yob,dob}, {dKeySexOffender__zip_type_public}, '~prte::key::SexOffender::' + pIndexVersion + '::zip_type_public');

	kKeySexOffender__didpublic_fcra				:=	index(dKeySexOffender__didpublic_fcra, {did}, {dKeySexOffender__didpublic_fcra}, '~prte::key::SexOffender::fcra::' + pIndexVersion + '::didpublic');
	kKeySexOffender__offenses_public_fcra	:=	index(dKeySexOffender__offenses_public_fcra, {sspk}, {dKeySexOffender__offenses_public_fcra}, '~prte::key::SexOffender::fcra::' + pIndexVersion + '::offenses_public');
	kKeySexOffender__spkpublic_fcra				:=	index(dKeySexOffender__spkpublic_fcra, {sspk}, {dKeySexOffender__spkpublic_fcra}, '~prte::key::SexOffender::fcra::' + pIndexVersion + '::spkpublic');	
	
	return	sequential(
											parallel(
																build(kKeySexOffender__autokey__address			, update),
																build(kKeySexOffender__autokey__citystname	, update),
																build(kKeySexOffender__autokey__latlong			, update),
																build(kKeySexOffender__autokey__name				, update),
																build(kKeySexOffender__autokey__payload			, update),
																build(kKeySexOffender__autokey__ssn2				, update),
																build(kKeySexOffender__autokey__stname			, update),
																build(kKeySexOffender__autokey__zip					, update),
																build(kKeySexOffender__didpublic						, update),
																build(kKeySexOffender__enhpublic						, update),
																build(kKeySexOffender__enhpublicaddress			, update),
																build(kKeySexOffender__enhpubliccitystname	, update),
																build(kKeySexOffender__enhpublicname				, update),
																build(kKeySexOffender__enhpublicphone				, update),
																build(kKeySexOffender__enhpublicssn					, update),
																build(kKeySexOffender__enhpublicstname			, update),
																build(kKeySexOffender__enhpubliczip					, update),
																build(kKeySexOffender__fdid_public					, update),
																build(kKeySexOffender__offenses_public			, update),
																build(kKeySexOffender__publicaddress				, update),
																build(kKeySexOffender__publiccitystname			, update),
																build(kKeySexOffender__publicname						, update),
																build(kKeySexOffender__publicphone					, update),
																build(kKeySexOffender__publicssn						, update),
																build(kKeySexOffender__publicstname					, update),
																build(kKeySexOffender__publiczip						, update),
																build(kKeySexOffender__spkpublic						, update),
																build(kKeySexOffender__zip_type_public			, update),
																build(kKeySexOffender__didpublic_fcra				, update),
																build(kKeySexOffender__offenses_public_fcra	, update),
																build(kKeySexOffender__spkpublic_fcra				, update)
															 ),
											
											PRTE.UpdateVersion('SexOffenderKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				),
											
											PRTE.UpdateVersion('FCRA_SexOffenderKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
											);

end :DEPRECATED('Use PRTE2_SEXOFEENDER.PROC_BUILD_KEYS');
