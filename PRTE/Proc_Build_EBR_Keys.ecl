import bipv2,prte_csv,_control,BIPV2;

export Proc_Build_EBR_Keys(string pIndexVersion)	:=
function
                                                                                                                                                                                                                                                                                                                            
	rkeythor_data400__key__ebr__0010_header__bdid																		:= PRTE_CSV.EBR.rthor_data400__key__ebr__0010_header__bdid																;
	rkeythor_data400__key__ebr__0010_header__file_number													  := PRTE_CSV.EBR.rthor_data400__key__ebr__0010_header__file_number													;
	rkeythor_data400__key__ebr__0010_header__linkids															  := PRTE_CSV.EBR.rthor_data400__key__ebr__0010_header__linkids															;
	rkeythor_data400__key__ebr__1000_executive_summary__bdid							 	 				:= PRTE_CSV.EBR.rthor_data400__key__ebr__1000_executive_summary__bdid											;
	rkeythor_data400__key__ebr__1000_executive_summary__file_number							 	 	:= PRTE_CSV.EBR.rthor_data400__key__ebr__1000_executive_summary__file_number							;
	rkeythor_data400__key__ebr__1000_executive_summary__linkids									 	 	:= PRTE_CSV.EBR.rthor_data400__key__ebr__1000_executive_summary__linkids									;
	rkeythor_data400__key__ebr__2000_trade__file_number															:= PRTE_CSV.EBR.rthor_data400__key__ebr__2000_trade__file_number													;
	rkeythor_data400__key__ebr__2015_trade_payment_totals__file_number						  := PRTE_CSV.EBR.rthor_data400__key__ebr__2015_trade_payment_totals__file_number						;
	rkeythor_data400__key__ebr__2020_trade_payment_trends__file_number							:= PRTE_CSV.EBR.rthor_data400__key__ebr__2020_trade_payment_trends__file_number						;
	rkeythor_data400__key__ebr__2025_trade_quarterly_averages__file_number					:= PRTE_CSV.EBR.rthor_data400__key__ebr__2025_trade_quarterly_averages__file_number				;
	rkeythor_data400__key__ebr__4010_bankruptcy__file_number												:= PRTE_CSV.EBR.rthor_data400__key__ebr__4010_bankruptcy__file_number											;
	rkeythor_data400__key__ebr__4020_tax_liens__file_number												  := PRTE_CSV.EBR.rthor_data400__key__ebr__4020_tax_liens__file_number											;
	rkeythor_data400__key__ebr__4030_judgement__file_number											  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__4030_judgement__file_number											;
	rkeythor_data400__key__ebr__4500_collateral_accounts__file_number							  := PRTE_CSV.EBR.rthor_data400__key__ebr__4500_collateral_accounts__file_number						;
	rkeythor_data400__key__ebr__4510_ucc_filings__bdid										  				:= PRTE_CSV.EBR.rthor_data400__key__ebr__4510_ucc_filings__bdid														;
	rkeythor_data400__key__ebr__4510_ucc_filings__file_number										  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__4510_ucc_filings__file_number										;
	rkeythor_data400__key__ebr__4510_ucc_filings__linkids												  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__4510_ucc_filings__linkids												;
	rkeythor_data400__key__ebr__5000_bank_details__file_number											:= PRTE_CSV.EBR.rthor_data400__key__ebr__5000_bank_details__file_number										;
	rkeythor_data400__key__ebr__5600_demographic_data__bdid													:= PRTE_CSV.EBR.rthor_data400__key__ebr__5600_demographic_data__bdid											;
	rkeythor_data400__key__ebr__5600_demographic_data__file_number									:= PRTE_CSV.EBR.rthor_data400__key__ebr__5600_demographic_data__file_number								;
	rkeythor_data400__key__ebr__5600_demographic_data__linkids											:= PRTE_CSV.EBR.rthor_data400__key__ebr__5600_demographic_data__linkids										;		
	rkeythor_data400__key__ebr__5610_demographic_data__did													:= PRTE_CSV.EBR.rthor_data400__key__ebr__5610_demographic_data__did												;
	rkeythor_data400__key__ebr__5610_demographic_data__file_number									:= PRTE_CSV.EBR.rthor_data400__key__ebr__5610_demographic_data__file_number								;
	rkeythor_data400__key__ebr__5610_demographic_data__linkids											:= PRTE_CSV.EBR.rthor_data400__key__ebr__5610_demographic_data__linkids										;
	rkeythor_data400__key__ebr__5610_demographic_data__ssn													:= PRTE_CSV.EBR.rthor_data400__key__ebr__5610_demographic_data__ssn												;
	rkeythor_data400__key__ebr__6000_inquiries__file_number												  := PRTE_CSV.EBR.rthor_data400__key__ebr__6000_inquiries__file_number											;
	rkeythor_data400__key__ebr__6500_government_trade__file_number									:= PRTE_CSV.EBR.rthor_data400__key__ebr__6500_government_trade__file_number								;
	rkeythor_data400__key__ebr__6510_government_debarred_contractor__file_number  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__6510_government_debarred_contractor__file_number	;
	rkeythor_data400__key__ebr__7010_snp_data__file_number											  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__7010_snp_data__file_number												;
	rkeythor_data400__key__ebr__autokey_addressb 											  						:= PRTE_CSV.EBR.rthor_data400__key__ebr__autokey_addressb															  	;
	rkeythor_data400__key__ebr__autokey_citystnameb 											  				:= PRTE_CSV.EBR.rthor_data400__key__ebr__autokey_citystnameb															;
	rkeythor_data400__key__ebr__autokey_nameb 																	  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__autokey_nameb																		;
	rkeythor_data400__key__ebr__autokey_namewords 															  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__autokey_namewords																;
	rkeythor_data400__key__ebr__autokey_payload 																  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__autokey_payload																	;
	rkeythor_data400__key__ebr__autokey_phoneb 																	  	:= PRTE_CSV.EBR.rthor_data400__key__ebr__autokey_phoneb 																	;
	rkeythor_data400__key__ebr__autokey_stnameb 																		:= PRTE_CSV.EBR.rthor_data400__key__ebr__autokey_stnameb																	;
	rkeythor_data400__key__ebr__autokey_zipb 																				:= PRTE_CSV.EBR.rthor_data400__key__ebr__autokey_zipb																			;

	dkeythor_data400__key__ebr__0010_header__bdid 																:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__0010_header__bdid 																,rkeythor_data400__key__ebr__0010_header__bdid																	);
	dkeythor_data400__key__ebr__0010_header__file_number 												  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__0010_header__file_number 												,rkeythor_data400__key__ebr__0010_header__file_number														);
	dkeythor_data400__key__ebr__0010_header__linkids		 												  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__0010_header__linkids			 												,rkeythor_data400__key__ebr__0010_header__linkids																);
	dkeythor_data400__key__ebr__1000_executive_summary__bdid				 						  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__1000_executive_summary__bdid				 							,rkeythor_data400__key__ebr__1000_executive_summary__bdid											 	);
	dkeythor_data400__key__ebr__1000_executive_summary__file_number 						  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__1000_executive_summary__file_number 							,rkeythor_data400__key__ebr__1000_executive_summary__file_number							 	);
	dkeythor_data400__key__ebr__1000_executive_summary__linkids			 						  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__1000_executive_summary__linkids		 							,rkeythor_data400__key__ebr__1000_executive_summary__linkids									 	);	
	dkeythor_data400__key__ebr__2000_trade__file_number 													:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__2000_trade__file_number 													,rkeythor_data400__key__ebr__2000_trade__file_number														);
	dkeythor_data400__key__ebr__2015_trade_payment_totals__file_number 					  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__2015_trade_payment_totals__file_number 					,rkeythor_data400__key__ebr__2015_trade_payment_totals__file_number							);
	dkeythor_data400__key__ebr__2020_trade_payment_trends__file_number 						:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__2020_trade_payment_trends__file_number 					,rkeythor_data400__key__ebr__2020_trade_payment_trends__file_number							);
	dkeythor_data400__key__ebr__2025_trade_quarterly_averages__file_number 				:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__2025_trade_quarterly_averages__file_number 			,rkeythor_data400__key__ebr__2025_trade_quarterly_averages__file_number					);
	dkeythor_data400__key__ebr__4010_bankruptcy__file_number 											:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__4010_bankruptcy__file_number 										,rkeythor_data400__key__ebr__4010_bankruptcy__file_number												);
	dkeythor_data400__key__ebr__4020_tax_liens__file_number 										  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__4020_tax_liens__file_number 											,rkeythor_data400__key__ebr__4020_tax_liens__file_number												);
	dkeythor_data400__key__ebr__4030_judgement__file_number 										  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__4030_judgement__file_number 											,rkeythor_data400__key__ebr__4030_judgement__file_number											  );
	dkeythor_data400__key__ebr__4500_collateral_accounts__file_number 					  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__4500_collateral_accounts__file_number 						,rkeythor_data400__key__ebr__4500_collateral_accounts__file_number							);
	dkeythor_data400__key__ebr__4510_ucc_filings__bdid				 									  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__4510_ucc_filings__bdid				 										,rkeythor_data400__key__ebr__4510_ucc_filings__bdid														  );
	dkeythor_data400__key__ebr__4510_ucc_filings__file_number 									  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__4510_ucc_filings__file_number 										,rkeythor_data400__key__ebr__4510_ucc_filings__file_number										  );
	dkeythor_data400__key__ebr__4510_ucc_filings__linkids													:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__4510_ucc_filings__linkids		 										,rkeythor_data400__key__ebr__4510_ucc_filings__linkids												  );	
	dkeythor_data400__key__ebr__5000_bank_details__file_number 										:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__5000_bank_details__file_number 									,rkeythor_data400__key__ebr__5000_bank_details__file_number											);
	dkeythor_data400__key__ebr__5600_demographic_data__bdid 											:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__5600_demographic_data__bdid 											,rkeythor_data400__key__ebr__5600_demographic_data__bdid												);
	dkeythor_data400__key__ebr__5600_demographic_data__file_number 								:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__5600_demographic_data__file_number 							,rkeythor_data400__key__ebr__5600_demographic_data__file_number									);
	dkeythor_data400__key__ebr__5600_demographic_data__linkids		 								:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__5600_demographic_data__linkids			 							,rkeythor_data400__key__ebr__5600_demographic_data__linkids											);
	dkeythor_data400__key__ebr__5610_demographic_data__did 												:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__5610_demographic_data__did 											,rkeythor_data400__key__ebr__5610_demographic_data__did													);
	dkeythor_data400__key__ebr__5610_demographic_data__file_number 								:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__5610_demographic_data__file_number 							,rkeythor_data400__key__ebr__5610_demographic_data__file_number									);
	dkeythor_data400__key__ebr__5610_demographic_data__linkids 										:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__5610_demographic_data__linkids 									,rkeythor_data400__key__ebr__5610_demographic_data__linkids											);
	dkeythor_data400__key__ebr__5610_demographic_data__ssn				 								:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__5610_demographic_data__ssn					 							,rkeythor_data400__key__ebr__5610_demographic_data__ssn													);	
	dkeythor_data400__key__ebr__6000_inquiries__file_number 										  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__6000_inquiries__file_number 											,rkeythor_data400__key__ebr__6000_inquiries__file_number												);
	dkeythor_data400__key__ebr__6500_government_trade__file_number 								:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__6500_government_trade__file_number 							,rkeythor_data400__key__ebr__6500_government_trade__file_number									);
	dkeythor_data400__key__ebr__6510_government_debarred_contractor__file_number  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__6510_government_debarred_contractor__file_number ,rkeythor_data400__key__ebr__6510_government_debarred_contractor__file_number  	);
	dkeythor_data400__key__ebr__7010_snp_data__file_number 											  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__7010_snp_data__file_number 											,rkeythor_data400__key__ebr__7010_snp_data__file_number											  	);
	dkeythor_data400__key__ebr__autokey_addressb 											  					:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__autokey_addressb																	,rkeythor_data400__key__ebr__autokey_addressb																  	);
	dkeythor_data400__key__ebr__autokey_citystnameb 											  			:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__autokey_citystnameb															,rkeythor_data400__key__ebr__autokey_citystnameb														  	);
	dkeythor_data400__key__ebr__autokey_nameb 																	  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__autokey_nameb																		,rkeythor_data400__key__ebr__autokey_nameb																	  	);
	dkeythor_data400__key__ebr__autokey_namewords 															  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__autokey_namewords																,rkeythor_data400__key__ebr__autokey_namewords															  	);
	dkeythor_data400__key__ebr__autokey_payload 																  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__autokey_payload																	,{rkeythor_data400__key__ebr__autokey_payload, BIPV2.IDlayouts.l_xlink_ids}	    );
	dkeythor_data400__key__ebr__autokey_phoneb 																	  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__autokey_phoneb																		,rkeythor_data400__key__ebr__autokey_phoneb											  							);
	dkeythor_data400__key__ebr__autokey_stnameb 																  := project(PRTE_CSV.EBR.dthor_data400__key__ebr__autokey_stnameb																	,rkeythor_data400__key__ebr__autokey_stnameb											  						);
	dkeythor_data400__key__ebr__autokey_zipb																			:= project(PRTE_CSV.EBR.dthor_data400__key__ebr__autokey_zipb																			,rkeythor_data400__key__ebr__autokey_zipb											  								);							 

	kkeythor_data400__key__ebr__0010_header__bdid 																:= index(dkeythor_data400__key__ebr__0010_header__bdid 																, {bdid}				, {dkeythor_data400__key__ebr__0010_header__bdid 																}, '~prte::key::ebr::' + pIndexVersion + '::0010_header::bdid');
	kkeythor_data400__key__ebr__0010_header__file_number 												  := index(dkeythor_data400__key__ebr__0010_header__file_number 												, {file_number}	, {dkeythor_data400__key__ebr__0010_header__file_number 												}, '~prte::key::ebr::' + pIndexVersion + '::0010_header::file_number');
	kkeythor_data400__key__ebr__0010_header__linkids		 												  := index(dkeythor_data400__key__ebr__0010_header__linkids		  												, {ultid,orgid,proxid,powid,empid,dotid,ultscore,orgscore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,proxweight,powweight,empweight,dotweight},{dkeythor_data400__key__ebr__0010_header__linkids},'~prte::key::ebr::' + pIndexVersion + '::0010_header::linkids');	
	kkeythor_data400__key__ebr__1000_executive_summary__bdid 						  				:= index(dkeythor_data400__key__ebr__1000_executive_summary__bdid 										, {bdid}				, {dkeythor_data400__key__ebr__1000_executive_summary__bdid 										}, '~prte::key::ebr::' + pIndexVersion + '::1000_executive_summary::bdid');
	kkeythor_data400__key__ebr__1000_executive_summary__file_number 						  := index(dkeythor_data400__key__ebr__1000_executive_summary__file_number 							, {file_number}	, {dkeythor_data400__key__ebr__1000_executive_summary__file_number 							}, '~prte::key::ebr::' + pIndexVersion + '::1000_executive_summary::file_number');
	kkeythor_data400__key__ebr__1000_executive_summary__linkids 								  := index(dkeythor_data400__key__ebr__1000_executive_summary__linkids		 							, {ultid,orgid,proxid,powid,empid,dotid,ultscore,orgscore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,proxweight,powweight,empweight,dotweight},{dkeythor_data400__key__ebr__1000_executive_summary__linkids}, '~prte::key::ebr::' + pIndexVersion + '::1000_executive_summary::linkids');	
	kkeythor_data400__key__ebr__2000_trade__file_number 													:= index(dkeythor_data400__key__ebr__2000_trade__file_number 													, {file_number}	, {dkeythor_data400__key__ebr__2000_trade__file_number 													}, '~prte::key::ebr::' + pIndexVersion + '::2000_trade::file_number');
	kkeythor_data400__key__ebr__2015_trade_payment_totals__file_number 					  := index(dkeythor_data400__key__ebr__2015_trade_payment_totals__file_number 					, {file_number}	, {dkeythor_data400__key__ebr__2015_trade_payment_totals__file_number 					}, '~prte::key::ebr::' + pIndexVersion + '::2015_trade_payment_totals::file_number');
	kkeythor_data400__key__ebr__2020_trade_payment_trends__file_number 						:= index(dkeythor_data400__key__ebr__2020_trade_payment_trends__file_number 					, {file_number}	, {dkeythor_data400__key__ebr__2020_trade_payment_trends__file_number 					}, '~prte::key::ebr::' + pIndexVersion + '::2020_trade_payment_trends::file_number');
	kkeythor_data400__key__ebr__2025_trade_quarterly_averages__file_number 				:= index(dkeythor_data400__key__ebr__2025_trade_quarterly_averages__file_number 			, {file_number}	, {dkeythor_data400__key__ebr__2025_trade_quarterly_averages__file_number 			}, '~prte::key::ebr::' + pIndexVersion + '::2025_trade_quarterly_averages::file_number');
	kkeythor_data400__key__ebr__4010_bankruptcy__file_number 											:= index(dkeythor_data400__key__ebr__4010_bankruptcy__file_number 										, {file_number}	, {dkeythor_data400__key__ebr__4010_bankruptcy__file_number 										}, '~prte::key::ebr::' + pIndexVersion + '::4010_bankruptcy::file_number');
	kkeythor_data400__key__ebr__4020_tax_liens__file_number 										  := index(dkeythor_data400__key__ebr__4020_tax_liens__file_number 											, {file_number}	, {dkeythor_data400__key__ebr__4020_tax_liens__file_number 											}, '~prte::key::ebr::' + pIndexVersion + '::4020_tax_liens::file_number');
	kkeythor_data400__key__ebr__4030_judgement__file_number 										  := index(dkeythor_data400__key__ebr__4030_judgement__file_number 											, {file_number}	, {dkeythor_data400__key__ebr__4030_judgement__file_number 											}, '~prte::key::ebr::' + pIndexVersion + '::4030_judgement::file_number');
	kkeythor_data400__key__ebr__4500_collateral_accounts__file_number 					  := index(dkeythor_data400__key__ebr__4500_collateral_accounts__file_number 						, {file_number}	, {dkeythor_data400__key__ebr__4500_collateral_accounts__file_number 						}, '~prte::key::ebr::' + pIndexVersion + '::4500_collateral_accounts::file_number');
	kkeythor_data400__key__ebr__4510_ucc_filings__bdid				 									  := index(dkeythor_data400__key__ebr__4510_ucc_filings__bdid				 										, {bdid}				, {dkeythor_data400__key__ebr__4510_ucc_filings__bdid 													}, '~prte::key::ebr::' + pIndexVersion + '::4510_ucc_filings::bdid');
	kkeythor_data400__key__ebr__4510_ucc_filings__file_number 									  := index(dkeythor_data400__key__ebr__4510_ucc_filings__file_number 										, {file_number}	, {dkeythor_data400__key__ebr__4510_ucc_filings__file_number 										}, '~prte::key::ebr::' + pIndexVersion + '::4510_ucc_filings::file_number');
	kkeythor_data400__key__ebr__4510_ucc_filings__linkids			 									  := index(dkeythor_data400__key__ebr__4510_ucc_filings__linkids												, {ultid,orgid,proxid,powid,empid,dotid,ultscore,orgscore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,proxweight,powweight,empweight,dotweight},{dkeythor_data400__key__ebr__4510_ucc_filings__linkids}, '~prte::key::ebr::' + pIndexVersion + '::4510_ucc_filings::linkids');	
	kkeythor_data400__key__ebr__5000_bank_details__file_number 										:= index(dkeythor_data400__key__ebr__5000_bank_details__file_number 									, {file_number}	, {dkeythor_data400__key__ebr__5000_bank_details__file_number 									}, '~prte::key::ebr::' + pIndexVersion + '::5000_bank_details::file_number');
	kkeythor_data400__key__ebr__5600_demographic_data__bdid 											:= index(dkeythor_data400__key__ebr__5600_demographic_data__bdid 											, {bdid}				, {dkeythor_data400__key__ebr__5600_demographic_data__bdid 											}, '~prte::key::ebr::' + pIndexVersion + '::5600_demographic_data::bdid');
	kkeythor_data400__key__ebr__5600_demographic_data__file_number 								:= index(dkeythor_data400__key__ebr__5600_demographic_data__file_number 							, {file_number}	, {dkeythor_data400__key__ebr__5600_demographic_data__file_number 							}, '~prte::key::ebr::' + pIndexVersion + '::5600_demographic_data::file_number');	
	kkeythor_data400__key__ebr__5600_demographic_data__linkids		 								:= index(dkeythor_data400__key__ebr__5600_demographic_data__linkids			 							, {ultid,orgid,proxid,powid,empid,dotid,ultscore,orgscore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,proxweight,powweight,empweight,dotweight},{dkeythor_data400__key__ebr__5600_demographic_data__linkids}, '~prte::key::ebr::' + pIndexVersion + '::5600_demographic_data::linkids');
	kkeythor_data400__key__ebr__5610_demographic_data__did 												:= index(dkeythor_data400__key__ebr__5610_demographic_data__did 											, {did}					, {dkeythor_data400__key__ebr__5610_demographic_data__did 											}, '~prte::key::ebr::' + pIndexVersion + '::5610_demographic_data::did');
	kkeythor_data400__key__ebr__5610_demographic_data__file_number 								:= index(dkeythor_data400__key__ebr__5610_demographic_data__file_number			 					, {file_number}	, {dkeythor_data400__key__ebr__5610_demographic_data__file_number								}, '~prte::key::ebr::' + pIndexVersion + '::5610_demographic_data::file_number');	
	kkeythor_data400__key__ebr__5610_demographic_data__linkids		 								:= index(dkeythor_data400__key__ebr__5610_demographic_data__linkids			 							, {ultid,orgid,proxid,powid,empid,dotid,ultscore,orgscore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,proxweight,powweight,empweight,dotweight},{dkeythor_data400__key__ebr__5610_demographic_data__linkids}, '~prte::key::ebr::' + pIndexVersion + '::5610_demographic_data::linkids');	
	kkeythor_data400__key__ebr__5610_demographic_data__ssn				 								:= index(dkeythor_data400__key__ebr__5610_demographic_data__ssn					 							, {ssn}					, {dkeythor_data400__key__ebr__5610_demographic_data__ssn					 							}, '~prte::key::ebr::' + pIndexVersion + '::5610_demographic_data::ssn');
	kkeythor_data400__key__ebr__6000_inquiries__file_number 										  := index(dkeythor_data400__key__ebr__6000_inquiries__file_number 											, {file_number}	, {dkeythor_data400__key__ebr__6000_inquiries__file_number 											}, '~prte::key::ebr::' + pIndexVersion + '::6000_inquiries::file_number');
	kkeythor_data400__key__ebr__6500_government_trade__file_number 								:= index(dkeythor_data400__key__ebr__6500_government_trade__file_number 							, {file_number}	, {dkeythor_data400__key__ebr__6500_government_trade__file_number 							}, '~prte::key::ebr::' + pIndexVersion + '::6500_government_trade::file_number');
	kkeythor_data400__key__ebr__6510_government_debarred_contractor__file_number  := index(dkeythor_data400__key__ebr__6510_government_debarred_contractor__file_number , {file_number}	, {dkeythor_data400__key__ebr__6510_government_debarred_contractor__file_number }, '~prte::key::ebr::' + pIndexVersion + '::6510_government_debarred_contractor::file_number');
	kkeythor_data400__key__ebr__7010_snp_data__file_number 											  := index(dkeythor_data400__key__ebr__7010_snp_data__file_number 											, {file_number}	, {dkeythor_data400__key__ebr__7010_snp_data__file_number 											}, '~prte::key::ebr::' + pIndexVersion + '::7010_snp_data::file_number');
	kkeythor_data400__key__ebr__autokey_addressb															  	:= index(dkeythor_data400__key__ebr__autokey_addressb																	,	{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__ebr__autokey_addressb}, '~prte::key::ebr::' + pIndexVersion + '::autokey::addressb');
	kkeythor_data400__key__ebr__autokey_citystnameb																:= index(dkeythor_data400__key__ebr__autokey_citystnameb															, {city_code,st,cname_indic,cname_sec,bdid},{dkeythor_data400__key__ebr__autokey_citystnameb}, '~prte::key::ebr::' + pIndexVersion + '::autokey::citystnameb');											 
	kkeythor_data400__key__ebr__autokey_nameb																			:= index(dkeythor_data400__key__ebr__autokey_nameb																		, {cname_indic,cname_sec,bdid}						 ,{dkeythor_data400__key__ebr__autokey_nameb}, '~prte::key::ebr::' + pIndexVersion + '::autokey::nameb');
	kkeythor_data400__key__ebr__autokey_namewords																	:= index(dkeythor_data400__key__ebr__autokey_namewords																, {word,state,seq,bdid}			 							 ,{dkeythor_data400__key__ebr__autokey_namewords}, '~prte::key::ebr::' + pIndexVersion + '::autokey::namewords');
	kkeythor_data400__key__ebr__autokey_payload																		:= index(dkeythor_data400__key__ebr__autokey_payload																	, {fakeid}																 ,{dkeythor_data400__key__ebr__autokey_payload}, '~prte::key::ebr::' + pIndexVersion + '::autokey::payload');
	kkeythor_data400__key__ebr__autokey_phoneb																		:= index(dkeythor_data400__key__ebr__autokey_phoneb																		, {p7,p3,cname_indic,cname_sec,st,bdid}		 ,{dkeythor_data400__key__ebr__autokey_phoneb}, '~prte::key::ebr::' + pIndexVersion + '::autokey::phoneb');
	kkeythor_data400__key__ebr__autokey_stnameb																		:= index(dkeythor_data400__key__ebr__autokey_stnameb																	, {st,cname_indic,cname_sec,bdid}					 ,{dkeythor_data400__key__ebr__autokey_stnameb}, '~prte::key::ebr::' + pIndexVersion + '::autokey::stnameb');
	kkeythor_data400__key__ebr__autokey_zipb																			:= index(dkeythor_data400__key__ebr__autokey_zipb																			, {zip,cname_indic,cname_sec,bdid}				 ,{dkeythor_data400__key__ebr__autokey_zipb}, '~prte::key::ebr::' + pIndexVersion + '::autokey::zipb');											 

	return 
	sequential(
		parallel(
			 build(kkeythor_data400__key__ebr__0010_header__bdid 																	,update)
			,build(kkeythor_data400__key__ebr__0010_header__file_number 												 	,update)
			,build(kkeythor_data400__key__ebr__0010_header__linkids		  												 	,update)			
			,build(kkeythor_data400__key__ebr__1000_executive_summary__bdid 											,update)
			,build(kkeythor_data400__key__ebr__1000_executive_summary__file_number 								,update)
			,build(kkeythor_data400__key__ebr__1000_executive_summary__linkids		 								,update)						
			,build(kkeythor_data400__key__ebr__2000_trade__file_number 														,update)
			,build(kkeythor_data400__key__ebr__2015_trade_payment_totals__file_number 						,update)
			,build(kkeythor_data400__key__ebr__2020_trade_payment_trends__file_number 						,update)
			,build(kkeythor_data400__key__ebr__2025_trade_quarterly_averages__file_number 				,update)
			,build(kkeythor_data400__key__ebr__4010_bankruptcy__file_number 											,update)
			,build(kkeythor_data400__key__ebr__4020_tax_liens__file_number 												,update)
			,build(kkeythor_data400__key__ebr__4030_judgement__file_number 												,update)
			,build(kkeythor_data400__key__ebr__4500_collateral_accounts__file_number 							,update)
			,build(kkeythor_data400__key__ebr__4510_ucc_filings__bdid 														,update)
			,build(kkeythor_data400__key__ebr__4510_ucc_filings__file_number 											,update)
			,build(kkeythor_data400__key__ebr__4510_ucc_filings__linkids		 											,update)				
			,build(kkeythor_data400__key__ebr__5000_bank_details__file_number 										,update)
			,build(kkeythor_data400__key__ebr__5600_demographic_data__bdid 												,update)
			,build(kkeythor_data400__key__ebr__5600_demographic_data__file_number 								,update)
			,build(kkeythor_data400__key__ebr__5600_demographic_data__linkids			 								,update)			
			,build(kkeythor_data400__key__ebr__5610_demographic_data__did					 								,update)
			,build(kkeythor_data400__key__ebr__5610_demographic_data__file_number 								,update)
			,build(kkeythor_data400__key__ebr__5610_demographic_data__linkids			 								,update)
			,build(kkeythor_data400__key__ebr__5610_demographic_data__ssn					 								,update)			
			,build(kkeythor_data400__key__ebr__6000_inquiries__file_number 												,update)
			,build(kkeythor_data400__key__ebr__6500_government_trade__file_number 								,update)
			,build(kkeythor_data400__key__ebr__6510_government_debarred_contractor__file_number 	,update)
			,build(kkeythor_data400__key__ebr__7010_snp_data__file_number 												,update)
			,build(kkeythor_data400__key__ebr__autokey_addressb 																  ,update)
			,build(kkeythor_data400__key__ebr__autokey_citystnameb 																,update)								 
			,build(kkeythor_data400__key__ebr__autokey_nameb 																			,update)
			,build(kkeythor_data400__key__ebr__autokey_namewords 																	,update)
			,build(kkeythor_data400__key__ebr__autokey_payload 																		,update)
			,build(kkeythor_data400__key__ebr__autokey_phoneb 																		,update)			
			,build(kkeythor_data400__key__ebr__autokey_stnameb 																		,update)	 
			,build(kkeythor_data400__key__ebr__autokey_zipb  																			,update)
	
		,PRTE.UpdateVersion(
				'EBRKeys'													//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		) 	//end PRTE.UpdateVersion
		) 	//end parallel
		); 	//end sequential


end;