import header;
export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module
	
	shared pname := Persistnames(pUseOtherEnvironment);
	
	export AggregateCorpV2Addresses2				:= Dataset(pname.AggregateCorpV2Addresses	 + '.fSummarize_Address_CorpV2_Append'		,layouts.temporary.AggregateCorpV2Addresses	,flat);
	export AggregateCorpV2Addresses				:= Dataset(pname.AggregateCorpV2Addresses			,layouts.temporary.AggregateCorpV2Addresses	,flat);
	export AggregateCorpV2Bdids						:= Dataset(pname.AggregateCorpV2Bdids					,layouts.temporary.AggregateCorpV2Bdids			,flat);
	export AggregateCorpV2Contacts				:= Dataset(pname.AggregateCorpV2Contacts			,layouts.temporary.AggregateCorpV2Contacts	,flat);
	export AggregateCorpV2Events					:= Dataset(pname.AggregateCorpV2Events				,layouts.temporary.AggregateCorpV2Events		,flat);
	export AggregateCorpV2EventsDerog			:= Dataset(pname.AggregateCorpV2EventsDerog		,layouts.temporary.AggregateCorpV2Events		,flat);
	export CountBankruptcyfBdid						:= Dataset(pname.CountBankruptcyfBdid					,Layouts.temporary.counts	,flat);
	export CountBankruptcyfDid						:= Dataset(pname.CountBankruptcyfDid					,Layouts.temporary.counts	,flat);
	export CountLJsfBdid									:= Dataset(pname.CountLJsfBdid								,Layouts.temporary.counts	,flat);
	export CountLJsfDid										:= Dataset(pname.CountLJsfDid									,Layouts.temporary.counts	,flat);
	export CountUCCfBdid									:= Dataset(pname.CountUCCfBdid								,Layouts.temporary.counts	,flat);
	export CountUCCfDid										:= Dataset(pname.CountUCCfDid									,Layouts.temporary.counts	,flat);
	export fSummarizeAddress							:= Dataset(pname.fSummarizeAddress						,Layouts.layaddr	,flat);
	export fSummarizeAddressCorpV2				:= Dataset(pname.fSummarizeAddressCorpV2			,layouts.temporary.addresssummary	,flat);
	export fSummarizeAddressCorpV2aid			:= Dataset(pname.fSummarizeAddressCorpV2aid		,layouts.temporary.addresssummary	,flat);
	export fSummarizeAddressCorpV2Append			:= Dataset(pname.fSummarizeAddressCorpV2Append		,layouts.temporary.BusinessSummary	,flat);
	export fSummarizeBusinessCorpV2Rollup		:= Dataset(pname.fSummarizeBusinessCorpV2Rollup		,layouts.temporary.BusinessSummary	,flat);
	export fSummarizeBusinessCorpV2Appends	:= Dataset(pname.fSummarizeBusinessCorpV2Appends	,layouts.temporary.BusinessSummary	,flat);
	export fSummarizeBusiness							:= Dataset(pname.fSummarizeBusiness						,Layouts.laybus	,flat);
	export fSummarizeBusinessCorpV2				:= Dataset(pname.fSummarizeBusinessCorpV2			,layouts.temporary.businesssummary,flat);
	export fSummarizeContact							:= Dataset(pname.fSummarizeContact						,Layouts.laycont	,flat);
	export fSummarizeContactCorpV2				:= Dataset(pname.fSummarizeContactCorpV2			,layouts.temporary.contactsummary	,flat);

	export DellfStandardizeName														:= Dataset(pname.DellfStandardizeName												,Layouts.Temporary.StandardizeInput	,flat);
	export DellAppendIdsAid																:= Dataset(pname.DellAppendIdsAid														,Layouts.Temporary.StandardizeInput	,flat);
	export DellAppendIdsBdid															:= Dataset(pname.DellAppendIdsBdid													,Layouts.Base												,flat);
	export DellAppendIdsBdid_dBdid_in_BizSumm							:= Dataset(pname.DellAppendIdsBdid_dBdid_in_BizSumm					,Layouts.Temporary.BdidSlim		,flat);
	export DellAppendIdsBdid_dBdid_Not_in_BizSumm					:= Dataset(pname.DellAppendIdsBdid_dBdid_Not_in_BizSumm			,Layouts.Temporary.BdidSlim		,flat);
	export DellAppendIdsBdid_dBdidOut_withoutbdid_all			:= Dataset(pname.DellAppendIdsBdid_dBdidOut_withoutbdid_all	,Layouts.Temporary.BdidSlim		,flat);
	export DellAppendIdsBdid_djoinCityState								:= Dataset(pname.DellAppendIdsBdid_djoinCityState						,Layouts.Temporary.BdidSlim		,flat);
	export DellAppendIdsBdid_djoinCityState_nomatches			:= Dataset(pname.DellAppendIdsBdid_djoinCityState_nomatches	,Layouts.Temporary.BdidSlim		,flat);
	export DellAppendIdsBdid_dBDidOut_sort								:= Dataset(pname.DellAppendIdsBdid_dBDidOut_sort						,Layouts.Temporary.BdidSlim		,flat);
	export DellAppendIdsBdid_dBDidOut_dedup								:= Dataset(pname.DellAppendIdsBdid_dBDidOut_dedup						,Layouts.Temporary.BdidSlim		,flat);
	export DellAppendIdsBdid_dAssignBdids									:= Dataset(pname.DellAppendIdsBdid_dAssignBdids							,Layouts.Base									,flat);

	export DellSummaryAppendsAddress											:= Dataset(pname.DellSummaryAppendsAddress									,Layouts.Base												,flat);
	export DellSummaryAppendsBusiness											:= Dataset(pname.DellSummaryAppendsBusiness									,Layouts.Base												,flat);
	export DellSummaryAppendsContact											:= Dataset(pname.DellSummaryAppendsContact									,Layouts.Base												,flat);
//	export DellCountBizsatAddress													:= Dataset(pname.DellCountBizsatAddress											,Layouts.Base												,flat);
	export DellAppendMiscellaneous												:= Dataset(pname.DellAppendMiscellaneous										,Layouts.Base												,flat);

	export PrepAdvo												:= Dataset(pname.PrepAdvo							,Layouts.Temporary.PrepAdvo					,flat);
	export PrepForeclosure								:= Dataset(pname.PrepForeclosure			,Layouts.Temporary.PrepForeclosure	,flat);
	export PrepGong												:= Dataset(pname.PrepGong							,Layouts.Temporary.PrepPhonesPlus		,flat);
	export PrepPhonesPlus									:= Dataset(pname.PrepPhonesPlus				,Layouts.Temporary.PrepPhonesPlus		,flat);
	export PrepUSPIS_HotList							:= Dataset(pname.PrepUSPIS_HotList		,Layouts.Temporary.PrepUSPISHotList	,flat);

	export fCorpV2UniqueNameCityState			:= Dataset(pname.fCorpV2UniqueNameCityState,Layouts.Temporary.fCorpV2UniqueNameCityState	,flat);
end;