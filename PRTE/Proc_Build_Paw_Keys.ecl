import prte_csv,_control, BIPV2;

export Proc_Build_Paw_Keys(string pIndexVersion)	:=
function
                                                                                                                                                                                                                                                                                                                          
	rkeythor_data400__key__paw__autokey__address					:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__address					;
	rkeythor_data400__key__paw__autokey__addressb2			  := PRTE_CSV.PAW.rthor_data400__key__paw__autokey__addressb2				;
	rkeythor_data400__key__paw__autokey__citystname		 	 	:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__citystname			;
	rkeythor_data400__key__paw__autokey__citystnameb2			:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__citystnameb2		;
	rkeythor_data400__key__paw__autokey__fein2					  := PRTE_CSV.PAW.rthor_data400__key__paw__autokey__fein2						;
	rkeythor_data400__key__paw__autokey__name							:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__name						;
	rkeythor_data400__key__paw__autokey__nameb2						:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__nameb2					;
	rkeythor_data400__key__paw__autokey__namewords2				:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__namewords2			;
	rkeythor_data400__key__paw__autokey__payload				  := PRTE_CSV.PAW.rthor_data400__key__paw__autokey__payload					;
	rkeythor_data400__key__paw__autokey__phone2				  	:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__phone2					;
	rkeythor_data400__key__paw__autokey__phoneb2				  := PRTE_CSV.PAW.rthor_data400__key__paw__autokey__phoneb2					;
	rkeythor_data400__key__paw__autokey__ssn2					  	:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__ssn2						;
	rkeythor_data400__key__paw__autokey__stname						:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__stname					;
	rkeythor_data400__key__paw__autokey__stnameb2					:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__stnameb2				;
	rkeythor_data400__key__paw__autokey__zip							:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__zip							;
	rkeythor_data400__key__paw__autokey__zipb2						:= PRTE_CSV.PAW.rthor_data400__key__paw__autokey__zipb2						;
	rkeythor_data400__key__paw__bdid										  := PRTE_CSV.PAW.rthor_data400__key__paw__bdid											;
	rkeythor_data400__key__paw__contactid									:= PRTE_CSV.PAW.rthor_data400__key__paw__contactid              	;
	rkeythor_data400__key__paw__did										  	:= PRTE_CSV.PAW.rthor_data400__key__paw__did											;
	rkeythor_data400__key__paw__companyname_domain				:= PRTE_CSV.PAW.rthor_data400__key__paw__companyname_domain				;
	rkeythor_data400__key__paw__linkids										:= PRTE_CSV.PAW.rthor_data400__key__paw__linkids									;

	dkeythor_data400__key__paw__autokey__address 					:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__address 				,rkeythor_data400__key__paw__autokey__address					);
	dkeythor_data400__key__paw__autokey__addressb2 			  := project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__addressb2 			,rkeythor_data400__key__paw__autokey__addressb2				);
	dkeythor_data400__key__paw__autokey__citystname 		  := project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__citystname 			,rkeythor_data400__key__paw__autokey__citystname			);
	dkeythor_data400__key__paw__autokey__citystnameb2 		:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__citystnameb2 		,rkeythor_data400__key__paw__autokey__citystnameb2		);
	dkeythor_data400__key__paw__autokey__fein2 					  := project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__fein2 					,rkeythor_data400__key__paw__autokey__fein2						);
	dkeythor_data400__key__paw__autokey__name 						:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__name 						,rkeythor_data400__key__paw__autokey__name						);
	dkeythor_data400__key__paw__autokey__nameb2 					:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__nameb2 					,rkeythor_data400__key__paw__autokey__nameb2					);
	dkeythor_data400__key__paw__autokey__namewords2 			:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__namewords2 			,rkeythor_data400__key__paw__autokey__namewords2			);
	dkeythor_data400__key__paw__autokey__payload 				  := project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__payload 				,rkeythor_data400__key__paw__autokey__payload					);
	dkeythor_data400__key__paw__autokey__phone2 				  := project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__phone2 					,rkeythor_data400__key__paw__autokey__phone2					);
	dkeythor_data400__key__paw__autokey__phoneb2 				  := project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__phoneb2 				,rkeythor_data400__key__paw__autokey__phoneb2					);
	dkeythor_data400__key__paw__autokey__ssn2 					  := project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__ssn2 						,rkeythor_data400__key__paw__autokey__ssn2						);
	dkeythor_data400__key__paw__autokey__stname 					:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__stname 					,rkeythor_data400__key__paw__autokey__stname					);
	dkeythor_data400__key__paw__autokey__stnameb2 				:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__stnameb2 				,rkeythor_data400__key__paw__autokey__stnameb2				);
	dkeythor_data400__key__paw__autokey__zip 							:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__zip 						,rkeythor_data400__key__paw__autokey__zip							);
	dkeythor_data400__key__paw__autokey__zipb2 						:= project(PRTE_CSV.PAW.dthor_data400__key__paw__autokey__zipb2 					,rkeythor_data400__key__paw__autokey__zipb2						);
	dkeythor_data400__key__paw__bdid 										  := project(PRTE_CSV.PAW.dthor_data400__key__paw__bdid 										,rkeythor_data400__key__paw__bdid											);
	dkeythor_data400__key__paw__contactid 								:= project(PRTE_CSV.PAW.dthor_data400__key__paw__contactid 								,{rkeythor_data400__key__paw__contactid and not __internal_fpos__, BIPV2.IDlayouts.l_xlink_ids}								);
	dkeythor_data400__key__paw__did 										  := project(PRTE_CSV.PAW.dthor_data400__key__paw__did 											,rkeythor_data400__key__paw__did											);
	dkeythor_data400__key__paw__companyname_domain			  := project(PRTE_CSV.PAW.dthor_data400__key__paw__companyname_domain				,rkeythor_data400__key__paw__companyname_domain				);
	dkeythor_data400__key__paw__linkids									  := project(PRTE_CSV.PAW.dthor_data400__key__paw__linkids 									,rkeythor_data400__key__paw__linkids									);


	kkeythor_data400__key__paw__autokey__address 			:= index(dkeythor_data400__key__paw__autokey__address 		, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}														, {dkeythor_data400__key__paw__autokey__address 			}, '~prte::key::paw::' + pIndexVersion + '::autokey::address'			);
	kkeythor_data400__key__paw__autokey__addressb2 		:= index(dkeythor_data400__key__paw__autokey__addressb2 	, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}																																	, {dkeythor_data400__key__paw__autokey__addressb2 		}, '~prte::key::paw::' + pIndexVersion + '::autokey::addressb2'		);
	kkeythor_data400__key__paw__autokey__citystname 	:= index(dkeythor_data400__key__paw__autokey__citystname 	, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}				, {dkeythor_data400__key__paw__autokey__citystname 		}, '~prte::key::paw::' + pIndexVersion + '::autokey::citystname'	);
	kkeythor_data400__key__paw__autokey__citystnameb2 := index(dkeythor_data400__key__paw__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}																																																			, {dkeythor_data400__key__paw__autokey__citystnameb2 	}, '~prte::key::paw::' + pIndexVersion + '::autokey::citystnameb2');
	kkeythor_data400__key__paw__autokey__fein2 				:= index(dkeythor_data400__key__paw__autokey__fein2 			, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}																																												, {dkeythor_data400__key__paw__autokey__fein2 				}, '~prte::key::paw::' + pIndexVersion + '::autokey::fein2'				);
	kkeythor_data400__key__paw__autokey__name 				:= index(dkeythor_data400__key__paw__autokey__name 				, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}				, {dkeythor_data400__key__paw__autokey__name 					}, '~prte::key::paw::' + pIndexVersion + '::autokey::name'				);
	kkeythor_data400__key__paw__autokey__nameb2 			:= index(dkeythor_data400__key__paw__autokey__nameb2 			, {cname_indic,cname_sec,bdid}																																																									, {dkeythor_data400__key__paw__autokey__nameb2 				}, '~prte::key::paw::' + pIndexVersion + '::autokey::nameb2'			);
	kkeythor_data400__key__paw__autokey__namewords2 	:= index(dkeythor_data400__key__paw__autokey__namewords2 	, {word,state,seq,bdid}																																																													, {dkeythor_data400__key__paw__autokey__namewords2 		}, '~prte::key::paw::' + pIndexVersion + '::autokey::namewords2'	);
	kkeythor_data400__key__paw__autokey__payload 			:= index(dkeythor_data400__key__paw__autokey__payload 		, {fakeid}																																																																			, {dkeythor_data400__key__paw__autokey__payload 			}, '~prte::key::paw::' + pIndexVersion + '::autokey::payload'			);
	kkeythor_data400__key__paw__autokey__phone2 			:= index(dkeythor_data400__key__paw__autokey__phone2 			, {p7,p3,dph_lname,pfname,st,did}																																																								, {dkeythor_data400__key__paw__autokey__phone2 				}, '~prte::key::paw::' + pIndexVersion + '::autokey::phone2'			);
	kkeythor_data400__key__paw__autokey__phoneb2 			:= index(dkeythor_data400__key__paw__autokey__phoneb2 		, {p7,p3,cname_indic,cname_sec,st,bdid}																																																					, {dkeythor_data400__key__paw__autokey__phoneb2 			}, '~prte::key::paw::' + pIndexVersion + '::autokey::phoneb2'			);
	kkeythor_data400__key__paw__autokey__ssn2 				:= index(dkeythor_data400__key__paw__autokey__ssn2 				, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}																																															, {dkeythor_data400__key__paw__autokey__ssn2 					}, '~prte::key::paw::' + pIndexVersion + '::autokey::ssn2'				);
	kkeythor_data400__key__paw__autokey__stname 			:= index(dkeythor_data400__key__paw__autokey__stname 			, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}	, {dkeythor_data400__key__paw__autokey__stname 				}, '~prte::key::paw::' + pIndexVersion + '::autokey::stname'			);
	kkeythor_data400__key__paw__autokey__stnameb2 		:= index(dkeythor_data400__key__paw__autokey__stnameb2 		, {st,cname_indic,cname_sec,bdid}																																																								, {dkeythor_data400__key__paw__autokey__stnameb2 			}, '~prte::key::paw::' + pIndexVersion + '::autokey::stnameb2'		);
	kkeythor_data400__key__paw__autokey__zip 					:= index(dkeythor_data400__key__paw__autokey__zip 				, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}		, {dkeythor_data400__key__paw__autokey__zip 					}, '~prte::key::paw::' + pIndexVersion + '::autokey::zip'					);
	kkeythor_data400__key__paw__autokey__zipb2 				:= index(dkeythor_data400__key__paw__autokey__zipb2 			, {zip,cname_indic,cname_sec,bdid}																																																							, {dkeythor_data400__key__paw__autokey__zipb2 				}, '~prte::key::paw::' + pIndexVersion + '::autokey::zipb2'				);
	kkeythor_data400__key__paw__bdid 									:= index(dkeythor_data400__key__paw__bdid 								, {bdid}																																																																				, {dkeythor_data400__key__paw__bdid 									}, '~prte::key::paw::' + pIndexVersion + '::bdid'									);
	kkeythor_data400__key__paw__contactid 						:= index(dkeythor_data400__key__paw__contactid 						, {contact_id}																																																																	, {dkeythor_data400__key__paw__contactid 							}, '~prte::key::paw::' + pIndexVersion + '::contactid'						);
	kkeythor_data400__key__paw__did 									:= index(dkeythor_data400__key__paw__did 									, {did}																																																																					, {dkeythor_data400__key__paw__did 										}, '~prte::key::paw::' + pIndexVersion + '::did'									);
	kkeythor_data400__key__paw__companyname_domain		:= index(dkeythor_data400__key__paw__companyname_domain		, {domain}																																																																			, {dkeythor_data400__key__paw__companyname_domain			}, '~prte::key::paw::' + pIndexVersion + '::companyname_domain'		);
	kkeythor_data400__key__paw__linkids								:= index(dkeythor_data400__key__paw__linkids 							, {ultid,orgid,seleid,proxid,powid,empid,dotid}																																																	, {dkeythor_data400__key__paw__linkids								}, '~prte::key::paw::' + pIndexVersion + '::linkids'							);

	return 
	sequential(
		parallel(
			 build(kkeythor_data400__key__paw__autokey__address 					,update)
			,build(kkeythor_data400__key__paw__autokey__addressb2 		 		,update)
			,build(kkeythor_data400__key__paw__autokey__citystname 				,update)
			,build(kkeythor_data400__key__paw__autokey__citystnameb2 			,update)
			,build(kkeythor_data400__key__paw__autokey__fein2 						,update)
			,build(kkeythor_data400__key__paw__autokey__name 							,update)
			,build(kkeythor_data400__key__paw__autokey__nameb2 						,update)
			,build(kkeythor_data400__key__paw__autokey__namewords2 				,update)
			,build(kkeythor_data400__key__paw__autokey__payload 					,update)
			,build(kkeythor_data400__key__paw__autokey__phone2 						,update)
			,build(kkeythor_data400__key__paw__autokey__phoneb2 					,update)
			,build(kkeythor_data400__key__paw__autokey__ssn2 							,update)
			,build(kkeythor_data400__key__paw__autokey__stname 						,update)
			,build(kkeythor_data400__key__paw__autokey__stnameb2 					,update)
			,build(kkeythor_data400__key__paw__autokey__zip 							,update)
			,build(kkeythor_data400__key__paw__autokey__zipb2 						,update)
			,build(kkeythor_data400__key__paw__bdid 											,update)
			,build(kkeythor_data400__key__paw__contactid 									,update)
			,build(kkeythor_data400__key__paw__did 												,update)
			,build(kkeythor_data400__key__paw__companyname_domain					,update)
			,build(kkeythor_data400__key__paw__linkids										,update)
		)
		,PRTE.UpdateVersion(
				'PAWV2Keys'													//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);


end;