import	_control, PRTE_CSV;

export  Proc_Build_Sanctn_Keys(string pIndexVersion)	:= function


rKeySanctn__key__sanctn__autokey__address	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__address;
end;

rKeySanctn__key__sanctn__autokey__addressb2	:=
record
PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__addressb2;
end;

rKeySanctn__key__sanctn__autokey__citystname	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__citystname;
end;

rKeySanctn__key__sanctn__autokey__citystnameb2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__citystnameb2;
end;

rKeySanctn__key__sanctn__autokey__name	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__name;
end;

rKeySanctn__key__sanctn__autokey__nameb2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__nameb2;
end;

rKeySanctn__key__sanctn__autokey__namewords2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__namewords2;
end;

rKeySanctn__key__sanctn__autokey__payload	:=
record
 PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__payload;

end;

rKeySanctn__key__sanctn__autokey__ssn2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__ssn2;
end;

rKeySanctn__key__sanctn__autokey__stname	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__stname;
end;

rKeySanctn__key__sanctn__autokey__stnameb2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__stnameb2;
end;

rKeySanctn__key__sanctn__autokey__zip	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__zip;
end;

rKeySanctn__key__sanctn__autokey__zipb2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__zipb2;
end;

rKeySanctn__key__sanctn__bdid	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__bdid;
end;

rKeySanctn__key__sanctn__did	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__did;
end;

rKeySanctn__key__sanctn__casenum	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__casenum;
end;

rKeySanctn__key__sanctn__incident	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__incident;
end;

rKeySanctn__key__sanctn__incident_midex	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__incident_midex;
end;

rKeySanctn__key__sanctn__license_midex	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__license_midex;
end;

rKeySanctn__key__sanctn__license_nbr	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__license_nbr;
end;

rKeySanctn__key__sanctn__midex_rpt_nbr	:=
record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__midex_rpt_nbr;
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__midex_rpt_nbr_new
end;

rKeySanctn__key__sanctn__nmls_id	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__nmls_id;
end;

rKeySanctn__key__sanctn__nmls_midex	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__nmls_midex;
end;

rKeySanctn__key__sanctn__party	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__party;
end;

rKeySanctn__key__sanctn__rebuttal	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__rebuttal;
end;

rKeySanctn__key__sanctn__ssn4	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__ssn4;
end;

rKeySanctn__key__sanctn__party_aka_dba	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__party_aka_dba;
end;

rKeySanctn__key__sanctn__linkids	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__linkids;
end;

dKeySanctn__key__sanctn__autokey__address 			:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__address 	,rKeySanctn__key__sanctn__autokey__address	);
dKeySanctn__key__sanctn__autokey__addressb2 		:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__addressb2 	,rKeySanctn__key__sanctn__autokey__addressb2	);
dKeySanctn__key__sanctn__autokey__citystname		:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__citystname	,rKeySanctn__key__sanctn__autokey__citystname	);
dKeySanctn__key__sanctn__autokey__citystnameb2 	:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__citystnameb2 	,rKeySanctn__key__sanctn__autokey__citystnameb2	);
dKeySanctn__key__sanctn__autokey__name 					:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__name 	,rKeySanctn__key__sanctn__autokey__name	);
dKeySanctn__key__sanctn__autokey__nameb2 				:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__nameb2 	,rKeySanctn__key__sanctn__autokey__nameb2	);
dKeySanctn__key__sanctn__autokey__namewords2 		:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__namewords2 	,rKeySanctn__key__sanctn__autokey__namewords2	);
dKeySanctn__key__sanctn__autokey__payload 			:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__payload 	,rKeySanctn__key__sanctn__autokey__payload );
dKeySanctn__key__sanctn__autokey__ssn2 					:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__ssn2 	,rKeySanctn__key__sanctn__autokey__ssn2	);
dKeySanctn__key__sanctn__autokey__stname 				:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__stname 	,rKeySanctn__key__sanctn__autokey__stname	);
dKeySanctn__key__sanctn__autokey__stnameb2 			:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__stnameb2 ,rKeySanctn__key__sanctn__autokey__stnameb2	);
dKeySanctn__key__sanctn__autokey__zip 					:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__zip 	,rKeySanctn__key__sanctn__autokey__zip	);
dKeySanctn__key__sanctn__autokey__zipb2 				:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__autokey__zipb2 	,rKeySanctn__key__sanctn__autokey__zipb2	);

dKeySanctn__key__sanctn__bdid 									:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__bdid 	,rKeySanctn__key__sanctn__bdid	);
dKeySanctn__key__sanctn__did 										:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__did	,rKeySanctn__key__sanctn__did	);
dKeySanctn__key__sanctn__casenum								:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__casenum	,rKeySanctn__key__sanctn__casenum	);
dKeySanctn__key__sanctn__incident								:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__incident 	,rKeySanctn__key__sanctn__incident	);
dKeySanctn__key__sanctn__incident_midex					:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__incident_midex 	,rKeySanctn__key__sanctn__incident_midex	);
dKeySanctn__key__sanctn__license_midex					:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__license_midex 	,rKeySanctn__key__sanctn__license_midex	);
dKeySanctn__key__sanctn__license_nbr						:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__license_nbr 	,rKeySanctn__key__sanctn__license_nbr	);
dKeySanctn__key__sanctn__midex_rpt_nbr					:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__midex_rpt_nbr 	,TRANSFORM(rKeySanctn__key__sanctn__midex_rpt_nbr, SELF:= left; self := [];));
dKeySanctn__key__sanctn__nmls_id								:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__nmls_id 	,TRANSFORM(rKeySanctn__key__sanctn__nmls_id,self.nmls_id := stringlib.stringfilterout(left.nmls_id,'#'); self := left;));
dKeySanctn__key__sanctn__nmls_midex							:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__nmls_midex 	,TRANSFORM(rKeySanctn__key__sanctn__nmls_midex,self.nmls_id := stringlib.stringfilterout(left.nmls_id,'#'); self := left;));
dKeySanctn__key__sanctn__party									:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__party 	,TRANSFORM(rKeySanctn__key__sanctn__party, self.cname := left.party_firm; self := left;));
dKeySanctn__key__sanctn__rebuttal								:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__rebuttal	,rKeySanctn__key__sanctn__rebuttal	);
dKeySanctn__key__sanctn__ssn4										:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__ssn4 	,rKeySanctn__key__sanctn__ssn4	);
dKeySanctn__key__sanctn__party_aka_dba					:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__party_aka_dba 	,rKeySanctn__key__sanctn__party_aka_dba	);
dKeySanctn__key__sanctn__linkids 								:=project(PRTE_CSV.Sanctn.dthor_data400__key__sanctn__linkids 	,rKeySanctn__key__sanctn__linkids	);


kKeySanctn__key__sanctn__autokey__address 		:= index(dKeySanctn__key__sanctn__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeySanctn__key__sanctn__autokey__address}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::address');
kKeySanctn__key__sanctn__autokey__addressb2 	:= index(dKeySanctn__key__sanctn__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__autokey__addressb2}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::addressb2');
kKeySanctn__key__sanctn__autokey__citystname 	:= index(dKeySanctn__key__sanctn__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySanctn__key__sanctn__autokey__citystname}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::citystname');
kKeySanctn__key__sanctn__autokey__citystnameb2:= index(dKeySanctn__key__sanctn__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__autokey__citystnameb2}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::citystnameb2');
kKeySanctn__key__sanctn__autokey__name 		  	:= index(dKeySanctn__key__sanctn__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySanctn__key__sanctn__autokey__name}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::name');
kKeySanctn__key__sanctn__autokey__nameb2 			:= index(dKeySanctn__key__sanctn__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__autokey__nameb2}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::nameb2');
kKeySanctn__key__sanctn__autokey__namewords2	:= index(dKeySanctn__key__sanctn__autokey__namewords2, {word,state,seq,bdid}, {dKeySanctn__key__sanctn__autokey__namewords2}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::namewords2');
kKeySanctn__key__sanctn__autokey__payload 		:= index(dKeySanctn__key__sanctn__autokey__payload, {fakeid}, {dKeySanctn__key__sanctn__autokey__payload}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::payload');
kKeySanctn__key__sanctn__autokey__ssn2 		  	:= index(dKeySanctn__key__sanctn__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeySanctn__key__sanctn__autokey__ssn2}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::ssn2');
kKeySanctn__key__sanctn__autokey__stname 			:= index(dKeySanctn__key__sanctn__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySanctn__key__sanctn__autokey__stname}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::stname');
kKeySanctn__key__sanctn__autokey__stnameb2 		:= index(dKeySanctn__key__sanctn__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__autokey__stnameb2}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::stnameb2');
kKeySanctn__key__sanctn__autokey__zip 				:= index(dKeySanctn__key__sanctn__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySanctn__key__sanctn__autokey__zip}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::zip');
kKeySanctn__key__sanctn__autokey__zipb2 			:= index(dKeySanctn__key__sanctn__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__autokey__zipb2}, '~prte::key::Sanctn::'+pIndexVersion+'::autokey::zipb2');

kKeySanctn__key__sanctn__bdid 								:= index(dKeySanctn__key__sanctn__bdid(bdid != 0), {bdid}, {dKeySanctn__key__sanctn__bdid}, '~prte::key::sanctn::'+pIndexVersion+'::bdid');
kKeySanctn__key__sanctn__did 									:= index(dKeySanctn__key__sanctn__did(did != 0), {did}, {dKeySanctn__key__sanctn__did}, '~prte::key::sanctn::'+pIndexVersion+'::did');
kKeySanctn__key__sanctn__casenum 							:= index(dKeySanctn__key__sanctn__casenum, {CASE_NUMBER}, {dKeySanctn__key__sanctn__casenum}, '~prte::key::sanctn::'+pIndexVersion+'::casenum');
kKeySanctn__key__sanctn__incident 						:= index(dKeySanctn__key__sanctn__incident, {BATCH_NUMBER,INCIDENT_NUMBER}, {dKeySanctn__key__sanctn__incident}, '~prte::key::sanctn::'+pIndexVersion+'::incident');
kKeySanctn__key__sanctn__incident_midex 			:= index(dKeySanctn__key__sanctn__incident_midex, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {dKeySanctn__key__sanctn__incident_midex}, '~prte::key::sanctn::'+pIndexVersion+'::incident_midex');
kKeySanctn__key__sanctn__license_midex 				:= index(dKeySanctn__key__sanctn__license_midex, {midex_rpt_nbr}, {dKeySanctn__key__sanctn__license_midex}, '~prte::key::sanctn::'+pIndexVersion+'::license_midex');
kKeySanctn__key__sanctn__license_nbr 					:= index(dKeySanctn__key__sanctn__license_nbr, {CLN_LICENSE_NUMBER,LICENSE_STATE}, {dKeySanctn__key__sanctn__license_nbr}, '~prte::key::sanctn::'+pIndexVersion+'::license_nbr');
kKeySanctn__key__sanctn__midex_rpt_nbr 			  := index(dKeySanctn__key__sanctn__midex_rpt_nbr, {midex_rpt_nbr}, {dKeySanctn__key__sanctn__midex_rpt_nbr}, '~prte::key::sanctn::'+pIndexVersion+'::midex_rpt_nbr');
kKeySanctn__key__sanctn__nmls_id			 			  := index(dKeySanctn__key__sanctn__nmls_id(nmls_id != ''), {nmls_id}, {dKeySanctn__key__sanctn__nmls_id}, '~prte::key::sanctn::'+pIndexVersion+'::nmls_id');
kKeySanctn__key__sanctn__nmls_midex		 			  := index(dKeySanctn__key__sanctn__nmls_midex, {midex_rpt_nbr}, {dKeySanctn__key__sanctn__nmls_midex}, '~prte::key::sanctn::'+pIndexVersion+'::nmls_midex');
kKeySanctn__key__sanctn__party 								:= index(dKeySanctn__key__sanctn__party, {BATCH_NUMBER,INCIDENT_NUMBER}, {dKeySanctn__key__sanctn__party}, '~prte::key::sanctn::'+pIndexVersion+'::party');
kKeySanctn__key__sanctn__rebuttal 			    	:= index(dKeySanctn__key__sanctn__rebuttal, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {dKeySanctn__key__sanctn__rebuttal}, '~prte::key::sanctn::'+pIndexVersion+'::rebuttal');
kKeySanctn__key__sanctn__ssn4 			   				:= index(dKeySanctn__key__sanctn__ssn4(ssn4 != ''), {SSN4}, {dKeySanctn__key__sanctn__ssn4}, '~prte::key::sanctn::'+pIndexVersion+'::ssn4');
kKeySanctn__key__sanctn__party_aka_dba 				:= index(dKeySanctn__key__sanctn__party_aka_dba, {BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}, {dKeySanctn__key__sanctn__party_aka_dba}, '~prte::key::sanctn::'+pIndexVersion+'::party_aka_dba');
kKeySanctn__key__sanctn__linkids							:= index(dKeySanctn__key__sanctn__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeySanctn__key__sanctn__linkids}, '~prte::key::sanctn::'+pIndexVersion+'::linkids');


return	sequential(
														parallel(
																build(kKeySanctn__key__sanctn__autokey__address,  update),
																build(kKeySanctn__key__sanctn__autokey__addressb2,  update),
																build(kKeySanctn__key__sanctn__autokey__citystname,  update),
																build(kKeySanctn__key__sanctn__autokey__citystnameb2,  update),
																build(kKeySanctn__key__sanctn__autokey__name,  update),
																build(kKeySanctn__key__sanctn__autokey__nameb2,  update),
																build(kKeySanctn__key__sanctn__autokey__namewords2,  update),
																build(kKeySanctn__key__sanctn__autokey__payload ,  update),
																build(kKeySanctn__key__sanctn__autokey__ssn2,  update),
																build(kKeySanctn__key__sanctn__autokey__stname,  update),
																build(kKeySanctn__key__sanctn__autokey__stnameb2,  update),
																build(kKeySanctn__key__sanctn__autokey__zip,  update),
																build(kKeySanctn__key__sanctn__autokey__zipb2,  update),
																build(kKeySanctn__key__sanctn__bdid,  update),
																build(kKeySanctn__key__sanctn__did,  update),
																build(kKeySanctn__key__sanctn__casenum,  update),
																build(kKeySanctn__key__sanctn__incident,  update),
																build(kKeySanctn__key__sanctn__incident_midex,  update),
																build(kKeySanctn__key__sanctn__license_midex,  update),
																build(kKeySanctn__key__sanctn__license_nbr,  update),
																build(kKeySanctn__key__sanctn__midex_rpt_nbr,  update),
																build(kKeySanctn__key__sanctn__nmls_id,  update),
																build(kKeySanctn__key__sanctn__nmls_midex,  update),
																build(kKeySanctn__key__sanctn__party,  update),
																build(kKeySanctn__key__sanctn__rebuttal,  update),
																build(kKeySanctn__key__sanctn__ssn4,  update),
																build(kKeySanctn__key__sanctn__party_aka_dba,  update),
																build(kKeySanctn__key__sanctn__linkids,  update)
																)
																// ,

   											// PRTE.UpdateVersion('SanctnKeys',												//	Package name
   																				 // pIndexVersion,												//	Package version
   																				 // _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 // 'B',																	//	B = Boca, A = Alpharetta
   																				 // 'N',																	//	N = Non-FCRA, F = FCRA
   																				 // 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																// )
												
								);
								 

end;

