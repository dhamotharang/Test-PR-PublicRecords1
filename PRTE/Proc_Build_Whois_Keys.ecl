import prte_csv,_control;

export Proc_Build_Whois_Keys(string pIndexVersion)	:=function
	
	rkeythor_data400__key__whois__bdid															:= PRTE_CSV.Whois.rthor_data400__key__whois__bdid								;
	rkeythor_data400__key__whois__did		  													:= PRTE_CSV.Whois.rthor_data400__key__whois__did								;
	rkeythor_data400__key__whois__domain	 													:= PRTE_CSV.Whois.rthor_data400__key__whois__domain							;
	rkeythor_data400__key__whois__LinkIDs	 												  := PRTE_CSV.Whois.rthor_data400__key__whois__LinkIDs					  ;
	rkeythor_data400__key__internetservices__autokey__address				:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__address			;
	rkeythor_data400__key__internetservices__autokey__addressb2			:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__addressb2		;
	rkeythor_data400__key__internetservices__autokey__citystname		:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__citystname	;
	rkeythor_data400__key__internetservices__autokey__citystnameb2	:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__citystnameb2;
	rkeythor_data400__key__internetservices__autokey__name					:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__name				;
	rkeythor_data400__key__internetservices__autokey__nameb2				:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__nameb2			;
	rkeythor_data400__key__internetservices__autokey__namewords2		:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__namewords2	;
	rkeythor_data400__key__internetservices__autokey__payload				:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__payload			;
	rkeythor_data400__key__internetservices__autokey__stname				:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__stname			;
	rkeythor_data400__key__internetservices__autokey__stnameb2			:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__stnameb2		;
	rkeythor_data400__key__internetservices__autokey__zip						:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__zip					;
	rkeythor_data400__key__internetservices__autokey__zipb2				  := PRTE_CSV.Internetservices.rthor_data400__key__internetservices__autokey__zipb2				;
	rkeythor_data400__key__internetservices__bdid										:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__bdid									;
	rkeythor_data400__key__internetservices__did										:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__did									;
	rkeythor_data400__key__internetservices__domain									:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__domain								;
	rkeythor_data400__key__internetservices__id											:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__id										;
	rkeythor_data400__key__internetservices__LinkIDs								:= PRTE_CSV.Internetservices.rthor_data400__key__internetservices__LinkIDs							;

	dkeythor_data400__key__whois__bdid 															:= project(PRTE_CSV.Whois.dthor_data400__key__whois__bdid 	,rkeythor_data400__key__whois__bdid		);
	dkeythor_data400__key__whois__did 	  													:= project(PRTE_CSV.Whois.dthor_data400__key__whois__did 		,rkeythor_data400__key__whois__did		);
	dkeythor_data400__key__whois__domain  													:= project(PRTE_CSV.Whois.dthor_data400__key__whois__domain	,rkeythor_data400__key__whois__domain	);
	dkeythor_data400__key__whois__LinkIDs														:= project(PRTE_CSV.Whois.dthor_data400__key__whois__LinkIDs	,rkeythor_data400__key__whois__LinkIDs	);  													
	dkeythor_data400__key__internetservices__autokey__address 			:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__address 			,rkeythor_data400__key__internetservices__autokey__address			);
	dkeythor_data400__key__internetservices__autokey__addressb2 	  := project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__addressb2 		,rkeythor_data400__key__internetservices__autokey__addressb2		);
	dkeythor_data400__key__internetservices__autokey__citystname 	  := project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__citystname 	  ,rkeythor_data400__key__internetservices__autokey__citystname		);
	dkeythor_data400__key__internetservices__autokey__citystnameb2	:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__citystnameb2	,rkeythor_data400__key__internetservices__autokey__citystnameb2	);
	dkeythor_data400__key__internetservices__autokey__name 				  := project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__name 				  ,rkeythor_data400__key__internetservices__autokey__name					);
	dkeythor_data400__key__internetservices__autokey__nameb2 				:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__nameb2 			  ,rkeythor_data400__key__internetservices__autokey__nameb2				);
	dkeythor_data400__key__internetservices__autokey__namewords2 		:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__namewords2 	  ,rkeythor_data400__key__internetservices__autokey__namewords2		);
	dkeythor_data400__key__internetservices__autokey__payload 			:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__payload 			,rkeythor_data400__key__internetservices__autokey__payload			);
	dkeythor_data400__key__internetservices__autokey__stname 			  := project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__stname 			  ,rkeythor_data400__key__internetservices__autokey__stname				);
	dkeythor_data400__key__internetservices__autokey__stnameb2 		  := project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__stnameb2 		  ,rkeythor_data400__key__internetservices__autokey__stnameb2			);
	dkeythor_data400__key__internetservices__autokey__zip 				  := project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__zip 					,rkeythor_data400__key__internetservices__autokey__zip					);
	dkeythor_data400__key__internetservices__autokey__zipb2 			  := project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__autokey__zipb2 				,rkeythor_data400__key__internetservices__autokey__zipb2				);
	dkeythor_data400__key__internetservices__bdid 									:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__bdid 									,rkeythor_data400__key__internetservices__bdid									);
	dkeythor_data400__key__internetservices__did 										:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__did 									  ,rkeythor_data400__key__internetservices__did										);
	dkeythor_data400__key__internetservices__domain 								:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__domain 								,rkeythor_data400__key__internetservices__domain								);
	dkeythor_data400__key__internetservices__id 										:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__id 										,rkeythor_data400__key__internetservices__id										);
	dkeythor_data400__key__internetservices__LinkIDs  							:= project(PRTE_CSV.Internetservices.dthor_data400__key__internetservices__LinkIDs 								,rkeythor_data400__key__internetservices__LinkIDs								);

	kkeythor_data400__key__whois__bdid 															:= index(dkeythor_data400__key__whois__bdid 	, {bdid}, {dkeythor_data400__key__whois__bdid 	}, '~prte::key::whois::' + pIndexVersion + '::bdid');
	kkeythor_data400__key__whois__did 										        	:= index(dkeythor_data400__key__whois__did 		, {d}		, {dkeythor_data400__key__whois__did 		}, '~prte::key::whois::' + pIndexVersion + '::did');
	kkeythor_data400__key__whois__domain 												  	:= index(dkeythor_data400__key__whois__domain	, {dn}	, {dkeythor_data400__key__whois__domain	}, '~prte::key::whois::' + pIndexVersion + '::domain');
	kkeythor_data400__key__whois__linkIDs 											  	:= index(dkeythor_data400__key__whois__linkIDs	, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__whois__linkIDs}, '~prte::key::whois::' + pIndexVersion + '::linkIDs');
	kkeythor_data400__key__internetservices__autokey__address 			:= index(dkeythor_data400__key__internetservices__autokey__address 			, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}														, {dkeythor_data400__key__internetservices__autokey__address 			}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::address');
	kkeythor_data400__key__internetservices__autokey__addressb2 		:= index(dkeythor_data400__key__internetservices__autokey__addressb2 		, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}																																	, {dkeythor_data400__key__internetservices__autokey__addressb2 		}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::addressb2');
	kkeythor_data400__key__internetservices__autokey__citystname 		:= index(dkeythor_data400__key__internetservices__autokey__citystname 	, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}				, {dkeythor_data400__key__internetservices__autokey__citystname 	}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::citystname');
	kkeythor_data400__key__internetservices__autokey__citystnameb2	:= index(dkeythor_data400__key__internetservices__autokey__citystnameb2	, {city_code,st,cname_indic,cname_sec,bdid}																																																			, {dkeythor_data400__key__internetservices__autokey__citystnameb2	}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::citystnameb2');
	kkeythor_data400__key__internetservices__autokey__name 					:= index(dkeythor_data400__key__internetservices__autokey__name 				, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}				, {dkeythor_data400__key__internetservices__autokey__name 				}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::name');
	kkeythor_data400__key__internetservices__autokey__nameb2 				:= index(dkeythor_data400__key__internetservices__autokey__nameb2 			, {cname_indic,cname_sec,bdid}																																																									, {dkeythor_data400__key__internetservices__autokey__nameb2 			}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::nameb2');
	kkeythor_data400__key__internetservices__autokey__namewords2 		:= index(dkeythor_data400__key__internetservices__autokey__namewords2 	, {word,state,seq,bdid}																																																													, {dkeythor_data400__key__internetservices__autokey__namewords2 	}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::namewords2');
	kkeythor_data400__key__internetservices__autokey__payload 			:= index(dkeythor_data400__key__internetservices__autokey__payload 			, {fakeid}																																																																			, {dkeythor_data400__key__internetservices__autokey__payload 			}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::payload');
	kkeythor_data400__key__internetservices__autokey__stname 				:= index(dkeythor_data400__key__internetservices__autokey__stname 			, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}	, {dkeythor_data400__key__internetservices__autokey__stname 			}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::stname');
	kkeythor_data400__key__internetservices__autokey__stnameb2 			:= index(dkeythor_data400__key__internetservices__autokey__stnameb2 		, {st,cname_indic,cname_sec,bdid}																																																								, {dkeythor_data400__key__internetservices__autokey__stnameb2 		}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::stnameb2');
	kkeythor_data400__key__internetservices__autokey__zip 					:= index(dkeythor_data400__key__internetservices__autokey__zip 					, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}		, {dkeythor_data400__key__internetservices__autokey__zip 					}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::zip');
	kkeythor_data400__key__internetservices__autokey__zipb2 				:= index(dkeythor_data400__key__internetservices__autokey__zipb2 				, {zip,cname_indic,cname_sec,bdid}																																																							, {dkeythor_data400__key__internetservices__autokey__zipb2 				}, '~prte::key::internetservices::' + pIndexVersion + '::autokey::zipb2');
	kkeythor_data400__key__internetservices__bdid 									:= index(dkeythor_data400__key__internetservices__bdid 									, {bdid}																																																																				, {dkeythor_data400__key__internetservices__bdid 									}, '~prte::key::internetservices::' + pIndexVersion + '::bdid');
	kkeythor_data400__key__internetservices__did 										:= index(dkeythor_data400__key__internetservices__did 									, {did}																																																																					, {dkeythor_data400__key__internetservices__did 									}, '~prte::key::internetservices::' + pIndexVersion + '::did');
	kkeythor_data400__key__internetservices__domain 								:= index(dkeythor_data400__key__internetservices__domain 								, {domain_name}																																																																	, {dkeythor_data400__key__internetservices__domain 								}, '~prte::key::internetservices::' + pIndexVersion + '::domain');
	kkeythor_data400__key__internetservices__id 										:= index(dkeythor_data400__key__internetservices__id 										, {internetservices_id}																																																													, {dkeythor_data400__key__internetservices__id 										}, '~prte::key::internetservices::' + pIndexVersion + '::id');
	kkeythor_data400__key__internetservices__linkIDs 								:= index(dkeythor_data400__key__internetservices__LinkIDs 	, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__internetservices__linkIDs}, '~prte::key::internetservices::' + pIndexVersion + '::linkIDs');
	
	return sequential(
											parallel(
												 build(kkeythor_data400__key__whois__bdid 		,update)
												,build(kkeythor_data400__key__whois__did 			,update)
												,build(kkeythor_data400__key__whois__domain 	,update)
												,build(kkeythor_data400__key__whois__linkIDs 	,update)
												,build(kkeythor_data400__key__internetservices__autokey__address 			,update)
												,build(kkeythor_data400__key__internetservices__autokey__addressb2 		,update)
												,build(kkeythor_data400__key__internetservices__autokey__citystname 	,update)
												,build(kkeythor_data400__key__internetservices__autokey__citystnameb2	,update)
												,build(kkeythor_data400__key__internetservices__autokey__name 				,update)
												,build(kkeythor_data400__key__internetservices__autokey__nameb2 			,update)
												,build(kkeythor_data400__key__internetservices__autokey__namewords2 	,update)
												,build(kkeythor_data400__key__internetservices__autokey__payload 			,update)
												,build(kkeythor_data400__key__internetservices__autokey__stname 			,update)
												,build(kkeythor_data400__key__internetservices__autokey__stnameb2 		,update)
												,build(kkeythor_data400__key__internetservices__autokey__zip 					,update)
												,build(kkeythor_data400__key__internetservices__autokey__zipb2 				,update)
												,build(kkeythor_data400__key__internetservices__bdid 									,update)
												,build(kkeythor_data400__key__internetservices__did 									,update)
												,build(kkeythor_data400__key__internetservices__domain 								,update)
												,build(kkeythor_data400__key__internetservices__id 										,update)
												,build(kkeythor_data400__key__internetservices__linkIDs 							,update)
											)
											,PRTE.UpdateVersion(
													'WhoisKeys'													//	Package name
												 ,pIndexVersion												//	Package version
												 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
												 ,'N'																	//  auto_pkg (optional) -- don't use it
												 ,'N'																	//	N = Non-FCRA, F = FCRA
												 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
											)
								);


end;