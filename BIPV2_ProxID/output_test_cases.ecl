import Business_DOT_SALT_micro9;
EXPORT output_test_cases(
	 dataset(layout_DOT_Base)	pDataset
	,string										pConst		= ''		
) :=
function
	//put all test cases here
  dDataset            := project(pDataset ,transform({string srcvlid,recordof(pDataset)},self.srcvlid := trim(left.source,left,right) + '-' + trim((string)left.source_record_id,left,right) + '-' + trim(left.vl_id,left,right),self := left));
  setcommonsrcvlid    := set(topn(table(dDataset(source not in ['DN'],source != '',source_record_id != 0,vl_id != '') ,{srcvlid,unsigned8 cnt := count(group)},srcvlid),1,-cnt),srcvlid);
  
	dautozone 					:= pDataset(regexfind('\\<autozone\\>'                  ,company_name,nocase));
	dLexis							:= pDataset(Business_DOT_SALT_micro9.fn_isLNrec(company_name));
	dhooters 						:= pDataset(regexfind('\\<hooters\\>'                   ,company_name,nocase));
	dpaysource					:= pDataset(regexfind('\\<paysource'                    ,company_name,nocase));
	dWalmartBrandtPike	:= pDataset(regexfind('^wal[- ]?mart'		                ,trim(cnp_name),nocase));
	dCityDayton1013rd		:= pDataset(regexfind('^city of dayton$'                ,trim(company_name),nocase),trim(prim_range) = '101'	,trim(prim_name) = '3RD'		);
	dCityDayton3013rd		:= pDataset(regexfind('^city of dayton$'                ,trim(company_name),nocase),trim(prim_range) = '301'	,trim(prim_name) = '3RD'		);
	dCityDayton3353rd		:= pDataset(regexfind('^city of dayton police$'         ,trim(company_name),nocase),trim(prim_range) = '335'	,trim(prim_name) = '3RD'		);
	dnatlcity 					:= pDataset(regexfind('national city mortgage'          ,company_name,nocase));
	dchoicepoint 				:= pDataset(regexfind('(choicepoint|DBT|database techn)',company_name,nocase));
	dsears 				      := pDataset(regexfind('\\<sears'                        ,company_name,nocase));
	dMETRITEK			      := pDataset(regexfind('\\<METRITEK'                     ,company_name,nocase));
//	dsears 				      := pDataset(regexfind('(blue martini|ecometry|escalate|smith gardner)',company_name,nocase));
//	dsears 				      := pDataset(regexfind('office depot',company_name,nocase));
//	dsears 				      := pDataset(regexfind('siemens',company_name,nocase));
//	dsears 				      := pDataset(regexfind('CHARLES F KETTERING',company_name,nocase));
  dtopsrcvlids        := dDataset(srcvlid in setcommonsrcvlid);
	setautozoneProxids 						:= set(dedup(dautozone 					,proxid,all)	 ,proxid);	
	setLexisProxids								:= set(dedup(dLexis							,proxid,all)	 ,proxid);	 
	sethootersProxids 						:= set(dedup(dhooters 					,proxid,all)	 ,proxid);	 
	setpaysourceProxids						:= set(dedup(dpaysource					,proxid,all)	 ,proxid);
	setWalmartBrandtPikeProxids		:= set(dedup(dWalmartBrandtPike	,proxid,all)	 ,proxid);	
	setCityDayton1013rdProxids		:= set(dedup(dCityDayton1013rd	,proxid,all)	 ,proxid);	 
	setCityDayton3013rdProxids		:= set(dedup(dCityDayton3013rd	,proxid,all)	 ,proxid);	 
	setCityDayton3353rdProxids		:= set(dedup(dCityDayton3353rd	,proxid,all)	 ,proxid);
	setdnatlcityProxids		        := set(dedup(dnatlcity        	,proxid,all)	 ,proxid);
	setdchoicepointProxids		    := set(dedup(dchoicepoint       ,proxid,all)	 ,proxid);
	setdsearsProxids		          := set(dedup(dsears        	    ,proxid,all)	 ,proxid);
	setdMETRITEKProxids		        := set(dedup(dMETRITEK        	,proxid,all)	 ,proxid);
	settopsrcvlids    		        := set(dedup(dtopsrcvlids        	,proxid,all)	 ,proxid);
	
	dAggOverall_raw := AggregateProxidElements(pDataset);
	dAggOverall	:= project(dAggOverall_raw	,transform(recordof(dAggOverall_raw)	
	,self.company_names		          := sort(left.company_names		,company_name		)
	,self.cnp_names				          := sort(left.cnp_names				,cnp_name				)
//	,self.corp_legal_names          := sort(left.corp_legal_names				,corp_legal_name				)
	,self.addresss				          := sort(left.addresss				,address				)
	,self.contacts				          := sort(left.contacts				,contact				)
	,self.sources				 	          := sort(left.sources				,source				)
	,self.vl_ids				 	          := sort(left.vl_ids				,vl_id				)
	,self.active_domestic_corp_keys	:= sort(left.active_domestic_corp_keys				,active_domestic_corp_key				)
	,self := left
	));
	dAggOverallautozoneProxids 						:= dAggOverall(proxid in setautozoneProxids 					);
	dAggOverallLexisProxids								:= dAggOverall(proxid in setLexisProxids							);
	dAggOverallhootersProxids 						:= dAggOverall(proxid in sethootersProxids 						);
	dAggOverallpaysourceProxids						:= dAggOverall(proxid in setpaysourceProxids					);
	dAggOverallWalmartBrandtPikeProxids		:= dAggOverall(proxid in setWalmartBrandtPikeProxids	);
	dAggOverallCityDayton1013rdProxids		:= dAggOverall(proxid in setCityDayton1013rdProxids		);
	dAggOverallCityDayton3013rdProxids		:= dAggOverall(proxid in setCityDayton3013rdProxids		);
	dAggOverallCityDayton3353rdProxids		:= dAggOverall(proxid in setCityDayton3353rdProxids		);
	dAggOverallNatlCityProxids		        := dAggOverall(proxid in setdnatlcityProxids		      );
	dAggOverallChoicepointProxids		      := dAggOverall(proxid in setdchoicepointProxids	      );
	dAggOverallsearsProxids		            := dAggOverall(proxid in setdsearsProxids	            );
	dAggOverallMetritekProxids		        := dAggOverall(proxid in setdMETRITEKProxids	        );
	dAggOveralltopsrcvlidsProxids		      := dAggOverall(proxid in settopsrcvlids	      );
	dSortAllcompany_name 						  := sort(dAggOverall(trim(company_names[1].company_name) != '')					,company_names[1].company_name,addresss[1].address);
	dSortAllcnp_name		 						  := sort(dAggOverall(trim(cnp_names[1].cnp_name) != '') 									,cnp_names[1].cnp_name,addresss[1].address);
//	dSortAllcorp_legal_name		 				:= sort(dAggOverall(trim(corp_legal_names[1].corp_legal_name) != '') 									,corp_legal_names[1].corp_legal_name,addresss[1].address);
	dSortAlladdress			 						  := sort(dAggOverall(trim(addresss[1].address) != '') 										,addresss[1].address,company_names[1].company_name);
	dSortAllactive_enterprise_number  := sort(dAggOverall((unsigned)active_enterprise_numbers[1].active_enterprise_number != 0) 	,active_enterprise_numbers[1].active_enterprise_number,active_enterprise_numbers[1].active_enterprise_number);
	dSortAllduns_number 						  := sort(dAggOverall((unsigned)active_duns_numbers[1].active_duns_number != 0)					,active_duns_numbers[1].active_duns_number);
	dSortAllactive_domestic_corp_key  := sort(dAggOverall((unsigned)active_domestic_corp_keys[1].active_domestic_corp_key != 0) 	,active_domestic_corp_keys[1].active_domestic_corp_key,active_domestic_corp_keys[1].active_domestic_corp_key);
	dSortAllfein 										  := sort(dAggOverall((unsigned)feins[1].fein != 0)												,feins[1].fein);
	dSortMostcompany_name 					  := sort(dAggOverall(count(company_names		) > 1) 			,-count(company_names		));
	dSortMostcnp_name		 						  := sort(dAggOverall(count(cnp_names				) > 1) 			,-count(cnp_names				));
//	dSortMostcorp_legal_name		 	    := sort(dAggOverall(count(corp_legal_names				  ) > 1) 			,-count(corp_legal_names				  ));
	dSortMostaddress			 					  := sort(dAggOverall(count(addresss				          ) > 1) 			,-count(addresss				          ));
	dSortMostactive_enterprise_number := sort(dAggOverall(count(active_enterprise_numbers	) > 1) 			,-count(active_enterprise_numbers	));
	dSortMostduns_number 						  := sort(dAggOverall(count(active_duns_numbers		    ) > 1) 			,-count(active_duns_numbers		    ));
	dSortMostactive_domestic_corp_key := sort(dAggOverall(count(active_domestic_corp_keys	) > 1) 			,-count(active_domestic_corp_keys	));
	dSortMostfein 									  := sort(dAggOverall(count(feins						          ) > 1) 			,-count(feins						          ));
	dSortMostCnt	 									  := sort(dAggOverall 			,-cnt										 );
	dSortLeastCnt	 									  := sort(dAggOverall 			,cnt										 );
	dBlankCompanyName 							:= sort(dAggOverall(trim(company_names    [1].company_name    ) = '')																								,addresss			[1].address			);
	dBlankdbaname										:= sort(dAggOverall(trim(cnp_names		    [1].cnp_name		    ) = '' and trim(company_names[1].company_name) != '')	,addresss			[1].address			);
//	dBlankcorp_legal_name						:= sort(dAggOverall(trim(corp_legal_names	[1].corp_legal_name	) = '' and trim(company_names[1].company_name) != '')	,addresss			[1].address			);
	dBlankAddress			 							:= sort(dAggOverall(trim(addresss			    [1].address			    ) = '')																								,company_names[1].company_name);
	dSortautozoneProxids 						:= sort(dAggOverallautozoneProxids 					,addresss[1].address,company_names[1].company_name);
	dSortLexisProxids								:= sort(dAggOverallLexisProxids							,addresss[1].address,company_names[1].company_name);
	dSorthootersProxids 						:= sort(dAggOverallhootersProxids 					,addresss[1].address,company_names[1].company_name);
	dSortpaysourceProxids						:= sort(dAggOverallpaysourceProxids					,addresss[1].address,company_names[1].company_name);
	dSortWalmartBrandtPikeProxids		:= sort(dAggOverallWalmartBrandtPikeProxids	,addresss[1].address,company_names[1].company_name);
	dSortCityDayton1013rdProxids		:= sort(dAggOverallCityDayton1013rdProxids	,addresss[1].address,company_names[1].company_name);
	dSortCityDayton3013rdProxids		:= sort(dAggOverallCityDayton3013rdProxids	,addresss[1].address,company_names[1].company_name);
	dSortCityDayton3353rdProxids		:= sort(dAggOverallCityDayton3353rdProxids	,addresss[1].address,company_names[1].company_name);
	dSortNatlCityProxids		        := sort(dAggOverallNatlCityProxids        	,addresss[1].address,company_names[1].company_name);
	dSortChoicepointProxids		      := sort(dAggOverallChoicepointProxids      	,addresss[1].address,company_names[1].company_name);
	dSortsearsProxids		            := sort(dAggOverallsearsProxids      	      ,addresss[1].address,company_names[1].company_name);
	dSortMetritekProxids		        := sort(dAggOverallMetritekProxids      	  ,addresss[1].address,company_names[1].company_name);
	dSortTopSrcVlidsProxids		        := project(sort(dAggOveralltopsrcvlidsProxids      	,srcvlids[1].srcvlid,addresss[1].address,company_names[1].company_name),transform({string thevlid,recordof(dAggOveralltopsrcvlidsProxids)}  ,self.thevlid := setcommonsrcvlid[1],self := left));
	return parallel(
     output(count(pDataset )  ,named('CountRecords' + pConst))
    ,output(count(table(pDataset,{dotid},dotid ))  ,named('CountDOTids' + pConst))
    ,output(count(table(dAggOverall ,{proxid},proxid))  ,named('CountProxids' + pConst))
    ,output(100.0 - ((real8)count(table(dAggOverall ,{proxid},proxid)) / (real8)count(table(pDataset,{dotid},dotid )) * 100.0)  ,named('ProxidConvergence' + pConst))
		,output('Full Dataset rolled up follows:'							,named('_' + pConst												)		 )
		,output(choosen(dAggOverall										    ,100)	,named('Overall'	 + pConst									),all)
		,output(enth	 (dAggOverall										    ,100)	,named('OverallEnth'	 + pConst							),all)
		,output('Full Dataset sorted by different fields follows:'				,named('__'	 + pConst												)		 )
		,output(choosen(dSortAllcompany_name 					    ,100)	,named('SortedCompany_name'	            + pConst),all)
		,output(choosen(dSortAllcnp_name		 					    ,100)	,named('Sortedcnp_name'		              + pConst),all)
//		,output(choosen(dSortAllcorp_legal_name		 				,100)	,named('Sortedcorp_legal_name'		      + pConst),all)
		,output(choosen(dSortAlladdress			 					    ,100)	,named('SortedAddress'			            + pConst),all)
		,output(choosen(dSortAllactive_enterprise_number  ,100)	,named('Sortedactive_enterprise_number'	+ pConst),all)
		,output(choosen(dSortAllduns_number 					    ,100)	,named('SortedDuns_number'		          + pConst),all)
		,output(choosen(dSortAllactive_domestic_corp_key	,100)	,named('Sortedactive_domestic_corp_key'	+ pConst),all)
		,output(choosen(dSortAllfein 									    ,100)	,named('SortedFein'						          + pConst),all)
		,output('Full Dataset sorted by count of unique values in different fields follows:'				,named('___'	 + pConst												)		 )
		,output(choosen(dSortMostcompany_name 				        ,50)	,named('SortMostCompany_names' 	          + pConst		),all)
		,output(choosen(dSortMostcnp_name		 					        ,50)	,named('SortMostcnp_names'		 		        + pConst	),all)
//		,output(choosen(dSortMostcorp_legal_name		 					,50)	,named('SortMostcorp_legal_names'		 		  + pConst	),all)
		,output(choosen(dSortMostaddress			 				        ,50)	,named('SortMostAddresses'			 	        + pConst	),all)
		,output(choosen(dSortMostactive_enterprise_number 		,50)	,named('SortMostactive_enterprise_number'	+ pConst	),all)
		,output(choosen(dSortMostduns_number 					        ,50)	,named('SortMostDuns_numbers' 		        + pConst	),all)
		,output(choosen(dSortMostactive_domestic_corp_key 		,50)	,named('SortMostactive_domestic_corp_key'	+ pConst	),all)
		,output(choosen(dSortMostfein 								        ,50)	,named('SortMostFeins' 						        + pConst	),all)
		,output(choosen(dSortMostCnt 									        ,50)	,named('SortMostCnt' 							        + pConst	),all)
		,output(choosen(dSortLeastCnt 								        ,50)	,named('SortLeastCnt' 							      + pConst	),all)
		,output('Full dataset Filtered for Blank Fields Follows:'				,named('____'			 + pConst										)		 )
		,output(choosen(dBlankCompanyName 						,100)	,named('BlankCompanyNames'  	 + pConst		),all)
		,output(choosen(dBlankdbaname														,100)	,named('dBlankdbaname'			 	 + pConst		),all)
//		,output(choosen(dBlankcorp_legal_name										,100)	,named('dBlankcorp_legal_name'			 	 + pConst		),all)
		,output(choosen(dBlankAddress			 						,100)	,named('BlankAddresses'				  + pConst		),all)
		,output('Rolled Up View of Test Cases Follows'				,named('_____'										 + pConst			)		 )
		,output(choosen(dSortautozoneProxids 					,100)	,named('AutozoneProxids'					 + pConst	),all)
		,output(choosen(dSortLexisProxids							,100)	,named('LexisProxids'							 + pConst	),all)
		,output(choosen(dSorthootersProxids 					,100)	,named('HootersProxids' 					 + pConst	),all)
		,output(choosen(dSortpaysourceProxids					,100)	,named('PaysourceProxids'					 + pConst	),all)
		,output(choosen(dSortWalmartBrandtPikeProxids	,100)	,named('WalmartBrandtPikeProxids'	 + pConst	),all)
		,output(choosen(dSortCityDayton1013rdProxids	,100)	,named('CityDayton_101_3rdProxids'	 + pConst	),all)
		,output(choosen(dSortCityDayton3013rdProxids	,100)	,named('CityDayton_301_3rdProxids'	 + pConst	),all)
		,output(choosen(dSortCityDayton3353rdProxids	,100)	,named('CityDayton_335_3rdProxids'	 + pConst	),all)
		,output(choosen(dSortNatlCityProxids        	,100)	,named('NationalCityMortgageProxids'	 + pConst	),all)
		,output(choosen(dSortChoicepointProxids        	,100)	,named('ChoicepointProxids'	 + pConst	),all)
		,output(choosen(dSortsearsProxids        	,100)	,named('searsProxids'	 + pConst	),all)
		,output(choosen(dSortMetritekProxids        	,100)	,named('MetritekProxids'	 + pConst	),all)
 //   ,output(dAggOverall(count(dotids(dotid in [101164,76507,88437,3132,798189]))>0),named('LnFLVsGaInc'),all)
 //   ,output(dAggOverall(count(dotids(dotid in [35643 ,13299 ,3766672, 88424, 2130272]))>0),named('OtherExamples'),all)
  //  ,output(dAggOverall(count(dotids(dotid in [231513,574987]))>0) ,named('dotsfromTodd'),all)
    ,output(sum(dAggOverall_raw,cnt) / (real8)count(dAggOverall_raw)  ,named('AvgRecsPerProx'))
    ,output(count(table(pDataset,{dotid},dotid )) / (real8)count(dAggOverall_raw)  ,named('AvgDotsPerProx'))
    ,output(max(dAggOverall_raw,cnt_dotids) ,named('MaxDotsPerProx'))
    ,output(max(dAggOverall_raw,cnt) ,named('MaxRecsPerProx'))
		,output(choosen(dSortTopSrcVlidsProxids        	,100)	,named('TopSrcVlidProxids'	 + pConst	),all)
	);
	
end;
