import	_control, PRTE_CSV,BIPV2;

export  Proc_Build_UCC_Keys(string pIndexVersion)	:= function

           rKeyUCC__key__ucc__autokey__address	:=record
	PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__address;
end;

           rKeyUCC__key__ucc__autokey__addressb2	:=record
	PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__addressb2;
end;

           rKeyUCC__key__ucc__autokey__citystname	:=record
	PRTE_CSV.UCC. rthor_data400__key__ucc__autokey__citystname;
end;

           rKeyUCC__key__ucc__autokey__citystnameb2	:=record
	PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__citystnameb2;
end;

           rKeyUCC__key__ucc__autokey__fein2	:=record
	PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__fein2;
end;

           rKeyUCC__key__ucc__autokey__name	:=record
		PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__name;
end;

           rKeyUCC__key__ucc__autokey__nameb2	:=record
PRTE_CSV.UCC. rthor_data400__key__ucc__autokey__nameb2;
end;

           rKeyUCC__key__ucc__autokey__namewords2	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__namewords2;
end;



           rKeyUCC__key__ucc__autokey__payload	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__payload;
end;

           rKeyUCC__key__ucc__autokey__phone2	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__phone2;
end;

           rKeyUCC__key__ucc__autokey__phoneb2	:=record
PRTE_CSV.UCC. rthor_data400__key__ucc__autokey__phoneb2;
end;

           rKeyUCC__key__ucc__autokey__ssn2	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__ssn2;
end;

           rKeyUCC__key__ucc__autokey__stname	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__stname;
end;

           rKeyUCC__key__ucc__autokey__stnameb2	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__stnameb2
end;

           rKeyUCC__key__ucc__autokey__zip	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__autokey__zip;
end;

           rKeyUCC__key__ucc__autokey__zipb2	:=record
PRTE_CSV.UCC. rthor_data400__key__ucc__autokey__zipb2;
end;

           rKeyUCC__key__ucc__bdid_w_type	:=record
PRTE_CSV.UCC. rthor_data400__key__ucc__bdid_w_type;
end;

           rKeyUCC__key__ucc__did_w_type	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__did_w_type
end;

           rKeyUCC__key__ucc__filing_number	:=record
PRTE_CSV.UCC.rthor_data400__key__ucc__filing_number;
end;

           rKeyUCC__key__ucc__main_rmsid	:=record,maxLength(32767)
		PRTE_CSV.UCC.rthor_data400__key__ucc__main_rmsid;
end;

       rKeyUCC__key__ucc__party_rmsid	:=record,maxLength(32767)
		PRTE_CSV.UCC.rthor_data400__key__ucc__party_rmsid;
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned8 persistent_record_id:=0;
end;

        rKeyUCC__key__ucc__rmsid	:=record,maxLength(32767) 
		PRTE_CSV.UCC.rthor_data400__key__ucc__rmsid;
		
end;
        rKeyUCC__key__ucc__Linkids	:=record 
		PRTE_CSV.UCC.rthor_data400__key__ucc__Linkids  ;
		unsigned8 persistent_record_id:=0;
		
end;
        rKeyUCC__key__ucc__bdid	:=record 
		PRTE_CSV.UCC.rthor_data400__key__ucc__bdid  ;
		
end;
        rKeyUCC__key__ucc__did	:=record 
		PRTE_CSV.UCC.rthor_data400__key__ucc__did  ;
		
end;
        rKeyUCC__key__ucc__filing_date	:=record 
		PRTE_CSV.UCC.rthor_data400__key__ucc__filing_date  ;
		
end;
        rKeyUCC__key__ucc__jurisdiction	:=record
		PRTE_CSV.UCC.rthor_data400__key__ucc__jurisdiction  ;
		
end;

dKeyUCC__key__ucc__autokey__address				:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__address ,rKeyUCC__key__ucc__autokey__address);
dKeyUCC__key__ucc__autokey__addressb2			:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__addressb2 ,rKeyUCC__key__ucc__autokey__addressb2); 
dKeyUCC__key__ucc__autokey__citystname		:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__citystname,rKeyUCC__key__ucc__autokey__citystname); 
dKeyUCC__key__ucc__autokey__citystnameb2	:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__citystnameb2  , rKeyUCC__key__ucc__autokey__citystnameb2);
dKeyUCC__key__ucc__autokey__fein2		    	:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__fein2 , rKeyUCC__key__ucc__autokey__fein2);
dKeyUCC__key__ucc__autokey__name					:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__name  ,rKeyUCC__key__ucc__autokey__name); 
dKeyUCC__key__ucc__autokey__nameb2				:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__nameb2  , rKeyUCC__key__ucc__autokey__nameb2);
dKeyUCC__key__ucc__autokey__namewords2		:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__namewords2  , rKeyUCC__key__ucc__autokey__namewords2);
dKeyUCC__key__ucc__autokey__payload				:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__payload,rKeyUCC__key__ucc__autokey__payload); 
dKeyUCC__key__ucc__autokey__phone2		 		:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__phone2  ,rKeyUCC__key__ucc__autokey__phone2); 
dKeyUCC__key__ucc__autokey__phoneb2				:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__phoneb2  ,rKeyUCC__key__ucc__autokey__phoneb2); 
dKeyUCC__key__ucc__autokey__ssn2					:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__20090901__autokey__ssn2  , rKeyUCC__key__ucc__autokey__ssn2);
dKeyUCC__key__ucc__autokey__stname				:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__stname  , rKeyUCC__key__ucc__autokey__stname);
dKeyUCC__key__ucc__autokey__stnameb2			:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__stnameb2 , rKeyUCC__key__ucc__autokey__stnameb2);
dKeyUCC__key__ucc__autokey__zip						:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__zip  ,rKeyUCC__key__ucc__autokey__zip); 
dKeyUCC__key__ucc__autokey__zipb2					:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__autokey__zipb2  , rKeyUCC__key__ucc__autokey__zipb2);
dKeyUCC__key__ucc__bdid_w_type						:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__bdid_w_type ,rKeyUCC__key__ucc__bdid_w_type); 
dKeyUCC__key__ucc__did_w_type							:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__did_w_type  ,rKeyUCC__key__ucc__did_w_type );
dKeyUCC__key__ucc__filing_number					:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__filing_number ,  rKeyUCC__key__ucc__filing_number);
dKeyUCC__key__ucc__main_rmsid							:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__main_rmsid  , rKeyUCC__key__ucc__main_rmsid); 
dKeyUCC__key__ucc__party_rmsid						:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__party_rmsid  ,rKeyUCC__key__ucc__party_rmsid); 
dKeyUCC__key__ucc__rmsid									:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__rmsid, rKeyUCC__key__ucc__rmsid);
dKeyUCC__key__ucc__Linkids								:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__Linkids, rKeyUCC__key__ucc__Linkids);
dKeyUCC__key__ucc__bdid								    := project(PRTE_CSV.UCC.dthor_data400__key__ucc__bdid, rKeyUCC__key__ucc__bdid);
dKeyUCC__key__ucc__did								    := project(PRTE_CSV.UCC.dthor_data400__key__ucc__did, rKeyUCC__key__ucc__did);
dKeyUCC__key__ucc__filing_date						:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__filing_date, rKeyUCC__key__ucc__filing_date);
dKeyUCC__key__ucc__jurisdiction						:= project(PRTE_CSV.UCC.dthor_data400__key__ucc__jurisdiction, rKeyUCC__key__ucc__jurisdiction);

kKeyUCC__key__ucc__autokey__address 					:= index(dKeyUCC__key__ucc__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyUCC__key__ucc__autokey__address}, '~prte::key::ucc::' + pIndexVersion + '::autokey::address');
kKeyUCC__key__ucc__autokey__addressb2 				:= index(dKeyUCC__key__ucc__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyUCC__key__ucc__autokey__addressb2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::addressb2');
kKeyUCC__key__ucc__autokey__citystname 				:= index(dKeyUCC__key__ucc__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyUCC__key__ucc__autokey__citystname}, '~prte::key::ucc::' + pIndexVersion + '::autokey::citystname');
kKeyUCC__key__ucc__autokey__citystnameb2 			:= index(dKeyUCC__key__ucc__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyUCC__key__ucc__autokey__citystnameb2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::citystnameb2');
kKeyUCC__key__ucc__autokey__fein2 						:= index(dKeyUCC__key__ucc__autokey__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeyUCC__key__ucc__autokey__fein2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::fein2');
kKeyUCC__key__ucc__autokey__name 							:= index(dKeyUCC__key__ucc__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyUCC__key__ucc__autokey__name}, '~prte::key::ucc::' + pIndexVersion + '::autokey::name');
kKeyUCC__key__ucc__autokey__nameb2 						:= index(dKeyUCC__key__ucc__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyUCC__key__ucc__autokey__nameb2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::nameb2');
kKeyUCC__key__ucc__autokey__namewords2 				:= index(dKeyUCC__key__ucc__autokey__namewords2, {word,state,seq,bdid}, {dKeyUCC__key__ucc__autokey__namewords2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::namewords2');
kKeyUCC__key__ucc__autokey__payload 					:= index(dKeyUCC__key__ucc__autokey__payload, {fakeid}, {dKeyUCC__key__ucc__autokey__payload}, '~prte::key::ucc::' + pIndexVersion + '::autokey::payload');
kKeyUCC__key__ucc__autokey__phone2 						:= index(dKeyUCC__key__ucc__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyUCC__key__ucc__autokey__phone2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::phone2');
kKeyUCC__key__ucc__autokey__phoneb2 					:= index(dKeyUCC__key__ucc__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyUCC__key__ucc__autokey__phoneb2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::phoneb2');
kKeyUCC__key__ucc__autokey__ssn2 							:= index(dKeyUCC__key__ucc__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyUCC__key__ucc__autokey__ssn2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::ssn2');
kKeyUCC__key__ucc__autokey__stname 						:= index(dKeyUCC__key__ucc__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyUCC__key__ucc__autokey__stname}, '~prte::key::ucc::' + pIndexVersion + '::autokey::stname');
kKeyUCC__key__ucc__autokey__stnameb2 					:= index(dKeyUCC__key__ucc__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyUCC__key__ucc__autokey__stnameb2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::stnameb2');
kKeyUCC__key__ucc__autokey__zip 							:= index(dKeyUCC__key__ucc__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyUCC__key__ucc__autokey__zip}, '~prte::key::ucc::' + pIndexVersion + '::autokey::zip');
kKeyUCC__key__ucc__autokey__zipb2 						:= index(dKeyUCC__key__ucc__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyUCC__key__ucc__autokey__zipb2}, '~prte::key::ucc::' + pIndexVersion + '::autokey::zipb2');
kKeyUCC__key__ucc__bdid_w_type 								:= index(dKeyUCC__key__ucc__bdid_w_type, {bdid,party_type}, {dKeyUCC__key__ucc__bdid_w_type}, '~prte::key::ucc::' + pIndexVersion + '::bdid_w_type');
kKeyUCC__key__ucc__did_w_type 								:= index(dKeyUCC__key__ucc__did_w_type, {did,party_type}, {dKeyUCC__key__ucc__did_w_type}, '~prte::key::ucc::' + pIndexVersion + '::did_w_type');
kKeyUCC__key__ucc__filing_number 							:= index(dKeyUCC__key__ucc__filing_number, {filing_number}, {dKeyUCC__key__ucc__filing_number}, '~prte::key::ucc::' + pIndexVersion + '::filing_number');
kKeyUCC__key__ucc__main_rmsid 								:= index(dKeyUCC__key__ucc__main_rmsid, {tmsid,rmsid}, {dKeyUCC__key__ucc__main_rmsid}, '~prte::key::ucc::' + pIndexVersion + '::main_rmsid');
kKeyUCC__key__ucc__party_rmsid 								:= index(dKeyUCC__key__ucc__party_rmsid, {tmsid,rmsid}, {dKeyUCC__key__ucc__party_rmsid}, '~prte::key::ucc::' + pIndexVersion + '::party_rmsid');
kKeyUCC__key__ucc__rmsid 											:= index(dKeyUCC__key__ucc__rmsid, {rmsid}, {dKeyUCC__key__ucc__rmsid}, '~prte::key::ucc::' + pIndexVersion + '::rmsid');
kKeyUCC__key__ucc__Linkids 										:= index(dKeyUCC__key__ucc__Linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, {dKeyUCC__key__ucc__Linkids}, '~prte::key::ucc::' + pIndexVersion + '::linkids');
kKeyUCC__key__ucc__bdid 										  := index(dKeyUCC__key__ucc__bdid,{bdid}, {dKeyUCC__key__ucc__bdid}, '~prte::key::ucc::' + pIndexVersion + '::bdid');
kKeyUCC__key__ucc__did 										    := index(dKeyUCC__key__ucc__did,{did}, {dKeyUCC__key__ucc__did}, '~prte::key::ucc::' + pIndexVersion + '::did');
kKeyUCC__key__ucc__filing_date 							  := index(dKeyUCC__key__ucc__filing_date,{filing_date}, {dKeyUCC__key__ucc__filing_date}, '~prte::key::ucc::' + pIndexVersion + '::filing_date');
kKeyUCC__key__ucc__jurisdiction 						  := index(dKeyUCC__key__ucc__jurisdiction,{filing_jurisdiction}, {dKeyUCC__key__ucc__jurisdiction}, '~prte::key::ucc::' + pIndexVersion + '::jurisdiction');

kKeyUCC__key__ucc__did_w_type_fcra 						:= index(dKeyUCC__key__ucc__did_w_type, {did,party_type}, {dKeyUCC__key__ucc__did_w_type}, '~prte::key::ucc::' + pIndexVersion + '::fcra::did_w_type');
kKeyUCC__key__ucc__main_rmsid_fcra 						:= index(dKeyUCC__key__ucc__main_rmsid, {tmsid,rmsid}, {dKeyUCC__key__ucc__main_rmsid}, '~prte::key::ucc::' + pIndexVersion + '::fcra::main_rmsid');
kKeyUCC__key__ucc__party_rmsid_fcra						:= index(dKeyUCC__key__ucc__party_rmsid, {tmsid,rmsid}, {dKeyUCC__key__ucc__party_rmsid}, '~prte::key::ucc::' + pIndexVersion + '::fcra::party_rmsid');

return	sequential(
                    parallel(
                          build(kKeyUCC__key__ucc__autokey__address	, update),
                          build(kKeyUCC__key__ucc__autokey__addressb2	, update),
                          build(kKeyUCC__key__ucc__autokey__citystname	, update),
                          build(kKeyUCC__key__ucc__autokey__citystnameb2	, update),
                          build(kKeyUCC__key__ucc__autokey__fein2	, update),
                          build(kKeyUCC__key__ucc__autokey__name	, update),
                          build(kKeyUCC__key__ucc__autokey__nameb2	, update),
                          build(kKeyUCC__key__ucc__autokey__namewords2	, update),
                          build(kKeyUCC__key__ucc__autokey__payload	, update),
                          build(kKeyUCC__key__ucc__autokey__phone2	, update),
                          build(kKeyUCC__key__ucc__autokey__phoneb2	, update),
                          build(kKeyUCC__key__ucc__autokey__ssn2	, update),
                          build(kKeyUCC__key__ucc__autokey__stname	, update),
                          build(kKeyUCC__key__ucc__autokey__stnameb2	, update),
                          build(kKeyUCC__key__ucc__autokey__zip	, update),
                          build(kKeyUCC__key__ucc__autokey__zipb2	, update),
                          build(kKeyUCC__key__ucc__bdid_w_type	, update),
                          build(kKeyUCC__key__ucc__did_w_type	, update),
                          build(kKeyUCC__key__ucc__filing_number	, update),
                          build(kKeyUCC__key__ucc__main_rmsid 	, update),
                          build(kKeyUCC__key__ucc__party_rmsid 	, update),
                          build(kKeyUCC__key__ucc__rmsid	, update),
                          build(kKeyUCC__key__ucc__Linkids	, update),
                          build(kKeyUCC__key__ucc__bdid	, update),
                          build(kKeyUCC__key__ucc__did	, update),
                          build(kKeyUCC__key__ucc__filing_date , update),
                          build(kKeyUCC__key__ucc__jurisdiction	, update),
													build(kKeyUCC__key__ucc__did_w_type_fcra , update),
                          build(kKeyUCC__key__ucc__main_rmsid_fcra , update),
													build(kKeyUCC__key__ucc__party_rmsid_fcra, update)
                        ),

                       PRTE.UpdateVersion('UCCV2Keys',										//	Package name
                                         pIndexVersion,												//	Package version
                                         _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
                                         'B',																	//	B = Boca, A = Alpharetta
                                         'N',																	//	N = Non-FCRA, F = FCRA
                                         'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																					);
											PRTE.UpdateVersion('FCRA_UCCV2Keys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				); 
										 );  
					 

end;
