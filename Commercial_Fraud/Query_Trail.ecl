import corp2;

export Query_Trail(
	 string																							pBizName
	,set of string																			pCorp_keys				= []
	,string																							pCharter_Number		= ''
	,set of string																			pApp_ref_keys			= []
	,set of unsigned6																		pBdids						= []
	,set of unsigned6																		pDids							= []
	,set of unsigned8																		pAce_Aids					= []
	,dataset(Layouts.Base															) pDellOut					= files().Dell_out.built
	,dataset(layouts.Input.Dell												) pDellInput				= files().Input.Dell.sprayed
	,dataset(Layouts.OutAppend												) pDellOutAppend		= files().Dell_out_Append.built
	,dataset(Layouts.layaddr													) pAddressSummary		= files().address_summary.built
	,dataset(Layouts.laybus														) pBusinessSummary	= files().business_summary.built
	,dataset(Layouts.laycont													) pContactSummary		= files().contact_summary.built	
	,dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp2						= corp2.files().base.corp.qa	
	,dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pCorp2Cont				= corp2.files().base.cont.qa	
	,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorp2Events			= corp2.files().base.events.qa	
) :=
function

	dAggregateCorpV2Bdids		 			:= Persists().AggregateCorpV2Bdids				(vendor_id != '' and vendor_id in pCorp_keys);	
	dfSummarizeAddressCorpV2aid 	:= Persists().fSummarizeAddressCorpV2aid	((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in pBdids));
	dconty_find										:= pCorp2Cont															((corp_key != '' and Corp_key in pCorp_keys) or (bdid != 0 and bdid in pBdids) or (did != 0 and did in pdids) or (corp_orig_sos_charter_nbr != '' and corp_orig_sos_charter_nbr = pCharter_Number) or (corp_sos_charter_nbr != '' and corp_sos_charter_nbr = pCharter_Number));
	dDell_input_find							:= pDellInput															(App_ref_key != '',App_ref_key in pApp_ref_keys);
	dDell_out_find								:= pDellout																(rawfields.App_ref_key != '',rawfields.App_ref_key in pApp_ref_keys);
	dDell_out_Append_find					:= pDellOutAppend													(rawfields.App_ref_key != '',rawfields.App_ref_key in pApp_ref_keys);
	
	dset_bdids	:= set(dAggregateCorpV2Bdids			,bdid				) + pBdids		
	+ set(dDell_out_find,bdid);
	dset_dids		:= set(dconty_find								,did				) + pdids			
	+ set(dDell_out_find, summary_contact.did);
	
	set_aids 		:= set(dedup(dfSummarizeAddressCorpV2aid,address_id,all),address_id	) + pAce_Aids	
								+ set(dDell_out_find, ace_aid)
								;
	
	// Summary Files
	dAddressSummary_find	:= pAddressSummary	((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids) or (address_id in set_aids));
	set_extra_corp_keys := set(dAddressSummary_find,vendor_id);
	dBusinessSummary_find	:= pBusinessSummary	((vendor_id != '' and vendor_id in pCorp_keys + set_extra_corp_keys) or (bdid != 0 and bdid in dset_bdids));
	dContactSummary_find	:= pContactSummary	((vendor_id != '' and vendor_id in pCorp_keys + set_extra_corp_keys) or (bdid != 0 and bdid in dset_bdids) or (did != 0 and did in dset_dids));


	// CorpV2
	dcorpy_find	:= pCorp2				((pBizName != '' and pBizName = corp_legal_name) and (Corp_key != '' and Corp_key in pCorp_keys + set_extra_corp_keys) or (bdid != 0 and bdid in dset_bdids) or (corp_orig_sos_charter_nbr != '' and corp_orig_sos_charter_nbr = pCharter_Number) or (corp_sos_charter_nbr != '' and corp_sos_charter_nbr = pCharter_Number));
	devent_find	:= pCorp2Events	((Corp_key != '' and Corp_key in pCorp_keys + set_extra_corp_keys) or (bdid != 0 and bdid in dset_bdids) or (corp_sos_charter_nbr != '' and corp_sos_charter_nbr = pCharter_Number));
	
	// Persists
	dAggregateCorpV2Addresses	 		:= Persists().AggregateCorpV2Addresses		(vendor_id != '' and vendor_id in pCorp_keys);
	dAggregateCorpV2Contacts		 	:= Persists().AggregateCorpV2Contacts			((vendor_id != '' and vendor_id in pCorp_keys) or (did != 0 and did in dset_dids));	
	dAggregateCorpV2Events			 	:= Persists().AggregateCorpV2Events				(vendor_id != '' and vendor_id in pCorp_keys);
	dAggregateCorpV2EventsDerog 	:= Persists().AggregateCorpV2EventsDerog	(vendor_id != '' and vendor_id in pCorp_keys);
	dCountBankruptcyfBdid			 		:= Persists().CountBankruptcyfBdid				(id != 0 and id in dset_bdids	);
	dCountBankruptcyfDid				 	:= Persists().CountBankruptcyfDid				  (id != 0 and id in dset_dids	);
	dCountLJsfBdid							 	:= Persists().CountLJsfBdid							  (id != 0 and id in dset_bdids	);
	dCountLJsfDid							 		:= Persists().CountLJsfDid								(id != 0 and id in dset_dids	);
	dCountUCCfBdid							 	:= Persists().CountUCCfBdid								(id != 0 and id in dset_bdids	);
	dCountUCCfDid							 		:= Persists().CountUCCfDid								(id != 0 and id in dset_dids	);
	dfSummarizeAddress					 	:= Persists().fSummarizeAddress					  ((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids));
	dfSummarizeAddressCorpV2		 	:= Persists().fSummarizeAddressCorpV2		  ((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids));
	dfSummarizeBusiness				 		:= Persists().fSummarizeBusiness					((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids));
	dfSummarizeBusinessCorpV2	 		:= Persists().fSummarizeBusinessCorpV2		((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids));
	dSummarizeBusinessCorpV2Rollup	:= Persists().fSummarizeBusinessCorpV2Rollup		((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids));
	dSummarizeBusinessCorpV2Appends	:= Persists().fSummarizeBusinessCorpV2Appends		((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids));
	dfSummarizeContact					 	:= Persists().fSummarizeContact					  ((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids) or (did != 0 and did in dset_dids));
	dfSummarizeContactCorpV2		 	:= Persists().fSummarizeContactCorpV2			((vendor_id != '' and vendor_id in pCorp_keys) or (bdid != 0 and bdid in dset_bdids) or (did != 0 and did in dset_dids));
	dPrepAdvo									 		:= Persists().PrepAdvo										(ace_aid != 0 and ace_aid in set_aids);
	dPrepForeclosure						 	:= Persists().PrepForeclosure						  (ace_aid != 0 and ace_aid in set_aids);
	dPrepGong									 		:= Persists().PrepGong										(ace_aid != 0 and ace_aid in set_aids);
	dPrepPhonesPlus						 		:= Persists().PrepPhonesPlus							(ace_aid != 0 and ace_aid in set_aids);
	dPrepUSPIS_HotList					 	:= Persists().PrepUSPIS_HotList						(ace_aid != 0 and ace_aid in set_aids);
	
	dAddressSummary_other_biz_at_addresses							:= pAddressSummary	(address_id in set_aids);
	dAddressSummary_other_biz_at_addresses_unique				:= dedup(dAddressSummary_other_biz_at_addresses,source,vendor_id, all);
	dfSummarizeAddress_other_biz_at_addresses					 	:= Persists().fSummarizeAddress					  (address_id in set_aids);;
	dfSummarizeAddressCorpV2_other_biz_at_addresses		 	:= Persists().fSummarizeAddressCorpV2		  (address_id in set_aids);;
	dfSummarizeAddressCorpV2aid_other_biz_at_addresses	:= Persists().fSummarizeAddressCorpV2aid	(address_id in set_aids);;
	dAddressSummaryCorpV2aid_other_biz_at_addresses_unique	:= dedup(dfSummarizeAddressCorpV2aid_other_biz_at_addresses,source,vendor_id, all);

	// dell stuff
	dDellfStandardizeName	 				:= Persists().DellfStandardizeName			(rawfields.App_ref_key != '',rawfields.App_ref_key in pApp_ref_keys);
	dDellAppendIdsAid	 						:= Persists().DellAppendIdsAid					(rawfields.App_ref_key != '',rawfields.App_ref_key in pApp_ref_keys);
  dDellAppendIdsBdid 						:= Persists().DellAppendIdsBdid  				(rawfields.App_ref_key != '',rawfields.App_ref_key in pApp_ref_keys);
  DellAppendIdsBdid_dBdid_in_BizSumm						:= Persists().DellAppendIdsBdid_dBdid_in_BizSumm						(company_name = pBizName or (bdid != 0 and bdid in dset_bdids) or (App_ref_key != '' and App_ref_key in pApp_ref_keys));
  DellAppendIdsBdid_dBdid_Not_in_BizSumm				:= Persists().DellAppendIdsBdid_dBdid_Not_in_BizSumm				(company_name = pBizName or (bdid != 0 and bdid in dset_bdids) or (App_ref_key != '' and App_ref_key in pApp_ref_keys));
  DellAppendIdsBdid_dBdidOut_withoutbdid_all		:= Persists().DellAppendIdsBdid_dBdidOut_withoutbdid_all		(company_name = pBizName or (bdid != 0 and bdid in dset_bdids) or (App_ref_key != '' and App_ref_key in pApp_ref_keys));
  DellAppendIdsBdid_djoinCityState							:= Persists().DellAppendIdsBdid_djoinCityState							(company_name = pBizName or (bdid != 0 and bdid in dset_bdids) or (App_ref_key != '' and App_ref_key in pApp_ref_keys));
  DellAppendIdsBdid_djoinCityState_nomatches		:= Persists().DellAppendIdsBdid_djoinCityState_nomatches		(company_name = pBizName or (bdid != 0 and bdid in dset_bdids) or (App_ref_key != '' and App_ref_key in pApp_ref_keys));
  DellAppendIdsBdid_dBDidOut_sort								:= Persists().DellAppendIdsBdid_dBDidOut_sort								(company_name = pBizName or (bdid != 0 and bdid in dset_bdids) or (App_ref_key != '' and App_ref_key in pApp_ref_keys));
  DellAppendIdsBdid_dBDidOut_dedup							:= Persists().DellAppendIdsBdid_dBDidOut_dedup							(company_name = pBizName or (bdid != 0 and bdid in dset_bdids) or (App_ref_key != '' and App_ref_key in pApp_ref_keys));
  DellAppendIdsBdid_dAssignBdids								:= Persists().DellAppendIdsBdid_dAssignBdids								((bdid != 0 and bdid in dset_bdids) or (rawfields.App_ref_key != '' and rawfields.App_ref_key in pApp_ref_keys));
	dDellSummaryAppendsAddress	 	:= Persists().DellSummaryAppendsAddress	(rawfields.App_ref_key != '',rawfields.App_ref_key in pApp_ref_keys);
	dDellSummaryAppendsBusiness	 	:= Persists().DellSummaryAppendsBusiness(rawfields.App_ref_key != '',rawfields.App_ref_key in pApp_ref_keys);
	dDellSummaryAppendsContact	 	:= Persists().DellSummaryAppendsContact	(rawfields.App_ref_key != '',rawfields.App_ref_key in pApp_ref_keys);
	dfCorpV2UniqueNameCityState		:= Persists().fCorpV2UniqueNameCityState(corp_legal_name = pBizName or (corp_key != '' and corp_key in pCorp_keys) or (bdid != 0 and bdid in dset_bdids));
	
	returnjob := parallel(
		 output('Looking for \'' + pBizName + '\' in All Comm Fraud Files')
		,output('Ids Used',named('_'))
		,output(pCorp_keys				,named('pCorp_keys'			))
		,output(pCharter_Number	,named('pCharter_Number'))
		,output(dset_bdids			,named('dset_bdids'			))
		,output(dset_dids				,named('dset_dids'			))
		,output(set_aids 				,named('set_aids'				))
		// CorpV2 
		,output('Query CorpV2 Files',named('__'))
		,output(dcorpy_find			,named('dcorpy_find'),all)
		,output(dconty_find			,named('dconty_find'),all)
		,output(devent_find			,named('devent_find'),all)
	// Summary Files
		,output('Query Summary Files',named('___'))
		,output(dAddressSummary_find		,named('dAddressSummary_find'),all)
		,output(dBusinessSummary_find		,named('dBusinessSummary_find'),all)
		,output(dContactSummary_find		,named('dContactSummary_find'),all)
	// Dell Files
		,output('Query Dell Files',named('____'))
		,output(dDell_input_find				,named('dDell_input_find'					),all)
		,output(dDell_out_find					,named('dDell_out_find'					),all)
		,output(dDell_out_Append_find		,named('dDell_out_Append_find'	),all)
		,output(dDellfStandardizeName						,named('dDellfStandardizeName'	 				),all)
		,output(dDellAppendIdsAid	 							,named('dDellAppendIdsAid'	 				),all)
		,output(dDellAppendIdsBdid 							,named('dDellAppendIdsBdid' 				),all)
		,output(DellAppendIdsBdid_dBdid_in_BizSumm							,named('DellAppendIdsBdid_dBdid_in_BizSumm'					 				),all)
		,output(DellAppendIdsBdid_dBdid_Not_in_BizSumm					,named('DellAppendIdsBdid_dBdid_Not_in_BizSumm'			 				),all)
		,output(DellAppendIdsBdid_dBdidOut_withoutbdid_all			,named('DellAppendIdsBdid_dBdidOut_withoutbdid_all'	 				),all)
		,output(DellAppendIdsBdid_djoinCityState								,named('DellAppendIdsBdid_djoinCityState'						 				),all)
		,output(DellAppendIdsBdid_djoinCityState_nomatches			,named('DellAppendIdsBdid_djoinCityState_nomatches'	 				),all)
		,output(DellAppendIdsBdid_dBDidOut_sort									,named('DellAppendIdsBdid_dBDidOut_sort'							 			),all)
		,output(DellAppendIdsBdid_dBDidOut_dedup								,named('DellAppendIdsBdid_dBDidOut_dedup'						 				),all)
		,output(DellAppendIdsBdid_dAssignBdids									,named('DellAppendIdsBdid_dAssignBdids'							 				),all)
		,output(dDellSummaryAppendsAddress			,named('dDellSummaryAppendsAddress'	),all)
		,output(dDellSummaryAppendsBusiness			,named('dDellSummaryAppendsBusiness'),all)
		,output(dDellSummaryAppendsContact			,named('dDellSummaryAppendsContact'	),all)
		,output(dfCorpV2UniqueNameCityState			,named('dfCorpV2UniqueNameCityState'	),all)
	
	// Persists
		,output('Query Persists',named('_____'))
		,output(dAggregateCorpV2Addresses	 		,named('dAggregateCorpV2Addresses'	),all)
		,output(dAggregateCorpV2Bdids		 			,named('dAggregateCorpV2Bdids'		 	),all)
		,output(dAggregateCorpV2Contacts			,named('dAggregateCorpV2Contacts'		),all)
		,output(dAggregateCorpV2Events				,named('dAggregateCorpV2Events'			),all)
		,output(dAggregateCorpV2EventsDerog 	,named('dAggregateCorpV2EventsDerog'),all)
		,output(dCountBankruptcyfBdid			 		,named('dCountBankruptcyfBdid'			),all)
		,output(dCountBankruptcyfDid					,named('dCountBankruptcyfDid'				),all)
		,output(dCountLJsfBdid								,named('dCountLJsfBdid'							),all)
		,output(dCountLJsfDid							 		,named('dCountLJsfDid'							),all)
		,output(dCountUCCfBdid								,named('dCountUCCfBdid'							),all)
		,output(dCountUCCfDid							 		,named('dCountUCCfDid'							),all)
		,output(dfSummarizeAddress						,named('dfSummarizeAddress'					),all)
		,output(dfSummarizeAddressCorpV2			,named('dfSummarizeAddressCorpV2'		),all)
		,output(dfSummarizeAddressCorpV2aid 	,named('dfSummarizeAddressCorpV2aid'),all)
		,output(dfSummarizeBusiness				 		,named('dfSummarizeBusiness'				),all)
		,output(dfSummarizeBusinessCorpV2	 		,named('dfSummarizeBusinessCorpV2' 	),all)
		,output(dSummarizeBusinessCorpV2Rollup		 		,named('dSummarizeBusinessCorpV2Rollup' 	),all)
		,output(dSummarizeBusinessCorpV2Appends		 		,named('dSummarizeBusinessCorpV2Appends' 	),all)
		,output(dfSummarizeContact						,named('dfSummarizeContact'					),all)
		,output(dfSummarizeContactCorpV2			,named('dfSummarizeContactCorpV2'		),all)
		,output(dPrepAdvo									 		,named('dPrepAdvo'									),all)
		,output(dPrepForeclosure							,named('dPrepForeclosure'						),all)
		,output(dPrepGong									 		,named('dPrepGong'									),all)
		,output(dPrepPhonesPlus						 		,named('dPrepPhonesPlus'						),all)
		,output(dPrepUSPIS_HotList						,named('dPrepUSPIS_HotList'					),all)
		,output(dAddressSummary_other_biz_at_addresses						,named('dAddressSummary_other_biz_at_addresses'					),all)
		,output(dAddressSummary_other_biz_at_addresses_unique			,named('dAddressSummary_other_biz_at_addresses_unique'	),all)
		,output(dfSummarizeAddress_other_biz_at_addresses					,named('dfSummarizeAddress_other_biz_at_addresses'			),all)
		,output(dfSummarizeAddressCorpV2_other_biz_at_addresses		,named('dfSummarizeAddressCorpV2_other_biz_at_addresses'),all)
		,output(dfSummarizeAddressCorpV2aid_other_biz_at_addresses		,named('dfSummarizeAddressCorpV2aid_other_biz_at_addresses'),all)
		,output(dAddressSummaryCorpV2aid_other_biz_at_addresses_unique		,named('dAddressSummaryCorpV2aid_other_biz_at_addresses_unique'),all)
	);

	return returnjob;

end;