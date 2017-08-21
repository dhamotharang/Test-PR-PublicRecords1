import	_control, PRTE_CSV;

export  Proc_Build_Prolicv2_Keys(string pIndexVersion)	:= function


rKeyProlicv2__key__prolicv2__autokey__address	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__address;
end;

rKeyProlicv2__key__prolicv2__autokey__addressb2	:=
record
PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__addressb2;
end;

rKeyProlicv2__key__prolicv2__autokey__citystname	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__citystname;
end;

rKeyProlicv2__key__prolicv2__autokey__citystnameb2	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__citystnameb2;
end;

rKeyProlicv2__key__prolicv2__autokey__name	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__name;
end;

rKeyProlicv2__key__prolicv2__autokey__nameb2	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__nameb2;
end;

rKeyProlicv2__key__prolicv2__autokey__namewords2	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__namewords2;
end;


rKeyProlicv2__key__prolicv2__autokey__payload	:=
record
 PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__payload;

end;

rKeyProlicv2__key__prolicv2__autokey__phoneb2	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__phoneb2;
end;

rKeyProlicv2__key__prolicv2__autokey__ssn2	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__ssn2;
end;

rKeyProlicv2__key__prolicv2__autokey__stname	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__stname;
end;

rKeyProlicv2__key__prolicv2__autokey__stnameb2	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__stnameb2;
end;

rKeyProlicv2__key__prolicv2__autokey__zip	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__zip;
end;

rKeyProlicv2__key__prolicv2__autokey__zipb2	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__autokey__zipb2;
end;

rKeyProlicv2__key__prolicv2__bdid	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__bdid;
end;

rKeyProlicv2__key__prolicv2__cbrs_addr	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__cbrs_addr;
end;

rKeyProlicv2__key__prolicv2__did	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__did;
end;

rKeyProlicv2__key__prolicv2__licensenum	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__licensenum;
end;

rKeyProlicv2__key__prolicv2__prolic_id	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__prolic_id;
end;
rKeyProlicv2__key__prolicv2__Linkids	:=
record
	PRTE_CSV.Prolicv2.rthor_data400__key__prolicv2__Linkids;
end;

dKeyProlicv2__key__prolicv2__autokey__address 			:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__address 	,rKeyProlicv2__key__prolicv2__autokey__address	);
dKeyProlicv2__key__prolicv2__autokey__addressb2 		:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__addressb2 	,rKeyProlicv2__key__prolicv2__autokey__addressb2	);
dKeyProlicv2__key__prolicv2__autokey__citystname		:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__citystname	,rKeyProlicv2__key__prolicv2__autokey__citystname	);
dKeyProlicv2__key__prolicv2__autokey__citystnameb2 	:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__citystnameb2 	,rKeyProlicv2__key__prolicv2__autokey__citystnameb2	);
dKeyProlicv2__key__prolicv2__autokey__name 					:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__name 	,rKeyProlicv2__key__prolicv2__autokey__name	);
dKeyProlicv2__key__prolicv2__autokey__nameb2 				:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__nameb2 	,rKeyProlicv2__key__prolicv2__autokey__nameb2	);
dKeyProlicv2__key__prolicv2__autokey__namewords2 		:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__namewords2 	,rKeyProlicv2__key__prolicv2__autokey__namewords2	);
dKeyProlicv2__key__prolicv2__autokey__payload 			:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__payload 	,rKeyProlicv2__key__prolicv2__autokey__payload	);
dKeyProlicv2__key__prolicv2__autokey__phoneb2 			:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__phoneb2 	,rKeyProlicv2__key__prolicv2__autokey__phoneb2	);
dKeyProlicv2__key__prolicv2__autokey__ssn2 					:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__ssn2 	,rKeyProlicv2__key__prolicv2__autokey__ssn2	);
dKeyProlicv2__key__prolicv2__autokey__stname 				:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__stname 	,rKeyProlicv2__key__prolicv2__autokey__stname	);
dKeyProlicv2__key__prolicv2__autokey__stnameb2 			:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__stnameb2 ,rKeyProlicv2__key__prolicv2__autokey__stnameb2	);
dKeyProlicv2__key__prolicv2__autokey__zip 					:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__zip 	,rKeyProlicv2__key__prolicv2__autokey__zip	);
dKeyProlicv2__key__prolicv2__autokey__zipb2 				:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__autokey__zipb2 	,rKeyProlicv2__key__prolicv2__autokey__zipb2	);
dKeyProlicv2__key__prolicv2__bdid 									:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__bdid 	,rKeyProlicv2__key__prolicv2__bdid	);
dKeyProlicv2__key__prolicv2__cbrs_addr 							:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__cbrs_addr ,rKeyProlicv2__key__prolicv2__cbrs_addr	);
dKeyProlicv2__key__prolicv2__did 										:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__did 	,rKeyProlicv2__key__prolicv2__did	);
dKeyProlicv2__key__prolicv2__licensenum							:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__licensenum 	,rKeyProlicv2__key__prolicv2__licensenum	);
dKeyProlicv2__key__prolicv2__prolic_id							:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__prolic_id 	,rKeyProlicv2__key__prolicv2__prolic_id	);
dKeyProlicv2__key__prolicv2__Linkids								:=project(PRTE_CSV.Prolicv2.dthor_data400__key__prolicv2__Linkids 	,rKeyProlicv2__key__prolicv2__Linkids	);


kKeyProlicv2__key__prolicv2__autokey__address 		:= index(dKeyProlicv2__key__prolicv2__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyProlicv2__key__prolicv2__autokey__address}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::address');
kKeyProlicv2__key__prolicv2__autokey__addressb2 	:= index(dKeyProlicv2__key__prolicv2__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyProlicv2__key__prolicv2__autokey__addressb2}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::addressb2');
kKeyProlicv2__key__prolicv2__autokey__citystname 	:= index(dKeyProlicv2__key__prolicv2__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyProlicv2__key__prolicv2__autokey__citystname}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::citystname');
kKeyProlicv2__key__prolicv2__autokey__citystnameb2:= index(dKeyProlicv2__key__prolicv2__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyProlicv2__key__prolicv2__autokey__citystnameb2}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::citystnameb2');
kKeyProlicv2__key__prolicv2__autokey__name 		  	:= index(dKeyProlicv2__key__prolicv2__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyProlicv2__key__prolicv2__autokey__name}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::name');
kKeyProlicv2__key__prolicv2__autokey__nameb2 			:= index(dKeyProlicv2__key__prolicv2__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyProlicv2__key__prolicv2__autokey__nameb2}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::nameb2');
kKeyProlicv2__key__prolicv2__autokey__namewords2	:= index(dKeyProlicv2__key__prolicv2__autokey__namewords2, {word,state,seq,bdid}, {dKeyProlicv2__key__prolicv2__autokey__namewords2}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::namewords2');
kKeyProlicv2__key__prolicv2__autokey__payload 		:= index(dKeyProlicv2__key__prolicv2__autokey__payload, {fakeid}, {dKeyProlicv2__key__prolicv2__autokey__payload}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::payload');
kKeyProlicv2__key__prolicv2__autokey__phoneb2 		:= index(dKeyProlicv2__key__prolicv2__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyProlicv2__key__prolicv2__autokey__phoneb2}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::phoneb2');
kKeyProlicv2__key__prolicv2__autokey__ssn2 		  	:= index(dKeyProlicv2__key__prolicv2__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyProlicv2__key__prolicv2__autokey__ssn2}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::ssn2');
kKeyProlicv2__key__prolicv2__autokey__stname 			:= index(dKeyProlicv2__key__prolicv2__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyProlicv2__key__prolicv2__autokey__stname}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::stname');
kKeyProlicv2__key__prolicv2__autokey__stnameb2 		:= index(dKeyProlicv2__key__prolicv2__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyProlicv2__key__prolicv2__autokey__stnameb2}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::stnameb2');
kKeyProlicv2__key__prolicv2__autokey__zip 				:= index(dKeyProlicv2__key__prolicv2__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyProlicv2__key__prolicv2__autokey__zip}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::zip');
kKeyProlicv2__key__prolicv2__autokey__zipb2 			:= index(dKeyProlicv2__key__prolicv2__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyProlicv2__key__prolicv2__autokey__zipb2}, '~prte::key::prolicv2::'+pIndexVersion+'::autokey::zipb2');
kKeyProlicv2__key__prolicv2__bdid 								:= index(dKeyProlicv2__key__prolicv2__bdid, {bd}, {dKeyProlicv2__key__prolicv2__bdid}, '~prte::key::prolicv2::'+pIndexVersion+'::bdid');
kKeyProlicv2__key__prolicv2__cbrs_addr 			   	 	:= index(dKeyProlicv2__key__prolicv2__cbrs_addr, {prim_name,prim_range,zip,sec_range}, {dKeyProlicv2__key__prolicv2__cbrs_addr}, '~prte::key::prolicv2::'+pIndexVersion+'::cbrs.addr');
kKeyProlicv2__key__prolicv2__did 									:= index(dKeyProlicv2__key__prolicv2__did, {did}, {dKeyProlicv2__key__prolicv2__did}, '~prte::key::prolicv2::'+pIndexVersion+'::did');
kKeyProlicv2__key__prolicv2__licensenum 					:= index(dKeyProlicv2__key__prolicv2__licensenum, {s_license_number,did,bdid}, {dKeyProlicv2__key__prolicv2__licensenum}, '~prte::key::prolicv2::'+pIndexVersion+'::licensenum');
kKeyProlicv2__key__prolicv2__prolic_id 			    	:= index(dKeyProlicv2__key__prolicv2__prolic_id, {prolic_seq_id}, {dKeyProlicv2__key__prolicv2__prolic_id}, '~prte::key::prolicv2::'+pIndexVersion+'::prolic_id');
kKeyProlicv2__key__prolicv2_LinkIDs 			    		:= index(dKeyProlicv2__key__prolicv2__Linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, {dKeyProlicv2__key__prolicv2__Linkids}, '~prte::key::prolicv2::'+pIndexVersion+'::linkids');
return	sequential(
														parallel(
																build(kKeyProlicv2__key__prolicv2__autokey__address,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__addressb2,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__citystname,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__citystnameb2,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__name,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__nameb2,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__namewords2,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__payload ,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__phoneb2,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__ssn2,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__stname,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__stnameb2,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__zip,  update),
																build(kKeyProlicv2__key__prolicv2__autokey__zipb2,  update),
																build(kKeyProlicv2__key__prolicv2__bdid,  update),
																build(kKeyProlicv2__key__prolicv2__cbrs_addr,  update),
																build(kKeyProlicv2__key__prolicv2__did,  update),
																build(kKeyProlicv2__key__prolicv2__licensenum,  update),
																build(kKeyProlicv2__key__prolicv2__prolic_id,  update),
																build(kKeyProlicv2__key__prolicv2_LinkIDs,  update)
																),

   											PRTE.UpdateVersion('ProfLicKeys ',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																)
								);
								 

end;

