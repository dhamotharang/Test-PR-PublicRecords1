EXPORT Superfile_List(boolean pFCRA = false) := module

	shared fcra 			:= if(pFCRA, '::fcra', '::nonfcra');
  shared prefix     := if(pFCRA, INQL_v2._Constants.FCRA_PREFIX,INQL_v2._Constants.NONFCRA_PREFIX);
	
	export bridger 					:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::bridger';
	export bridger_bldg			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::bridger_bldg';
	export bridger_hist			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::bridger_hist';
	
	export riskwise 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise';	
	export riskwise_bldg 		:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise_bldg';	
	export riskwise_sl 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise_sl';
	export riskwise_sl_bldg := prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise_sl_bldg';
	export riskwise_hist    := prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise_hist';

	export banko 						:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::banko';	
	export banko_bldg 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::banko_bldg';	
	export banko_hist 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::banko_hist';	

	export batch 						:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batch';
	export batch_bldg 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batch_bldg';
	export batch_hist 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batch_hist';
	
	export batchr3					:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batchr3';
	export batchr3_bldg			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batchr3_bldg';
	export batchr3_hist			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batchr3_hist';
	
	export custom 					:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom';
	export custom_bldg 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom_bldg';
	export custom_sl 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom_sl';
	export custom_sl_bldg 	:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom_sl_bldg';
	export custom_hist     	:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom_hist';
	
	export idm		 					:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::idm';
	export idm_bldg			 		:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::idm_bldg';
	export idm_hist			 		:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::idm_hist';
	
	export sba 							:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::sba';
	export sba_bldg 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::sba_bldg';
	export sba_hist 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::sba_hist';
	
	export accurint 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint';
	export accurint_bldg 		:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_bldg';
	export accurint_cc 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_cc';
	export accurint_cc_bldg := prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_cc_bldg';
	export accurint_sl 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_sl';	
	export accurint_sl_bldg := prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_sl_bldg';	
	export accurint_fdn			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_fdn';
	export accurint_fdn_bldg:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_fdn_bldg';
	export accurint_hist    := prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_hist';

	
end;