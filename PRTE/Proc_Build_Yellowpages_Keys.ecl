import	_control, PRTE_CSV;

export	Proc_Build_Yellowpages_Keys(string pIndexVersion)	:=
function
  rKeyYellowpages__autokey__address				:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__address;
	end;	
	dKeyYellowpages__autokey__address				:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__address, rKeyYellowpages__autokey__address);
  kKeyYellowpages__autokey__address				:=	index(dKeyYellowpages__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyYellowpages__autokey__address}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::address');

  rKeyYellowpages__autokey__addressb2			:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__addressb2;
	end;
	dKeyYellowpages__autokey__addressb2			:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__addressb2, rKeyYellowpages__autokey__addressb2);
	kKeyYellowpages__autokey__addressb2			:=	index(dKeyYellowpages__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyYellowpages__autokey__addressb2}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::addressb2');

  rKeyYellowpages__autokey__citystname			:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__citystname;
	end;
	dKeyYellowpages__autokey__citystname			:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__citystname, rKeyYellowpages__autokey__citystname);
	kKeyYellowpages__autokey__citystname			:=	index(dKeyYellowpages__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyYellowpages__autokey__citystname}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::citystname');

  rKeyYellowpages__autokey__citystnameb2		:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__citystnameb2;
	end;
	dKeyYellowpages__autokey__citystnameb2		:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__citystnameb2, rKeyYellowpages__autokey__citystnameb2);
	kKeyYellowpages__autokey__citystnameb2		:=	index(dKeyYellowpages__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid,lookups}, {dKeyYellowpages__autokey__citystnameb2}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::citystnameb2');

	rKeyYellowpages__autokey__name						:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__name;
	end;
	dKeyYellowpages__autokey__name						:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__name, rKeyYellowpages__autokey__name);
  kKeyYellowpages__autokey__name						:=	index(dKeyYellowpages__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyYellowpages__autokey__name}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::name');

	rKeyYellowpages__autokey__nameb2					:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__nameb2;
	end;
	dKeyYellowpages__autokey__nameb2					:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__nameb2, rKeyYellowpages__autokey__nameb2);
	kKeyYellowpages__autokey__nameb2					:=	index(dKeyYellowpages__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyYellowpages__autokey__nameb2}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::nameb2');

	rKeyYellowpages__autokey__namewords2			:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__namewords2;
	end;
	dKeyYellowpages__autokey__namewords2			:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__namewords2, rKeyYellowpages__autokey__namewords2);
	kKeyYellowpages__autokey__namewords2			:=	index(dKeyYellowpages__autokey__namewords2, {word,state,seq,bdid}, {dKeyYellowpages__autokey__namewords2}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::namewords2');
	
	rKeyYellowpages__autokey__payload				:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__payload;
	end;
	dKeyYellowpages__autokey__payload				:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__payload, rKeyYellowpages__autokey__payload);
  kKeyYellowpages__autokey__payload				:=	index(dKeyYellowpages__autokey__payload, {fakeid}, {dKeyYellowpages__autokey__payload}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::payload');

	rKeyYellowpages__autokey__phone2					:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__phone2;
	end;
	dKeyYellowpages__autokey__phone2					:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__phone2, rKeyYellowpages__autokey__phone2);
	kKeyYellowpages__autokey__phone2					:=	index(dKeyYellowpages__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyYellowpages__autokey__phone2}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::phone2');

	rKeyYellowpages__autokey__phoneb2				:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__phoneb2;
	end;
	dKeyYellowpages__autokey__phoneb2				:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__phoneb2, rKeyYellowpages__autokey__phoneb2);
	kKeyYellowpages__autokey__phoneb2				:=	index(dKeyYellowpages__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyYellowpages__autokey__phoneb2}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::phoneb2');

	rKeyYellowpages__autokey__stname					:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__stname;
	end;
	dKeyYellowpages__autokey__stname					:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__stname, rKeyYellowpages__autokey__stname);
	kKeyYellowpages__autokey__stname					:=	index(dKeyYellowpages__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyYellowpages__autokey__stname}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::stname');

	rKeyYellowpages__autokey__stnameb2				:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__stnameb2;
	end;
	dKeyYellowpages__autokey__stnameb2				:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__stnameb2, rKeyYellowpages__autokey__stnameb2);
	kKeyYellowpages__autokey__stnameb2				:=	index(dKeyYellowpages__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyYellowpages__autokey__stnameb2}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::stnameb2');

	rKeyYellowpages__autokey__zip						:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__zip;
	end;
	dKeyYellowpages__autokey__zip						:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__zip, rKeyYellowpages__autokey__zip);
	kKeyYellowpages__autokey__zip						:=	index(dKeyYellowpages__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyYellowpages__autokey__zip}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::zip');

	rKeyYellowpages__autokey__zipb2					:=
	record
		PRTE_CSV.YellowPages.rthor_data400__key__yellowpages__autokey__zipb2;
	end;
	dKeyYellowpages__autokey__zipb2					:= 	project(PRTE_CSV.YellowPages.dthor_data400__key__yellowpages__autokey__zipb2, rKeyYellowpages__autokey__zipb2);
	kKeyYellowpages__autokey__zipb2					:=	index(dKeyYellowpages__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyYellowpages__autokey__zipb2}, '~prte::key::yellowpages::' + pIndexVersion + '::autokey::zipb2');

	rKeyYellowpages__bdid	:=
	record
		PRTE_CSV.Yellowpages.rthor_data400__key__yellowpages__bdid;
	end;
	dKeyYellowpages__bdid			:= 	project(PRTE_CSV.Yellowpages.dthor_data400__key__yellowpages__bdid, rKeyYellowpages__bdid);	
	kKeyYellowpages__bdid			:=	index(dKeyYellowpages__bdid, {bdid}, {dKeyYellowpages__bdid}, '~prte::key::yellowpages::' + pIndexVersion + '::bdid');

	rKeyYellowpages__linkids			:=
	record
		PRTE_CSV.Yellowpages.rthor_data400__key__Yellowpages__linkids;
	end;
	dKeyYellowpages__linkids			:= 	project(PRTE_CSV.Yellowpages.dthor_data400__key__Yellowpages__linkids, rKeyYellowpages__linkids);
	kKeyYellowpages__linkids			:=	index(dKeyYellowpages__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, {dKeyYellowpages__linkids}, '~prte::key::Yellowpages::' + pIndexVersion + '::linkids');

	rKeyYellowpages__phone	:=
	record
		PRTE_CSV.Yellowpages.rthor_data400__key__yellowpages__phone;
	end;
	dKeyYellowpages__phone		:= 	project(PRTE_CSV.Yellowpages.dthor_data400__key__yellowpages__phone, rKeyYellowpages__phone);
	kKeyYellowpages__phone		:=	index(dKeyYellowpages__phone, {phone10}, {business_name, prim_range, prim_name, sec_range, zip, geo_lat, geo_long}, '~prte::key::yellowpages::' + pIndexVersion + '::phone');
	
	return	sequential(
											parallel( /* autokeys are not part of the package file
																build(kKeyYellowpages__autokey__address,  		update),
																build(kKeyYellowpages__autokey__addressb2, 		update),
																build(kKeyYellowpages__autokey__citystname, 	update),
																build(kKeyYellowpages__autokey__citystnameb2, update),
																build(kKeyYellowpages__autokey__name, 				update),
																build(kKeyYellowpages__autokey__nameb2, 			update),
																build(kKeyYellowpages__autokey__namewords2, 	update),
																build(kKeyYellowpages__autokey__payload, 			update),
																build(kKeyYellowpages__autokey__phone2, 			update),
																build(kKeyYellowpages__autokey__phoneb2, 			update),
																build(kKeyYellowpages__autokey__stname, 			update),
																build(kKeyYellowpages__autokey__stnameb2, 		update),
																build(kKeyYellowpages__autokey__zip, 					update),
																build(kKeyYellowpages__autokey__zipb2, 				update), */
																build(kKeyYellowpages__bdid, 									update), 
																build(kKeyYellowpages__linkids, 							update),																
																build(kKeyYellowpages__phone, 								update)
															 ),
											PRTE.UpdateVersion('YellowpagesKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;	