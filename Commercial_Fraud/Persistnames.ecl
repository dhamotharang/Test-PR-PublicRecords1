import versioncontrol;

export Persistnames(

	boolean	pUseOtherEnvironment = false

) :=
module

	export lPersistTemplate 	:= _dataset(pUseOtherEnvironment).thor_cluster_persists + 'persist::' + _Dataset().name + '::'						;

	export AggregateCorpV2Addresses				:= lPersistTemplate + 'Aggregate_CorpV2_Addresses'										;
	export AggregateCorpV2Bdids						:= lPersistTemplate + 'Aggregate_CorpV2_Bdids'												;
	export AggregateCorpV2Contacts				:= lPersistTemplate + 'Aggregate_CorpV2_Contacts'											;
	export AggregateCorpV2Events					:= lPersistTemplate + 'Aggregate_CorpV2_Events'												;
	export AggregateCorpV2EventsDerog			:= lPersistTemplate + 'Aggregate_CorpV2_Events.Derog'									;
	export CountBankruptcyfBdid						:= lPersistTemplate + 'Count_Bankruptcy.fBdid'												;
	export CountBankruptcyfDid						:= lPersistTemplate + 'Count_Bankruptcy.fDid'													;
	export CountLJsfBdid									:= lPersistTemplate + 'Count_LJs.fBdid'																;
	export CountLJsfDid										:= lPersistTemplate + 'Count_LJs.fDid'																;
	export CountUCCfBdid									:= lPersistTemplate + 'Count_UCC.fBdid'																;
	export CountUCCfDid										:= lPersistTemplate + 'Count_UCC.fDid'																;
	export fSummarizeAddress							:= lPersistTemplate + 'fSummarize_Address'														;
	export fSummarizeAddressCorpV2				:= lPersistTemplate + 'fSummarize_Address_CorpV2'											;
	export fSummarizeAddressCorpV2Append		:= lPersistTemplate + 'fSummarize_Address_CorpV2_Append'											;
	export fSummarizeAddressCorpV2aid			:= lPersistTemplate + 'fSummarize_Address_CorpV2.aid'									;
	export fSummarizeBusiness							:= lPersistTemplate + 'fSummarize_Business'														;
	export fSummarizeBusinessCorpV2				:= lPersistTemplate + 'fSummarize_Business_CorpV2'										;
	export fSummarizeBusinessCorpV2Rollup		:= lPersistTemplate + 'fSummarize_Business_CorpV2_rollup'		;
	export fSummarizeBusinessCorpV2Appends	:= lPersistTemplate + 'fSummarize_Business_CorpV2_Appends'		;
	export fSummarizeContact							:= lPersistTemplate + 'fSummarize_Contact'														;
	export fSummarizeContactCorpV2				:= lPersistTemplate + 'fSummarize_Contact_CorpV2'											;
	export DellfStandardizeName						:= lPersistTemplate + 'Dell_Standardize_Input.fStandardizeName'				;
	export DellAppendIdsAid								:= lPersistTemplate + 'Dell_Append_Ids.fAppendAid'										;
	export DellAppendIdsBdid							:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid'										;
	export DellAppendIdsBdid_dBdid_in_BizSumm							:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid.dBdid_in_BizSumm'					;
	export DellAppendIdsBdid_dBdid_Not_in_BizSumm					:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid.dBdid_Not_in_BizSumm'			;
	export DellAppendIdsBdid_dBdidOut_withoutbdid_all			:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid.dBdidOut_withoutbdid_all'	;
	export DellAppendIdsBdid_djoinCityState								:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid.djoinCityState'						;
	export DellAppendIdsBdid_djoinCityState_nomatches			:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid.djoinCityState_nomatches'	;
	export DellAppendIdsBdid_dBDidOut_sort								:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid.dBDidOut_sort'							;
	export DellAppendIdsBdid_dBDidOut_dedup								:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid.dBDidOut_dedup'						;
	export DellAppendIdsBdid_dAssignBdids									:= lPersistTemplate + 'Dell_Append_Ids.fAppendBdid.dAssignBdids'							;
	export DellSummaryAppendsAddress			:= lPersistTemplate + 'Dell_Summary_Appends.fAppend_Address_Summary'	;
	export DellSummaryAppendsBusiness			:= lPersistTemplate + 'Dell_Summary_Appends.fAppend_Business_Summary'	;
	export DellSummaryAppendsContact			:= lPersistTemplate + 'Dell_Summary_Appends.fAppend_Contact_Summary'	;
//	export DellCountBizsatAddress					:= lPersistTemplate + 'DellCountBizsatAddress'	;
	export DellAppendMiscellaneous					:= lPersistTemplate + 'DellAppendMiscellaneous'	;
	export PrepAdvo												:= lPersistTemplate + 'PrepAdvo'																			;
	export PrepForeclosure								:= lPersistTemplate + 'PrepForeclosure'																;
	export PrepGong												:= lPersistTemplate + 'PrepGong'																			;
	export PrepPhonesPlus									:= lPersistTemplate + 'PrepPhonesPlus'																;
	export PrepUSPIS_HotList							:= lPersistTemplate + 'PrepUSPIS_HotList'															;
	export fCorpV2UniqueNameCityState			:= lPersistTemplate + 'fCorpV2_Unique_Name_City_State'								;
	
	export dAll_Filenames :=
	dataset([
	
				 {CountBankruptcyfBdid					}							
        ,{CountBankruptcyfDid						}							
        ,{CountLJsfBdid									}							
        ,{CountLJsfDid									}							
        ,{CountUCCfBdid									}							
        ,{CountUCCfDid									}							
        ,{fSummarizeAddress							}							
        ,{fSummarizeAddressCorpV2				}							
        ,{fSummarizeAddressCorpV2aid		}							
        ,{fSummarizeBusiness						}							
        ,{fSummarizeBusinessCorpV2Rollup	}						
        ,{fSummarizeBusinessCorpV2Appends}						
				,{fSummarizeContact							}
				,{fSummarizeContactCorpV2				}
				,{DellAppendIdsAid							}
				,{DellAppendIdsBdid							}
				,{DellSummaryAppendsAddress			}
				,{DellSummaryAppendsBusiness		}
				,{DellSummaryAppendsContact			}
				,{PrepAdvo											}
				,{PrepForeclosure								}
				,{PrepGong											}
				,{PrepPhonesPlus								}
				,{PrepUSPIS_HotList							}
				,{fCorpV2UniqueNameCityState		}
          
	], versioncontrol.Layout_Names)
	;

end;