 import	_control, PRTE_CSV;

export Proc_Build_Ingenix_Sanctions_Keys(string pIndexVersion)	:= function


rKeyIngenix_Sanctions__ingenix_sanctions__address__auto	:= record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__address__auto;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__address	:= record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__address;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__addressb2	:= record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__addressb2;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystname	:=record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__citystname;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystnameb2	:=record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__citystnameb2;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__name	:= record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__name;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__nameb2	:= record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__nameb2;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__namewords2	:= record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__namewords2;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__payload	:=record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__payload;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__stname	:=record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__stname;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__stnameb2	:=record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__stnameb2;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__zip	:=
record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__zip;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__autokey__zipb2	:=
record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__autokey__zipb2;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__bdid := record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__bdid;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__citystname__auto	:=record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__citystname__auto;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__did := record
 PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__did;
 end ;
 
rKeyIngenix_Sanctions__ingenix_sanctions__fdids	:=
record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__fdids;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__license	:=
record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__license_new;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__name__auto	:= record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__name__auto;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__sancid	:=RECORD
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__sancid;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__stname__auto	:=record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__stname__auto;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__taxid	:=
record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__taxid;
end; 

rKeyIngenix_Sanctions__ingenix_sanctions__taxid__name	:=
record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__taxid__name;
end;
 
rKeyIngenix_Sanctions__ingenix_sanctions__upin := record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__upin_new;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__zip__auto	:=
record
	PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__zip__auto;
end;

rKeyIngenix_Sanctions__ingenix_speciality__providerid	:=record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_speciality__providerid;
end;

rKeyIngenix_Sanctions__ingenix_sanctions__LinkIDs	:=
record
PRTE_CSV.Ingenix_Sanctions.rthor_data400__key__ingenix_sanctions__LinkIDs
end;

dKeyIngenix_Sanctions__ingenix_sanctions__address__auto 	 				:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__address__auto ,rKeyIngenix_Sanctions__ingenix_sanctions__address__auto);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__address 	 			:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__address ,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__address);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__addressb2 	 		:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__addressb2,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__addressb2);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystname			:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__citystname ,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystname);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystnameb2 	:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__citystnameb2,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystnameb2);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__name 	 				:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__name,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__name);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__nameb2 	 			:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__nameb2,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__nameb2);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__namewords2 	 	:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__namewords2,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__namewords2);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__payload  			:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__payload , rKeyIngenix_Sanctions__ingenix_sanctions__autokey__payload);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__stname 	 			:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__stname,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__stname);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__stnameb2 	 		:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__stnameb2,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__stnameb2);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__zip 		 				:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__zip ,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__zip);
dKeyIngenix_Sanctions__ingenix_sanctions__autokey__zipb2 		 			:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__autokey__zipb2 ,rKeyIngenix_Sanctions__ingenix_sanctions__autokey__zipb2);
dKeyIngenix_Sanctions__ingenix_sanctions__bdid 				 						:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__bdid  ,rKeyIngenix_Sanctions__ingenix_sanctions__bdid);
dKeyIngenix_Sanctions__ingenix_sanctions__citystname__auto				:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__citystname__auto ,rKeyIngenix_Sanctions__ingenix_sanctions__citystname__auto);
dKeyIngenix_Sanctions__ingenix_sanctions__did 										:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__did,rKeyIngenix_Sanctions__ingenix_sanctions__did);
dKeyIngenix_Sanctions__ingenix_sanctions__fdids 				 					:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__fdids ,rKeyIngenix_Sanctions__ingenix_sanctions__fdids);
prte.header_ds_macro(prkey__ingenix_sanctions__license,'self.sanc_id:=(unsigned)l.sanc_id;',,,,rKeyIngenix_Sanctions__ingenix_sanctions__license,PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__license,dKeyIngenix_Sanctions__ingenix_sanctions__license);
dKeyIngenix_Sanctions__ingenix_sanctions__name__auto 	 						:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__name__auto,rKeyIngenix_Sanctions__ingenix_sanctions__name__auto);
dKeyIngenix_Sanctions__ingenix_sanctions__LinkIDs 								:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__LinkIds,rKeyIngenix_Sanctions__ingenix_sanctions__LinkIds);

dKeyIngenix_Sanctions__ingenix_sanctions__sancid 			 						:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__sancid,rKeyIngenix_Sanctions__ingenix_sanctions__sancid);
dKeyIngenix_Sanctions__ingenix_sanctions__stname__auto 	 					:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__stname__auto,rKeyIngenix_Sanctions__ingenix_sanctions__stname__auto);
dKeyIngenix_Sanctions__ingenix_sanctions__taxid 				 					:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__taxid ,rKeyIngenix_Sanctions__ingenix_sanctions__taxid);
dKeyIngenix_Sanctions__ingenix_sanctions__taxid__name 						:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__taxid__name ,rKeyIngenix_Sanctions__ingenix_sanctions__taxid__name);
prte.header_ds_macro(prkey__ingenix_sanctions__upin ,'self.sanc_id:=(unsigned)l.sanc_id;',,,,rKeyIngenix_Sanctions__ingenix_sanctions__upin,PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__upin,dKeyIngenix_Sanctions__ingenix_sanctions__upin);
dKeyIngenix_Sanctions__ingenix_sanctions__zip__auto 		 					:= project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_sanctions__zip__auto ,rKeyIngenix_Sanctions__ingenix_sanctions__zip__auto);
dKeyIngenix_Sanctions__ingenix_speciality__providerid 					  := project(PRTE_CSV.Ingenix_Sanctions.dthor_data400__key__ingenix_speciality__providerid ,rKeyIngenix_Sanctions__ingenix_speciality__providerid);


kKeyIngenix_Sanctions__ingenix_sanctions__address__auto 					:= index(dKeyIngenix_Sanctions__ingenix_sanctions__address__auto, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__address__auto}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::address_auto');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__address 				:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__address}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::address');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__addressb2 			:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__addressb2}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::addressb2');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystname 		:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystname}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::citystname');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystnameb2 	:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystnameb2}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::citystnameb2');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__name 					:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__name}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::name');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__nameb2 				:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__nameb2, {cname_indic,cname_sec,bdid,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__nameb2}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::nameb2');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__namewords2 		:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__namewords2, {word,state,seq,bdid,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__namewords2}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::namewords2');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__payload 				:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__payload, {fakeid}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__payload}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::payload');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__stname 				:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__stname}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::stname');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__stnameb2 			:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__stnameb2, {st,cname_indic,cname_sec,bdid,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__stnameb2}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::stnameb2');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__zip 						:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__zip}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::zip');
kKeyIngenix_Sanctions__ingenix_sanctions__autokey__zipb2 					:= index(dKeyIngenix_Sanctions__ingenix_sanctions__autokey__zipb2, {zip,cname_indic,cname_sec,bdid,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__autokey__zipb2}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::autokey::zipb2');
kKeyIngenix_Sanctions__ingenix_sanctions__bdid 										:= index(dKeyIngenix_Sanctions__ingenix_sanctions__bdid, {bdid}, {dKeyIngenix_Sanctions__ingenix_sanctions__bdid}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::bdid');
kKeyIngenix_Sanctions__ingenix_sanctions__citystname__auto 				:= index(dKeyIngenix_Sanctions__ingenix_sanctions__citystname__auto, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__citystname__auto}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::citystname_auto');
kKeyIngenix_Sanctions__ingenix_sanctions__did 										:= index(dKeyIngenix_Sanctions__ingenix_sanctions__did, {l_did}, {dKeyIngenix_Sanctions__ingenix_sanctions__did}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::did');
kKeyIngenix_Sanctions__ingenix_sanctions__fdids 									:= index(dKeyIngenix_Sanctions__ingenix_sanctions__fdids, {fdid}, {dKeyIngenix_Sanctions__ingenix_sanctions__fdids}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::fdids');
kKeyIngenix_Sanctions__ingenix_sanctions__license 								:= index(dKeyIngenix_Sanctions__ingenix_sanctions__license, {sanc_sancst,sanc_licnbr}, {dKeyIngenix_Sanctions__ingenix_sanctions__license}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::license');
kKeyIngenix_Sanctions__ingenix_sanctions__name__auto 							:= index(dKeyIngenix_Sanctions__ingenix_sanctions__name__auto, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__name__auto}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::name_auto');
kKeyIngenix_Sanctions__ingenix_sanctions__sancid 									:= index(dKeyIngenix_Sanctions__ingenix_sanctions__sancid, {l_sancid}, {dKeyIngenix_Sanctions__ingenix_sanctions__sancid}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::sancid');
kKeyIngenix_Sanctions__ingenix_sanctions__stname__auto 						:= index(dKeyIngenix_Sanctions__ingenix_sanctions__stname__auto, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__stname__auto}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::stname_auto');
kKeyIngenix_Sanctions__ingenix_sanctions__taxid 									:= index(dKeyIngenix_Sanctions__ingenix_sanctions__taxid, {l_taxid}, {dKeyIngenix_Sanctions__ingenix_sanctions__taxid}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::taxid');
kKeyIngenix_Sanctions__ingenix_sanctions__taxid__name 						:= index(dKeyIngenix_Sanctions__ingenix_sanctions__taxid__name, {l_taxid,l_fname}, {dKeyIngenix_Sanctions__ingenix_sanctions__taxid__name}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::taxid_name');
kKeyIngenix_Sanctions__ingenix_sanctions__upin 										:= index(dKeyIngenix_Sanctions__ingenix_sanctions__upin, {l_upin}, {dKeyIngenix_Sanctions__ingenix_sanctions__upin}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::upin');
kKeyIngenix_Sanctions__ingenix_sanctions__zip__auto 							:= index(dKeyIngenix_Sanctions__ingenix_sanctions__zip__auto, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Sanctions__ingenix_sanctions__zip__auto}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::zip_auto');
kKeyIngenix_Sanctions__ingenix_speciality__providerid 						:= index(dKeyIngenix_Sanctions__ingenix_speciality__providerid, {l_providerid}, {dKeyIngenix_Sanctions__ingenix_speciality__providerid}, '~prte::key::ingenix_speciality::' + pIndexVersion + '::providerid');
kKeyIngenix_Sanctions__ingenix_sanctions__LinkIDs 								:= index(dKeyIngenix_Sanctions__ingenix_sanctions__LinkIDs, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyIngenix_Sanctions__ingenix_sanctions__LinkIDs}, '~prte::key::ingenix_sanctions::' + pIndexVersion + '::LinkIDs');
			
						return	sequential(
														parallel(
																build(kKeyIngenix_Sanctions__ingenix_sanctions__address__auto					,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__address			,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__addressb2		,update),																
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystname		,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__citystnameb2	,update),													
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__name					,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__nameb2				,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__namewords2		,update),																
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__payload			,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__stname				,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__stnameb2			,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__zip					,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__autokey__zipb2				,update),																
																build(kKeyIngenix_Sanctions__ingenix_sanctions__bdid									,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__citystname__auto			,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__did										,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__fdids									,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__license								,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__name__auto						,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__sancid								,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__stname__auto					,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__taxid									,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__taxid__name						,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__upin									,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__zip__auto							,update),
																build(kKeyIngenix_Sanctions__ingenix_speciality__providerid						,update),
																build(kKeyIngenix_Sanctions__ingenix_sanctions__LinkIDs							  ,update)
																),

   											PRTE.UpdateVersion('IngenixKeys',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																)
								);
								 

end;
