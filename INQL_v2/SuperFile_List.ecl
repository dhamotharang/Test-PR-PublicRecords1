EXPORT Superfile_List(boolean pFCRA = false) := module

	shared fcra := if(pFCRA, '::fcra', '::nonfcra');

	export bridger 					:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::bridger';
	export bridger_bldg			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::bridger_bldg';
	export bridger_hist			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::bridger_hist';
	
	export riskwise 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise';	
	export riskwise_bldg 		:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise_bldg';	
	export riskwise_sl 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise_sl';
	export riskwise_sl_bldg := INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise_sl_bldg';
	export riskwise_hist    := INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::riskwise_hist';

	export banko 						:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::banko';	
	export banko_bldg 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::banko_bldg';	
	export banko_hist 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::banko_hist';	

	export batch 						:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batch';
	export batch_bldg 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batch_bldg';
	export batch_hist 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batch_hist';
	
	export batchr3					:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batchr3';
	export batchr3_bldg			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batchr3_bldg';
	export batchr3_hist			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::batchr3_hist';
	
	export custom 					:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom';
	export custom_bldg 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom_bldg';
	export custom_sl 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom_sl';
	export custom_sl_bldg 	:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom_sl_bldg';
	export custom_hist     	:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::custom_hist';
	
	export idm		 					:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::idm';
	export idm_bldg			 		:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::idm_bldg';
	export idm_hist			 		:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::idm_hist';
	
	export sba 							:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::sba';
	export sba_bldg 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::sba_bldg';
	export sba_hist 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::sba_hist';
	
	export accurint 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint';
	export accurint_bldg 		:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_bldg';
	export accurint_cc 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_cc';
	export accurint_cc_bldg := INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_cc_bldg';
	export accurint_sl 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_sl';	
	export accurint_sl_bldg := INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_sl_bldg';	
	export accurint_fdn			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_fdn';
	export accurint_fdn_bldg:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_fdn_bldg';
	export accurint_hist    := INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + '::accurint_hist';
	
end;