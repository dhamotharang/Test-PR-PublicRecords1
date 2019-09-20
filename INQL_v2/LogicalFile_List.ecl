EXPORT LogicalFile_List(boolean pFCRA = false, string version) := module
	
	shared fcra 	:= if(pFCRA, '::fcra::', '::nonfcra::');
  shared prefix     := if(pFCRA, INQL_v2._Constants.FCRA_PREFIX,INQL_v2._Constants.NONFCRA_PREFIX);
	
	export accurint 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::accurint';
	export custom 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::custom';
	export batch 					:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::batch';
	export batchr3 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::batchr3';
	export banko 					:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::banko';
	export bridger 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::bridger';
	export riskwise 			:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::riskwise';	
	export idm		 				:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::idm';
	export sba 						:= prefix + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::sba';
	export deconfliction	:= prefix + '::in::' + INQL_v2._Constants.DatasetName + fcra + version + '::mbs::deconfliction';
	export transaction 		:= prefix + '::in::' + INQL_v2._Constants.DatasetName + fcra + version + '::mbs::transaction';									
	
	
end;